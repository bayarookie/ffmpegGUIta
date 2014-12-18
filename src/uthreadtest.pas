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
    fcmd: TStringList;
    fdir: string;
    fStatus: string;
    d, e: double;
    fExitStatus: integer;
    //fsep: boolean;
    procedure DataGet;
    procedure DataOut;
    procedure ShowJournal;
    procedure ShowStatus1;
    procedure ShowSynMemo;
  protected
    procedure Execute; override;
  public
    pr: TProcessUTF8;
    constructor Create(dir: string; Item: TListItem);
  end;

implementation

uses ufrmGUIta;

{ TThreadTest }

procedure TThreadTest.DataGet;
var
  jo: TJob;
begin
  dt := Now;
  fcmd.Clear;
  frmGUIta.SynMemo5.Clear;
  jo := TJob(li.Data);
  frmGUIta.memJournal.Lines.Add(DateTimeToStr(dt) + ' - ' + jo.files[0]);
  fcmd.Text := frmGUIta.myGetCmdFromJo(jo, True);
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
  e := myTimeStrToReal(frmGUIta.cmbTestDurationt.Text);
  if (d <> 0) and (e > d) then
    e := d;
  if e <> 0 then
    e := d / e * i;
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
  frmGUIta.memJournal.Lines.Add(s);
  frmGUIta.StatusBar1.SimpleText := s;
  frmGUIta.memJournal.Lines.Add(mes[19] + ' ' + myRealToTimeStr(e));
  frmGUIta.memJournal.Lines.Add(sdiv);
  frmGUIta.SynMemo5.Lines.Add(sdiv);
  if li.Selected then
    frmGUIta.LVfilesSelectItem(nil, li, True);
  if fExitStatus = 0 then
    frmGUIta.btnPlayOutClick(nil);
  frmGUIta.LVfiles.Refresh;
end;

procedure TThreadTest.ShowJournal;
begin
  frmGUIta.memJournal.Lines.Add(fStatus);
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
  scmd, Buffer, t: string;
  BytesAvailable: DWord;
  BytesRead: longint;
  i, j: integer;
begin
  Synchronize(@DataGet);
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
    Synchronize(@Showstatus1);
    Synchronize(@ShowSynMemo);
    pr := TProcessUTF8.Create(nil);
    try
      //pr.CurrentDirectory := fdir;
      pr.CommandLine := scmd;
      pr.Options := [poUsePipes, poStderrToOutPut];
      pr.ShowWindow := swoHide;
      pr.Execute;
      t := '';

      while (not Terminated) and (pr.Running) do
      begin
        BytesAvailable := pr.Output.NumBytesAvailable;
        BytesRead := 0;
        while BytesAvailable > 0 do
        begin
          SetLength(Buffer, BytesAvailable);
          BytesRead := pr.OutPut.Read(Buffer[1], BytesAvailable);
          t := t + copy(Buffer, 1, BytesRead);
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
        Sleep(2);
      end;
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

constructor TThreadTest.Create(dir: string; Item: TListItem);
begin
  FreeOnTerminate := True;
  fcmd := TStringList.Create;
  fdir := dir;
  li := Item;
  fExitStatus := 0;
  inherited Create(True);
end;

end.
