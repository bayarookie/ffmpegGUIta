unit MediaInfoDll;

{
  MediaInfoLib (MediaInfo.dll v0.7.7.6) Interface for Delphi
    (c)2008 by Norbert Mereg (Icebob)

    http://MediaArea.net/MediaInfo
}

// Defines how the DLL is called (dynamic or static)
//{$DEFINE STATIC}

interface
uses
  dynlibs
{$IFDEF WINDOWS}
  , Windows
{$ENDIF}
  ;

type TMIStreamKind =
(
    Stream_General,
    Stream_Video,
    Stream_Audio,
    Stream_Text,
    Stream_Other,
    Stream_Image,
    Stream_Menu,
    Stream_Max
);

type TMIInfo =
(
    Info_Name,
    Info_Text,
    Info_Measure,
    Info_Options,
    Info_Name_Text,
    Info_Measure_Text,
    Info_Info,
    Info_HowTo,
    Info_Max
);

type TMIInfoOption =
(
    InfoOption_ShowInInform,
    InfoOption_Reserved,
    InfoOption_ShowInSupported,
    InfoOption_TypeOfValue,
    InfoOption_Max
);


{$IFDEF STATIC}
  // Unicode methods
  function  MediaInfo_New(): Cardinal cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll';
  procedure MediaInfo_Delete(Handle: Cardinal) cdecl  {$IFDEF WIN32} stdcall {$ENDIF}; external 'MediaInfo.Dll';
  function  MediaInfo_Open(Handle: Cardinal; File__: PWideChar): Cardinal cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll';
  procedure MediaInfo_Close(Handle: Cardinal) cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll';
  function  MediaInfo_Inform(Handle: Cardinal; Reserved: Integer): PWideChar cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll';
  function  MediaInfo_GetI(Handle: Cardinal; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: Integer; KindOfInfo: TMIInfo): PWideChar cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll'; //Default: KindOfInfo=Info_Text
  function  MediaInfo_Get(Handle: Cardinal; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: PWideChar; KindOfInfo: TMIInfo; KindOfSearch: TMIInfo): PWideChar cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll'; //Default: KindOfInfo=Info_Text, KindOfSearch=Info_Name
  function  MediaInfo_Option(Handle: Cardinal; Option: PWideChar; Value: PWideChar): PWideChar cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll';
  function  MediaInfo_State_Get(Handle: Cardinal): Integer cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll';
  function  MediaInfo_Count_Get(Handle: Cardinal; StreamKind: TMIStreamKind; StreamNumber: Integer): Integer cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll';

  // Ansi methods
  function  MediaInfoA_New(): Cardinal cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll';
  procedure MediaInfoA_Delete(Handle: Cardinal) cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll';
  function  MediaInfoA_Open(Handle: Cardinal; File__: PAnsiChar): Cardinal cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll';
  procedure MediaInfoA_Close(Handle: Cardinal) cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll';
  function  MediaInfoA_Inform(Handle: Cardinal; Reserved: Integer): PAnsiChar cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll';
  function  MediaInfoA_GetI(Handle: Cardinal; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: Integer; KindOfInfo: TMIInfo): PAnsiChar cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll'; //Default: KindOfInfo=Info_Text
  function  MediaInfoA_Get(Handle: Cardinal; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: PAnsiChar; KindOfInfo: TMIInfo; KindOfSearch: TMIInfo): PAnsiChar cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll'; //Default: KindOfInfo=Info_Text, KindOfSearch=Info_Name
  function  MediaInfoA_Option(Handle: Cardinal; Option: PAnsiChar; Value: PAnsiChar): PAnsiChar cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll';
  function  MediaInfoA_State_Get(Handle: Cardinal): Integer cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll';
  function  MediaInfoA_Count_Get(Handle: Cardinal; StreamKind: TMIStreamKind; StreamNumber: Integer): Integer cdecl  {$IFDEF WIN32} stdcall {$ENDIF};external 'MediaInfo.Dll';
{$ELSE}

