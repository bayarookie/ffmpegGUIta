unit uthreadconv;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, utf8process, Process, synmemo, Math,
  {$IFDEF MSWINDOWS}
  Fileutil,
  {$ENDIF}
  ubyutils, ujobinfo;

type

  { TThreadConv }

  TThreadConv = class(TThread)
  private
    dt: TDateTime;
    jo: TJob;
    fterm_use: boolean;
    fterminal: string;
    ftermopts: string;
    fterm1str: boolean;
    fStopIfError: boolean;
    cmd: TJob;
    fmemo: TSynMemo;
    fStatus: string;
    fExitStatus: integer;
    procedure DataGet;
    procedure DataOut;
    procedure ShowJournal;
    procedure ShowStatus1;
    procedure ShowSynMemo;
  protected
    procedure Execute; override;
  public
    pr: TProcessUTF8;
    num: integer;
    constructor Create(threadnum: integer);
  end;

implementation

uses ufrmGUIta;

{ TThreadConv }

procedure TThreadConv.DataGet;
var
  i: integer;
begin
  dt := Now;
  fmemo := aMems[num];
  fterm_use := frmGUIta.chkxtermconv.Checked;
  fterminal := frmGUIta.edtxterm.Text;
  ftermopts := frmGUIta.edtxtermopts.Text;
  fterm1str := frmGUIta.chkxterm1str.Checked;
  fStopIfError := frmGUIta.chkStopIfError.Checked;
  SetLength(cmd.f, 0);
  for i := 0 to frmGUIta.LVjobs.Items.Count - 1 do
  begin
    if frmGUIta.LVjobs.Items[i].Checked then
    begin
      frmGUIta.LVjobs.Items[i].Checked := False;
      fmemo.Clear;
      jo := TJob(frmGUIta.LVjobs.Items[i].Data);
      frmGUIta.myGetCmdFromJo(jo, cmd);
      jo.setval(sMyCompleted, '2');
      frmGUIta.LVjobs.Refresh;
      Break;
    end;
  end;
end;

procedure TThreadConv.DataOut;
var
  i: integer;
  s, fno: string;
  {$IFDEF MSWINDOWS}
  fnoa: string;
  {$ENDIF}
begin
  if fExitStatus = 0 then
    jo.setval(sMyCompleted, '1')
  else
    jo.setval(sMyCompleted, '3');
  fno := jo.getval(frmGUIta.edtOfn.Name);
  {$IFDEF MSWINDOWS}
  fnoa := jo.getval(frmGUIta.edtOfna.Name);
  i := 0;
  if (fExitStatus = 0) and (fnoa <> fno) then
  begin
    while not RenameFileUTF8(fnoa, fno) and (i < 100) do
    begin
      Inc(i);
      Sleep(100);
    end;
    fnoa := myGetAnsiFN(fno);
    jo.setval(frmGUIta.edtOfna.Name, fnoa);
  end;
  {$ENDIF}
  for i := 0 to frmGUIta.LVjobs.Items.Count - 1 do
  begin
    if frmGUIta.LVjobs.Items[i].Caption = jo.getval('index') then
    begin
      if frmGUIta.LVjobs.Items[i].Selected then
        frmGUIta.LVjobsSelectItem(nil, frmGUIta.LVjobs.Items[i], True);
      Break;
    end;
  end;
  s := IntToStr(num + 1) + ': ' + myDTtoStr(sMyDTformat, Now) + ' '
    + mes[5] + ' ' + TimeToStr(Now - dt);
  if fExitStatus <> 0 then
  begin
    s := s + ' - ' + mes[6] + ': ' + IntToStr(fExitStatus);
    fmemo.Lines.Add(s);
    fno := ChangeFileExt(fno, '_error.log');
    {$IFDEF MSWINDOWS}
    fnoa := ChangeFileExt(fnoa, '_error.log');
    fmemo.Lines.SaveToFile(fnoa);
    RenameFileUTF8(fnoa, fno);
    {$ELSE}
    fmemo.Lines.SaveToFile(fno);
    {$ENDIF}
  end;
  frmGUIta.memJournal.Lines.Add(s);
  frmGUIta.StatusBar1.SimpleText := s;
  if frmGUIta.spnCpuCount.Value = 1 then
    frmGUIta.memJournal.Lines.Add(sdiv);
  fmemo.Lines.Add(sdiv);
  frmGUIta.LVjobs.Refresh;
end;

