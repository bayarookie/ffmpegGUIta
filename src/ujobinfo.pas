unit ujobinfo;

{$mode objfpc}{$H+}

interface

uses
  SysUtils;

type

  { TCont }

  TCont = class(TObject)
  public
    sk: array of string;
    sv: array of string;
    function addval(key, Value: string): integer;
    function getval(key: string): string;
    procedure setval(key, Value: string);
  end;

  { TFil }

  TFil = class(TCont)
  public
    s: array of TCont; //streams
    function AddStream: integer;
  end;

  { TJob }

  TJob = class(TCont)
  public
    f: array of TFil; //files
    m: array of string; //mapping of streams
    function AddFile(fn: string): integer;
    function AddMap(index: string): integer;
  end;

implementation

uses
  ufrmGUIta, ubyutils;

{ TCont }

function TCont.addval(key, Value: string): integer;
begin
  Result := Length(sk);
  SetLength(sk, Result + 1);
  SetLength(sv, Result + 1);
  sk[Result] := key;
  sv[Result] := Value;
end;

function TCont.getval(key: string): string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to High(sk) do
  if LowerCase(key) = LowerCase(sk[i]) then
  begin
    Result := sv[i];
    Exit;
  end;
end;

procedure TCont.setval(key, Value: string);
var
  i: integer;
begin
  for i := 0 to High(sk) do
  if LowerCase(key) = LowerCase(sk[i]) then
  begin
    sv[i] := Value;
    Exit;
  end;
  addval(key, Value);
end;

{ TFil }

function TFil.AddStream: integer;
begin
  Result := Length(s);
  SetLength(s, Result + 1);
  s[Result] := TCont.Create;
end;

{ TJob }

function TJob.AddFile(fn: string): integer;
begin
  Result := Length(f);
  SetLength(f, Result + 1);
  f[Result] := TFil.Create;
  f[Result].addval(sMyFilename, fn);
  {$IFDEF MSWINDOWS}
  f[Result].addval(sMyDOSfname, myGetAnsiFN(fn));
  {$ENDIF}
  f[Result].setval(sMyffprobe, '0');
end;

function TJob.AddMap(index: string): integer;
begin
  Result := Length(m);
  SetLength(m, Result + 1);
  m[Result] := index;
end;

end.

