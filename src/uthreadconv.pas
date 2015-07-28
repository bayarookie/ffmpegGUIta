unit uthreadconv;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, utf8process, Process, LConvEncoding,
  {$IFDEF MSWINDOWS}
  Fileutil, ubyutils,
  {$ENDIF}
  Math, ujobinfo;

type

  { TThreadConv }

  TThreadConv = class(TThread)
  private
    dt: TDateTime;
    jo: TJob;
    fOEM: boolean;
    fterm_use: boolean;
    fterminal: string;
    ftermopts: string;
    fterm1str: boolean;
    fcmd: TStringList;
    fdir: string;
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
    constructor Create(dir: string);
  end;

implementation

uses ufrmGUIta;

{ TThreadConv }

procedure TThreadConv.DataGet;
var
  i: integer;
  s: string;
begin
  dt := Now;
  fterm_use := frmGUIta.chkxtermconv.Checked;
  fterminal := frmGUIta.edtxterm.Text;
  ftermopts := frmGUIta.edtxtermopts.Text;
  fterm1str := frmGUIta.chkxterm1str.Checked;
  fcmd.Clear;
  for i := 0 to frmGUIta.LVjobs.Items.Count - 1 do
  begin
    if frmGUIta.LVjobs.Items[i].Checked then
    begin
      frmGUIta.SynMemo3.Clear;
      jo := TJob(frmGUIta.LVjobs.Items[i].Data);
      DateTimeToString(s, 'yyyy-mm-dd hh:nn:ss', Now);
      frmGUIta.memJournal.Lines.Add(s + ' - ' + jo.f[0].getval('filename'));
      fcmd.Text := frmGUIta.myGetCmdFromJo(jo);
      jo.setval('Completed', '2');
      frmGUIta.LVjobs.Refresh;
      Break;
    end;
  end;
end;

procedure TThreadConv.DataOut;
var
  i: integer;
  s, t, fno: string;
  {$IFDEF MSWINDOWS}
  fnoa: string;
  {$ENDIF}
begin
  if fExitStatus = 0 then
    jo.setval('Completed', '1')
  else
    jo.setval('Completed', '3');
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
    s := TJob(frmGUIta.LVjobs.Items[i].Data).getval('index');
    t := jo.getval('index');
    if s = t then
    begin
      frmGUIta.LVjobs.Items[i].Checked := False;
      if frmGUIta.LVjobs.Items[i].Selected then
        frmGUIta.LVjobsSelectItem(nil, frmGUIta.LVjobs.Items[i], True);
      Break;
    end;
  end;
  DateTimeToString(s, 'yyyy-mm-dd hh:nn:ss', Now);
  s := s + ' ' + mes[5] + ' ' + TimeToStr(Now - dt);
  //s := DateTimeToStr(Now) + ' ' + mes[5] + ' ' + TimeToStr(Now - dt);
  if fExitStatus <> 0 then
  begin
    s := s + ' - ' + mes[6] + ': ' + IntToStr(fExitStatus);
    frmGUIta.SynMemo3.Lines.Add(s);
    fno := ChangeFileExt(fno, '_error.log');
    {$IFDEF MSWINDOWS}
    fnoa := ChangeFileExt(fnoa, '_error.log');
    frmGUIta.SynMemo3.Lines.SaveToFile(fnoa);
    RenameFileUTF8(fnoa, fno);
    {$ELSE}
    frmGUIta.SynMemo3.Lines.SaveToFile(fno);
    {$ENDIF}
  end;
  frmGUIta.memJournal.Lines.Add(s);
  frmGUIta.StatusBar1.SimpleText := s;
  frmGUIta.memJournal.Lines.Add(sdiv);
  frmGUIta.SynMemo3.Lines.Add(sdiv);
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
  frmGUIta.SynMemo3.Lines.Add(fStatus);
end;

procedure TThreadConv.Execute;
var
  scmd, Buffer, s, t, scp: string;
  BytesAvailable: DWord;
  BytesRead: longint;
  i, j: integer;
  sl: TStringList;
begin
  scp := GetConsoleTextEncoding;
  while (not Terminated) and True do
  begin
    Synchronize(@DataGet);
    if fcmd.Count = 0 then
      Exit;
    while (not Terminated) and (fcmd.Count > 0) and (fExitStatus = 0) do
    begin
      fExitStatus := -1;
      scmd := fcmd[0];
      fcmd.Delete(0);
      if scmd = '' then
      begin
        fStatus := mes[6] + ': ' + mes[11];
        Synchronize(@ShowSynMemo);
        Break;
      end;
      fStatus := scmd;
      Synchronize(@ShowJournal);
      Synchronize(@ShowStatus1);
      Synchronize(@ShowSynMemo);
      pr := TProcessUTF8.Create(nil);
      try
        //pr.CurrentDirectory := fdir;
        if fterm_use then
        begin
          pr.Executable := fterminal;
          pr.Parameters.Add(ftermopts);
          if fterm1str then
            pr.Parameters.Add(scmd)
          else
          begin
            sl := TStringList.Create;
            process.CommandToList(scmd, sl);
            for i := 0 to sl.Count - 1 do
              pr.Parameters.Add(sl[i]);
            sl.Free;
          end;
        end
        else
          pr.CommandLine := scmd;
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
            if fOEM then
              s := ConvertEncoding(s, scp, EncodingUTF8);
            t := t + s;
            repeat
              i := Pos(#13, t);
              j := Pos(#10, t);
              if (i > 0) and (j <> i + 1) then //carrier return, no line feed
              begin
                if (j > i + 1) then j := i;
                fStatus := Copy(t, 1, i - 1);
                Delete(t, 1, Max(i, j));
                Synchronize(@ShowStatus1);
              end else
              if ((i > 0) and (j = i + 1))  //crlf
              or ((i = 0) and (j > 0))      //lf
              or ((i > j) and (j > 0)) then //lf, cr
              begin
                if (i = 0) or (i > j) then i := j;
                fStatus := Copy(t, 1, Min(i, j) - 1);
                Delete(t, 1, Max(i, j));
                Synchronize(@ShowStatus1);
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
    end;
    Synchronize(@DataOut);
  end;
end;

constructor TThreadConv.Create(dir: string);
begin
  FreeOnTerminate := True;
  fcmd := TStringList.Create;
  fdir := dir;
  fExitStatus := 0;
  fOEM := False;
  inherited Create(True);
end;

end.

