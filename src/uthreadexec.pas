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
    fFirst: boolean;
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
  if fFirst then
  begin
    fmem.Lines.Add(fStatus);
    fFirst := False;
  end
  else
  begin
    fmem.Lines[fmem.Lines.Count - 1] := fStatus;
  end;
  frmGUIta.StatusBar1.SimpleText := fStatus;
end;

procedure TThreadExec.ShowSynMemo;
begin
  if (fStatus <> '') then
    fmem.Lines.Add(fStatus);
  //fFirst := True;
end;

procedure TThreadExec.Execute;
var
  Buffer, s, s1, s2, scp: string;
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
  pr.CommandLine := fcmd;
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
        i := Pos(#13, s2);
        j := Pos(#10, s2);
        if i = 0 then i:= j;
        if j = 0 then j:= i;
        if (i > 0) then
        begin
          fStatus := Copy(s2, 1, Min(i, j) - 1);
          Delete(s2, 1, Max(i, j));
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
  pr.Free;
end;

constructor TThreadExec.Create(cmd: string; oem: boolean; mem: TSynMemo);
begin
  FreeOnTerminate := True;
  fcmd := cmd;
  fOEM := oem;
  fmem := mem;
  fFirst := True;
  inherited Create(True);
end;

end.
