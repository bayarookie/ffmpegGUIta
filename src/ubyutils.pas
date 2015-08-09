unit ubyUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, strutils, Math,
  {$IFDEF MSWINDOWS}
  Windows, LConvEncoding, Dialogs, Registry,
  {$ENDIF}
  Fileutil, LCLIntf, Process, UTF8Process;

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
{$IFDEF MSWINDOWS}
function myGetOutFNa(Dir, Inp, Ext: string): string;
{$ENDIF}
function myBetween(var s: string; const s1, s2: string): string;
procedure myExecProc(Path: string; ComLine: array of string; sw: TShowWindowOptions = swoShowNormal);
procedure myExecProc1(ComLine: string; sw: TShowWindowOptions = swoShowNormal);
procedure myOpenDoc(Path: string);
function myCompareInt(List: TStringList; Index1, Index2: integer): integer;
function myGetLocaleLanguage: string;
function myDTtoStr(FormatStr: string; DateTime: TDateTime): string;

implementation

uses ufrmGUIta;

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
  if Pos(LowerCase(s), LowerCase(Path)) = 1 then
  {$ELSE}
  e := '$' + Env;
  if Pos(s, Path) = 1 then
  {$ENDIF}
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

//function SetFileShortNameW(hFile: THandle; ShortName: PWideChar): longbool; stdcall;
//  external 'kernel32.dll' Name 'SetFileShortNameW';
type
  TSetFileShortNameW = function(
    hFile: THandle;
    ShortName: PWideChar): BOOL; stdcall;
type
  TCreateSymbolicLinkW = function(
    pwcSymlinkFileName,
    pwcTargetFileName: PWideChar;
    dwFlags: DWORD): BOOL; stdcall;

function myCanCreateDosNam: boolean;
var
  Reg: TRegistry;
  i: integer;
begin
  //HKLM\SYSTEM\CurrentControlSet\Control\FileSystem, NtfsDisable8dot3NameCreation = 1, default = 2
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKeyReadOnly('\SYSTEM\CurrentControlSet\Control\FileSystem') then
      i := Reg.ReadInteger('NtfsDisable8dot3NameCreation');
    Reg.CloseKey;
  except
    on E: Exception do
      frmGUIta.myError(-1, E.Message);
  end;
  Reg.Free;
  if i = 1 then
    frmGUIta.myError(1, 'Short filename creating are disabled: '
    + 'HKLM\SYSTEM\CurrentControlSet\Control\FileSystem\NtfsDisable8dot3NameCreation = ' + IntToStr(i));
  Result := i <> 1;
end;

function myGenDosNam1(f: string; l: integer): string;
var
  s: string;
  j, k: integer;
  c: char;
begin
  Result := '';
  s := StringReplace(f, ' ', '', [rfReplaceAll]);
  j := 1;
  while (Length(s) >= j) and (Length(Result) < l) do
  begin
    c := s[j];
    k := word(c);
    if k > 127 then
      Result := Result + IntToHex(k, 2)
    else
      Result := Result + c;
    Inc(j);
  end;
  Result := Copy(Result, 1, l);
end;

function myGenDosName(f: string): string;
var
  FullPath, ext, w: string;
  i: integer;
begin
  FullPath := ExtractFilePath(f);
  ext := myGenDosNam1(ExtractFileExt(f), 4);
  i := 0;
  repeat
    Inc(i);
    w := myGenDosNam1(ExtractFileNameOnly(f), 7 - Length(IntToStr(i))) + '~' + IntToStr(i) + ext;
  until (not FileExistsUTF8(FullPath + w) and not DirectoryExistsUTF8(FullPath + w))
  or (i = 999999);
  Result := FullPath + w;
end;

function mySetFileShortName(wfn: string): boolean;
var
  w: string;
  h, f: THandle;
  SetFileShortNameW: TSetFileShortNameW;
begin
  if not myCanCreateDosNam then Exit;
  if not NTSetPrivilege('SeRestorePrivilege', True) then
  begin
    frmGUIta.myError(2, 'Cannot get privilege to create short filename for ' + wfn);
    Exit;
  end;
  h := GetModuleHandle('kernel32.dll');
  if h = 0 then
  begin
    frmGUIta.myError(3, 'Can not load library "kernel32.dll"');
    Exit;
  end;
  SetFileShortNameW := TSetFileShortNameW(GetProcAddress(h, 'SetFileShortNameW'));
  if not Assigned(SetFileShortNameW) then
  begin
    frmGUIta.myError(4, 'Can not get function address for "SetFileShortNameW"');
    Exit;
  end;
  f := CreateFileW(PWideChar(UTF8Decode(wfn)), GENERIC_ALL, FILE_SHARE_WRITE,
    nil, OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, 0);
  if f = INVALID_HANDLE_VALUE then
    frmGUIta.myError(5, 'Create short filename. Cannot get handle for: '
    + wfn + ', maybe nave no rights. Copy file or create symlink.')
  else
  begin
    //generate 8.3 name, it needs to be improved
    w := ExtractFileName(myGenDosName(wfn));
    Result := SetFileShortNameW(f, PWideChar(UTF8Decode(w)));
    if not Result then
      frmGUIta.myError(6, 'Cannot set short filename: ' + w + ' ' + wfn + ' -> Copy file or create symlink.');
  end;
  CloseHandle(f);
