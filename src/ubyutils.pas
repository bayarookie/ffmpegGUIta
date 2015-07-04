unit ubyUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, strutils, Math, LConvEncoding,
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF}
  Fileutil,
  LCLIntf, Process, UTF8Process, Dialogs;

function myGetFileSize(fn: string; short: boolean = False): string;
function myExpandFileNameCaseW(const wfn: string; out MatchFound: boolean): string;
function myExpandEnv(Path: string): string;
function myUnExpandEnv1(Path, Env: string): string;
function myUnExpandEnv2(Path, Env: string): string;
function myUnExpandEnvs(Path: string): string;
function myRealToTimeStr(rt: double; full: boolean = True): string;
function myTimeStrToReal(s: string): double;
function myGetAnsiFN(wfn: string): string;
procedure myGetListFromStr(s, sep: string; List: TStrings);
function myGetOutFN(Dir, Inp, Ext: string): string;
function myGetOutFNa(Dir, Inp, Ext: string): string;
function myBetween(var s: string; const s1, s2: string): string;
procedure myExecProc(Path: string; ComLine: array of string; sw: TShowWindowOptions = swoShowNormal);
procedure myExecProc1(ComLine: string; sw: TShowWindowOptions = swoShowNormal);
procedure myOpenDoc(Path: string);
function myCompareInt(List: TStringList; Index1, Index2: integer): integer;
function myGetLocaleLanguage: string;

implementation

function myGetFileSize(fn: string; short: boolean = False): string;
var
  sr: TSearchRec;
  i: double;
  fs: TFormatSettings;
begin
  fs.ThousandSeparator := ' ';
  if FindFirstUTF8(fn, 0, sr) = 0 then
  begin
    i := sr.Size * 1.0;
    if short then
    begin
      if i > 1024 * 1024 * 10240 then
        Result := Format('%12.0n GiB', [i / 1024 / 1024 / 1024], fs)
      else if i > 1024 * 10240 then
        Result := Format('%12.0n MiB', [i / 1024 / 1024], fs)
      else if i > 10240 then
        Result := Format('%12.0n KiB', [i / 1024], fs)
      else
        Result := Format('%12.0n', [i], fs);
    end
    else
      Result := Format('%12.0n', [i], fs);
  end
  else
    Result := '0';
  FindCloseUTF8(sr);
end;

function myExpandFileNameCaseW(const wfn: string; out MatchFound: boolean): string;
var
  SR: TSearchRec;
  FullPath, Name: string;
  Temp: Integer;
begin
  Result := ExpandFileName(wfn);
  FullPath := ExtractFilePath(Result);
  Name := ExtractFileName(Result);
  MatchFound := False;

  // if FullPath is not the root directory  (portable)
  if (FullPath <> AppendPathDelim(ExtractFileDrive(FullPath))) then
  begin  // Does the path need case-sensitive work?
    Temp := FindFirstUTF8(FullPath, faAnyFile, SR);
    FindCloseUTF8(SR);   // close search before going recursive
    if Temp <> 0 then
    begin
      FullPath := ExcludeTrailingPathDelimiter(FullPath);
      FullPath := myExpandFileNameCaseW(FullPath, MatchFound);
      if not MatchFound then
        Exit;    // if we can't find the path, we certainly can't find the file!
      FullPath := IncludeTrailingPathDelimiter(FullPath);
    end;
  end;

  // Path is validated / adjusted.  Now for the file itself
  try
    if FindFirstUTF8(FullPath + Name, faAnyFile, SR) = 0 then    // exact match on filename
    begin
      //if not (MatchFound in [mkSingleMatch, mkAmbiguous]) then  // path might have been inexact
        MatchFound := True;
      Result := FullPath + SR.Name;
    end;
  finally
    FindCloseUTF8(SR);
  end;
end;

function myExpandEnv(Path: string): string;
var
  i, j: integer;
  s, key, va1: string;
begin
  Result := Path;
  for i := 1 to GetEnvironmentVariableCount do
  begin
    s := GetEnvironmentString(i);
    j := Pos('=', s);
    if j = 0 then
      Continue;
    key := Copy(s, 1, j - 1);
    va1 := Copy(s, j + 1, maxint);
    {$IFDEF MSWINDOWS}
    Result := StringReplace(Result, '%' + key + '%', va1, [rfReplaceAll, rfIgnoreCase]);
    {$ELSE}
    Result := StringReplace(Result, '$' + key, va1, [rfReplaceAll, rfIgnoreCase]);
    {$ENDIF}
  end;
end;

function myUnExpandEnv1(Path, Env: string): string;
var
  s, e: string;
