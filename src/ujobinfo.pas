unit ujobinfo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TCont }

  TCont = class(TObject)
  public
    sk: TStringList;
    sv: TStringList;
    constructor Create; overload;
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

constructor TCont.Create;
begin
  inherited;
  sk := TStringList.Create;
  sv := TStringList.Create;
end;

function TCont.getval(key: string): string;
var
  i: integer;
begin
  i := sk.IndexOf(key);
  if (i >= 0) and (i < sv.Count) then
    Result := sv[i]
  else
    Result := '';
end;

procedure TCont.setval(key, Value: string);
var
  i: integer;
begin
  i := sk.IndexOf(key);
  if (i >= 0) and (i < sv.Count) then
    sv[i] := Value
  else
  begin
    sk.Add(key);
    sv.Add(Value);
  end;
end;

end.