end;

function myGenSymLnkNam(linkdir, target: string): string;
var
  w, ext: string;
  i: integer;
begin
  if myCanCreateDosNam then
  begin
    w := ExtractFileName(target);
  end
  else
  begin
    ext := myGenDosNam1(ExtractFileExt(target), 4);
    i := 0;
    repeat
      Inc(i);
      w := myGenDosNam1(ExtractFileNameOnly(target), 7 - Length(IntToStr(i))) + '~' + IntToStr(i) + ext;
      //if FileExistsUTF8(linkdir + w) then
      //begin
      //  if link.target = target
      //end
      //else
        i := 999999;
    until (i = 999999);
  end;
  Result := linkdir + w;
end;

function myCreateSymLink(link, target: string): boolean;
var
  h: THandle;
  CreateSymbolicLinkW: TCreateSymbolicLinkW;
begin
  Result := FileExistsUTF8(link);
  if Result then Exit; //or delete?
  h := GetModuleHandle('kernel32.dll');
  if h = 0 then
  begin
    frmGUIta.myError(7, 'Can not load library "kernel32.dll"');
    Exit;
  end;
  CreateSymbolicLinkW := TCreateSymbolicLinkW(GetProcAddress(h, 'CreateSymbolicLinkW'));
  if not Assigned(CreateSymbolicLinkW) then
  begin
    frmGUIta.myError(8, 'Can not get function address for "CreateSymbolicLinkW"');
    Exit;
  end;
  if FileExistsUTF8(target) then
    Result := CreateSymbolicLinkW(PWideChar(UTF8Decode(link)), PWideChar(UTF8Decode(target)), 0);
end;

function myCheckAnsi(s: string): boolean;
var
  a: ansistring;
  w: string;
begin
  a := Utf8ToAnsi(s);
  w := AnsiToUtf8(a);
  Result := (w > '') and (Pos('?', w) = 0) and (FileExistsUTF8(w) or DirectoryExistsUTF8(w));
end;

function myGet127FN(wfn: string): string;
var
  s, FullPath: string;
  i: integer;
  c: char;
begin
  FullPath := ExtractFileDir(wfn);
  if (FullPath <> ExtractFileDrive(FullPath)+'\') then
    FullPath := myGet127FN(FullPath);
  Result := ExtractShortPathNameUTF8(wfn);
  s := ExtractFileName(Result);
  if s = '' then
  begin
    if frmGUIta.chkCreateDosFN.Checked and mySetFileShortName(wfn) then
      Result := ExtractShortPathNameUTF8(wfn);
  end
  else
  for i := 1 to Length(s) do
  begin
    c := s[i];
    if (word(c) > 127) then //error of oem ansi converting
    begin
      if frmGUIta.chkCreateDosFN.Checked and mySetFileShortName(wfn) then
        Result := ExtractShortPathNameUTF8(wfn);
      Break;
    end;
  end;
end;

function myGetAnsiFN(wfn: string): string;
begin
  Result := wfn;
  //if Pos('?', wfn) > 0 then
  if not (FileExistsUTF8(wfn) or DirectoryExistsUTF8(wfn)) then
  begin
    frmGUIta.myError(9, 'incorrect filename? - ' + wfn);
    Exit;
  end;
  //ffmpeg tickets: #4697 https://trac.ffmpeg.org/ticket/4697 and #819 https://trac.ffmpeg.org/ticket/819
  if Pos(LowerCase(ExtractFileExt(wfn)), '.jpg .jpeg') = 0 then
  begin
    //ansi chars?
    if myCheckAnsi(Result) then Exit;
    //non ansi chars
    Result := ExtractShortPathNameUTF8(wfn);
    if myCheckAnsi(Result) then Exit;
  end;
  //something is wrong, trying to get 8.3 name
  Result := myGet127FN(wfn);
  if myCheckAnsi(Result) then Exit;
  //maybe, network drive with no msdos file system
  //create symlink to network file and return as result
  if frmGUIta.chkCreateSymLink.Checked then
  begin
    Result := myGenSymLnkNam(myExpandEnv('%TEMP%\'), wfn);
    if myCreateSymLink(Result, wfn) then
    begin
      Result := ExtractShortPathNameUTF8(Result);
      if myCheckAnsi(Result) then Exit;
    end;
  end;
  //surrender
{$ELSE}
function myGetAnsiFN(wfn: string): string;
begin
{$ENDIF}
  Result := wfn;
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

{$IFDEF MSWINDOWS}
function myGetOutFNa(Dir, Inp, Ext: string): string;
begin
  Result := myGetOutFN(myGetAnsiFN(myExpandEnv(Dir)), Inp, Ext);
end;
{$ENDIF}

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

function myDTtoStr(FormatStr: string; DateTime: TDateTime): string;
begin
  DateTimeToString(Result, FormatStr, DateTime);
end;

end.
