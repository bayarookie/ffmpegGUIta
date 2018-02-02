unit ufrmGUIta;
{
component's property Tag
0 = default, normal component
1 = readonly, dont save to profile
2 = filters, depends from chkFilterComplex.Checked
3 = output filename, dont save to profile
4 = x264 x265
5 = metadata: title, language
}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, StdCtrls, IniFiles, LclIntf, Process, UTF8Process, LConvEncoding,
  SynMemo, synhighlighterunixshellscript, StrUtils, types, Math,
  Spin, Buttons, IntfGraphics, LCLType, Menus, fpImage, Masks,
  LazFileUtils, LazUTF8, CheckBoxThemed, ListFilterEdit, ListViewFilterEdit,
  {$IFDEF MSWINDOWS}
  Windows, Registry, shlobj, mediainfodll,
  {$ELSE}
  clipbrd, ColorBox, Grids, ShellCtrls,
  {$ENDIF}
  ucalcul, ufrmcompare, ujobinfo, urun, utaversion, UniqueInstance2, cpucount,
  uthreadconv, uthreadtest, uthreadaddf, uthreadexec, ufrmmaskprof;

type

  { TfrmGUIta }

  TfrmGUIta = class(TForm)
    btnCompare: TButton;
    btnAddFiles: TButton;
    btnAddFilesAsAvs1: TButton;
    btnAddFilesAsAvs2: TButton;
    btnFindDirOut: TBitBtn;
    btnFindDirTmp: TBitBtn;
    btnFindExtPlayer: TBitBtn;
    btnFindffmpeg: TBitBtn;
    btnFindffplay: TBitBtn;
    btnFindffprobe: TBitBtn;
    btnFindMediaInfo: TBitBtn;
    btnFindOfn: TBitBtn;
    btnLanguage: TButton;
    btnMaskAdd: TButton;
    btnMaskDel: TButton;
    btnMaskEdit: TButton;
    btnMaskReset: TButton;
    btnMediaInfo1: TButton;
    btnMediaInfo2: TButton;
    btnPlayOut: TButton;
    btnProfileSaveAs: TButton;
    btnCmdRun: TButton;
    btnLogSave: TButton;
    btnLogClear: TButton;
    btnPlayIn: TButton;
    btnReset: TButton;
    btnSaveSets: TButton;
    btnTest: TButton;
    btnStop: TButton;
    btnStart: TButton;
    btnSuspend: TButton;
    btnAddTracks: TButton;
    btnCrop: TButton;
    btnAddFileSplit: TButton;
    btnAddScreenGrab: TButton;
    btnAddTrack1: TButton;
    chkCreateDosFN: TCheckBox;
    chkCreateSymLink: TCheckBox;
    chkffplayfs: TCheckBox;
    chkSGmixaudio: TCheckBox;
    chkSGmixvideo: TCheckBox;
    chk1instance: TCheckBox;
    chkAddTracks: TCheckBox;
    chkDebug: TCheckBox;
    chkDirOutStruct: TCheckBox;
    chkLangA1: TCheckBox;
    chkLangA2: TCheckBox;
    chkLangS1: TCheckBox;
    chkLangS2: TCheckBox;
    chkMetadataGet: TCheckBox;
    chkPlayer2: TCheckBox;
    chkPlayer3: TCheckBox;
    chkPlayInTerm: TCheckBox;
    chkSaveFormPos: TCheckBox;
    chkMetadataWork: TCheckBox;
    chkSaveOnExit: TCheckBox;
    chkSGsource1: TCheckBox;
    chkSGsource2: TCheckBox;
    chkSGsource3: TCheckBox;
    chkSGsource0: TCheckBox;
    chkStopIfError: TCheckBox;
    chkSynColor: TCheckBox;
    chkUseMasks: TCheckBox;
    chkMetadataClear: TCheckBox;
    chkUseEditedCmd: TCheckBox;
    chkConcat: TCheckBox;
    chkFilterComplex: TCheckBox;
    chkRunInMem: TCheckBox;
    chkRunInTerm: TCheckBox;
    chkOEM: TCheckBox;
    chkx264Pass1fast: TCheckBox;
    chkxterm1str: TCheckBox;
    chkxtermconv: TCheckBox;
    cmbAddOptsS: TComboBox;
    cmbAddOptsI: TComboBox;
    cmbAddOptsO: TComboBox;
    cmbAddOptsA: TComboBox;
    cmbAddTracks: TComboBox;
    cmbBitrateA: TComboBox;
    cmbBitrateV: TComboBox;
    cmbChannels: TComboBox;
    cmbDirLast: TComboBox;
    cmbDurationss1: TComboBox;
    cmbDurationss2: TComboBox;
    cmbDurationt1: TComboBox;
    cmbExtPlayer: TComboBox;
    cmbFont: TComboBox;
    cmbhqdn3d: TComboBox;
    cmbLangA: TComboBox;
    cmbLangS: TComboBox;
    cmbLangsList: TComboBox;
    cmbLanguage: TComboBox;
    cmbSGsource1: TComboBox;
    cmbSGsource2: TComboBox;
    cmbSGsource3: TComboBox;
    cmbSGsource0: TComboBox;
    cmbTagLangA: TComboBox;
    cmbTagLangS: TComboBox;
    cmbSetDAR: TComboBox;
    cmbEncoderA: TComboBox;
    cmbEncoderS: TComboBox;
    cmbEncoderV: TComboBox;
    cmbExt: TComboBox;
    cmbFiltersA: TComboBox;
    cmbFiltersV: TComboBox;
    cmbFormat: TComboBox;
    cmbProfile: TComboBox;
    cmbCrop: TComboBox;
    cmbPad: TComboBox;
    cmbPass: TComboBox;
    cmbRotate: TComboBox;
    cmbRunCmd: TComboBox;
    cmbScale: TComboBox;
    cmbSRate: TComboBox;
    cmbTagTitleV: TComboBox;
    cmbTagTitleA: TComboBox;
    cmbTagTitleS: TComboBox;
    cmbTestDurationss: TComboBox;
    cmbTestDurationt: TComboBox;
    cmbx264preset: TComboBox;
    cmbx264tune: TComboBox;
    cmbDurationt2: TComboBox;
    cmbAddOptsV: TComboBox;
    cmbFilterComplex: TComboBox;
    cmbTagTitleOut: TComboBox;
    cmbTagLangV: TComboBox;
    cmbSGfiltercomplex: TComboBox;
    cmbSGaddoptsO: TComboBox;
    cmbSGoutput: TComboBox;
    cmbSGoutext: TComboBox;
    cmbProfileDef: TComboBox;
    edtBitrateA: TLabeledEdit;
    edtDirOut: TComboBox;
    edtDirTmp: TComboBox;
    edtffmpeg: TComboBox;
    edtffplay: TComboBox;
    edtffprobe: TComboBox;
    edtFileExts: TComboBox;
    edtMediaInfo: TComboBox;
    edtOfn: TLabeledEdit;
    edtxterm: TComboBox;
    edtxtermopts: TComboBox;
    edtBitrateV: TLabeledEdit;
    edtOfna: TLabeledEdit;
    lblSGoutput: TLabel;
    lblSGaddoptsO: TLabel;
    lblSGfiltercomplex: TLabel;
    lblCpuCount: TLabel;
    lblDirLast: TLabel;
    lblDirOut: TLabel;
    lblDirTmp: TLabel;
    lblffmpeg: TLabel;
    lblffplay: TLabel;
    lblffprobe: TLabel;
    lblMediaInfo: TLabel;
    lblTagLangV: TLabel;
    lblAddOptsS: TLabel;
    lblAddOptsV: TLabel;
    lblAddOptsA: TLabel;
    lblTagLangA: TLabel;
    lblTagLangS: TLabel;
    lblTagTitleOut: TLabel;
    lblAddOptsI: TLabel;
    lblDurationss1: TLabel;
    lblDurationss2: TLabel;
    lblDurationt1: TLabel;
    lblDurationt2: TLabel;
    lblAddOptsO: TLabel;
    lblBitrateA: TLabel;
    lblBitrateV: TLabel;
    lblChannels: TLabel;
    lblDenoise: TLabel;
    lblDAR: TLabel;
    lblEncoderA: TLabel;
    lblEncoderS: TLabel;
    lblEncoderv: TLabel;
    lblExt: TLabel;
    lblFiltersA: TLabel;
    lblFiltersV: TLabel;
    lblFormat: TLabel;
    lblkoefA: TLabel;
    lblkoefV: TLabel;
    lblProfile: TLabel;
    lblCrop: TLabel;
    lblPad: TLabel;
    lblPass: TLabel;
    lblRotate: TLabel;
    lblScale: TLabel;
    lblSRate: TLabel;
    lblTagTitleV: TLabel;
    lblTagTitleA: TLabel;
    lblTagTitleS: TLabel;
    lblTestStartDurationTime: TLabel;
    lblx264preset: TLabel;
    lblx264tune: TLabel;
    lblxterm: TLabel;
    lblxtermopts: TLabel;
    LVtrd: TListView;
    LVfiles: TListView;
    LVjobs: TListView;
    LVmasks: TListView;
    LVstreams: TListView;
    memCmdlines: TMemo;
    mnuMediainfo1: TMenuItem;
    mnuDeleteJob: TMenuItem;
    mnuDeleteFile: TMenuItem;
    mnuPasteFiles: TMenuItem;
    mnuCheck: TMenuItem;
    mnuPasteTracks: TMenuItem;
    mnuView: TMenuItem;
    mnuOpen: TMenuItem;
    mnuCopyAsAvs: TMenuItem;
    mnuEditAvs: TMenuItem;
    mnuPasteAsAvs2: TMenuItem;
    mnuPasteAsAvs1: TMenuItem;
    mnuPaste: TMenuItem;
    PageControl1: TPageControl;
    PageControl3: TPageControl;
    PageControl2: TPageControl;
    PageControl4: TPageControl;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel66: TPanel;
    Panel67: TPanel;
    Panel68: TPanel;
    pnlOutSize: TPanel;
    PanelMasks: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    Panel2: TPanel;
    Panel20: TPanel;
    Panel21: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
    Panel24: TPanel;
    Panel25: TPanel;
    Panel26: TPanel;
    Panel27: TPanel;
    Panel28: TPanel;
    Panel29: TPanel;
    Panel3: TPanel;
    Panel30: TPanel;
    Panel31: TPanel;
    Panel32: TPanel;
    Panel33: TPanel;
    Panel34: TPanel;
    Panel35: TPanel;
    Panel36: TPanel;
    Panel37: TPanel;
    Panel38: TPanel;
    Panel39: TPanel;
    Panel4: TPanel;
    Panel40: TPanel;
    Panel41: TPanel;
    Panel42: TPanel;
    Panel43: TPanel;
    Panel44: TPanel;
    Panel45: TPanel;
    Panel46: TPanel;
    Panel47: TPanel;
    Panel48: TPanel;
    Panel49: TPanel;
    Panel50: TPanel;
    Panel51: TPanel;
    Panel52: TPanel;
    Panel53: TPanel;
    Panel54: TPanel;
    Panel55: TPanel;
    Panel56: TPanel;
    Panel57: TPanel;
    Panel58: TPanel;
    Panel59: TPanel;
    Panel6: TPanel;
    Panel60: TPanel;
    Panel61: TPanel;
    Panel62: TPanel;
    Panel63: TPanel;
    Panel64: TPanel;
    Panel65: TPanel;
    Panel7: TPanel;
    PanelPathes: TPanel;
    Panel9: TPanel;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    PopupMenu3: TPopupMenu;
    Splitter1: TSplitter;
    spnCpuCount: TSpinEdit;
    spnKoefA: TSpinEdit;
    spnKoefV: TSpinEdit;
    StatusBar1: TStatusBar;
    memJournal: TSynMemo;
    SynMemo2: TSynMemo;
    SynMemo4: TSynMemo;
    SynMemo5: TSynMemo;
    SynMemo6: TSynMemo;
    SynUNIXShellScriptSyn1: TSynUNIXShellScriptSyn;
    TabJournal: TTabSheet;
    TabConsole: TTabSheet;
    TabConsole1: TTabSheet;
    TabConvJob: TTabSheet;
    TabOutput: TTabSheet;
    TabContRows: TTabSheet;
    TabConsole3: TTabSheet;
    TabConsole4: TTabSheet;
    TabCmdline: TTabSheet;
    TabInput: TTabSheet;
    TabSets: TTabSheet;
    TabSets1: TTabSheet;
    TabSets2: TTabSheet;
    TabScreenGrab: TTabSheet;
    TabVideo: TTabSheet;
    TabAudio: TTabSheet;
    TabSubtitle: TTabSheet;
    procedure btnAddFilesClick(Sender: TObject);
    procedure btnAddScreenGrabClick(Sender: TObject);
    procedure btnAddTrack1Click(Sender: TObject);
    procedure btnCompareClick(Sender: TObject);
    procedure btnCmdRunClick(Sender: TObject);
    procedure btnCropClick(Sender: TObject);
    procedure btnFindDirOutClick(Sender: TObject);
    procedure btnFindExtPlayerClick(Sender: TObject);
    procedure btnFindffmpegClick(Sender: TObject);
    procedure btnFindffplayClick(Sender: TObject);
    procedure btnFindffprobeClick(Sender: TObject);
    procedure btnFindMediaInfoClick(Sender: TObject);
    procedure btnFindDirTmpClick(Sender: TObject);
    procedure btnLanguageClick(Sender: TObject);
    procedure btnLogClearClick(Sender: TObject);
    procedure btnLogSaveClick(Sender: TObject);
    procedure btnMaskAddClick(Sender: TObject);
    procedure btnMaskDelClick(Sender: TObject);
    procedure btnMaskEditClick(Sender: TObject);
    procedure btnMaskResetClick(Sender: TObject);
    procedure btnMediaInfo1Click(Sender: TObject);
    procedure btnFindOfnClick(Sender: TObject);
    procedure btnPlayInClick(Sender: TObject);
    procedure btnPlayOutClick(Sender: TObject);
    procedure btnProfileSaveAsClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnSaveSetsClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnSuspendClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure chk1instanceChange(Sender: TObject);
    procedure chkAddTracksChange(Sender: TObject);
    procedure chkFilterComplexChange(Sender: TObject);
    procedure chkLangA1Change(Sender: TObject);
    procedure chkLangA2Change(Sender: TObject);
    procedure chkLangS1Change(Sender: TObject);
    procedure chkLangS2Change(Sender: TObject);
    procedure chkPlayer2Change(Sender: TObject);
    procedure chkPlayer3Change(Sender: TObject);
    procedure chkSGmixvideoChange(Sender: TObject);
    procedure chkSynColorChange(Sender: TObject);
    procedure chkMetadataWorkChange(Sender: TObject);
    procedure chkUseEditedCmdChange(Sender: TObject);
    procedure chkUseMasksChange(Sender: TObject);
    procedure cmbBitrateAChange(Sender: TObject);
    procedure cmbBitrateVChange(Sender: TObject);
    procedure cmbEncoderVChange(Sender: TObject);
    procedure cmbExtChange(Sender: TObject);
    procedure cmbExtGetItems(Sender: TObject);
    procedure cmbExtPlayerChange(Sender: TObject);
    procedure cmbExtPlayerGetItems(Sender: TObject);
    procedure cmbExtSelect(Sender: TObject);
    procedure cmbFontGetItems(Sender: TObject);
    procedure cmbFontSelect(Sender: TObject);
    procedure cmbFormatChange(Sender: TObject);
    procedure cmbFormatGetItems(Sender: TObject);
    procedure cmbFormatSelect(Sender: TObject);
    procedure cmbLanguageChange(Sender: TObject);
    procedure cmbLanguageGetItems(Sender: TObject);
    procedure cmbProfileChange(Sender: TObject);
    procedure cmbProfileDefChange(Sender: TObject);
    procedure cmbProfileGetItems(Sender: TObject);
    procedure cmbRunCmdGetItems(Sender: TObject);
    procedure cmbSGsource0GetItems(Sender: TObject);
    procedure cmbSGsource2GetItems(Sender: TObject);
    procedure edtDirOutChange(Sender: TObject);
    procedure edtffmpegGetItems(Sender: TObject);
    procedure edtOfnChange(Sender: TObject);
    procedure edtxtermGetItems(Sender: TObject);
    procedure edtxtermSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormDropFiles(Sender: TObject; const FileNames: array of string);
    procedure FormShow(Sender: TObject);
    procedure LVfilesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure LVjobsClick(Sender: TObject);
    procedure LVjobsContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: boolean);
    procedure LVjobsCustomDrawSubItem(Sender: TCustomListView; Item: TListItem;
      SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure LVjobsDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure LVjobsDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure LVjobsItemChecked(Sender: TObject; Item: TListItem);
    procedure LVjobsKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure LVjobsSelectItem(Sender: TObject; Item: TListItem;
      Selected: boolean);
    procedure LVmasksCustomDrawSubItem(Sender: TCustomListView;
      Item: TListItem; SubItem: Integer; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure LVstreamsClick(Sender: TObject);
    procedure LVstreamsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LVstreamsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LVstreamsItemChecked(Sender: TObject; Item: TListItem);
    procedure LVstreamsSelectItem(Sender: TObject; Item: TListItem;
      Selected: boolean);
    procedure mnuCheckClick(Sender: TObject);
    procedure mnuCopyAsAvsClick(Sender: TObject);
    procedure mnuDeleteFileClick(Sender: TObject);
    procedure mnuDeleteJobClick(Sender: TObject);
    procedure mnuEditAvsClick(Sender: TObject);
    procedure mnuOpenClick(Sender: TObject);
    procedure mnuPasteClick(Sender: TObject);
    procedure onCnv3Terminate(Sender: TObject);
    procedure ontAutoStart(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure TabCmdlineShow(Sender: TObject);
    procedure TabContRowsShow(Sender: TObject);
    procedure TabSets1Show(Sender: TObject);
    procedure TabVideoShow(Sender: TObject);
    procedure UniqueInstance1OtherInstance(Sender: TObject;
      ParamCount: Integer; const Parameters: array of String);
    procedure xmyChange0(Sender: TObject);
    procedure xmyChange0o(Sender: TObject);
    procedure xmyChange1i(Sender: TObject);
    procedure xmyChange2(Sender: TObject);
    procedure xmyChange2c(Sender: TObject); //if not in combobox.items then red
    procedure xmyChange2v(Sender: TObject);
    procedure xmyChange2a(Sender: TObject);
    procedure xmyChange2o(Sender: TObject);
    procedure xmyCheckDir(Sender: TObject);
    procedure xmyCheckFile(Sender: TObject);
    procedure xmySelDir(Sender: TObject);
    procedure xmySelFile(Sender: TObject);
  private
    { private declarations }
    procedure myAddFile1(di, fn, ss, t, o: string);
    procedure myAddFiles(params: TStrings);
    {$IFDEF MSWINDOWS}
    procedure myAddFilesAsAVS1(fns: TStrings);
    procedure myAddFilesAsAVS2(fns: TStrings);
    function myGetAvs(fn: string): string;
    {$ENDIF}
    procedure myAddFileSplit(files: TStrings);
    procedure myAddFilesPlus(li: TListItem; files: TStrings);
    procedure myAddFileStart;
    procedure myFindFiles(dir, exe: string; c: TComboBox; bSet2: boolean = True);
    procedure myFindPlayers(bSet2: boolean);
    function myGetFileList(const Path, Mask: string; List: TStrings;
      subdir: boolean = False; fullpath: boolean = True): boolean;
    function myGetSimilarFiles(fn: string; List: TStrings): boolean;
    procedure myDisComp;
    function myGetCaptionCont(p: TCont): string;
    procedure myGetWH(v: TCont; var w, h: integer);
    procedure myGetWHXYcrop(v: TCont; var w, h, x, y: integer);
    procedure myGetWHXYscale(v: TCont; var w, h: integer);
    procedure myGetWHXY(s: string; var w, h, x, y: string);
    function myValInt(f, v: string): integer;
    function myDirExists(dir, mes: string): boolean;
    procedure myFillEnc;
    procedure myFillFmt;
    //procedure myFillx264Tune;
    function myCantUpd(i: integer = 0): boolean;
    function myAutoCrop(jo: TJob; l, k: integer): string;
    procedure myGetClipboardFileNames(files: TStrings; test: boolean = False);
    function myWindowColorIsDark: boolean;
    function myGetExts: string;
    procedure myDefaultSave;
    procedure myDefaultLoad;
    procedure myToIni(Ini: TIniFile; s1, s2, s3: string; t: Integer = 0);
    procedure mySets1(Ini: TIniFile; s: string; c: array of TComponent; bRead: boolean); //enabled and not tag in 1,3
    procedure mySets4(Ini: TIniFile; bRead: boolean);
    procedure mySets(bRead: boolean);
    procedure myFormPosLoad(Form: TForm; Ini: TIniFile);
    procedure myFormPosSave(Form: TForm; Ini: TIniFile);
    procedure myLanguage(bRead: boolean; bDefault: boolean = False);
    procedure myGetTerminal;
    function myGetUserDir(dir: string): string;
    procedure myChkCpuCount;
  public
    { public declarations }
    procedure myError(i: integer; s: string);
    function myExpandFN(fn: string; dir: boolean = False): string;
    function myUnExpandFN(fn: string): string;
    function myGetRunOut(run: TRun; mem: TSynMemo): integer;
    function myGetFilter(jo: TJob; v: TCont; all: boolean = True): string;
    procedure myGetRunFromJo(jo: TJob; var run: TRun; mode: integer);
    function myGetPic(ss, fn, fv: string; sm: TSynMemo; st: TStatusBar): string;
    function myStrReplace(s: string; jo: TJob = nil): string;
    function myValFPS(a: array of string): extended;
    function myGetFPS(jo: TJob; stream: string): extended;
    procedure myAdd2cmb(c: TComboBox; s: string; add: boolean = True);
    procedure myGetss4Compare(jo: TJob; rs: double = 0; rt: double = 0);
    procedure myGetCaptions(jo: TJob; var v, a, s: string);
    {$IFDEF MSWINDOWS}
    function myGetMediaInfo(fn, par: string; sk: TMIStreamKind = Stream_Video;
      sn: integer = 0): string;
    {$ENDIF}
    function myCalcOutSize(jo: TJob): string;
    function myCalcBRv(v: TCont): string;
    function myCalcBRa(a: TCont): string;
    procedure myGetFileStreamNums(s: string; var l, k: integer);
    function myGetProfile(fn: string): string;
    function myGetLngFromFNs(jo: TJob; l: integer): string;
    function myQuoteStr(Str: string): string;
    function myGetStr(a: array of string): string;
    function myGetStr(a: TStrings): string;
    function myGetStr(a: TStringList): string;
    procedure myShowCaption(s: string);
    procedure myFillSGin(si: TStrings; ct: string);
    procedure myFillJo(jo: TJob; p: string);
  end;

const
  iMaxMask: integer = 31;

var
  frmGUIta: TfrmGUIta;
  sCap, sDirApp, sInidir, sInifile, sLngfile: string;
  fs: TFormatSettings;
  mes: array [0..42] of string;
  tAutoStart: TTimer;
  bUpdFromCode: boolean;
  sdiv: string = '--------------------------------------------------------------------------------';
  DuraAll: double;
  DuraAl2: integer;
  DuraJob: string;
  Files2Add: TList;
  Counter: integer;
  myUnik: TUniqueInstance;
  cDefaultSets: TCont; //default settings,
  cCmdIni: TCont;
  iTabCount: integer;
  sMyDTformat: string = 'yyyy-mm-dd hh:nn:ss';
  sMyFilename: string = 'my_filename'; //input source filename
  {$IFDEF MSWINDOWS}
  sMyDOSfname: string = 'my_dosfname'; //input source msdos 8.3 filename
  {$ENDIF}
  sMyBakfname: string = 'my_bakfname'; //backup filename for generating filenames with counter: "output filename (1).ext"
  sMyffprobe: string = 'my_ffprobe';   //0 - get streams info, 1 - do not get
  sMyCompleted: string = 'my_Completed';//0 - job added, 1 - completed, 2 - in progress, 3 - error
  sMyChecked: string = 'my_Checked';   //0 - do not convert, 1 - in queue
  cStatusB: array [0..3] of TColor = (clBlue, clGreen, clYellow, clRed);
  cStatusC: array [0..3] of TColor = (clYellow, clWhite, clBlue, clWhite);

implementation

uses ubyUtils, ufrmsplash, ufrmcrop, ufrmtrack;

{$R *.lfm}

procedure TfrmGUIta.myToIni(Ini: TIniFile; s1, s2, s3: string; t: Integer = 0);
begin
  if (t <> 1) and ((cDefaultSets.getval(s2) = s3) or (s3 = '')) then
    Ini.DeleteKey(s1, s2)
  else if Ini.ReadString(s1, s2, '') <> s3 then
    Ini.WriteString(s1, s2, s3);
end;

procedure TfrmGUIta.mySets1(Ini: TIniFile; s: string; c: array of TComponent; bRead: boolean);
var
  k, i: integer;
begin
  for k := Low(c) to High(c) do
    if TWinControl(c[k]).Enabled and not (TWinControl(c[k]).Tag in [1, 3]) then
      if c[k] is TLabeledEdit then
        with TLabeledEdit(c[k]) do
          if bRead then
          begin
            if not ReadOnly then
              Text := Ini.ReadString(s, Name, Text);
          end
          else
          begin
            if not ReadOnly then
              myToIni(Ini, s, Name, Text, Tag);
          end
      else if c[k] is TComboBox then
        with TComboBox(c[k]) do
          if bRead then
          begin
            if ReadOnly then
              ItemIndex := StrToIntDef(Ini.ReadString(s, Name, '-1'), -1)
            else
              Text := Ini.ReadString(s, Name, Text);
          end
          else
          begin
            if ReadOnly then
            begin
              if (ItemIndex >= 0) and (ItemIndex < Items.Count - 1) then //cmbRotate
                myToIni(Ini, s, Name, IntToStr(ItemIndex))
              else
                myToIni(Ini, s, Name, '');
            end
            else
              myToIni(Ini, s, Name, Text);
          end
      else if c[k] is TSpinEdit then
        with TSpinEdit(c[k]) do
          if bRead then
            Value := Ini.ReadInteger(s, Name, Value)
          else
          begin
            if Enabled then
              myToIni(Ini, s, Name, Text)
          end
      else if c[k] is TCheckBox then
        with TCheckBox(c[k]) do
          if bRead then
            Checked := Ini.ReadBool(s, Name, Checked)
          else
            myToIni(Ini, s, Name, IfThen(Checked, '1', '0'))
      else if c[k] is TPanel then
        for i := 0 to TPanel(c[k]).ControlCount - 1 do
          mySets1(Ini, s, [TPanel(c[k]).Controls[i]], bRead)
      else if c[k] is TTabSheet then
        for i := 0 to TTabSheet(c[k]).ControlCount - 1 do
          mySets1(Ini, s, [TTabSheet(c[k]).Controls[i]], bRead)
      //else if c[k] is TScrollBox then
      //  for i := 0 to TScrollBox(c[k]).ControlCount - 1 do
      //    mySets1(Ini, s, [TScrollBox(c[k]).Controls[i]], bRead)
end;

procedure TfrmGUIta.mySets4(Ini: TIniFile; bRead: boolean);
var
  i: integer;
  SL: TStringList;
begin
  if bRead then
  begin
    SL := TStringList.Create;
    Ini.ReadSection(cmbRunCmd.Name, SL);
    for i := 0 to SL.Count - 1 do
      cCmdIni.setval(Ini.ReadString(cmbRunCmd.Name, SL[i], ''), '0');
    SL.Free;
  end
  else for i := 0 to High(cCmdIni.sk) do
    myToIni(Ini, cmbRunCmd.Name, IntToStr(i), cCmdIni.sk[i]);
end;

procedure TfrmGUIta.mySets(bRead: boolean);
var
  Ini: TIniFile;
  s: string;
  i: integer;
  li: TListItem;
begin
  if not FileExistsUTF8(sInifile) and bRead then
    Exit;
  bUpdFromCode := True;
  Ini := TIniFile.Create(UTF8ToSys(sInifile));
  s := 'Main';
  mySets1(Ini, s, [TabSets1, TabSets2, TabScreenGrab], bRead);
  //if not chkUseMasks.Checked then
  //  mySets1(Ini, s, [cmbProfile], bRead);
  mySets4(Ini, bRead);
  if bRead then
  begin
    myFormPosLoad(frmGUIta, Ini);
    i := 0;
    while Ini.ReadString('Masks', IntToStr(i) + 'Checked', '') <> '' do
    begin
      li := LVmasks.Items.Add;
      li.Checked := Ini.ReadString('Masks', IntToStr(i) + 'Checked', '') = '1';
      li.Caption := Ini.ReadString('Masks', IntToStr(i) + 'Prefix', '');
      li.SubItems.Add(Ini.ReadString('Masks', IntToStr(i) + 'Extens', ''));
      li.SubItems.Add(Ini.ReadString('Masks', IntToStr(i) + 'Profile', ''));
      inc(i);
    end;
  end
  else
  begin
    myFormPosSave(frmGUIta, Ini);
    for i := 0 to iMaxMask do
    begin
      if i < LVmasks.Items.Count then
      begin
        myToIni(Ini, 'Masks', IntToStr(i) + 'Checked', IfThen(LVmasks.Items[i].Checked, '1', '0'));
        myToIni(Ini, 'Masks', IntToStr(i) + 'Prefix', LVmasks.Items[i].Caption);
        myToIni(Ini, 'Masks', IntToStr(i) + 'Extens', LVmasks.Items[i].SubItems[0]);
        myToIni(Ini, 'Masks', IntToStr(i) + 'Profile', LVmasks.Items[i].SubItems[1]);
      end
      else
      begin
        myToIni(Ini, 'Masks', IntToStr(i) + 'Checked', '');
        myToIni(Ini, 'Masks', IntToStr(i) + 'Prefix', '');
        myToIni(Ini, 'Masks', IntToStr(i) + 'Extens', '');
        myToIni(Ini, 'Masks', IntToStr(i) + 'Profile', '');
      end;
    end;
  end;
  Ini.Free;
  bUpdFromCode := False;
end;

procedure mySet2(Sender: TObject; s: string);
begin
  if (Sender is TComboBox) then
  begin
    if TComboBox(Sender).ReadOnly then
      TComboBox(Sender).ItemIndex := StrToIntDef(s, -1)
    else
      TComboBox(Sender).Text := s;
  end
  else if (Sender is TLabeledEdit) then
    TLabeledEdit(Sender).Text := s
  else if (Sender is TMemo) then
    TMemo(Sender).Text := s
  else if (Sender is TCheckBox) then
    TCheckBox(Sender).Checked := (s = '1')
  else if (Sender is TSpinEdit) then
    TSpinEdit(Sender).Text := s;
end;

function myGet2(Sender: TObject): string;
begin
  if (Sender is TComboBox) then
  begin
    if TComboBox(Sender).ReadOnly then
      Result := IntToStr(TComboBox(Sender).ItemIndex)
    else
      Result := TComboBox(Sender).Text;
  end
  else if (Sender is TLabeledEdit) then
    Result := TLabeledEdit(Sender).Text
  else if (Sender is TMemo) then
    Result := TMemo(Sender).Text
  else if (Sender is TCheckBox) then
    Result := IfThen(TCheckBox(Sender).Checked, '1', '0')
  else if (Sender is TSpinEdit) then
    Result := TSpinEdit(Sender).Text
  else
    Result := '';
end;

procedure myGetValsFromCont(t: TTabSheet; v: TCont);
var
  i: integer;
begin
  for i := 0 to t.ControlCount - 1 do
    mySet2(t.Controls[i], v.getval(t.Controls[i].Name));
end;

procedure myClear2(ts: array of TTabSheet);
var
  i, j: integer;
begin
  for j := Low(ts) to High(ts) do
    for i := 0 to TTabSheet(ts[j]).ControlCount - 1 do
      mySet2(TTabSheet(ts[j]).Controls[i], '');
end;

{ TfrmGUIta }

procedure TfrmGUIta.myAddFile1(di, fn, ss, t, o: string);
var
  jo: TJob;
  i, j: integer;
  s, p: string;
  sl: TStringList;
  Ini: TIniFile;
begin
  jo := TJob.Create;
  Inc(Counter);
  jo.setval(sMyCompleted, '0');
  s := myGetProfile(ExtractFileName(fn));
  jo.setval(cmbProfile.Name, s);
  {$IFDEF MSWINDOWS}
  s := myGetAnsiFN(AppendPathDelim(sInidir) + s);
  {$ELSE}
  s := AppendPathDelim(sInidir) + s;
  {$ENDIF}
  Ini := TIniFile.Create(UTF8ToSys(s));
  sl := TStringList.Create;
  Ini.ReadSection('1', sl);
  for i := 0 to sl.Count - 1 do
    jo.setval(sl[i], Ini.ReadString('1', sl[i], ''));
  sl.Free;
  Ini.Free;
  if o <> '' then
    s := o
  else if Trim(edtDirOut.Text) <> '' then
    s := Trim(edtDirOut.Text)
  else
    s := ExtractFilePath(fn);
  if chkDirOutStruct.Checked then
  begin
    p := ExtractFilePath(fn);
    s := AppendPathDelim(s) + Copy(p, Length(di) + 1, Length(p));
  end;
  jo.setval(edtOfn.Name, myGetOutFN(s, fn, jo.getval(cmbExt.Name)));
  jo.setval(cmbDurationt2.Name, t); //if add file splitted
  i := jo.AddFile(fn);
  jo.f[i].setval(cmbDurationss1.Name, ss); //if add file splitted
  {$IFDEF MSWINDOWS}
  jo.setval(edtOfna.Name, myGetOutFNa(s, jo.f[0].getval(sMyDOSfname), jo.getval(cmbExt.Name)));
  {$ENDIF}
  jo.setval(sMyBakfname, ExtractFileName(fn));
  if chkAddTracks.Checked then
  begin
    sl := TStringList.Create;
    if myGetSimilarFiles(fn, sl) then
    for j := 0 to sl.Count - 1 do
    begin
      i := jo.AddFile(sl[j]);
      jo.f[i].setval(cmbDurationss1.Name, ss); //if add file splitted
    end;
    sl.Free;
  end;
  Files2Add.Add(Pointer(jo));
end;

procedure TfrmGUIta.myAddFiles(params: TStrings);
var
  i, j: integer;
  s, t, o: string;
  ST: TStringList;
begin
  o := '';
  for i := 0 to params.Count - 1 do
  begin
    s := params[i];
    if DirectoryExistsUTF8(s) then
    begin
      ST := TStringList.Create;
      if myGetFileList(s, myGetExts, ST, True) then
      begin
        ST.Sort;
        for j := 0 to ST.Count - 1 do
          myAddFile1(ExtractFilePath(s), ST[j], '', '', o);
      end;
      ST.Free;
    end
    else if (s[1] = '-') {$IFDEF MSWINDOWS}or (s[1] = '/'){$ENDIF} then
    begin
      t := Copy(LowerCase(s), 2, Length(s));
      if (t = 'start') then
      begin
        if tAutoStart = nil then
          tAutoStart := TTimer.Create(Self);
        tAutoStart.Enabled := False;
        tAutoStart.Interval := 5000;
        tAutoStart.OnTimer := @ontAutoStart;
        tAutoStart.Enabled := True;
      end
      else if (Copy(t, 1, 2) = 'o:') then
      begin
        o := Copy(s, 4, Length(s));
        {$IFDEF MSWINDOWS}
        if (Length(o) > 0) and (o[1] = '"') then
            o := Copy(o, 2, Length(o) - 2);
        {$ENDIF}
      end
      else if (Copy(t, 1, 2) = 'p:') then
      begin
        chkUseMasks.Checked := False;
        cmbProfileDef.Text := Copy(s, 4, Length(s));
      end
      else if (t = 'p') then
        chkUseMasks.Checked := False
      else if (t = 'm') then
        chkUseMasks.Checked := True
      else if (t = 'h') then
        ShowMessage(StringReplace(mes[2], '\n', #13, [rfReplaceAll]))
      else
        myAddFile1(ExtractFilePath(s), s, '', '', o);
    end
    else
      myAddFile1(ExtractFilePath(s), s, '', '', o);
  end;
  myAddFileStart;
end;

{$IFDEF MSWINDOWS}
procedure TfrmGUIta.myAddFilesAsAVS1(fns: TStrings);
var
  s, fn, tmp: string;
  SL, ST: TStringList;
  i: integer;
begin
  tmp := myStrReplace('$dirtmp');
  if not myDirExists(tmp, mes[9]) then
    Exit;
  SL := TStringList.Create;
  ST := TStringList.Create;
  for i := 0 to fns.Count - 1 do
  begin
    SL.Text := UTF8ToSys(myGetAvs(fns[i]));
    s := myGetOutFN(tmp, ExtractFileName(myGetAnsiFN(fns[i])), '.avs');
    fn := myGetOutFN(tmp, ExtractFileName(fns[i]), '.avs');
    SL.SaveToFile(UTF8ToSys(s));
    RenameFileUTF8(UTF8ToSys(s), fn);
    SL.Clear;
    ST.Add(fn);
  end;
  SL.Free;
  myAddFiles(ST);
  ST.Free;
end;

procedure TfrmGUIta.myAddFilesAsAVS2(fns: TStrings);
var
  s, fn, tmp: string;
  SL: TStringList;
  i: integer;
begin
  tmp := myStrReplace('$dirtmp');
  if not myDirExists(tmp, mes[9]) then
    Exit;
  SL := TStringList.Create;
  for i := 0 to fns.Count - 1 do
  begin
    s := UTF8ToSys(myGetAvs(fns[i]));
    if (i < fns.Count - 1) then
      s := s + ' + \';
    SL.Add(s);
  end;
  s := myGetOutFN(tmp, ExtractFileName(myGetAnsiFN(fns[0])), '.avs');
  fn := myGetOutFN(tmp, ExtractFileName(fns[0]), '.avs');
  SL.SaveToFile(UTF8ToSys(s));
  RenameFileUTF8(UTF8ToSys(s), fn);
  SL.Text := fn;
  myAddFiles(SL);
  SL.Free;
end;

function TfrmGUIta.myGetAvs(fn: string): string;
var
  sp, sf, tc, se, fps, vc: string;
  reg: TRegistry;
begin
  sf := myGetAnsiFN(fn);
  tc := ExtractFileName(sf) + '.txt';
  se := LowerCase(ExtractFileExt(sf));
  fps := '25'; //myGetMediaInfo(sf, 'FrameRate');
  if se = '.avi' then
    Result := 'AviSource("' + sf + '")'
  else if se = '.wmv' then
    Result := 'DirectShowSource("' + sf + '", fps=' + fps + ', convertfps=true)'
  else if (Pos(se, '.mkv;.mp4;.m2ts;.evo') > 0) then
  begin
    Result := 'DirectShowSource("' + sf + '", convertfps=true)';
    vc := myGetMediaInfo(sf, 'Format');
    if vc = 'AVC' then
    begin
      sp := '';
      reg := TRegistry.Create;
      try
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        if Reg.OpenKeyReadOnly('\SOFTWARE\AviSynth') then
          sp := AppendPathDelim(Reg.ReadString('plugindir2_5'));
        Reg.CloseKey;
      except
        on E: Exception do
          ShowMessage(E.Message);
      end;
      reg.Free;
      if FileExistsUTF8(sp + 'ffms2.dll') then
      begin
        //Result := 'audio = FFAudioSource("' + sf + '", 1) # or track#2, or #3, etc'#13#10 +
        //  'video = FFVideoSource("' + sf + '")'#13#10 +
        //  'AudioDub(video, audio)'#13#10;
        Result := 'FFmpegSource2("' + sf + '", vtrack = -1, atrack = -1, timecodes="' +
          tc + '")';
      end
      else if FileExistsUTF8(sp + 'DGAVCDecode.dll') then
      begin
        Result := '# raw video demuxed from M2TS (Blu-ray BDAV MPEG-2 transport streams)'#13#10 + 'LoadPlugin("' + sp + 'DGAVCDecode.dll")'#13#10 +
          'AVCSource("D:\track1.dga") #http://avisynth.org/mediawiki/FAQ_loading_clips';
      end;
    end;
  end
  else
    Result := 'DirectShowSource("' + sf + '")';
end;
{$ENDIF}

procedure TfrmGUIta.myAddFileSplit(files: TStrings);
var
  i: integer;
  j, k, r: double;
  run: TRun;
  s, d: string;
begin
  s := '4:00';
  if not InputQuery(mes[25], mes[26], s) then
    Exit;
  r := myTimeStrToReal(s);
  if r = 0 then
  begin
    memJournal.Lines.Add('myAddFileSplit: ' + mes[6] + ' - ' + mes[37]); //Error - divide by zero
    Exit;
  end;
  for i := 0 to files.Count - 1 do
  begin
    run:= TRun.Create;
    run.add(myStrReplace('$ffprobe'), ['-hide_banner', '-show_format', files[i]]);
    myGetRunOut(run, SynMemo2);
    run.Free;
    d := SynMemo2.Text;
    d := myBetween(d, 'Duration: ', ',');
    j := myTimeStrToReal(d);
    {$IFDEF MSWINDOWS}
    if (j = 0) and FileExistsUTF8(myExpandFN(edtMediaInfo.Text)) then
    begin
      d := myGetMediaInfo(s, 'Duration', Stream_General);
      j := StrToFloatDef(d, 1) / 1000;
    end;
    {$ENDIF}
    k := 0;
    while k < j do
    begin
      myAddFile1(ExtractFilePath(files[i]), files[i], myRealToTimeStr(k, False), myRealToTimeStr(r, False), '');
      k := k + r;
    end;
  end;
  myAddFileStart;
end;

procedure TfrmGUIta.myAddFilesPlus(li: TListItem; files: TStrings);
var
  jo: TJob;
  j: integer;
begin
  jo := TJob(li.Data);
  for j := 0 to files.Count - 1 do
    jo.AddFile(files[j]);
  jo.setval('index', IntToStr(li.Index));
  Files2Add.Add(Pointer(jo));
  myAddFileStart;
end;

procedure TfrmGUIta.myAddFileStart;
var
  h: TThreadAddF;
  li: TListItem;
begin
  h := TThreadAddF.Create(True);
  if Assigned(h.FatalException) then
    raise h.FatalException;
  h.OnTerminate := @onCnv3Terminate;
  h.Start;
  li := LVtrd.Items.Add;
  li.Caption := 'a';
  li.SubItems.Add(mes[40]); //add files
  li.Data := Pointer(h);
  if chkDebug.Checked then
    PageControl3.ActivePage := TabConsole4;
end;

function TfrmGUIta.myGetFilter(jo: TJob; v: TCont; all: boolean = True): string;
var
  i: integer;

  function my0(s: string): string;
  var
    i: integer;
    c, d: string;
  begin
    Result := '';
    d := '';
    for i := 1 to Length(s) do
    begin
      c := s[i];
      if (c = ',') and (d <>'\') then
        Result := Result + '\,'
      else
        Result := Result + c;
      d := c;
    end;
  end;

  procedure my1(c: TComboBox);
  var
    t, n: string;
  begin
    t := v.getval(c.Name);
    n := LowerCase(Copy(c.Name, 4, Length(c.Name)));
    if t <> '' then
      Result := IfThen(Result <> '', Result + ',') + n + '=' + my0(t);
  end;

  procedure my2(r: string);
  var
    p, q, b: string;
    i, j: integer;
  begin
    if r = '' then
      Exit;
    r := my0(r);
    i := High(jo.f);
    while i > -2 do
    begin
      if i < 0 then //for backward compatibility
      begin
        q := '''$input''';
        b := '$input';
        j := 0;
      end
      else
      begin
        q := '''$inpu' + IntToStr(i) + '''';
        b := '$inpu' + IntToStr(i);
        j := i;
      end;
      if (Pos(q, r) > 0) or (Pos(b, r) > 0) then
      begin
        {$IFDEF MSWINDOWS}
        p := jo.f[j].getval(sMyDOSfname);
        {$ELSE}
        p := jo.f[j].getval(sMyFilename);
        {$ENDIF}
        p := StringReplace(p, '\', '/', [rfReplaceAll]);
        p := StringReplace(p, ',', '\,', [rfReplaceAll]);
        p := StringReplace(p, ':', '\\\:', [rfReplaceAll]);
        p := StringReplace(p, '[', '\[', [rfReplaceAll]);
        p := StringReplace(p, ']', '\]', [rfReplaceAll]);
        p := StringReplace(p, '(', '\(', [rfReplaceAll]);
        p := StringReplace(p, ')', '\)', [rfReplaceAll]);
        p := StringReplace(p, '''', '\\\''', [rfReplaceAll]);
        if (Pos(q, r) > 0) then
          r := StringReplace(r, q, p, [rfReplaceAll])
        else
          r := StringReplace(r, b, p, [rfReplaceAll]);
      end;
      dec(i);
    end;
    Result := IfThen(Result <> '', Result + ',') + r;
  end;

begin
  Result := '';
  my1(cmbCrop);
  my1(cmbScale);
  my1(cmbPad);
  if all then
    my1(cmbhqdn3d);
  i := StrToIntDef(v.getval(cmbRotate.Name), 7);
  if i in [0..6] then
    Result := IfThen(Result <> '', Result + ',');
  case i of
    0..3: Result := Result + 'transpose=' + IntToStr(i);
    4: Result := Result + 'hflip';
    5: Result := Result + 'vflip';
    6: Result := Result + 'hflip, vflip';
    7: ;
    else
      if chkDebug.Checked then
        memJournal.Lines.Add('rotate not in range: ' + IntToStr(i));
  end;
  my1(cmbSetDAR);
  my2(v.getval(cmbFiltersV.Name));
  my2(v.getval(cmbFiltersA.Name));
end;

procedure TfrmGUIta.myGetRunFromJo(jo: TJob; var run: TRun; mode: integer);
var
  i, k, l, cf, cv, ca, cs, ct, cd: integer;
  fl: TFil;
  c: TCont;
  si, fi: TStringList;
  rd,
  rsi, rso, rst, rti, rto, rtt: double;
  ssi, sso, sst, sti, sto, stt,
  s, co, ty, fc2, fn, fb, ni, vi, au, su, ma,
  so, tmp, f1p, sp1, sp2, fn1, fn2, fno, fnoa: string;
  bfi: boolean;

  procedure my1v;
  begin
    Inc(cv);
    co := c.getval(cmbEncoderV.Name);
    if co <> '' then
    begin
      ni := IntToStr(cv);
      vi := vi + ' -c:v:' + ni + ' ' + co;
      if (co <> 'copy') then
      begin
        if not bfi then
        begin
          s := myGetFilter(jo, c);
          if s <> '' then
          begin
            fi.add('-filter:v:' + ni);
            fi.add(s);
          end;
        end;
        s := c.getval(cmbBitrateV.Name);
        if s <> '' then
        begin
          s := c.getval(edtBitrateV.Name);
          vi := vi + IfThen(s <> '', ' -b:v:' + ni + ' ' + s);
        end;
        if (co = 'libx264') or (co = 'libx264rgb') or (co = 'libx265') then
        begin
          s := c.getval(cmbx264preset.Name);
          vi := vi + IfThen(s <> '', ' -preset:v:' + ni + ' ' + s);
          s := c.getval(cmbx264tune.Name);
          vi := vi + IfThen(s <> '', ' -tune:v:' + ni + ' ' + s);
          if (c.getval(chkx264Pass1fast.Name) = '1') then
            f1p := ' -fastfirstpass:v:' + ni + ' 1'
          else
            f1p := ' -fastfirstpass:v:' + ni + ' 0';
        end;
        if (c.getval(cmbPass.Name) = '2') and (mode <> 2) then
        begin
          tmp := myStrReplace('$dirtmp');
          if tmp <> '' then
          begin
            if not myDirExists(tmp, '') then
              Exit;
            tmp := AppendPathDelim(tmp);
          end;
          s := ' -passlogfile:v:' + ni + ' ' + myQuoteStr(tmp + 'ff-tmp' + jo.getval('index') + ni);
          sp1 := sp1 + ' -pass:v:' + ni + ' 1' + s + f1p;
          sp2 := sp2 + ' -pass:v:' + ni + ' 2' + s;
        end;
        s := c.getval(cmbAddOptsV.Name);
        vi := vi + IfThen(s <> '', ' ' + s);
        //title
        if jo.getval(chkMetadataWork.Name) = '1' then
        if jo.getval(chkMetadataClear.Name) <> '1' then
        begin
          s := c.getval(cmbTagTitleV.Name);
          if (s <> '') then
            so := so + ' -metadata:s:v:' + ni + ' title="' + s + '"'
          else if ((s = '') and (c.getval('TAG:title') <> '')) then
            so := so + ' -metadata:s:v:' + ni + ' title=';
          s := c.getval(cmbTagLangV.Name);
          if (s <> '') then
            so := so + ' -metadata:s:v:' + ni + ' language="' + s + '"'
          else if ((s = '') and (c.getval('TAG:language') <> '')) then
            so := so + ' -metadata:s:v:' + ni + ' language=';
        end;
      end;
    end
    else
      vi := vi + ' ';
  end;

  procedure my1a;
  begin
    Inc(ca);
    co := c.getval(cmbEncoderA.Name);
    if co <> '' then
    begin
      ni := IntToStr(ca);
      au := au + ' -c:a:' + ni + ' ' + co;
      if (co <> 'copy') then
      begin
        if not bfi then
        begin
          s := myGetFilter(jo, c);
          if s <> '' then
          begin
            fi.add('-filter:a:' + ni);
            fi.add(s);
          end;
        end;
        s := c.getval(cmbBitrateA.Name);
        if s <> '' then
        begin
          s := c.getval(edtBitrateA.Name);
          au := au + IfThen(s <> '', ' -b:a:' + ni + ' ' + s);
        end;
        s := c.getval(cmbSRate.Name);
        au := au + IfThen(s <> '', ' -ar:a:' + ni + ' ' + s);
        s := c.getval(cmbChannels.Name);
        au := au + IfThen(s <> '', ' -ac:a:' + ni + ' ' + s);
        s := c.getval(cmbAddOptsA.Name);
        au := au + IfThen(s <> '', ' ' + s);
        //title
        if jo.getval(chkMetadataWork.Name) = '1' then
        if jo.getval(chkMetadataClear.Name) <> '1' then
        begin
          s := c.getval(cmbTagTitleA.Name);
          if (s <> '') then
            so := so + ' -metadata:s:a:' + ni + ' title="' + s + '"'
          else if ((s = '') and (c.getval('TAG:title') <> '')) then
            so := so + ' -metadata:s:a:' + ni + ' title=';
          s := c.getval(cmbTagLangA.Name);
          if (s <> '') then
            so := so + ' -metadata:s:a:' + ni + ' language="' + s + '"'
          else if ((s = '') and (c.getval('TAG:language') <> '')) then
            so := so + ' -metadata:s:a:' + ni + ' language=';
        end;
      end;
    end
    else
      au := au + ' ';
  end;

  procedure my1s;
  begin
    Inc(cs);
    co := c.getval(cmbEncoderS.Name);
    if co <> '' then
    begin
      ni := IntToStr(cs);
      su := su + ' -c:s:' + ni + ' ' + co;
      if (co <> 'copy') then
      begin
        s := c.getval(cmbAddOptsS.Name);
        su := su + IfThen(s <> '', ' ' + s);
        //title
        if jo.getval(chkMetadataWork.Name) = '1' then
        if jo.getval(chkMetadataClear.Name) <> '1' then
        begin
          s := c.getval(cmbTagTitleS.Name);
          if (s <> '') then
            so := so + ' -metadata:s:s:' + ni + ' title="' + s + '"'
          else if ((s = '') and (c.getval('TAG:title') <> '')) then
            so := so + ' -metadata:s:s:' + ni + ' title=';
          s := c.getval(cmbTagLangS.Name);
          if (s <> '') then
            so := so + ' -metadata:s:s:' + ni + ' language="' + s + '"'
          else if ((s = '') and (c.getval('TAG:language') <> '')) then
            so := so + ' -metadata:s:s:' + ni + ' language=';
        end;
      end;
    end
    else
      su := su + ' ';
  end;

  procedure my1t;
  begin
    Inc(ct);
    co := 'copy';
    ni := IntToStr(ct);
    su := su + ' -c:t:' + ni + ' ' + co;
  end;

  procedure my1d;
  begin
    Inc(cd);
    co := 'copy';
    ni := IntToStr(cd);
    su := su + ' -c:d:' + ni + ' ' + co;
  end;

  procedure my2(s, outfn: string);
  var
    sl: TStringList;
  begin
    if chkxtermconv.Checked then
    begin
      l := run.add(edtxterm.Text, []);
      sl := TStringList.Create;
      process.CommandToList(edtxtermopts.Text, sl);
      run.p[l].Parameters.AddStrings(sl);
      sl.Free;
      if chkxterm1str.Checked then
      begin
        run.p[l].Parameters.Add(myQuoteStr(myStrReplace('$ffmpeg'))
        + ' ' + myGetStr(si) + myGetStr(fi) + s + ' ' + myQuoteStr(outfn));
        Exit;
      end;
    end
    else
      l := run.add(myStrReplace('$ffmpeg'), []);
    run.p[l].Parameters.AddStrings(si);
    run.p[l].Parameters.AddStrings(fi);
    sl := TStringList.Create;
    process.CommandToList(s, sl);
    run.p[l].Parameters.AddStrings(sl);
    sl.Free;
    run.p[l].Parameters.Add(outfn);
  end;

begin
  //mode, 0 = convert, 1 = test, 2 = play, 3 = show cmdline
  if (jo.getval(chkUseEditedCmd.Name) = '1') and (mode = 0) then
  begin
    si := TStringList.Create;
    si.Text := jo.getval(memCmdlines.Name);
    for i := 0 to si.Count - 1 do
      run.add(si[i]);
    si.Free;
    Exit;
  end;
  // -ss input, output, test
  ssi := '';
  sso := jo.getval(cmbDurationss2.Name);
  sst := IfThen(mode = 1, Trim(cmbTestDurationss.Text));
  // -t input, output, test
  sti := '';
  sto := jo.getval(cmbDurationt2.Name);
  stt := IfThen(mode = 1, Trim(cmbTestDurationt.Text));
  // calc time range for test
  rd := myTimeStrToReal(jo.f[0].getval('duration'));
  rso := myTimeStrToReal(sso);
  rto := myTimeStrToReal(sto);
  if mode = 1 then
  begin
    rst := myTimeStrToReal(sst);
    rtt := myTimeStrToReal(stt);
    if (rd > 0) and (rd < rtt) then
      rtt := rd;
    if rst > (rd - rtt) then
      rst := rd - rtt;
    sst := IfThen(rst <> 0, myRealToTimeStr(rst));
    stt := IfThen(rtt <> 0, myRealToTimeStr(rtt));
    myGetss4Compare(jo, rst, rtt);
  end;
  // init vars
  fc2 := '';
  vi := '';
  au := '';
  su := '';
  sp1 := '';
  sp2 := '';
  ma := '';
  so := '';
  cf := 0;
  cv := -1;
  ca := -1;
  cs := -1;
  ct := -1;
  cd := -1;
  fn := '';
  fb := '-';
  si := TStringList.Create; //inputs
  fi := TStringList.Create; //filters
  // input params
  for l := 0 to High(jo.f) do
  begin
    fl := jo.f[l];
    ssi := fl.getval(cmbDurationss1.Name);
    if (mode = 1) and (rso = 0) then
    begin
      rsi := myTimeStrToReal(ssi);
      if (rsi < rst) then
        ssi := sst;
    end;
    if ssi <> '' then begin si.add('-ss'); si.add(ssi); end;
    sti := fl.getval(cmbDurationt1.Name);
    if (mode = 1) and (rto = 0) then
    begin
      rti := myTimeStrToReal(sti);
      if (rti = 0) or (rti > rtt) then
        sti := stt;
    end;
    if sti <> '' then begin si.add('-t'); si.add(sti); end;
    s := fl.getval(cmbAddOptsI.Name);
    if s <> '' then process.CommandToList(s, si);
    {$IFDEF MSWINDOWS}
    s := fl.getval(sMyDOSfname);
    {$ELSE}
    s := fl.getval(sMyFilename);
    {$ENDIF}
    if LowerCase(ExtractFileExt(s)) = '.vob' then
    begin
      si.add('-analyzeduration');
      si.add('100M');
      si.add('-probesize');
      si.add('100M');
    end;
    si.add('-i');
    si.add(s);
  end;
  bfi := (jo.getval(chkFilterComplex.Name) = '1')
      or (jo.getval(chkConcat.Name) = '1');
  // --- if concat ---
  if (jo.getval(chkConcat.Name) = '1') then
  begin
    fi.add('-filter_complex');
    for l := 0 to High(jo.f) do
    for k := 0 to High(jo.f[l].s) do
    begin
      c := jo.f[l].s[k];
      if c.getval('Checked') = '1' then
      begin
        fn := IntToStr(l);
        ni := IntToStr(k);
        if fn <> fb then
          Inc(cf);
        fb := fn;
        ty := c.getval('codec_type');
        if ty = 'video' then
        begin
          fi.add('[' + fn + ':' + ni + ']');
          if fn = '0' then
          begin
            s := '[v' + ni + ']';
            fc2 := fc2 + ' ' + s;
            ma := ma + ' -map "' + s + '"';
            my1v;
          end;
        end
        else if ty = 'audio' then
        begin
          fi.add('[' + fn + ':' + ni + ']');
          if fn = '0' then
          begin
            s := '[a' + ni + ']';
            fc2 := fc2 + ' ' + s;
            ma := ma + ' -map "' + s + '"';
            my1a;
          end;
        end;
      end;
    end;
    fi.add('concat=n=' + IntToStr(cf) + ':v=' + IntToStr(cv + 1) +
      ':a=' + IntToStr(ca + 1));
    process.CommandToList(fc2, fi);
  end
  else
  // --- mix mux ---
  begin
    if (jo.getval(chkFilterComplex.Name) = '1') then
    begin
      s := jo.getval(cmbFilterComplex.Name);
      fi.add('-filter_complex');
      fi.add(s);
    end;
    // map and params for every track
    for i := 0 to High(jo.m) do
    begin
      myGetFileStreamNums(jo.m[i], l, k);
      c := jo.f[l].s[k];
      if c.getval('Checked') = '1' then
      begin
        ma := ma + ' -map ' + IntToStr(l) + ':' + IntToStr(k);
        ty := c.getval('codec_type');
        if ty = 'video' then
          my1v
        else if ty = 'audio' then
          my1a
        else if ty = 'subtitle' then
          my1s
        else if ty = 'attachment' then
          my1t
        else if ty = 'data' then
          my1d;
      end;
    end;
  end;
  if vi = '' then vi := ' -vn'; //no video
  if au = '' then au := ' -an'; //no audio
  if su = '' then su := ' -sn'; //no subtitle
  // metadata
  if jo.getval(chkMetadataWork.Name) = '1' then
  begin
    if jo.getval(chkMetadataClear.Name) <> '1' then
    begin
      s := jo.getval(cmbTagTitleOut.Name);
      if (s <> '') then
        so := so + ' -metadata title="' + s + '"'
      else if ((s = '') and (jo.f[0].getval('TAG:title') <> '')) then
        so := so + ' -metadata title=';
    end
    else
      so := so + ' -map_metadata -1';
  end;
  // time
  if mode = 1 then
  begin
    if (rso > 0) and (rso < rst) then
      sso := sst;
    if (rto = 0) or (rto > rtt) and (rtt > 0) then
      sto := stt;
  end;
  so := so + IfThen(sso <> '', ' -ss ' + sso) + IfThen(sto <> '', ' -t ' + sto);
  // additional options
  s := jo.getval(cmbAddOptsO.Name);
  so := so + IfThen(s <> '', ' ' + s);
  // format
  s := jo.getval(cmbFormat.Name);
  so := so + IfThen(s <> '', ' -f ' + s);
  so := so + ' -y';
  // output filename
  fno := jo.getval(edtOfn.Name);
  if (fno <> '') and (mode <> 2) then
  begin
    if not DirectoryExistsUTF8(ExtractFileDir(fno)) then
    begin
      if not ForceDirectoriesUTF8(ExtractFileDir(fno)) then
        myError(-1, mes[10] + ': ' + ExtractFileDir(fno));
    end;
    if FileExistsUTF8(fno) and (mode <> 3) then
    begin
      fno := myGetOutFN(ExtractFilePath(fno), jo.getval(sMyBakfname),  ExtractFileExt(fno));
      jo.setval(edtOfn.Name, fno);
    end;
    {$IFDEF MSWINDOWS}
    fnoa := jo.getval(edtOfna.Name); //short filename
    if FileExistsUTF8(fnoa) and (mode <> 3) then
    begin
      fnoa := myGetOutFNa(ExtractFilePath(fnoa), jo.f[0].getval(sMyDOSfname), ExtractFileExt(fnoa));
      jo.setval(edtOfna.Name, fnoa);
    end;
    fn1 := 'NUL';
    {$ELSE}
    fnoa := fno;
    fn1 := '/dev/null';
    {$ENDIF}
    fn2 := fnoa;
  end
  else
  begin
    fn1 := '-';
    fn2 := '-'; //if (mode=2) - play through pipe - ffmpeg -i input -f format - | ffplay -
  end;
  // final
  if Pos('-map', so) > 0 then ma := '';
  if (sp1 <> '') and (mode <> 2) then
  begin
    s := vi + au + su + ma + sp1 + so; //1st pass
    my2(s, fn1);
  end;
  s := vi + au + su + ma + sp2 + so;  //2nd pass or 1 pass
  my2(s, fn2);
end;

function TfrmGUIta.myGetRunOut(run: TRun; mem: TSynMemo): integer;
var
  Buffer, t, fStatus: string;
  BytesAvailable: DWord;
  BytesRead: longint;
  i, j, l: integer;
  pr: TProcessUTF8;
begin
  mem.Clear;
  for l := 0 to High(run.p) do
  begin
    Result := -1;
    pr := run.p[l];
    try
      t := pr.Executable + ' ' + myGetStr(pr.Parameters);
      if chkDebug.Checked then
        memJournal.Lines.Add(t);
      mem.Lines.Add(t);
      if not FileExistsUTF8(pr.Executable) then
      begin
        myError(-1, mes[12] + ': ' + pr.Executable);
        Continue;
      end;
      pr.Options := [poUsePipes, poStderrToOutPut];
      pr.ShowWindow := swoHIDE;
      pr.Execute;
      t := '';

      repeat
        Sleep(2);
        BytesAvailable := pr.Output.NumBytesAvailable;
        BytesRead := 0;
        while BytesAvailable > 0 do
        begin
          SetLength(Buffer, BytesAvailable);
          BytesRead := pr.OutPut.Read(Buffer[1], BytesAvailable);
          t := t + copy(Buffer, 1, BytesRead);
          repeat
            i := Pos(#13, t);
            j := Pos(#10, t);
            if (i > 0) and (j <> i + 1) then //carrier return, no line feed
            begin
              if (j > i + 1) then j := i;
              fStatus := Copy(t, 1, i - 1);
              Delete(t, 1, Max(i, j));
              StatusBar1.SimpleText := fStatus;
            end else
            if ((i > 0) and (j = i + 1))  //crlf
            or ((i = 0) and (j > 0))      //lf
            or ((i > j) and (j > 0)) then //lf, cr
            begin
              if (i = 0) or (i > j) then i := j;
              fStatus := Copy(t, 1, Min(i, j) - 1);
              Delete(t, 1, Max(i, j));
              //StatusBar1.SimpleText := fStatus;
              mem.Lines.Add(fStatus);
            end;
          until i = 0;
          BytesAvailable := pr.Output.NumBytesAvailable;
        end;
      until not pr.Running;
      if (t <> '') then
        mem.Lines.Add(t);
      Result := pr.ExitStatus;
    finally
      pr.Free;
    end;
    if Result <> 0 then Break;
  end;
  if chkDebug.Checked then
    memJournal.Lines.Add('exit code: ' + IntToStr(Result));
end;

procedure TfrmGUIta.myFindFiles(dir, exe: string; c: TComboBox; bSet2: boolean = True);
var
  SL: TStringList;
  j: integer;
  s: string;
begin
  s := myExpandFN(exe);
  if FileExistsUTF8(s) and not DirectoryExistsUTF8(s) then
    myAdd2cmb(c, exe);
  SL := TStringList.Create;
  if myGetFileList(dir, exe, SL, True) then
    for j := 0 to SL.Count - 1 do
      myAdd2cmb(c, myUnExpandFN(SL[j]));
  if bSet2 and (c.Items.Count > 0) then
    c.ItemIndex := c.Items.Count - 1;
  SL.Free;
end;

procedure TfrmGUIta.myFindPlayers(bSet2: boolean);
var
  i: integer;
  s: string;
{$IFDEF MSWINDOWS}
  j: integer;
  Reg, Re2: TRegistry;
  SL: TStringList;
  procedure my1;
  begin
    if Re2.OpenKeyReadOnly(s) then
    begin
      s := Re2.ReadString('');
      if (s <> '') and (s[1] = '"') then
      begin
        j := PosEx('"', s, 2);
        if j > 0 then
          s := Copy(s, 2, j - 2);
      end
      else
      begin
        j := PosEx(' ', s, 2);
        if j > 0 then
          s := Copy(s, 1, j - 1);
      end;
      if FileExistsUTF8(myExpandEnv(s)) then
        myAdd2cmb(cmbExtPlayer, myUnExpandFN(s))
      else
        s := '';
    end;
  end;

begin
  Reg := TRegistry.Create;
  Re2 := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Re2.RootKey := HKEY_CLASSES_ROOT;
    if Reg.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.avi\OpenWithProgids') then
    begin
      SL := TStringList.Create;
      Reg.GetValueNames(SL);
      for i := 0 to SL.Count - 1 do
      begin
        s := '\' + SL[i] + '\shell\open\command'; //KMPlayer.avi
        my1;
      end;
      SL.Free;
    end;
    //HKEY_CURRENT_USER
    if Reg.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.avi\OpenWithList') then
    begin
      SL := TStringList.Create;
      Reg.GetValueNames(SL);
      for i := 0 to SL.Count - 1 do
      begin
        s := Reg.ReadString(SL[i]);
        //HKEY_CLASSES_ROOT\Applications\ffplay.exe\shell\open\command
        s := '\Applications\' + s + '\shell\open\command'; //ffplay.exe
        my1;
      end;
      SL.Free;
    end;
    Reg.CloseKey;
    Re2.CloseKey;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
  Reg.Free;
  Re2.Free;
{$ELSE}
  a: array [0..9] of string = ('mplayer', 'vlc', 'dragon', 'avplay', 'ffplay',
                               'totem', 'xine', 'mpv', 'smplayer', 'miro');
begin
  for i := Low(a) to High(a) do
  begin
    s := a[i];
    if FileExistsUTF8(FindDefaultExecutablePath(s)) then
      myAdd2cmb(cmbExtPlayer, s);
  end;
{$ENDIF}
  if bSet2 and (cmbExtPlayer.Items.Count > 0) then
    cmbExtPlayer.ItemIndex := 0;
end;

function TfrmGUIta.myExpandFN(fn: string; dir: boolean = False): string;
var
  s: string;
begin
  {$IFDEF MSWINDOWS}
  if (Pos('%', fn) > 0) then
  {$ELSE}
  if (Pos('$', fn) > 0) then
  {$ENDIF}
    fn := myExpandEnv(fn);
  {$IFDEF MSWINDOWS}
  if (Pos(':', fn) > 1) then
  {$ELSE}
  if (Pos('/', fn) = 1) then
  {$ENDIF}
    Result := fn
  else
  begin
    if (Pos('..', fn) = 1) then
    begin
      s := GetCurrentDir;
      SetCurrentDir(sDirApp);
      Result := ExpandFileName(fn);
      SetCurrentDir(s);
    end
    else
    begin
      Result := sDirApp + fn;
      if not dir and not FileExistsUTF8(Result) or DirectoryExistsUTF8(Result) then
        s := FindDefaultExecutablePath(ExtractFileName(fn), sDirApp);
      if s <> '' then
        Result := s;
    end;
  end;
end;

function TfrmGUIta.myUnExpandFN(fn: string): string;
begin
  {$IFDEF MSWINDOWS}
  if Pos(LowerCase(sDirApp), LowerCase(fn)) = 1 then
    fn := ExtractRelativePath(sDirApp, fn)
  else if Pos(LowerCase(ExtractFileDir(ExtractFileDir(sDirApp))), LowerCase(fn)) = 1 then
    fn := ExtractRelativePath(Application.ExeName, fn);
  {$ELSE}
  if Pos(sDirApp, fn) = 1 then
    fn := ExtractRelativePath(sDirApp, fn)
  else if Pos(ExtractFileDir(ExtractFileDir(sDirApp)), fn) = 1 then
    fn := ExtractRelativePath(Application.ExeName, fn);
  {$ENDIF}
  Result := myUnExpandEnvs(fn);
end;

function TfrmGUIta.myStrReplace(s: string; jo: TJob = nil): string;
var
  p, q: string;
  i: integer;
begin
  Result := s;
  Result := StringReplace(Result, '$ffmpeg', myExpandFN(edtffmpeg.Text), [rfReplaceAll]);
  Result := StringReplace(Result, '$ffplay', myExpandFN(edtffplay.Text), [rfReplaceAll]);
  Result := StringReplace(Result, '$ffprobe', myExpandFN(edtffprobe.Text), [rfReplaceAll]);
  Result := StringReplace(Result, '$dirtmp', myExpandFN(edtDirTmp.Text, True), [rfReplaceAll]);
  if jo <> nil then
  begin
    q := '$inputw';
    p := jo.f[0].getval(sMyFilename);
    Result := StringReplace(Result, q, p, [rfReplaceAll]);
    i := High(jo.f);
    while i > -2 do
    begin
      if i < 0 then
      begin
        q := '$input';
        {$IFDEF MSWINDOWS}
        p := jo.f[0].getval(sMyFilename);
        {$ELSE}
        p := jo.f[0].getval(sMyFilename);
        {$ENDIF}
      end
      else
      begin
        q := '$inpu' + IntToStr(i);
        {$IFDEF MSWINDOWS}
        p := jo.f[i].getval(sMyDOSfname);
        {$ELSE}
        p := jo.f[i].getval(sMyFilename);
        {$ENDIF}
      end;
      Result := StringReplace(Result, q, p, [rfReplaceAll]);
      dec(i);
    end;
    q := ExtractFileDir(jo.f[0].getval(sMyFilename));
    Result := StringReplace(Result, '$dirinp', q, [rfReplaceAll]);
    if Trim(edtDirOut.Text) <> '' then
      q := myExpandFN(Trim(edtDirOut.Text), True)
    else
      q := ExtractFileDir(jo.f[0].getval(sMyFilename));
    Result := StringReplace(Result, '$dirout', q, [rfReplaceAll]);
    Result := StringReplace(Result, '$output',
    {$IFDEF MSWINDOWS} jo.getval(edtOfna.Name), [rfReplaceAll]);
    {$ELSE}            jo.getval(edtOfn.Name), [rfReplaceAll]);
    {$ENDIF}
  end;
end;

function TfrmGUIta.myGetFileList(const Path, Mask: string; List: TStrings;
  subdir: boolean = False; fullpath: boolean = True): boolean;
var
  frm: TfrmSplash;
  SL: TStringList;

  function myGetList(const Path2: string): boolean;
  var
    i: integer;
    b: boolean;
    SR: TSearchRec;
  begin
    if FindFirstUTF8(AppendPathDelim(Path2) + '*', faAnyFile and faDirectory, SR) = 0 then
    begin
      repeat
        if (SR.Attr and faDirectory) = faDirectory then
        begin
          if (SR.Name <> '.') and (SR.Name <> '..') then
            myGetList(AppendPathDelim(Path2) + SR.Name);
        end
        else
        begin
          b := False;
          for i := 0 to SL.Count - 1 do
          if MatchesMask(SR.Name, SL.Strings[i]) then
          begin
            b := True;
            Break;
          end;
          if b then
            List.Add(IfThen(fullpath, AppendPathDelim(Path2)) + SR.Name);
        end;
        if frm.bCancel then
          Break;
      until FindNextUTF8(SR) <> 0;
    end;
    FindCloseUTF8(SR);
    Result := not frm.bCancel;
  end;

begin
  Application.CreateForm(TfrmSplash, frm);
  try
    frm.Caption := mes[3] + ': ' + Path + ' - ' + Mask;
    frm.btnCancel.Caption := mes[8];
    frm.Label1.Caption := mes[3];
    if subdir then
      frm.Show;
    SL := TStringList.Create;
    myGetListFromStr(Mask, ';', SL);
    Result := myGetList(Path);
    SL.Free;
  except
    on E: Exception do
      ShowMessage(E.Message)
  end;
  frm.Free;
end;

function TfrmGUIta.myGetSimilarFiles(fn: string; List: TStrings): boolean;
var
  i: integer;
  nStatus: Longint;
  b: boolean;
  SL: TStringList;
  SR: TSearchRec;
begin
  SL := TStringList.Create;
  myGetListFromStr(cmbAddTracks.Text, ';', SL);
  nStatus := FindFirstUTF8(ChangeFileExt(fn, '*'), 0, SR);
  while nStatus = 0 do
  begin
    b := False;
    for i := 0 to SL.Count - 1 do
    if MatchesMask(SR.Name, SL[i]) then
    begin
      if ExtractFileName(fn) <> SR.Name then
        b := True;
    end;
    if b then
      List.Add(ExtractFilePath(fn) + SR.Name);
    nStatus := FindNextUTF8(SR);
  end;
  FindCloseUTF8(SR);
  SL.Free;
  Result := (List.Count > 0);
end;

procedure TfrmGUIta.myFormPosLoad(Form: TForm; Ini: TIniFile);
begin
  if chkSaveFormPos.Checked then
  begin
    Form.Position := poDesigned;
    Form.Top := Ini.ReadInteger(Form.Name, 'Top', Form.Top);
    Form.Left := Ini.ReadInteger(Form.Name, 'Left', Form.Left);
    Form.Height := Ini.ReadInteger(Form.Name, 'Height', Form.Height);
    Form.Width := Ini.ReadInteger(Form.Name, 'Width', Form.Width);
    if (Form.Height > Screen.Height) then
      Form.Height := Screen.Height;
    if (Form.Width > Screen.Width) then
      Form.Width := Screen.Width;
    if (Form.Top > Screen.Height - Form.Height) then
      Form.Top := Screen.Height - Form.Height;
    if (Form.Top < 0) then
      Form.Top := 0;
    if (Form.Left > Screen.Width - Form.Width) then
      Form.Left := Screen.Width - Form.Width;
    if (Form.Left < 0) then
      Form.Left := 0;
    if Ini.ReadBool(Form.Name, 'Maximized', False) then
      Form.WindowState := wsMaximized;
  end
  else
    Form.Position := poDefault;
end;

procedure TfrmGUIta.myFormPosSave(Form: TForm; Ini: TIniFile);
begin
  if chkSaveFormPos.Checked then
    if (WindowState = wsMaximized) then
      myToIni(Ini, Form.Name, 'Maximized', '1')
    else
    begin
      myToIni(Ini, Form.Name, 'Maximized', '0');
      myToIni(Ini, Form.Name, 'Top', IntToStr(Form.Top));
      myToIni(Ini, Form.Name, 'Left', IntToStr(Form.Left));
      myToIni(Ini, Form.Name, 'Height', IntToStr(Form.Height));
      myToIni(Ini, Form.Name, 'Width', IntToStr(Form.Width));
    end;
end;

procedure TfrmGUIta.myLanguage(bRead: boolean; bDefault: boolean = False);
var
  Ini: TIniFile;
  s1, s2, s3: string;
  i: integer;

  function my1(s, k, d: string): string;
  begin
    Result := StringReplace(Ini.ReadString(s, k, d), '\n', LineEnding, [rfReplaceAll]);
  end;

  procedure my2(s, k, v: string);
  begin
    Ini.WriteString(s, k, StringReplace(v, LineEnding, '\n', [rfReplaceAll]));
  end;

  procedure myLng1(c: array of TComponent);
  var
    i, k: integer;
  begin
    for k := Low(c) to High(c) do
      if c[k] is TLabel then
        with TLabel(c[k]) do
          if bRead then
            Caption := my1(s1, Name, Caption)
          else
            my2(s1, Name, Caption)
      else if c[k] is TLabeledEdit then
        with TLabeledEdit(c[k]) do
          if bRead then
          begin
            EditLabel.Caption := my1(s1, Name, EditLabel.Caption);
            Hint := my1(s2, Name, Hint);
            ShowHint := Hint <> '';
          end
          else
          begin
            my2(s1, Name, EditLabel.Caption);
            my2(s2, Name, Hint);
          end
      else if c[k] is TButton then
        with TButton(c[k]) do
          if bRead then
          begin
            Caption := my1(s1, Name, Caption);
            Hint := my1(s2, Name, Hint);
            ShowHint := Hint <> '';
          end
          else
          begin
            my2(s1, Name, Caption);
            my2(s2, Name, Hint);
          end
      else if c[k] is TMenuItem then
        with TMenuItem(c[k]) do
          if bRead then
          begin
            Caption := my1(s1, Name, Caption);
            Hint := my1(s2, Name, Hint);
            ShowHint := Hint <> '';
          end
          else
          begin
            my2(s1, Name, Caption);
            my2(s2, Name, Hint);
          end
      else if c[k] is TCheckBox then
        with TCheckBox(c[k]) do
          if bRead then
          begin
            Caption := my1(s1, Name, Caption);
            Hint := my1(s2, Name, Hint);
            ShowHint := Hint <> '';
          end
          else
          begin
            my2(s1, Name, Caption);
            my2(s2, Name, Hint);
          end
      else if c[k] is TComboBox then
        with TComboBox(c[k]) do
          if bRead then
          begin
            Hint := my1(s2, Name, Hint);
            ShowHint := Hint <> '';
            if ReadOnly then
              for i := 0 to Items.Count - 1 do
                Items[i] := Ini.ReadString(Name, IntToStr(i), Items[i]);
          end
          else
          begin
            my2(s2, Name, Hint);
            if ReadOnly then
              for i := 0 to Items.Count - 1 do
                Ini.WriteString(Name, IntToStr(i), Items[i]);
          end
      else if c[k] is TSpinEdit then
        with TSpinEdit(c[k]) do
          if bRead then
          begin
            Hint := my1(s2, Name, Hint);
            ShowHint := Hint <> '';
          end
          else
            my2(s2, Name, Hint)
      else if c[k] is TListView then
        with TListView(c[k]) do
        begin
          for i := 0 to Columns.Count - 1 do
            if bRead then
              Column[i].Caption := Ini.ReadString(Name, IntToStr(i), Column[i].Caption)
            else
              Ini.WriteString(Name, IntToStr(i), Column[i].Caption);
          if bRead then
          begin
            Hint := my1(s2, Name, Hint);
            ShowHint := Hint <> '';
          end
          else
            my2(s2, Name, Hint);
        end
      else if c[k] is TPanel then
        for i := 0 to TPanel(c[k]).ControlCount - 1 do
          myLng1([TPanel(c[k]).Controls[i]])
      else if c[k] is TTabSheet then
      begin
        with TTabSheet(c[k]) do
          if bRead then
            Caption := my1(s1, Name, Caption)
          else
            my2(s1, Name, Caption);
        for i := 0 to TTabSheet(c[k]).ControlCount - 1 do
          myLng1([TTabSheet(c[k]).Controls[i]]);
      end;
  end;

  procedure myLng4(a: array of TPopupMenu);
  var
    i, j: integer;
  begin
    for j := Low(a) to High(a) do
    begin
      for i := 0 to TPopupMenu(a[j]).Items.Count - 1 do
        myLng1([TPopupMenu(a[j]).Items[i]]);
    end;
  end;

  procedure myLng5(a: array of TPageControl);
  var
    i, j: integer;
  begin
    for j := Low(a) to High(a) do
    begin
      for i := 0 to TPageControl(a[j]).PageCount - 1 do
        myLng1([TPageControl(a[j]).Pages[i]]);
    end;
  end;

begin
  if bRead then
  begin
    mes[0] := 'Video files';
    mes[1] := 'All files (*)|*';
    mes[2] := 'Usage: ffmpegGUIta [-start] [-o:"folder"] [<files>...]\n-start   start converting\n-o:"folder" set output dir to folder\n-m  use masks\n-p  use default profile\-p:"profile.ini" use profile';
    mes[3] := 'Creating file list';
    mes[4] := 'process completed, error code:';
    mes[5] := 'job completed for';
    mes[6] := 'Error';
    mes[7] := 'Select job to change convert parameters';
    mes[8] := 'Cancel';
    mes[9] := 'temporary';
    mes[10] := 'folder not exists';
    mes[11] := 'cmdline is empty';
    mes[12] := 'file not exists';
    mes[13] := 'create new?';
    mes[14] := 'Source';
    mes[15] := 'Destination';
    mes[16] := 'Difference';
    mes[17] := 'Executable';
    mes[18] := 'Find folder';
    mes[19] := 'Expected time of converting this file is:';
    mes[20] := 'Find file';
    mes[21] := 'Overall duration is';
    mes[22] := 'width';
    mes[23] := 'height';
    mes[24] := 'is not divisable by 16';
    mes[25] := 'Split file';
    mes[26] := 'length of cuts in seconds:';
    mes[27] := 'Files';
    mes[28] := 'Search in folder:';
    mes[29] := 'All files';
    mes[30] := 'Process';
    mes[31] := 'terminated';
    mes[32] := 'Job';
    mes[33] := 'added';
    mes[34] := 'completed';
    mes[35] := 'in progress';
    mes[36] := 'error';
    mes[37] := 'divide by zero';
    mes[38] := 'convert';
    mes[39] := 'test';
    mes[40] := 'add files';
    mes[41] := 'play input, test filters';
    mes[42] := 'run command line';
  end;
  s1 := AppendPathDelim(sInidir) + cmbLanguage.Text;
  if bRead and (not FileExistsUTF8(s1)
  or (bDefault and (cmbLanguage.Text = 'Default.lng'))) then
    Exit;
  Ini := TIniFile.Create(UTF8ToSys(s1));
  s1 := 'Captions';
  s2 := 'Hints';
  s3 := 'Messages';
  myLng5([PageControl1, PageControl2, PageControl3, PageControl4]);
  myLng4([PopupMenu1, PopupMenu2, PopupMenu3]);
  for i := Low(mes) to High(mes) do
    if bRead then
      mes[i] := Ini.ReadString(s3, IntToStr(i), mes[i])
    else
      Ini.WriteString(s3, IntToStr(i), mes[i]);
  Ini.Free;
  if bRead then
  begin
    s1 := UpperCase(mes[6]);
    if SynUNIXShellScriptSyn1.SecondKeyWords.IndexOf(s1) < 0 then
      SynUNIXShellScriptSyn1.SecondKeyWords.Add(s1);
  end;
end;

procedure TfrmGUIta.myGetTerminal;
var
  s, t: string;
begin
  {$IFDEF MSWINDOWS}
  s := 'cmd.exe';
  t := '/c';
  edtxterm.Text := s;
  myAdd2cmb(edtxterm, s);
  edtxtermopts.Text := t;
  myAdd2cmb(edtxtermopts, t);
  myAdd2cmb(edtxtermopts, '/k');
  {$ELSE}
  s := '/usr/bin/xterm';
  t := '-e';
  if FileExistsUTF8(s) then
  begin
    myAdd2cmb(edtxterm, s);
    myAdd2cmb(edtxtermopts, t);
  end;
  //s := GetEnvironmentVariable('XDG_CURRENT_DESKTOP');
  //if s = 'KDE' then
  s := '/usr/bin/konsole';
  t := '--nofork -e';
  if FileExistsUTF8(s) then
  begin
    edtxterm.Text := s;
    myAdd2cmb(edtxterm, s);
    edtxtermopts.Text := t;
    myAdd2cmb(edtxtermopts, t);
    myAdd2cmb(edtxtermopts, '--nofork --hold -e');
  end;
  //else if (s = 'GNOME') or (s = 'X-Cinnamon') then
  s := '/usr/bin/gnome-terminal';
  t := '-x';
  if FileExistsUTF8(s) then
  begin
    edtxterm.Text := s;
    myAdd2cmb(edtxterm, s);
    edtxtermopts.Text := t;
    myAdd2cmb(edtxtermopts, t);
  end;
  //else if s = 'XFCE' then
  s := '/usr/bin/xfce4-terminal';
  t := '-x';
  if FileExistsUTF8(s) then
  begin
    edtxterm.Text := s;
    myAdd2cmb(edtxterm, s);
    edtxtermopts.Text := t;
    myAdd2cmb(edtxtermopts, t);
  end;
  //else if s = 'LXDE' then
  s := '/usr/bin/lxterminal';
  t := '-e';
  if FileExistsUTF8(s) then
  begin
    edtxterm.Text := s;
    myAdd2cmb(edtxterm, s);
    edtxtermopts.Text := t;
    myAdd2cmb(edtxtermopts, t);
  end;
  s := '/bin/sh';
  t := '-c';
  if FileExistsUTF8(s) then
  begin
    edtxterm.Text := s;
    myAdd2cmb(edtxterm, s);
    edtxtermopts.Text := t;
    myAdd2cmb(edtxtermopts, t);
  end;
  {$ENDIF}
end;

function TfrmGUIta.myGetUserDir(dir: string): string;
{$IFDEF MSWINDOWS}
var
  Path: Array[0..MaxPathLen] of WideChar; //Allocate memory
begin
  Path := '';
  if dir = 'VIDEOS' then
    SHGetSpecialFolderPathW(0, Path, CSIDL_MYVIDEO, false);
  Result := Path;
{$ELSE}
var
  s: string;
  i: integer;
  run: TRun;
begin
  Result := '';
  s := FindDefaultExecutablePath('xdg-user-dir');
  if not FileExistsUTF8(s) then Exit;
  run := TRun.Create;
  run.add(s, [dir]);
  i := myGetRunOut(run, SynMemo2);
  run.Free;
  if i <> 0 then Exit;
  if SynMemo2.Lines.Count > 1 then
    Result := myUnExpandFN(SynMemo2.Lines[SynMemo2.Lines.Count - 1]);
{$ENDIF}
end;

procedure TfrmGUIta.myChkCpuCount;
begin
  if spnCpuCount.Value = 0 then
    spnCpuCount.Value := cpucount.GetLogicalCpuCount;
  if (spnCpuCount.Value = 0) then
    spnCpuCount.Value := 1;
end;

procedure TfrmGUIta.myDisComp;
var
  b, b1, b2, b3: boolean;
  l: integer;
  jo: TJob;
begin
  b := (LVjobs.Selected <> nil);
  if b then
    jo := TJob(LVjobs.Selected.Data);
  if LVfiles.Selected <> nil then
    l := LVfiles.Selected.Index
  else
    l := 0;
  b1 := b and FileExistsUTF8(jo.f[l].getval(sMyFilename));
  btnPlayIn.Enabled := b1;
  mnuOpen.Enabled := b1;
  mnuView.Enabled := b1;
  b3 := FileExistsUTF8(myExpandFN(edtMediaInfo.Text));
  mnuMediaInfo1.Enabled := b1 and b3;
  btnMediaInfo1.Enabled := b1 and b3;
  b2 := b and FileExistsUTF8(jo.getval(edtOfn.Name));
  btnMediaInfo2.Enabled := b2 and b3;
  btnPlayOut.Enabled := b2;
  btnCompare.Enabled := b1 and b2;
  b3 := b1 and (LowerCase(ExtractFileExt(jo.f[0].getval(sMyFilename))) = '.avs');
  mnuEditAvs.Enabled := b3;
  mnuCopyAsAvs.Enabled := b1 and not b3;
  chkConcat.Enabled := b and (Length(jo.f) > 1);
end;

function TfrmGUIta.myGetCaptionCont(p: TCont): string;
var
  s, t: string;
  i: integer;
  e: extended;
begin
  with p do
  begin
    s := getval('codec_tag_string');
    Result := getval('codec_name') + IfThen(Pos('[', s) = 0, ' ' + s);
    t := getval('codec_type');
    if t = 'video' then
    begin
      Result := Result + ' ' + getval('width') + 'x' + getval('height');
      e := myValFPS([getval('avg_frame_rate'), getval('r_frame_rate')]);
      Result := Result + ' ' + FloatToStr(e) + 'fps';
    end
    else if t = 'audio' then
      Result := Result + ' ' + getval('channels') + 'ch ' + getval('sample_rate') + 'Hz';
    i := StrToIntDef(getval('bit_rate'), 0);
    if i > 100000 then
      Result := Result + ' ' + IntToStr(Round(i / 1000)) + 'kbps'
    else if i > 10000 then
      Result := Result + ' ' + FloatToStr(Round(i / 100) / 10) + 'kbps'
    else
      Result := Result + ' ' + IntToStr(i) + 'bps';
    s := getval('TAG:language');
    if s <> '' then
      Result := Result + ' ' + s;
    s := getval('TAG:handler_name');
    if s <> '' then
      Result := Result + ' ' + s;
    s := getval('TAG:title');
    if s <> '' then
      Result := Result + ' ' + s;
  end;
end;

procedure TfrmGUIta.myGetCaptions(jo: TJob; var v, a, s: string);
var
  k, l: integer;
  t: string;
  c: TCont;
begin
  for l := 0 to High(jo.f) do
  for k := 0 to High(jo.f[l].s) do
  begin
    c := jo.f[l].s[k];
    t := c.getval('codec_type');
    if t = 'video' then
      v := v + myGetCaptionCont(c) + '; '
    else if t = 'audio' then
      a := a + myGetCaptionCont(c) + '; '
    else if t = 'subtitle' then
      s := s + myGetCaptionCont(c) + '; ';
  end;
end;

function TfrmGUIta.myCalcOutSize(jo: TJob): string;
var
  r, q, p: double;
  k, l, v, a, s: integer;
  t, sExt: string;
  c: TCont;

  function my1(s: string): double;
  var
    i: integer;
  begin
    Val(s, Result, i);
    if i > 0 then
      Val(Copy(s, 1, i - 1), Result, i);
    if Pos('ki', LowerCase(s)) > 0 then
      Result := Result * 1024
    else if Pos('k', LowerCase(s)) > 0 then
      Result := Result * 1000
    else if Pos('mi', LowerCase(s)) > 0 then
      Result := Result * 1024 * 1024
    else if Pos('m', LowerCase(s)) > 0 then
      Result := Result * 1000000
    else if Pos('gi', LowerCase(s)) > 0 then
      Result := Result * 1024 * 1024 * 1024
    else if Pos('g', LowerCase(s)) > 0 then
      Result := Result * 1000000000;
  end;

begin
  sExt := LowerCase(ExtractFileExt(jo.getval(edtOfn.Name)));
  //get bitrate per second for every checked tracks
  r := 0;
  v := 0;
  a := 0;
  s := 0;
  for l := 0 to High(jo.f) do
  for k := 0 to High(jo.f[l].s) do
  begin
    c := jo.f[l].s[k];
    if c.getval('Checked') = '1' then
    begin
      t := c.getval('codec_type');
      if t = 'video' then
      begin
        if c.getval(cmbEncoderV.Name) = 'copy' then
          q := StrToIntDef(c.getval('bit_rate'), 0)
        else
          q := my1(c.getval(edtBitRateV.Name));
        if q = 0 then
        begin
          if sExt = '.webp' then
          begin
            q := StrToIntDef(c.getval('width'), 0)
               * StrToIntDef(c.getval('height'), 0) * 24;
          end;
        end;
        //additional bitrate per video stream, more or less
        if sExt = '.mkv' then
          p := 1946
        else if sExt = '.mp4' then
          p := 4477
        else if sExt = '.avi' then
          p := 4500
        else if sExt = '.3gp' then
          p := 1000
        else
          p := 10000;  //other files?
        inc(v);
      end
      else if t = 'audio' then
      begin
        if c.getval(cmbEncoderA.Name) = 'copy' then
          q := StrToIntDef(c.getval('bit_rate'), 0)
        else
          q := my1(c.getval(edtBitRateA.Name));
        //additional bitrate per audio stream, more or less
        if sExt = '.mkv' then
          p := 1401
        else if sExt = '.mp4' then
          p := 1126
        else if sExt = '.avi' then
          p := 9650
        else if sExt = '.3gp' then
          p := 800
        else
          p := 10000;  //other files?
        inc(a);
      end
      else
      begin
        q := 0;
        p := 0;
        inc(s);
      end;
      if chkDebug.Checked then
        memJournal.Lines.Add('calc out size: ' + IntToStr(v + a + s) + ' ' + t + ' bitrate=' + FloatToStr(q) + ' +' + FloatToStr(p));
      r := r + q + p;
    end;
  end;
  //additional bitrate per file, more or less
  p := 0;
  if sExt = '.mkv' then
  begin
    p := 302;
    if (v > 0) and (a > 0) then
      p := p - 86 * (v + a - 1);
  end
  else if sExt = '.mp4' then
  begin
    if (v > 0) and (a > 0) then
      p := v * (821 + 119) + a * (631 + 117) + 879
    else if (v > 1) and (a = 0) then
      p := v * (821 + 119)
    else if (v = 0) and (a > 1) then
      p := a * (631 + 117);
  end
  else if sExt = '.avi' then
  begin

  end;
  r := r + p;
  if chkDebug.Checked then
    memJournal.Lines.Add('calc out size: out br=' + FloatToStr(r));
  //multiplicate to duration
  if jo.getval(cmbDurationt2.Name) <> '' then
    q := myTimeStrToReal(jo.getval(cmbDurationt2.Name))
  else
    q := myTimeStrToReal(jo.f[0].getval('duration'));
  if chkDebug.Checked then
    memJournal.Lines.Add('calc out size: duration=' + FloatToStr(q));
  if q = 0 then
    r := r / 8
  else
    r := r / 8 * q;
  //header, more or less
  //if sExt = '.mkv' then
  //  q := 1360
  //else if sExt = '.mp4' then
  //  q := 3860
  //else
  //  q := 5000;
  //r := r + q;
  if chkDebug.Checked then
    memJournal.Lines.Add('calc out size: out size=' + FloatToStr(r));
  Result := '~' + Trim(Format('%12.0n', [r], fs));
end;

function TfrmGUIta.myCalcBRv(v: TCont): string;
var
  fps: extended;
  w, h: integer;
  s: string;
begin
  fps := myValFPS([v.getval('outFPS'), v.getval('avg_frame_rate'),
    v.getval('r_frame_rate')]);
  if fps = 0 then
    fps := 30;
  w := 0;
  h := 0;
  myGetWH(v, w, h);
  s := 'w=' + IntToStr(w) + LineEnding + 'h=' + IntToStr(h) + LineEnding +
    'fps=' + FloatToStr(fps) + LineEnding + '$koefv=' + v.getval(spnKoefV.Name) + LineEnding;
  if (w > 0) and (h > 0) then
    Result := IntToStr(myValInt(v.getval(cmbBitrateV.Name), s))
  else
    Result := '1';
  Result := Result + 'k';
  if chkDebug.Checked then
    memJournal.Lines.Add('calculate bitratev=' + Result + ' ' +
      StringReplace(s, LineEnding, ' ', [rfReplaceAll]));
end;

function TfrmGUIta.myCalcBRa(a: TCont): string;
var
  i: integer;
  s: string;
begin
  s := 'srate=' + IfThen(a.getval(cmbSRate.Name) = '', a.getval('sample_rate'),
    a.getval(cmbSRate.Name)) + LineEnding + 'ch=' +
    IfThen(a.getval(cmbChannels.Name) = '', a.getval('channels'),
    a.getval(cmbChannels.Name)) + LineEnding + '$koefa=' + a.getval(spnKoefA.Name) + LineEnding;
  i := myValInt(a.getval(cmbBitrateA.Name), s);
  Result := IntToStr(i) + 'k';
  if chkDebug.Checked then
    memJournal.Lines.Add('calculate bitratea=' + Result + ' ' +
      StringReplace(s, LineEnding, ' ', [rfReplaceAll]));
end;

procedure TfrmGUIta.myGetFileStreamNums(s: string; var l, k: integer);
var
  i: integer;
begin
  l := -1;
  k := -1;
  if Length(s) < 3 then Exit;
  i := Pos(':', s);
  l := StrToIntDef(Copy(s, 1, i - 1), -1);
  k := StrToIntDef(Copy(s, i + 1, Length(s)), -1);
end;

procedure TfrmGUIta.myGetWH(v: TCont; var w, h: integer);
var
  x, y, i: integer;
begin
  w := StrToIntDef(v.getval('width'), 0);
  h := StrToIntDef(v.getval('height'), 0);
  x := 0;
  y := 0;
  myGetWHXYcrop(v, w, h, x, y);
  myGetWHXYscale(v, w, h);
  if (StrToIntDef(v.getval(cmbRotate.Name), 7) in [0..3]) then
  begin
    i := w;
    w := h;
    h := i;
  end;
  if chkDebug.Checked then
    memJournal.Lines.Add('calculate ' + mes[22] + '=' + IntToStr(w) +
      ' ' + mes[23] + '=' + IntToStr(h));
end;

procedure TfrmGUIta.myGetWHXYcrop(v: TCont; var w, h, x, y: integer);
var
  sar, dar: double;
  iw, ih: integer;
  s, vars, sw, sh, sx, sy, w1, h1, w2, h2: string;

  function my1: string;
  begin
    w1 := IntToStr(iw);
    h1 := IntToStr(ih);
    w2 := IntToStr(w);
    h2 := IntToStr(h);
    Result := 'in_w=' + w1 + #13#10'in_h=' + h1 + #13#10'iw=' + w1 +
      #13#10'ih=' + h1 + #13#10'w=' + w2 + #13#10'h=' + h2 + #13#10'out_w=' +
      w2 + #13#10'out_h=' + h2 + #13#10'ow=' + w2 + #13#10'oh=' +
      h2 + #13#10'a=' + FloatToStr(iw / ih) + #13#10'sar=' + FloatToStr(sar) +
      #13#10'dar=' + FloatToStr(dar) + #13#10'hsub=2'#13#10'vsub=1'#13#10
      //if pix_fmt=yuv420p
      + 'n=0'#13#10'pos=1'#13#10't=1'#13#10'x=' + IntToStr(x) +
      #13#10'y=' + IntToStr(y) + #13#10;
  end;

begin
  s := v.getval(cmbCrop.Name);
  if s = '' then
    Exit;
  iw := StrToIntDef(v.getval('width'), 0);
  ih := StrToIntDef(v.getval('height'), 0);
  sar := myValFPS([v.getval('sample_aspect_ratio')]);
  if (sar = 0) then
    sar := 1;
  dar := myValFPS([v.getval('display_aspect_ratio')]);
  if (dar = 0) then
  begin
    if (iw > 0) and (ih > 0) then
      dar := iw / ih
    else
      dar := 1.778;
  end;
  sw := '';
  sh := '';
  sx := '';
  sy := '';
  myGetWHXY(s, sw, sh, sx, sy);
  vars := my1;
  w := myValInt(sw, vars);
  h := myValInt(sh, vars);
  if Pos('y', sx) > 0 then
  begin
    y := myValInt(sy, vars);
    vars := my1;
    x := myValInt(sx, vars);
  end
  else
  begin
    x := myValInt(sx, vars);
    y := myValInt(sy, vars);
  end;
  if w = 0 then
    w := iw;
  if h = 0 then
    h := ih;
  if chkDebug.Checked then
    memJournal.Lines.Add('calculate crop ' + s + ' ' + mes[22] + '=' +
      IntToStr(w) + ' ' + mes[23] + '=' + IntToStr(h) + ' x=' +
      IntToStr(x) + ' y=' + IntToStr(y) + ' ' + StringReplace(vars,
      #13#10, ' ', [rfReplaceAll]));
end;

procedure TfrmGUIta.myGetWHXYscale(v: TCont; var w, h: integer);
var
  sar, dar: double;
  iw, ih, i, j: integer;
  s, vars, sw, sh, sx, sy: string;
begin
  s := v.getval(cmbScale.Name);
  if s = '' then
    Exit;
  iw := StrToIntDef(v.getval('width'), 0);
  ih := StrToIntDef(v.getval('height'), 0);
  i := 0;
  j := 0;
  sar := myValFPS([v.getval('sample_aspect_ratio')]);
  if (sar = 0) then
    sar := 1;
  dar := myValFPS([v.getval('display_aspect_ratio')]);
  if (dar = 0) then
  begin
    if (iw > 0) and (ih > 0) then
      dar := iw / ih
    else
      dar := 1.778;
  end;
  sw := '';
  sh := '';
  sx := '';
  sy := '';
  myGetWHXY(s, sw, sh, sx, sy);
  vars := 'in_w=' + v.getval('width') + #13#10'in_h=' + v.getval('height') +
    #13#10'iw=' + v.getval('width') + #13#10'ih=' + v.getval('height') +
    #13#10'out_w=' + IntToStr(w) + #13#10'out_h=' + IntToStr(h) +
    #13#10'ow=' + IntToStr(w) + #13#10'oh=' + IntToStr(h) + #13#10'a=' +
    FloatToStr(iw / ih) + #13#10'sar=' + FloatToStr(sar) + #13#10'dar=' +
    FloatToStr(dar) + #13#10'hsub=2'#13#10'vsub=1'#13#10;
  //if pix_fmt=yuv420p
  i := myValInt(sw, vars);
  j := myValInt(sh, vars);
  if (i <= 0) and (j > 0) and (iw > 0) and (h > 0) then
    i := Round(w * ih * dar / iw * j / h / sar);
  if (i > 0) and (j <= 0) and (ih > 0) and (w > 0) then
    j := Round(h * iw / dar / ih * i / w * sar);
  w := i;
  h := j;
  if chkDebug.Checked then
    memJournal.Lines.Add('calculate scale ' + mes[22] + '=' + IntToStr(w) +
      ' ' + mes[23] + '=' + IntToStr(h) + ' ' + StringReplace(vars,
      #13#10, ' ', [rfReplaceAll]));
  if (w <= 0) or (h <= 0) then
  begin
    w := iw;
    h := ih;
  end;
end;

procedure TfrmGUIta.myGetWHXY(s: string; var w, h, x, y: string);
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  myGetListFromStr(s, ':', SL);
  if SL.Count > 0 then
    w := SL.Strings[0];
  if SL.Count > 1 then
    h := SL.Strings[1];
  if SL.Count > 2 then
    x := SL.Strings[2];
  if SL.Count > 3 then
    y := SL.Strings[3];
  SL.Free;
end;

function TfrmGUIta.myValInt(f, v: string): integer;
var
  c: TCalcul;
  s: string;
  w: word;
begin
  c := TCalcul.Create;
  c.Variables := v;
  c.Formula := StringReplace(f, '\', '', [rfReplaceAll]);
  s := c.calc;
  Val(s, Result, w);
  if w > 0 then
    Val(Copy(s, 1, w - 1), Result, w);
  if c.CalcError then
  begin
    StatusBar1.SimpleText := c.CalcErrorText;
    if chkDebug.Checked then
      memJournal.Lines.Add(c.CalcErrorText);
  end;
end;

function TfrmGUIta.myDirExists(dir, mes: string): boolean;
begin
  Result := True;
  if not DirectoryExistsUTF8(dir) then
    if not ForceDirectoriesUTF8(dir) then
    begin
      myError(-1, mes + ' ' + mes[10] + ' - ' + dir);
      Result := False;
    end;
end;

procedure TfrmGUIta.myError(i: integer; s: string);
begin
  if (i <> 0) or chkDebug.Checked then
    memJournal.Lines.Add(IfThen(i <> 0, mes[6] + ': ' + IntToStr(i) + ' ') + s);
  if (i <> 0) then
    PageControl1.ActivePage := TabJournal;
end;

procedure TfrmGUIta.myFillEnc;
var
  s: string;
  i: integer;
  run: TRun;
begin
  cmbEncoderV.Items.Clear;
  cmbEncoderA.Items.Clear;
  cmbEncoderS.Items.Clear;
  run := TRun.Create;
  run.add(myStrReplace('$ffmpeg'), ['-hide_banner', '-encoders']);
  myGetRunOut(run, SynMemo2);
  run.Free;
  for i := 0 to SynMemo2.Lines.Count - 1 do
  begin
    s := SynMemo2.Lines[i];
    if Length(s) > 30 then
      case s[2] of
        'V': cmbEncoderV.Items.Add(Trim(Copy(s, 9, 21)));
        'A': cmbEncoderA.Items.Add(Trim(Copy(s, 9, 21)));
        'S': cmbEncoderS.Items.Add(Trim(Copy(s, 9, 21)));
        else
          ;
      end;
  end;
  cmbEncoderV.Sorted := True;
  cmbEncoderA.Sorted := True;
  cmbEncoderS.Sorted := True;
  cmbEncoderV.Sorted := False;
  cmbEncoderA.Sorted := False;
  cmbEncoderS.Sorted := False;
  cmbEncoderV.Items.Insert(0, '');
  cmbEncoderA.Items.Insert(0, '');
  cmbEncoderS.Items.Insert(0, '');
  cmbEncoderV.Items.Insert(1, 'copy');
  cmbEncoderA.Items.Insert(1, 'copy');
  cmbEncoderS.Items.Insert(1, 'copy');
end;

procedure TfrmGUIta.myFillFmt;
var
  s: string;
  i: integer;
  run: TRun;
begin
  cmbFormat.Items.Clear;
  cmbFormat.Items.Add('');
  cmbExt.Items.Clear;
  cmbExt.Items.Add('');
  run := TRun.Create;
  run.add(myStrReplace('$ffmpeg'), ['-hide_banner', '-formats']);
  myGetRunOut(run, SynMemo2);
  run.Free;
  for i := 0 to SynMemo2.Lines.Count - 1 do
  begin
    s := SynMemo2.Lines[i];
    if (Length(s) > 21) and (s[5] <> '=') then
      case s[3] of
        'E':
        begin
          s := Trim(Copy(s, 5, 16));
          cmbFormat.Items.Add(s);
          if s = 'matroska' then
            s := 'mkv'
          else if s = 'asf_stream' then
            s := 'asf'
          else if s = 'avm2' then
            s := 'swf'
          else if s = 'bink' then
            s := 'bik'
          else if s = 'dvd' then
            s := 'vob'
          else if s = 'f32be' then
            s := 'wav'
          else if s = 'f32le' then
            s := 'wav'
          else if s = 'f64be' then
            s := 'wav'
          else if s = 'f64le' then
            s := 'wav'
          else if s = 'image2' then
            s := 'jpg'
          else if s = 's16be' then
            s := 'wav'
          else if s = 's16le' then
            s := 'wav'
          else if s = 's24be' then
            s := 'wav'
          else if s = 's24le' then
            s := 'wav'
          else if s = 's32be' then
            s := 'wav'
          else if s = 's32le' then
            s := 'wav'
          else if s = 's8' then
            s := 'wav'
          else if s = 'u16be' then
            s := 'wav'
          else if s = 'u16le' then
            s := 'wav'
          else if s = 'u24be' then
            s := 'wav'
          else if s = 'u24le' then
            s := 'wav'
          else if s = 'u32be' then
            s := 'wav'
          else if s = 'u32le' then
            s := 'wav'
          else if s = 'u8' then
            s := 'wav'
          else if s = 'vcd' then
            s := 'mpg';
          cmbExt.Items.Add('.' + s);
        end;
        else
          ;
      end;
  end;
end;

procedure TfrmGUIta.myFillSGin(si: TStrings; ct: string);
var
  s, t, u: string;
  i, j, k: integer;
  run: TRun;
begin
  si.Clear;
  {$IFDEF MSWINDOWS}
  run := TRun.Create;
  run.add(myStrReplace('$ffmpeg'), ['-hide_banner', '-list_devices', 'true', '-f', 'dshow', '-i', 'NUL']);
  k := myGetRunOut(run, SynMemo2);
  run.Free;
  if (k < 0) or (k > 1) then Exit;
  i := 0;
  while i < SynMemo2.Lines.Count do
  begin
    s := SynMemo2.Lines[i];
    if Pos('DirectShow video devices', s) > 0 then
      t := 'video';
    if Pos('DirectShow audio devices', s) > 0 then
      t := 'audio';
    j := Pos('  "', s);
    if (j > 0) and ((ct = t) or (ct = '')) then
    begin
      u := t + '=' + Copy(s, j + 2, Length(s));
      si.Add('-f dshow -i ' + u);
    end;
    inc(i);
  end;
  {$ELSE}
  if (ct = 'video') or (ct = '') then
  begin
    si.Add('-f x11grab -framerate 30 -video_size '
    + IntToStr(Screen.Width) + 'x'+ IntToStr(Screen.Height)
    + ' -i ' + GetEnvironmentVariableUTF8('DISPLAY'));
    k := 0;
    while FileExistsUTF8('/dev/video' + IntToStr(k)) do
    begin
      run := TRun.Create;
      run.add(myStrReplace('$ffprobe'), ['-hide_banner', '-list_formats', 'all', '-f', 'v4l2', '/dev/video' + IntToStr(k)]);
      j := myGetRunOut(run, SynMemo2);
      run.Free;
      //if (j < 0) or (j > 1) then Exit; //return code is 256
      i := 0;
      //ffprobe -list_formats all -f v4l2 /dev/video0
      //[video4linux2,v4l2 @ 0xb05026a0] Raw       :     yuyv422 :     YUV 4:2:2 (YUYV) : 640x480 352x288 320x240 176x144 160x120
      while i < SynMemo2.Lines.Count do
      begin
        s := SynMemo2.Lines[i];
        if Pos('[video4linux2', s) = 1 then
        begin
          j := Pos(':', s);
          while j > 0 do
          begin
            s := Copy(s, j + 1, Length(s));
            j := Pos(':', s);
          end;
          j := Pos(' ', s);
          while j > 0 do
          begin
            s := Copy(s, j + 1, Length(s));
            j := Pos(' ', s);
            if j > 0 then
              t := Copy(s, 1, j - 1)
            else
              t := s;
            si.Add('-f v4l2 -framerate 30 -video_size ' + t + ' -i /dev/video' + IntToStr(k));
          end;
        end;
        inc(i);
      end;
      inc(k);
    end;
  end;
  if (ct = 'audio') or (ct = '') then
  begin
    run := TRun.Create;
    run.add(FindDefaultExecutablePath('pactl'), ['list', 'sources']);
    j := myGetRunOut(run, SynMemo2);
    run.Free;
    if j <> 0 then Exit;
    i := 1; //skip datetime - cmdline
    while i < SynMemo2.Lines.Count do
    begin
      s := SynMemo2.Lines[i];
      if (Length(s) > 0) and (s[1] <> #9) then //Источник #2 //Источник №2
      begin
        inc(i, 2);
        if i >= SynMemo2.Lines.Count then Exit;
        s := SynMemo2.Lines[i];
        j := Pos(':', s); //Имя: alsa_input.pci-0000_00_1b.0.analog-stereo
        if j = 0 then Exit;
        u := Copy(s, j + 2, Length(s));
        si.Add('-f pulse -i ' + u);
        //inc(i, 3);
        //if i >= SynMemo2.Lines.Count then Exit;
        //s := SynMemo2.Lines[i];
        //j := Pos(':', s); //Спецификация сэмплов: s16le 2ch 48000Гц
        //                  //Спецификация сэмплов: s16le 2-канальный 4800
        //if j = 0 then Exit;
        //s := Copy(s, j + 2, Length(s));
        //j := Pos(' ', s);
        //if j = 0 then Exit;
        //s := Copy(s, j + 1, Length(s));
        //t := myGetDigits(s);
        //si.Add('-f pulse -ac ' + t  + ' -i ' + u);
        //j := Pos(' ', s);
        //if j = 0 then Exit;
        //s := Copy(s, j + 1, Length(s));
        //si.Add('-f pulse -ac ' + t + ' -ar ' + myGetDigits(s) + ' -i ' + u);
      end;
      inc(i);
    end;
  end;
  {$ENDIF}
end;

function TfrmGUIta.myCantUpd(i: integer = 0): boolean;
begin
  Result := bUpdFromCode or (LVjobs.Selected = nil)
    or ((i = 1) and (LVfiles.Selected = nil))
    or ((i = 2) and (LVstreams.Selected = nil));
end;

procedure TfrmGUIta.myGetss4Compare(jo: TJob; rs: double = 0; rt: double = 0);
var
  rd, ri, ro, rm: double;
begin
  rd := myTimeStrToReal(jo.f[0].getval('duration'));
  if rs = 0 then
    rs := myTimeStrToReal(jo.getval(cmbDurationss2.Name));
  if rt = 0 then
    rt := myTimeStrToReal(jo.getval(cmbDurationt2.Name));
  rm := 300;
  if (rs = 0) and (rt = 0) and (rd > rm) then
  begin
    ro := rd / 2;
    ri := ro;
  end
  else if (rs = 0) and (rt > 0) and (rd > rt) then
  begin
    ro := rt / 2;
    ri := ro;
  end
  else if (rs > 0) and (rt = 0) and (rd > rm) then
  begin
    ro := (rd - rs) / 2;
    ri := rs + ro;
  end
  else if (rs > 0) and (rt > 0) and (rt <= rm) and ((rs + rt) < rd) then
  begin
    ro := 0;
    ri := rs;
  end
  else if (rs > 0) and (rt > 0) and ((rs + rt) < rd) then
  begin
    ro := rt / 2;
    ri := rs + ro;
  end
  else
  begin
    ro := 0;
    ri := 0;
  end;
  jo.setval('ssi', myRealToTimeStr(ri, False));
  jo.setval('sso', myRealToTimeStr(ro, False));
end;

function TfrmGUIta.myGetPic(ss, fn, fv: string; sm: TSynMemo; st: TStatusBar): string;
var
  run: TRun;
  s: string;
begin
  Result := myGetOutFN(myStrReplace('$dirtmp'), 'tmp', '.bmp');
  run := TRun.Create;
  run.add(myStrReplace('$ffmpeg'), ['-hide_banner']);
  s := LowerCase(ExtractFileExt(fn));
  if (s <> '.jpg') and (s <> '.jpeg') then
  begin
    if ss = '' then
      ss := '0';
    run.p[0].Parameters.Add('-ss');
    run.p[0].Parameters.Add(ss);
  end;
  run.p[0].Parameters.Add('-i');
  run.p[0].Parameters.Add(myGetAnsiFN(fn));
  process.CommandToList(fv, run.p[0].Parameters);
  run.p[0].Parameters.Add('-frames');
  run.p[0].Parameters.Add('1');
  run.p[0].Parameters.Add('-f');
  run.p[0].Parameters.Add('image2');
  run.p[0].Parameters.Add('-y');
  run.p[0].Parameters.Add(Result);
  myGetRunOut(run, sm);
  run.Free;
end;

function TfrmGUIta.myValFPS(a: array of string): extended;
var
  i, k: integer;
  s, s1, s2: string;
begin
  Result := 0;
  for k := 0 to High(a) do
  begin
    s := a[k];
    i := Pos('/', s);
    if i = 0 then
      i := Pos(':', s);
    if i > 0 then
    begin
      s1 := Copy(s, 1, i - 1);
      s2 := Copy(s, i + 1, Length(s));
      i := StrToIntDef(s2, 1);
      if i = 0 then
        i := 1;
      Result := StrToIntDef(s1, 0) / i;
    end
    else
      Result := StrToFloatDef(s, 0, fs);
    if Result > 0 then
      Break;
  end;
  Result := Round(Result * 1000) / 1000;
end;

function TfrmGUIta.myGetFPS(jo: TJob; stream: string): extended;
var
  k, l: integer;
  c: TCont;
begin
  if stream <> '' then
  begin
    myGetFileStreamNums(stream, l, k);
    c := jo.f[l].s[k];
    Result := myValFPS(c.getval('avg_frame_rate'));
    if Result = 0 then
      Result := myValFPS(c.getval('r_frame_rate'));
    if Result = 0 then
      Result := 30;
  end
  else
  begin
    for l := 0 to High(jo.f) do
    for k := 0 to High(jo.f[l].s) do
    begin
      c := jo.f[l].s[k];
      if (c.getval('Checked') = '1') and (c.getval('codec_type') = 'video') then
      begin
        Result := myValFPS(c.getval('avg_frame_rate'));
        if Result = 0 then
          Result := myValFPS(c.getval('r_frame_rate'));
        if Result = 0 then
          Result := 30;
        Break;
      end;
    end;
  end;
end;

procedure TfrmGUIta.myAdd2cmb(c: TComboBox; s: string; add: boolean = True);
begin
  if (c.Items.IndexOf(s) < 0) then
    if add then
      c.Items.Add(s)
    else
      c.Items.Insert(0, s);
end;

{$IFDEF MSWINDOWS}
function TfrmGUIta.myGetMediaInfo(fn, par: string; sk: TMIStreamKind = Stream_Video;
  sn: integer = 0): string;
var
  h: cardinal;
  m: string;
begin
  Result := '';
  m := ChangeFileExt(myExpandFN(edtMediaInfo.Text), '.dll');
  if not FileExistsUTF8(m) then
    Exit;
  if not MediaInfoDLL_Load(m) then
  begin
    MessageDlg(mes[6] + ' ' + m, mtError, [mbOK], 0);
    Exit;
  end;
  try
    h := MediaInfo_New();
    MediaInfo_Open(h, PWideChar(UTF8Decode(fn)));
    Result := UTF8Encode(WideString(MediaInfo_Get(h, sk, sn,
      PWideChar(UTF8Decode(par)), Info_Text, Info_Name)));
    MediaInfo_Close(h);
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;
{$ENDIF}

function TfrmGUIta.myAutoCrop(jo: TJob; l, k: integer): string;
var
  s, c: string;
  sl: TStringList;
  i, j: integer;
  run: TRun;
begin
  run := TRun.Create;
  run.add(myStrReplace('$ffmpeg'), ['-hide_banner']);
  s := jo.getval(cmbDurationss2.Name);
  if s <> '' then
  begin
    run.p[0].Parameters.Add('-ss');
    run.p[0].Parameters.Add(s);
  end;
  {$IFDEF MSWINDOWS}
  s := jo.f[l].getval(sMyDOSfname);
  {$ELSE}
  s := jo.f[l].getval(sMyFilename);
  {$ENDIF}
  run.p[0].Parameters.Add('-i');
  run.p[0].Parameters.Add(s);
  j := -1;
  for i := 0 to High(jo.f[l].s) do
  begin
    if jo.f[l].s[i].getval('codec_type') = 'video' then
      inc(j); //count video tracks
    if i = k then Break;
  end;
  run.p[0].Parameters.Add('-frames:v');
  run.p[0].Parameters.Add('20');
  run.p[0].Parameters.Add('-filter:v:' + IntToStr(j)); //video track number
  run.p[0].Parameters.Add('framestep=60, cropdetect');
  run.p[0].Parameters.Add('-an');
  run.p[0].Parameters.Add('-sn');
  run.p[0].Parameters.Add('-map');
  run.p[0].Parameters.Add('0:' + IntToStr(k)); //stream number
  run.p[0].Parameters.Add('-f');
  run.p[0].Parameters.Add('avi');
  run.p[0].Parameters.Add('-y');
  {$IFDEF MSWINDOWS}
  run.p[0].Parameters.Add('NUL');
  {$ELSE}
  run.p[0].Parameters.Add('/dev/null');
  {$ENDIF}
  if chkDebug.Checked then
    memJournal.Lines.Add(run.p[0].Executable + ' ' + myGetStr(run.p[0].Parameters));
  myGetRunOut(run, SynMemo2);
  s := SynMemo2.Text;
  sl := TStringList.Create;
  repeat
    c := myBetween(s, 'crop=', LineEnding);
    sl.Add(c);
  until c = '';
  sl.CustomSort(@myCompareInt);
  if sl.Count > 0 then
    Result := sl[sl.Count - 1]
  else
    Result := '';
  if chkDebug.Checked then
    memJournal.Lines.AddStrings(sl);
  sl.Free;
  run.Free;
end;

procedure TfrmGUIta.myGetClipboardFileNames(files: TStrings; test: boolean = False);
var
{$IFDEF MSWINDOWS}
  Drop: HDROP;
  L: longword;
  I, C: integer;
  WideBuffer: WideString;
  fn: string;
begin
  Windows.OpenClipboard(frmGUIta.Handle);
  Drop := Windows.GetClipboardData(CF_HDROP);
  Windows.CloseClipboard;
  if Drop <= 0 then
    Exit;
  C := DragQueryFile(Drop, $FFFFFFFF, nil, 0);
  if C <= 0 then
    Exit;
  for I := 0 to C - 1 do
  begin
    L := DragQueryFileW(Drop, I, nil, 0);
    SetLength(WideBuffer, L);
    L := DragQueryFileW(Drop, I, @WideBuffer[1], L + 1);
    SetLength(WideBuffer, L);
    fn := UTF8Encode(WideBuffer);
    if FileExistsUTF8(fn) then
      files.Add(fn);
    if test then
      Exit;
  end;
end;
{$ELSE}
  i: integer;
  s: string;
  sl1, sl2: TStringList;
begin
  if not Clipboard.HasFormat(CF_TEXT) then
    Exit;
  sl1 := TStringList.Create;
  try
    sl1.Text := ClipBoard.AsText;
    for i := 0 to sl1.Count - 1 do
    begin
      s := Copy(sl1[i], 8, length(sl1[i]));
      if DirectoryExistsUTF8(s) then
      begin
        sl2 := TStringList.Create;
        if myGetFileList(s, myGetExts, sl2, True) then
        begin
          sl2.Sort;
          files.AddStrings(sl2);
        end;
        sl2.Free;
      end
      else
      if FileExistsUTF8(s) then
        files.Add(s)
      else
        Break;
      if test then
        Break;
    end;
  finally
    sl1.Free;
  end;
end;
{$ENDIF}
function TfrmGUIta.myWindowColorIsDark: boolean;
var
  m: Graphics.TBitmap;
  t: TLazIntfImage;
  r, g, b: word;
begin
  m := Graphics.TBitmap.Create;
  m.SetSize(1, 1);
  m.Canvas.Brush.Color := clWindow;
  m.Canvas.FillRect(0, 0, 1, 1);
  t := m.CreateIntfImage;
  r := t.Colors[0, 0].red;
  g := t.Colors[0, 0].green;
  b := t.Colors[0, 0].blue;
  Result := (r + g + b) < 70000;
  //r + g + b, 65535 + 65535 + 65535 = 196605 = white, 0 + 0 + 0 = black
  t.Free;
  m.Free;
  if chkDebug.Checked then
    memJournal.Lines.Add('myWindowColorIsDark: r,g,b='
    + IntToStr(r) + ','+ IntToStr(g) + ','+ IntToStr(b));
end;

function TfrmGUIta.myGetExts: string;
var
  i, j: integer;
  s: string;
  SL: TStringList;
begin
  Result := '';
  if chkUseMasks.Checked then
  for i := 0 to LVmasks.Items.Count - 1 do
  begin
    if LVmasks.Items[i].Checked then
    begin
      s := LVmasks.Items[i].SubItems[0];
      SL := TStringList.Create;
      myGetListFromStr(s, ';', SL);
      for j := 0 to SL.Count - 1 do
      begin
        s := '*' + SL[j] + ';';
        if Pos(s, Result) = 0 then
          Result := Result + s;
      end;
      SL.Free;
    end;
  end
  else
    Result := edtFileExts.Text;
end;

function TfrmGUIta.myGetProfile(fn: string): string;
var
  i, j: integer;
  s: string;
  SL: TStringList;
begin
  if chkUseMasks.Checked then
  begin
    Result := '';
    for i := 0 to LVmasks.Items.Count - 1 do
    begin
      if LVmasks.Items[i].Checked then
      begin
        s := LVmasks.Items[i].SubItems[0];
        SL := TStringList.Create;
        myGetListFromStr(s, ';', SL);
        for j := 0 to SL.Count - 1 do
        begin
          s := LVmasks.Items[i].Caption + SL[j];
          if MatchesMask(fn, s) then
          begin
            Result := LVmasks.Items[i].SubItems[1];
            Break;
          end;
        end;
        SL.Free;
      end;
      if Result <> '' then
        Break;
    end;
    if Result = '' then
      Result := cmbProfileDef.Text;
  end
  else
    Result := cmbProfileDef.Text;
end;

function TfrmGUIta.myGetLngFromFNs(jo: TJob; l: integer): string;
var
  v, a: string;
begin
  Result := '';
  v := ExtractFileNameOnly(jo.f[0].getval(sMyFilename));
  a := ExtractFileNameOnly(jo.f[l].getval(sMyFilename));
  if Pos(v, a) = 1 then
    Result := Trim(Copy(a, Length(v) + 2, Length(a)));
end;

function TfrmGUIta.myQuoteStr(Str: string): string;
begin
  if Pos(' ', Str) > 0 then
    Result := QuotedStr(Str)
  else
    Result := Str;
end;

function TfrmGUIta.myGetStr(a: array of string): string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to High(a) do
    Result := Result + myQuoteStr(a[i]) + ' ';
end;

function TfrmGUIta.myGetStr(a: TStrings): string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to a.Count - 1 do
    Result := Result + myQuoteStr(a[i]) + ' ';
end;

function TfrmGUIta.myGetStr(a: TStringList): string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to a.Count - 1 do
    Result := Result + myQuoteStr(a[i]) + ' ';
end;

procedure TfrmGUIta.myShowCaption(s: string);
begin
  frmGUIta.Caption := sCap
    + IfThen(DuraAll > 0, ', ' + mes[21] + ' = ' + myRealToTimeStr(DuraAll))
    + IfThen(DuraAl2 > 0, ', ' + mes[27] + ' = ' + IntToStr(DuraAl2))
    + IfThen(DuraJob <> '', ', ' + mes[32] + ' = ' + DuraJob)
    + IfThen(s <> '', ', ' + s);
end;

procedure TfrmGUIta.myFillJo(jo: TJob; p: string);
var
  i, k, l: integer;
  s, op, fn: string;
  run: TRun;
  sl: TStringList;
  c: TCont;
begin
  i := Pos(' -i ', p);
  if i > 0 then
  begin
    op := Copy(p, 1, i - 1);
    fn := Copy(p, i + 4, Length(p));
  end
  else
  begin
    myError(1, 'Input parameter " -i " not found in string: ' + p);
    Exit;
  end;
  if Trim(fn) = '' then
  begin
    myError(2, 'Filename not found in string: ' + p);
    Exit;
  end;
  run := TRun.Create;
  run.add(myStrReplace('$ffprobe'), ['-hide_banner', '-show_streams']);
  process.CommandToList(p, run.p[0].Parameters);
  if myGetRunOut(run, SynMemo2) <> 0 then Exit;
  run.Free;
  l := jo.AddFile(fn);
  jo.f[l].setval(sMyffprobe, '1');
  jo.f[l].setval(cmbAddOptsI.Name, op);
  s := SynMemo2.Text;
  sl := TStringList.Create;
  repeat
    sl.Text := myBetween(s, '[STREAM]', '[/STREAM]');
    if (sl.Text = '') then
      Break;
    k := jo.f[l].AddStream;
    c := jo.f[l].s[k];
    c.setval('Checked', '1');
    for i := 0 to sl.Count - 1 do
      c.setpair(sl[i]);
    jo.AddMap(IntToStr(l) + ':' + IntToStr(k));
  until s = '';
  sl.Free;
end;

//------------------------------------------------------------------------------

procedure TfrmGUIta.btnAddFilesClick(Sender: TObject);
var
  od: TOpenDialog;
begin
  od := TOpenDialog.Create(frmGUIta);
  if DirectoryExistsUTF8(myExpandFN(cmbDirLast.Text, True)) then
    od.InitialDir := myExpandFN(cmbDirLast.Text, True);
  od.Filter := mes[0] + '|' + myGetExts + '|' + mes[29] + ' (' + AllFilesMask + ')|' + AllFilesMask;
  od.Title := mes[20] + ' - ' + mes[0];
  od.Options := [ofEnableSizing, ofViewDetail, ofAllowMultiSelect, ofFileMustExist];
  if od.Execute then
  begin
    cmbDirLast.Text := ExtractFileDir(myUnExpandFN(od.FileName));
    {$IFDEF MSWINDOWS}
    if Sender = btnAddFilesAsAvs1 then
      myAddFilesAsAVS1(od.Files)
    else
    if Sender = btnAddFilesAsAvs2 then
      myAddFilesAsAVS2(od.Files)
    else
    {$ENDIF}
    if Sender = btnAddFileSplit then
      myAddFileSplit(od.Files)
    else
    if (Sender = btnAddTracks) and (LVjobs.Selected <> nil) then
      myAddFilesPlus(LVjobs.Selected, od.Files)
    else
      myAddFiles(od.Files)
  end;
  od.Free;
end;

procedure TfrmGUIta.btnAddScreenGrabClick(Sender: TObject);
var
  jo: TJob;
  v, a, s: string;
  li: TListItem;
begin
  if MessageDlg(btnAddScreenGrab.Caption, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    jo := TJob.Create;
    Inc(Counter);
    jo.setval('index', IntToStr(Counter));
    jo.setval(sMyCompleted, '0');
    if Trim(edtDirOut.Text) <> '' then
      s := Trim(edtDirOut.Text)
    else
      s := Trim(edtDirTmp.Text);
    jo.setval(edtOfn.Name, myGetOutFN(s, cmbSGoutput.Text, cmbSGoutext.Text));
    {$IFDEF MSWINDOWS}
    jo.setval(edtOfna.Name, myGetOutFNa(s, cmbSGoutput.Text, cmbSGoutext.Text));
    {$ENDIF}
    jo.setval(sMyBakfname, cmbSGoutput.Text + cmbSGoutext.Text);
    jo.setval(chkFilterComplex.Name, IfThen(cmbSGfiltercomplex.Text <> '', '1', '0'));
    jo.setval(cmbFilterComplex.Name, cmbSGfiltercomplex.Text);
    jo.setval(cmbAddOptsO.Name, cmbSGaddoptsO.Text);
    //add files and tracks
    if chkSGsource0.Checked then
      myFillJo(jo, cmbSGsource0.Text);
    if chkSGsource1.Checked then
      myFillJo(jo, cmbSGsource1.Text);
    if chkSGsource2.Checked then
      myFillJo(jo, cmbSGsource2.Text);
    if chkSGsource3.Checked then
      myFillJo(jo, cmbSGsource3.Text);
    //to listview
    li := LVjobs.Items.Add;
    li.Checked := True;
    li.Caption := IntToStr(Counter);
    li.SubItems.Add('screen grab');
    li.SubItems.Add('0');
    li.SubItems.Add('0');
    li.SubItems.Add('0');
    frmGUIta.myGetCaptions(jo, v, a, s);
    li.SubItems.Add(v);
    li.SubItems.Add(a);
    li.Data := Pointer(jo);
    if (LVjobs.Items.Count = 1) then
      LVjobs.Items[0].Selected := True;
    inc(DuraAl2);
    myShowCaption('');
  end;
end;

procedure TfrmGUIta.btnAddTrack1Click(Sender: TObject);
var
  frmT: TfrmTrack;
  jo: TJob;
begin
  if LVjobs.Selected = nil then
    Exit;
  Application.CreateForm(TfrmTrack, frmT);
  frmT.Caption := btnAddTrack1.Caption;
  if frmT.ShowModal = mrOK then
  begin
    jo := TJob(LVjobs.Selected.Data);
    myFillJo(jo, frmT.ComboBox1.Text);
    LVjobsSelectItem(Sender, LVjobs.Selected, True);
  end;
  frmT.Free;
end;

procedure TfrmGUIta.btnCompareClick(Sender: TObject);
var
  Ini: TIniFile;
  jo: TJob;
  c: TCont;
  frmCompare: TfrmCompare;
  ty, iv, ia, fv, fa, fn, map: string;
  k, l, nv, na: integer;
  bfi: boolean;
begin
  if LVjobs.Selected = nil then
    Exit;
  if not FileExistsUTF8(edtOfn.Text) then
    Exit;
  jo := TJob(LVjobs.Selected.Data);
  iv := '';
  ia := '';
  fv := '';
  fa := '';
  nv := -1;
  na := -1;
  map := '';
  bfi := (jo.getval(chkFilterComplex.Name) = '1');
  for l := 0 to High(jo.f) do
  for k := 0 to High(jo.f[l].s) do
  begin
    c := jo.f[l].s[k];
    if c.getval('Checked') = '1' then
    begin
      ty := c.getval('codec_type');
      if (ty = 'video') and (iv = '') then
      begin
        nv := l;
        iv := IntToStr(k);
        if not bfi then
        begin
          fv := myGetFilter(jo, c, False); //resize only filter
          if fv <> '' then fv := ' -filter:v "' + fv + '"';
        end;
      end
      else if (ty = 'audio') and (ia = '') then
      begin
        na := l;
        ia := IntToStr(k);
        fa := ' -filter_complex "showwaves=s=1200x480:mode=line"';
      end;
    end;
  end;
  l := nv;
  if (l < 0) or (l > High(jo.f)) then
    l := na;
  if (l < 0) or (l > High(jo.f)) then
    l := 0;
  fn := jo.f[l].getval(sMyFilename);
  if not FileExistsUTF8(fn) then
    Exit;
  if iv <> '' then
  begin
    map := ' -map 0:' + iv;
    fa := '';
  end
  else if ia <> '' then
    fv := fa;
  Application.CreateForm(TfrmCompare, frmCompare);
  frmCompare.Button1.Caption := mes[14];
  frmCompare.Button2.Caption := mes[15];
  frmCompare.Button3.Caption := mes[16];
  frmCompare.b := False;
  frmCompare.LabeledEdit3.Text := fv + map;
  frmCompare.LabeledEdit4.Text := fa;
  frmCompare.Image1.Picture.Clear;
  frmCompare.Image2.Picture.Clear;
  frmCompare.Image3.Picture.Clear;
  frmCompare.Button2.Click;
  frmCompare.LabeledEdit1.EditLabel.Caption := fn;
  frmCompare.LabeledEdit2.EditLabel.Caption := edtOfn.Text;
  if frmCompare.LabeledEdit1.Text <> jo.getval('ssi') then
    frmCompare.LabeledEdit1.Text := jo.getval('ssi')
  else
    frmCompare.LabeledEdit1Change(frmCompare.LabeledEdit1);
  if frmCompare.LabeledEdit2.Text <> jo.getval('sso') then
    frmCompare.LabeledEdit2.Text := jo.getval('sso')
  else
    frmCompare.LabeledEdit1Change(frmCompare.LabeledEdit2);
  frmCompare.Image1.Visible := True;
  Ini := TIniFile.Create(UTF8ToSys(sInifile));
  myFormPosLoad(frmCompare, Ini);
  frmCompare.ShowModal;
  myFormPosSave(frmCompare, Ini);
  Ini.Free;
  jo.setval('ssi', frmCompare.LabeledEdit1.Text);
  jo.setval('sso', frmCompare.LabeledEdit2.Text);
  frmCompare.Free;
end;

procedure TfrmGUIta.btnCmdRunClick(Sender: TObject);
var
  s: string;
  jo: TJob;
  run: TRun;
  p: TProcessUTF8;
  e: TThreadExec;
  li: TListItem;
begin
  if LVjobs.Selected <> nil then
  begin
    jo := TJob(LVjobs.Selected.Data);
    s := myStrReplace(cmbRunCmd.Text, jo);
  end
  else
    s := myStrReplace(cmbRunCmd.Text);
  if chkRunInTerm.Checked then
  begin
    p := TProcessUTF8.Create(nil);
    if chkxterm1str.Checked then
    begin
      p.ParseCmdLine(edtxterm.Text + ' ' + edtxtermopts.Text);
      p.Parameters.Add(s);
    end
    else
    begin
      p.ParseCmdLine(edtxterm.Text + ' ' + edtxtermopts.Text + ' ' + s);
    end;
    if chkDebug.Checked then
      SynMemo2.Lines.Add(myDTtoStr(sMyDTformat, Now) + ' run in terminal: ' + p.Executable + ' ' + p.Parameters.Text);
    p.Execute;
    p.Free;
  end
  else
  if chkRunInMem.Checked then
  begin
    if chkDebug.Checked then
      SynMemo2.Lines.Add(myDTtoStr(sMyDTformat, Now) + ' run in memo: ' + s);
    run := TRun.Create;
    run.add(s);
    myGetRunOut(run, SynMemo2);
    run.Free;
  end
  else
  begin
    if chkDebug.Checked then
      SynMemo2.Lines.Add(myDTtoStr(sMyDTformat, Now) + ' run in thread: ' + s);
    e := TThreadExec.Create(s, chkOEM.Checked, SynMemo2);
    if Assigned(e.FatalException) then
      raise e.FatalException;
    e.OnTerminate := @onCnv3Terminate;
    e.Start;
    li := LVtrd.Items.Add;
    li.Caption := 'r';
    li.SubItems.Add(mes[42]); //run command line
    li.Data := Pointer(e);
  end;
  if cmbRunCmd.Items.IndexOf(cmbRunCmd.Text) < 0 then
  begin
    cCmdIni.setval(cmbRunCmd.Text, '1');
    cmbRunCmd.Items.Add(cmbRunCmd.Text);
  end;
end;

procedure TfrmGUIta.btnCropClick(Sender: TObject);
var
  l, k, w, h, x, y: integer;
  jo: TJob;
  c: TCont;
  frmCrop: TfrmCrop;
  Ini: TIniFile;
  iv, fn: string;
begin
  if myCantUpd(2) then
    Exit;
  jo := TJob(LVjobs.Selected.Data);
  myGetFileStreamNums(LVstreams.Selected.Caption, l, k);
  c := jo.f[l].s[k];
  if cmbCrop.Text = '' then
  begin
    cmbCrop.Text := myAutoCrop(jo, l, k);
    xmyChange2v(cmbCrop);
  end;
  iv := ' -map 0:' + IntToStr(k);
  fn := jo.f[l].getval(sMyFilename);
  if not FileExistsUTF8(fn) then
    Exit;
  Application.CreateForm(TfrmCrop, frmCrop);
  frmCrop.LabeledEdit2.Text := iv;
  frmCrop.LabeledEdit1.EditLabel.Caption := fn;
  frmCrop.LabeledEdit1.Text := jo.getval('ssi');
  frmCrop.Show;
  frmCrop.Hide;
  w := 0;
  h := 0;
  x := 0;
  y := 0;
  myGetWHXYcrop(c, w, h, x, y);
  frmCrop.Caption := IntToStr(w) + ':' + IntToStr(h) + ':' + IntToStr(x) +
    ':' + IntToStr(y);
  frmCrop.btnW.Left := x + w - frmCrop.btnW.Width;
  frmCrop.btnW.Top := (frmCrop.Image1.Height - frmCrop.btnW.Height) div 2;
  frmCrop.btnW.Caption := IntToStr(w);
  frmCrop.btnH.Left := (frmCrop.Image1.Width - frmCrop.btnH.Width) div 2;
  frmCrop.btnH.Top := y + h - frmCrop.btnH.Height;
  frmCrop.btnH.Caption := IntToStr(h);
  frmCrop.btnX.Left := x;
  frmCrop.btnX.Top := (frmCrop.Image1.Height - frmCrop.btnX.Height) div 2;
  frmCrop.btnX.Caption := IntToStr(x);
  frmCrop.btnY.Left := (frmCrop.Image1.Width - frmCrop.btnY.Width) div 2;
  frmCrop.btnY.Top := y;
  frmCrop.btnY.Caption := IntToStr(y);
  Ini := TIniFile.Create(UTF8ToSys(sInifile));
  myFormPosLoad(frmCrop, Ini);
  if frmCrop.ShowModal = mrOk then
  begin
    cmbCrop.Text := frmCrop.Caption;
    xmyChange2v(cmbCrop);
  end;
  myFormPosSave(frmCrop, Ini);
  frmCrop.Free;
  Ini.Free;
end;

procedure TfrmGUIta.btnFindDirOutClick(Sender: TObject);
begin
  xmySelDir(edtDirOut);
end;

procedure TfrmGUIta.btnFindExtPlayerClick(Sender: TObject);
begin
  xmySelFile(cmbExtPlayer);
end;

procedure TfrmGUIta.btnFindffmpegClick(Sender: TObject);
begin
  xmySelFile(edtffmpeg);
end;

procedure TfrmGUIta.btnFindffplayClick(Sender: TObject);
begin
  xmySelFile(edtffplay);
end;

procedure TfrmGUIta.btnFindffprobeClick(Sender: TObject);
begin
  xmySelFile(edtffprobe);
end;

procedure TfrmGUIta.btnFindMediaInfoClick(Sender: TObject);
begin
  xmySelFile(edtMediaInfo);
end;

procedure TfrmGUIta.btnFindDirTmpClick(Sender: TObject);
begin
  xmySelDir(edtDirTmp);
end;

procedure TfrmGUIta.btnLanguageClick(Sender: TObject);
var
  s, d: string;
begin
  d := AppendPathDelim(sInidir);
  if not FileExistsUTF8(d + cmbLanguage.Text) then
  begin
    if MessageDlg(mes[12] + ' "' + cmbLanguage.Text + '" ' + mes[13],
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if not myDirExists(d, '') then
        Exit;
      myLanguage(False);
    end
    else
      Exit;
  end;
  s := myGetAnsiFN(d + cmbLanguage.Text);
  myOpenDoc(s);
end;

procedure TfrmGUIta.btnLogClearClick(Sender: TObject);
begin
  SynMemo2.Lines.Clear;
end;

procedure TfrmGUIta.btnLogSaveClick(Sender: TObject);
var
  i: integer;
  sd: TSaveDialog;
  s: string;
begin
  sd := TSaveDialog.Create(Self);
  sd.InitialDir := myExpandFN(edtDirOut.Text, True);
  sd.Filter := '*.log|*.log|' + mes[29] + ' (' + AllFilesMask + ')|' + AllFilesMask;
  i := 0;
  repeat
    Inc(i);
    sd.FileName := IntToStr(i) + '.log';
  until not FileExistsUTF8(AppendPathDelim(sd.InitialDir) + sd.FileName);
  if sd.Execute then
  begin
    if FileExistsUTF8(sd.FileName) then
      s := myGetAnsiFN(sd.FileName)
    else
      s := myGetOutFN(myGetAnsiFN(ExtractFileDir(sd.FileName)), 'tmp',
        ExtractFileExt(sd.FileName));
    SynMemo2.Lines.SaveToFile(UTF8ToSys(s));
    RenameFileUTF8(s, sd.FileName);
  end;
  sd.Free;
end;

procedure TfrmGUIta.btnMaskAddClick(Sender: TObject);
var
  li: TListItem;
  frmM: TfrmMaskProf;
begin
  if LVmasks.Items.Count > iMaxMask then
  begin
    ShowMessage('Too many masks +' + IntToStr(iMaxMask + 1));
    Exit;
  end;
  Application.CreateForm(TfrmMaskProf, frmM);
  frmM.Caption := btnMaskAdd.Caption;
  frmM.ComboBox1.Text := '';
  frmM.ComboBox2.Text := '';
  frmM.ComboBox3.Text := '';
  cmbProfileGetItems(cmbProfileDef);
  frmM.ComboBox3.Items.AddStrings(cmbProfileDef.Items);
  if frmM.ShowModal = mrOk then
  begin
    li := LVmasks.Items.Add;
    li.Checked := True;
    li.Caption := frmM.ComboBox1.Text;
    li.SubItems.Add(frmM.ComboBox2.Text);
    li.SubItems.Add(frmM.ComboBox3.Text);
  end;
  frmM.Free;
end;

procedure TfrmGUIta.btnMaskDelClick(Sender: TObject);
begin
  if LVmasks.Selected = nil then
    Exit;
  LVmasks.Selected.Delete;
end;

procedure TfrmGUIta.btnMaskEditClick(Sender: TObject);
var
  frmM: TfrmMaskProf;
begin
  if LVmasks.Selected = nil then
    Exit;
  Application.CreateForm(TfrmMaskProf, frmM);
  frmM.Caption := btnMaskEdit.Caption;
  frmM.ComboBox1.Text := LVmasks.Selected.Caption;
  frmM.ComboBox2.Text := LVmasks.Selected.SubItems[0];
  frmM.ComboBox3.Text := LVmasks.Selected.SubItems[1];
  cmbProfileGetItems(cmbProfileDef);
  frmM.ComboBox3.Items.AddStrings(cmbProfileDef.Items);
  if frmM.ShowModal = mrOk then
  begin
    LVmasks.Selected.Caption := frmM.ComboBox1.Text;
    LVmasks.Selected.SubItems[0] := frmM.ComboBox2.Text;
    LVmasks.Selected.SubItems[1] := frmM.ComboBox3.Text;
  end;
  frmM.Free;
end;

procedure TfrmGUIta.btnMaskResetClick(Sender: TObject);
var
  li: TListItem;
begin
  LVmasks.Clear;
  li := LVmasks.Items.Add;
  li.Checked := True;
  li.Caption := '*';
  li.SubItems.Add('.jp*g;.png');
  li.SubItems.Add('photo to webp.ini');
  li := LVmasks.Items.Add;
  li.Checked := False;
  li.Caption := '*';
  li.SubItems.Add('.mp3;.ac3;.wav');
  li.SubItems.Add('sound to mp3 128k.ini');
  li := LVmasks.Items.Add;
  li.Checked := False;
  li.Caption := 'anim*';
  li.SubItems.Add('.avi;.mkv;.vob;.mp*g;.mp4;.mov;.flv;.3gp;.3g2;.asf;.wmv;.m2ts;.ts;.ogv;.webm;.rm;.qt');
  li.SubItems.Add('libx264 slow animation-aac-matroska.ini');
  li := LVmasks.Items.Add;
  li.Checked := True;
  li.Caption := '*';
  li.SubItems.Add('.avi;.mkv;.vob;.mp*g;.mp4;.mov;.flv;.3gp;.3g2;.asf;.wmv;.m2ts;.ts;.ogv;.webm;.rm;.qt');
  li.SubItems.Add('libx264 slow film-aac-matroska.ini');
end;

procedure TfrmGUIta.btnMediaInfo1Click(Sender: TObject);
var
  s, fn: string;
  l: integer;
  {$IFDEF MSWINDOWS}
  se: string;
  sl: TStringList;
  h: cardinal;
  {$ENDIF}
begin
  if myCantUpd(0) then
    Exit;
  if Sender = btnMediaInfo2 then
  begin
    fn := edtOfn.Text;
  end
  else
  begin
    if LVfiles.Selected <> nil then
      l := LVfiles.Selected.Index
    else
      l := 0;
    fn := TJob(LVjobs.Selected.Data).f[l].getval(sMyFilename);
  end;
  {$IFDEF MSWINDOWS}
  s := myGetAnsiFN(myExpandFN(edtMediaInfo.Text));
  if not FileExistsUTF8(s) then
    xmySelFile(edtMediaInfo);
  s := myGetAnsiFN(myExpandFN(edtMediaInfo.Text));
  if not FileExistsUTF8(s) then
    Exit;
  se := LowerCase(ExtractFileExt(s));
  if se = '.exe' then
    myExecProc(s, [fn])
  else if se = '.dll' then
  begin
    if (MediaInfoDLL_Load(s) = False) then
    begin
      MessageDlg(mes[20] + ' ' + s, mtError, [mbOK], 0);
      Exit;
    end;
    try
      h := MediaInfo_New();
      MediaInfo_Open(h, PWideChar(UTF8Decode(fn)));
      sl := TStringList.Create;
      sl.Text := UTF8Encode(WideString(MediaInfo_Inform(h, 0)));
      SynMemo2.Clear;
      SynMemo2.Lines.AddStrings(sl);
      sl.Free;
      MediaInfo_Close(h);
      PageControl1.ActivePage := TabConsole;
      PageControl3.ActivePage := TabConsole1;
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  end;
  {$ELSE}
  s := myExpandFN(edtMediaInfo.Text);
  myExecProc(s, [fn]);
  {$ENDIF}
end;

procedure TfrmGUIta.btnFindOfnClick(Sender: TObject);
var
  sd: TSaveDialog;
  s: string;
  i: integer;
begin
  sd := TSaveDialog.Create(Self);
  s := ExtractFileDir(edtOfn.Text);
  i := 0;
  while not DirectoryExistsUTF8(s) and (i < 128) do
  begin
    s := ExtractFileDir(s);
    Inc(i);
  end;
  sd.InitialDir := s;
  sd.Filter := mes[29] + ' (' + AllFilesMask + ')|' + AllFilesMask;
  sd.FileName := ExtractFileName(edtOfn.Text);
  if sd.Execute then
    edtOfn.Text := sd.FileName;
  sd.Free;
end;

procedure TfrmGUIta.btnPlayInClick(Sender: TObject);
var
  jo: TJob;
  c: TCont;
  run: TRun;
  s, ss, t, vf, af, vn, an, sn: string;
  k, l, filenum: integer;
  bfi: boolean;
  p: TProcessUTF8;
  a: array of string;
  h: TThreadExec;
  li: TListItem;
  procedure add2a(s: string);
  var
    i: integer;
  begin
    i := Length(a);
    SetLength(a, i + 1);
    a[i] := s;
  end;

begin
  if LVjobs.Selected = nil then
    Exit;
  jo := TJob(LVjobs.Selected.Data);
  if chkPlayInTerm.Checked then
  begin
    run := TRun.Create;
    myGetRunFromJo(jo, run, 2);
    p := run.p[0];
    s := p.Parameters[p.Parameters.Count - 1];
    s := s + ' | ' + myQuoteStr(myStrReplace('$ffplay')) + ' -';
    if chkffplayfs.Checked then
      s := s + ' -fs';
    //p := TProcessUTF8.Create(nil);
    p.Parameters[p.Parameters.Count - 1] := s;
    if chkDebug.Checked then
    begin
      memJournal.Lines.Add(p.Executable);
      memJournal.Lines.AddStrings(p.Parameters);
    end;
    try
      p.InheritHandles := False;
      p.Options := [];
      p.ShowWindow := swoShow;
      for k := 1 to GetEnvironmentVariableCount do
        p.Environment.Add(GetEnvironmentString(k));
      p.Execute;
    finally
      run.Free;
    end;
  end
  else if not chkRunInMem.Checked then
  begin
    vf := '';
    af := '';
    vn := '';
    an := '';
    sn := '';
    filenum := -1; //ffplay works with one input file
    bfi := (jo.getval(chkFilterComplex.Name) = '1');
    for l := 0 to High(jo.f) do
    begin
      if (filenum > -1) and (filenum <> l) then Break;
      for k := 0 to High(jo.f[l].s) do
      begin
        c := jo.f[l].s[k];
        if (c.getval('Checked') = '1') then
        begin
          s := c.getval('codec_type');
          if (s = 'video') and (vn = '') then
          begin
            filenum := l;
            vn := ' -vst ' + IntToStr(k);
            add2a('-vst');
            add2a(IntToStr(k));
            if not bfi then
            begin
              vf := myGetFilter(jo, c);
              if vf <> '' then
              begin
                add2a('-vf');
                add2a(vf);
              end;
            end;
          end
          else if (s = 'audio') and (an = '') then
          begin
            filenum := l;
            an := ' -ast ' + IntToStr(k);
            add2a('-ast');
            add2a(IntToStr(k));
            if not bfi then
            begin
              af := myGetFilter(jo, c);
              if af <> '' then
              begin
                add2a('-af');
                add2a(af);
              end;
            end;
          end
          else if (s = 'subtitle') and (sn = '') then
          begin
            sn := ' -sst ' + IntToStr(k);
            add2a('-sst');
            add2a(IntToStr(k));
          end;
        end;
      end;
    end;
    if (vn = '') and (an = '') then
      Exit; //play nothing
    if vn = '' then
      add2a('-vn');
    if an = '' then
      add2a('-an');
    if sn = '' then
      add2a('-sn'); //ffplay 1.0.10 - Missing argument for option 'sn'
    l := filenum;
    if (l < 0) or (l > High(jo.f)) then
      l := 0;
    ss := jo.f[l].getval(cmbDurationss1.Name);
    if ss = '' then
      ss := jo.getval(cmbDurationss2.Name);
    if ss <> '' then
    begin
      add2a('-ss');
      add2a(ss);
    end;
    t := jo.f[l].getval(cmbDurationt1.Name);
    if t = '' then
      t := jo.getval(cmbDurationt2.Name);
    if t <> '' then
    begin
      add2a('-t');
      add2a(t);
    end;
    {$IFDEF MSWINDOWS}
    s := jo.f[l].getval(sMyDOSfname);
    {$ELSE}
    s := jo.f[l].getval(sMyFilename);
    {$ENDIF}
    add2a('-i');
    add2a(s);
    if chkffplayfs.Checked then
      add2a('-fs');
    myExecProc(myStrReplace('$ffplay'), a);
  end
  else
  begin
    h := TThreadExec.Create('', chkOEM.Checked, SynMemo2);
    if Assigned(h.FatalException) then
      raise h.FatalException;
    //h.OnTerminate := @onCmdrTerminate;
    h.OnTerminate := @onCnv3Terminate;
    h.p.Executable := myStrReplace('$ffplay');
    vf := '';
    af := '';
    vn := '';
    an := '';
    sn := '';
    filenum := -1; //ffplay works with one input file
    bfi := (jo.getval(chkFilterComplex.Name) = '1');
    for l := 0 to High(jo.f) do
    begin
      if (filenum > -1) and (filenum <> l) then Break;
      for k := 0 to High(jo.f[l].s) do
      begin
        c := jo.f[l].s[k];
        if (c.getval('Checked') = '1') then
        begin
          s := c.getval('codec_type');
          if (s = 'video') and (vn = '') then
          begin
            filenum := l;
            vn := ' -vst ' + IntToStr(k);
            h.p.Parameters.Add('-vst');
            h.p.Parameters.Add(IntToStr(k));
            if not bfi then
            begin
              vf := myGetFilter(jo, c);
              if vf <> '' then
              begin
                h.p.Parameters.Add('-vf');
                h.p.Parameters.Add(vf);
              end;
            end;
          end
          else if (s = 'audio') and (an = '') then
          begin
            filenum := l;
            an := ' -ast ' + IntToStr(k);
            h.p.Parameters.Add('-ast');
            h.p.Parameters.Add(IntToStr(k));
            if not bfi then
            begin
              af := myGetFilter(jo, c);
              if af <> '' then
              begin
                h.p.Parameters.Add('-af');
                h.p.Parameters.Add(af);
              end;
            end;
          end
          else if (s = 'subtitle') and (sn = '') then
          begin
            sn := ' -sst ' + IntToStr(k);
            h.p.Parameters.Add('-sst');
            h.p.Parameters.Add(IntToStr(k));
          end;
        end;
      end;
    end;
    if (vn = '') and (an = '') then
      Exit; //play nothing
    if vn = '' then
      h.p.Parameters.Add('-vn');
    if an = '' then
      h.p.Parameters.Add('-an');
    if sn = '' then
      h.p.Parameters.Add('-sn'); //ffplay 1.0.10 - Missing argument for option 'sn'
    l := filenum;
    if (l < 0) or (l > High(jo.f)) then
      l := 0;
    ss := jo.f[l].getval(cmbDurationss1.Name);
    if ss = '' then
      ss := jo.getval(cmbDurationss2.Name);
    if ss <> '' then
    begin
      h.p.Parameters.Add('-ss');
      h.p.Parameters.Add(ss);
    end;
    t := jo.f[l].getval(cmbDurationt1.Name);
    if t = '' then
      t := jo.getval(cmbDurationt2.Name);
    if t <> '' then
    begin
      h.p.Parameters.Add('-t');
      h.p.Parameters.Add(t);
    end;
    {$IFDEF MSWINDOWS}
    s := jo.f[l].getval(sMyDOSfname);
    {$ELSE}
    s := jo.f[l].getval(sMyFilename);
    {$ENDIF}
    h.p.Parameters.Add('-i');
    h.p.Parameters.Add(s);
    if chkffplayfs.Checked then
      h.p.Parameters.Add('-fs');
    h.Start;
    li := LVtrd.Items.Add;
    li.Caption := 'p';
    li.SubItems.Add(mes[41]); //play input, test filters
    li.Data := Pointer(h);
  end;
end;

procedure TfrmGUIta.btnPlayOutClick(Sender: TObject);
var
  s: string;
begin
  s := myGetAnsiFN(edtOfn.Text);
  if not FileExistsUTF8(s) then
  begin
    if chkDebug.Checked then
      memJournal.Lines.Add(mes[12] + ' ' + s);
    Exit;
  end;
  if chkPlayer2.Checked then
    //myOpenDoc(s)
    OpenDocument(s)
  else
  if chkPlayer3.Checked and FileExistsUTF8(myExpandFN(cmbExtPlayer.Text)) then
    myExecProc(myExpandFN(cmbExtPlayer.Text), [s])
  else
  if chkffplayfs.Checked then
    myExecProc(myStrReplace('$ffplay'), [s, '-fs'])
  else
    myExecProc(myStrReplace('$ffplay'), [s]);
end;

procedure TfrmGUIta.btnProfileSaveAsClick(Sender: TObject);
var
  Ini: TIniFile;
  b: boolean;
  sd: TSaveDialog;
  s: string;
begin
  sd := TSaveDialog.Create(Self);
  sd.InitialDir := sInidir;
  sd.Filter := '*.ini|*.ini|' + mes[29] + ' (' + AllFilesMask + ')|' + AllFilesMask;
  sd.DefaultExt := '.ini';
  if not myDirExists(sd.InitialDir, '') then
    Exit;
  b := (cmbEncoderV.Text = 'libx264') or (cmbEncoderV.Text = 'libx264rgb')
  or (cmbEncoderV.Text = 'libx265');
  sd.FileName := cmbEncoderV.Text + IfThen(b, ' ' + cmbx264preset.Text +
    ' ' + cmbx264tune.Text) + '-' + cmbEncoderA.Text + '-' + cmbFormat.Text + '.ini';
  if sd.Execute then
  begin
    cmbProfile.Text := ExtractFileName(sd.FileName);
    if FileExistsUTF8(sd.FileName) then
      s := myGetAnsiFN(sd.FileName)
    else
    begin
      s := UTF8ToSys(ExtractFileName(sd.FileName));
      if Pos('?', s) > 0 then
        s := myGetOutFN(myGetAnsiFN(ExtractFileDir(sd.FileName)), 'tmp', '.ini')
      else
        s := AppendPathDelim(myGetAnsiFN(ExtractFileDir(sd.FileName))) +
          ExtractFileName(sd.FileName);
    end;
    PageControl2.ActivePage := TabInput;
    PageControl2.ActivePage := TabVideo;
    PageControl2.ActivePage := TabAudio;
    PageControl2.ActivePage := TabSubtitle;
    PageControl2.ActivePage := TabOutput;
    Ini := TIniFile.Create(UTF8ToSys(s));
    mySets1(Ini, '1', [TabOutput], False);
    mySets1(Ini, 'input', [TabInput], False);
    mySets1(Ini, 'video', [TabVideo], False);
    mySets1(Ini, 'audio', [TabAudio], False);
    mySets1(Ini, 'subtitle', [TabSubtitle], False);
    Ini.Free;
    cmbProfile.Items.Clear;
    if not FileExistsUTF8(sd.FileName) then
      RenameFileUTF8(s, sd.FileName);
    myOpenDoc(myGetAnsiFN(sd.FileName));
    myGetFileList(sInidir, '*.ini', cmbProfile.Items, False, False);
    cmbProfile.Sorted := True;
  end;
end;

procedure TfrmGUIta.myDefaultSave;
var
  i: integer;
  procedure my1(c: TComponent);
  var
    i: integer;
  begin
    if (c is TComboBox) or (c is TCheckBox) then
      cDefaultSets.setval(c.Name, myGet2(c))
    else if c is TPanel then
      for i := 0 to TPanel(c).ControlCount - 1 do
        my1(TPanel(c).Controls[i]);
  end;
begin
  for i := 0 to TabSets1.ControlCount - 1 do
    my1(TabSets1.Controls[i]);
  for i := 0 to TabSets2.ControlCount - 1 do
    cDefaultSets.setval(TabSets2.Controls[i].Name, myGet2(TabSets2.Controls[i]));
  for i := 0 to TabScreenGrab.ControlCount - 1 do
    cDefaultSets.setval(TabScreenGrab.Controls[i].Name, myGet2(TabScreenGrab.Controls[i]));
  cDefaultSets.setval(chkMetadataWork.Name, myGet2(chkMetadataWork));
  cDefaultSets.setval(chkMetadataClear.Name, myGet2(chkMetadataClear));
  cDefaultSets.setval(chkConcat.Name, myGet2(chkConcat));
  cDefaultSets.setval(chkFilterComplex.Name, myGet2(chkFilterComplex));
  cDefaultSets.setval(chkx264Pass1fast.Name, myGet2(chkx264Pass1fast));
end;

procedure TfrmGUIta.myDefaultLoad;
var
  i: integer;
  procedure my2(c: TComponent);
  var
    i: integer;
  begin
    if (c is TComboBox) or (c is TCheckBox) then
      mySet2(c, cDefaultSets.getval(c.Name))
    else if c is TPanel then
      for i := 0 to TPanel(c).ControlCount - 1 do
        my2(TPanel(c).Controls[i]);
  end;
begin
  for i := 0 to TabSets1.ControlCount - 1 do
    my2(TabSets1.Controls[i]);
  for i := 0 to TabSets2.ControlCount - 1 do
    mySet2(TabSets2.Controls[i], cDefaultSets.getval(TabSets2.Controls[i].Name));
  for i := 0 to TabScreenGrab.ControlCount - 1 do
    mySet2(TabScreenGrab.Controls[i], cDefaultSets.getval(TabScreenGrab.Controls[i].Name));
end;

procedure TfrmGUIta.btnResetClick(Sender: TObject);
var
  s, t: string;
  i: integer;
  sl: TStringList;
  {$IFDEF MSWINDOWS}
  procedure myFindMediaInfo;
  var
    j: integer;
    s: string;
    reg: TRegistry;
  begin
    if not FileExistsUTF8(myExpandFN(edtMediaInfo.Text)) then
    begin
      reg := TRegistry.Create;
      try
        Reg.RootKey := HKEY_CLASSES_ROOT;
        if Reg.OpenKeyReadOnly('\SystemFileAssociations\.avi\Shell\MediaInfo\Command') then
        begin
          s := Reg.ReadString('');
          if (s <> '') and (s[1] = '"') then
          begin
            j := PosEx('"', s, 2);
            if j > 0 then
              s := Copy(s, 2, j - 2);
          end;
          if FileExistsUTF8(s) then
            mySet2(edtMediaInfo, myUnExpandFN(s));
        end;
        Reg.CloseKey;
      except
        on E: Exception do
          ShowMessage(E.Message);
      end;
      reg.Free;
    end;
  end;
  {$ENDIF}
begin
  if Sender = btnReset then
    myDefaultLoad;
  s := myGetLocaleLanguage;
  if s <> '' then
  begin
    sl := TStringList.Create;
    for i := 0 to cmbLangsList.Items.Count - 1 do
    begin
      myGetListFromStr(cmbLangsList.Items[i], '|', sl);
      if (sl.Count > 2) and (s = sl[2]) then
      begin
        s := sl[3];
        t := sl[0];
        Break;
      end;
    end;
    sl.Free;
    cmbLanguage.Text := s + '.lng';
    cmbLangA.Text := t;
  end;
  if edtxterm.Text = '' then
    myGetTerminal;
  myFindFiles(sDirApp, edtffmpeg.Text, edtffmpeg);
  myFindFiles(sDirApp, edtffprobe.Text, edtffprobe);
  myFindFiles(sDirApp, edtffplay.Text, edtffplay);
  myFindFiles(sDirApp, edtMediaInfo.Text, edtMediaInfo);
  {$IFDEF MSWINDOWS}
  myFindMediaInfo;
  {$ENDIF}
  myFindPlayers(True);
  edtDirOut.Text := myGetUserDir('VIDEOS');
  cmbProfileGetItems(cmbProfileDef);
  if cmbProfileDef.Items.Count > 0 then
    cmbProfileDef.ItemIndex := 0;
  //screen grab, fill items
  myFillSGin(cmbSGsource0.Items, 'video');
  cmbSGsource1.Items.Clear;
  cmbSGsource1.Items.AddStrings(cmbSGsource0.Items);
  myFillSGin(cmbSGsource2.Items, 'audio');
  cmbSGsource3.Items.Clear;
  cmbSGsource3.Items.AddStrings(cmbSGsource2.Items);
  //set defaults
  if cmbSGsource0.Items.Count > 0 then
    cmbSGsource0.ItemIndex := 0;
  if cmbSGsource1.Items.Count > 1 then
    cmbSGsource1.ItemIndex := 1;
  {$IFDEF MSWINDOWS}
  if cmbSGsource2.Items.Count > 0 then
    cmbSGsource2.ItemIndex := 0;
  if cmbSGsource3.Items.Count > 1 then
    cmbSGsource3.ItemIndex := 1;
  {$ELSE}
  chkSGsource1.Checked := FileExistsUTF8('/dev/video0');
  //pactl list sources
  for i := 0 to cmbSGsource2.Items.Count - 1 do
  begin
    s := cmbSGsource2.Items[i];
    if (Pos('alsa_output.', s) > 0) and (Pos('.analog', s) > 0) and (Pos('.monitor', s) > 0) then
    begin
      cmbSGsource2.ItemIndex := i;
      Break;
    end;
  end;
  for i := 0 to cmbSGsource3.Items.Count - 1 do
  begin
    s := cmbSGsource3.Items[i];
    if (Pos('alsa_input.', s) > 0) then
    begin
      cmbSGsource3.ItemIndex := i;
      Break;
    end;
  end;
  {$ENDIF}
end;

procedure TfrmGUIta.btnSaveSetsClick(Sender: TObject);
begin
  mySets(False);
end;

procedure TfrmGUIta.btnStartClick(Sender: TObject);
var
  i, iMax: integer;
  t: TTabSheet;
  m: TSynMemo;
  h: TThreadCnv2;
  li: TListItem;
begin
  myChkCpuCount;
  iMax := 0;
  for i := 0 to LVjobs.Items.Count - 1 do
    if LVjobs.Items[i].Checked then
    begin
      inc(iMax);
      if iMax > spnCpuCount.Value then Break;
    end;
  iMax := Min(iMax, spnCpuCount.Value);
  if iMax = 0 then iMax := 1;
  for i := 0 to iMax - 1 do
  begin
    if PageControl3.PageCount > iTabCount + i then
    begin
      t := PageControl3.Pages[iTabCount + i];
      m := TSynMemo(t.Controls[0]);
    end
    else
    begin
      t := PageControl3.AddTabSheet;
      t.Caption := mes[30] + ' ' + IntToStr(i + 1);
      m := TSynMemo.Create(t);
      m.Parent := t;
      m.Align := alClient;
      m.Color := clWindow;
      m.Font.Color := clWindowText;
      m.Highlighter := SynUNIXShellScriptSyn1;
    end;
    h := TThreadCnv2.Create(i, m);
    if Assigned(h.FatalException) then
      raise h.FatalException;
    h.OnTerminate := @onCnv3Terminate;
    h.Start;
    li := LVtrd.Items.Add;
    li.Caption := 'c';
    li.SubItems.Add(mes[38]); //convert
    li.Data := Pointer(h);
    Sleep(2);
  end;
end;

procedure TfrmGUIta.btnStopClick(Sender: TObject);
var
  i: integer;
  s: string;
  h: TThreadCnv2;
  t: TThreadTest;
  a: TThreadAddF;
  e: TThreadExec;
begin
  for i := 0 to LVtrd.Items.Count - 1 do
  begin
    s := LVtrd.Items[i].Caption;
    if s = 'c' then
    begin
      h := TThreadCnv2(LVtrd.Items[i].data);
      if h = nil then Exit;
      h.Terminate;
      if h.pr <> nil then
        h.pr.Terminate(-2);
      {$IFDEF MSWINDOWS}
      if h.Suspended then
        h.Resume;
      {$ENDIF}
    end
    else
    if s = 't' then
    begin
      t := TThreadTest(LVtrd.Items[i].data);
      if t = nil then Exit;
      t.Terminate;
      if t.pr <> nil then
        t.pr.Terminate(-2);
      {$IFDEF MSWINDOWS}
      if t.Suspended then
        t.Resume;
      {$ENDIF}
    end
    else
    if s = 'a' then
    begin
      a := TThreadAddF(LVtrd.Items[i].data);
      if a = nil then Exit;
      a.Terminate;
      if a.pr <> nil then
        a.pr.Terminate(-2);
      {$IFDEF MSWINDOWS}
      if a.Suspended then
        a.Resume;
      {$ENDIF}
    end
    else
    begin
      e := TThreadExec(LVtrd.Items[i].data);
      if e = nil then Exit;
      e.Terminate;
      if e.p <> nil then
        e.p.Terminate(-2);
      {$IFDEF MSWINDOWS}
      if e.Suspended then
        e.Resume;
      {$ENDIF}
    end;
  end;
end;

procedure TfrmGUIta.btnSuspendClick(Sender: TObject);
{$IFDEF MSWINDOWS}
var
  i: integer;
  s: string;
  h: TThreadCnv2;
  t: TThreadTest;
  a: TThreadAddF;
  e: TThreadExec;
begin
  for i := 0 to LVtrd.Items.Count - 1 do
  begin
    s := LVtrd.Items[i].Caption;
    if s = 'c' then
    begin
      h := TThreadCnv2(LVtrd.Items[i].data);
      if h = nil then Exit;
      if h.Suspended then
        h.Resume
      else
        h.Suspend;
    end
    else
    if s = 't' then
    begin
      t := TThreadTest(LVtrd.Items[i].data);
      if t = nil then Exit;
      if t.Suspended then
        t.Resume
      else
        t.Suspend;
    end
    else
    if s = 'a' then
    begin
      a := TThreadAddF(LVtrd.Items[i].data);
      if a = nil then Exit;
      if a.Suspended then
        a.Resume
      else
        a.Suspend;
    end
    else
    begin
      e := TThreadExec(LVtrd.Items[i].data);
      if e = nil then Exit;
      if e.Suspended then
        e.Resume
      else
        e.Suspend;
    end;
  end;
  {$ELSE}
begin
  {$ENDIF}
end;

procedure TfrmGUIta.btnTestClick(Sender: TObject);
var
  t: TThreadTest;
  li: TListItem;
begin
  if LVjobs.Selected = nil then
    Exit;
  t := TThreadTest.Create(LVjobs.Selected);
  if Assigned(t.FatalException) then
    raise t.FatalException;
  t.OnTerminate := @onCnv3Terminate;
  t.Start;
  li := LVtrd.Items.Add;
  li.Caption := 't';
  li.SubItems.Add(mes[39]); //test
  li.Data := Pointer(t);
  PageControl3.ActivePage := TabConsole3;
end;

procedure TfrmGUIta.chk1instanceChange(Sender: TObject);
begin
  if bUpdFromCode then Exit;
  if chk1instance.Checked then
  begin;
    if myUnik = nil then
    begin
      myUnik := TUniqueInstance.Create(Self);
      myUnik.OnOtherInstance := @UniqueInstance1OtherInstance;
      myUnik.Enabled := True;
      myUnik.Loaded;
    end
    else
      myUnik.Enabled := True;
  end
  else
  begin
    if myUnik <> nil then
    begin
      myUnik.Enabled := False;
    end;
  end;
end;

procedure TfrmGUIta.chkAddTracksChange(Sender: TObject);
begin
  //cmbAddTracks.Enabled := chkAddTracks.Checked;
end;

procedure TfrmGUIta.chkFilterComplexChange(Sender: TObject);
var
  b: boolean;
begin
  xmyChange0(Sender);
  b := not chkFilterComplex.Checked;
  cmbFilterComplex.Enabled := not b;
  //for i := 0 to TabVideo do if controls[i].Tag = 2 then
  cmbCrop.Enabled := b;
  cmbScale.Enabled := b;
  cmbPad.Enabled := b;
  cmbhqdn3d.Enabled := b;
  cmbSetDAR.Enabled := b;
  cmbRotate.Enabled := b;
  cmbFiltersV.Enabled := b;
  cmbFiltersA.Enabled := b;
end;

procedure TfrmGUIta.chkLangA1Change(Sender: TObject);
begin
  if chkLangA1.Checked then
    chkLangA2.Checked := False;
end;

procedure TfrmGUIta.chkLangA2Change(Sender: TObject);
begin
  if chkLangA2.Checked then
    chkLangA1.Checked := False;
end;

procedure TfrmGUIta.chkLangS1Change(Sender: TObject);
begin
  if chkLangS1.Checked then
    chkLangS2.Checked := False;
end;

procedure TfrmGUIta.chkLangS2Change(Sender: TObject);
begin
  if chkLangS2.Checked then
    chkLangS1.Checked := False;
end;

procedure TfrmGUIta.chkPlayer2Change(Sender: TObject);
begin
  if chkPlayer2.Checked then
    chkPlayer3.Checked := False;
end;

procedure TfrmGUIta.chkPlayer3Change(Sender: TObject);
begin
  if chkPlayer3.Checked then
    chkPlayer2.Checked := False;
  //cmbExtPlayer.Enabled := chkPlayer3.Checked;
end;

procedure TfrmGUIta.chkSGmixvideoChange(Sender: TObject);
var
  f, m: string;
  bv: boolean;
  i: integer;
begin
  f := '';
  m := '';
  bv := chkSGmixvideo.Checked and chkSGsource0.Checked and chkSGsource1.Checked;
  if bv then
  begin
    f := '[0][1]overlay=main_w-overlay_w-2:main_h-overlay_h-2[v]';
    m := ' -map [v]';
  end;
  if chkSGmixaudio.Checked and chkSGsource2.Checked and chkSGsource3.Checked then
  begin
    if f <> '' then
    begin
      f := f + ', [2][3]amix=inputs=2[a]';
      m := m + ' -map [a]';
    end
    else
    begin
      f := f + 'amix=inputs=2';
    end;
  end
  else if bv then
  begin
    if chkSGsource2.Checked or (not chkSGsource2.Checked and chkSGsource3.Checked) then
      m := m + ' -map 2:0';
    if chkSGsource2.Checked and chkSGsource3.Checked then
      m := m + ' -map 3:0';
  end;
  cmbSGfiltercomplex.Text := f;
  for i := 0 to cmbSGaddoptsO.Items.Count - 1 do
    if Copy(cmbSGaddoptsO.Text, 1, 12) = Copy(cmbSGaddoptsO.Items[i], 1, 12) then
      cmbSGaddoptsO.Text := cmbSGaddoptsO.Items[i] + m;
end;

procedure TfrmGUIta.chkSynColorChange(Sender: TObject);
begin
  if chkSynColor.Checked then  //if dark theme
  begin
    SynUNIXShellScriptSyn1.CommentAttri.Foreground := clLime;  //Green
    SynUNIXShellScriptSyn1.NumberAttri.Foreground := TColor($FF8800); //Blue
    SynUNIXShellScriptSyn1.SecondKeyAttri.Foreground := clRed; //Maroon
    SynUNIXShellScriptSyn1.StringAttri.Foreground := clYellow; //Olive
    SynUNIXShellScriptSyn1.SymbolAttri.Foreground := clAqua;  //Teal
    SynUNIXShellScriptSyn1.VarAttri.Foreground := clFuchsia;   //Purple
  end
  else //if light theme
  begin
    SynUNIXShellScriptSyn1.CommentAttri.Foreground := clGreen;
    SynUNIXShellScriptSyn1.NumberAttri.Foreground := clNavy;
    SynUNIXShellScriptSyn1.SecondKeyAttri.Foreground := clMaroon;
    SynUNIXShellScriptSyn1.StringAttri.Foreground := clOlive;
    SynUNIXShellScriptSyn1.SymbolAttri.Foreground := clTeal;
    SynUNIXShellScriptSyn1.VarAttri.Foreground := clPurple;
  end;
  if chkDebug.Checked then
    myWindowColorIsDark;
end;

procedure TfrmGUIta.chkMetadataWorkChange(Sender: TObject);
var
  b: boolean;
begin
  b := chkMetadataWork.Checked;
  chkMetadataClear.Enabled := b;
  b := b and not chkMetadataClear.Checked;
  //for i := 0 to TabOutput do if controls[i].Tag = 5 then
  lblTagTitleOut.Enabled := b;
  lblTagTitleV.Enabled := b;
  lblTagTitleA.Enabled := b;
  lblTagTitleS.Enabled := b;
  lblTagLangV.Enabled := b;
  lblTagLangA.Enabled := b;
  lblTagLangS.Enabled := b;
  cmbTagTitleOut.Enabled := b;
  cmbTagTitleV.Enabled := b;
  cmbTagTitleA.Enabled := b;
  cmbTagTitleS.Enabled := b;
  cmbTagLangV.Enabled := b;
  cmbTagLangA.Enabled := b;
  cmbTagLangS.Enabled := b;
  xmyChange0(Sender);
  {$IFDEF MSWINDOWS}
  //in win, quotes in metadata works ok
  {$ELSE}
  if b then
    StatusBar1.SimpleText := 'Enable: ' + chkxtermconv.Caption;
  {$ENDIF}
end;

procedure TfrmGUIta.chkUseEditedCmdChange(Sender: TObject);
begin
  if bUpdFromCode then Exit;
  xmyChange0(Sender);
  if chkUseEditedCmd.Checked then
    xmyChange0(memCmdlines)
  else
    TabCmdlineShow(nil);
end;

procedure TfrmGUIta.chkUseMasksChange(Sender: TObject);
var
  b: boolean;
begin
  b := chkUseMasks.Checked;
  LVmasks.Enabled := b;
  btnMaskAdd.Enabled := b;
  btnMaskDel.Enabled := b;
  btnMaskEdit.Enabled := b;
end;

procedure TfrmGUIta.cmbBitrateAChange(Sender: TObject);
var
  b: boolean;
begin
  b := Pos('$koefa', cmbBitrateA.Text) > 0;
  spnKoefA.Enabled := b;
  lblkoefA.Enabled := b;
  xmyChange2a(Sender);
end;

procedure TfrmGUIta.cmbBitrateVChange(Sender: TObject);
var
  b: boolean;
begin
  b := Pos('$koefv', cmbBitrateV.Text) > 0;
  spnKoefV.Enabled := b;
  lblkoefV.Enabled := b;
  xmyChange2v(Sender);
end;

procedure TfrmGUIta.cmbEncoderVChange(Sender: TObject);
var
  b1, b2, b3, b4, b5: boolean;
  i: integer;
  s: string;
  c: TWinControl;
begin
  if (Sender is TComboBox) then
  begin
    with (Sender as TComboBox) do
    if (Items.Count > 0) and (Items.IndexOf(Text) < 0) then
      Font.Color := clRed
    else
      Font.Color := clWindowText;
  end;
  s := TComboBox(Sender).Text;
  b1 := (s <> 'copy');
  b2 := b1 and not chkFilterComplex.Checked;
  b3 := (Pos('x264', s) > 0);
  b4 := (Pos('x265', s) > 0);
  b5 := b1 and chkMetadataWork.Checked;
  c := TControl(Sender).Parent;
  for i := 0 to c.ControlCount - 1 do
    if c.Controls[i].Name <> TControl(Sender).Name then
      c.Controls[i].Enabled := (b1 and (c.Controls[i].Tag = 0))
                            or (b2 and (c.Controls[i].Tag = 2))
                            or ((b3 or b4) and (c.Controls[i].Tag = 4))
                            or (b5 and (c.Controls[i].Tag = 5));
  cmbx264tune.Items.Clear;
  if b3 then //x264
    cmbx264tune.Items.AddStrings(['', 'film', 'animation', 'grain', 'stillimage', 'psnr', 'ssim', 'fastdecode', 'zerolatency']);
  if b4 then //x265
    cmbx264tune.Items.AddStrings(['', 'psnr', 'ssim', 'grain', 'zerolatency', 'fastdecode']);
  //to do: parse output: ffmpeg -f lavfi -i nullsrc -c:v libx264 -preset help -f mp4 -
  //[libx264 @ 0xb02de60] Possible presets: ultrafast superfast veryfast faster fast medium slow slower veryslow placebo
  //[libx264 @ 0xb02de60] Possible tunes: film animation grain stillimage psnr ssim fastdecode zerolatency
  xmyChange2(Sender);
end;

procedure TfrmGUIta.cmbExtChange(Sender: TObject);
var
  s: string;
  i: integer;
begin
  s := cmbExt.Text;
  if (cmbExt.Items.Count > 0) and (cmbExt.Items.IndexOf(s) < 0) then
  begin
    cmbExt.Font.Color := clRed;
    Exit;
  end
  else
    cmbExt.Font.Color := clWindowText;
  i := Length(s);
  if (i = 0) or ((i > 0) and (s[1] <> '.')) then
    s := '.' + s;
  if s <> '.tee' then
    edtOfn.Text := ChangeFileExt(edtOfn.Text, s);
  if Sender = cmbExt then
    if cmbExt.Items.IndexOf(s) < 0 then
      cmbFormat.Text := ''
    else if s <> '' then
    begin
      i := cmbExt.Items.IndexOf(s);
      if i >= 0 then
        cmbFormat.ItemIndex := i;
    end;
  xmyChange0(cmbExt);
end;

procedure TfrmGUIta.cmbExtGetItems(Sender: TObject);
begin
  if cmbExt.Items.Count > 0 then Exit;
  myFillFmt;
end;

procedure TfrmGUIta.cmbExtPlayerChange(Sender: TObject);
begin
  if FileExistsUTF8(cmbExtPlayer.Text) then
    myAdd2cmb(cmbExtPlayer, cmbExtPlayer.Text);
end;

procedure TfrmGUIta.cmbExtPlayerGetItems(Sender: TObject);
begin
  if cmbExtPlayer.Items.Count = 0 then
    myFindPlayers(False);
end;

procedure TfrmGUIta.cmbExtSelect(Sender: TObject);
begin
  if cmbFormat.Items.Count >= cmbExt.ItemIndex + 1 then
  begin
    cmbFormat.ItemIndex := cmbExt.ItemIndex;
    xmyChange0(cmbFormat);
  end;
end;

procedure TfrmGUIta.cmbFontGetItems(Sender: TObject);
begin
  cmbFont.Items.Clear;
  cmbFont.Items.Assign(Screen.Fonts);
end;

procedure TfrmGUIta.cmbFontSelect(Sender: TObject);
begin
  frmGUIta.Font.Name := cmbFont.Text;
end;

procedure TfrmGUIta.cmbFormatChange(Sender: TObject);
begin
  if (cmbFormat.Items.Count > 0) and (cmbFormat.Items.IndexOf(cmbFormat.Text) < 0) then
    cmbFormat.Font.Color := clRed
  else
    cmbFormat.Font.Color := clWindowText;
  xmyChange0(Sender);
end;

procedure TfrmGUIta.cmbFormatGetItems(Sender: TObject);
begin
  if cmbFormat.Items.Count > 0 then Exit;
  myFillFmt;
end;

procedure TfrmGUIta.cmbFormatSelect(Sender: TObject);
begin
  if cmbExt.Items.Count >= cmbFormat.ItemIndex + 1 then
  begin
    cmbExt.ItemIndex := cmbFormat.ItemIndex;
    cmbExtChange(Sender);
  end;
end;

procedure TfrmGUIta.cmbLanguageChange(Sender: TObject);
begin
  if FileExistsUTF8(AppendPathDelim(sInidir) + cmbLanguage.Text) then
    myLanguage(True);
end;

procedure TfrmGUIta.cmbLanguageGetItems(Sender: TObject);
begin
  if cmbLanguage.Items.Count > 0 then Exit;
  cmbLanguage.Items.Clear;
  myGetFileList(sInidir, '*.lng', cmbLanguage.Items, False, False);
  cmbLanguage.Sorted := True;
end;

procedure TfrmGUIta.cmbProfileChange(Sender: TObject);
var
  s, u, se: string;
  Ini: TIniFile;
  jo: TJob;
  c: TCont;
  i, k, l: integer;
  t: TTabSheet;
begin
  s := AppendPathDelim(sInidir) + TComboBox(Sender).Text;
  if not FileExistsUTF8(s) then
  begin
    TComboBox(Sender).Font.Color := clRed;
    Exit;
  end
  else
    TComboBox(Sender).Font.Color := clWindowText;
  if myCantUpd(0) then
    Exit;
  {$IFDEF MSWINDOWS}
  s := myGetAnsiFN(s);
  {$ENDIF}
  Ini := TIniFile.Create(UTF8ToSys(s));
  jo := TJob(LVjobs.Selected.Data);
  jo.setval(TComboBox(Sender).Name, TComboBox(Sender).Text);
  for i := 0 to TabOutput.ControlCount - 1 do
  if not (TabOutput.Controls[i].Tag in [1, 3]) then
  begin
    s := Ini.ReadString('1', TabOutput.Controls[i].Name, '');
    jo.setval(TabOutput.Controls[i].Name, s);
  end;
  se := Ini.ReadString('1', cmbExt.Name, '');
  jo.setval(edtOfn.Name, ChangeFileExt(jo.getval(edtOfn.Name), se));
  {$IFDEF MSWINDOWS}
  jo.setval(edtOfna.Name, ChangeFileExt(jo.getval(edtOfna.Name), se));
  {$ENDIF}
  for l := 0 to High(jo.f) do
  begin
    for i := 0 to TabInput.ControlCount - 1 do
    if not (TabInput.Controls[i].Tag in [1, 3]) then
    begin
      s := Ini.ReadString('input', TabInput.Controls[i].Name, '');
      jo.f[l].setval(TabInput.Controls[i].Name, s);
    end;
    for k := 0 to High(jo.f[l].s) do
    begin
      c := jo.f[l].s[k];
      u := c.getval('codec_type');
      if u = 'video' then
        t := TabVideo
      else if u = 'audio' then
        t := TabAudio
      else if u = 'subtitle' then
        t := TabSubtitle
      else
        Continue;
      for i := 0 to t.ControlCount - 1 do
      if not (t.Controls[i].Tag in [1, 3]) then
      begin
        s := Ini.ReadString(u, t.Controls[i].Name, '');
        c.setval(t.Controls[i].Name, s);
      end;
      if u = 'video' then
        c.setval(edtBitrateV.Name, myCalcBRv(c))
      else if u = 'audio' then
        c.setval(edtBitrateA.Name, myCalcBRa(c));
    end;
  end;
  Ini.Free;
  LVjobs.Selected.SubItems[3] := myCalcOutSize(jo);
  LVjobsSelectItem(Sender, LVjobs.Selected, True);
end;

procedure TfrmGUIta.cmbProfileDefChange(Sender: TObject);
begin
  if not FileExistsUTF8(AppendPathDelim(sInidir) + TComboBox(Sender).Text) then
    TComboBox(Sender).Font.Color := clRed
  else
    TComboBox(Sender).Font.Color := clWindowText;
end;

procedure TfrmGUIta.cmbProfileGetItems(Sender: TObject);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  myGetFileList(sInidir, '*.ini', sl, False, False);
  if sl.Count <> TComboBox(Sender).Items.Count then
  begin
    TComboBox(Sender).Items.AddStrings(sl, True);
    TComboBox(Sender).Sorted := True;
  end;
  sl.Free;
end;

procedure TfrmGUIta.cmbRunCmdGetItems(Sender: TObject);
var
  i: integer;
begin
  if cmbRunCmd.Items.Count > 0 then Exit;
  for i := 0 to High(cCmdIni.sk) do
    myAdd2cmb(cmbRunCmd, cCmdIni.sk[i]);
end;

procedure TfrmGUIta.cmbSGsource0GetItems(Sender: TObject);
begin
  myFillSGin(TComboBox(Sender).Items, 'video');
end;

procedure TfrmGUIta.cmbSGsource2GetItems(Sender: TObject);
begin
  myFillSGin(TComboBox(Sender).Items, 'audio');
end;

procedure TfrmGUIta.edtDirOutChange(Sender: TObject);
begin
  xmyCheckDir(Sender);
  chkDirOutStruct.Enabled := edtDirOut.Text <> '';
end;

procedure TfrmGUIta.edtffmpegGetItems(Sender: TObject);
var
  s, t: string;
begin
  if TComboBox(Sender).Items.Count = 0 then
  begin
    s := sDirApp;
    {$IFDEF MSWINDOWS}
    t := Copy(TComboBox(Sender).Name, 4, 100) + GetExeExt;
    {$ELSE}
    t := Copy(TComboBox(Sender).Name, 4, 100);
    if Sender = edtMediaInfo then //bad code
      t := 'mediainfo-gui';
    {$ENDIF}
    //if not InputQuery(mes[20] + ' ' + t, mes[28], s) then
    //  Exit;
    myFindFiles(s, t, TComboBox(Sender), False);
  end;
end;

procedure TfrmGUIta.edtOfnChange(Sender: TObject);
var
  sd, se: string;
begin
  sd := ExtractFileDir(edtOfn.Text);
  if (sd = '') or DirectoryExistsUTF8(sd) then
  begin
    TWinControl(Sender).Font.Color := clWindowText;
    pnlOutSize.Caption := myGetFileSize(edtOfn.Text);
  end
  else
  begin
    TWinControl(Sender).Font.Color := clRed;
    sd := '';
  end;
  if myCantUpd(0) then
    Exit;
  xmyChange0(Sender);
  se := ExtractFileExt(edtOfn.Text);
  {$IFDEF MSWINDOWS}
  if FileExistsUTF8(edtOfn.Text) then
    edtOfna.Text := myGetAnsiFN(edtOfn.Text)
  else if LVjobs.Selected <> nil then
    edtOfna.Text := myGetOutFNa(sd, TJob(LVjobs.Selected.Data).f[0].getval(sMyDOSfname), se)
  else
    edtOfna.Text := '';
  {$ENDIF}
  if cmbExt.Text <> '.tee' then
  begin
    cmbExt.Text := se;
    cmbExtChange(cmbExt);
  end;
  xmyChange0(cmbFormat);
  TJob(LVjobs.Selected.Data).setval(sMyBakfname, ExtractFileName(edtOfn.Text));
end;

procedure TfrmGUIta.edtxtermGetItems(Sender: TObject);
begin
  if edtxterm.Items.Count = 0 then
    myGetTerminal;
end;

procedure TfrmGUIta.edtxtermSelect(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  if edtxterm.Text = 'cmd.exe' then begin
    edtxtermopts.Text := '/c';
    chkxterm1str.Checked := False;
  end;
  {$ELSE}
  if edtxterm.Text = '/bin/sh' then begin
    edtxtermopts.Text := '-c';
    chkxterm1str.Checked := True;
  end else
  if edtxterm.Text = '/usr/bin/xterm' then begin
    edtxtermopts.Text := '-e';
    chkxterm1str.Checked := True;
  end else
  if edtxterm.Text = '/usr/bin/konsole' then begin
    edtxtermopts.Text := '--nofork -e';
    chkxterm1str.Checked := True;
  end else
  if edtxterm.Text = '/usr/bin/gnome-terminal' then begin
    edtxtermopts.Text := '-x';
    chkxterm1str.Checked := True;
  end else
  if edtxterm.Text = '/usr/bin/xfce4-terminal' then begin
    edtxtermopts.Text := '-x';
    chkxterm1str.Checked := True;
  end;
  {$ENDIF}
end;

procedure TfrmGUIta.FormCreate(Sender: TObject);
var
  s: string;
begin
  memJournal.Clear;
  sCap := 'ffmpegGUIta ' + taVersion + '.' + taRevision + ' alpha';
  frmGUIta.Caption := sCap;
  memJournal.Lines.Add(sCap + ' - ' + taBuildDate + ' - Free Pascal ' +
    fpcVersion + ' - Lazarus ' + lazVersion + '-' + lazRevision +
    ' - ' + TargetCPU + ' ' + TargetOS);
  Files2Add := TList.Create;
  cDefaultSets := TCont.Create;
  cCmdIni := TCont.Create;
  Counter := 0;
  fs.DecimalSeparator := '.';
  fs.ThousandSeparator := ' ';
  DuraAll := 0;
  iTabCount := PageControl3.PageCount; //backup page count, for thread count
  //get inifile location
  s := ChangeFileExt(ExtractFileName(Application.ExeName), '.cfg');
  sDirApp := ExtractFilePath(Application.ExeName);
  sInidir := GetAppConfigDirUTF8(False, True);
  sInifile := AppendPathDelim(sDirApp) + s;
  if FileExistsUTF8(sIniFile) then //if portable
  begin
    if FileIsWritable(sIniFile) then
      sInidir := sDirApp
    else
    begin
      sInifile := AppendPathDelim(sInidir) + s;
      if not FileExistsUTF8(sIniFile) then //if app is executed in readonly folder
        FileUtil.CopyFile(AppendPathDelim(sDirApp) + s, sIniFile, False);
    end;
  end
  else
  begin
    sInifile := AppendPathDelim(sInidir) + s;
    if not FileExistsUTF8(sIniFile) and DirectoryIsWritable(sDirApp) then //if first start then default is portable
    begin
      sInidir := sDirApp;
      sInifile := AppendPathDelim(sInidir) + s;
    end;
  end;
  memJournal.Lines.Add(sInifile);
  //hide some unused components
  {$IFDEF MSWINDOWS}
  //nothing to hide
  {$ELSE}
  btnAddFilesAsAvs1.Visible := False;
  btnAddFilesAsAvs2.Visible := False;
  btnSuspend.Visible := False; //pause external process doesnt work on linux
  mnuCopyAsAvs.Visible := False;
  mnuEditAvs.Visible := False;
  mnuPasteAsAvs1.Visible := False;
  mnuPasteAsAvs2.Visible := False;
  edtOfna.Visible := False;
  chkCreateDosFN.Visible := False;
  chkCreateSymLink.Visible := False;
  {$ENDIF}
  //set some defaults
  bUpdFromCode := True;
  cmbDirLast.Text := GetCurrentDir;
  {$IFDEF MSWINDOWS}
  edtffmpeg.Text := 'ffmpeg.exe';
  edtffplay.Text := 'ffplay.exe';
  edtffprobe.Text:= 'ffprobe.exe';
  edtDirTmp.Text := '%TEMP%';
  edtDirOut.Text := '';
  edtMediaInfo.Text := '%ProgramFiles%\MediaInfo\MediaInfo.exe';
  cmbExtPlayer.Text := '%ProgramFiles%\Windows Media Player\wmplayer.exe';
  cmbDirLast.Text := 'C:\';
  //screen grab
  cmbSGsource0.Text := '-f dshow -i video="screen-capture-recorder"';
  chkSGsource1.Checked := False;
  cmbSGsource1.Text := '';
  chkSGsource2.Checked := False;
  cmbSGsource2.Text := '';
  cmbSGsource3.Text := '-f dshow -i audio="virtual-audio-capturer"';
  chkSGmixvideo.Checked := False;
  chkSGmixaudio.Checked := False;
  cmbSGfiltercomplex.Text := '';
  cmbSGaddoptsO.Text := '-c:v libvpx -b:v 3M -quality realtime -deadline realtime -c:a libvorbis -b:a 320k';
  cmbSGoutext.Text := '.webm';
  {$ELSE}
  edtffmpeg.Text := 'ffmpeg';
  edtffplay.Text := 'ffplay';
  edtffprobe.Text:= 'ffprobe';
  edtDirTmp.Text := '/tmp';
  edtDirOut.Text := '';
  edtMediaInfo.Text:= 'mediainfo-gui';
  cmbExtPlayer.Text := 'mplayer';
  cmbDirLast.Text := '$HOME';
  cmbFont.Text := 'Ubuntu';
  edtxterm.Text := '';
  edtxtermopts.Text := '';
  chkxterm1str.Checked := True;
  //screen grab
  cmbSGsource0.Text := '-f x11grab -framerate 30 -video_size '
  + IntToStr(Screen.Width) + 'x'+ IntToStr(Screen.Height)
  + ' -i ' + GetEnvironmentVariableUTF8('DISPLAY');
  cmbSGsource1.Text := '-f v4l2 -framerate 30 -video_size 160x120 -i /dev/video0';
  cmbSGsource2.Text := '-f pulse -ac 2 -ar 44100 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor';
  cmbSGsource3.Text := '-f pulse -ac 2 -ar 48000 -i alsa_input.pci-0000_00_1b.0.analog-stereo';
  cmbSGfiltercomplex.Text := '[0][1]overlay=main_w-overlay_w-2:main_h-overlay_h-2[v], [2][3]amix=inputs=2[a]';
  cmbSGaddoptsO.Text := '-c:v libvpx -b:v 3M -quality realtime -deadline realtime -c:a libvorbis -b:a 320k -map [v] -map [a]';
  cmbSGoutext.Text := '.webm';
  {$ENDIF}
  bUpdFromCode := False;
  chkSynColor.Checked := myWindowColorIsDark;
  myDefaultSave; //save defaults to container
  if FileExistsUTF8(sInifile) then //if config file exists then
    mySets(True)                   //load settings from config file
  else
  begin                            //assign some sets
    btnResetClick(nil);
    btnMaskResetClick(nil);
  end;
  chkPlayer3Change(nil);
  chk1instanceChange(nil);
  myLanguage(True, True); //load language
  frmGUIta.Font.Name := cmbFont.Text;
  myChkCpuCount; //process count for single thread formats: png xvid etc
  cmbProfileChange(cmbProfileDef);
  myFillEnc;
  myFillFmt;
  {$IFDEF MSWINDOWS}
  myGetFileList(sInidir, '*.ini', cmbProfileDef.Items, False, False);
  {$ENDIF}
end;

procedure TfrmGUIta.FormDestroy(Sender: TObject);
begin
  if chkSaveOnExit.Checked then
    mySets(False);
  Files2Add.Free;
  cDefaultSets.Free;
  cCmdIni.Free;
end;

procedure TfrmGUIta.FormDropFiles(Sender: TObject; const FileNames: array of string);
var
  i: integer;
  ST: TStringList;
  p: TPoint;
  wc: TWinControl;
  w: word;
begin
  p.x := 0;
  p.y := 0;
  GetCursorPos(p);
  wc := FindControl(WindowFromPoint(p));
  StatusBar1.SimpleText := wc.Name;
  {$IFDEF MSWINDOWS}
  if wc.Name = btnAddFilesAsAvs1.Name then
    w := 1
  else
  if wc.Name = btnAddFilesAsAvs2.Name then
    w := 2
  else
  {$ENDIF}
  if (LVjobs.Selected <> nil)
  and ((wc.Name = LVstreams.Name) or (wc.Name = LVfiles.Name)) then
    w := 3
  else
  if (LVjobs.Selected <> nil) and (wc.Name = edtOfn.Name) then
    w := 4
  else
  if wc.Name = btnAddFileSplit.Name then
    w := 5
  else
    w := 0;
  ST := TStringList.Create;
  try
    for i := Low(FileNames) to High(FileNames) do
      ST.Add(FileNames[i]);
    if ST.Count > 0 then
      case w of
        {$IFDEF MSWINDOWS}
        1: myAddFilesAsAVS1(ST);
        2: myAddFilesAsAVS2(ST);
        {$ENDIF}
        3: myAddFilesPlus(LVjobs.Selected, ST);
        4: edtOfn.Text := ST[0];
        5: myAddFileSplit(ST);
        else
          myAddFiles(ST);
      end;
  except
    on E: Exception do
      ShowMessage(E.Message)
  end;
  ST.Free;
end;

procedure TfrmGUIta.FormShow(Sender: TObject);
var
  i: integer;
  s: string;
  {$IFDEF MSWINDOWS}
  t: string;
  b: boolean;
  SP,
  {$ENDIF}
  SL: TStringList;
begin
  try
    SL := TStringList.Create;
    if ParamCount > 0 then
    begin
      {$IFDEF MSWINDOWS}
      SP := TStringList.Create;
      CommandToList(UTF8Encode(WideString(GetCommandLineW)), SP);
      while SP.Count <= ParamCount do
        SP.Add('');
      {$ENDIF}
      for i := 1 to ParamCount do
      begin
        s := ParamStrUTF8(i); //UTF8 from Lazarus for test params
        {$IFDEF MSWINDOWS}
        if not (FileExistsUTF8(s) or DirectoryExistsUTF8(s)) then
          s := SP[i]; //UTF16 from Windows apps
        b := False;
        if Pos('~', s) > 1 then //expand 8.3 filename
        begin
          t := myExpandFileNameCaseW(s, b);
          if b then
            s := t;
        end;
        {$ENDIF}
        SL.Add(s);
      end;
      {$IFDEF MSWINDOWS}
      SP.Free;
      {$ENDIF}
    end
    else if myGetFileList(GetCurrentDir, myGetExts, SL, True) then
      SL.Sort;
    if SL.Count > 0 then
      myAddFiles(SL);
    SL.Free;
  except
    on E: Exception do
      ShowMessage(E.Message)
  end;
end;

procedure TfrmGUIta.LVfilesSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  i, j, l, m: integer;
  jo: TJob;
  s: string;
begin
  if (LVjobs.Selected = nil) then Exit;
  if (LVfiles.Selected = nil) then Exit;
  jo := TJob(LVjobs.Selected.Data);
  l := LVfiles.Selected.Index;
  if (l < 0) and (l > High(jo.f)) then Exit;
  myGetValsFromCont(TabInput, TCont(jo.f[l]));
  if bUpdFromCode then Exit;
  bUpdFromCode := True;
  j := -1;
  m := -1;
  if LVstreams.Selected <> nil then
  begin
    s := LVstreams.Selected.Caption;
    if (Length(s) > 0) and (s[1] = IntToStr(l)) then
      j := LVstreams.Selected.Index;
  end;
  if j < 0 then
  for i := 0 to LVstreams.Items.Count - 1 do
  begin
    s := LVstreams.Items[i].Caption;
    if (Length(s) > 0) and (s[1] = IntToStr(l)) then
    begin
      if (j < 0) and LVstreams.Items[i].Checked then
        j := i;
      if (m < 0) then
        m := i;
    end;
    LVstreams.Items[i].Selected := False;
  end;
  if (j >= 0) then
    i := j
  else if (m >= 0) then
    i := m
  else
    i := -1;
  bUpdFromCode := False;
  if (i >= 0) then
    LVstreams.Items[i].Selected := True;
end;

procedure TfrmGUIta.LVjobsClick(Sender: TObject);
begin
  if LVjobs.Selected = nil then
  begin
    edtOfn.EditLabel.Caption := mes[7];
    myClear2([TabInput, TabOutput, TabVideo, TabAudio, TabSubtitle, TabContRows, TabCmdline]);
    LVfiles.Clear;
    LVstreams.Clear;
    myDisComp;
  end;
end;

procedure TfrmGUIta.LVjobsContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: boolean);
begin
  myDisComp;
end;

procedure TfrmGUIta.LVjobsCustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  var DefaultDraw: Boolean);
var
  b, c: TColor;
  mRect: TRect;
  i, w: integer;
begin
  if (Sender = LVjobs) then
  begin
    if TJob(Item.Data) = nil then
      Exit;
    if (SubItem = 1) then
    begin
      i := StrToIntDef(TJob(Item.Data).getval(sMyCompleted), 3);
      if (i > 3) or (i < 0) then
        i := 3;
      b := cStatusB[i];
      c := cStatusC[i];
      w := 0;
      for i := 0 to SubItem - 1 do
        w := w + LVjobs.Columns[i].Width;
      mRect := Item.DisplayRect(drBounds);
      Sender.Canvas.Brush.Color := b;
      Sender.Canvas.Font := LVjobs.Font;
      Sender.Canvas.Font.Color := c;
      Sender.Canvas.TextOut(mRect.Left + w, mRect.Top, Item.SubItems[SubItem - 1]);
      DefaultDraw := false;
    end;
  end;
end;

procedure TfrmGUIta.LVjobsDragDrop(Sender, Source: TObject; X, Y: integer);
var
  currentItem, nextItem, dragItem, dropItem: TListItem;
  i: integer;
  b: boolean;
begin
  if Sender <> Source then Exit;
  with TListView(Sender) do
  begin
    dropItem := GetItemAt(X, Y);
    currentItem := Selected;
    b := Selected.Checked;
    while currentItem <> nil do
    begin
      nextItem := nil;
      for i := 0 to Items.Count - 1 do
        if (Items[i].Selected) and (currentItem.Index <> i) then
        begin
          nextItem := Items[i];
          break;
        end;
      if Assigned(dropItem) then
      begin
        dragItem := Items.Insert(dropItem.Index);
        dragItem.Checked := b;
      end
      else
        dragItem := Items.Add;
      dragItem.Assign(currentItem);
      currentItem.Free;
      currentItem := nextItem;
    end;
  end;
end;

procedure TfrmGUIta.LVjobsDragOver(Sender, Source: TObject; X, Y: integer;
  State: TDragState; var Accept: boolean);
begin
  Accept := (Sender = Source);
end;

procedure TfrmGUIta.LVjobsItemChecked(Sender: TObject; Item: TListItem);
var
  i: integer;
  jo: TJob;
begin
  DuraAll := 0;
  DuraAl2 := 0;
  for i := 0 to LVjobs.Items.Count - 1 do
    if LVjobs.Items[i].Checked then
    begin
      jo := TJob(LVjobs.Items[i].Data);
      DuraAll := DuraAll + myTimeStrToReal(jo.f[0].getval('duration'));
      inc(DuraAl2);
    end;
  myShowCaption('');
end;

procedure TfrmGUIta.LVjobsKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) then
    if (Key = 86) then
      mnuPasteClick(mnuPaste);
  if (Shift = [ssShift]) then
    if (Key = VK_INSERT) then
      mnuPasteClick(mnuPaste);
end;

procedure TfrmGUIta.LVjobsSelectItem(Sender: TObject; Item: TListItem;
  Selected: boolean);
var
  i, k, l: integer;
  jo: TJob;
  li: TListItem;
begin
  if bUpdFromCode then Exit;
  bUpdFromCode := True;
  LVfiles.Clear;
  LVstreams.Clear;
  myClear2([TabInput, TabOutput, TabVideo, TabAudio, TabSubtitle, TabContRows, TabCmdline]);
  if LVjobs.Selected <> nil then
    jo := TJob(LVjobs.Selected.Data)
  else
    jo := TJob(Item.Data); //bug
  myGetValsFromCont(TabOutput, jo);
  myGetValsFromCont(TabCmdline, jo);
  for l := 0 to High(jo.f) do
  begin
    li := LVfiles.Items.Add;
    li.Caption := IntToStr(l);;
    li.SubItems.Add(jo.f[l].getval(sMyFilename));
  end;
  for i := 0 to High(jo.m) do
  begin
    myGetFileStreamNums(jo.m[i], l, k);
    li := LVstreams.Items.Add;
    li.Checked := jo.f[l].s[k].getval('Checked') = '1';
    li.Caption := jo.m[i];
    li.SubItems.Add(myGetCaptionCont(jo.f[l].s[k]));
  end;
  cmbProfile.Text := jo.getval(cmbProfile.Name);
  //cmbProfileChange(cmbProfile);
  bUpdFromCode := False;
  myDisComp;
  if (PageControl2.ActivePage = TabVideo)
  or (PageControl2.ActivePage = TabAudio)
  or (PageControl2.ActivePage = TabSubtitle) then
    TabVideoShow(PageControl2.ActivePage)
  else if LVstreams.Items.Count > 0 then
    LVstreams.Items[0].Selected := True;
  if PageControl2.ActivePage = TabCmdline then
    TabCmdlineShow(Sender);
  if PageControl2.ActivePage = TabContRows then
    TabContRowsShow(Sender);
end;

procedure TfrmGUIta.LVmasksCustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  var DefaultDraw: Boolean);
var
  b, c: TColor;
  mRect: TRect;
  i: integer;
  s: string;
begin
  DefaultDraw := True;
  if Item.Selected then
  begin
    b := clHighlight;
    c := clHighlightText;
  end
  else
  begin
    b := clWindow;
    c := clWindowText;
  end;
  Sender.Canvas.Brush.Color := b;
  Sender.Canvas.Font.Color := c;
  if (Item.SubItems.Count > 0) and (SubItem = 2) then
  begin
    mRect := Item.DisplayRect(drBounds);
    for i := SubItem - 1 downto 0 do
      mRect.Left := mRect.Left + Sender.Column[i].Width;
    mRect.Left := mRect.Left + 2;
    mRect.Right := mRect.Left + Sender.Column[SubItem].Width;
    s := AppendPathDelim(sInidir) + Item.SubItems[1];
    if not FileExistsUTF8(s) then
    begin
      DefaultDraw := False;
      Sender.Canvas.Font := LVmasks.Font;
      Sender.Canvas.Font.Color := clRed;
      Sender.Canvas.FillRect(mRect);
      Sender.Canvas.TextRect(mRect, mRect.Left + 1, mRect.Top + 1, Item.SubItems[SubItem - 1]);
    end;
  end;
end;

procedure TfrmGUIta.LVstreamsClick(Sender: TObject);
begin
  if LVstreams.Selected = nil then
  begin
    myClear2([TabVideo, TabAudio, TabSubtitle, TabContRows]);
    PageControl2.ActivePage := TabOutput;
  end;
end;

procedure TfrmGUIta.LVstreamsDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  currentItem, nextItem, dragItem, dropItem: TListItem;
  i: integer;
  jo: TJob;
begin
  if myCantUpd(0) then
    Exit;
  if Sender <> Source then Exit;
  with TListView(Sender) do
  begin
    dropItem := GetItemAt(X, Y);
    currentItem := Selected;
    while currentItem <> nil do
    begin
      nextItem := nil;
      for i := 0 to Items.Count - 1 do
        if (Items[i].Selected) and (currentItem.Index <> i) then
        begin
          nextItem := Items[i];
          break;
        end;
      if Assigned(dropItem) then
        dragItem := Items.Insert(dropItem.Index)
      else
        dragItem := Items.Add;
      dragItem.Assign(currentItem);
      currentItem.Free;
      currentItem := nextItem;
    end;
  end;
  jo := TJob(LVjobs.Selected.Data);
  for i := 0 to High(jo.m) do
    jo.m[i] := LVstreams.Items[i].Caption;
end;

procedure TfrmGUIta.LVstreamsDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := (Sender = Source);
end;

procedure TfrmGUIta.LVstreamsItemChecked(Sender: TObject; Item: TListItem);
var
  s: string;
  k, l: integer;
  jo: TJob;
begin
  if myCantUpd(0) then
    Exit;
  s := IfThen(Item.Checked, '1', '0');
  myGetFileStreamNums(Item.Caption, l, k);
  jo := TJob(LVjobs.Selected.Data);
  jo.f[l].s[k].setval('Checked', s);
  LVjobs.Selected.SubItems[3] := myCalcOutSize(jo);
  if PageControl2.ActivePage = TabCmdline then
    TabCmdlineShow(Sender);
end;

procedure TfrmGUIta.LVstreamsSelectItem(Sender: TObject; Item: TListItem;
  Selected: boolean);
var
  c: TCont;
  s: string;
  i, k, l: integer;
  t: TTabSheet;
begin
  if myCantUpd(2) then
    Exit;
  bUpdFromCode := True;
  myGetFileStreamNums(LVstreams.Selected.Caption, l, k);
  if (LVfiles.Selected = nil)
  or ((LVfiles.Selected <> nil) and (LVfiles.Selected.Index <> l)) then
  begin
    for i := 0 to LVfiles.Items.Count - 1 do
      LVfiles.Items[i].Selected := False;
    LVfiles.Items[l].Selected := True;
  end;
  c := TJob(LVjobs.Selected.Data).f[l].s[k];
  s := c.getval('codec_type');
  if (PageControl2.ActivePage = TabVideo)
  or (PageControl2.ActivePage = TabAudio)
  or (PageControl2.ActivePage = TabSubtitle) then
  begin
    if s = 'video' then
    begin
      t := TabVideo;
      myGetValsFromCont(t, c); //fill edit fields from stream
      cmbBitrateVChange(cmbBitrateV);
      cmbEncoderVChange(cmbEncoderV);
    end
    else if s = 'audio' then
    begin
      t := TabAudio;
      myGetValsFromCont(t, c);
      cmbBitrateAChange(cmbBitrateA);
      cmbEncoderVChange(cmbEncoderA);
    end
    else if s = 'subtitle' then
    begin
      t := TabSubtitle;
      myGetValsFromCont(t, c);
      cmbEncoderVChange(cmbEncoderS);
    end;
    PageControl2.ActivePage := t;
  end
  else if (PageControl2.ActivePage = TabContRows) then
    TabContRowsShow(nil);
  bUpdFromCode := False;
end;

procedure TfrmGUIta.mnuCheckClick(Sender: TObject);
var
  i: integer;
begin
  mnuCheck.Checked := not mnuCheck.Checked;
  for i := 0 to LVjobs.Items.Count - 1 do
    LVjobs.Items[i].Checked := mnuCheck.Checked;
  if mnuCheck.Checked then
    LVjobsItemChecked(Sender, nil)
  else
  begin
    DuraAll := 0;
    DuraAl2 := 0;
    myShowCaption('');
  end;
end;

procedure TfrmGUIta.mnuCopyAsAvsClick(Sender: TObject);
{$IFDEF MSWINDOWS}
var
  s: string;
  sl: TStringList;
  b: boolean;
{$ENDIF}
begin
  {$IFDEF MSWINDOWS}
  if LVjobs.Selected = nil then
    Exit;
  b := False;
  s := myExpandFileNameCaseW(LVjobs.Selected.SubItems[1], b);
  if not b then
    s := LVjobs.Selected.SubItems[1];
  if LowerCase(ExtractFileExt(s)) = '.avs' then
    Exit;
  sl := TStringList.Create;
  sl.Add(s);
  myAddFilesAsAVS1(sl);
  sl.Free;
  {$ENDIF}
end;

procedure TfrmGUIta.mnuDeleteFileClick(Sender: TObject);
var
  jo: TJob;
  i, k, l: integer;
begin
  if LVjobs.Selected = nil then Exit;
  if LVfiles.Selected = nil then Exit;
  if LVfiles.Items.Count = 1 then Exit;
  jo := TJob(LVjobs.Selected.Data);
  for i := LVfiles.Selected.Index to LVfiles.Items.Count - 2 do
    jo.f[i] := jo.f[i + 1];
  SetLength(jo.f, Length(jo.f) - 1);
  SetLength(jo.m, 0);
  for l := 0 to High(jo.f) do
  for k := 0 to High(jo.f[l].s) do
  begin
    SetLength(jo.m, Length(jo.m) + 1);
    jo.m[High(jo.m)] := IntToStr(l) + ':' + IntToStr(k);
  end;
  LVjobsSelectItem(Sender, LVjobs.Selected, True);
end;

procedure TfrmGUIta.mnuDeleteJobClick(Sender: TObject);
begin
  if LVjobs.Selected <> nil then
    LVjobs.Selected.Delete;
end;

procedure TfrmGUIta.mnuEditAvsClick(Sender: TObject);
{$IFDEF MSWINDOWS}
var
  s: string;
begin
  if LVjobs.Selected = nil then
    Exit;
  s := TJob(LVjobs.Selected.Data).f[0].getval(sMyDOSfname);
  if LowerCase(ExtractFileExt(s)) = '.avs' then
    myOpenDoc(s);
{$ELSE}
begin
{$ENDIF}
end;

procedure TfrmGUIta.mnuOpenClick(Sender: TObject);
begin
  if myCantUpd(0) then
    Exit;
  myOpenDoc(LVjobs.Selected.SubItems[1]);
end;

procedure TfrmGUIta.mnuPasteClick(Sender: TObject);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  myGetClipboardFileNames(sl);
  if sl.Count > 0 then
    if Sender = mnuPaste then
      myAddFiles(sl)
    else
    {$IFDEF MSWINDOWS}
    if Sender = mnuPasteAsAvs1 then
      myAddFilesAsAVS1(sl)
    else
    if Sender = mnuPasteAsAvs2 then
      myAddFilesAsAVS2(sl)
    else
    {$ENDIF}
    if (LVjobs.Selected <> nil) and ((Sender = mnuPasteTracks) or (Sender = mnuPasteFiles)) then
      myAddFilesPlus(LVjobs.Selected, sl);
  sl.Free;
end;

procedure TfrmGUIta.onCnv3Terminate(Sender: TObject);
var
  s: string;
  li: TListItem;
begin
  li := LVtrd.FindData(0, Sender, True, False);
  if li <> nil then
  begin
    s := li.Caption + ': ' + mes[30] + ' ' + mes[31];
    if chkDebug.Checked then
      memJournal.Lines.Add(s);
    StatusBar1.SimpleText := s;
    li.Data := nil;
    li.Delete;
  end;
  if LVtrd.Items.Count > 0 then Exit;
  DuraJob := '';
  myShowCaption('');
end;

procedure TfrmGUIta.ontAutoStart(Sender: TObject);
begin
  tAutoStart.Enabled := False;
  tAutoStart.OnTimer := nil;
  tAutoStart.Free;
  btnStart.Click;
end;

procedure TfrmGUIta.PopupMenu1Popup(Sender: TObject);
var
  sl: TStringList;
  b, b3: boolean;
begin
  sl := TStringList.Create;
  myGetClipboardFileNames(sl, True);
  b3 := sl.Count > 0;
  sl.Free;
  mnuPaste.Enabled := b3;
  mnuPasteAsAvs1.Enabled := b3;
  mnuPasteAsAvs2.Enabled := b3;
  b := (LVjobs.Selected <> nil);
  b3 := FileExistsUTF8(myExpandFN(edtffplay.Text));
  mnuView.Enabled := b and b3;
end;

procedure TfrmGUIta.PopupMenu2Popup(Sender: TObject);
var
  sl: TStringList;
  b3: boolean;
begin
  sl := TStringList.Create;
  myGetClipboardFileNames(sl, True);
  b3 := sl.Count > 0;
  sl.Free;
  mnuPasteTracks.Enabled := b3;
end;

procedure TfrmGUIta.PopupMenu3Popup(Sender: TObject);
var
  sl: TStringList;
  b, b3: boolean;
begin
  sl := TStringList.Create;
  myGetClipboardFileNames(sl, True);
  b3 := sl.Count > 0;
  sl.Free;
  mnuPasteFiles.Enabled := b3;
  b := (LVfiles.Selected <> nil) and (LVfiles.Items.Count > 1);
  mnuDeleteFile.Enabled := b;
end;

procedure TfrmGUIta.Splitter1CanResize(Sender: TObject; var NewSize: Integer;
  var Accept: Boolean);
begin
  Accept := NewSize > 200
end;

procedure TfrmGUIta.TabCmdlineShow(Sender: TObject);
var
  jo: TJob;
  run: TRun;
  l: integer;
  s: string;
begin
  if LVjobs.Selected = nil then Exit;
  bUpdFromCode := True;
  jo := TJob(LVjobs.Selected.Data);
  chkUseEditedCmd.Checked := (jo.getval(chkUseEditedCmd.Name) = '1');
  run := TRun.Create;
  myGetRunFromJo(jo, run, 3);
  memCmdlines.Clear;
  if chkUseEditedCmd.Checked then
    memCmdlines.Text := jo.getval(memCmdlines.Name)
  else
  for l := 0 to High(run.p) do
  begin
    s := myGetStr(run.p[l].Executable);
    s := s + myGetStr(run.p[l].Parameters);
    memCmdlines.Lines.Add(s);
  end;
  run.Free;
  bUpdFromCode := False;
end;

procedure TfrmGUIta.TabContRowsShow(Sender: TObject);
var
  i, k, l: integer;
  jo: TJob;
  c: TCont;
begin
  SynMemo4.Clear;
  if LVjobs.Selected = nil then Exit;
  jo := TJob(LVjobs.Selected.Data);
  if (LVstreams.Selected = nil) or (Sender = LVjobs) then
  begin
    for l := 0 to High(jo.f) do
    begin
      for i := 0 to High(jo.sk) do
        SynMemo4.Lines.Add(jo.sk[i] + '=' + jo.sv[i]);
      SynMemo4.Lines.Add(sdiv);
      SynMemo4.Lines.Add('$inpu' + IntToStr(l));
      for i := 0 to High(jo.f[l].sk) do
        SynMemo4.Lines.Add(jo.f[l].sk[i] + '=' + jo.f[l].sv[i]);
    end;
  end
  else
  begin
    myGetFileStreamNums(LVstreams.Selected.Caption, l, k);
    c := jo.f[l].s[k];
    for i := 0 to High(c.sk) do
      SynMemo4.Lines.Add(c.sk[i] + '=' + c.sv[i]);
  end;
end;

procedure TfrmGUIta.TabSets1Show(Sender: TObject);
begin
  xmyCheckFile(edtffmpeg);
  xmyCheckFile(edtffplay);
  xmyCheckFile(edtffprobe);
  xmyCheckFile(edtMediaInfo);
  xmyCheckFile(cmbExtPlayer);
  xmyCheckDir(edtDirTmp);
  xmyCheckDir(edtDirOut);
  xmyCheckDir(cmbDirLast);
end;

procedure TfrmGUIta.TabVideoShow(Sender: TObject);
var
  i, j, k, l, m: integer;
  s: string;
begin
  if myCantUpd(0) then
    Exit;
  if LVstreams.Selected <> nil then
  begin
    myGetFileStreamNums(LVstreams.Selected.Caption, l, k);
    s := TJob(LVjobs.Selected.Data).f[l].s[k].getval('codec_type');
    if (s = LowerCase(Copy(TTabSheet(Sender).Name, 4, 8))) then
    begin
      LVstreamsSelectItem(Sender, LVstreams.Selected, True);
      Exit;
    end;
  end;
  bUpdFromCode := True;
  j := -1;
  m := -1;
  for i := 0 to LVstreams.Items.Count - 1 do
  begin
    myGetFileStreamNums(LVstreams.Items[i].Caption, l, k);
    s := TJob(LVjobs.Selected.Data).f[l].s[k].getval('codec_type');
    if (s = LowerCase(Copy(TTabSheet(Sender).Name, 4, 8))) then
    begin
      if (j < 0) and LVstreams.Items[i].Checked then
        j := i;
      if (m < 0) then
        m := i;
    end;
    LVstreams.Items[i].Selected := False;
  end;
  if (j >= 0) then
    i := j
  else if (m >= 0) then
    i := m
  else
    i := -1;
  bUpdFromCode := False;
  if (i >= 0) then
    LVstreams.Items[i].Selected := True;
end;

procedure TfrmGUIta.UniqueInstance1OtherInstance(Sender: TObject;
  ParamCount: Integer; const Parameters: array of String);
var
  i:Integer;
  SL: TStringList;
begin
  SL := TStringList.Create;
  for i := Low(Parameters) to High(Parameters) do
    SL.Add(Parameters[i]);
  if SL.Count > 0 then
    myAddFiles(SL);
  SL.Free;
  BringToFront;
end;

procedure TfrmGUIta.xmyChange0(Sender: TObject);
var
  s1, s2: string;
begin
  if myCantUpd(0) then
    Exit;
  s1 := (Sender as TControl).Name;
  s2 := myGet2(Sender);
  TJob(LVjobs.Selected.Data).setval(s1, s2);
  if (Sender as TControl).Tag = 3 then //output filename
    myDisComp;
end;

procedure TfrmGUIta.xmyChange0o(Sender: TObject);
begin
  if myCantUpd(0) then
    Exit;
  xmyChange0(Sender);
  LVjobs.Selected.SubItems[3] := myCalcOutSize(TJob(LVjobs.Selected.Data));
end;

procedure TfrmGUIta.xmyChange1i(Sender: TObject);
var
  s1, s2: string;
  i: integer;
  jo: TJob;
begin
  if myCantUpd(1) then
    Exit;
  s1 := (Sender as TControl).Name;
  s2 := myGet2(Sender);
  jo := TJob(LVjobs.Selected.Data);
  i := LVfiles.Selected.Index;
  if (i >= 0) and (i <= High(jo.f)) then
    jo.f[i].setval(s1, s2);
end;

procedure TfrmGUIta.xmyChange2(Sender: TObject);
var
  s1, s2: string;
  k, l: integer;
begin
  if myCantUpd(2) then
    Exit;
  s1 := (Sender as TControl).Name;
  s2 := myGet2(Sender);
  myGetFileStreamNums(LVstreams.Selected.Caption, l, k);
  TJob(LVjobs.Selected.Data).f[l].s[k].setval(s1, s2);
end;

procedure TfrmGUIta.xmyChange2c(Sender: TObject);
begin
  if (Sender is TComboBox) then
    with (Sender as TComboBox) do
    if Items.IndexOf(Text) < 0 then
      Font.Color := clRed
    else
      Font.Color := clWindowText;
  xmyChange2(Sender);
end;

procedure TfrmGUIta.xmyChange2v(Sender: TObject);
var
  k, l: integer;
begin
  if myCantUpd(2) then
    Exit;
  xmyChange2(Sender);
  myGetFileStreamNums(LVstreams.Selected.Caption, l, k);
  edtBitrateV.Text := myCalcBRv(TJob(LVjobs.Selected.Data).f[l].s[k]);
end;

procedure TfrmGUIta.xmyChange2a(Sender: TObject);
var
  k, l: integer;
begin
  if myCantUpd(2) then
    Exit;
  xmyChange2(Sender);
  myGetFileStreamNums(LVstreams.Selected.Caption, l, k);
  edtBitrateA.Text := myCalcBRa(TJob(LVjobs.Selected.Data).f[l].s[k]);
end;

procedure TfrmGUIta.xmyChange2o(Sender: TObject);
begin
  if myCantUpd(2) then
    Exit;
  xmyChange2(Sender);
  LVjobs.Selected.SubItems[3] := myCalcOutSize(TJob(LVjobs.Selected.Data));
end;

procedure TfrmGUIta.xmyCheckDir(Sender: TObject);
begin
  if DirectoryExistsUTF8(myExpandFN(myGet2(Sender), True)) then
    TWinControl(Sender).Font.Color := clWindowText
  else
    TWinControl(Sender).Font.Color := clRed;
end;

procedure TfrmGUIta.xmyCheckFile(Sender: TObject);
begin
  if FileExistsUTF8(myExpandFN(myGet2(Sender))) then
    TWinControl(Sender).Font.Color := clWindowText
  else
    TWinControl(Sender).Font.Color := clRed;
end;

procedure TfrmGUIta.xmySelDir(Sender: TObject);
var
  s: string;
begin
  s := myExpandFN(myGet2(Sender), True);
  if SelectDirectory(mes[18], s, s) then
  begin
    mySet2(Sender, myUnExpandFN(s));
    TWinControl(Sender).Font.Color := clWindowText;
  end;
end;

procedure TfrmGUIta.xmySelFile(Sender: TObject);
var
  w, t, sExt: string;
  od: TOpenDialog;
begin
  w := myGet2(Sender);
  t := Copy((Sender as TControl).Name, 4, 20) + GetExeExt;
  od := TOpenDialog.Create(frmGUIta);
  od.Title := mes[20] + ' - ' + t;
  if (w <> '') then
  begin
    sExt := ExtractFileExt(w);
    od.InitialDir := ExtractFileDir(myExpandFN(w));
    w := ExtractFileName(w);
  end
  else
    w := t;
  od.FileName := w;
  od.Filter := w + '|' + w
    + IfThen(sExt <> '', '|' + mes[17] + ' (*' + sExt + ')|*' + sExt)
    + '|' + mes[29] + ' (' + AllFilesMask + ')|' + AllFilesMask;
  od.DefaultExt := sExt;
  if od.Execute then
  begin
    mySet2(Sender, myUnExpandFN(od.FileName));
    TWinControl(Sender).Font.Color := clWindowText;
  end;
  od.Free;
end;

end.
