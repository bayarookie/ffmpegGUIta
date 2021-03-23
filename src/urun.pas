unit urun;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Process, UTF8Process;

type

  { TRun }

  TRun = class(TObject)
  public
    p: array of TProcessUTF8;
    function add(s: string): integer;
    function add(s: string; a: array of string): integer;
    function add(sl: TStrings): integer;
    function add(s: string; sl: TStrings): integer;
  end;

function myGetRunOut(s: string; out o: string): integer;
function myGetRunOut(exe: string; a: array of string; out o: string): integer;
//function myGetRunOut(sl: TStrings; out o: string): integer;
function myGetRunOut(exe: string; sl: TStrings; out o: string): integer;
function myGetRunOut(run: TRun; out o: string): integer;
function myGetRunOut(exe: string; a: array of string; maxerrorlevel: integer; out o: string): integer;

implementation

uses ufrmGUIta, ubyUtils;

{ TRun }

function TRun.add(s: string): integer;
begin
  Result := Length(p);
  SetLength(p, Result + 1);
  p[Result] := TProcessUTF8.Create(nil);
  p[Result].ParseCmdLine(s);
end;

function TRun.add(s: string; a: array of string): integer;
begin
  Result := Length(p);
  SetLength(p, Result + 1);
  p[Result] := TProcessUTF8.Create(nil);
  p[Result].Executable := s;
  p[Result].Parameters.AddStrings(a);
end;

function TRun.add(sl: TStrings): integer;
begin
  Result := Length(p);
  SetLength(p, Result + 1);
  p[Result] := TProcessUTF8.Create(nil);
  if sl.Count > 0 then
  begin
    p[Result].Executable := sl[0];
    sl.Delete(0);
    p[Result].Parameters.AddStrings(sl);
  end;
end;

function TRun.add(s: string; sl: TStrings): integer;
begin
  Result := Length(p);
  SetLength(p, Result + 1);
  p[Result] := TProcessUTF8.Create(nil);
  p[Result].Executable := s;
  p[Result].Parameters.AddStrings(sl);
end;

//from process
function myInternalRunCommand(p: TProcessUTF8; out outputstring: string;
                            out stderrstring: string; out exitstatus: integer): integer;
Const
  READ_BYTES = 65536; // not too small to avoid fragmentation when reading large files.
var
  numbytes, bytesread, available: integer;
  outputlength, stderrlength: integer;
  stderrnumbytes, stderrbytesread: integer;
begin
  result := -1;
  try
    try
      p.Options := p.Options + [poUsePipes];
      bytesread := 0;
      outputlength := 0;
      stderrbytesread := 0;
      stderrlength := 0;
      p.Execute;
      while p.Running do
      begin
        // Only call ReadFromStream if Data from corresponding stream
        // is already available, otherwise, on  linux, the read call
        // is blocking, and thus it is not possible to be sure to handle
        // big data amounts bboth on output and stderr pipes. PM.
        available := P.Output.NumBytesAvailable;
        if available > 0 then
        begin
          if (BytesRead + available > outputlength) then
          begin
            outputlength := BytesRead + READ_BYTES;
            Setlength(outputstring,outputlength);
          end;
          NumBytes := p.Output.Read(outputstring[1 + bytesread], available);
          if NumBytes > 0 then
            Inc(BytesRead, NumBytes);
        end
        // The check for assigned(P.stderr) is mainly here so that
        // if we use poStderrToOutput in p.Options, we do not access invalid memory.
        else if assigned(P.stderr) and (P.StdErr.NumBytesAvailable > 0) then
        begin
          available := P.StdErr.NumBytesAvailable;
          if (StderrBytesRead + available > stderrlength) then
          begin
            stderrlength := StderrBytesRead + READ_BYTES;
            Setlength(stderrstring, stderrlength);
          end;
          StderrNumBytes := p.StdErr.Read(stderrstring[1 + StderrBytesRead], available);
          if StderrNumBytes > 0 then
            Inc(StderrBytesRead, StderrNumBytes);
        end
        else
          Sleep(100);
      end;
      // Get left output after end of execution
      available := P.Output.NumBytesAvailable;
      while available > 0 do
      begin
        if (BytesRead + available > outputlength) then
        begin
          outputlength := BytesRead + READ_BYTES;
          Setlength(outputstring, outputlength);
        end;
        NumBytes := p.Output.Read(outputstring[1 + bytesread], available);
        if NumBytes > 0 then
          Inc(BytesRead, NumBytes);
        available := P.Output.NumBytesAvailable;
      end;
      setlength(outputstring, BytesRead);
      while assigned(P.stderr) and (P.Stderr.NumBytesAvailable > 0) do
      begin
        available := P.Stderr.NumBytesAvailable;
        if (StderrBytesRead + available > stderrlength) then
        begin
          stderrlength := StderrBytesRead + READ_BYTES;
          Setlength(stderrstring, stderrlength);
        end;
        StderrNumBytes := p.StdErr.Read(stderrstring[1 + StderrBytesRead], available);
        if StderrNumBytes > 0 then
          Inc(StderrBytesRead, StderrNumBytes);
      end;
      setlength(stderrstring, StderrBytesRead);
      exitstatus := p.exitstatus;
      result := 0; // we came to here, document that.
    except
      on e: Exception do
      begin
        result := 1;
        setlength(outputstring, BytesRead);
      end;
    end;
  finally
    p.free;
  end;
