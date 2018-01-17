unit uthreadtest;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, utf8process, Process, ComCtrls,
  {$IFDEF MSWINDOWS}
  Fileutil, LazFileUtils,
  {$ENDIF}
  Math, ujobinfo, ubyutils, dateutils;

type

  { TThreadTest }

  TThreadTest = class(TThread)
  private
    dt: TDateTime;
    li: TListItem;
    fterm_use: boolean;
    fterminal: string;
    ftermopts: string;
    fterm1str: boolean;
    cmd: TJob;
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
    constructor Create(Item: TListItem);
  end;

implementation

uses ufrmGUIta;

{ TThreadTest }

procedure TThreadTest.DataGet;
var
  jo: TJob;
begin
  dt := Now;
  fterm_use := frmGUIta.chkxtermconv.Checked;
  fterminal := frmGUIta.edtxterm.Text;
  ftermopts := frmGUIta.edtxtermopts.Text;
  fterm1str := frmGUIta.chkxterm1str.Checked;
  frmGUIta.SynMemo5.Clear;
  jo := TJob(li.Data);
  cmd := TJob.Create;
  frmGUIta.myGetCmdFromJo(jo, cmd, 1);
  jo.setval('Completed', '2');
  frmGUIta.LVjobs.Refresh;
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
  s := myDTtoStr(sMyDTformat, Now) + ' ' + mes[5] + ' ' + TimeToStr(Now - dt);
  i := SecondsBetween(dt, Now);
  d := myTimeStrToReal(jo.f[0].getval('duration'));
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
    frmGUIta.LVjobsSelectItem(nil, li, True);
  if fExitStatus = 0 then
    frmGUIta.btnPlayOutClick(nil);
  frmGUIta.LVjobs.Refresh;
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
  Buffer, t: string;
  BytesAvailable: DWord;
  BytesRead: longint;
  i, j, l: integer;
begin
  Synchronize(@DataGet);
  for l := 0 to High(cmd.f) do
  begin
    fExitStatus := -1;
    pr := TProcessUTF8.Create(nil);
    try
      fStatus := frmGUIta.myCmdFillPr(cmd.f[l], fterm_use, pr);
      Synchronize(@ShowJournal);
      Synchronize(@Showstatus1);
      if fterm_use then
      begin
        pr.ShowWindow := swoShowNormal;
        pr.Execute;
        repeat
          Sleep(10);
        until Terminated or not pr.Running;
      end
      else
      begin
        Synchronize(@ShowSynMemo);
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
            t := t + copy(Buffer, 1, BytesRead);
            repeat
              i := Pos(#13, t);
              j := Pos(#10, t);
              if (i > 0) and (j <> i + 1) then //carrier return, no line feed
              begin
                if (j > i + 1) then j := i;
                fStatus := TimeToStr(Now - dt) + ' ' + Copy(t, 1, i - 1);
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
      end;
      fExitStatus := pr.ExitStatus;
    finally
      pr.Free;
    end;
    if fExitStatus <> 0 then Break;
  end;
  Synchronize(@DataOut);
end;

constructor TThreadTest.Create(Item: TListItem);
begin
  FreeOnTerminate := True;
  li := Item;
  fExitStatus := 0;
  inherited Create(True);
end;

end.

