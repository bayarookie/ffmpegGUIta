unit uthreadtest;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, utf8process, Process, LConvEncoding, fileutil, ComCtrls,
  Math, ujobinfo, ubyutils, dateutils;

type

  { TThreadTest }

  TThreadTest = class(TThread)
  private
    dt: TDateTime;
    li: TListItem;
    fOEM: boolean;
    fcmd: TStringList;
    fdir: string;
    fStatus: string;
    d, t: double;
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
    constructor Create(CreateSuspended: boolean; dir: string; Item: TListItem);
  end;

implementation

uses ufrmGUIta;

{ TThreadTest }

procedure TThreadTest.DataGet;
var
  jo: TJob;
  //s, s1, s2: string;
  //ss: double;
begin
  dt := Now;
  fcmd.Clear;
  frmGUIta.SynMemo5.Clear;
  jo := TJob(li.Data);
  //s1 := jo.getval(frmGUIta.cmbDurationss.Name);
  //s2 := jo.getval(frmGUIta.cmbDurationt.Name);
  //r := myTimeStrToReal(jo.getval('duration'));
  //if r = 0 then
  //  r := 1;
  //t := myTimeStrToReal(frmGUIta.cmbTestDurationt.Text);
  //if t > r then
  //  t := r;
  //s := IntToStr(Trunc(t));
  //jo.setval(frmGUIta.cmbDurationt.Name, s);
  //frmGUIta.SynMemo1.Lines.Add('test ' + s + ' sec');
  //if (s1 <> '') then
  //  s := s1
  //else
  //  s := frmGUIta.cmbTestDurationss.Text;
  //ss := myTimeStrToReal(s);
  //if r < (ss + t) then
  //  ss := r - t;
  //s := myRealToTimeStr(ss);
  //jo.setval(frmGUIta.cmbDurationss.Name, s);
  //frmGUIta.myGetss4Compare(jo);
  frmGUIta.SynMemo1.Lines.Add(DateTimeToStr(dt) + ' - ' + jo.files[0]);
  fcmd.Text := frmGUIta.myGetCmdFromJo(jo, True);
  //jo.setval(frmGUIta.cmbDurationss.Name, s1);
  //jo.setval(frmGUIta.cmbDurationt.Name, s2);
  jo.setval('Completed', '2');
  frmGUIta.LVfiles.Refresh;
end;

procedure TThreadTest.DataOut;
var
  i: integer;
  s, fno: string;
  {$IFDEF MSWINDOWS}
  fnoa: string;
  {$ENDIF}
  jo: TJob;
begin
  jo := TJob(li.Data);
  if fExitStatus = 0 then
    jo.setval('Completed', '0')
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
  s := DateTimeToStr(Now) + ' ' + mes[5] + ' ' + TimeToStr(Now - dt);
  i := SecondsBetween(dt, Now);
  d := myTimeStrToReal(jo.getval('duration'));
  t := myTimeStrToReal(frmGUIta.cmbTestDurationt.Text);
  if (d <> 0) and (t > d) then
    t := d;
  if t <> 0 then
    t := d / t * i;
  if fExitStatus <> 0 then
  begin
    s := s + ' - ' + mes[6] + ': ' + IntToStr(pr.ExitStatus);
    frmGUIta.SynMemo5.Lines.Add(s);
    fno := ChangeFileExt(fno, '_error.log');
    {$IFDEF MSWINDOWS}
    fnoa := ChangeFileExt(fnoa, '_error.log');
    frmGUIta.SynMemo5.Lines.SaveToFile(fnoa);
    RenameFileUTF8(fnoa, fno);
    {$ELSE}
    frmGUIta.SynMemo5.Lines.SaveToFile(fno);
    {$ENDIF}
  end;
  frmGUIta.SynMemo1.Lines.Add(s);
  frmGUIta.StatusBar1.SimpleText := s;
  frmGUIta.SynMemo1.Lines.Add(mes[19] + ' ' + myRealToTimeStr(t));
  frmGUIta.SynMemo1.Lines.Add(sdiv);
  frmGUIta.SynMemo5.Lines.Add(sdiv);
  if li.Selected then
    frmGUIta.LVfilesSelectItem(nil, li, True);
  if fExitStatus = 0 then
    frmGUIta.btnPlayOutClick(nil);
  frmGUIta.LVfiles.Refresh;
end;

procedure TThreadTest.ShowJournal;
begin
  frmGUIta.SynMemo1.Lines.Add(fStatus);
end;

procedure TThreadTest.ShowStatus1;
begin
  frmGUIta.StatusBar1.SimpleText := fStatus;
end;

procedure TThreadTest.ShowSynMemo;
begin
  frmGUIta.SynMemo5.Lines.Add(fStatus);
end;

procedure TThreadTest.Execute;
var
  scmd, Buffer, s, s1, s2, scp: string;
  BytesAvailable: DWord;
  BytesRead: longint;
  i: integer;
begin
  scp := GetConsoleTextEncoding;
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
    Synchronize(@Showstatus1);
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

constructor TThreadTest.Create(CreateSuspended: boolean; dir: string; Item: TListItem);
begin
  FreeOnTerminate := True;
  fcmd := TStringList.Create;
  fdir := dir;
  li := Item;
  fExitStatus := 0;
  fOEM := False;
  inherited Create(CreateSuspended);
end;

end.