begin
  s := GetEnvironmentVariableUTF8(Env);
  {$IFDEF MSWINDOWS}
  e := '%' + Env + '%';
  {$ELSE}
  e := '$' + Env;
  {$ENDIF}
  if Pos(LowerCase(s), LowerCase(Path)) = 1 then
    Result := e + Copy(Path, Length(s) + 1, Length(Path))
  else
    Result := Path;
end;

function myUnExpandEnv2(Path, Env: string): string;
var
  s: string;
  i: integer;
begin
  s := GetEnvironmentVariableUTF8(Env);
  i := Pos(LowerCase(s), LowerCase(Path));
  if i > 0 then
    Result := Copy(Path, 1, i - 1) + '%' + Env + '%' +
      Copy(Path, Length(s) + 1, Length(Path))
  else
    Result := Path;
end;

function myUnExpandEnvs(Path: string): string;
var
  s: string;
begin
  {$IFDEF MSWINDOWS}
  s := myUnExpandEnv1(Path, 'TEMP');
  s := myUnExpandEnv1(s, 'TMP');
  s := myUnExpandEnv1(s, 'ProgramFiles');
  s := myUnExpandEnv1(s, 'COMMANDER_PATH');
  s := myUnExpandEnv1(s, 'ALLUSERSPROFILE');
  s := myUnExpandEnv1(s, 'USERPROFILE');
  s := myUnExpandEnv1(s, 'APPDATA');
  s := myUnExpandEnv1(s, 'LOCALAPPDATA');
  s := myUnExpandEnv1(s, 'windir');
  s := myUnExpandEnv1(s, 'SystemRoot');
  Result := myUnExpandEnv2(s, 'USERNAME');
  {$ELSE}
  s := myUnExpandEnv1(Path, 'HOME');
  Result := s;
  {$ENDIF}
end;

function myRealToTimeStr(rt: double; full: boolean = True): string;
var
  Hour, Min, Sec, MSec: int64;
begin
  Hour := Trunc(rt) div 3600;
  Min := (Trunc(rt) - Hour * 3600) div 60;
  Sec := (Trunc(rt) - Hour * 3600 - Min * 60);
  MSec := Trunc((rt - Hour * 3600 - Min * 60 - Sec) * 1000);
  Result := strutils.IfThen(Hour = 0, '', IntToStr(Hour) + ':');
  Result := Result + IfThen((Min = 0) and (Result = ''), '',
    char(48 + Min div 10) + char(48 + Min mod 10) + ':');
  Result := Result + IfThen((Sec = 0) and (Result = ''), '0',
    char(48 + Sec div 10) + char(48 + Sec mod 10));
  if (MSec > 0) or full then
    Result := Result + '.' + IfThen(MSec < 100, IfThen(MSec < 10, '00', '0'), '') +
      IntToStr(MSec);
end;

function myTimeStrToReal(s: string): double;
var
  i: integer;
  s1, s2, s3, s4: string;
  fs: TFormatSettings;
begin
  s1 := '';
  s2 := '';
  s3 := '';
  s4 := '';
  i := Pos(':', s);
  if (i > 1) then
  begin
    s2 := Copy(s, 1, i - 1);
    Delete(s, 1, i);
  end;
  i := Pos(':', s);
  if (i > 1) then
  begin
    s1 := s2;
    s2 := Copy(s, 1, i - 1);
    Delete(s, 1, i);
  end;
  i := Pos('.', s);
  if (i > 1) then
  begin
    s3 := Copy(s, 1, i - 1);
    Delete(s, 1, i);
    s4 := s;
  end
  else
    s3 := s;
  fs.DecimalSeparator := '.';
  Result := StrToIntDef(s1, 0) * 3600 + StrToIntDef(s2, 0) * 60 +
    StrToIntDef(s3, 0) + StrToFloatDef('.' + s4, 0, fs);
end;

{$IFDEF MSWINDOWS}
function NTSetPrivilege(sPrivilege: string; bEnabled: boolean): boolean;
var
  hToken: THandle;
  TokenPriv: TOKEN_PRIVILEGES;
  PrevTokenPriv: TOKEN_PRIVILEGES;
  ReturnLength: cardinal;
begin
  Result := True;
  // Only for Windows NT/2000/XP and later.
  if not (Win32Platform = VER_PLATFORM_WIN32_NT) then
    Exit;
  Result := False;

  // obtain the processes token
  if OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or
    TOKEN_QUERY, hToken) then
  begin
    try
      // Get the locally unique identifier (LUID) .
      if LookupPrivilegeValue(nil, PChar(sPrivilege), TokenPriv.Privileges[0].Luid) then
      begin
        TokenPriv.PrivilegeCount := 1; // one privilege to set

        case bEnabled of
          True: TokenPriv.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
          False: TokenPriv.Privileges[0].Attributes := 0;
        end;

        ReturnLength := 0; // replaces a var parameter
        PrevTokenPriv := TokenPriv;

        // enable or disable the privilege

        AdjustTokenPrivileges(hToken, False, TokenPriv, SizeOf(PrevTokenPriv),
          PrevTokenPriv, ReturnLength);
      end;
    finally
      CloseHandle(hToken);
    end;
  end;
  // test the return value of AdjustTokenPrivileges.
  Result := GetLastError = ERROR_SUCCESS;
  if not Result then
    raise Exception.Create(SysErrorMessage(GetLastError));