end;

function myGetRunOut(s: string; out o: string): integer;
var
  run: TRun;
begin
  run := TRun.Create;
  run.add(s);
  Result := myGetRunOut(run, o);
  run.Free;
end;

function myGetRunOut(exe: string; a: array of string; out o: string): integer;
var
  run: TRun;
begin
  run := TRun.Create;
  run.add(exe, a);
  Result := myGetRunOut(run, o);
  run.Free;
end;

function myGetRunOut(sl: TStrings; out o: string): integer;
var
  run: TRun;
begin
  run := TRun.Create;
  run.add(sl);
  Result := myGetRunOut(run, o);
  run.Free;
end;

function myGetRunOut(exe: string; sl: TStrings; out o: string): integer;
var
  run: TRun;
begin
  run := TRun.Create;
  run.add(exe, sl);
  Result := myGetRunOut(run, o);
  run.Free;
end;

function myGetRunOut(run: TRun; out o: string): integer;
var
  s, t, u: string;
  l, ExitStatus: integer;
  p: TProcessUTF8;
begin
  o := '';
  for l := 0 to High(run.p) do
  begin
    p := run.p[l];
    p.Options := [poNoConsole, poStderrToOutPut]; //if cropdetect then stderr
    t := myQuotedStr(p.Executable) + myList2Str(p.Parameters);
    Result := myInternalRunCommand(p, s, u, ExitStatus);
    o += s;
    //if ExitStatus <> 0 then
    if u <> '' then
    begin
      o += u;
      Result := ExitStatus;
    end;
    if u <> '' then s := u + ' - ' + t else s := t;
    frmGUIta.myError(Result, 'myGetRunOut: ' + s);
    if Result <> 0 then Break;
  end;
end;

function myGetRunOut(exe: string; a: array of string; maxerrorlevel: integer; out o: string): integer;
var
  s, t, u: string;
  l, ExitStatus: integer;
  p: TProcessUTF8;
begin
  o := '';
  p := TProcessUTF8.Create(nil);
  p.Executable := exe;
  p.Parameters.AddStrings(a);
  p.Options := [poNoConsole, poStderrToOutPut];
  t := myQuotedStr(p.Executable) + myList2Str(p.Parameters);
  myInternalRunCommand(p, s, u, ExitStatus);
  o += s;
  o += u;
  Result := ExitStatus;
  if u <> '' then s := u + ' - ' + t else s := t;
  if Result > maxerrorlevel then l := Result else l := 0;
  frmGUIta.myError(l, IntToStr(Result) + ' myGetRunOut: ' + s);
end;

end.

