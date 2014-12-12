unit MediaInfoDll;

{
  MediaInfoLib (MediaInfo.dll v0.7.7.6) Interface for Delphi
    (c)2008 by Norbert Mereg (Icebob)

    http://mediainfo.sourceforge.net
}


interface
uses
{$IFDEF WIN32}
  Windows;
{$ELSE}
  Wintypes, WinProcs;
{$ENDIF}

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

type
  // Unicode methods
  TMediaInfo_New=        function  (): Cardinal cdecl stdcall;
  TMediaInfo_Delete=     procedure (Handle: Cardinal) cdecl stdcall;
  TMediaInfo_Open=       function  (Handle: Cardinal; File__: PWideChar): Cardinal cdecl stdcall;
  TMediaInfo_Close=      procedure (Handle: Cardinal) cdecl stdcall;
  TMediaInfo_Inform=     function  (Handle: Cardinal; Reserved: Integer): PWideChar cdecl stdcall;
  TMediaInfo_GetI=       function  (Handle: Cardinal; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: Integer;   KindOfInfo: TMIInfo): PWideChar cdecl stdcall; //Default: KindOfInfo=Info_Text,
  TMediaInfo_Get=        function  (Handle: Cardinal; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: PWideChar; KindOfInfo: TMIInfo; KindOfSearch: TMIInfo): PWideChar cdecl stdcall; //Default: KindOfInfo=Info_Text, KindOfSearch=Info_Name
  TMediaInfo_Option=     function  (Handle: Cardinal; Option: PWideChar; Value: PWideChar): PWideChar cdecl stdcall;
  TMediaInfo_State_Get=  function  (Handle: Cardinal): Integer cdecl stdcall;
  TMediaInfo_Count_Get=  function  (Handle: Cardinal; StreamKind: TMIStreamKind; StreamNumber: Integer): Integer cdecl stdcall;

  // Ansi methods
  TMediaInfoA_New=       function  (): Cardinal cdecl stdcall;
  TMediaInfoA_Delete=    procedure (Handle: Cardinal) cdecl stdcall;
  TMediaInfoA_Open=      function  (Handle: Cardinal; File__: PChar): Cardinal cdecl stdcall;
  TMediaInfoA_Close=     procedure (Handle: Cardinal) cdecl stdcall;
  TMediaInfoA_Inform=    function  (Handle: Cardinal; Reserved: Integer): PChar cdecl stdcall;
  TMediaInfoA_GetI=      function  (Handle: Cardinal; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: Integer; KindOfInfo: TMIInfo): PChar cdecl stdcall; //Default: KindOfInfo=Info_Text
  TMediaInfoA_Get=       function  (Handle: Cardinal; StreamKind: TMIStreamKind; StreamNumber: Integer; Parameter: PChar;   KindOfInfo: TMIInfo; KindOfSearch: TMIInfo): PChar cdecl stdcall; //Default: KindOfInfo=Info_Text, KindOfSearch=Info_Name
  TMediaInfoA_Option=    function  (Handle: Cardinal; Option: PChar; Value: PChar): PChar cdecl stdcall;
  TMediaInfoA_State_Get= function  (Handle: Cardinal): Integer cdecl stdcall;
  TMediaInfoA_Count_Get= function  (Handle: Cardinal; StreamKind: TMIStreamKind; StreamNumber: Integer): Integer cdecl stdcall;

var
  LibHandle: THandle = 0;
  MediaInfo_New: TMediaInfo_New;
  MediaInfo_Open: TMediaInfo_Open;
  MediaInfo_Close: TMediaInfo_Close;
  MediaInfo_Inform: TMediaInfo_Inform;
  MediaInfo_Get: TMediaInfo_Get;

function MediaInfoDLL_Load(LibPath: string): boolean;

implementation

function MediaInfoDLL_Load(LibPath: string): boolean;
begin
  Result := False;
  if LibHandle = 0 then
    LibHandle := LoadLibrary(PChar(LibPath));
  if LibHandle <> 0 then
  begin
    MediaInfo_New := TMediaInfo_New(GetProcAddress(LibHandle, 'MediaInfo_New'));
    MediaInfo_Open := TMediaInfo_Open(GetProcAddress(LibHandle, 'MediaInfo_Open'));
    MediaInfo_Close := TMediaInfo_Close(GetProcAddress(LibHandle, 'MediaInfo_Close'));
    MediaInfo_Inform := TMediaInfo_Inform(GetProcAddress(LibHandle, 'MediaInfo_Inform'));
    MediaInfo_Get := TMediaInfo_Get(GetProcAddress(LibHandle, 'MediaInfo_Get'));
    //MI_GetProcAddress('MediaInfo_Delete',     @MediaInfo_Delete);
    //MI_GetProcAddress('MediaInfo_GetI',       @MediaInfo_GetI);
    //MI_GetProcAddress('MediaInfo_Option',     @MediaInfo_Option);
    //MI_GetProcAddress('MediaInfo_State_Get',  @MediaInfo_State_Get);
    //MI_GetProcAddress('MediaInfo_Count_Get',  @MediaInfo_Count_Get);
    //
    //MI_GetProcAddress('MediaInfoA_New',       @MediaInfoA_New);
    //MI_GetProcAddress('MediaInfoA_Delete',    @MediaInfoA_Delete);
    //MI_GetProcAddress('MediaInfoA_Open',      @MediaInfoA_Open);
    //MI_GetProcAddress('MediaInfoA_Close',     @MediaInfoA_Close);
    //MI_GetProcAddress('MediaInfoA_Inform',    @MediaInfoA_Inform);
    //MI_GetProcAddress('MediaInfoA_GetI',      @MediaInfoA_GetI);
    //MI_GetProcAddress('MediaInfoA_Get',       @MediaInfoA_Get);
    //MI_GetProcAddress('MediaInfoA_Option',    @MediaInfoA_Option);
    //MI_GetProcAddress('MediaInfoA_State_Get', @MediaInfoA_State_Get);
    //MI_GetProcAddress('MediaInfoA_Count_Get', @MediaInfoA_Count_Get);
    Result := True;
  end;
end;

end.