end;

function SetFileShortNameW(hFile: THandle; ShortName: PWideChar): longbool; stdcall;
  external 'kernel32.dll' Name 'SetFileShortNameW';
{$ENDIF}

function myGetAnsiFN(wfn: string): string;
{$IFDEF MSWINDOWS}
var
  FullPath: string;
  w, ext, s4: string;
  sa: ansistring;
  h: THandle;
  i: integer;
  //buffer: array[0..MAX_PATH-1] of widechar;

  function my2(w: string; l: integer): string;
  var
    s: ansistring;
    s2: string;
    j, k: integer;
    c: char;
  begin
    Result := '';
    s := UTF8Encode(w);
    s2 := ConvertEncoding(s, EncodingUTF8, GetDefaultTextEncoding);
    s2 := StringReplace(s2, ' ', '', [rfReplaceAll]);
    j := 1;
    while (Length(s2) >= j) and (Length(Result) < l) do
    begin
      c := s2[j];
      k := word(c);
      if k > 128 then
        Result := Result + IntToHex(k, 2)
      else
        Result := Result + c;
      Inc(j);
    end;
    Result := Copy(Result, 1, l);
  end;

begin
  wfn := AnsiDequotedStr(wfn, '"');
  sa := Utf8ToAnsi(wfn);
  Result := AnsiToUtf8(sa);
  if (Result <> '') and (Pos('?', Result) = 0) then
  begin
    if FileExistsUTF8(Result) then
      Exit;
    if DirectoryExistsUTF8(Result) then
      Exit;
  end;
  //s4 := UTF8ToSys(ExtractShortPathNameUTF8(wfn));
  //Result := AnsiToUtf8(s4);
  //SetString(Result, buffer, GetShortPathNameW(pwchar(wfn), buffer, MAX_PATH - 1));
  Result := ExtractShortPathNameUTF8(wfn);
  if (Result <> '') and (Pos('?', Result) = 0) then
  begin
    if FileExistsUTF8(Result) then
      Exit;
    if DirectoryExistsUTF8(Result) then
      Exit;
  end;
  Result := StringReplace(Result, '?', '_', [rfReplaceAll]);
  //если не нашёл, например, отключено в реестре
  // [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem]
  // NtfsDisable8dot3NameCreation = 1
  //то тогда создадим
  FullPath := ExtractFileDir(wfn);
  if (FullPath <> ExtractFileDrive(FullPath)) then
    FullPath := myGetAnsiFN(FullPath);
  FullPath := IncludeTrailingPathDelimiter(FullPath);
  ext := Copy(UTF8Encode(ExtractFileExt(wfn)), 1, 4);
  if Pos('?', ext) > 0 then
    ext := '.ext';
  i := 0;
  repeat
    Inc(i);
    s4 := my2(ExtractFileName(wfn), 7 - Length(IntToStr(i))) + '~';
    w := s4 + IntToStr(i) + ext;
  until (not FileExistsUTF8(FullPath + w) and not DirectoryExistsUTF8(FullPath + w)) or
    (i = 999999);
  if not NTSetPrivilege('SeRestorePrivilege', True) then
  begin
    ShowMessage('cannot get privilege to create short filename');
    //RaiseLastOSError;
    Exit;
  end;
  h := CreateFileW(PWideChar(UTF8Decode(wfn)), GENERIC_ALL, FILE_SHARE_WRITE,
    nil, OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, 0);
  if h = INVALID_HANDLE_VALUE then
    Exit;
  if not SetFileShortNameW(h, PWideChar(UTF8Decode(w))) then
  begin
    //fsutil 8dot3name set 0
    ShowMessage('cannot set short filename to ' + wfn);
    //RaiseLastOSError;
  end;
  CloseHandle(h);
  s4 := UTF8ToSys(ExtractShortPathNameUTF8(wfn));
  Result := AnsiToUtf8(s4);
  if Pos('?', Result) = 0 then
  begin
    if FileExistsUTF8(Result) then
      Exit;
    if DirectoryExistsUTF8(Result) then
      Exit;
  end;
  Result := StringReplace(Result, '?', '_', [rfReplaceAll]);
{$ELSE}
begin
  Result := wfn;
{$ENDIF}
end;

procedure myGetListFromStr(s, sep: string; List: TStrings);
var
  i, j: integer;
  s2: string;
