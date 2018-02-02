unit uthreadconv;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, utf8process, Process, synmemo, Math, ComCtrls,
  {$IFDEF MSWINDOWS}
  Fileutil, LazFileutils,
  {$ENDIF}
  ubyutils, ujobinfo, urun;

type

  { TThreadCnv2 }

  TThreadCnv2 = class(TThread)
  private
    dt: TDateTime;
    jo: TJob;
    fterm_use: boolean;
    fStopIfError: boolean;
    run: TRun;
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
    NumOfThread: integer;
    NumOfJob: string;
    li: TListItem;
    constructor Create(threadnum: integer; mem: TSynMemo);
  end;

implementation

uses ufrmGUIta;

{ TThreadCnv2 }

procedure TThreadCnv2.DataGet;
var
  i: integer;
begin
  dt := Now;
  //fmemo := aMems[NumOfThread];
  fterm_use := frmGUIta.chkxtermconv.Checked;
  fStopIfError := frmGUIta.chkStopIfError.Checked;
  SetLength(run.p, 0);
  DuraJob := '';
  for i := 0 to frmGUIta.LVjobs.Items.Count - 1 do
  begin
    li := frmGUIta.LVjobs.Items[i];
    if li.Checked then
    begin
      li.Checked := False;
      fmemo.Clear;
      jo := TJob(li.Data);
      frmGUIta.myGetRunFromJo(jo, run, 0);
      jo.setval(sMyCompleted, '2');
      li.SubItems[0] := mes[35]; //in progress
      frmGUIta.LVjobs.Refresh;
      DuraJob := li.Caption;
      NumOfJob := DuraJob;
      //frmGUIta.myShowCaption('');
      frmGUIta.LVjobsItemChecked(nil, nil);
      Break;
    end;
  end;
end;

procedure TThreadCnv2.DataOut;
var
  s, fno: string;
  {$IFDEF MSWINDOWS}
  i: integer;
  fnoa: string;
  {$ENDIF}
begin
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
  if fExitStatus = 0 then
  begin
    jo.setval(sMyCompleted, '1');
    li.SubItems[0] := mes[34]  //completed
  end
  else
  begin
    jo.setval(sMyCompleted, '3');
    li.SubItems[0] := mes[36]; //error
  end;
  if li.Selected then
    frmGUIta.LVjobsSelectItem(nil, li, True);

  s := IntToStr(NumOfThread + 1) + '-' + NumOfJob + ': ' + myDTtoStr(sMyDTformat, Now)
    + ' ' + mes[5] + ' ' + TimeToStr(Now - dt);
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

procedure TThreadCnv2.ShowJournal;
begin
  frmGUIta.memJournal.Lines.Add(IntToStr(NumOfThread + 1) + '-' + NumOfJob + ': ' + fStatus);
end;

procedure TThreadCnv2.ShowStatus1;
begin
  frmGUIta.StatusBar1.SimpleText := IntToStr(NumOfThread + 1) + '-' + NumOfJob + ': ' + fStatus;
end;

procedure TThreadCnv2.ShowSynMemo;
begin
  fmemo.Lines.Add(fStatus);
end;

procedure TThreadCnv2.Execute;
var
  Buffer, s, t: string;
  BytesAvailable: DWord;
  BytesRead: longint;
  i, j, l: integer;
begin
  //scp := GetConsoleTextEncoding;
  while not Terminated and (fExitStatus = 0) do
  begin
    Synchronize(@DataGet);
    if Length(run.p) = 0 then
      Exit;
    for l := 0 to High(run.p) do
    begin
      fExitStatus := -1;
      pr := run.p[l];
      try
        fStatus := myDTtoStr(sMyDTformat, Now) + ' ' + pr.Executable + ' ' + frmGUIta.myGetStr(pr.Parameters);
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
                  fStatus := TimeToStr(Now - dt) + ' ' + Copy(t, 1, i - 1);
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

constructor TThreadCnv2.Create(threadnum: integer; mem: TSynMemo);
begin
  FreeOnTerminate := True;
  run := TRun.Create;
  NumOfThread := threadnum;
  fmemo := mem;
  fExitStatus := 0;
  inherited Create(True);
end;

end.

