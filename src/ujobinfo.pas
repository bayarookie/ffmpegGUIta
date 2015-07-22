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
    function getval(key: string): string;
    procedure setval(key, Value: string);
  end;

  { TFil }

  TFil = class(TCont)
  public
    s: array of TCont; //streams
  end;

  { TJob }

  TJob = class(TCont)
  public
    f: array of TFil; //files
    m: array of string; //mapping of streams
  end;

implementation

{ TCont }

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
  i := Length(sk) + 1;
  SetLength(sk, i);
  SetLength(sv, i);
  sk[High(sk)] := key;
  sv[High(sv)] := Value;
end;

end.

