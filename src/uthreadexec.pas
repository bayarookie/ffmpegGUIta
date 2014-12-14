unit uthreadexec;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, utf8process, Process, LConvEncoding, fileutil,
  Math, dateutils, synmemo;

type

  { TThreadExec }

  TThreadExec = class(TThread)
  private
    fcmd: string;
    fOEM: boolean;
    fmem: TSynMemo;
    fStatus: string;
    procedure ShowJournal;
    procedure ShowStatus1;
    procedure ShowSynMemo;
  protected
    procedure Execute; override;
  public
    pr: TProcessUTF8;
    constructor Create(cmd: string; oem: boolean; mem: TSynMemo);
  end;

implementation

uses ufrmGUIta;

{ TExeThread }

procedure TThreadExec.ShowJournal;
begin
  if frmGUIta.chkDebug.Checked then
    frmGUIta.SynMemo1.Lines.Add(fStatus);
end;

procedure TThreadExec.ShowStatus1;
begin
  frmGUIta.StatusBar1.SimpleText := fStatus;
end;

procedure TThreadExec.ShowSynMemo;
begin
  if (fStatus <> '') then
    fmem.Lines.Add(fStatus);
end;

procedure TThreadExec.Execute;
var
  Buffer, s, t, scp: string;
  BytesAvailable: DWord;
  BytesRead: longint;
  i, j: integer;
begin
  scp := GetConsoleTextEncoding;
  if fcmd = '' then
    Exit;
  fStatus := fcmd;
  Synchronize(@ShowJournal);
  Synchronize(@ShowSynMemo);
  pr := TProcessUTF8.Create(nil);
  try
    pr.CommandLine := fcmd;
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
      Sleep(2);
    end;
    if (t <> '') then
      fStatus := t;
    if (fStatus <> '') then
      Synchronize(@ShowSynMemo);
  finally
    pr.Free;
  end;
end;

constructor TThreadExec.Create(cmd: string; oem: boolean; mem: TSynMemo);
begin
  FreeOnTerminate := True;
  fcmd := cmd;
  fOEM := oem;
  fmem := mem;
  inherited Create(True);
end;

end.
