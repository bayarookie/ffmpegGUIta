unit uthreadexec;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, utf8process, process, LConvEncoding,
  Math, synmemo;

type

  { TThreadExec }

  TThreadExec = class(TThread)
  private
    fOEM: boolean;
    fmem: TSynMemo;
    fStatus: string;
    procedure ShowJournal;
    procedure ShowStatus1;
    procedure ShowSynMemo;
  protected
    procedure Execute; override;
  public
    p: TProcessUTF8;
    constructor Create(cmd: string; oem: boolean; mem: TSynMemo);
  end;

implementation

uses ufrmGUIta;

{ TThreadExec }

procedure TThreadExec.ShowJournal;
begin
  if frmGUIta.chkDebug.Checked then
    frmGUIta.memJournal.Lines.Add(fStatus);
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
  fStatus := p.Executable + ' ' + p.Parameters.Text;
  Synchronize(@ShowJournal);
  Synchronize(@ShowSynMemo);
  try
    p.Execute;
    t := '';
    repeat
      Sleep(2);
      BytesAvailable := p.Output.NumBytesAvailable;
      BytesRead := 0;
      while BytesAvailable > 0 do
      begin
        SetLength(Buffer, BytesAvailable);
        BytesRead := p.OutPut.Read(Buffer[1], BytesAvailable);
        s := copy(Buffer, 1, BytesRead);
        if fOEM then
          s := ConvertEncoding(s, scp, EncodingUTF8);
        t := t + s;
        repeat
          i := Pos(#13, t);
          j := Pos(#10, t);
          if (i > 0) and (j <> i + 1) then //cr, not crlf
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
        BytesAvailable := p.Output.NumBytesAvailable;
      end;
    until Terminated or not p.Running;
    if (t <> '') then
    begin
      fStatus := t;
      Synchronize(@ShowSynMemo);
    end;
  finally
    p.Free;
  end;
end;

constructor TThreadExec.Create(cmd: string; oem: boolean; mem: TSynMemo);
begin
  FreeOnTerminate := True;
  p := TProcessUTF8.Create(nil);
  if cmd <> '' then
    p.ParseCmdLine(cmd);
  p.Options := [poUsePipes, poStderrToOutPut];
  //p.ShowWindow := swoHide;
  fOEM := oem;
  fmem := mem;
  inherited Create(True);
end;

end.

