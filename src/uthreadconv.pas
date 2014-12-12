unit uthreadconv;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, utf8process, Process, LConvEncoding, fileutil,
  ujobinfo, ubyutils;

type

  { TThreadConv }

  TThreadConv = class(TThread)
  private
    dt: TDateTime;
    jo: TJob;
    fOEM: boolean;
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
    constructor Create(CreateSuspended: boolean; dir: string);
  end;

implementation

uses ufrmGUIta;

{ TThreadConv }

procedure TThreadConv.DataGet;
var
  i: integer;
begin
  dt := Now;
  fcmd.Clear;
  for i := 0 to frmGUIta.LVfiles.Items.Count - 1 do
  begin
    if frmGUIta.LVfiles.Items[i].Checked then
    begin
      frmGUIta.SynMemo3.Clear;
      jo := TJob(frmGUIta.LVfiles.Items[i].Data);
      frmGUIta.SynMemo1.Lines.Add(DateTimeToStr(dt) + ' - ' + jo.files[0]);
      fcmd.Text := frmGUIta.myGetCmdFromJo(jo);
      jo.setval('Completed', '2');
      frmGUIta.LVfiles.Refresh;
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
  for i := 0 to frmGUIta.LVfiles.Items.Count - 1 do
  begin
    s := TJob(frmGUIta.LVfiles.Items[i].Data).getval('index');
    t := jo.getval('index');
    if s = t then
    begin
      frmGUIta.LVfiles.Items[i].Checked := False;
      if frmGUIta.LVfiles.Items[i].Selected then
        frmGUIta.LVfilesSelectItem(nil, frmGUIta.LVfiles.Items[i], True);
      Break;
    end;
  end;
  s := DateTimeToStr(Now) + ' ' + mes[5] + ' ' + TimeToStr(Now - dt);
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
  frmGUIta.SynMemo1.Lines.Add(s);
  frmGUIta.StatusBar1.SimpleText := s;
  frmGUIta.SynMemo1.Lines.Add(sdiv);
  frmGUIta.SynMemo3.Lines.Add(sdiv);
  frmGUIta.LVfiles.Refresh;
end;

procedure TThreadConv.ShowJournal;
begin
  frmGUIta.SynMemo1.Lines.Add(fStatus);
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
  scmd, Buffer, s, s1, s2, scp: string;
  BytesAvailable: DWord;
  BytesRead: longint;
  i: integer;
begin
  scp := GetConsoleTextEncoding;
  while (not Terminated) and True do
  begin
    Synchronize(@DataGet);
    if fcmd.Count = 0 then
      Exit;
    while (not Terminated) and (fcmd.Count > 0) and (fExitStatus = 0) do
    begin
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
      pr.CommandLine := scmd;
      //pr.CurrentDirectory := fdir;
      pr.Options := [poUsePipes, poStderrToOutPut];
      pr.ShowWindow := swoHide;
      pr.Execute;
      s1 := '';

      while (not Terminated) and (pr.Running) do
      begin
        BytesAvailable := pr.Output.NumBytesAvailable;
        BytesRead := 0;
        while BytesAvailable > 0 do
        begin
          SetLength(Buffer, BytesAvailable);
          BytesRead := pr.OutPut.Read(Buffer[1], BytesAvailable);
          s := copy(Buffer, 1, BytesRead);
          if fOEM then
            s := ConvertEncoding(s, scp, EncodingUTF8);
          s2 := s1 + s;
          repeat
            {$IFDEF MSWINDOWS}
            i := Pos(#13, s2);
            if (i > 0) and (i < Length(s2)) then
            begin
              fStatus := Copy(s2, 1, i - 1);
              Delete(s2, 1, i);
              Synchronize(@Showstatus1);
              if (s2[1] = #10) then
              begin
                Delete(s2, 1, 1);
                Synchronize(@ShowSynMemo);
              end;
            end
            else
              i := 0;
            {$ELSE}
            i := Pos(#10, s2);
            if (i > 0) then
            begin
              fStatus := Copy(s2, 1, i - 1);
              Delete(s2, 1, i);
              Synchronize(@ShowStatus1);
              Synchronize(@ShowSynMemo);
            end
            else
            begin
              fStatus := s2;
              s2 := '';
              Synchronize(@ShowStatus1);
              i := 0;
            end;
            {$ENDIF}
          until i = 0;
          s1 := s2;
          BytesAvailable := pr.Output.NumBytesAvailable;
        end;
        Sleep(2);
      end;
      if (s1 <> '') then
      begin
        fStatus := s1;
        Synchronize(@ShowSynMemo);
      end;
      fExitStatus := pr.ExitStatus;
      pr.Free;
    end;
    Synchronize(@DataOut);
  end;
end;

constructor TThreadConv.Create(CreateSuspended: boolean; dir: string);
begin
  FreeOnTerminate := True;
  fcmd := TStringList.Create;
  fdir := dir;
  fExitStatus := 0;
  fOEM := False;
  inherited Create(CreateSuspended);
end;

end.