begin
  s2 := s;
  List.Clear;
  i := Pos(sep, s2);
  j := Length(sep);
  while (i > 0) do
  begin
    List.Add(copy(s2, 1, i - 1));
    Delete(s2, 1, i + j - 1);
    i := Pos(sep, s2);
  end;
  if s2 <> '' then
    List.Add(s2);
end;

function myGetOutFN(Dir, Inp, Ext: string): string;
var
  i, j: integer;
  s: string;
begin
  if Dir <> '' then
    s := IncludeTrailingPathDelimiter(myExpandEnv(Dir));
  s := s + ChangeFileExt(ExtractFileName(Inp), '');
  if (Length(s) > 0) and (s[Length(s)] = ')') then
  begin
    i := 1;
    j := 0;
    while i > 0 do
    begin
      i := PosEx('(', s, i + 1);
      if (i > 0) and (i + 1 < Length(s)) then
        j := i;
    end;
    if j > 0 then
    begin
      i := StrToIntDef(Copy(s, j + 1, Length(s) - j - 1), 0);
      if (i > 0) and (i < 1000) then
        s := Copy(s, 1, j - 2);
    end;
  end;
  i := 0;
  Result := s + Ext;
  while FileExistsUTF8(myExpandEnv(Result)) do
  begin
    Inc(i);
    Result := s + ' (' + IntToStr(i) + ')' + Ext;
  end;
end;

function myGetOutFNa(Dir, Inp, Ext: string): string;
begin
  Result := myGetOutFN(myGetAnsiFN(myExpandEnv(Dir)), myGetAnsiFN(Inp), Ext);
end;

function myBetween(var s: string; const s1, s2: string): string;
var
  i, j: integer;
begin
  Result := '';
  i := Pos(s1, s);
  if i > 0 then
  begin
    j := PosEx(s2, s, i + 1);
    if j > 0 then
    begin
      Result := Copy(s, i + Length(s1), j - i - Length(s1));
      Delete(s, 1, j + Length(s2));
    end
    else
    begin
      Result := Copy(s, i + Length(s1), Length(s));
      s := '';
    end;
  end;
end;

procedure myExecProc(Path: string; ComLine: array of string; sw: TShowWindowOptions = swoShowNormal);
var
  p: TProcessUTF8;
  i: integer;
begin
  p := TProcessUTF8.Create(nil);
  p.Executable := Path;
  for i := Low(ComLine) to High(ComLine) do
    p.Parameters.Add(ComLine[i]);
  p.ShowWindow := sw;
  p.Execute;
  p.Free;
end;

procedure myExecProc1(ComLine: string; sw: TShowWindowOptions = swoShowNormal);
var
  p: TProcessUTF8;
begin
  p := TProcessUTF8.Create(nil);
  p.CommandLine := ComLine;
  p.ShowWindow := sw;
  p.Execute;
  p.Free;
end;

procedure myOpenDoc(Path: string);
begin
  if not OpenDocument(Path) then
  {$IFDEF MSWINDOWS}
    myExecProc('cmd.exe', ['/c', 'start', '""', Path], swoshowMinNOActive);
  {$ELSE}
    myExecProc('/usr/bin/xdg-open', [Path], swoShowNormal);
  {$ENDIF}
end;

function myCompareInt(List: TStringList; Index1, Index2: integer): integer;
var
  d1, d2: integer;
  r1, r2: boolean;

  function IsInt(AString: string; var AInteger: integer): boolean;
  var
    Code: integer;
  begin
    Val(AString, AInteger, Code);
    Result := (Code > 1);
    if Result then
      Val(Copy(AString, 1, Code - 1), AInteger, Code);
  end;

begin
  d1 := 0;
  d2 := 0;
  r1 := IsInt(List[Index1], d1);
  r2 := IsInt(List[Index2], d2);
  Result := Ord(r1 or r2);
  if Result <> 0 then
  begin
    if d1 < d2 then
      Result := -1
    else if d1 > d2 then
      Result := 1
    else
      Result := 0;
  end
  else
    //Result := lstrcmp(PChar(List[Index1]), PChar(List[Index2]));
    Result := strcomp(PChar(List[Index1]), PChar(List[Index2]));
end;

function myGetLocaleLanguage: string;
{$IFDEF MSWINDOWS}
  function myGetLocaleInfo(Flag: integer): string;
  var
    pcLCA: array[0..20] of char;
  begin
    if (GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, Flag, pcLCA, 19) <= 0) then
      pcLCA[0] := #0;
    Result := pcLCA;
  end;
begin
  Result := myGetLocaleInfo(LOCALE_SENGLANGUAGE);
{$ELSE}
begin
  Result := Copy(SysUtils.GetEnvironmentVariable('LANG'), 1, 2);
{$ENDIF}
end;

end.