procedure TThreadConv.ShowJournal;
begin
  frmGUIta.memJournal.Lines.Add(fStatus);
end;

procedure TThreadConv.ShowStatus1;
begin
  frmGUIta.StatusBar1.SimpleText := fStatus;
end;

procedure TThreadConv.ShowSynMemo;
begin
  fmemo.Lines.Add(fStatus);
end;

procedure TThreadConv.Execute;
var
  scmd, Buffer, s, t: string;
  BytesAvailable: DWord;
  BytesRead: longint;
  i, j, k, l: integer;
begin
  //scp := GetConsoleTextEncoding;
  while not Terminated and (fExitStatus = 0) do
  begin
    Synchronize(@DataGet);
    if Length(cmd.f) = 0 then
      Exit;
    for l := 0 to High(cmd.f) do
    begin
      fExitStatus := -1;
      scmd := cmd.f[l].getval(sMyFilename);
      t := '';
      for k := 0 to High(cmd.f[l].s) do
        t := t + frmGUIta.myGetStr(cmd.f[l].s[k].sv);
      fStatus := IntToStr(num + 1) + ': ' + myDTtoStr(sMyDTformat, Now) + ' - ' + scmd + ' ' + t;
      Synchronize(@ShowJournal);
      Synchronize(@ShowStatus1);
      Synchronize(@ShowSynMemo);
      pr := TProcessUTF8.Create(nil);
      try
        if fterm_use then
        begin
          pr.Executable := fterminal;
          pr.Parameters.Add(ftermopts);
          if fterm1str then
            pr.Parameters.Add(frmGUIta.myEscapeStr(scmd) + ' ' + t)
          else
          begin
            for k := 0 to High(cmd.f[l].s) do
            for i := 0 to High(cmd.f[l].s[k].sv) do
              pr.Parameters.Add(cmd.f[l].s[k].sv[i]);
          end;
        end
        else
        begin
          pr.Executable := scmd;
          for k := 0 to High(cmd.f[l].s) do
          for i := 0 to High(cmd.f[l].s[k].sv) do
            pr.Parameters.Add(cmd.f[l].s[k].sv[i]);
        end;
        pr.Options := [poUsePipes, poStderrToOutPut];
        pr.ShowWindow := swoHIDE;
        pr.Execute;
        t := '';

        repeat
          Sleep(2);
          BytesAvailable := pr.Output.NumBytesAvailable;
          BytesRead := 0;
          while BytesAvailable > 0 do
          begin
            SetLength(Buffer, BytesAvailable);
            BytesRead := pr.OutPut.Read(Buffer[1], BytesAvailable);
            s := copy(Buffer, 1, BytesRead);
            //if fOEM then
            //  s := ConvertEncoding(s, scp, EncodingUTF8);
            t := t + s;
            repeat
              i := Pos(#13, t);
              j := Pos(#10, t);
              if (i > 0) and (j <> i + 1) then //carrier return, no line feed
              begin
                if (j > i + 1) then
                  j := i;
                fStatus := IntToStr(num + 1) + ': ' + TimeToStr(Now - dt) + ' ' + Copy(t, 1, i - 1);
                Delete(t, 1, Max(i, j));
                Synchronize(@ShowStatus1);
              end
              else
              if ((i > 0) and (j = i + 1))  //crlf
                or ((i = 0) and (j > 0))      //lf
                or ((i > j) and (j > 0)) then //lf, cr
              begin
                if (i = 0) or (i > j) then
                  i := j;
                fStatus := Copy(t, 1, Min(i, j) - 1);
                Delete(t, 1, Max(i, j));
                //Synchronize(@ShowStatus1);
                Synchronize(@ShowSynMemo);
              end;
            until i = 0;
            BytesAvailable := pr.Output.NumBytesAvailable;
          end;
        until Terminated or not pr.Running;
        if (t <> '') then
        begin
          fStatus := t;
          Synchronize(@ShowSynMemo);
        end;
        fExitStatus := pr.ExitStatus;
      finally
        pr.Free;
      end;
      if fExitStatus <> 0 then Break;
    end;
    Synchronize(@DataOut);
    if not fStopIfError and (fExitStatus <> 0) then
      fExitStatus := 0;
  end;
end;

constructor TThreadConv.Create(threadnum: integer);
begin
  FreeOnTerminate := True;
  cmd := TJob.Create;
  num := threadnum;
  fExitStatus := 0;
  inherited Create(True);
end;

end.
