

(*   ********************************************************
     *                  Borland Delphi                      *
     *           TCalcul object, unit uCalcul.pas           *
     *                   version 2.3                        *
     *               Author:  Jan Tungli (c) 2002           *
     *               web:     www.tsoft.szm.com             *
     *               mailto:  jan.tungli@seznam.cz          *
     ********************************************************

      If you want modify this source code,
      plase send me your source segment
      to mail: jan.tungli@seznam.cz with subject "Calcul"

    _____________________________________________________________________
   | Variable types:                                                     |
   |=====================================================================|
   |   x,y         : numeric - (integer, float)                          |
   |   a,b         : boolean (1 or 0)                                    |
   |   s,t,v       : string                                              |
   |   d           : DateTimeString  (StampString)                       |
   |_____________________________________________________________________|

    _____________________________________________________________________
   | Basic operations:                                                   |
   |=====================================================================|
   |   numeric:          x + y , x - y , x * y, x / y, x ^ y             |
   |   compare:          x > y, x < y, x >= y, x <= y, x = y, x <> y     |
   |   ansi compare:     s > t, s < t, s >= t, s <= t, s = t, s <> t     |
   |   boolean (1/0):    a AND b,  a OR b,  NOT(a)                       |
   |   set variable :    x:=formula (or value) ;                         |
   |   destroy variable: FreeVar(s);    // s=variable name               |
   |   logical:          ExistVar(s)  // s=variable name                 |
   |   formula separation with semicolon :  formula1 ; formula2          |
   |_____________________________________________________________________|

    _____________________________________________________________________
   | Type conversion:                                                    |
   |=====================================================================|
   |   boolean (1/0):   Logic(x)                                         |
   |   numeric:         Numeric(s)                                       |
   |   string:          String(x)                                        |
   |   char:            Char(x)                                          |
   |   integer:         Ascii(s)                                         |
   |---------------------------------------------------------------------|
   |   all types:       Eval(f)  // where f is formula in [...]          |
   |   string :         NumBase(x,base) // base from <2..16>             |
   |   integer:         BaseNum(s,base) // base from <2..16>
   |_____________________________________________________________________|

    _____________________________________________________________________
   | Math operations:                                                    |
   |=====================================================================|
   |  numeric (integer): x Div y,  x Mod y                               |
   |_____________________________________________________________________|

    _____________________________________________________________________
   | Math functions:                                                     |
   |=====================================================================|
   |    Abs(x), Frac(x), Trunc(x), Heaviside(x) or H(x), Sign(x),        |
   |    Sqrt(x), Ln(x), Exp(x),                                          |
   |    Cos(x), CTg(x), Ch(x), CTh(x), Sin(x),  Sh(x), Tg(x), Th(x),     |
   |    ArcSin(x), ArcCos(x), ArcTg(x), ArcCtg(x),                       |
   |    MaxVal(x [,y, ...]),  MinVal(x [,y, ...]),                       |
   |    SumVal(x [,y,...]),   AvgVal(x [,y, ...])                        |
   |_____________________________________________________________________|

    _____________________________________________________________________
   | String operations:                                                  |
   |=====================================================================|
   |    s || t ,                                                         |
   |    s Like t,      // (%,_)                                          |*)
// |    s Wildcard t   // (*,?)                                          |
(* |_____________________________________________________________________|

    _____________________________________________________________________
   | String functions:                                                   |
   |=====================================================================|
   |   integer: Length(s), Pos(t,s)                                      |
   |   string:  Trim(s), TrimLeft(s), TrimRight(s), Upper(s), Lower(s),  |
   |            Copy(s,x,[y]), CopyTo(s,x,[y]), Delete(s,x,[y]),         |
   |            Insert(s,t,x);                                           |
   |            Replace(s,t,v,[1/0=ReplaceAll,[1/0=IgnoreCase]] );       |
   |            IFF(a,s,t);    //IF a>=1 then Result:=s else Result:=t   |
   |_____________________________________________________________________|

    _____________________________________________________________________
   | Date & Time functions:                                              |
   |=====================================================================|
   |   integer: Year(s), Month(s), Day(s), WeekDay(s),                   |
   |            Hour(s), Minute(s), Sec(s)                               |
   |   numeric: StrToStamp(d)  LastDay(x) // last day in Month (28-31)   |
   |   string:  StampToStr(x), StampToDateStr(x), StampToTimeStr(x)      |
   |_____________________________________________________________________|

       Delta days with  2002/1/1 - 1999/1/1 :
          DeltaDays:=StrToStamp("2002/1/1") - StrToStamp("1999/1/1")

   Example:
      procedure TForm1.CalcBtnClick(Sender: TObject);
      var s:string;
      begin
        Calcul1.Variables:='x=100'#13#10+
                           'y=200'#13#10+
                           's="hello"'#13#10;
        Calcul1.Formula := ComboBox1.text;
        s:=Calcul1.calc;
        if Calcul1.CalcError=false then
          ShowMessage(Calcul1.Formula+'='+s);
        else
          ShowMessage(Calcul1.CalcErrorText);
      end; {----}

  ************************************************************************)

(* History:

   10.8.2001
   ver.1.2 - implemented aritmetic functions with use variables

   1.5.2002
   ver.2.0 & 2.1 - implememnted string & dateTime functions & Eval() function

   6.5.2002
   ver.2.2 - implemented set variable ":=" and FreeVar(), ExistVar(), NumBase(), BaseNum() functions

   10.5.2002
   ver.2.3 - finally version Date & Time operations & LastDay(..) function

  If you want modify this source code,
  plase send me your source segment
  to mail: jan.tungli@seznam.cz with subject "Calcul"

*)

unit uCalcul;

interface

uses
  SysUtils, Classes, Graphics, Controls, Math, masks;

type
  TCalc_vek = array of Pointer;

  TCalc_Tree = record
    id, num: integer;
    con: string;
    l, r: pointer;
    typ: byte;
  end;
  PCalc_Tree = ^TCalc_Tree;


  TCalcul = class(TObject)
  private
    fErr: boolean;
    Bc: integer;
    PrevLex, Curlex: integer;
    fPos: integer;
    FFormula: string;
    Tree: pointer;
    fVek: Tcalc_vek;
    cVek, MaxVek: integer;
    FVariables: TStringList;
    fFParams: TStringList;
    FDefaultNames: boolean;
    fResultType: byte;
    fErrText: string;
    function gettree(s: string): pointer;
    function deltree(t: PCalc_Tree): pointer;
    procedure Error(s: string);
    procedure SetVariables(Value: string);
    function GetVariables: string;
    function m1(c: string): extended;   //StrToFloat
    function m0(s: string): integer;    //StrToInt
    function m2(x: extended): string;   //FloatToStr
    procedure Addvek(t: pointer);
    procedure Delvek(t: pointer);
    function IsString(s: string): boolean;
    function Separ(s: string): string;
  public
    constructor Create;
    destructor Destroy; override;
    function Calc: string;
    function Test(s: string; sys: boolean = False): integer;
  published
    property Formula: string read FFormula write fFormula;
    property Variables: string read GetVariables write SetVariables;
    property CalcError: boolean read fErr;
    property CalcErrorText: string read fErrText;
    property ResultType: byte read fResultType;   // 0=unknown; 1=numeric; 2=string
  end;

function MStrToFloat(c: string; var d: extended): boolean;   //StrToFloat
function MFloatToStr(x: extended): string;
function MDateToStr(Dt: TDateTime): string;
function MTimeToStr(Dt: TdateTime): string;
function MDateTimeToStr(Dt: TDateTime): string;
function MStrToDate(Dt: string): double;
function MStrToTime(Dt: string): double;
function MStrToDateTime(Dt: string): double;
function NumBase(AnyInteger, NumberBase: integer): string; //(2,8,10,16));
function BaseNum(s: string; NumberBase: integer): integer; //(2,8,10,16));

implementation

function MStrToFloat(c: string; var d: extended): boolean;   //StrToFloat
var
  err: integer;
  s: string;
begin
  s := Trim(c);
  s := StringReplace(s, ',', '.', [rfReplaceAll]);
  if (s <> '') and (s[1] = '"') then
    system.Delete(s, 1, 1);
  if (s <> '') and (s[length(s)] = '"') then
    system.Delete(s, length(s), 1);
  Val(s, d, err);
  Result := err = 0;
end;

function MFloatToStr(x: extended): string;
var
  s: string;
  i, j, k: word;
begin
  Str(x: 0: 12, s);
  i := Pos('.', s);
  k := 0;
  for j := Length(s) downto i + 2 do
    if s[j] = '0' then
      Inc(k)
    else
      break;
  if k > 0 then
    system.Delete(s, Length(s) - k + 1, k);
  if system.copy(s, length(s) - 1, 2) = '.0' then
    system.Delete(s, length(s) - 1, 2);
  Result := s;
end;

function MDateToStr(Dt: TDateTime): string;
var
  s: string[50];
  t: string[4];
  Y, M, D: word;
begin
  DecodeDate(Dt, Y, M, D);
  t := IntToStr(D);
  if length(t) < 2 then
    t := '0' + t;
  s := '/' + t;
  t := IntToStr(M);
  if length(t) < 2 then
    t := '0' + t;
  s := '/' + t + s;
  t := IntToStr(Y);
  while length(t) < 4 do
    t := '0' + t;
  s := t + s;
  Result := s;
end;

function MTimeToStr(Dt: TdateTime): string;
var
  s: string[50];
  t: string[4];
  H, M, S1, S2: word;
begin
  DecodeTime(Dt, H, M, S1, S2);
  t := IntToStr(S2);
  while length(t) < 3 do
    t := '0' + t;
  s := '.' + t;
  t := IntToStr(S1);
  if length(t) < 2 then
    t := '0' + t;
  s := ':' + t + s;
  t := IntToStr(M);
  if length(t) < 2 then
    t := '0' + t;
  s := ':' + t + s;
  t := IntToStr(H);
  if length(t) < 2 then
    t := '0' + t;
  s := t + s;
  Result := s;
end;

function MDateTimeToStr(Dt: TDateTime): string;
begin
  Result := MDateToStr(Dt) + ' ' + MTimeToStr(Dt);
end;

function MStrToDate(Dt: string): double;
var
  i, j, Y, M, D, err: integer;
begin
  Result := 0;
  Dt := trim(Dt);
  if (dt <> '') and (dt[1] = '"') then
    system.Delete(dt, 1, 1);
  if (dt <> '') and (dt[length(dt)] = '"') then
    system.Delete(dt, length(dt), 1);
  dt := StringReplace(dt, ' /', '/', [rfReplaceAll]);
  dt := StringReplace(dt, '/ ', '/', [rfReplaceAll]);
  Dt := trim(Dt);
  if (Dt = '') or (not (dt[1] in ['0'..'9'])) then
    exit;
  if Pos(' ', dt) > 1 then
    Dt := system.copy(Dt, 1, Pos(' ', dt) - 1);
  Y := 1;
  M := 1;
  D := 1;
  i := Pos('/', dt);
  if i > 1 then
  begin
    Val(system.copy(dt, 1, i - 1), Y, err);
    system.Delete(dt, 1, i);
    i := Pos('/', dt);
    if i > 1 then
    begin
      Val(trim(system.copy(dt, 1, i - 1)), j, err);
      if err = 0 then
        M := j;
      system.Delete(dt, 1, i);
    end;
    Val(trim(dt), D, err);
  end
  else
  begin
    Val(trim(dt), i, err);
    if err = 0 then
      Y := i;
  end;
  if M > 0 then
  begin
    if M mod 12 = 0 then
    begin
      Y := Y + (M div 13);
    end
    else
    begin
      Y := Y + (M div 12);
    end;
    M := (M mod 12);
    if M = 0 then
      M := 12;
  end
  else
  begin
    M := ABS(M);
    Y := Y - 1 - (M div 12);
    M := 12 - (M mod 12);
  end;
  if Y < 1 then
  begin
    Y := 1;
    M := 1;
    D := 1;
  end;
  Result := EncodeDate(Y, M, 1);
  Result := Result + d - 1;
  i := trunc(EncodeDate(1, 1, 1));
  if Result < i then
    Result := i;
end;

function LastDay(DD: TdateTime): byte;
const
  DaysPerMonth: array[1..12] of integer =
    (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
var
  Y, M, D: word;
begin
  Result := 0;
  DecodeDate(DD, Y, M, D);
  if not ((Y = 1) and (M = 1) and (D = 1)) then
  begin
    Result := DaysPerMonth[M];
    if (M = 2) and IsLeapYear(Y) then
      Result := Result + 1;
  end;
end;

function MStrToTime(Dt: string): double;
var
  i, D, H, M, S, SS, err: integer;
begin
  Dt := trim(Dt);
  Result := 0;
  if (dt <> '') and (dt[1] = '"') then
    system.Delete(dt, 1, 1);
  if (dt <> '') and (dt[length(dt)] = '"') then
    system.Delete(dt, length(dt), 1);
  Dt := trim(Dt);
  dt := StringReplace(dt, '  ', ' ', [rfReplaceAll]);
  dt := StringReplace(dt, ' /', '/', [rfReplaceAll]);
  dt := StringReplace(dt, '/ ', '/', [rfReplaceAll]);
  dt := StringReplace(dt, ' :', ':', [rfReplaceAll]);
  dt := StringReplace(dt, ': ', ':', [rfReplaceAll]);
  dt := StringReplace(dt, ' .', '.', [rfReplaceAll]);
  dt := StringReplace(dt, '. ', '.', [rfReplaceAll]);
  if (Pos(' ', dt) > 1) then
  begin
    Dt := system.copy(Dt, Pos(' ', dt) + 1, 255);
    Dt := trim(dt);
  end;
  if (Dt = '') or (not (dt[1] in ['-', '0'..'9'])) then
    exit;
  H := 0;
  M := 0;
  S := 0;
  ss := 0;
  i := Pos(':', dt);
  if i > 1 then
  begin
    Val(trim(system.copy(dt, 1, i - 1)), H, err);
    system.Delete(dt, 1, i);
    i := Pos(':', dt);
    if i > 1 then
    begin
      Val(trim(system.copy(dt, 1, i - 1)), M, err);
      system.Delete(dt, 1, i);
      i := Pos('.', dt);
      if i > 0 then
      begin
        Val(trim(system.copy(dt, 1, i - 1)), S, err); //sec
        system.Delete(dt, 1, i);
        Val(trim(dt), SS, err);   //MSec
      end
      else
      begin
        Val(trim(dt), i, err);
        if err = 0 then
          S := i
        else
          S := 0;
      end;
    end
    else
    begin
      val(trim(dt), i, err);
      if err = 0 then
        M := i
      else
        M := 0;
    end;
  end
  else
  begin
    Val(trim(dt), i, err);
    if err = 0 then
      H := i
    else
      H := 0;
  end;

  D := 0; //day
  if ss >= 0 then
  begin
    S := S + (ss div 1000);
    ss := ss mod 1000;
  end
  else
  begin
    ss := abs(ss);
    s := s - 1 - (ss div 1000);
    ss := 1000 - (ss mod 999);
  end;
  if S >= 0 then
  begin
    M := M + (s div 60);
    S := s mod 60;
  end
  else
  begin
    S := abs(S);
    M := M - 1 - (s div 60);
    s := 60 - (s mod 59);
  end;
  if M >= 0 then
  begin
    H := H + (M div 60);
    M := M mod 60;
  end
  else
  begin
    M := abs(M);
    H := H - 1 - (M div 60);
    M := 60 - (M mod 59);
  end;
  if H >= 0 then
  begin
    D := D + (H div 24);
    H := H mod 24;
  end
  else
  begin
    H := Abs(H);
    D := D - 1 - (H div 24);
    H := 24 - (H mod 23);
  end;
  Result := D + frac(EncodeTime(H, M, S, SS));
end;

function MStrToDateTime(Dt: string): double;
var
  D: double;
  H, M, S, ss: word;
begin
  dt := trim(dt);
  if Pos('/', dt) = 0 then
  begin
    if Pos(':', dt) > 0 then
    begin
      Result := MStrToTime(dt);
    end
    else
      Result := MStrToDate(dt);
  end
  else
  begin
    Result := MStrToDate(dt);
    if Pos(':', dt) > 0 then
    begin
      d := MStrToTime(dt);
      if Result < 0 then
      begin
        if d < 0 then
        begin
          DecodeTime(Abs(d), H, M, S, ss);
          H := 23 - H;
          M := 59 - M;
          S := 59 - S;
          Result := Result + Trunc(d) - 1 - Frac(EncodeTime(H, M, S, 999));
        end
        else
          Result := Result + Trunc(d) - Frac(d);
      end
      else
        Result := Result + D;
    end;
  end;
end;

function NumBase(AnyInteger, NumberBase: integer): string; //(2,8,10,16));
const
  DataSize = 32;  (* bit-size of an INTEGER *)
var
  Index: integer;
  Digit: array [1..DataSize] of char;
begin
  Result := '';
  if (NumberBase > 1) and (NumberBase < 17) then
  begin
    Index := 0;
    repeat
      Inc(Index);
      Digit[Index] := CHR(AnyInteger mod NumberBase + Ord('0'));
      if (Digit[Index] > '9') then
        Inc(Digit[Index], 7);
      AnyInteger := AnyInteger div NumberBase;
    until (AnyInteger = 0) or (Index = DataSize);
    while (Index > 0) do
    begin
      Result := Result + Digit[Index];
      Dec(Index);
    end;
  end;
end;

function BaseNum(s: string; NumberBase: integer): integer; //(2,8,10,16,32));
var
  i: integer;
  j: byte;
begin
  s := UpperCase(s);
  j := 0;
  if (NumberBase > 1) and (NumberBase < 17) then
  begin
    while (length(s) > 0) and (s[1] = '0') do
      system.Delete(s, 1, 1);
    Result := 0;
    if length(s) = 0 then
      exit;
    for i := length(s) downto 1 do
    begin
      if (s[i] in ['0'..'9']) then
        j := byte(s[i]) - byte('0')
      else
      if s[i] in ['A'..'F'] then
        j := byte(s[i]) - byte('A') + 10
      else
      begin
        Result := -1;
        exit;
      end;
      try
        Result := Result + j * trunc(power(NumberBase, length(s) - i) + 0.1);
      except
        Result := -1;
        break;
      end;
    end;
  end
  else
    Result := -1;
end;

(*------------------------------------------------------------------*)

//*********************************************************************

constructor TCalcul.Create;
begin
  inherited;
  Tree := nil;
  cVek := 0;
  MaxVek := 0;
  setlength(fvek, 0);
  Formula := '0';
  FDefaultNames := False;
  FVariables := TStringList.Create;
  Fvariables.Clear;
  FFParams := TStringList.Create;
  FFParams.Clear;
end;

destructor TCalcul.Destroy;
begin
  DelTree(Tree);
  FFParams.Free;
  FVariables.Free;
  inherited;
end;

//***************************************************************


function TCalcul.m1(c: string): extended;   //StrToFloat
var
  d: extended;
  err: integer;
  s: string;
begin
  s := Trim(c);
  s := StringReplace(s, ',', '.', [rfReplaceAll]);
  Val(s, d, err);
  if err > 0 then
  begin
    d := 0;
    Error('Error, convert to numeric value:' + c);
  end;
  Result := d;
end;

function TCalcul.m0(s: string): integer;   //StrToInt
var
  x: extended;
begin
  Result := 0;
  if fErr then
    exit;
  x := m1(s);
  if x > 0 then
    x := x + 0.0000001;
  if x < 0 then
    x := x - 0.0000001;
  Result := trunc(x);
end;

function TCalcul.m2(x: extended): string;   //FloatToStr
var
  s: string;
  i, j, k: word;
begin
  Str(x: 0: 12, s);
  i := Pos('.', s);
  k := 0;
  for j := Length(s) downto i + 2 do
    if s[j] = '0' then
      Inc(k)
    else
      break;
  if k > 0 then
    system.Delete(s, Length(s) - k + 1, k);
  if system.copy(s, length(s) - 1, 2) = '.0' then
    system.Delete(s, length(s) - 1, 2);
  Result := s;
end;

function TCalcul.calc: string;
//var
  //fMultyparam: boolean;

  function c(t: PCalc_TREE): string;
  var
    r: extended;
    d, dd: double;
    s, ms: string;
    TC: TCalcul;
    j, i, k: integer;
    Y1, D1, H1, MM1, S1: word;
    sp: array [1..5] of string;
    mRepFlag: TReplaceFlags;
  begin
    c := '';
    mRepFlag := [];
    if fErr then
      exit;
    try
      if t^.num in [3..6, 10..35, 44, 47..55, 62, 65..68, 72, 73, 197,
        198, 200, 201, 208..211, 220..225] then
        t^.typ := 1; //numeric
      if t^.num in [38, 39, 41, 43, 45, 46, 56..58, 60, 61, 64, 69,
        70, 71, 196, 202] then
        t^.typ := 2; //string
    except
      Error('Invalid formula (..)');
    end;
    if ferr then
      exit;
    case t^.num of
      // dual operations
      3:
      begin
        c := m2(m1(c(t^.l)) + m1(c(t^.r)));
         (*
         s:=c(t^.l);
         mS:=c(t^.r);
         s:=m2(m1(s)+m1(ms));
         FFParams.Strings[ffParams.Count-3]:=s;
         c:=s;
         *)
      end;
      4: c := m2(m1(c(t^.l)) - m1(c(t^.r)));
      5: c := m2(m1(c(t^.l)) * m1(c(t^.r)));
      6:
      begin
        r := m1(c(t^.r));
        if abs(r) < 0.00000001 then
          c := '0'
        else
          c := m2(m1(c(t^.l)) / r);
      end;
      // unary + or unary -
      7, 8: c := (t^.con);

      // variable or function
      9:
      begin
        if not ((t^.con[1] in [#36, #39, '_', 'A'..'Z', 'a'..'z']) or
          (Pos('@@', t^.con) = 1)) then
        begin
          Error('Unknown variable:' + t^.con + ', invalid character in name');
          //if assigned(fOnGetValue) then fOnGetValue(t^.con,ms);
          c := '';
        end
        else
        begin
          i := fVariables.IndexOfName(t^.con);
          if i < 0 then
          begin
            c := '';
            Error('Unknown variable:' + t^.con);
          end
          else
          begin
            s := fVariables.strings[i];
            if Pos('@@', s) = 1 then
            begin //:= eval
              ms := copy(s, 1, Pos('=', s) - 1);
              ms := copy(ms, 3, 255);
              s := copy(s, Pos('=', s) + 1, 65000);
              if s <> '' then
              begin
                if (s[1] = '[') and (s[length(s)] = ']') then
                begin
                  system.Delete(s, 1, 1);
                  system.Delete(s, length(s), 1);
                  s := trim(s);
                end;
              end;
              TC := TCalcul.Create;
              TC.Variables := FVariables.Text;
              TC.formula := s;
              try
                Result := TC.Calc;
                t^.typ := TC.ResultType;
              finally
                TC.Free;
                i := fVariables.IndexOfName('@@' + ms);
                if i > 0 then
                  FVariables.Delete(i);
                i := fVariables.IndexOfName(ms);
                if i >= 0 then
                  fVariables.Strings[i] := ms + '=' + Result
                else
                  fVariables.add(ms + '=' + Result);
              end;
            end
            else
            begin
              t^.typ := 2;
              if Pos('=', s) > 0 then
              begin
                s := system.copy(s, Pos('=', s) + 1, 65000);
                s := Trimleft(s);
                if s <> '' then
                begin
                  if s[1] = '"' then
                  begin
                    if s[length(s)] = '"' then
                      system.Delete(s, length(s), 1);
                    if s <> '' then
                      system.Delete(s, 1, 1);
                  end
                  else
                    t^.typ := 1;
                end;
              end
              else
                s := '';
              c := s;
            end;
          end;
        end;
      end;

      //single operations
      10: c := m2(-m1(c(t^.l)));
      11: c := m2(cos(m1(c(t^.l))));
      12: c := m2(sin(m1(c(t^.l))));
      13: c := m2(tan(m1(c(t^.l))));
      14:
      begin
        r := tan(m1(c(t^.l)));
        if r < -0.0000001 then
          c := '-1'
        else
        if r > 0.00000001 then
          c := '1'
        else
          c := m2(1 / r);
      end;
      15: c := m2(abs(m1(c(t^.l))));
      16:
      begin
        r := m1(c(t^.l));
        if r < -0.0000001 then
          c := '-1'
        else if r > 0.00000001 then
          c := '1'
        else
          c := '0';
      end;
      17: c := m2(sqrt(m1(c(t^.l))));
      18: c := m2(ln(m1(c(t^.l))));
      19: c := m2(exp(m1(c(t^.l))));
      20: c := m2(arcsin(m1(c(t^.l))));
      21: c := m2(arccos(m1(c(t^.l))));
      22: c := m2(arctan(m1(c(t^.l))));
      23: c := m2(pi / 2 - arctan(m1(c(t^.l))));
      24:
      begin
        r := m1(c(t^.l));
        c := m2((exp(r) - exp(-r)) / 2);
      end;
      25:
      begin
        r := m1(c(t^.l));
        c := m2((exp(r) + exp(-r)) / 2);
      end;
      26:
      begin
        r := m1(c(t^.l));
        c := m2((exp(r) - exp(-r)) / (exp(r) + exp(-r)));
      end;
      27:
      begin
        r := m1(c(t^.l));
        c := m2((exp(r) + exp(-r)) / (exp(r) - exp(-r)));
      end;
      28:
      begin
        r := m1(c(t^.l));
        if r >= 0 then
          c := '1'
        else
          c := '0';
      end;
      29:
      begin //ExistVar
        i := FVariables.indexOfname(c(t^.l));
        if i < 0 then
          c := '0'
        else
          c := '1';
      end;
      30:
      begin  //FreeVar
        i := FVariables.indexOfname(c(t^.l));
        if i >= 0 then
        begin
          FVariables.Delete(i);
          c := '1';
        end
        else
          c := '0';
      end;
      31: c := m2(power(m1(c(t^.l)), m1(c(t^.r))));
      32: c := m2(LastDay(m0(c(t^.l))));  //LastDay(Stamp)
      33: c := m2(frac(m1(c(t^.l))));  //frac
      34: c := m2(trunc(m1(c(t^.l)))); //trunc
      73: c := m2(round(m1(c(t^.l)))); //round - added func
      35: c := m2(length(c(t^.l)));  //length
      38: c := trimLeft(c(t^.l)); //trimleft
      39: c := trimright(c(t^.l)); //trimright

      41: c := trim(c(t^.l)); //trim
      42:
      begin    //eval
        s := trim(c(t^.l));
        if s <> '' then
        begin
          if (s[1] = '[') and (s[length(s)] = ']') then
          begin
            system.Delete(s, 1, 1);
            system.Delete(s, length(s), 1);
            s := trim(s);
          end;
        end;
        TC := TCalcul.Create;
        TC.Variables := FVariables.Text;
        TC.formula := s;
        try
          c := TC.Calc;
          t^.typ := TC.ResultType;
        finally
          TC.Free;
        end;
      end;
      43: c := char(m0(c(t^.l))); //char
      44:
      begin
        s := c(t^.l);    //ascii
        if s <> '' then
          c := m2(0.0 + byte(s[1]));
      end;
      45: c := AnsiUpperCase(c(t^.l));
      46: c := AnsiLowerCase(c(t^.l));
      47: if m1(c(t^.l)) >= 1 then
          c := '0'
        else
          c := '1'; // not
      48:
      begin //weekday
        s := c(t^.l);
        d := MStrToDateTime(s);
        j := DayOfWeek(d);
        if j > 0 then
          if j = 1 then
            j := 7
          else
            j := j - 1;
        c := IntToStr(j);
      end;
      49:
      begin //month
        s := c(t^.l);
        d := MStrToDateTime(s);
        DecodeDate(d, Y1, MM1, D1);
        c := IntToStr(MM1);
      end;
      50:
      begin //year
        s := c(t^.l);
        d := MStrToDateTime(s);
        DecodeDate(d, Y1, MM1, D1);
        c := IntToStr(Y1);
      end;
      51:
      begin //day
        s := c(t^.l);
        d := MStrToDateTime(s);
        DecodeDate(d, Y1, MM1, D1);
        c := IntToStr(D1);
      end;
      52:
      begin //hour
        s := c(t^.l);
        d := MStrToDateTime(s);
        DecodeTime(d, H1, MM1, S1, Y1);
        c := IntToStr(H1);
      end;
      53:
      begin //minute
        s := c(t^.l);
        d := MStrToDateTime(s);
        DecodeTime(d, H1, MM1, S1, Y1);
        c := IntToStr(MM1);
      end;
      54:
      begin //sec
        s := c(t^.l);
        d := MStrToDateTime(s);
        DecodeTime(d, H1, MM1, S1, Y1);
        c := IntToStr(S1);
      end;
      55:
      begin //StrToStamp
        s := c(t^.l);
        d := MStrToDateTime(s);
        c := m2(d);
      end;
      56:
      begin //StampToDateStr
        s := c(t^.l);
        c := MDateToStr(m1(s));
      end;
      57:
      begin //StampToTimeStr
        s := c(t^.l);
        c := MTimeToStr(m1(s));
      end;
      58:
      begin //StampToStr
        s := c(t^.l);
        c := MDateTimeToStr(m1(s));
      end;
      60..72:
      begin
           (*
           60=copy(s,x,[y]);
           61=copyto(s,x,[y]);
           62=Pos(t,s)
           63=Delete(s,x,[y]);
           64=replace(s,t,v,ReplaceAll=1/0,IgnoreCase=1/0)
           65=MaxVal(x,y,[z, ...])
           66=MinVal(x,y,[z, ...])
           67=IFF(a,s,t);
           68=SumVal(x,...)
           69=AvgVal(x,...)
           70=Insert(t,s,x)
           71=NumBase(x,y);
           *)
        FFParams.add(IntToStr(t^.num));
        FFParams.add('[!!!]');
        //fMultyParam := False;
        s := c(t^.l);
        c := s;
        //fMultyParam := False;
        FFParams.Insert(FFParams.Count - 2, s);
        if ffParams.Count = 0 then
          exit;
        j := m0(FFparams.Strings[FFParams.Count - 2]);
        i := 0;
        case j of
          60: i := 2; //copy
          61: i := 2; //copyto
          62: i := 2; //pos
          63: i := 2; //delete
          64: i := 3; //replace
          65: i := 1; //maxval
          66: i := 1; //minval
          67: i := 1; //SumVal
          68: i := 1; //AvgVal
          69: i := 3; //Iff
          70: i := 3; //Insert
          71: i := 2; //NumBase
          72: i := 2; //baseNum
          else
            Error('Internal error, function with params');
        end;
        if not fErr then
        begin
          FFparams.Delete(FFParams.Count - 1);
          FFparams.Delete(FFParams.Count - 1);
        end;
        if FFparams.Count > 0 then
        begin
          k := 0;
          if not (j in [65, 66, 67, 68]) then
          begin
            while (FFParams.Count > 0) and (k < 5) and
              (FFParams.Strings[FFparams.Count - 1] <> '[!!!]') do
            begin
              Inc(k);
              sp[k] := trim(FFParams.strings[FFParams.Count - 1]);
              ffParams.Delete(FFParams.Count - 1);
            end;
            if k < i then
            begin
              Error('Not enough params');
              exit;
            end;
          end;
          dd := 0;
          ;
          s := sp[1];
          case j of
            60:
            begin  //copy
              if k < 3 then
                sp[3] := IntToStr(length(sp[1]));
              if (length(sp[1]) >= m0(sp[2])) and (m0(sp[3]) > 0) then
                s := system.copy(sp[1], m0(sp[2]), m0(sp[3]))
              else
                s := '';
            end;
            61:
            begin  //copyto
              if k < 3 then
                sp[3] := IntToStr(length(sp[1]));
              if (length(sp[1]) >= m0(sp[2])) and (m0(sp[3]) >= m0(sp[2])) then
                s := system.copy(sp[1], m0(sp[2]), m0(sp[3]) - m0(sp[2]) + 1)
              else
                s := '';
            end;
            62:
            begin //pos
              s := IntToStr(pos(sp[1], sp[2]));
            end;
            63:
            begin  //delete
              if k < 3 then
                sp[3] := IntToStr(length(sp[1]));
              if (length(sp[1]) >= m0(sp[2])) and (m0(sp[3]) > 0) then
                system.Delete(sp[1], m0(sp[2]), m0(sp[3]));
              s := sp[1];
            end;
            64:
            begin  //replace
              mRepFlag := [];
              if k < 5 then
                sp[5] := '1';
              if k < 4 then
                sp[4] := '1';
              if m0(sp[4]) = 1 then
                mRepFlag := mRepFlag + [rfReplaceAll];
              if m0(sp[5]) = 1 then
                mRepFlag := mRepFlag + [rfIgnoreCase];
              s := StringReplace(sp[1], sp[2], sp[3], mRepFlag);
            end;
            65:
            begin  //maxval
              k := 0;
              while (fErr = False) and (FFParams.Count > 0) and
                (FFParams.Strings[FFparams.Count - 1] <> '[!!!]') do
              begin
                Inc(k);
                d := m1(trim(FFParams.strings[FFParams.Count - 1]));
                if k = 1 then
                  dd := d
                else if d > dd then
                  dd := d;
                ffParams.Delete(FFParams.Count - 1);
              end;
              if k < 1 then
                Error('Error, not enough params');
              s := m2(dd);
            end;
            66:
            begin  //minval
              k := 0;
              while (fErr = False) and (FFParams.Count > 0) and
                (FFParams.Strings[FFparams.Count - 1] <> '[!!!]') do
              begin
                Inc(k);
                d := m1(trim(FFParams.strings[FFParams.Count - 1]));
                if k = 1 then
                  dd := d
                else if d < dd then
                  dd := d;
                ffParams.Delete(FFParams.Count - 1);
              end;
              if k < 1 then
                Error('Error, not enough params');
              s := m2(dd);
            end;
            67:
            begin  //sumVal
              dd := 0;
              while (fErr = False) and (FFParams.Count > 0) and
                (FFParams.Strings[FFparams.Count - 1] <> '[!!!]') do
              begin
                Inc(k);
                d := m1(trim(FFParams.strings[FFParams.Count - 1]));
                dd := dd + d;
                ffParams.Delete(FFParams.Count - 1);
              end;
              if k < 1 then
                Error('Error, not enough params');
              s := m2(dd);
            end;
            68:
            begin  //AvgVal
              dd := 0;
              k := 0;
              s := '0';
              while (fErr = False) and (FFParams.Count > 0) and
                (FFParams.Strings[FFparams.Count - 1] <> '[!!!]') do
              begin
                Inc(k);
                d := m1(trim(FFParams.strings[FFParams.Count - 1]));
                dd := dd + d;
                ffParams.Delete(FFParams.Count - 1);
              end;
              if k < 1 then
                Error('Error, not enough params')
              else
                s := m2(dd / k);
            end;
            69:
            begin  //IFF(a,s,t) - string
              if m0(sp[1]) = 1 then
                s := sp[2]
              else
                s := sp[3];
            end;
            70:
            begin  //insert(t,s,x)
              if length(sp[1]) = 0 then
                sp[1] := sp[2]
              else
              begin
                if m0(sp[3]) > length(s) + 1 then
                  sp[3] := IntToStr(length(s) + 1);
                if m0(sp[3]) <= 0 then
                  sp[3] := '1';
                system.insert(sp[2], sp[1], m0(sp[3]));
              end;
              s := sp[1];
            end;
            71:
            begin
              if m0(sp[2]) > 16 then
                sp[2] := '16';
              if m0(sp[2]) < 2 then
                sp[2] := '2';
              s := NumBase(m0(sp[1]), m0(sp[2]));
            end;
            72:
            begin
              if m0(sp[2]) > 16 then
                sp[2] := '16';
              if m0(sp[2]) < 2 then
                sp[2] := '2';
              i := Basenum(sp[1], m0(sp[2]));
              if i > 0 then
                s := IntToStr(i)
              else
                s := '';
            end;
          end;{case}
          c := s;
        end;
        //s:=c(t^.l);
        //FFparams.Insert(0,s);
      end;
      196: c := c(t^.l);      //string()
      197:
      begin
        s := c(t^.l);
        s := StringReplace(s, ' ', '', [rfReplaceAll]);
        s := StringReplace(s, ',', '.', [rfReplaceAll]);
        c := m2(m1(s));      //numeric()
      end;
      198:
      begin //logic 0,1
        if m0(c(t^.l)) >= 1 then
          c := '1'
        else
          c := '0';
      end;

      {-------------  dual oper ---------------------------------}
      200:
      begin
        j := m0(c(t^.r));     // div
        if j = 0 then
          c := '0'
        else
          c := m2(m0(c(t^.l)) div j);
      end;
      201: c := m2(m0(c(t^.l)) mod m0(c(t^.r))); //mod
      202: c := c(t^.l) + c(t^.r);    // ||
      210: if (m1(c(t^.l)) >= 1) and (m1(c(t^.r)) >= 1) then
          c := '1'
        else
          c := '0';  //and
      211: if (m1(c(t^.l)) >= 1) or (m1(c(t^.r)) >= 1) then
          c := '1'
        else
          c := '0';  //or
      220: if c(t^.l) = c(t^.r) then
          c := '1'
        else
          c := '0';  //=
      225: if c(t^.l) <> c(t^.r) then
          c := '1'
        else
          c := '0';  //<>
      221, 222, 223, 224:
      begin
        d := m1(c(t^.l));
        dd := m1(c(t^.r));
        if fErr then
        begin
          fErr := False;
          fErrText := '';
          s := c(t^.l);
          ms := c(t^.r);
          j := AnsiCompareStr(s, ms);
          case t^.num of
            221: if j < 0 then
                c := '1'
              else
                c := '0';  //<
            222: if j <= 0 then
                c := '1'
              else
                c := '0';  //<=
            223: if j > 0 then
                c := '1'
              else
                c := '0';  //>
            224: if j >= 0 then
                c := '1'
              else
                c := '0';  //>=
          end;
        end
        else
        begin
          case t^.num of
            221: if d < dd then
                c := '1'
              else
                c := '0';  //<
            222: if d <= dd then
                c := '1'
              else
                c := '0';  //<=
            223: if d > dd then
                c := '1'
              else
                c := '0';  //>
            224: if d >= dd then
                c := '1'
              else
                c := '0';  //>=
          end;
        end;
      end;
      230:
      begin
        s := c(t^.r);
        s := StringReplace(s, '%', '*', [rfReplaceAll]);
        s := StringReplace(s, '_', '?', [rfReplaceAll]);
        if MatchesMask(c(t^.l), s) then
          c := '1'
        else
          c := '0';
      end;
      231:
      begin
        s := c(t^.r);
        if MatchesMask(c(t^.l), s) then
          c := '1'
        else
          c := '0';
      end;
      251:
      begin   // ;  formula separated
        Result := c(t^.l); //must evaluated
        Result := c(t^.r);
      end;
      250://if FFParams.Count<2 then Error('Error param. count') else
      begin
           (*
           60=copy(s,x,[y]);
           61=copyto(s,x,[y]);
           62=Pos(t,s)
           63=Delete(s,x,[y]);
           64=replace(s,t,v,ReplaceAll=1/0,IgnoreCase=1/0)
           65=MaxVal(x,y,[z, ...])
           66=MinVal(x,y,[z, ...])
           67=SumVal(x,...)
           68=AvgVal(x,...)
           69=IFF(a,x,y);
           70=Insert(t,s,x);
           *)
        s := c(t^.r);
        FFParams.Insert(FFParams.Count - 2, s);
        c := c(t^.l);
      end;
      else  {case else}
        Error('Internal error oper code ' + IntToStr(t^.num));
    end;
  end;

var
  sss: string;
begin
  FFParams.Clear;
  if Pos('"', fFormula) > 0 then
    fResultType := 2
  else
    fResultType := 1;
  while (fFormula <> '') and (fFormula[length(fFormula)] in [';', ' ']) do
    system.Delete(fFormula, length(fFormula), 1);
  try
    sss := Separ(fFormula);
    Test(sss, True);
    sss := c(tree);
    if not fErr then
    begin
      fResultType := PCalc_TREE(Tree)^.typ;
      Result := sss;
      if fResultType = 2 then
      begin
        if not IsString(sss) then
          Result := '"' + Result + '"';
      end;
    end;
  except
    Error('');
  end;
end;

function TCalcul.IsString(s: string): boolean;
begin
  s := trim(s);
  Result := False;
  if length(s) = 0 then
    exit;
  if s[1] <> '"' then
    exit;
  if s[length(s)] <> '"' then
    exit;
  Result := True;
end;

procedure TCalcul.Error(s: string);
begin
  if fErr = False then
  begin
    if s = '' then
      s := 'invalid formule';
    fErrText := s;
    fErr := True;
    //if Err then if Assigned(fErr) then fErr(self,fErrText);
  end;
  //Raise ; //Exception.Create(s);
end;



//*********************************************************************

function TCalcul.GetTree(s: string): pointer;
  //Get number from string

  function getnumber(s: string): string;
  begin
    Result := '';
    try
      //Begin
      //if Pos(DecimalSeparator,s)>0 then s[Pos(DecimalSeparator,s)]:='.';
      while (fpos <= length(s)) and (s[fpos] in ['0'..'9']) do
      begin
        Result := Result + s[fpos];
        Inc(fpos);
      end;
      if fpos > length(s) then
        exit;
      if s[fpos] = '.' then
      begin
        //Fraction part
        Result := Result + '.';
        Inc(fpos);
        if (fpos > length(s)) or not (s[fpos] in ['0'..'9']) then
        begin
          Error('Wrong number in ' + s);
          exit;
        end;
        while (fpos <= length(s)) and (s[fpos] in ['0'..'9']) do
        begin
          Result := Result + s[fpos];
          Inc(fpos);
        end;
      end;
      if fpos > length(s) then
        exit;
      //Power
      if (s[fpos] <> 'e') and (s[fpos] <> 'E') then
        exit;
      Result := Result + s[fpos];
      Inc(fpos);
      if fpos > length(s) then
      begin
        Error('Wrong number in ' + s);
        exit;
      end;
      if s[fpos] in ['-', '+'] then
      begin
        Result := Result + s[fpos];
        Inc(fpos);
      end;
      if (fpos > length(s)) or not (s[fpos] in ['0'..'9']) then
      begin
        Error('Wrong number in ' + s);
        exit;
      end;
      while (fpos <= length(s)) and (s[fpos] in ['0'..'9']) do
      begin
        Result := Result + s[fpos];
        Inc(fpos);
      end;
    except
    end;
  end;

  //Read lexem from string

  procedure getlex(s: string; var num: integer; var con: string);
  var
    mb: boolean;
    i: integer;
    mcon: string;
    ccc: char;
    z: boolean;
  begin
    con := '';
    num := 0;
    //skip spaces
    while (fpos <= length(s)) and (s[fpos] in [' ', #0..#13]) do
      Inc(fpos);
    if fpos > length(s) then
    begin
      num := 0;
      exit;
    end;

    case s[fpos] of
      '(': num := 1;
      ')': num := 2;
      '+': num := 3;
      '-':
      begin
        num := 4;
        if (fpos < length(s)) and (s[fpos + 1] in ['1'..'9', '0']) and
          (curlex in [0, 1]) then
        begin
          Inc(fpos);
          con := '-' + getnumber(s);
          Dec(fpos);
          num := 7;
        end;
      end;
      '*': num := 5;
      '/': num := 6;
      '^': num := 31;
      '|':
      begin
        if (s[fpos + 1] = '|') then
          Inc(fpos);
        num := 202; //a add b  string operation
      end;
      '1'..'9', '0':
      begin
        con := getnumber(s);
        Dec(fpos);
        num := 7;
      end;
      '>':
      begin
        if (fpos <= length(s)) and (s[fpos + 1] = '=') then
        begin
          num := 224;
          Inc(fpos);     //>=
        end
        else
          num := 223;         //>
      end;
      '<':
      begin
        if (fpos <= length(s)) and (s[fpos + 1] = '=') then
        begin
          num := 222;
          Inc(fpos);     //<=
        end
        else
        begin
          if (fpos <= length(s)) and (s[fpos + 1] = '>') then
          begin
            num := 225;
            Inc(fpos); //<>
          end
          else
            num := 221;     //<
        end;
      end;
      '=': num := 220;
      ',': num := 250;
      ';': num := 251; //formules separator;
      '"':
      begin                     //string
        Inc(fpos);
        mb := True;
        while mb do
        begin
          mb := False;
          while (fpos <= length(s)) and (s[fpos] <> '"') do
          begin
            con := con + s[fpos];
            Inc(fpos);
          end;
          if (fpos < length(s)) and (s[fpos + 1] = '"') then
          begin
            Inc(fpos);
            con := con + s[fpos];
            Inc(fpos);
            mb := True;
          end;   //"alfa""
        end;
        if (fpos > length(s)) or ((fpos < length(s)) and (s[fpos] <> '"')) then
          Error('String value end error');
        num := 8;
      end;
      'a'..'z', 'A'..'Z', '_', #36,
      #39:    //num=9 nastavi ze je to funkcia alebo variable
      begin
        ccc := s[fpos];
        while (fpos <= length(s)) and (s[fpos] in
            ['a'..'z', 'A'..'Z', #36, '_', '.', '1'..'9', '0']) do
        begin
          con := con + s[fpos];
          Inc(fpos);
        end;
        if (ccc = #39) and (length(s) >= fpos + 1) and (s[fpos] = #39) then
          con := con + #39
        else
          Dec(fpos); //variable 'name'
        if (ccc <> #39) and (length(s) >= fpos + 1) and (s[fpos + 1] = '(') then
          con := con + '('; //funkcia
        if (ccc <> #39) and (length(s) >= fpos + 2) and (s[fpos + 1] = ':') and
          (s[fpos + 2] = '=') then
        begin
          fPos := fPos + 2;
          i := fpos;
          z := False;
          while (i < length(s)) do
          begin
            Inc(i);
            if (s[i] = ';') and (z = False) then
            begin
              Dec(i);
              break;
            end;
            if s[i] = '"' then
              z := not (z);
          end;
          con := '@@' + con;
          FVariables.add(con + '=[' + copy(s, fPos + 1, i - fpos) + ']');
          fPos := i;
          num := 9;
        end;
        if ccc = #39 then
        begin
          if con[length(con)] = #39 then
            con := system.copy(con, 1, length(con) - 2)
          else
            Error('Invalid varaible name ' + con); //variab 'name'
        end;
        num := 9;
      end;
    end;

    if num = 9 then
    begin
      if length(con) > 1 then
      begin
        mcon := lowercase(con);
        if mCon[length(mcon)] = '(' then
        begin
          //function  to from 11 to 199
               (*
           60=copy(s,x,[y]);
           61=copyto(s,x,[y]);
           62=Pos(t,s)
           63=Delete(s,x,[y]);
           64=replace(s,t,v,ReplaceAll=1/0,IgnoreCase=1/0)
           65=MaxVal(x,y,[z, ...])
           66=MinVal(x,y,[z, ...])
           *)
          case mcon[1] of
            'r':
            begin
              if mcon = 'replace(' then
                num := 64;
              if mcon = 'round(' then
                num := 73;
            end;
            'p': if mcon = 'pos(' then
                num := 62;
            'f':
            begin
              if mcon = 'frac(' then
                num := 33;
              if mcon = 'freevar(' then
                num := 30;
            end;
            'c':
            begin
              if mcon = 'cos(' then
                num := 11;
              if mcon = 'ctg(' then
                num := 14;
              if mcon = 'ch(' then
                num := 25;
              if mcon = 'cth(' then
                num := 27;
              if mcon = 'char(' then
                num := 43;
              if mcon = 'copy(' then
                num := 60;     //copy(a,x,y)
              if mcon = 'copyto(' then
                num := 61;     //copy(a,x,y)
            end;
            's':
            begin
              if mcon = 'string(' then
                num := 196;
              if Pos('stamp', mcon) = 1 then
              begin
                if mcon = 'stamptodatestr(' then
                  num := 56;
                if mcon = 'stamptotimestr(' then
                  num := 57;
                if mcon = 'stamptostr(' then
                  num := 58;
              end;
              if mcon = 'strtostamp(' then
                num := 55;
              if mcon = 'sin(' then
                num := 12;
              if mcon = 'sign(' then
                num := 16;
              if mcon = 'sqrt(' then
                num := 17;
              if mcon = 'sh(' then
                num := 24;
              if mcon = 'sec(' then
                num := 54;
              if mcon = 'sumval(' then
                num := 67;
            end;
            't':
            begin
              if mcon = 'trunc(' then
                num := 34;
              if mcon = 'trim(' then
                num := 41;
              if mcon = 'tg(' then
                num := 13;
              if mcon = 'th(' then
                num := 26;
              if mcon = 'trimleft(' then
                num := 38;
              if mcon = 'trimright(' then
                num := 39;
            end;
            'a':
            begin
              if Pos('arc', mcon) = 1 then
              begin
                if mcon = 'arcsin(' then
                  num := 20;
                if mcon = 'arccos(' then
                  num := 21;
                if mcon = 'arctg(' then
                  num := 22;
                if mcon = 'arcctg(' then
                  num := 23;
              end
              else
              begin
                if mcon = 'abs(' then
                  num := 15;
                if mcon = 'ascii(' then
                  num := 44;
                if mcon = 'avgval(' then
                  num := 68;
              end;
            end;
            'l':
            begin
              if mcon = 'ln(' then
                num := 18;
              if mcon = 'lower(' then
                num := 46;
              if mcon = 'logic(' then
                num := 198;
              if mcon = 'length(' then
                num := 35;
              if mcon = 'lastday(' then
                num := 32;
            end;
            'e':
            begin
              if mcon = 'exp(' then
                num := 19;
              if mcon = 'eval(' then
                num := 42;
              if mcon = 'existvar(' then
                num := 29;
            end;
            'h':
            begin
              if (mcon = 'heaviside(') or (mcon = 'h(') then
                num := 28;
              if (mcon = 'hour(') then
                num := 52;
            end;
            'u': if mcon = 'upper(' then
                num := 45;
            'n':
            begin
              if mcon = 'not(' then
                num := 47;            // not(a)
              if mcon = 'numeric(' then
                num := 197;            // not(a)
              if mcon = 'numbase(' then
                num := 71;
            end;
            'd':
            begin
              if mcon = 'delete(' then
                num := 63;
              if mcon = 'day(' then
                num := 51;     //day()
            end;
            'm':
            begin
              if mcon = 'month(' then
                num := 49;
              if mcon = 'minute(' then
                num := 53;
              if mcon = 'max(' then  //maxval
                num := 65;
              if mcon = 'min(' then  //minval
                num := 66;
            end;
            'w': if mcon = 'weekday(' then
                num := 48;
            'y': if mcon = 'year(' then
                num := 50;
            'i':
            begin
              if mcon = 'iff(' then
                num := 69;
              if mcon = 'insert(' then
                num := 70;
            end;
            'b': if mcon = 'basenum(' then
                num := 72;
          end; {case}
          if num = 9 then
            Error('Invalid function ' + con + '...)');
        end
        else
        begin
          case mcon[1] of
            // 2nd operands from 200 to 255
            'l':
            begin
              if mcon = 'like' then
                num := 230;  //like (%,_');
            end;
            'w':
            begin                   //like by do (*,?)
              if mcon = 'wildcard' then
                num := 231;
            end;
            'a':
            begin
              if mcon = 'and' then
                num := 210;
            end;
            'd':
            begin
              if mcon = 'div' then
                num := 200;
            end;
            'm':
            begin
              if mcon = 'mod' then
                num := 201;
            end;
            'o': if mcon = 'or' then
                num := 211;
            else
            //Error('Invalic operand '+con);
          end;//case
        end;
      end;
    end;
    Inc(fpos);
    PrevLex := CurLex;
    CurLex := num;
  end;

var
  neg: boolean;
  l, r, res: PCalc_Tree;
  n, op: integer;
  c: string;

  function newnode: PCalc_Tree;
  begin
    Result := allocmem(sizeof(TCalc_Tree));
    AddVek(Result);
    Result^.l := nil;
    Result^.r := nil;
  end;

  function getsingleop: pointer;
  var
    op, bracket: integer;
    opc: string;
    l, r, res: PCalc_Tree;
  begin
    l := nil;
    Result := nil;
    try
      if n = 1 then
      begin
        Inc(bc);
        l := gettree(s);
      end
      else
      begin
        // First operand
        if not (n in [7..199]) then
        begin
          Error('? operand ');
          exit;
        end;
        op := n;
        opc := c;
        if n in [7, 8, 9] then
        begin
          // Number or variable
          l := newnode;
          l^.num := op;
          l^.con := opc;
        end
        else
        begin
          //Function
          getlex(s, n, c);
          if n <> 1 then
          begin
            Error('');
            exit;
          end;  //first char must by:(
          Inc(bc);
          l := newnode;
          l^.l := gettree(s);
          l^.num := op;
          l^.con := opc;
        end;
      end;
      //Operation symbol
      getlex(s, n, c);
      //Power symbol
      while n in [31] do
      begin
        getlex(s, n, c);
        bracket := 0;
        if n = 1 then
        begin
          bracket := 1;
          getlex(s, n, c);
        end;
        if not (n in [7, 8, 9]) then
        begin
          Error('Invalid values');
          exit;
        end;
        r := newnode;
        r^.num := n;
        r^.con := c;
        res := newnode;
        res^.l := l;
        res^.r := r;
        res^.num := 31;
        l := res;
        if bracket = 1 then
        begin
          getlex(s, n, c);
          if n <> 2 then
          begin
            Error('');
            exit;
          end;
        end;
        getlex(s, n, c);
      end;
      Result := l;
    except
      DelTree(l);
      Result := nil;
    end;
  end;


  function getop: pointer;  // unary or dual operand
  var
    op: integer;
    l, r, res: PCalc_Tree;
  begin
    neg := False;
    getlex(s, n, c);
    // Unary - or +
    if prevlex in [0, 1, 4, 3] then
    begin
      if n = 4 then
      begin
        neg := True;
        getlex(s, n, c);
      end;
      if n = 3 then
        getlex(s, n, c);
    end;
    l := getsingleop;
    // 2nd operand **************
    while n in [5, 6, 200..255] do
    begin
      op := n;
      getlex(s, n, c);
      r := getsingleop;
      res := allocmem(sizeof(TCalc_Tree));
      Addvek(res);
      res^.l := l;
      res^.r := r;
      res^.num := op;
      l := res;
    end;
    // Unary minus
    if neg then
    begin
      res := allocmem(sizeof(TCalc_Tree));
      addvek(res);
      res^.l := l;
      res^.r := nil;
      res^.num := 10;
      l := res;
    end;
    Result := l;
  end;

begin
  l := nil;
  Result := nil;
  try
    l := getop;
    while True do
    begin
      if n in [0, 2] then
      begin
        if n = 2 then
          Dec(bc);
        Result := l;
        exit;
      end;
      if not (n in [3, 4, 8, 9]) then
      begin
        Error('Invalid expression');
        exit;
      end;
      op := n;
      r := getop;
      res := allocmem(sizeof(TCalc_Tree));
      Addvek(res);
      res^.l := l;
      res^.r := r;
      res^.num := op;
      l := res;
    end;
    Result := l;
  except
    DelTree(l);
    Result := nil;
  end;
end;


//***************************************************************


function TCalcul.Test(s: string; sys: boolean = False): integer;
var
  i: integer;
  ms: Shortstring;
begin
  if s = '' then
    s := '0';
  deltree(tree);
  for i := 1 to cVek do
    if fvek[i] <> nil then
      deltree(fvek[i]);
  cVek := 0;
  MaxVek := 0;
  SetLength(fVek, 0);
  fErr := False;
  fErrtext := '';
  if sys then
  begin
    ms := MDateTostr(date);
    i := fVariables.IndexOfName('date');
    if i < 0 then
    begin
      fVariables.add('date="' + ms + '"');
    end
    else
      fVariables.Strings[i] := 'date="' + ms + '"';

    ms := MDateTimeToStr(now);
    i := fVariables.IndexOfName('now');
    if i < 0 then
    begin
      fVariables.add('now="' + ms + '"');
    end
    else
      fvariables.Strings[i] := 'now="' + ms + '"';

    ms := MTimeToStr(now);
    i := fVariables.IndexOfName('time');
    if i < 0 then
    begin
      fVariables.add('time="' + ms + '"');
    end
    else
      fvariables.Strings[i] := 'time="' + ms + '"';
  end;
  Prevlex := 0;
  Curlex := 0;
  fPos := 1;
  bc := 0;
  Tree := GetTree(s);
  try
    PCalc_tree(tree)^.typ := fResultType;
  except
  end;
  if (bc <> 0) or fErr then
  begin
    Tree := DelTree(Tree);
    for i := 1 to cVek do
      if fvek[i] <> nil then
        deltree(fvek[i]);
    cVek := 0;
    MaxVek := 0;
    SetLength(fVek, 0);
    Result := -1;
  end
  else
    Result := cVek;
end;

//Tree deletion

function TCalcul.deltree(t: PCalc_Tree): pointer;
begin
  Result := nil;
  try
    if t = nil then
      exit;
    if (t^.id > cVek) or (t^.id < 1) then
      exit;
    if t^.l <> nil then
      Deltree(t^.l);
    if t^.r <> nil then
      Deltree(t^.r);
    Delvek(t);
    freemem(t);
  except
  end;
end;

procedure TCalcul.SetVariables(Value: string);
begin
  FVariables.Text := Value;
end;

function TCalcul.GetVariables: string;
begin
  Result := FVariables.Text;
end;

procedure TCalcul.Addvek(t: pointer);
begin
  Inc(cVek);
  if cVek > MaxVek then
  begin
    MaxVek := Maxvek + 50;
    SetLength(fVek, MaxVek);
  end;
  PCalc_tree(t)^.id := cVek;
  fVek[cVek] := t;
end;

procedure TCalcul.Delvek(t: pointer);
begin
  if (PCalc_tree(t)^.id <= cVek) and (PCalc_Tree(t)^.id > 0) then
    fvek[PCalc_Tree(t)^.id] := nil;
end;

function Tcalcul.Separ(s: string): string;
var
  b: array[1..100] of smallint;
  i, j, k: integer;
  z: boolean;
begin
  i := Pos(',', s);
  if i = 0 then
  begin
    Result := s;
    exit;
  end;
  for i := Low(b) to High(b) do
    b[i] := 0;
  z := False;
  i := 0;
  k := 0;
  while i < length(s) do
  begin
    Inc(i);
    if s[i] = '"' then
      z := not (z);
    if not z then
    begin
      if s[i] = ',' then
      begin
        if (k > 0) and (b[k] = 0) then
        begin
          system.insert(')', s, i);
          Inc(i);
          Dec(k);
        end
        else
        begin
          j := i;
          system.insert(')', s, i);
          Inc(i);
          b[1] := 0;
          while j > 1 do
          begin
            Dec(j);
            if s[j] = ')' then
              b[1] := b[1] - 1;
            if s[j] = '(' then
              b[1] := b[1] + 1;
            if b[1] > 0 then
            begin
              system.insert('(', s, j);
              Inc(i);
              b[1] := 0;
              j := 0;
            end;
          end;
        end;
        Inc(i);
        system.insert('(', s, i);
        k := k + 1;
        b[k] := 0;
        continue;
      end;
      if k > 0 then
      begin
        if s[i] = '(' then
          b[k] := b[k] + 1;
        if s[i] = ')' then
          b[k] := b[k] - 1;
        if b[k] < 0 then
        begin
          Dec(k);
          system.insert(')', s, i);
          Inc(i);
        end;
      end;
    end;
  end;
  Result := s;
end;

end.
