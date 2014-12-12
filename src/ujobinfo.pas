unit ujobinfo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TCont }

  TCont = class(TObject)
  private
  public
    sk: TStringList;
    sv: TStringList;
    constructor Create; overload;
    function getval(key: string): string;
    procedure setval(key, Value: string);
  end;

  { TJob }

  TJob = class(TCont)
  private
  public
    a: array of TCont;
    files: TStringList;
    filecnt: integer;
    constructor Create; overload;
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

{ TJob }

constructor TJob.Create;
begin
  inherited;
  files := TStringList.Create;
end;

end.