var
  LibHandle: THandle = 0;

  // Unicode methods
  MediaInfo_New:        function  (): THandle; {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  MediaInfo_Delete:     procedure (Handle: THandle); {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  MediaInfo_Open:       function  (Handle: THandle; File__: PWideChar): Cardinal; {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  MediaInfo_Close:      procedure (Handle: THandle); {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  MediaInfo_Inform:     function  (Handle: THandle; Reserved: Integer): PWideChar; {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  MediaInfo_GetI:       function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: Integer;   KindOfInfo: TMIInfo): PWideChar; {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; //Default: KindOfInfo=Info_Text,
  MediaInfo_Get:        function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: PWideChar; KindOfInfo: TMIInfo; KindOfSearch: TMIInfo): PWideChar; {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; //Default: KindOfInfo=Info_Text, KindOfSearch=Info_Name
  MediaInfo_Option:     function  (Handle: THandle; Option: PWideChar; Value: PWideChar): PWideChar; {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  MediaInfo_State_Get:  function  (Handle: THandle): Integer; {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  MediaInfo_Count_Get:  function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer): Integer; {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF};

  // Ansi methods
  MediaInfoA_New:       function  (): THandle; {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  MediaInfoA_Delete:    procedure (Handle: THandle); {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  MediaInfoA_Open:      function  (Handle: THandle; File__: PAnsiChar): Cardinal; {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  MediaInfoA_Close:     procedure (Handle: THandle); {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  MediaInfoA_Inform:    function  (Handle: THandle; Reserved: Integer): PAnsiChar; {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  MediaInfoA_GetI:      function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: Integer; KindOfInfo: TMIInfo): PAnsiChar; {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; //Default: KindOfInfo=Info_Text
  MediaInfoA_Get:       function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: PAnsiChar;   KindOfInfo: TMIInfo; KindOfSearch: TMIInfo): PAnsiChar; {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; //Default: KindOfInfo=Info_Text, KindOfSearch=Info_Name
  MediaInfoA_Option:    function  (Handle: THandle; Option: PAnsiChar; Value: PAnsiChar): PAnsiChar; {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  MediaInfoA_State_Get: function  (Handle: THandle): Integer; {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  MediaInfoA_Count_Get: function  (Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer): Integer; {$IFDEF WINDOWS}stdcall{$ELSE}cdecl{$ENDIF};

function MediaInfoDLL_Load(LibPath: string): boolean;
function myMI_Open(Handle: THandle; File__: string): Cardinal;
function myMI_Inform(Handle: THandle; Reserved: Integer): string;
function myMI_Get(Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: string; KindOfInfo: TMIInfo; KindOfSearch: TMIInfo): string;

{$ENDIF}

implementation

{$IFNDEF STATIC}
function MI_GetProcAddress(Name: PChar; var Addr: Pointer): boolean;
begin
  Addr := dynlibs.GetProcAddress(LibHandle, Name);
  Result := Addr <> nil;
end;

function MediaInfoDLL_Load(LibPath: string): boolean;
begin
  Result := False;

  if LibHandle = 0 then
    LibHandle := LoadLibrary(PChar(LibPath));

  if LibHandle <> 0 then
  begin
    MI_GetProcAddress('MediaInfo_New',        Pointer(MediaInfo_New));
    MI_GetProcAddress('MediaInfo_Delete',     Pointer(MediaInfo_Delete));
    MI_GetProcAddress('MediaInfo_Open',       Pointer(MediaInfo_Open));
    MI_GetProcAddress('MediaInfo_Close',      Pointer(MediaInfo_Close));
    MI_GetProcAddress('MediaInfo_Inform',     Pointer(MediaInfo_Inform));
    MI_GetProcAddress('MediaInfo_GetI',       Pointer(MediaInfo_GetI));
    MI_GetProcAddress('MediaInfo_Get',        Pointer(MediaInfo_Get));
    MI_GetProcAddress('MediaInfo_Option',     Pointer(MediaInfo_Option));
    MI_GetProcAddress('MediaInfo_State_Get',  Pointer(MediaInfo_State_Get));
    MI_GetProcAddress('MediaInfo_Count_Get',  Pointer(MediaInfo_Count_Get));

    MI_GetProcAddress('MediaInfoA_New',       Pointer(MediaInfoA_New));
    MI_GetProcAddress('MediaInfoA_Delete',    Pointer(MediaInfoA_Delete));
    MI_GetProcAddress('MediaInfoA_Open',      Pointer(MediaInfoA_Open));
    MI_GetProcAddress('MediaInfoA_Close',     Pointer(MediaInfoA_Close));
    MI_GetProcAddress('MediaInfoA_Inform',    Pointer(MediaInfoA_Inform));
    MI_GetProcAddress('MediaInfoA_GetI',      Pointer(MediaInfoA_GetI));
    MI_GetProcAddress('MediaInfoA_Get',       Pointer(MediaInfoA_Get));
    MI_GetProcAddress('MediaInfoA_Option',    Pointer(MediaInfoA_Option));
    MI_GetProcAddress('MediaInfoA_State_Get', Pointer(MediaInfoA_State_Get));
    MI_GetProcAddress('MediaInfoA_Count_Get', Pointer(MediaInfoA_Count_Get));

    Result := True;
  end;
end;

function myMI_Open(Handle: THandle; File__: string): Cardinal;
begin
  {$IFDEF WINDOWS}
  Result := MediaInfo_Open(Handle, PWideChar(UTF8Decode(File__)));
  {$ELSE}
  Result := MediaInfoA_Open(Handle, PAnsiChar(File__));
  {$ENDIF}
end;

function myMI_Inform(Handle: THandle; Reserved: Integer): string;
begin
  {$IFDEF WINDOWS}
  Result := UTF8Encode(WideString(MediaInfo_Inform(Handle, 0)));
  {$ELSE}
  Result := String(MediaInfoA_Inform(Handle, 0));
  {$ENDIF}
end;

function myMI_Get(Handle: THandle; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: string; KindOfInfo: TMIInfo; KindOfSearch: TMIInfo): string;
begin
  {$IFDEF WINDOWS}
  Result := UTF8Encode(WideString(MediaInfo_Get(Handle, StreamKind, StreamNumber,
      PWideChar(UTF8Decode(Parameter)), KindOfInfo, KindOfSearch)));
  {$ELSE}
  Result := String(MediaInfoA_Get(Handle, StreamKind, StreamNumber,
      PAnsiChar(Parameter), KindOfInfo, KindOfSearch));
  {$ENDIF}
end;

{$ENDIF}

end.
