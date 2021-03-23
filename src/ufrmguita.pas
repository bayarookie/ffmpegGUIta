unit ufrmGUIta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, StdCtrls, IniFiles, LclIntf, Process, UTF8Process, LConvEncoding,
  SynMemo, synhighlighterunixshellscript, SynHighlighterIni, StrUtils, types,
  Math, Spin, Buttons, IntfGraphics, LCLType, Menus, fpImage, Masks,
  LazFileUtils, LazUTF8, character, LCLproc,
  {$IFDEF MSWINDOWS}
  Windows, Registry, shlobj,
  {$ELSE}
  clipbrd, Grids, FileCtrl, ColorBox,
  {$ENDIF}
  mediainfodll, ucalcul, ujobinfo, utaversion, UniqueInstance2, uthreadexec, urun;

type

  TmyWinState = class(TObject)
    a: array [0..4] of integer;
  end;

  { TfrmGUIta }

  TfrmGUIta = class(TForm)
    btnAddScreenGrab: TButton;
    btnAddTrack1: TButton;
    btnAddTracks: TButton;
    btnClearHist: TButton;
    btnCompare: TButton;
    btnConcatFiles: TButton;
    btnAddImageDir: TButton;
    btnAddProtocol: TButton;
    btnAddFiles1job: TButton;
    btnAddFiles: TButton;
    btnConcat2Files: TButton;
    btnCrop: TButton;
    btnExtractTrackA: TButton;
    btnExtractTrackS: TButton;
    btnFindOfn: TBitBtn;
    btnGenDB: TButton;
    btnLanguage: TButton;
    btnLogClear: TButton;
    btnLogSave: TButton;
    btnMaskAdd: TButton;
    btnMaskDel: TButton;
    btnMaskEdit: TButton;
    btnMaskReset: TButton;
    btnMediaInfo1: TButton;
    btnMediaInfo2: TButton;
    btnPlayOut: TButton;
    btnProfileGetItems: TButton;
    btnProfileSaveAs: TButton;
    btnRereadInfo: TButton;
    btnReset: TButton;
    btnRunCmd: TButton;
    btnSaveCmdline: TButton;
    btnSaveSets: TButton;
    btnTest: TButton;
    btnStop: TButton;
    btnStart: TButton;
    btnSuspend: TButton;
    btnAddFileSplit: TButton;
    btnTestFiltersA: TButton;
    btnTestFiltersO: TButton;
    btnTestFiltersV: TButton;
    btnVolumeDetect: TButton;
    chkColorMasks: TCheckBox;
    chkColorJobs: TCheckBox;
    chk1instance: TCheckBox;
    chkAddTracks: TCheckBox;
    chkCmdline4shell: TCheckBox;
    chkDebug: TCheckBox;
    chkDirOutStruct: TCheckBox;
    chkffplayexit: TCheckBox;
    chkffplayfs: TCheckBox;
    chkGenDBuse: TCheckBox;
    chkLangA1: TCheckBox;
    chkLangA2: TCheckBox;
    chkLangS1: TCheckBox;
    chkLangS2: TCheckBox;
    chkLangV1: TCheckBox;
    chkMediaInfoDll: TCheckBox;
    chkMediaInfoIsCli: TCheckBox;
    chkMetadataClear: TCheckBox;
    chkMetadataGen: TCheckBox;
    chkMetadataGet: TCheckBox;
    chkMetadataGet1: TCheckBox;
    chkMetadataWork: TCheckBox;
    chkPlayer2: TCheckBox;
    chkPlayer3: TCheckBox;
    chkProfile2All: TCheckBox;
    chkRunInTerm: TCheckBox;
    chkRunInTred: TCheckBox;
    chkSaveFormPos: TCheckBox;
    chkSaveOnExit: TCheckBox;
    chkSGmixaudio: TCheckBox;
    chkSGmixvideo: TCheckBox;
    chkSGsource0: TCheckBox;
    chkSGsource1: TCheckBox;
    chkSGsource2: TCheckBox;
    chkSGsource3: TCheckBox;
    chkStopIfError: TCheckBox;
    chkStreamSpec: TCheckBox;
    chkSynColor: TCheckBox;
    chkUseEditedCmd: TCheckBox;
    chkUseMasks: TCheckBox;
    chkxterm1str: TCheckBox;
    chkxtermconv: TCheckBox;
    chkxtermwait: TCheckBox;
    cmbAddOptsA: TComboBox;
    cmbAddOptsI: TComboBox;
    cmbAddOptsI1: TComboBox;
    cmbAddOptsO: TComboBox;
    cmbAddOptsS: TComboBox;
    cmbAddOptsV: TComboBox;
    cmbAddTracks: TComboBox;
    cmbBitrateA: TComboBox;
    cmbBitrateV: TComboBox;
    cmbChannels: TComboBox;
    cmbcqV: TComboBox;
    cmbcrfv: TComboBox;
    cmbCrop: TComboBox;
    cmbDateTime: TComboBox;
    cmbDirLast: TComboBox;
    cmbDurationss1: TComboBox;
    cmbDurationss2: TComboBox;
    cmbDurationt1: TComboBox;
    cmbDurationt2: TComboBox;
    cmbEncoderA: TComboBox;
    cmbEncoderD: TComboBox;
    cmbEncoderS: TComboBox;
    cmbEncoderV: TComboBox;
    cmbExt: TComboBox;
    cmbExtPlayer: TComboBox;
    cmbFilterComplex: TComboBox;
    cmbFiltersA: TComboBox;
    cmbFiltersV: TComboBox;
    cmbFont: TComboBox;
    cmbFormat: TComboBox;
    cmbhqdn3d: TComboBox;
    cmbItsoffset: TComboBox;
    cmbLangA: TComboBox;
    cmbLangS: TComboBox;
    cmbLangsList: TComboBox;
    cmbLanguage: TComboBox;
    cmbMetadataCP: TComboBox;
    cmbMetadataCPext: TComboBox;
    cmbPad: TComboBox;
    cmbPass: TComboBox;
    cmbpix_fmt: TComboBox;
    cmbPreset: TComboBox;
    cmbProfile: TComboBox;
    cmbQualityA: TComboBox;
    cmbQualityV: TComboBox;
    cmbRenameMask: TComboBox;
    cmbRotate: TComboBox;
    cmbRunCmd: TComboBox;
    cmbScale: TComboBox;
    cmbScenario: TComboBox;
    cmbScenarioOpt1: TComboBox;
    cmbScenarioOpt2: TComboBox;
    cmbScenarioOpt3: TComboBox;
    cmbScenarioOpt4: TComboBox;
    cmbSetDAR: TComboBox;
    cmbSGcodecaudio: TComboBox;
    cmbSGcodecvideo: TComboBox;
    cmbSGfiltercomplex: TComboBox;
    cmbSGmaps: TComboBox;
    cmbSGoutext: TComboBox;
    cmbSGoutput: TComboBox;
    cmbSGsource0: TComboBox;
    cmbSGsource1: TComboBox;
    cmbSGsource2: TComboBox;
    cmbSGsource3: TComboBox;
    cmbSRate: TComboBox;
    cmbTagLangA: TComboBox;
    cmbTagLangS: TComboBox;
    cmbTagLangV: TComboBox;
    cmbTagTitleA: TComboBox;
    cmbTagTitleS: TComboBox;
    cmbTagTitleV: TComboBox;
    cmbTestDurationss: TComboBox;
    cmbTestDurationt: TComboBox;
    cmbTune: TComboBox;
    ColorAddedText: TColorButton;
    ColorAddedBack: TColorButton;
    ColorCompletedText: TColorButton;
    ColorCompletedBack: TColorButton;
    ColorProgressText: TColorButton;
    ColorProgressBack: TColorButton;
    ColorErrorText: TColorButton;
    ColorErrorBack: TColorButton;
    edtEncoderS: TEdit;
    edtBitrateA: TEdit;
    edtBitrateV: TEdit;
    edtDirOut: TComboBox;
    edtDirTmp: TComboBox;
    edtEncoderA: TEdit;
    edtEncoderV: TEdit;
    edtffmpeg: TComboBox;
    edtffplay: TComboBox;
    edtffprobe: TComboBox;
    edtFileExts: TComboBox;
    edtMediaInfo: TComboBox;
    edtMediaInfoDll: TComboBox;
    edtOfn: TEdit;
    edtxterm: TComboBox;
    edtxtermopts: TComboBox;
    ImageList1: TImageList;
    lblAddOptsI1: TLabel;
    lblColorAddedText: TLabel;
    lblColorAddedBack: TLabel;
    lblColorCompletedText: TLabel;
    lblColorCompletedBack: TLabel;
    lblColorProgressText: TLabel;
    lblColorProgressBack: TLabel;
    lblColorErrorText: TLabel;
    lblColorErrorBack: TLabel;
    lblCpuCount: TLabel;
    lblFontSize: TLabel;
    lblFont: TLabel;
    lblMetadataCP: TLabel;
    lblMetadataCPext: TLabel;
    lblSGcodecaudio: TLabel;
    lblSGcodecvideo: TLabel;
    lblSGfiltercomplex: TLabel;
    lblSGmaps: TLabel;
    lblSGoutput: TLabel;
    lblTestStartDurationTime: TLabel;
    lblxtermopts: TLabel;
    lblAddOptsS: TLabel;
    lblEncoderCS: TLabel;
    lblEncoderS: TLabel;
    lblAddOptsA: TLabel;
    lblAddOptsI: TLabel;
    lblAddOptsO: TLabel;
    lblAddOptsV: TLabel;
    lblBitrateA: TLabel;
    lblBitrateBA: TLabel;
    lblBitrateBV: TLabel;
    lblBitrateV: TLabel;
    lblChannels: TLabel;
    lblcqV: TLabel;
    lblcrfv: TLabel;
    lblCrop: TLabel;
    lblDAR: TLabel;
    lblDenoise: TLabel;
    lblDirLast: TLabel;
    lblDirOut: TLabel;
    lblDirTmp: TLabel;
    lblDurationss1: TLabel;
    lblDurationss2: TLabel;
    lblDurationss3: TLabel;
    lblDurationt1: TLabel;
    lblDurationt2: TLabel;
    lblEncoderA: TLabel;
    lblEncoderCA: TLabel;
    lblEncoderCV: TLabel;
    lblEncoderV: TLabel;
    lblExt: TLabel;
    lblffmpeg: TLabel;
    lblffplay: TLabel;
    lblffprobe: TLabel;
    lblFilterComplex: TLabel;
    lblFiltersA: TLabel;
    lblFiltersV: TLabel;
    lblFormat: TLabel;
    lblkoefA: TLabel;
    lblkoefV: TLabel;
    lblMediaInfo: TLabel;
    lblMediaInfoDll: TLabel;
    lblOfn: TLabel;
    lblPad: TLabel;
    lblPass: TLabel;
    lblpix_fmt: TLabel;
    lblPreset: TLabel;
    lblProfile: TLabel;
    lblQualityA: TLabel;
    lblQualityV: TLabel;
    lblRenameMask: TLabel;
    lblRotate: TLabel;
    lblScale: TLabel;
    lblScenario: TLabel;
    lblScenarioOpt1: TLabel;
    lblScenarioOpt2: TLabel;
    lblScenarioOpt3: TLabel;
    lblScenarioOpt4: TLabel;
    lblSRate: TLabel;
    lblTagLangA: TLabel;
    lblTagLangS: TLabel;
    lblTagLangV: TLabel;
    lblTagTitleA: TLabel;
    lblTagTitleS: TLabel;
    lblTagTitleV: TLabel;
    lblTune: TLabel;
    ListBox1: TListBox;
    LVfiles: TListView;
    LVjobs: TListView;
    LVmasks: TListView;
    LVstreams: TListView;
    LVtrd: TListView;
    memCmdlines: TMemo;
    memConsole: TSynMemo;
    memJournal: TSynMemo;
    memMediaInfo: TSynMemo;
    memStreamInfo: TSynMemo;
    memTagsOut: TMemo;
    mnuSaveJob: TMenuItem;
    mnuCopyStreamInfo: TMenuItem;
    mnuCopyConsole: TMenuItem;
    mnuCopyMediaInfo: TMenuItem;
    mnuCopyJournal: TMenuItem;
    mnuClearJobs: TMenuItem;
    mnuMediainfo1: TMenuItem;
    mnuDeleteJob: TMenuItem;
    mnuDeleteFile: TMenuItem;
    mnuPasteFiles: TMenuItem;
    mnuCheck: TMenuItem;
    mnuPasteTracks: TMenuItem;
    mnuOpen: TMenuItem;
    mnuPaste: TMenuItem;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    PageControl3: TPageControl;
    PageControl4: TPageControl;
    PageControl5: TPageControl;
    PageControl6: TPageControl;
    PageControl7: TPageControl;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel100: TPanel;
    Panel101: TPanel;
    Panel102: TPanel;
    Panel103: TPanel;
    Panel104: TPanel;
    Panel105: TPanel;
    Panel106: TPanel;
    Panel107: TPanel;
    Panel108: TPanel;
    Panel109: TPanel;
    Panel11: TPanel;
    Panel110: TPanel;
    Panel111: TPanel;
    Panel112: TPanel;
    Panel113: TPanel;
    Panel114: TPanel;
    Panel115: TPanel;
    Panel116: TPanel;
    Panel117: TPanel;
    Panel118: TPanel;
    Panel119: TPanel;
    Panel12: TPanel;
    Panel120: TPanel;
    Panel121: TPanel;
    Panel122: TPanel;
    Panel123: TPanel;
    Panel124: TPanel;
    Panel125: TPanel;
    Panel126: TPanel;
    Panel127: TPanel;
    Panel128: TPanel;
    Panel129: TPanel;
    Panel13: TPanel;
    Panel130: TPanel;
    Panel131: TPanel;
    Panel132: TPanel;
    Panel133: TPanel;
    Panel134: TPanel;
    Panel135: TPanel;
    Panel136: TPanel;
    Panel137: TPanel;
    Panel138: TPanel;
    Panel139: TPanel;
    Panel14: TPanel;
    Panel140: TPanel;
    Panel141: TPanel;
    Panel147: TPanel;
    Panel148: TPanel;
    Panel149: TPanel;
    Panel150: TPanel;
    Panel153: TPanel;
    Panel154: TPanel;
    Panel155: TPanel;
    Panel156: TPanel;
    Panel157: TPanel;
    Panel158: TPanel;
    Panel159: TPanel;
    Panel160: TPanel;
    Panel161: TPanel;
    Panel162: TPanel;
    Panel163: TPanel;
    Panel164: TPanel;
    Panel165: TPanel;
    Panel166: TPanel;
    Panel167: TPanel;
    Panel168: TPanel;
    Panel169: TPanel;
    Panel170: TPanel;
    Panel171: TPanel;
    Panel172: TPanel;
    Panel173: TPanel;
    Panel174: TPanel;
    Panel175: TPanel;
    Panel176: TPanel;
    Panel177: TPanel;
    Panel178: TPanel;
    Panel179: TPanel;
    Panel180: TPanel;
    Panel181: TPanel;
    Panel182: TPanel;
    Panel183: TPanel;
    Panel184: TPanel;
    Panel185: TPanel;
    Panel186: TPanel;
    Panel187: TPanel;
    Panel4: TPanel;
    Panel68: TPanel;
    Panel75: TPanel;
    Panel79: TPanel;
    pnlTagS: TPanel;
    Panel142: TPanel;
    Panel143: TPanel;
    Panel144: TPanel;
    Panel145: TPanel;
    Panel146: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
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
    pnlJobs: TPanel;
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
    Panel5: TPanel;
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
    Panel66: TPanel;
    Panel67: TPanel;
    Panel69: TPanel;
    Panel7: TPanel;
    Panel70: TPanel;
    Panel71: TPanel;
    Panel72: TPanel;
    Panel73: TPanel;
    Panel74: TPanel;
    Panel76: TPanel;
    Panel77: TPanel;
    Panel78: TPanel;
    Panel8: TPanel;
    Panel80: TPanel;
    Panel81: TPanel;
    Panel82: TPanel;
    Panel83: TPanel;
    Panel84: TPanel;
    Panel85: TPanel;
    Panel86: TPanel;
    Panel87: TPanel;
    Panel88: TPanel;
    Panel89: TPanel;
    Panel9: TPanel;
    Panel90: TPanel;
    Panel91: TPanel;
    Panel92: TPanel;
    Panel93: TPanel;
    Panel94: TPanel;
    Panel95: TPanel;
    Panel96: TPanel;
    Panel97: TPanel;
    Panel98: TPanel;
    Panel99: TPanel;
    PanelMasks: TPanel;
    PanelPathes: TPanel;
    pnlOfnSize: TPanel;
    pnlStreams: TPanel;
    PopupMenuJobs: TPopupMenu;
    PopupMenuStreams: TPopupMenu;
    PopupMenuFiles: TPopupMenu;
    PopupMenuJournal: TPopupMenu;
    PopupMenuMediaInfo: TPopupMenu;
    PopupMenuConsole: TPopupMenu;
    PopupMenuStreamInfo: TPopupMenu;
    seFontSize: TSpinEdit;
    Splitter1: TSplitter;
    SplitterLVjobs: TSplitter;
    SplitterLVstreams: TSplitter;
    spnCpuCount: TSpinEdit;
    spnKoefA: TSpinEdit;
    spnKoefV: TSpinEdit;
    StatusBar1: TStatusBar;
    SynIniSyn1: TSynIniSyn;
    SynMemo5: TSynMemo;
    SynMemo6: TSynMemo;
    SynUNIXShellScriptSyn1: TSynUNIXShellScriptSyn;
    TabAudio: TTabSheet;
    TabAudio1: TTabSheet;
    TabCmdline: TTabSheet;
    TabConsole: TTabSheet;
    TabConsole1: TTabSheet;
    TabConsole3: TTabSheet;
    TabConsole4: TTabSheet;
    TabContRows: TTabSheet;
    TabConvJob: TTabSheet;
    TabData: TTabSheet;
    TabFilterComplex: TTabSheet;
    TabFiltersA: TTabSheet;
    TabFiltersV: TTabSheet;
    TabInput: TTabSheet;
    TabJournal: TTabSheet;
    TabMediaInfo: TTabSheet;
    TabMetaData: TTabSheet;
    TabMetaDataA: TTabSheet;
    TabMetaDataV: TTabSheet;
    TabOutput: TTabSheet;
    TabOutput1: TTabSheet;
    TabScreenGrab: TTabSheet;
    TabSets: TTabSheet;
    TabSets1: TTabSheet;
    TabSets2: TTabSheet;
    TabColors: TTabSheet;
    TabSubtitle: TTabSheet;
    TabVideo: TTabSheet;
    TabVideo1: TTabSheet;
    UpDownDurass1: TUpDown;
    UpDownDurass2: TUpDown;
    UpDownDurat1: TUpDown;
    UpDownDurat2: TUpDown;
    UpDownItsoffset: TUpDown;
    procedure btnAddFilesClick(Sender: TObject);
    procedure btnAddImageDirClick(Sender: TObject);
    procedure btnAddProtocolClick(Sender: TObject);
    procedure btnAddScreenGrabClick(Sender: TObject);
    procedure btnAddTrack1Click(Sender: TObject);
    procedure btnClearHistClick(Sender: TObject);
    procedure btnCompareClick(Sender: TObject);
    procedure btnRunCmdClick(Sender: TObject);
    procedure btnCropClick(Sender: TObject);
    procedure btnExtractTrackSClick(Sender: TObject);
    procedure btnFindDirOutClick(Sender: TObject);
    procedure btnFindExtPlayerClick(Sender: TObject);
    procedure btnFindffmpegClick(Sender: TObject);
    procedure btnFindffplayClick(Sender: TObject);
    procedure btnFindffprobeClick(Sender: TObject);
    procedure btnFindMediaInfoDllClick(Sender: TObject);
    procedure btnFindDirTmpClick(Sender: TObject);
    procedure btnGenDBClick(Sender: TObject);
    procedure btnLanguageClick(Sender: TObject);
    procedure btnLogClearClick(Sender: TObject);
    procedure btnLogSaveClick(Sender: TObject);
    procedure btnMaskAddClick(Sender: TObject);
    procedure btnMaskDelClick(Sender: TObject);
    procedure btnMaskEditClick(Sender: TObject);
    procedure btnMaskResetClick(Sender: TObject);
    procedure btnMediaInfo1Click(Sender: TObject);
    procedure btnFindOfnClick(Sender: TObject);
    procedure btnPlayOutClick(Sender: TObject);
    procedure btnProfileGetItemsClick(Sender: TObject);
    procedure btnProfileSaveAsClick(Sender: TObject);
    procedure btnRereadInfoClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnSaveCmdlineClick(Sender: TObject);
    procedure btnSaveSetsClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnSuspendClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnTestFiltersOClick(Sender: TObject);
    procedure btnTestFiltersVClick(Sender: TObject);
    procedure btnVolumeDetectClick(Sender: TObject);
    procedure chk1instanceChange(Sender: TObject);
    procedure chkCmdline4shellChange(Sender: TObject);
    procedure chkColorJobsChange(Sender: TObject);
    procedure chkColorMasksChange(Sender: TObject);
    procedure chkGenDBuseChange(Sender: TObject);
    procedure chkLangA1Change(Sender: TObject);
    procedure chkLangA2Change(Sender: TObject);
    procedure chkLangS1Change(Sender: TObject);
    procedure chkLangS2Change(Sender: TObject);
    procedure chkMetadataWorkChange(Sender: TObject);
    procedure chkPlayer2Change(Sender: TObject);
    procedure chkPlayer3Change(Sender: TObject);
    procedure chkSGmixvideoChange(Sender: TObject);
    procedure chkSynColorChange(Sender: TObject);
    procedure chkUseEditedCmdChange(Sender: TObject);
    procedure chkUseMasksChange(Sender: TObject);
    procedure cmbBitrateAChange(Sender: TObject);
    procedure cmbBitrateVChange(Sender: TObject);
    procedure cmbEncoderAChange(Sender: TObject);
    procedure cmbEncoderSChange(Sender: TObject);
    procedure cmbEncoderVChange(Sender: TObject);
    procedure cmbExtChange(Sender: TObject);
    procedure cmbExtPlayerChange(Sender: TObject);
    procedure cmbExtPlayerGetItems(Sender: TObject);
    procedure cmbFontGetItems(Sender: TObject);
    procedure cmbFormatChange(Sender: TObject);
    procedure cmbLanguageChange(Sender: TObject);
    procedure cmbLanguageGetItems(Sender: TObject);
    procedure cmbProfileChange(Sender: TObject);
    procedure cmbProfileExit(Sender: TObject);
    procedure cmbProfileGetItems(Sender: TObject);
    procedure cmbProfileKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbRenameMaskChange(Sender: TObject);
    procedure cmbRunCmdGetItems(Sender: TObject);
    procedure cmbScenarioChange(Sender: TObject);
    procedure cmbScenarioOpt3GetItems(Sender: TObject);
    procedure cmbScenarioOpt4GetItems(Sender: TObject);
    procedure cmbSGsource0GetItems(Sender: TObject);
    procedure cmbSGsource2GetItems(Sender: TObject);
    procedure edtDirOutChange(Sender: TObject);
    procedure edtffmpegChange(Sender: TObject);
    procedure edtffmpegGetItems(Sender: TObject);
    procedure edtMediaInfoDllGetItems(Sender: TObject);
    procedure edtMediaInfoGetItems(Sender: TObject);
    procedure edtOfnChange(Sender: TObject);
    procedure edtxtermGetItems(Sender: TObject);
    procedure edtxtermoptsGetItems(Sender: TObject);
    procedure edtxtermSelect(Sender: TObject);
    procedure FormChangeBounds(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormDropFiles(Sender: TObject; const FileNames: array of string);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LVfilesClick(Sender: TObject);
    procedure LVfilesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LVfilesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LVfilesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure LVjobsClick(Sender: TObject);
    procedure LVjobsCustomDrawSubItem(Sender: TCustomListView; Item: TListItem;
      SubItem: Integer; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure LVjobsDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure LVjobsDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure LVjobsItemChecked(Sender: TObject; Item: TListItem);
    procedure LVjobsKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure LVjobsSelectItem(Sender: TObject; Item: TListItem;
      Selected: boolean);
    procedure LVmasksCustomDrawSubItem(Sender: TCustomListView; Item: TListItem;
      SubItem: Integer; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure LVstreamsClick(Sender: TObject);
    procedure LVstreamsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LVstreamsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LVstreamsItemChecked(Sender: TObject; Item: TListItem);
    procedure LVstreamsSelectItem(Sender: TObject; Item: TListItem;
      Selected: boolean);
    procedure mnuCheckClick(Sender: TObject);
    procedure mnuClearJobsClick(Sender: TObject);
    procedure mnuCopyConsoleClick(Sender: TObject);
    procedure mnuDeleteFileClick(Sender: TObject);
    procedure mnuDeleteJobClick(Sender: TObject);
    procedure mnuOpenClick(Sender: TObject);
    procedure mnuPasteClick(Sender: TObject);
    procedure mnuSaveJobClick(Sender: TObject);
    procedure onCnv3Terminate(Sender: TObject);
    procedure ontAutoStart(Sender: TObject);
    procedure PopupMenuJobsPopup(Sender: TObject);
    procedure PopupMenuStreamsPopup(Sender: TObject);
    procedure PopupMenuFilesPopup(Sender: TObject);
    procedure seFontSizeChange(Sender: TObject);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure SplitterLVjobsCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure SplitterLVstreamsCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure TabCmdlineShow(Sender: TObject);
    procedure TabContRowsShow(Sender: TObject);
    procedure TabInputShow(Sender: TObject);
    procedure TabOutputShow(Sender: TObject);
    procedure TabSets1Show(Sender: TObject);
    procedure TabVideoShow(Sender: TObject);
    procedure UniqueInstance1OtherInstance(Sender: TObject;
      ParamCount: Integer; const Parameters: array of String);
    procedure UpDownDurat2Click(Sender: TObject; Button: TUDBtnType);
    procedure xmyChange0(Sender: TObject);  //output file
    procedure xmyChange0o(Sender: TObject); //output file, calculate output size
    procedure xmyChange0i(Sender: TObject); //output file, in items or red
    procedure xmyChange1(Sender: TObject);  //input file
    procedure xmyChange2(Sender: TObject);
    procedure xmyChange2i(Sender: TObject); //stream, in items or red
    procedure xmyChange2v(Sender: TObject); //stream, calc video bitrate
    procedure xmyChange2a(Sender: TObject); //stream, calc audio bitrate
    procedure xmyCheckDir(Sender: TObject);
    procedure xmyCheckFile(Sender: TObject);
    procedure xmySelDir(Sender: TObject);
    procedure xmySelFile(Sender: TObject);
  private
    { private declarations }
    function myGetDirTmp(fn: string): string;
    function myGetDirOut(o, fn: string): string;
    function myGetDirOut(o, basedir, fn: string): string;
    procedure myProfile2jo(p: string; jo: TJob);
    procedure myInit_jo(fn, o: string; out jo: TJob);
    procedure myAdd_Job1(fn, o: string; out jo: TJob);       //create job, 1 file
    procedure myAdd_Job2(fn, o: string);                     //create job, 1 file
    procedure myAdd_Job4(c: TCont);                          //create job, all files as a single job
    procedure myAdd_Job7(c: TCont);                          //create job, -f concat -safe 0 -i ff00001.txt
    procedure myAdd_Job8(c: TCont; o: string);               //create job, screengrab
    procedure myAdd_Job9(c: TCont);                          //create job, concat:file1|file2|file3
    procedure myAdd2Job1(fn: string; jo: TJob);              //add to job, 1 file
    procedure myAdd2Job5(c: TCont; jo: TJob);                //add to job, all files
    procedure myAddFiles(c: TCont);                          //add files
    procedure myAddFile1(fn, o: string);                     //add 1 file and similar files
    procedure myAdd_pics(fn, o: string);                     //add folder with pics
    procedure myAddSplit(c: TCont);                          //add files split
    procedure myAddStart;
    procedure myParseParams(params: TStrings);
    procedure myGetClipboardFileNames(c: TCont; test: boolean = False);
    function myUnExpandFN(fn: string): string;
    procedure myFindFiles(dir, exe: string; cmb: TComboBox; bSet2: boolean = True);
    procedure myFindPlayers(bSet2: boolean);
    procedure myFindMediaInfo(bSet2: boolean);
    function myGetMediaInfo(fn, par: string; sk: TMIStreamKind = Stream_Video; sn: integer = 0): string;
    function myGetFileList(const Path, Mask: string; List: TStrings; subdir, fullpath, test: boolean): boolean;
    procedure myDisComp;
    procedure myDisTab(w: TWinControl; b: boolean);
    procedure myBusy(b: boolean);
    function myGetCaptionCont(c: TCont): string;
    procedure myGetWH(c: TCont; out w, h: integer; b: boolean = False);
    function myValInt(f, v: string): integer;
    function myValStr(f, v: string): string;
    function myFileExists(fn: string): boolean;
    function myChkFile(Sender: TObject): boolean;
    procedure myFillFmtEnc;                                  //get encoders formats from ffmpeg
    function myNoJo(out jo: TJob): boolean;                  //read object
    function myNoJoC(out jo: TJob; out c: TCont): boolean;   //read objects
    function myGetCurrCont(jo: TJob; s: string): TCont;      //read object number using string "0:2"
    function myWindowColorIsDark: boolean;
    function myGetExtsFromMasks: string;
    procedure myToIni(Ini: TMemIniFile; Section, Key, Value: string); //read write string
    procedure mySet1(Ini: TMemIniFile; s: string;
      a: array of TComponent; bRead: boolean);               //read write component values
    procedure mySaveCont(Ini: TMemIniFile; s: string; a: array of TComponent; c: TCont);
    procedure mySets(bRead: boolean);                        //read write settings
    procedure myHistory(bRead: boolean);                     //read write history
    procedure myFormPosLoad(Form: TForm; Ini: TMemIniFile);
    procedure myFormPosSave(Form: TForm; Ini: TMemIniFile);
    procedure myLanguage(bRead: boolean; bDefault: boolean = False); //read write language strings
    procedure myChkCpuCount;                                 //get cpu cores count
    procedure myChngFormat;
    procedure myChngEnc;
    procedure myMoveLi(lv: TListView; X, Y: integer);
    function myGetFilter(jo: TJob; c: TCont; mode: integer = 0): string;
    function myValSAR(s: string): extended;                  //sample aspect ratio
    function myGetSAR(s: string): string;                    //sample aspect ratio - string
    function myValFPS(a: array of string): extended;         //frames per seconds
    procedure myAdd2cmb(c: TComboBox; s: string; add: boolean = True);
    procedure myGetss4Compare(jo: TJob; rs: double = 0; rt: double = 0); //get -ss -t for compare util
    function myCalcOutSize(jo: TJob): string;
    function myCalcEncV(c: TCont): string;
    function myCalcEncA(c: TCont): string;
    function myCalcEncS(c: TCont): string;
    function myCalcBRv(c: TCont): string;
    function myCalcBRa(c: TCont): string;
    procedure myShowCaption(s: string);
    procedure myFillSGin(si: TStrings; ct: string);          //get list of screen, camera, audio inputs
    function myExtrDirExist(d: string): string;              //get existing dir
    function myProfileRead(f: string; jo: TJob): boolean;
    procedure myTags(jo: TJob);                              //copy tags from input to output
    procedure myGenTags(s: string; out a, t: string);
    function myGetTag(c: TCont; s: string): string;
    procedure myGetColumns56(jo: TJob; out v, a: string);    //get values for columns number 5 and 6
    function myGetOutputFN(jo: TJob): string;
    procedure myTredExe1(mode: integer; m: TSynMemo; c, d: string); //modes: 0=convert, 1=test, 2=add jobs
    procedure myTredExe2(term: boolean; sl: TStringList; m: TSynMemo; c, d: string; swo: TShowWindowOptions = swoHIDE); //mode 3=other
    procedure myListBox1view(cmb: TComboBox);
  public
    { public declarations }
    procedure myError(i: integer; s: string);
    function myDirExists(dir, s: string): boolean;
    procedure myGetRunFromJo(jo: TJob; var run: TRun; mode: integer; term: boolean); //modes: 0=convert, 1=test, 4=play, 5=cmdline
    function myGetFPS(jo: TJob; stream: string): extended;
    function myGetPic(ss, fn, fv: string; sm: TSynMemo): string;
    function myGetFrame(nb: integer; fn, fv: string; sm: TSynMemo): string;
    function myGetNumFrames(fn: string; sm: TSynMemo): integer;
    function myStrReplace(s: string; jo: TJob = nil): string;
    procedure myParseIni(jo: TJob; l: integer; o: string);
    procedure myPlayOut(jo: TJob);
    procedure mylst2run(term: boolean; a: TStrings; run: TRun);
    function myExpandFN(fn: string; dir: boolean = False): string;
    function myGetInputFiles(jo: TJob; s: string; sl: TStrings): string; //Result := stream number (get last numbers from string "0:2")
    function myGetDuration(jo: TJob): double;
  end;

var
  frmGUIta: TfrmGUIta;
  sCap, sDirApp, sInidir, sInifile, sLngfile, sHistory: string;
  cfg, hst: TMemIniFile; //main config
  fsp: TFormatSettings;
  mes: array [0..57] of string;
  tAutoStart: TTimer;
  bUpdFromCode: boolean;
  sdiv: string = '--------------------------------------------------------------------------------';
  DuraAll: double = 0;
  DuraAl2: integer = 0;
  DuraJob: string;
  Files2Add: TList;
  Counter: integer = 0;
  myUnik: TUniqueInstance;
  cDefaultSets: TCont; //default settings,
  cCmdIni: TCont;
  iTabCount: integer;
  sMyInputFN:     string = 'my_inputfn';    //input source filename
  sMyOutputFNbak: string = 'my_outputfnbak';//backup filename for generating filenames with counter: "output filename (1).ext"
  sMyffprobe:     string = 'my_ffprobe';    //0 - get streams info, 1 - do not get
  sMyCompleted:   string = 'my_Completed';  //0 - job added, 1 - completed, 2 - in progress, 3 - error
  sMyChecked:     string = 'my_Checked';    //0 - do not convert, 1 - in queue
  sMyIndex:       string = 'my_index';      //job number
  sMyProfile:     string = 'profile.ini';   //content of file or stream of convert options
  sMyTested:      string = 'my_tested';     //if tested do not calculate output size
  sMyCompar1:     string = 'my_cmp_time1';  //compare pics: start time for input file
  sMyCompar2:     string = 'my_cmp_time2';  //compare pics: start time for output file
  sMySplitted:    string = 'my_splitted';   //split file into fragments
  sDevNull: string = {$IFDEF MSWINDOWS}'NUL'{$ELSE}'/dev/null'{$ENDIF};
  lsWinState: TList;

implementation

uses ubyUtils, ufrmcrop, ufrmtrack, ufrmgendb, ufrmcompare, ufrmmaskprof;

{$R *.lfm}

procedure TfrmGUIta.myToIni(Ini: TMemIniFile; Section, Key, Value: string);
var
  s, t: string;
begin
  Value := Trim(Value);
  s := Ini.ReadString(Section, Key, '');
  t := cDefaultSets.getval(Key);
  if Ini.ValueExists(Section, Key) and (t = Value) then
  begin
    Ini.DeleteKey(Section, Key);
    //DebuglnThreadLog(['delete key [', Section, '] ', Key]);
  end
  else
  if (s <> Value) and (t <> Value) then
  begin
    Ini.WriteString(Section, Key, Value);
    //DebuglnThreadLog(['write string [', Section, '] ', Key, '=', Value]);
  end;
end;

procedure TfrmGUIta.mySet1(Ini: TMemIniFile; s: string; a: array of TComponent; bRead: boolean);
var
  k, i: integer;
begin
  for k := 0 to High(a) do
  if a[k] is TComboBox then
    with TComboBox(a[k]) do
      if bRead then
      begin
        if (Style = csDropDownList) then
          ItemIndex := StrToIntDef(Ini.ReadString(s, Name, '-1'), -1)
        else
          Text := Ini.ReadString(s, Name, Text);
      end
      else
      begin
        if (Style = csDropDownList) then
        begin
          if (ItemIndex >= 0) and (ItemIndex < Items.Count) then
            myToIni(Ini, s, Name, IntToStr(ItemIndex))
          else
            myToIni(Ini, s, Name, '');
        end
        else
          myToIni(Ini, s, Name, Text);
      end
  else if a[k] is TCheckBox then
    with TCheckBox(a[k]) do
      if bRead then
        Checked := Ini.ReadBool(s, Name, Checked)
      else
        myToIni(Ini, s, Name, IfThen(Checked, '1', '0'))
  else if a[k] is TSpinEdit then
    with TSpinEdit(a[k]) do
      if bRead then
        Value := Ini.ReadInteger(s, Name, Value)
      else
        myToIni(Ini, s, Name, IfThen(Value <> MinValue, IntToStr(Value), ''))
  else if a[k] is TColorButton then
    with TColorButton(a[k]) do
      if bRead then
        ButtonColor := StringToColor(Ini.ReadString(s, Name, ColorToString(ButtonColor)))
      else
        myToIni(Ini, s, Name, ColorToString(ButtonColor))
  else if a[k] is TPanel then
    for i := 0 to TPanel(a[k]).ControlCount - 1 do
      mySet1(Ini, s, [TPanel(a[k]).Controls[i]], bRead)
  else if a[k] is TTabSheet then
    for i := 0 to TTabSheet(a[k]).ControlCount - 1 do
      mySet1(Ini, s, [TTabSheet(a[k]).Controls[i]], bRead)
  else if a[k] is TPageControl then
    for i := 0 to TPageControl(a[k]).PageCount - 1 do
      mySet1(Ini, s, [TPageControl(a[k]).Pages[i]], bRead);
end;

procedure TfrmGUIta.mySaveCont(Ini: TMemIniFile; s: string; a: array of TComponent; c: TCont);
var
  k, i: integer;
begin
  for k := 0 to High(a) do
  if (a[k] is TComboBox) or (a[k] is TCheckBox) or (a[k] is TSpinEdit) then
    with TWinControl(a[k]) do
      myToIni(Ini, s, Name, c.getval(Name))
  else if (a[k] is TPanel) or (a[k] is TTabSheet) then
    for i := 0 to TWinControl(a[k]).ControlCount - 1 do
      mySaveCont(Ini, s, [TWinControl(a[k]).Controls[i]], c)
  else if a[k] is TPageControl then
    for i := 0 to TPageControl(a[k]).PageCount - 1 do
      mySaveCont(Ini, s, [TPageControl(a[k]).Pages[i]], c);
end;

procedure TfrmGUIta.mySets(bRead: boolean);
var
  s: string;
  i, j: integer;
  li: TListItem;
  sl: TStringList;
begin
  if bRead and not FileExistsUTF8(sInifile) then Exit;
  bUpdFromCode := True;
  {$IFDEF MSWINDOWS}
  s := 'Win';
  {$ELSE}
  s := 'Nix';
  {$ENDIF}
  mySet1(cfg, s, [TabSets1, TabScreenGrab], bRead);
  s := 'Main';
  mySet1(cfg, s, [TabSets2, TabColors, cmbProfile, chkProfile2All], bRead);
  //if bRead then cmbProfileChange(nil);
  //splitter
  if bRead then
  begin
    pnlJobs.Height := cfg.ReadInteger(s, pnlJobs.Name, pnlJobs.Height);
    pnlStreams.Width := cfg.ReadInteger(s, pnlStreams.Name, pnlStreams.Width);
  end
  else
  begin
    myToIni(cfg, s, pnlJobs.Name, IntToStr(pnlJobs.Height));
    myToIni(cfg, s, pnlStreams.Name, IntToStr(pnlStreams.Width));
  end;
  //masks
  sl := TStringList.Create;
  sl.Delimiter := '|';
  if bRead then
  begin
    LVmasks.BeginUpdate;
    LVmasks.Items.Clear;
    i := 0;
    repeat
      s := cfg.ReadString('Mask', 'mask_' + IntToStr(i), '');
      sl.DelimitedText := s;
      j := sl.Count;
      if j = 4 then
      begin
        li := LVmasks.Items.Add;
        li.Checked := sl[0] = '1';
        li.Caption := sl[1];
        li.SubItems.Add(sl[2]);
        li.SubItems.Add(sl[3]);
      end;
      inc(i);
    until s = '';
    LVmasks.EndUpdate;
  end
  else
  begin
    cfg.ReadSectionValues('Mask', sl);
    if sl.Count <> LVmasks.Items.Count then cfg.EraseSection('Mask');
    for i := 0 to LVmasks.Items.Count - 1 do
    begin
      myToIni(cfg, 'Mask', 'mask_' + IntToStr(i),
        IfThen(LVmasks.Items[i].Checked, '1', '0') + '|' +
        LVmasks.Items[i].Caption + '|' +
        LVmasks.Items[i].SubItems[0] + '|"' +
        LVmasks.Items[i].SubItems[1] + '"');
    end;
  end;
  sl.Free;
  bUpdFromCode := False;
end;

procedure TfrmGUIta.myHistory(bRead: boolean);
var
  s: string;
  i, j: integer;
  sl: TStringList;
begin
  //run cmd
  sl := TStringList.Create;
  hst.ReadSection(cmbRunCmd.Name, sl);
  j := StrToIntDef(cDefaultSets.getval(cmbRunCmd.Name), 0);
  if bRead then
  for i := 0 to sl.Count - 1 do
  begin
    s := hst.ReadString(cmbRunCmd.Name, sl[i], '');
    myAdd2cmb(cmbRunCmd, s);
  end
  else
  if sl.Count <> cmbRunCmd.Items.Count - j then
  begin
    hst.EraseSection(cmbRunCmd.Name);
    for i := j to cmbRunCmd.Items.Count - 1 do
      myToIni(hst, cmbRunCmd.Name, IntToStr(i), cmbRunCmd.Items[i]);
  end;
  sl.Free;
  //todo: add other comboboxes
end;

procedure mySet2(Sender: TObject; s: string);
begin
  if (Sender is TComboBox) then
  begin
    if (TComboBox(Sender).Style = csDropDownList)  then
      TComboBox(Sender).ItemIndex := StrToIntDef(s, -1)
    else
      TComboBox(Sender).Text := s;
  end
  else if (Sender is TEdit) then
    TEdit(Sender).Text := s
  else if (Sender is TLabeledEdit) then
    TLabeledEdit(Sender).Text := s
  else if (Sender is TCheckBox) then
    TCheckBox(Sender).Checked := (s = '1')
  else if (Sender is TSpinEdit) then
    TSpinEdit(Sender).Value := StrToIntDef(s, -1)
  else if (Sender is TMemo) then
    TMemo(Sender).Text := s
  else if (Sender is TColorButton) then
    TColorButton(Sender).ButtonColor := StringToColor(s);
end;

function myGet2(Sender: TObject): string;
begin
  if (Sender is TComboBox) then
  begin
    if (TComboBox(Sender).Style = csDropDownList) then
      Result := IntToStr(TComboBox(Sender).ItemIndex)
    else
      Result := TComboBox(Sender).Text;
  end
  else if (Sender is TEdit) then
    Result := TEdit(Sender).Text
  else if (Sender is TLabeledEdit) then
    Result := TLabeledEdit(Sender).Text
  else if (Sender is TCheckBox) then
    Result := IfThen(TCheckBox(Sender).Checked, '1', '0')
  else if (Sender is TSpinEdit) then
    Result := IntToStr(TSpinEdit(Sender).Value)
  else if (Sender is TMemo) then
    Result := TMemo(Sender).Text
  else if (Sender is TColorButton) then
    Result := ColorToString(TColorButton(Sender).ButtonColor)
  else
    Result := '';
end;

procedure myCont2Tab(c: TCont; wc: TWinControl);
var
  i, j: integer;
begin
  for i := 0 to wc.ControlCount - 1 do
  if wc.Controls[i] is TPanel then
    myCont2Tab(c, TPanel(wc.Controls[i]))
  else if wc.Controls[i] is TPageControl then
    for j := 0 to TPageControl(wc.Controls[i]).PageCount - 1 do
      myCont2Tab(c, TPageControl(wc.Controls[i]).Pages[j])
  else
    mySet2(wc.Controls[i], c.getval(wc.Controls[i].Name));
end;

procedure myClear2(a: array of TControl);
var
  k, i, j: integer;
  wc: TWinControl;
begin
  for k := 0 to High(a) do
  begin
    wc := TWinControl(a[k]);
    for i := 0 to wc.ControlCount - 1 do
    if wc.Controls[i] is TPanel then
      myClear2([wc.Controls[i]])
    else if wc.Controls[i] is TPageControl then
      for j := 0 to TPageControl(wc.Controls[i]).PageCount - 1 do
        myClear2([TPageControl(wc.Controls[i]).Pages[j]])
    else
      mySet2(wc.Controls[i], '');
  end;
end;

{ TfrmGUIta }

function TfrmGUIta.myGetDirTmp(fn: string): string;
begin
  if edtDirTmp.Text <> '' then
    Result := AppendPathDelim(myExpandFN(edtDirTmp.Text, True))
  else if fn <> '' then
    Result := ExtractFilePath(fn)
  else
    Result := AppendPathDelim(GetTempDir);
end;

function TfrmGUIta.myGetDirOut(o, fn: string): string;
begin
  if o <> '' then
    Result := AppendPathDelim(o)
  else if edtDirOut.Text <> '' then
    Result := AppendPathDelim(edtDirOut.Text)
  else
    Result := ExtractFilePath(fn);
end;

function TfrmGUIta.myGetDirOut(o, basedir, fn: string): string;
var
  s: string;
begin
  if chkDirOutStruct.Checked then
    s := ExtractRelativepath(basedir, fn)
  else
    s := '';
  if o <> '' then
    Result := AppendPathDelim(o) + s
  else if edtDirOut.Text <> '' then
    Result := AppendPathDelim(edtDirOut.Text) + s
  else
    Result := ExtractFilePath(fn);
end;

procedure TfrmGUIta.myProfile2jo(p: string; jo: TJob);
var
  sl: TStringList;
  s: string;
begin
  jo.setval(cmbProfile.Name, p); //save profile filename
  if p = mes[52] then //(default)
  begin
    jo.setval(sMyProfile,
      '[1]' + LineEnding
    + cmbExt.Name + '=.mkv' + LineEnding
    + '[video]' + LineEnding
    + cmbEncoderV.Name + '=libx264' + LineEnding
    + '[audio]' + LineEnding
    + cmbEncoderA.Name + '=aac' + LineEnding
    + cmbBitrateA.Name + '=iff(in_bitrate/in_ch>160,ch*160,in_bitrate/in_ch*ch)' + LineEnding
    + '[subtitle]' + LineEnding
    + cmbEncoderS.Name + '=iff(pos(codec_name,"subrip ass webvtt")>0,"copy","")' + LineEnding);
  end
  else
  if p = mes[53] then //(screengrab)
  begin
    s := '[1]' + LineEnding
    + cmbExt.Name + '=' + cmbSGoutext.Text + LineEnding
    + cmbAddOptsO.Name + '=' + cmbSGmaps.Text + ' ' + cmbSGcodecvideo.Text + ' ' + cmbSGcodecaudio.Text + LineEnding;
    if cmbSGfiltercomplex.Text <> '' then
    begin
      s += cmbFilterComplex.Name + '=' + cmbSGfiltercomplex.Text + LineEnding;
    end
    else
    begin
      if chkSGsource0.Checked or chkSGsource1.Checked then
        s += '[video]' + LineEnding + cmbEncoderV.Name + '=no' + LineEnding;
      if chkSGsource2.Checked or chkSGsource3.Checked then
        s += '[audio]' + LineEnding + cmbEncoderA.Name + '=no' + LineEnding;
    end;
    jo.setval(sMyProfile, s);
  end
  else
  if FileExistsUTF8(sInidir + p) then
  begin
    sl := TStringList.Create;
    sl.LoadFromFile(sInidir + p);
    jo.setval(sMyProfile, sl.Text); //save profile content
    sl.Free;
  end;
end;

procedure mySplitFN(fn: string; out s, t: string);
var
  i: integer;
begin
  s := '';
  t := fn;
  if FileExistsUTF8(fn) then Exit;
  i := Pos(' -i ', fn);
  if i > 0 then
  begin
    s := Copy(fn, 1, i - 1);
    t := Copy(fn, i + 4, Length(fn));
  end;
end;

procedure TfrmGUIta.myInit_jo(fn, o: string; out jo: TJob);
var
  s, t: string;

  function myGetProfile(fn: string): string;
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
        myStr2List(s, ';', SL);
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
      if Result <> '' then Break;
    end;
    if Result = '' then
      Result := cmbProfile.Text;
    if (Result = '') and (cmbProfile.Items.Count > 0) then
      Result := cmbProfile.Items[0];
  end;

begin
  Inc(Counter);
  jo := TJob.Create;
  jo.setval(sMyIndex, IntToStr(Counter));
  jo.setval(sMyCompleted, '0');
  jo.setval(edtDirOut.Name, o);
  jo.setval(sMyOutputFNbak, ExtractFileNameOnly(fn));
  mySplitFN(fn, s, t); //"-f format -i input" or "input"
  myProfile2jo(myGetProfile(t), jo);
  jo.AddFile(t);
  jo.f[0].setval(cmbAddOptsI.Name, s);
end;

procedure TfrmGUIta.myAdd_Job1(fn, o: string; out jo: TJob);
begin
  myInit_jo(fn, o, jo);
  Files2Add.Add(Pointer(jo));
end;

procedure TfrmGUIta.myAdd_Job2(fn, o: string);
var
  jo: TJob;
begin
  myInit_jo(fn, o, jo);
  Files2Add.Add(Pointer(jo));
end;

procedure TfrmGUIta.myAdd_Job4(c: TCont);
var
  i, l: integer;
  s, t: string;
  jo: TJob;
begin
  if Length(c.sk) = 0 then Exit;
  myInit_jo(c.sk[0], c.sv[0], jo);
  for i := 1 to High(c.sk) do
  begin
    mySplitFN(c.sk[i], s, t); //"-f format -i input" or "input"
    l := jo.AddFile(t);
    jo.f[l].setval(cmbAddOptsI.Name, s);
  end;
  Files2Add.Add(Pointer(jo));
end;

procedure TfrmGUIta.myAdd_Job7(c: TCont);
var
  i: integer;
  t: string;
  jo: TJob;
  sl: TStringList;
begin
  if Length(c.sk) = 0 then Exit;
  t := myGetTempFileName(myGetDirTmp(c.sk[0]), 'ff', '.txt');
  sl := TStringList.Create;
  for i := 0 to High(c.sk) do
  begin
    sl.Add('file ''' + c.sk[i] + '''');
  end;
  try
    sl.SaveToFile(t);
  except
    on E: Exception do myError(-1, 'myAdd_Job7: ' + mes[56] + ' - ' + t + ' ' + E.Message); //cant save to file
  end;
  sl.Free;
  myInit_jo(t, c.sv[0], jo);
  jo.f[0].setval(cmbAddOptsI.Name, '-f concat -safe 0');
  Files2Add.Add(Pointer(jo));
end;

procedure TfrmGUIta.myAdd_Job8(c: TCont; o: string);
var
  jo: TJob;
begin
  Inc(Counter);
  jo := TJob.Create;
  jo.setval(sMyIndex, IntToStr(Counter));
  jo.setval(sMyCompleted, '0');
  myProfile2jo(mes[53], jo); //(screengrab)
  jo.setval(edtDirOut.Name, myGetDirOut(o, myGetDirTmp('') + 'tmp'));
  jo.setval(sMyOutputFNbak, cmbSGoutput.Text);
  if chkSGsource0.Checked then c.addval(cmbSGsource0.Text, '');
  if chkSGsource1.Checked then c.addval(cmbSGsource1.Text, '');
  if chkSGsource2.Checked then c.addval(cmbSGsource2.Text, '');
  if chkSGsource3.Checked then c.addval(cmbSGsource3.Text, '');
  myAdd2Job5(c, jo);
  memJournal.Lines.Add('screengrab to ' + o);;
end;

procedure TfrmGUIta.myAdd_Job9(c: TCont);
var
  i: integer;
  t: string;
  jo: TJob;
begin
  if Length(c.sk) = 0 then Exit;
  t := 'concat:' + c.sk[0];
  for i := 1 to High(c.sk) do
    t += '|' + c.sk[i];
  myInit_jo(t, c.sv[0], jo);
  Files2Add.Add(Pointer(jo));
end;

procedure TfrmGUIta.myAdd2Job1(fn: string; jo: TJob);
var
  l: integer;
  s, t: string;
begin
  mySplitFN(fn, s, t); //"-f format -i input" or "input"
  l := jo.AddFile(t);
  jo.f[l].setval(cmbAddOptsI.Name, s);
  Files2Add.Add(Pointer(jo));
end;

procedure TfrmGUIta.myAdd2Job5(c: TCont; jo: TJob);
var
  i, l: integer;
  s, t: string;
begin
  for i := 0 to High(c.sk) do
  begin
    mySplitFN(c.sk[i], s, t); //"-f format -i input" or "input"
    l := jo.AddFile(t);
    jo.f[l].setval(cmbAddOptsI.Name, s);
  end;
  Files2Add.Add(Pointer(jo));
end;

procedure TfrmGUIta.myAddFiles(c: TCont);
var
  i: integer;
begin
  for i := 0 to High(c.sk) do
    myAddFile1(c.sk[i], c.sv[i]);
end;

procedure TfrmGUIta.myAddFile1(fn, o: string);
var
  c: TCont;
  x: string;

  procedure myAdd_cue;
  var
    sl: TStringList;
    i, l, k: integer;
    s, t, lf: string;
    cu, jo: TJob;
    r1, r2: double;

    function my0(s: string): double; //mm:ss:ff = minutes:seconds:frames
    var
      i: integer;
      s1, s2, s3: string;
    begin
      s1 := ''; s2 := ''; s3 := '';
      i := Pos(':', s);
      if (i > 1) then
      begin
        s1 := Copy(s, 1, i - 1);
        Delete(s, 1, i);
      end;
      i := Pos(':', s);
      if (i > 1) then
      begin
        s2 := Copy(s, 1, i - 1);
        s3 := Copy(s, i + 1, 2);
      end;
      Result := StrToIntDef(s1, 0) * 60 + StrToIntDef(s2, 0) + StrToIntDef(s3, 0) / 75; //CDDA: 75 frames per sec
    end;

  begin
    cu := TJob.Create;
    sl := TStringList.Create;
    sl.LoadFromFile(fn);
    i := 0;
    l := -1;
    while i < sl.Count do
    begin
      s := sl[i] + LineEnding;
      if Pos('REM GENRE', s) > 0 then cu.setval('REM GENRE', AnsiDequotedStr(myBetween(s, 'GENRE ', LineEnding), '"'));
      if Pos('REM DATE', s)  > 0 then cu.setval('REM DATE',  myBetween(s, 'DATE ', LineEnding));
      if Pos('PERFORMER', s) > 0 then cu.setval('PERFORMER', AnsiDequotedStr(myBetween(s, ' ', LineEnding), '"'));
      if Pos('TITLE', s)     > 0 then cu.setval('TITLE',     AnsiDequotedStr(myBetween(s, ' ', LineEnding), '"'));
      if Pos('FILE', s)      > 0 then Break;
      inc(i);
    end;
    while i < sl.Count do
    begin
      s := sl[i] + LineEnding;
      if Pos('FILE', s)      > 0 then
      begin
        l := cu.AddFile(ExtractFilePath(fn) + myBetween(s, '"', '"'));
        k := -1;
        inc(i);
        while i < sl.Count do
        begin
          s := sl[i] + LineEnding;
          if Pos('TRACK', s)     > 0 then
          begin
            k := cu.f[l].AddStream;
            cu.f[l].s[k].setval('TRACK', myBetween(s, 'TRACK ', ' '));
          end;
          if k < 0 then //FILE "file.wav" WAVE\n INDEX 01 00:00:00
          begin
            k := cu.f[l].AddStream;
            Continue;
          end
          else
          begin
            if Pos('TITLE', s)     > 0 then cu.f[l].s[k].setval('TITLE',     AnsiDequotedStr(myBetween(s, 'TITLE ', LineEnding), '"'));
            if Pos('PERFORMER', s) > 0 then cu.f[l].s[k].setval('PERFORMER', AnsiDequotedStr(myBetween(s, 'PERFORMER ', LineEnding), '"'));
            if Pos('INDEX 00', s)  > 0 then cu.f[l].s[k].setval('INDEX 00',  myBetween(s, 'INDEX 00 ', LineEnding));
            if Pos('INDEX 01', s)  > 0 then cu.f[l].s[k].setval('INDEX 01',  myBetween(s, 'INDEX 01 ', LineEnding));
          end;
          if Pos('FILE', s)      > 0 then Break;
          inc(i);
        end;
      end
      else
        inc(i);
    end;
    if chkDebug.Checked then
    begin
      memConsole.Lines.Add(fn);
      memConsole.Lines.Add(sdiv);
      for i := 0 to High(cu.sk) do
        memConsole.Lines.Add(cu.sk[i] + '=' + cu.sv[i]);
      for l := 0 to High(cu.f) do
      begin
        memConsole.Lines.Add(sdiv);
        memConsole.Lines.Add('$inpu' + IntToStr(l));
        for i := 0 to High(cu.f[l].sk) do
          memConsole.Lines.Add(cu.f[l].sk[i] + '=' + cu.f[l].sv[i]);
        for k := 0 to High(cu.f[l].s) do
        begin
          memConsole.Lines.Add(sdiv);
          for i := 0 to High(cu.f[l].s[k].sk) do
            memConsole.Lines.Add(cu.f[l].s[k].sk[i] + '=' + cu.f[l].s[k].sv[i]);
        end;
      end;
    end;
    for l := 0 to High(cu.f) do
    begin
      lf := cu.f[l].getval(sMyInputFN);
      for k := 0 to High(cu.f[l].s) do
      begin
        myAdd_Job1(lf, o, jo);
        s := cu.f[l].s[k].getval('INDEX 00');
        t := cu.f[l].s[k].getval('INDEX 01');
        if (s <> '') and (t = '') then r1 := my0(s) else
        if (s <> '') and (t <> '') then r1 := my0(t) else
        if (s = '') and (t <> '') then r1 := my0(t) else
          r1 := 0;
        if k < High(cu.f[l].s) then
        begin
          s := cu.f[l].s[k + 1].getval('INDEX 00');
          t := cu.f[l].s[k + 1].getval('INDEX 01');
          if (s <> '') and (t = '') then r2 := my0(s) else
          if (s <> '') and (t <> '') then r2 := my0(t) else
          if (s = '') and (t <> '') then r2 := my0(t) else
            r2 := 0;
        end
        else
          r2 := 0;
        r2 := r2 - r1;
        if r2 > 0 then jo.setval(cmbDurationt2.Name, myRealToTimeStr(r2));
        s := cu.f[l].s[k].getval('PERFORMER');
        t := cu.f[l].s[k].getval('TITLE');
        jo.setval(sMyOutputFNbak, s + ' - ' + t);
        jo.setval(sMySplitted, '1');
        if Length(jo.f) > 0 then
        begin
          if r1 > 0 then jo.f[0].setval(cmbDurationss1.Name, myRealToTimeStr(r1));
          jo.f[0].setval('TAG:artist', s);
          jo.f[0].setval('TAG:title', t);
          jo.f[0].setval('TAG:album_artist', cu.getval('PERFORMER'));
          jo.f[0].setval('TAG:album', cu.getval('TITLE'));
          jo.f[0].setval('TAG:track', cu.f[l].s[k].getval('TRACK'));
          jo.f[0].setval('TAG:date', cu.getval('REM DATE'));
          jo.f[0].setval('TAG:genre', cu.getval('REM GENRE'));
        end;
      end;
    end;
    sl.Free;
  end;

  procedure myAdd_m3u;
  var
    sl: TStringList;
    i: integer;
    s: string;
  begin
    sl := TStringList.Create;
    sl.LoadFromFile(fn);
    for i := 0 to sl.Count - 1 do
    begin
      s := sl[i];
      if (s <> '') and (s[1] <> '#') then
      begin
        if not FilenameIsAbsolute(s) then s := ExtractFilePath(fn) + s;
        myAdd_Job2(s, o);
      end;
    end;
    sl.Free;
  end;

  procedure myAdd_ffjob;
  var
    Ini: TMemIniFile;
    jo: TJob;
    sl: TStringList;
    i, l, k: integer;
    s, t: string;
    li: TListItem;
  begin
    Ini := TMemIniFile.Create(fn);
    LVjobs.BeginUpdate;
    LVfiles.BeginUpdate;
    LVstreams.BeginUpdate;
    jo := TJob.Create;
    sl := TStringList.Create;
    Ini.ReadSection('jo', sl);
    for i := 0 to sl.Count - 1 do
      jo.addval(sl[i], StringReplace(Ini.ReadString('jo', sl[i], ''), '\n', LineEnding, [rfReplaceAll]));
    Ini.ReadSection('m', sl);
    for i := 0 to sl.Count - 1 do
      jo.AddMap(Ini.ReadString('m', sl[i], ''));
    l := 0;
    s := 'jo.f.' + IntToStr(l);
    while Ini.SectionExists(s) do
    begin
      jo.AddFile('');
      Ini.ReadSection(s, sl);
      for i := 0 to sl.Count - 1 do
        jo.f[l].setval(sl[i], StringReplace(Ini.ReadString(s, sl[i], ''), '\n', LineEnding, [rfReplaceAll]));
      k := 0;
      t := 'jo.f.' + IntToStr(l) + '.s.' + IntToStr(k);
      while Ini.SectionExists(t) do
      begin
        jo.f[l].AddStream;
        Ini.ReadSection(t, sl);
        for i := 0 to sl.Count - 1 do
          jo.f[l].s[k].setval(sl[i], StringReplace(Ini.ReadString(t, sl[i], ''), '\n', LineEnding, [rfReplaceAll]));
        inc(k);
        t := 'jo.f.' + IntToStr(l) + '.s.' + IntToStr(k);
      end;
      inc(l);
      s := 'jo.f.' + IntToStr(l);
    end;
    sl.Free;

    inc(Counter);
    jo.setval(sMyIndex, IntToStr(Counter));

    li := LVjobs.Items.Add;
    li.ImageIndex := StrToIntDef(jo.getval(sMyCompleted), 0);
    li.Checked := jo.getval(sMyChecked) <> '0';
    li.Caption := jo.getval(sMyIndex);
    for i := 0 to LVjobs.ColumnCount - 1 do
      li.SubItems.Add(Ini.ReadString('SubItems', IntToStr(i), ''));
    li.Data := Pointer(jo);
    if (LVjobs.Items.Count = 1) then
      LVjobs.Items[0].Selected := True;
    LVjobs.EndUpdate;
    LVfiles.EndUpdate;
    LVstreams.EndUpdate;
    if li.Selected then
      LVjobsSelectItem(nil, li, True);
    Ini.Free;
  end;

  procedure myGetSimilarFiles;
  var
    i: integer;
    nStatus: Longint;
    b: boolean;
    SL: TStringList;
    SR: TSearchRec;
  begin
    SL := TStringList.Create;
    myStr2List(cmbAddTracks.Text, ';', SL);
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
        c.addval(ExtractFilePath(fn) + SR.Name, '');
      nStatus := FindNextUTF8(SR);
    end;
    FindCloseUTF8(SR);
    SL.Free;
  end;

begin
  x := LowerCase(ExtractFileExt(fn));
  if x = '.cue' then myAdd_cue else
  if (x = '.m3u') or (x = '.m3u8') then myAdd_m3u else
  if x = '.ffjob' then myAdd_ffjob else
  begin
    c := TCont.Create;
    c.addval(fn, o);
    if chkAddTracks.Checked then myGetSimilarFiles;
    myAdd_Job4(c);
    c.Free;
  end;
end;

procedure TfrmGUIta.myAdd_pics(fn, o: string);
var
  i, j, k, l: integer;
  s, t: string;
  frmT: TfrmTrack;
  jo: TJob;
begin
  Application.CreateForm(TfrmTrack, frmT);
  frmT.Font := frmGUIta.Font;
  frmT.Caption := btnAddImageDir.Caption;
  //sequence, decode filename to "foo-%03d.jpg"
  j := 0;
  k := 0;
  s := '';
  t := ExtractFileNameOnly(fn);
  for i := Length(t) downto 1 do
  begin
    if (k = 0) and IsNumber(t[i]) then
    begin
      inc(j);
      s := t[i] + s;
    end
    else
      inc(k);
  end;
  if j > 0 then
  begin
    i := StrToIntDef(s, 1);
    s := Copy(t, 1, k) + '%0' + IntToStr(j) + 'd';
    k := frmT.ComboBox1.Items.Add('-framerate 1 -pattern_type sequence -start_number ' + IntToStr(i)
      + ' -i ' + ExtractFilePath(fn) + s + ExtractFileExt(fn));
    if i < 500 then l := k;
  end;
  //glob
  {$IFDEF WINDOWS}
  l := 0;
  {$ELSE}
  l := frmT.ComboBox1.Items.Add('-framerate 1 -pattern_type glob -i '
    + ExtractFilePath(fn) + '*' + ExtractFileExt(fn));
  {$ENDIF}
  //one pic
  frmT.ComboBox1.Items.Add('-framerate 1 -i ' + fn);
  frmT.ComboBox1.Items.Add(fn);
  frmT.ComboBox1.ItemIndex := l;
  if frmT.ShowModal = mrOK then
  begin
    fn := frmT.ComboBox1.Text;
    myAdd_Job1(fn, o, jo);
    jo.setval(sMyOutputFNbak, t);
  end;
  frmT.Free;
end;

procedure TfrmGUIta.myAddSplit(c: TCont);
var
  i: integer;
  d, k, r: double;
  s, t: string;

  procedure my1(fn, o, ss, t: string);
  var
    jo: TJob;
    i: integer;
  begin
    myAdd_Job1(fn, o, jo);
    for i := 0 to High(jo.f) do
    begin
      jo.f[i].setval(cmbDurationss1.Name, ss);
      jo.f[i].setval(cmbDurationt1.Name, t);
    end;
    //jo.setval(cmbDurationt2.Name, t);
    jo.setval(sMySplitted, '1');
  end;

begin
  s := '10:00';
  if not InputQuery(mes[25], mes[26], s) then Exit; //Split file   length of cuts in seconds:
  r := myTimeStrToReal(s);
  if r = 0 then
    memJournal.Lines.Add('myAddSplit: ' + mes[6] + ' - ' + mes[37]) //Error - divide by zero
  else
  for i := 0 to High(c.sk) do
  begin
    myGetRunOut(myExpandFN(edtffprobe.Text), ['-v', 'error', '-show_entries', 'format=duration', '-of', 'default=noprint_wrappers=1:nokey=1', c.sk[i]], t);
    d := StrToFloatDef(Trim(t), 0, fsp); //trim #10
    if (d = 0) then
    begin
      t := myGetMediaInfo(s, 'Duration', Stream_General); //Duration;; ms;N YFY;;;Play time of the stream in ms;
      d := StrToFloatDef(t, 1, fsp) / 1000;
    end;
    k := 0;
    while k < d do
    begin
      my1(c.sk[i], c.sv[i], myRealToTimeStr(k, False), myRealToTimeStr(r, False));
      k += r;
    end;
  end;
end;

procedure TfrmGUIta.myAddStart;
var
  li: TListItem;
begin
  li := LVtrd.FindCaption(0, 'a', False, True, False);
  if li <> nil then Exit;
  myTredExe1(2, SynMemo6, 'a', mes[40]); //add files
  //if chkDebug.Checked then
  PageControl3.ActivePage := TabConsole4;
end;

procedure TfrmGUIta.myParseParams(params: TStrings);
var
  i, j, k: integer;
  s, t, o: string;
  sl: TStringList;
  c: TCont;
begin
  k := 0;
  o := '';
  c := TCont.Create;
  for i := 0 to params.Count - 1 do
  begin
    s := params[i];
    if chkDebug.Checked then memJournal.Lines.Add(s);
    if s = '' then Continue;
    if DirectoryExistsUTF8(s) then
    begin
      sl := TStringList.Create;
      if myGetFileList(s, myGetExtsFromMasks, sl, True, True, False) then
      begin
        sl.Sort;
        for j := 0 to sl.Count - 1 do
          c.addval(sl[j], myGetDirOut(o, s, ExtractFilePath(sl[j])));
      end;
      sl.Free;
    end
    else
    if FileExistsUTF8(s) then
    begin
      c.addval(s, myGetDirOut(o, s));
    end
    else
    if (s[1] = '-') {$IFDEF MSWINDOWS}or (s[1] = '/'){$ENDIF} then
    begin
      t := Copy(LowerCase(s), 2, Length(s));
      if (t = 'start') then //start jobs
      begin
        if tAutoStart = nil then
          tAutoStart := TTimer.Create(Self);
        tAutoStart.Enabled := False;
        tAutoStart.Interval := 5000;
        tAutoStart.OnTimer := @ontAutoStart;
        tAutoStart.Enabled := True;
      end
      else if (Copy(t, 1, 2) = 'o:') then //output folder
      begin
        o := Copy(s, 4, Length(s));
        {$IFDEF MSWINDOWS}
        if (Length(o) > 0) and (o[1] = '"') then
          o := Copy(o, 2, Length(o) - 2);
        {$ENDIF}
      end
      else if (Copy(t, 1, 2) = 'p:') then //use this profile
      begin
        chkUseMasks.Checked := False;
        bUpdFromCode := True;
        cmbProfile.Text := Copy(s, 4, Length(s));
        bUpdFromCode := False;
      end
      else if (t = 'p') or (t = 'profile')then chkUseMasks.Checked := False //use default profile
      else if (t = 'm') or (t = 'masks')  then chkUseMasks.Checked := True  //use masks profile
      else if (t = 'c') or (t = 'split')  then k := 1     //cut file to fragments
      else if (t = 'i') or (t = 'images') then k := 2     //first file of image sequence
      else if (t = 's') or (t = 'single') then k := 4     //all files as a single job
      else if (t = 'a') or (t = 'add')    then
      begin
        if (LVjobs.Selected <> nil)       then k := 5     //add files to job
        else                                   k := 4;    //all files as a single job
      end
      else if (t = 'concat')              then k := 7     //concat files
      else if (t = 'screengrab')          then k := 8     //screen grab
      else if (t = 'concat2')             then k := 9     //concat:file1|file2
      else if (t = 'h') or (t = '?') then                 //Usage:
      begin
        sl := TStringList.Create;
        sl.Text := StringReplace(mes[2], '\n', LineEnding, [rfReplaceAll]);
        memJournal.Lines.AddStrings(sl);
        sl.Free;
        PageControl1.ActivePage := TabJournal;
      end
      else
        c.addval(s, myGetDirOut(o, s));
    end
    else
      c.addval(s, myGetDirOut(o, s));
  end;
  if (Length(c.sk) > 0) or (k = 8) then
  begin
    case k of
      1: myAddSplit(c);
      2: myAdd_pics(c.sk[0], c.sv[0]);
      4: myAdd_Job4(c);
      5: myAdd2Job5(c, TJob(LVjobs.Selected.Data));
      7: myAdd_Job7(c);
      8: myAdd_Job8(c, o);
      9: myAdd_Job9(c);
      else
         myAddFiles(c);
    end;
    myAddStart;
  end;
  c.Free;
end;

function TfrmGUIta.myGetFilter(jo: TJob; c: TCont; mode: integer = 0): string;
var
  i: integer;
  t: string;

  procedure my1(cmb: TComboBox);
  var
    s, n: string;
  begin
    s := c.getval(cmb.Name);
    n := LowerCase(Copy(cmb.Name, 4, Length(cmb.Name)));
    if s <> '' then
    begin
      if Pos(',', s) > 0 then s := '''' + s + '''';
      Result := IfThen(Result <> '', Result + ',') + n + '=' + s;
    end;
  end;

  procedure my2(f: string);
  var
    l: integer;
    function my3(s: string): string;
    begin
      Result := StringsReplace(s, ['\', ':'], ['\\', '\:'], [rfReplaceAll]);
    end;
    {$IFDEF MSWINDOWS}
    // subtitles=d:\tmp\test' source, eac3, srt.mkv:si=0
    // subtitles='d\:\\tmp\\test'\\\'' source, eac3, srt.mkv':si=0
    function ff3(s: string): string;
    begin
      Result := StringsReplace(s, ['\', ':', ''''], ['\\', '\:', '''\\\'''''], [rfReplaceAll]);
      Result := '''' + Result + '''';
    end;
    {$ELSE}
    // http://ffmpeg.org/ffmpeg-filters.html#Notes-on-filtergraph-escaping
    // subtitles=/mnt/upload/t:est' source, eac3, srt.mkv:si=0
    // subtitles=/mnt/upload/t\:est\' source, eac3, srt.mkv:si=0
    // subtitles=/mnt/upload/t\\:est\\\' source\, eac3\, srt.mkv:si=0
    // subtitles=/mnt/upload/t\\\\:est\\\\\\' source\\, eac3\\, srt.mkv:si=0
    function ff1(s: string): string;
    begin
      Result := StringsReplace(s, ['''', ':'], ['\''', '\:'], [rfReplaceAll]);
    end;
    function ff2(s: string): string;
    begin
      Result := ff1(s);
      Result := StringsReplace(Result, ['\', '''', ','], ['\\', '\''', '\,'], [rfReplaceAll]);
    end;
    function ff3(s: string): string;
    begin
      Result := ff2(s);
      //modes: 0 = convert, 1 = test, 4 = play, 5 = cmdline
      if (mode = 5) and chkCmdline4shell.Checked then
        Result := StringReplace(Result, '\', '\\', [rfReplaceAll]);
    end;
    {$ENDIF}
    procedure r(s, t: string);
    var
      e: string;
    begin
      e := '$' + s;
      if (Pos(s, f) > 0) then f := StringReplace(f, e, t, [rfReplaceAll]);
      e := '${' + s + '}';
      if (Pos(s, f) > 0) then f := StringReplace(f, e, t, [rfReplaceAll]);
    end;

  begin
    if f = '' then Exit;
    if Length(jo.f) > 0 then
    begin
      for l := High(jo.f) downto 0 do
      begin
        r('inpu' + IntToStr(l), ff3(jo.f[l].getval(sMyInputFN))); //back compat
        r('input:' + IntToStr(l), ff3(jo.f[l].getval(sMyInputFN)));
      end;
      l := 0;
      r('input', ff3(jo.f[l].getval(sMyInputFN)));
      r('artist', my3(myGetTag(jo.f[l], 'artist')));
      r('title', my3(myGetTag(jo.f[l], 'title')));
      r('album', my3(myGetTag(jo.f[l], 'album')));
      r('track', Format('%.2d', [StrToIntDef(jo.f[l].getval('TAG:track'), 0)]));
      r('date', my3(jo.f[l].getval('TAG:date')));
    end;
    Result := IfThen(Result <> '', Result + ',') + f;
  end;

begin
  Result := '';
  t := c.getval('codec_type');
  if t = 'video' then
  begin
    my1(cmbCrop);
    my1(cmbScale);
    my1(cmbPad);
    if mode >= 0 then my1(cmbhqdn3d);
    i := StrToIntDef(c.getval(cmbRotate.Name), 7);
    if i in [0..6] then
      Result := IfThen(Result <> '', Result + ',');
    case i of
      0..3: Result += 'transpose=' + IntToStr(i);
      4: Result += 'hflip';
      5: Result += 'vflip';
      6: Result += 'hflip, vflip';
      7,-1: ;
      else
        memJournal.Lines.Add('rotate not in range [0..7]: ' + IntToStr(i));
    end;
    my1(cmbSetDAR);
    my2(c.getval(cmbFiltersV.Name));
  end
  else
  if t = 'audio' then
    my2(c.getval(cmbFiltersA.Name));
end;

procedure TfrmGUIta.myGetRunFromJo(jo: TJob; var run: TRun; mode: integer; term: boolean);
var
  c: TCont;
  cc, cv, ca, cs, cd: integer; //count all, video, audio, subtitles, data
  s, co, nt, fn: string;
  si, ma, fi, ec, p1, p2, ou: TStringList;
  mdw, mdc: boolean;
  //cr: string = {$IFDEF MSWINDOWS}''{$ELSE}' '#13{$ENDIF};
  cr: string = ' '#13;
  ext: string = {$IFDEF MSWINDOWS}'.bat'{$ELSE}'.sh'{$ENDIF};

  procedure m(sl: TStringList; t, s: string); //add to list
  begin
    if s = '' then Exit;
    if t = '' then process.CommandToList(s, sl)
    else begin sl.Add(t); sl.Add(s); end;
  end;

  procedure n(sl: TStringList; t, s: string); //add numbered for outgoing streams
  begin
    if s = '' then Exit;
    if t = '' then process.CommandToList(s, sl)
    else begin sl.Add(t + nt); sl.Add(s); end;
  end;

  procedure myInp; //inputfiles standard
  var
    l: integer;
  begin
    for l := 0 to High(jo.f) do
    begin
      m(si, '-ss', jo.f[l].getval(cmbDurationss1.Name));
      m(si, '-t', jo.f[l].getval(cmbDurationt1.Name));
      m(si, '-itsoffset', jo.f[l].getval(cmbItsoffset.Name));
      m(si, '', jo.f[l].getval(cmbAddOptsI.Name));
      m(si, '', jo.f[l].getval(cmbAddOptsI1.Name));
      m(si, '-i', jo.f[l].getval(sMyInputFN));
    end;
  end;

  procedure myInpT; //inputfiles test
  var
    l: integer;
    rd, rs, rt: double;
  begin
    rs := myTimeStrToReal(Trim(cmbTestDurationss.Text));
    rt := myTimeStrToReal(Trim(cmbTestDurationt.Text));
    //if rt = 0 then rt := 30;
    if CompareValue(rt, 0.0, 0.000001) = 0 then rt := 30;
    for l := 0 to High(jo.f) do
    begin
      rd := myTimeStrToReal(jo.f[l].getval('duration'));
      if rs > (rd - rt) then rs := rd - rt;
      if rs > 0 then s := myRealToTimeStr(rs) else s := '';
      m(si, '-ss', s);
      m(si, '-itsoffset', jo.f[l].getval(cmbItsoffset.Name));
      m(si, '', jo.f[l].getval(cmbAddOptsI.Name));
      m(si, '', jo.f[l].getval(cmbAddOptsI1.Name));
      m(si, '-i', jo.f[l].getval(sMyInputFN));
    end;
    myGetss4Compare(jo, rs, rt);
  end;

  function myDur1(l: integer): double;
  var
    rd, rt: double;
  begin
    rd := myTimeStrToReal(jo.f[l].getval('duration'));
    rd += myTimeStrToReal(jo.f[l].getval(cmbItsoffset.Name));
    rd -= myTimeStrToReal(jo.f[l].getval(cmbDurationss1.Name));
    rt := myTimeStrToReal(jo.f[l].getval(cmbDurationt1.Name));
    if (rt > 0) and (Pos('-loop 1', jo.f[l].getval(cmbAddOptsI.Name)) > 0) then Result := rt else
    if (rt > 0) and (rd > rt) then Result := rt else
    Result := rd;
  end;

  procedure my1m(t, s: string); // metadata stream
  begin
    if s <> '' then n(ou, '-metadata:s', t + '=' + s) else
    if not mdc and (c.getval('TAG:' + t) <> '') then n(ou, '-metadata:s', t + '='); //if not metadata clear then emptying tag
  end;

  procedure my2m; // metadata file
  var
    i: integer;
    sl: TStringList;
  begin
    if not mdw then Exit;
    if mdc then m(ou, '-map_metadata', '-1');
    sl := TStringList.Create;
    sl.Text := jo.getval(memTagsOut.Name);
    i := 0;
    while i < sl.Count do
    begin
      s := sl[i];
      inc(i);
      if (i < sl.Count) and (Pos('=', sl[i]) = 0) then //multiline tag
      begin
        repeat
          s += LineEnding + sl[i];
          inc(i);
        until (i = sl.Count) or (Pos('=', sl[i]) > 1);
      end;
      m(ou, '-metadata', s);
    end;
    sl.Free;
  end;

  procedure my1v; //video stream
  begin
    Inc(cv);
    Inc(cc);
    if chkStreamSpec.Checked then nt := ':v:' + IntToStr(cv) else nt := ':' + IntToStr(cc);
    if mode = 4 then
    begin
      n(ec, '-c', 'huffyuv');
      Exit;
    end;
    co := c.getval(edtEncoderV.Name);
    if co <> '' then
    begin
      if co <> 'no' then n(ec, '-c', co);
      if co <> 'copy' then
      begin
        n(ec, '-preset', c.getval(cmbPreset.Name));
        n(ec, '-tune', c.getval(cmbTune.Name));
        //case: quality, crf, cq or bitrate. ?todo: global_quality
        n(ec, '-q', c.getval(cmbQualityV.Name));
        n(ec, '-crf', c.getval(cmbcrfv.Name));
        n(ec, '-cq', c.getval(cmbcqV.Name));
        if c.getval(cmbBitrateV.Name) <> '' then
        begin
          n(ec, '-b', c.getval(edtBitrateV.Name));
          if (c.getval(cmbPass.Name) = '2') then
          begin
            s := myGetDirTmp(fn) + 'ffpass' + jo.getval(sMyIndex) + IntToStr(cv);
            n(p1, '-pass', '1'); n(p1, '-passlogfile', s);
            n(p2, '-pass', '2'); n(p2, '-passlogfile', s);
          end;
        end;
        n(ec, '-pix_fmt', c.getval(cmbpix_fmt.Name));
        n(ec, '', c.getval(cmbAddOptsV.Name));
      end;
      if mdw then
      begin
        my1m('title', c.getval(cmbTagTitleV.Name));
        my1m('language', c.getval(cmbTagLangV.Name));
      end;
    end;
  end;

  procedure my1a; //audio stream
  begin
    Inc(ca);
    Inc(cc);
    if chkStreamSpec.Checked then nt := ':a:' + IntToStr(ca) else nt := ':' + IntToStr(cc);
    if mode = 4 then
    begin
      n(ec, '-c', 'pcm_s16le');
      Exit;
    end;
    co := c.getval(edtEncoderA.Name);
    if co <> '' then
    begin
      if co <> 'no' then n(ec, '-c', co);
      if co <> 'copy' then
      begin
        //case: quality or bitrate
        n(ec, '-q', c.getval(cmbQualityA.Name));
        if c.getval(cmbBitrateA.Name) <> '' then
          n(ec, '-b', c.getval(edtBitrateA.Name));
        n(ec, '-ar', c.getval(cmbSRate.Name));
        n(ec, '-ac', c.getval(cmbChannels.Name));
        n(ec, '', c.getval(cmbAddOptsA.Name));
      end;
      if mdw then
      begin
        my1m('title', c.getval(cmbTagTitleA.Name));
        my1m('language', c.getval(cmbTagLangA.Name));
      end;
    end;
  end;

  procedure my1s; //subtitle stream
  begin
    Inc(cs);
    Inc(cc);
    if chkStreamSpec.Checked then nt := ':s:' + IntToStr(cs) else nt := ':' + IntToStr(cc);
    if mode = 4 then Exit;
    co := c.getval(edtEncoderS.Name);
    if co <> '' then
    begin
      if co <> 'no' then n(ec, '-c', co);
      if co <> 'copy' then
      begin
        n(ec, '', c.getval(cmbAddOptsS.Name));
      end;
      if mdw then
      begin
        my1m('title', c.getval(cmbTagTitleS.Name));
        my1m('language', c.getval(cmbTagLangS.Name));
      end;
    end;
  end;

  procedure my1d; //data stream
  begin
    Inc(cd);
    Inc(cc);
    if chkStreamSpec.Checked then nt := ':d:' + IntToStr(cv) else nt := ':' + IntToStr(cc);
    if mode = 4 then Exit;
    co := c.getval(cmbEncoderD.Name);
    if co <> '' then
    begin
      if co <> 'no' then n(ec, '-c', co);
    end;
  end;

  procedure myTrk;

  type
    TmyChainV = record
      p0, p1, f0, f1, f2, f3, tb, fps, ar: string;
      c, d, e, w, h, bw, bh, pw, ph: integer;
      sar: extended;
      bwh, bsar, bfps: boolean;
    end;

    TmyChainA = record
      p0, p1, f0, f1, f2, sr: string;
      c, k, ac: integer;
    end;

    var
      scenario: string;
      t, fl, sk: string;
      c1, c2, o1, o2, o3, o4: string;
      v: array of TmyChainV;
      a: array of TmyChainA;
      iv, ia: integer;

    procedure myTrk0; //standard job
    var
      i: integer;
    begin
      m(si, '-filter_complex', myStrReplace(jo.getval(cmbFilterComplex.Name), jo));
      // map and params for every track
      for i := 0 to High(jo.m) do //sort order
      begin
        c := myGetCurrCont(jo, jo.m[i]);
        if c.getval(sMyChecked) <> '1' then Continue;
        m(ma, '-map', jo.m[i]);
        t := c.getval('codec_type');
        if t = 'video'    then my1v else
        if t = 'audio'    then my1a else
        if t = 'subtitle' then my1s else
        if t = 'data'     then my1d;
        n(fi, '-filter', myGetFilter(jo, c, mode)); //if cmdline for shell
      end;
    end;

    procedure mySplitMap(mi: string);
    var
      i: integer;
    begin
      i := Pos(':', mi);
      fl := Copy(mi, 1, i - 1);
      sk := Copy(mi, i + 1, Length(mi));
    end;

    procedure mySplitMap(mi: string; var l: integer);
    var
      i: integer;
    begin
      i := Pos(':', mi);
      fl := Copy(mi, 1, i - 1);
      sk := Copy(mi, i + 1, Length(mi));
      l := StrToIntDef(fl, 0);
    end;

    procedure mySplitMap(mi: string; var l, k: integer);
    var
      i: integer;
    begin
      i := Pos(':', mi);
      fl := Copy(mi, 1, i - 1);
      sk := Copy(mi, i + 1, Length(mi));
      l := StrToIntDef(fl, 0);
      k := StrToIntDef(sk, 0);
    end;

    procedure ny1getv;
    begin
      my1v;
      inc(iv);
      SetLength(v, iv + 1);
      myGetWH(c, v[iv].w, v[iv].h, Pos('-noautorotate', jo.f[0].getval(cmbAddOptsI.Name)) = 0);
      v[iv].sar := myValSAR(c.getval('sample_aspect_ratio'));
      if Round(v[iv].sar * 10) = 10 then v[iv].ar := '1' else //101:100, 254:255
      v[iv].ar := FloatToStr(v[iv].sar, fsp);
      v[iv].tb := c.getval('time_base');
      v[iv].fps := c.getval('r_frame_rate');
      v[iv].bfps := False;
      v[iv].bsar := False;
      v[iv].bwh := False;
      v[iv].c := 0;   //count video 1
      v[iv].d := 0;   //count video 2
      v[iv].e := 0;   //count video 3
      v[iv].f0 := '';
      v[iv].f1 := '';
      v[iv].f2 := '';
      v[iv].f3 := '';
      v[iv].p1 := '[v' + IntToStr(cv) + ']'; //concat
    end;

    procedure ny1geta;
    begin
      my1a;
      inc(ia);
      SetLength(a, ia + 1);
      a[ia].ac := StrToIntDef(c.getval('channels'), 2);
      a[ia].sr := c.getval('sample_rate');
      a[ia].c := 0;   //count audio
      a[ia].f0 := '';
      a[ia].f1 := '';
      a[ia].p1 := '[a' + IntToStr(ca) + ']'; //concat
    end;

    procedure my1cFirstFile; //concat, sorted, checked
    var
      i: integer;
    begin
      iv := -1;
      ia := -1;
      for i := 0 to High(jo.m) do
      begin
        if Pos('0:', jo.m[i]) <> 1 then Continue; //first file
        c := myGetCurrCont(jo, jo.m[i]);
        if c.getval(sMyChecked) <> '1' then Continue; //only checked
        t := c.getval('codec_type');
        if t = 'video' then
        begin
          ny1getv;
          c2 += v[iv].p1;
        end;
      end;
      for i := 0 to High(jo.m) do
      begin
        if Pos('0:', jo.m[i]) <> 1 then Continue; //first file
        c := myGetCurrCont(jo, jo.m[i]);
        if c.getval(sMyChecked) <> '1' then Continue; //only checked
        t := c.getval('codec_type');
        if t = 'audio' then
        begin
          ny1geta;
          c2 += a[ia].p1;
        end;
      end;
    end;

    procedure my1nFirstFile; //concat, not sorted
    var
      l, k: integer;
    begin
      l := 0;
      iv := -1;
      ia := -1;
      for k := 0 to High(jo.f[l].s) do
      begin
        c := jo.f[l].s[k];
        t := c.getval('codec_type');
        if t = 'video' then
        begin
          ny1getv;
          c2 += v[iv].p1;
        end
        else
        if t = 'audio' then
        begin
          ny1geta;
          c2 += a[ia].p1;
        end;
      end;
    end;

    procedure my1cFirstFile12; //concat, sorted, checked
    var
      i: integer;
    begin
      iv := -1;
      ia := -1;
      for i := 0 to High(jo.m) do
      begin
        c := myGetCurrCont(jo, jo.m[i]);
        if c.getval(sMyChecked) <> '1' then Continue; //only checked
        t := c.getval('codec_type');
        if t = 'video' then
        begin
          ny1getv;
          c2 += v[iv].p1;
          Break; //1 video
        end;
      end;
      for i := 0 to High(jo.m) do
      begin
        c := myGetCurrCont(jo, jo.m[i]);
        if c.getval(sMyChecked) <> '1' then Continue; //only checked
        t := c.getval('codec_type');
        if t = 'audio' then
        begin
          ny1geta;
          c2 += a[ia].p1;
          Break; //1 audio
        end;
      end;
    end;

    procedure ny2getv(l: integer);
    var
      w, h: integer;
    begin
      myGetWH(c, w, h, Pos('-noautorotate', jo.f[l].getval(cmbAddOptsI.Name)) = 0);
      if (v[iv].w <> w) or (v[iv].h <> h) then v[iv].bwh := True;
      if v[iv].bsar or (v[iv].sar <> myValSAR(c.getval('sample_aspect_ratio'))) then v[iv].bsar := True;
      if v[iv].bfps or (v[iv].tb <> c.getval('time_base')) then v[iv].bfps := True;
      if v[iv].bfps or (v[iv].fps <> c.getval('r_frame_rate')) then v[iv].bfps := True;
    end;

    procedure my2cCheckDiff;
    var
      l, i: integer;
    begin
      for l := 1 to High(jo.f) do
      begin
        iv := -1;
        for i := 0 to High(jo.m) do
        begin
          if Pos(IntToStr(l) + ':', jo.m[i]) <> 1 then Continue; //streams of current file
          c := myGetCurrCont(jo, jo.m[i]);
          if c.getval(sMyChecked) <> '1' then Continue; //only checked
          t := c.getval('codec_type');
          if t = 'video' then
          begin
            inc(iv);
            if iv > High(v) then Continue;
            ny2getv(l);
          end;
        end;
      end;
    end;

    procedure my2nCheckDiff;
    var
      l, k: integer;
    begin
      for l := 1 to High(jo.f) do
      begin
        iv := -1;
        for k := 0 to High(jo.f[l].s) do
        begin
          c := jo.f[l].s[k];
          t := c.getval('codec_type');
          if t = 'video' then
          begin
            inc(iv);
            if iv > High(v) then Continue;
            ny2getv(l);
          end;
        end;
      end;
    end;

    procedure my2cCheckDiff12;
    var
      l, i: integer;
    begin
      iv := 0; //1 video
      if iv > High(v) then Exit;
      for i := 0 to High(jo.m) do
      begin
        c := myGetCurrCont(jo, jo.m[i]);
        if c.getval(sMyChecked) <> '1' then Continue; //only checked
        t := c.getval('codec_type');
        if t = 'video' then
        begin
          mySplitMap(jo.m[i], l);
          ny2getv(l);
        end;
      end;
    end;

    procedure my3cMaxWH; //4 6 7 10 11 count max width height, sorted
    var
      l, i, w, h: integer;
    begin
      for l := 0 to High(jo.f) do
      begin
        iv := -1;
        for i := 0 to High(jo.m) do
        begin
          if Pos(IntToStr(l) + ':', jo.m[i]) <> 1 then Continue; //streams of current file
          c := myGetCurrCont(jo, jo.m[i]);
          if c.getval(sMyChecked) <> '1' then Continue; //only checked
          t := c.getval('codec_type');
          if t = 'video' then
          begin
            inc(iv);      //array index
            inc(v[iv].d); //count video 2
            myGetWH(c, w, h, Pos('-noautorotate', jo.f[l].getval(cmbAddOptsI.Name)) = 0);
            if v[iv].w < w then v[iv].w := w;
            if v[iv].h < h then v[iv].h := h;
          end;
        end;
      end;
    end;

    procedure my3oGetBG; //7 8 9
    var
      i, k, l: integer;
      rd, r1: real;
    begin
      //calc max duration
      r1 := 0;
      rd := 0;
      for l := 0 to High(jo.f) do
      for k := 0 to High(jo.f[l].s) do
      begin
        c := jo.f[l].s[k];
        if c.getval(sMyChecked) <> '1' then Continue; //only checked
        t := c.getval('codec_type');
        if t = 'video' then
        begin
          rd := myDur1(l);
        end;
        if r1 < rd then r1 := rd;
      end;

      //init streams
      for i := 0 to High(v) do
      begin
        v[i].p0 := '[bg' + IntToStr(i) + ']';
        v[i].f0 := Format('color=s=%dx%d:d=%n:r=%s%s', [v[i].w, v[i].h, r1, v[i].fps, v[i].p0], fsp);
        v[i].p1 := v[i].p0;
        //v[i].c := 1; //count video
        inc(v[i].c);
      end;
    end;

    procedure my3oGetAE; //scenario 7
    var
      i, k, l: integer;
      rd, r1: real;
    begin
      //calc max duration
      r1 := 0;
      rd := 0;
      for l := 0 to High(jo.f) do
      for k := 0 to High(jo.f[l].s) do
      begin
        c := jo.f[l].s[k];
        if c.getval(sMyChecked) <> '1' then Continue; //only checked
        t := c.getval('codec_type');
        if t = 'audio' then
        begin
          rd := myDur1(l);
        end;
        if r1 < rd then r1 := rd;
      end;

      //init streams
      for i := 0 to High(a) do
      begin
        a[i].p0 := '[ae' + IntToStr(i) + ']';
        a[i].f0 += 'aevalsrc=0';
        for k := 2 to a[i].ac do
          a[i].f0 += '|0';
        a[i].f0 += ':d=' + FloatToStr(r1, fsp) + ':s=' + a[i].sr + a[i].p0;
        a[i].p1 := a[i].p0;
        a[i].f1 := a[i].p0; //amix
        a[i].c := 1;
      end;
    end;

    function my4get(jomi: string; cur: boolean): boolean;
    begin
      Result := True;
      if cur and (Pos(fl + ':', jomi) <> 1) then Exit; //streams of current file
      c := myGetCurrCont(jo, jomi);
      if c.getval(sMyChecked) <> '1' then Exit; //only checked
      sk := c.getval('index');
      t := c.getval('codec_type');
      Result := False;
    end;

    function my4incv: boolean;
    begin
      inc(iv);
      if iv > High(v) then begin Result := False; Exit; end else Result := True;
      inc(v[iv].c);
      s := myGetFilter(jo, c, mode);
    end;

    function my4inca: boolean;
    begin
      inc(ia);
      if ia > High(a) then begin Result := False; Exit; end else Result := True;
      inc(a[ia].c);
      s := myGetFilter(jo, c, mode);
    end;

    procedure my4cvf0(var v: TmyChainV; t: string = '');
    begin
      if (s = '') then
      begin
        if v.bwh then
        begin
          s := Format('scale=%d:%d:force_original_aspect_ratio=decrease'
                     + ',pad=%d:%d:(ow-iw)/2:(oh-ih)/2,setsar=%s', [v.w, v.h, v.w, v.h, v.ar]);
        end
        else
          if v.bsar then s := 'setsar=' + v.ar;
        if v.bfps then s += IfThen(s <> '', ',') + 'fps=' + v.fps;
      end;
      if (s <> '') and (t <> '') then s += ',';
      s += t;
      v.p0 := '[' + fl + ':' + sk + ']';
      if s <> '' then
      begin
        v.f0 += IfThen(v.f0 <> '', ';'+ cr);
        v.f0 += v.p0 + s;
        v.p0 := '[' + fl + 's' + sk + ']';
        v.f0 += v.p0;                       //[0:0]filters[0s0]
      end;
      c1 += v.p0;                           //[0s0][1s0]concat
    end;

    procedure my4ovf0(var v: TmyChainV; t: string = '');
    begin
      if (s <> '') and (t <> '') then s += ',';
      s += t;
      v.p0 := '[' + fl + ':' + sk + ']';
      if s <> '' then
      begin
        v.f0 += IfThen(v.f0 <> '', ';'+ cr);
        v.f0 += v.p0 + s;
        v.p0 := '[' + fl + 'v' + sk + ']';
        v.f0 += v.p0;                       //[0:0]filters[0v0]
      end;
    end;

    procedure my4ovf1(var v: TmyChainV);
    begin
      v.f1 += IfThen(v.f1 <> '', ';'+ cr);
      v.f1 += v.p1 + v.p0 + s;
      v.p1 := '[' + fl + 'u' + sk + ']';
      v.f1 += v.p1;                         //[bg][0v0]overlay[0u0];[0u0][1v0]overlay[1u0]
    end;

    procedure my4caf0(var a: TmyChainA);
    begin
      a.p0 := '[' + fl + ':' + sk + ']';
      if s <> '' then
      begin
        a.f0 += IfThen(a.f0 <> '', ';'+ cr);
        a.f0 += a.p0 + s;
        a.p0 := '[' + fl + 'a' + sk + ']';
        a.f0 += a.p0;                       //[0:1]filters[0a1]
      end;
      c1 += a.p0;                           //[0a1][1a1][2a1]concat
    end;

    procedure my4oaf1(var a: TmyChainA);
    begin
      a.f1 += IfThen(a.f1 <> '', ';' + cr);
      a.f1 += a.p1 + a.p0 + s;
      a.p1 := '[' + fl + 'b' + sk + ']';
      a.f1 += a.p1;                         //[0a1][1a1]acrossfade[1b1];[1b1][2a1]acrossfade[2b1]
    end;

    procedure my5amix; //6 7 10 11
    var
      i: integer;
    begin
      for i := 0 to High(a) do
      begin
        if o2 <> '' then
          s := ',' + o2
        else //compensate for a decrease in volume
          s := ',volume=' + FloatToStr(Round(-15 * math.Log2(2/Power(a[i].c, 2)))/10, fsp) + 'dB';
          //s := ',loudnorm=I=-5';
        if a[i].f1 <> '' then
        begin
          a[i].p1 := '[a' + IntToStr(i) + ']';
          a[i].f1 += 'amix=inputs=' + IntToStr(a[i].c) + s + a[i].p1;
        end;
      end;
    end;

    procedure my5end1;
    var
      i: integer;
    begin
      s := '';
      for i := 0 to High(v) do s += IfThen((s <> '') and (v[i].f0 <> ''), ';' + cr + v[i].f0, v[i].f0);
      for i := 0 to High(v) do s += IfThen((s <> '') and (v[i].f1 <> ''), ';' + cr + v[i].f1, v[i].f1);
      for i := 0 to High(a) do s += IfThen((s <> '') and (a[i].f0 <> ''), ';' + cr + a[i].f0, a[i].f0);
      for i := 0 to High(a) do s += IfThen((s <> '') and (a[i].f1 <> ''), ';' + cr + a[i].f1, a[i].f1);
    end;

    procedure my5cvo1;
    var
      i: integer;
    begin
      if (o1 <> '') then
      for i := 0 to High(v) do
      begin
        s += ';' + cr;
        s += v[i].p1 + o1;
        v[i].p1 := '[cv' + IntToStr(i) + ']';
        s += v[i].p1;                       //concat[v0][a0];[v0]scale[cv0]
      end;
    end;

    procedure my5cao2;
    var
      i: integer;
    begin
      if (o2 <> '') then
      for i := 0 to High(a) do
      begin
        s += ';' + cr;
        s += a[i].p1 + o2;
        a[i].p1 := '[ca' + IntToStr(i) + ']';
        s += a[i].p1;                       //concat[v0][a0];[a0]volume[ca0]
      end;
    end;

    procedure my5end2;
    var
      i: integer;
    begin
      m(si, '-filter_complex', s);
      for i := 0 to High(v) do m(ma, '-map', v[i].p1);
      for i := 0 to High(a) do m(ma, '-map', a[i].p1);
    end;

    procedure myTrk1c; //concat, only checked video audio, order=file+remapped
    var
      l, i: integer;
    begin
      my1cFirstFile; //first file, get encoders, count streams
      my2cCheckDiff; //check difference with next files

      //cycle, get chain
      for l := 0 to High(jo.f) do
      begin
        iv := -1;
        ia := -1;
        fl := IntToStr(l);
        for i := 0 to High(jo.m) do
        begin
          if my4get(jo.m[i], True) then Continue;
          if (t = 'video') and my4incv then
          begin
            my4cvf0(v[iv]);
          end
          else
          if (t = 'audio') and my4inca then
          begin
            my4caf0(a[ia]);
          end;
        end;
      end;

      my5end1;
      l := 0;
      for i := 0 to High(v) do if v[i].c > 0 then l := v[i].c;
      for i := 0 to High(a) do if a[i].c > 0 then l := a[i].c;
      if l > 1 then
      begin
        s += IfThen(s <> '', ';' + cr);
        s += c1 + Format('concat=n=%d:v=%d:a=%d', [l, cv + 1, ca + 1]) + c2;
        my5cvo1;
        my5cao2;
        my5end2;
      end;
    end;

    procedure myTrk2c; //concat all video audio, not sorted
    var
      l, k: integer;
    begin
      my1nFirstFile; //first file, get encoders, get sar width height, set output pads
      my2nCheckDiff; //check difference with next files

      //cycle files
      for l := 0 to High(jo.f) do
      begin
        iv := -1;
        ia := -1;
        fl := IntToStr(l);
        for k := 0 to High(jo.f[l].s) do
        begin
          c := jo.f[l].s[k];
          sk := IntToStr(k);
          t := c.getval('codec_type');
          if (t = 'video') and my4incv then
          begin
            my4cvf0(v[iv]);
          end
          else
          if (t = 'audio') and my4inca then
          begin
            my4caf0(a[ia]);
          end;
        end;
      end;

      my5end1;
      l := High(jo.f) + 1;
      if l > 1 then
      begin
        s += IfThen(s <> '', ';' + cr);
        s += c1 + Format('concat=n=%d:v=%d:a=%d', [l, cv + 1, ca + 1]) + c2;
        my5cvo1;
        my5cao2;
        my5end2;
      end;
    end;

    procedure myTrk3x; //xfade + acrossfade, order=file+remapped checked
    var
      i, l: integer;
      rd, r3, r4: real;
    begin
      if o3 <> '' then o3 += ':';
      r4 := StrToFloatDef(o4, 1, fsp);       //xfade duration
      if (o4 = '') or (r4 = 0) then
      begin
        r4 := 1; //default 1 sec
        o4 := '1';
      end;

      my1cFirstFile; //get some data from first file
      my2cCheckDiff; //check difference with next files

      //first file, start chains
      iv := -1;
      ia := -1;
      r3 := 0;  //offset count
      rd := myDur1(0);
      fl := '0';
      for i := 0 to High(jo.m) do
      begin
        if my4get(jo.m[i], True) then Continue;
        if (t = 'video') and my4incv then
        begin
          my4cvf0(v[iv]);
          v[iv].p1 := v[iv].p0;
        end
        else
        if (t = 'audio') and my4inca then
        begin
          if s = '' then
            s := 'aresample=async=1,apad,atrim=0:' + FloatToStr(rd, fsp);
          my4caf0(a[ia]);
          a[ia].p1 := a[ia].p0;
        end;
      end;
      r3 := rd - r4;

      //next files, xfade + acrossfade
      for l := 1 to High(jo.f) do
      begin
        iv := -1;
        ia := -1;
        fl := IntToStr(l);
        rd := myDur1(l);
        for i := 0 to High(jo.m) do
        begin
          if my4get(jo.m[i], True) then Continue;
          if (t = 'video') and my4incv then
          begin
            my4cvf0(v[iv]);
            s := 'xfade=' + o3 + 'duration=' + o4 + ':offset=' + FloatToStr(r3, fsp);
            my4ovf1(v[iv]);
          end
          else
          if (t = 'audio') and my4inca then
          begin
            if s = '' then
              s := 'aresample=async=1,apad,atrim=0:' + FloatToStr(rd, fsp);
            my4caf0(a[ia]);
            s := 'acrossfade=d=' + o4;
            my4oaf1(a[ia]);
          end;
        end;
        r3 := r3 + rd - r4;
      end;

      my5end1;
      my5cvo1;
      my5cao2;
      my5end2;
    end;

    procedure myTrk4x; //pics slideshow xfade, order=file
    var
      i, l: integer;
      rd, r3, r4: real;
    begin
      if o3 <> '' then o3 += ':';
      r4 := StrToFloatDef(o4, 1, fsp);       //xfade duration
      if (o4 = '') or (r4 = 0) then
      begin
        r4 := 1; //default 1 sec
        o4 := '1';
      end;

      my1cFirstFile; //first file
      my3cMaxWH;     //calculate max width height

      //first picture
      iv := -1;
      rd := myDur1(0);
      fl := '0';
      for i := 0 to High(jo.m) do
      begin
        if my4get(jo.m[i], True) then Continue;
        if (t = 'video') and my4incv then
        begin
          my4cvf0(v[iv]);
          v[iv].p1 := v[iv].p0;
        end;
      end;

      //next pictures, gen complex
      r3 := rd - r4;
      for l := 1 to High(jo.f) do
      begin
        iv := -1;
        fl := IntToStr(l);
        rd := myDur1(l);
        for i := 0 to High(jo.m) do
        begin
          if my4get(jo.m[i], True) then Continue;
          if (t = 'video') and my4incv then
          begin
            my4cvf0(v[iv]);
            s := 'xfade=' + o3 + 'duration=' + o4 + ':offset=' + FloatToStr(r4, fsp);
            my4ovf1(v[iv]);
          end;
        end;
        r3 := r3 + rd - r4;
      end;

      my5end1;
      my5cvo1;
      my5end2;
    end;

    procedure myTrk5f; //fade + overlay + tblend + acrossfade, order=file+remapped checked
    var
      i, l: integer;
      rd, r3, r4: real;
    begin
      r4 := StrToFloatDef(o4, 1, fsp);       //fade duration
      if (o4 = '') or (r4 = 0) then
      begin
        r4 := 1; //default 1 sec
        o4 := '1';
      end;

      my1cFirstFile; //first video audio, get encoders
      my2cCheckDiff;

      //first file, start chains
      iv := -1;
      ia := -1;
      r3 := 0;  //offset count
      rd := myDur1(0);
      fl := '0';
      for i := 0 to High(jo.m) do
      begin
        if my4get(jo.m[i], True) then Continue;
        if (t = 'video') and my4incv then
        begin
          my4cvf0(v[iv], 'fade=d=' + o4 + ':alpha=1,fade=t=out:st=' + FloatToStr(rd - r4, fsp) + ':d=' + o4 + ':alpha=1');
          v[iv].p1 := v[iv].p0;
        end
        else
        if (t = 'audio') and my4inca then
        begin
          if s = '' then
            s := 'aresample=async=1,apad,atrim=0:' + FloatToStr(rd, fsp);
          my4caf0(a[ia]);
          a[ia].p1 := a[ia].p0;
        end;
      end;
      r3 := rd - r4;

      //next files, blend + afade
      for l := 1 to High(jo.f) do
      begin
        iv := -1;
        ia := -1;
        fl := IntToStr(l);
        rd := myDur1(l);
        for i := 0 to High(jo.m) do
        begin
          if my4get(jo.m[i], True) then Continue;
          if (t = 'video') and my4incv then
          begin
            my4cvf0(v[iv], 'fade=d=' + o4 + ':alpha=1,fade=t=out:st=' + FloatToStr(rd - r4, fsp) + ':d=' + o4 + ':alpha=1,setpts=PTS+' + FloatToStr(r3, fsp) + '/TB');
            s := 'overlay,tblend=' + IfThen(o3 <> '', o3 + ':') + 'enable=''between(t,' + FloatToStr(r3, fsp) + ',' + FloatToStr(r3 + r4, fsp) + ')''';
            my4ovf1(v[iv]);
          end
          else
          if (t = 'audio') and my4inca then
          begin
            if s = '' then
              s := 'aresample=async=1,apad,atrim=0:' + FloatToStr(rd, fsp);
            my4caf0(a[ia]);
            s := 'acrossfade=d=' + o4;
            my4oaf1(a[ia]);
          end;
        end;
        r3 := r3 + rd - r4;
      end;

      my5end1;
      my5cvo1;
      my5cao2;
      my5end2;
    end;

    procedure myTrk6o; //merge side by side, overlay + amix, order=file+remapped checked
    var
      i, l, w, h: integer;
    begin
      my1cFirstFile; //first video audio, get encoders
      my3cMaxWH;     //calculate max width height, count streams

      //init
      for i := 0 to High(v) do
      begin
        v[i].bw := 1; //width of box
        v[i].bh := 1; //height of box
        while (v[i].bw * v[i].bh) < v[i].c do
        begin
          //calc box size
          if ((v[i].bw * v[i].w) / (v[i].bh * v[i].h)) < (16 / 9) then Inc(v[i].bw) else Inc(v[i].bh);
        end;
        v[i].p0 := '[bg' + IntToStr(i) + ']';
        v[i].f0 := Format('color=size=%dx%d:d=0.04%s', [v[i].bw * v[i].w, v[i].bh * v[i].h, v[i].p0], fsp);
        v[i].p1 := v[i].p0;
        v[i].pw := 0; //position of video, column
        v[i].ph := 0; //position of video, row
      end;

      //cycle streams
      for l := 0 to High(jo.f) do
      begin
        iv := -1;
        ia := -1;
        fl := IntToStr(l);
        for i := 0 to High(jo.m) do
        begin
          if my4get(jo.m[i], True) then Continue; //
          if (t = 'video') and my4incv then
          begin
            myGetWH(c, w, h, Pos('-noautorotate', jo.f[l].getval(cmbAddOptsI.Name)) = 0);
            if v[iv].pw >= v[iv].bw then
            begin
              v[iv].pw := 0;
              inc(v[iv].ph);
            end;
            w := v[iv].pw * v[iv].w + ((v[iv].w - w) div 2);
            h := v[iv].ph * v[iv].h + ((v[iv].h - h) div 2);
            inc(v[iv].pw);

            my4ovf0(v[iv]);
            //s := 'overlay=x=' + IntToStr(w) + ':y=' + IntToStr(h);
            s := Format('overlay=%d:%d', [w, h]);
            my4ovf1(v[iv]);
          end
          else
          if (t = 'audio') and my4inca then
          begin
            if s = '' then
              s := 'aresample=async=1:first_pts=0';
            my4caf0(a[ia]);
            a[ia].f1 += a[ia].p0; //amix
          end;
        end;
      end;

      my5amix;
      my5end1;
      my5cvo1;
      my5end2;
    end;

    procedure myTrk7o; //overlay + amix, order=file+remapped checked, use -itsoffset
    var
      i, l: integer;
    begin
      my1cFirstFile; //first video audio, get encoders
      my3cMaxWH;     //calculate max width height
      my3oGetBG;     //get background
      my3oGetAE;     //get silent audio

      //cycle streams
      for l := 0 to High(jo.f) do
      begin
        iv := -1;
        ia := -1;
        fl := IntToStr(l);
        for i := 0 to High(jo.m) do
        begin
          if my4get(jo.m[i], True) then Continue;
          if (t = 'video') and my4incv then
          begin
            my4ovf0(v[iv]);
            s := 'overlay=(W-w)/2:(H-h)/2';
            my4ovf1(v[iv]);
          end
          else
          if (t = 'audio') and my4inca then
          begin
            if s = '' then
              s := 'aresample=async=1:first_pts=0';
            my4caf0(a[ia]);
            a[ia].f1 += a[ia].p0; //amix
          end;
        end;
      end;

      my5amix;
      my5end1;
      my5cvo1;
      my5end2;
    end;

    procedure myTrk8o; //overlay slide left + acrossfade, order=file+remapped checked
    var
      i, l: integer;
      rd, r3, r4: real;
    begin
      r4 := StrToFloatDef(o4, 1, fsp);       //fade duration
      if (o4 = '') or (r4 = 0) then
      begin
        r4 := 3; //default 1 sec
        o4 := '3';
      end;

      my1cFirstFile;
      my2cCheckDiff;
      my3oGetBG;

      //first file, start chains
      iv := -1;
      ia := -1;
      r3 := 0;  //offset count
      rd := myDur1(0);
      fl := '0';
      for i := 0 to High(jo.m) do
      begin
        if my4get(jo.m[i], True) then Continue;
        if (t = 'video') and my4incv then
        begin
          //v[iv].d := 0; //count video
          my4ovf0(v[iv]);
          s := 'overlay=x=''if(between(t,' + FloatToStr(rd - r4, fsp) + ',' + FloatToStr(rd, fsp) + '), -(t-' + FloatToStr(rd - r4, fsp) + ')*(W/' + FloatToStr(r4, fsp) + '), 0)'':y=0';
          my4ovf1(v[iv]);
        end
        else
        if (t = 'audio') and my4inca then
        begin
          if s = '' then
            s := 'aresample=async=1,apad,atrim=0:' + FloatToStr(rd, fsp);
          my4caf0(a[ia]);
          a[ia].p1 := a[ia].p0;
        end;
      end;
      r3 := rd - r4;

      //next files
      for l := 1 to High(jo.f) do
      begin
        iv := -1;
        ia := -1;
        fl := IntToStr(l);
        rd := myDur1(l);
        for i := 0 to High(jo.m) do
        begin
          if my4get(jo.m[i], True) then Continue;
          if (t = 'video') and my4incv then
          begin
            my4ovf0(v[iv], 'setpts=PTS+' + FloatToStr(r3, fsp) + '/TB');
            inc(v[iv].d);
            s := Format('overlay=enable=''between(t,%n,%n)'':x=''if(between(t,%n,%n),W-(t-%n)*(W/%n),', [r3, r3 + rd, r3, r3 + r4, r3, r4], fsp);
            if v[iv].c <> v[iv].d then
              s += Format('if(between(t,%n,%n),-(t-%n)*(W/%n),0)', [r3 + rd - r4, r3 + rd, r3 + rd - r4, r4], fsp)
            else
              s += '0';
            s += ')'':y=0';
            my4ovf1(v[iv]);
          end
          else
          if (t = 'audio') and my4inca then
          begin
            if s = '' then
              s := 'aresample=async=1,apad,atrim=0:' + FloatToStr(rd, fsp);
            my4caf0(a[ia]);
            s := 'acrossfade=d=' + o4;
            my4oaf1(a[ia]);
          end;
        end;
        r3 := r3 + rd - r4;
      end;

      my5end1;
      my5cvo1;
      my5cao2;
      my5end2;
    end;

    procedure myTrk9o; //overlay slide up + acrossfade, order=file+remapped checked
    var
      i, l: integer;
      rd, r3, r4: real;
    begin
      r4 := StrToFloatDef(o4, 3, fsp);       //fade duration
      if (o4 = '') or (r4 = 0) then
      begin
        r4 := 3; //default 1 sec
        o4 := '3';
      end;

      my1cFirstFile;
      my2cCheckDiff;
      my3oGetBG;

      //first file, start chains
      iv := -1;
      ia := -1;
      r3 := 0;  //offset count
      rd := myDur1(0);
      fl := '0';
      for i := 0 to High(jo.m) do
      begin
        if my4get(jo.m[i], True) then Continue;
        if (t = 'video') and my4incv then
        begin
          //v[iv].d := 0; //count video
          my4cvf0(v[iv]);
          s := 'overlay=x=0:y=''if(between(t,' + FloatToStr(rd - r4, fsp) + ',' + FloatToStr(rd, fsp) + '), -(t-' + FloatToStr(rd - r4, fsp) + ')*(H/' + FloatToStr(r4, fsp) + '), 0)''';
          my4ovf1(v[iv]);
        end
        else
        if (t = 'audio') and my4inca then
        begin
          if s = '' then
            s := 'aresample=async=1,apad,atrim=0:' + FloatToStr(rd, fsp);
          my4caf0(a[ia]);
          a[ia].p1 := a[ia].p0;
        end;
      end;
      r3 := rd - r4;

      //next files
      for l := 1 to High(jo.f) do
      begin
        iv := -1;
        ia := -1;
        fl := IntToStr(l);
        rd := myDur1(l);
        for i := 0 to High(jo.m) do
        begin
          if my4get(jo.m[i], True) then Continue;
          if (t = 'video') and my4incv then
          begin
            my4cvf0(v[iv], 'setpts=PTS+' + FloatToStr(r3, fsp) + '/TB');
            inc(v[iv].d);
            s := Format('overlay=enable=''between(t,%n,%n)'':x=0:y=''if(between(t,%n,%n),H-(t-%n)*(H/%n),', [r3, r3 + rd, r3, r3 + r4, r3, r4], fsp);
            if v[iv].c <> v[iv].d then
              s += Format('if(between(t,%n,%n),-(t-%n)*(H/%n),0)', [r3 + rd - r4, r3 + rd, r3 + rd - r4, r4], fsp)
            else
              s += '0';
            s += ')''';
            my4ovf1(v[iv]);
          end
          else
          if (t = 'audio') and my4inca then
          begin
            if s = '' then
              s := 'aresample=async=1,apad,atrim=0:' + FloatToStr(rd, fsp);
            my4caf0(a[ia]);
            s := 'acrossfade=d=' + o4;
            my4oaf1(a[ia]);
          end;
        end;
        r3 := r3 + rd - r4;
      end;

      my5end1;
      my5cvo1;
      my5cao2;
      my5end2;
    end;

    procedure myTrk10s; //hstack + vstack + amix, order=file+remapped checked
    var
      i, l: integer;
    begin
      my1cFirstFile; //first video audio, get encoders
      my2cCheckDiff; //diff with next videos
      my3cMaxWH;     //max video size

      //calc box size
      for i := 0 to High(v) do
      begin
        v[i].bw := 1; //width of box
        v[i].bh := 1; //height of box
        while (v[i].bw * v[i].bh) < v[i].c do
        begin
          if ((v[i].bw * v[i].w) / (v[i].bh * v[i].h)) < (16 / 9) then Inc(v[i].bw) else Inc(v[i].bh);
        end;
        v[i].pw := 0; //position of video, column
        v[i].ph := 0; //position of video, row
      end;

      //cycle files
      for l := 0 to High(jo.f) do
      begin
        iv := -1;
        ia := -1;
        fl := IntToStr(l);
        for i := 0 to High(jo.m) do
        begin
          if my4get(jo.m[i], True) then Continue;
          if (t = 'video') and my4incv then
          begin
            if v[iv].pw >= v[iv].bw then   //if box width reached, begin next row
            begin
              v[iv].pw := 0;
              inc(v[iv].ph);
              v[iv].p0 := '[' + fl + 't' + sk + ']';
              v[iv].f1 += 'hstack=inputs=' + IntToStr(v[iv].bw) + v[iv].p0 + ';' + cr;
              v[iv].f2 += v[iv].p0;
            end;
            inc(v[iv].pw);

            my4cvf0(v[iv]);
            v[iv].f1 += v[iv].p0;
          end
          else
          if (t = 'audio') and my4inca then
          begin
            if s = '' then
              s := 'aresample=async=1:first_pts=0';
            my4caf0(a[ia]);
            a[ia].f1 += a[ia].p0;
          end;
        end;
      end;

      //finish stack
      for i := 0 to High(v) do
      if (v[i].w > 0) and (v[i].h > 0) then
      begin
        while v[i].pw < v[i].bw do
        begin
          v[i].f0 += IfThen(v[i].f0 <> '', ';' + cr);
          v[i].p0 := '[bl' + IntToStr(i) + IntToStr(v[i].pw) + ']';
          v[i].f0 += Format('color=s=%dx%d:d=1%s', [v[i].w, v[i].h, v[i].p0]);
          v[i].f1 += v[i].p0;
          inc(v[i].pw);
        end;
        v[i].p0 := '[last' + IntToStr(i) + ']';
        v[i].f1 += 'hstack=inputs=' + IntToStr(v[i].bw) + v[i].p0;

        inc(v[i].ph);
        if v[i].ph > 1 then
        begin
          v[i].f2 += v[i].p0;
          v[i].p0 := '[vstk' + IntToStr(i) + ']';
          v[i].f2 += 'vstack=inputs=' + IntToStr(v[i].ph) + v[i].p0;
        end;
        v[i].p1 := v[i].p0;

        if o1 <> '' then
        begin
          v[i].f2 += ';' + cr + v[i].p0 + o1;
          v[i].p0 := '[o1' + IntToStr(i) + ']';
          v[i].f2 += v[i].p0;
          v[i].p1 := v[i].p0;
        end;
      end;

      my5amix;
      my5end1;
      for i := 0 to High(v) do s += IfThen((s <> '') and (v[i].f2 <> ''), ';' + cr) + v[i].f2;
      my5cvo1;
      my5end2;
    end;

    procedure myTrk11s; //xstack + amix, order=file+remapped checked
    var
      i, l: integer;
    begin
      my1cFirstFile;
      my2cCheckDiff;
      my3cMaxWH;     //max video size

      //calc box size
      for i := 0 to High(v) do
      begin
        v[i].bw := 1; //width of box
        v[i].bh := 1; //height of box
        while (v[i].bw * v[i].bh) < v[i].d do
        begin
          if ((v[i].bw * v[i].w) / (v[i].bh * v[i].h)) < (16 / 9) then Inc(v[i].bw) else Inc(v[i].bh);
        end;
        v[i].pw := 0; //position of video, column
        v[i].ph := 0; //position of video, row
      end;

      //cycle files
      for l := 0 to High(jo.f) do
      begin
        iv := -1;
        ia := -1;
        fl := IntToStr(l);
        for i := 0 to High(jo.m) do
        begin
          if my4get(jo.m[i], True) then Continue;
          if (t = 'video') and my4incv then
          begin
            if v[iv].ph >= v[iv].bh then   //if box heigth reached, begin next column
            begin
              v[iv].ph := 0;
              inc(v[iv].pw);
            end;

            my4cvf0(v[iv]);
            v[iv].f2 += v[iv].p0;
            v[iv].f3 += IfThen(v[iv].f3 <> '', '|') + IntToStr(v[iv].pw * v[iv].w) + '_' + IntToStr(v[iv].ph * v[iv].h);
            inc(v[iv].ph);
          end
          else
          if (t = 'audio') and my4inca then
          begin
            if s = '' then
              s := 'aresample=async=1:first_pts=0';
            my4caf0(a[ia]);
            a[ia].f1 += a[ia].p0;
          end;
        end;
      end;

      my5amix;
      my5end1;
      for i := 0 to High(v) do
        s += IfThen(s <> '', ';' + cr) + v[i].f2 + 'xstack=inputs=' + IntToStr(v[i].c)
           + IfThen(o3 <> '', ':fill=' + o3) + ':layout=' + v[i].f3 + v[i].p1;
      my5cvo1;
      my5end2;
    end;

    procedure myTrk12c; //concat 1 video + 1 audio, order=remapped checked
    var
      i, j: integer;
    begin
      my1cFirstFile12;
      my2cCheckDiff12;

      for i := 0 to High(jo.m) do
      begin
        if my4get(jo.m[i], False) then Continue;
        iv := -1;
        ia := -1;
        mySplitMap(jo.m[i]);
        if (t = 'video') and my4incv then
        begin
          my4cvf0(v[iv]);
        end
        else
        if (t = 'audio') and my4inca then
        begin
          my4caf0(a[ia]);
        end;
      end;

      my5end1;
      if High(v) >= 0 then i := v[0].c else i := 0;
      if High(a) >= 0 then j := a[0].c else j := 0;
      j := IfThen(i > 0, i, j);
      if j > 1 then
      begin
        s += IfThen(s <> '', ';' + cr);
        s += c1 + Format('concat=n=%d:v=1:a=1', [j]) + c2;
        my5cvo1;
        my5cao2;
        my5end2;
      end;
    end;

  begin
    scenario := jo.getval(cmbScenario.Name);
    c1 := '';
    c2 := '';
    o1 := jo.getval(cmbScenarioOpt1.Name); //common video filter
    o2 := jo.getval(cmbScenarioOpt2.Name); //common audio filter
    o3 := jo.getval(cmbScenarioOpt3.Name);
    o4 := jo.getval(cmbScenarioOpt4.Name);
    case StrToIntDef(scenario, 0) of
      1: myTrk1c; //concat, files, remapped streams
      2: myTrk2c; //concat, files, not remapped streams
      3: myTrk3x; //xfade + acrossfade
      4: myTrk4x; //xfade, pics slideshow
      5: myTrk5f; //fade + overlay + tblend + acrossfade
      6: myTrk6o; //overlay + amix, merge side by side
      7: myTrk7o; //overlay + amix, concat video using -itsoffset
      8: myTrk8o; //overlay + acrossfade, slide left
      9: myTrk9o; //overlay + acrossfade, slide up
      10: myTrk10s; //hstack + vstack + amix
      11: myTrk11s; //xstacks + amix
      12: myTrk12c; //concat 1 video + 1 audio, remapped streams
    else
      myTrk0;
    end;
  end;

  procedure myOut;
  begin
    my2m;
    m(ou, '-ss', jo.getval(cmbDurationss2.Name));
    m(ou, '-t', jo.getval(cmbDurationt2.Name));
    m(ou, '', jo.getval(cmbAddOptsO.Name));
    m(ou, '-f', jo.getval(cmbFormat.Name));
    ou.Add('-y');
    if (si.IndexOf('-map') >= 0) or (ec.IndexOf('-map') >= 0) or (ou.IndexOf('-map') >= 0) then ma.Clear;
  end;

  procedure myOutT; //test
  var
    rt: double;
  begin
    my2m;
    rt := myTimeStrToReal(Trim(cmbTestDurationt.Text));
    if rt > 0 then s := myRealToTimeStr(rt) else s := '';
    m(ou, '-t', s);
    m(ou, '', jo.getval(cmbAddOptsO.Name));
    m(ou, '-f', jo.getval(cmbFormat.Name));
    ou.Add('-y');
    if (si.IndexOf('-map') >= 0) or (ec.IndexOf('-map') >= 0) or (ou.IndexOf('-map') >= 0) then ma.Clear;
  end;

  procedure myOutP; //play
  begin
    //my2m;
    m(ou, '-ss', jo.getval(cmbDurationss2.Name));
    m(ou, '-t', jo.getval(cmbDurationt2.Name));
    m(ou, '', jo.getval(cmbAddOptsO.Name));
    m(ou, '-f', 'matroska');
    ou.Add('-y');
    if (si.IndexOf('-map') >= 0) or (ec.IndexOf('-map') >= 0) or (ou.IndexOf('-map') >= 0) then ma.Clear;
  end;

  procedure myFin;
  var
    a: TStringList;
  begin
    a := TStringList.Create;
    if (p1.Count > 0) then
    begin
      a.Add(myExpandFN(edtffmpeg.Text));
      a.Add('-hide_banner');
      a.AddStrings(si);
      a.AddStrings(ma);
      a.AddStrings(fi);
      a.AddStrings(ec);
      a.AddStrings(p1);
      a.AddStrings(ou);
      a.Add(sDevNull);
      mylst2run(term, a, run);
      a.Clear;
    end;
    a.Add(myExpandFN(edtffmpeg.Text));
    a.Add('-hide_banner');
    a.AddStrings(si);
    a.AddStrings(ma);
    a.AddStrings(fi);
    a.AddStrings(ec);
    a.AddStrings(p2);
    a.AddStrings(ou);
    a.Add(fn);
    mylst2run(term, a, run);
    a.Free;
  end;

  procedure myFinP; //play
  var
    a: TStringList;
    s: string;
  begin
    a := TStringList.Create;
    a.Add(myExpandFN(edtffmpeg.Text));
    a.Add('-hide_banner');
    a.AddStrings(si);
    a.AddStrings(ma);
    a.AddStrings(fi);
    a.AddStrings(ec);
    a.AddStrings(ou);
    a.Add('-');
    a.Add('|');
    s := myExpandFN(edtffplay.Text);
    if FileExistsUTF8(s) then
    begin
      a.Add(s);
      a.Add('-hide_banner');
      if chkffplayfs.Checked then a.Add('-fs');
      if chkffplayexit.Checked then a.Add('-autoexit');
    end
    else
      a.Add(myExpandFN(cmbExtPlayer.Text));
    a.Add('-');
    mylst2run(True, a, run);
    a.Free;
  end;

begin
  //output filename
  fn := jo.getval(edtOfn.Name);
  if (mode in [0, 1]) and FileExistsUTF8(fn) then // new filename (n)
  begin
    fn := myGetOutputFN(jo);
    jo.setval(edtOfn.Name, fn);
  end;
  // init vars
  si := TStringList.Create;  //inputs
  ma := TStringList.Create;  //mapping
  fi := TStringList.Create;  //filters
  ec := TStringList.Create;  //encoders
  p1 := TStringList.Create;  //pass #1
  p2 := TStringList.Create;  //pass #2
  ou := TStringList.Create;  //output
  cc := -1;  //count all tracks
  cv := -1;  //count video tracks
  ca := -1;  //count audio tracks
  cs := -1;  //count subtitle tracks
  cd := -1;  //count data tracks
  mdw := (jo.getval(chkMetadataWork.Name) = '1');
  mdc := (jo.getval(chkMetadataClear.Name) = '1');
  //modes: 0 = convert, 1 = test, 4 = play, 5 = cmdline
  case mode of
    0, 5: begin //convert, cmdline
      if (jo.getval(chkUseEditedCmd.Name) = '1') then //use edited command lines
      begin
        with TStringList.Create do
        try
          Text := jo.getval(memCmdlines.Name);
          s := myGetTempFileName(myGetDirTmp(fn), 'ff', ext);
          try
            SaveToFile(s);
          except
            on E: Exception do myError(-1, 'myGetRunFromJo: ' + mes[56] + ' - ' + s + ' ' + E.Message); //cant save to file
          end;
        finally
          Free;
        end;
        {$IFDEF MSWINDOWS}
        run.add(s);
        {$ELSE}
        run.add('bash', [s]);
        {$ENDIF}
      end
      else
      begin
        myInp; //input files: -ss 10:00 -i INPUT0.avi -ss 10:00 -i INPUT1.wav
        myTrk;
        myOut; //output file: -t 30 -f matroska -y OUTPUT.mkv
        myFin; //create object TRun
      end;
    end;
    1: begin //test
      if (jo.getval(chkUseEditedCmd.Name) = '1') then //use edited command lines
      begin
        myError(-1, 'myGetRunFromJo: ' + mes[50]); //cannot test edited command lines
        //insert "-t 30" before output filename?
      end
      else
      begin
        myInpT; //test
        myTrk;
        myOutT; //test
        myFin;
      end;
    end;
    4: begin // play through pipe: sh -c "ffmpeg -i input -f matroska - | ffplay -"
      if (jo.getval(chkUseEditedCmd.Name) = '1') then //use edited command lines
      begin
        myError(-1, 'myGetRunFromJo: ' + mes[50]);
      end
      else
      begin
        myInp;
        myTrk;
        myOutP; //play
        myFinP; //play
      end;
    end;
  end;
  si.Free; ma.Free; fi.Free; ec.Free; p1.Free; p2.Free; ou.Free;
end;

procedure TfrmGUIta.myFindFiles(dir, exe: string; cmb: TComboBox; bSet2: boolean = True);
var
  SP, SL: TStringList;
  i: integer;
  s: string;
begin
  s := myExpandFN(exe);
  if FileExistsUTF8(s) and not DirectoryExistsUTF8(s) then
    myAdd2cmb(cmb, exe);
  SP := TStringList.Create;
  SL := TStringList.Create;
  s := GetEnvironmentVariableUTF8('PATH');
  myStr2List(s, PathSeparator, SL);
  for i := 0 to SL.Count - 1 do
  begin
    s := AppendPathDelim(SL[i]) + exe;
    if FileExistsUTF8(s) and not DirectoryExistsUTF8(s) then
      SP.Add(s);
  end;
  if SP.Count > 1 then
    for i := 0 to SP.Count - 1 do
      myAdd2cmb(cmb, SP[i]);
  SL.Clear;
  if myGetFileList(dir, exe, SL, True, True, False) then
    for i := 0 to SL.Count - 1 do
      myAdd2cmb(cmb, myUnExpandFN(SL[i]));
  if bSet2 and (cmb.Items.Count > 0) then
    cmb.ItemIndex := cmb.Items.Count - 1;
  SL.Free;
  SP.Free;
end;

procedure TfrmGUIta.myFindPlayers(bSet2: boolean);
var
  i, j: integer;
  s: string;
  SL: TStringList;
{$IFDEF MSWINDOWS}
  Reg, Re2: TRegistry;
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
      on E: Exception do myError(-1, 'myFindPlayers: ' + E.Message);
    end;
  finally
    Reg.Free;
    Re2.Free;
  end;
{$ELSE}
  a: array [0..1] of string = ('$HOME/.config/mimeapps.list', '/usr/share/applications/mimeapps.list');
  b: array [0..2] of string = ('$HOME/.local/share/applications/', '/usr/share/applications/', '/usr/local/share/applications/');
  Ini: TMemIniFile;
begin
  SL := TStringList.Create;
  try
    try
      for i := 0 to High(a) do
      if FileExistsUTF8(myExpandEnv(a[i])) then
      begin
        Ini := TMemIniFile.Create(myExpandEnv(a[i]));
        s := Ini.ReadString('Added Associations', 'video/mp4', '');
        if (s <> '') then myStr2List(s, ';', SL, False);
        //s := Ini.ReadString('Added Associations', 'video/x-matroska', '');
        //if (s <> '') then myStr2List(s, ';', SL, False);
        //s := Ini.ReadString('Added Associations', 'video/x-msvideo', '');
        //if (s <> '') then myStr2List(s, ';', SL, False);
        Ini.Free;
      end;
      Ini := TMemIniFile.Create('/usr/share/applications/mimeinfo.cache');
      s := Ini.ReadString('MIME Cache', 'video/mp4', '');
      if (s <> '') then myStr2List(s, ';', SL, False);
      //s := Ini.ReadString('MIME Cache', 'video/x-msvideo', '');
      //if (s <> '') then myStr2List(s, ';', SL, False);
      Ini.Free;
      //
      for i := 0 to High(b) do
      if DirectoryExistsUTF8(myExpandEnv(b[i])) then
      for j := 0 to SL.Count - 1 do
      begin
        Ini := TMemIniFile.Create(myExpandEnv(b[i]) + SL[j]);
        s := ' ' + Ini.ReadString('Desktop Entry', 'Exec', '') + ' ';
        s := myBetween(s, ' ', ' ');
        myAdd2cmb(cmbExtPlayer, s);
        Ini.Free;
      end;
    except
      on E: Exception do myError(-1, 'myFindPlayers: ' + E.Message);
    end;
  finally
    SL.Free;
  end;
{$ENDIF}
  if bSet2 and (cmbExtPlayer.Items.Count > 1) then
    cmbExtPlayer.ItemIndex := 1;
end;

procedure TfrmGUIta.myFindMediaInfo(bSet2: boolean);
var
  s: string;
  j: integer;
{$IFDEF MSWINDOWS}
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
        begin
          myAdd2cmb(edtMediaInfo, myUnExpandFN(s));
          s := ChangeFileExt(s, '.dll');
          if FileExistsUTF8(s) then
            myAdd2cmb(edtMediaInfoDll, myUnExpandFN(s));
        end;
      end;
      Reg.CloseKey;
    except
      on E: Exception do myError(-1, 'myFindMediaInfo: ' + E.Message);
    end;
    reg.Free;
  end;
  myFindFiles(sDirApp, 'MediaInfo.exe', edtMediaInfo, False);
  myFindFiles(sDirApp, 'MediaInfo.dll', edtMediaInfoDll, False);
  myFindFiles(myExpandEnv('%ProgramFiles%'), 'MediaInfo.dll', edtMediaInfoDll, False);
  myFindFiles(myExpandEnv('%ProgramFiles%'), 'MediaInfo64.dll', edtMediaInfoDll, False);
{$ELSE}
  i: integer;
  SL, SC: TStringList;
begin
  myFindFiles(sDirApp, 'mediainfo-gui', edtMediaInfo, False);
  myFindFiles(sDirApp, 'mediainfo', edtMediaInfo, False);
  myFindFiles(sDirApp, 'libmediainfo.so.0', edtMediaInfoDll, False);
  if FileExistsUTF8('/usr/lib/x86_64-linux-gnu/libmediainfo.so.0') then
    myAdd2cmb(edtMediaInfoDll, '/usr/lib/x86_64-linux-gnu/libmediainfo.so.0');
  SL := TStringList.Create;
  try
    try
      myGetFileList('/etc/ld.so.conf.d/', '*', SL, False, True, False); //FindAllFiles(SL, '/etc/ld.so.conf.d/', '*', False);
      for i := 0 to SL.Count -1 do
      begin
        s := SL[i];
        if FileExistsUTF8(s) then
        begin
          SC := TStringList.Create;
          SC.LoadFromFile(s);
          for j := 0 to SC.Count - 1 do
          begin
            s := SC[j] + '/libmediainfo.so.0';
            if (s[1] <> '#') and FileExistsUTF8(s) then
            begin
              myAdd2cmb(edtMediaInfoDll, 'libmediainfo.so.0');
              myAdd2cmb(edtMediaInfoDll, s);
            end;
          end;
          SC.Free;
        end;
      end;
    except
      on E: Exception do myError(-1, 'myFindMediaInfo: ' + E.Message);
    end;
  finally
    SL.Free;
  end;
{$ENDIF}
  if bSet2 then
  begin
    if (edtMediaInfo.Items.Count > 0) then edtMediaInfo.ItemIndex := 0;
    if (edtMediaInfoDll.Items.Count > 0) then edtMediaInfoDll.ItemIndex := 0;
  end;
end;

function TfrmGUIta.myGetMediaInfo(fn, par: string; sk: TMIStreamKind = Stream_Video;
  sn: integer = 0): string;
var
  h: cardinal;
  s: string;
begin
  Result := '';
  s := myExpandFN(edtMediaInfoDll.Text);
  if FileExistsUTF8(s) then
  begin
    if not MediaInfoDLL_Load(s) then
      myError(0, 'myGetMediaInfo: ' + mes[6] + ' ' + s) //Error
    else
    begin
      h := MediaInfo_New();
      try
        try
          //myError(0, 'myGetMediaInfo: ' + s + ' ' + fn + ' ' + par + ' ' + IntToStr(Integer(sk)) + ' ' + IntToStr(sn));
          myError(0, Format('myGetMediaInfo: %s %s %s %d %d', [s, fn, par, sk, sn]));
          myMI_Open(h, fn);
          Result := myMI_Get(h, sk, sn, par, Info_Text, Info_Name);
        except
          on E: Exception do myError(-1, 'myGetMediaInfo: ' + E.Message);
        end;
      finally
        MediaInfo_Close(h);
      end;
    end;
  end
  else
  if chkMediaInfoIsCli.Checked then
  begin
    if sk = Stream_Video then s := 'Video' else
    if sk = Stream_Audio then s := 'Audio' else
                              s := 'General';
    myGetRunOut(myExpandFN(edtMediaInfo.Text), ['--Inform=' + s + ';%' + par + '%', fn], Result);
    Result := Trim(Result); //trim #10
  end;
end;

function TfrmGUIta.myExpandFN(fn: string; dir: boolean = False): string;
var
  s: string;
  {$IFNDEF MSWINDOWS}
  sl, st: TStringList;
  i, j: integer;
  {$ENDIF}
begin
  Result := fn;
  if (fn = '') or FilenameIsAbsolute(fn) then Exit;
  {$IFDEF MSWINDOWS}
  if (Pos('%', fn) > 0) then
  {$ELSE}
  if (fn[1] = '~') then fn := StringReplace(fn, '~', '$HOME', []);
  if (Pos('$', fn) > 0) then
  {$ENDIF}
    fn := myExpandEnv(fn);
  if FilenameIsAbsolute(fn) then
    Result := fn
  else
  if (Pos('..', fn) = 1) then
  begin
    s := GetCurrentDir;
    SetCurrentDir(sDirApp);
    Result := ExpandFileNameUTF8(fn);
    SetCurrentDir(s);
  end
  else
  {$IFDEF MSWINDOWS}
  if LowerCase(ExtractFileExt(fn)) = '.dll' then
  begin
    Result := sDirApp + fn;
    if FileExistsUTF8(Result) then Exit;
    s := FindDefaultExecutablePath(ExtractFileName(fn), sDirApp);
    if s <> '' then
      Result := s;
  end
  else
  {$ELSE}
  if (ExtractFileExt(fn) = '.so') or (ExtractFileExt(fn) = '.0') then  //libmediainfo.so.0
  begin
    Result := sDirApp + fn;
    if FileExistsUTF8(Result) then Exit;
    Result := '/usr/lib/' + fn;
    if FileExistsUTF8(Result) then Exit;
    sl := TStringList.Create;
    st := TStringList.Create;
    myGetFileList('/etc/ld.so.conf.d/', '*', SL, False, True, False);
    for i := 0 to sl.Count -1 do
    begin
      s := sl[i];
      if FileExistsUTF8(s) then
      begin
        st.LoadFromFile(s);
        for j := 0 to st.Count - 1 do
        begin
          s := AppendPathDelim(st[j]) + fn;
          if (s[1] <> '#') and FileExistsUTF8(s) then
          begin
            Result := s;
            Break;
          end;
        end;
      end;
    end;
    st.Free;
    sl.Free;
  end
  else
  {$ENDIF}
  begin
    Result := sDirApp + fn;
    if (not dir and FileExistsUTF8(Result)) or (dir and DirectoryExistsUTF8(Result)) then Exit;
    s := FindDefaultExecutablePath(ExtractFileName(fn), sDirApp);
    if s <> '' then
      Result := s
    else
    begin
      s := sInidir + fn;
      if not dir and FileExistsUTF8(s) then
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
  k, l: integer;
  c: TCont;
  t, v, a: string;
  b, d: array of string;

  procedure q(o, n: string);
  begin
    SetLength(b, Length(b) + 1);
    SetLength(d, Length(d) + 1);
    b[High(b)] := o;
    d[High(d)] := n;
  end;

  procedure r(o, n: string);
  begin
    if n = '' then Exit;
    q('$' + o, n);
    q('${' + o + '}', n);
  end;

begin
  SetLength(b, 0);
  SetLength(d, 0);
  r('ffmpeg', myExpandFN(edtffmpeg.Text));
  r('ffplay', myExpandFN(edtffplay.Text));
  r('ffprobe', myExpandFN(edtffprobe.Text));
  if (jo <> nil) then
  begin
    r('dirout', jo.getval(edtDirOut.Name));
    r('output', jo.getval(edtOfn.Name));
    r('dirtmp', myGetDirTmp(jo.getval(edtOfn.Name)));
    if Length(jo.f) > 0 then
    begin
      for l := High(jo.f) downto 0 do
      begin
        r('inpu' + IntToStr(l), jo.f[l].getval(sMyInputFN)); //back compat
        r('input:' + IntToStr(l), jo.f[l].getval(sMyInputFN));
      end;
      l := 0;
      r('input', jo.f[l].getval(sMyInputFN));
      r('dirinp', ExtractFileDir(jo.f[l].getval(sMyInputFN)));
      r('artist', myValidFilename(myGetTag(jo.f[l], 'artist'))); //?
      r('title', myValidFilename(myGetTag(jo.f[l], 'title')));   //?
      r('album', myValidFilename(myGetTag(jo.f[l], 'album')));   //?
      r('track', Format('%.2d', [StrToIntDef(jo.f[l].getval('TAG:track'), 0)]));
      r('date', jo.f[l].getval('TAG:date'));
      r('genre', myGetTag(jo.f[l], 'genre'));
      r('comment', myGetTag(jo.f[l], 'comment'));
      r('copyright', myGetTag(jo.f[l], 'copyright'));
      r('album_artist', myGetTag(jo.f[l], 'album_artist'));
      if (Pos('$encoders', s) > 0) or (Pos('${encoders}', s) > 0) then
      begin
        v := ''; a := '';
        for l := 0 to High(jo.f) do
        for k := 0 to High(jo.f[l].s) do
        begin
          c := jo.f[l].s[k];
          if c.getval(sMyChecked) = '1' then
          begin
            t := c.getval('codec_type');
            if t = 'video' then
            begin
              v := Trim(myCalcEncV(c)
              + IfThen(c.getval(cmbPreset.Name) <> '', ' ' + c.getval(cmbPreset.Name))
              + IfThen(c.getval(cmbTune.Name) <> '', ' ' + c.getval(cmbTune.Name))
              + IfThen(c.getval(cmbQualityV.Name) <> '', ' q ' + c.getval(cmbQualityV.Name))
              + IfThen(c.getval(cmbcrfv.Name) <> '', ' crf ' + c.getval(cmbcrfv.Name))
              + IfThen(c.getval(cmbcqV.Name) <> '', ' cq ' + c.getval(cmbcqV.Name))
              + IfThen(c.getval(cmbPass.Name) <> '', ' ' + c.getval(cmbPass.Name) + 'pass'));
            end
            else
            if t = 'audio' then
            begin
              a := Trim(myCalcEncA(c));
            end;
          end;
        end;
        if (v <> '') and (a <> '') then v := v + '-' + a else
        if (v = '') and (a <> '') then v := a else
        if (v = '') and (a = '') then v := 'unknown';
        r('encoders', myValidFilename(v));
      end;
    end;
  end;
  Result := StringsReplace(s, b, d, [rfReplaceAll]);
end;

function TfrmGUIta.myGetFileList(const Path, Mask: string; List: TStrings; subdir, fullpath, test: boolean): boolean;
var
  SL: TStringList;

  procedure myGetList(const Path2: string);
  var
    i: integer;
    b: boolean;
    SR: TSearchRec;
  begin
    if FindFirstUTF8(AppendPathDelim(Path2) + '*', faAnyFile and faDirectory, SR) = 0 then
    repeat
      if (SR.Attr and faDirectory) = faDirectory then
      begin
        if subdir and (SR.Name <> '.') and (SR.Name <> '..') then myGetList(AppendPathDelim(Path2) + SR.Name);
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
        begin
          List.Add(IfThen(fullpath, AppendPathDelim(Path2)) + SR.Name);
          if test then Break;
        end;
      end;
    until FindNextUTF8(SR) <> 0;
    FindCloseUTF8(SR);
  end;

begin
  SL := TStringList.Create;
  myStr2List(Mask, ';', SL);
  myGetList(Path);
  Result := List.Count > 0;
  SL.Free;
end;

procedure TfrmGUIta.myFormPosLoad(Form: TForm; Ini: TMemIniFile);
begin
  try
    if chkSaveFormPos.Checked then
    begin
      Form.Position := poDefaultPosOnly;
      Form.Top := Ini.ReadInteger(Form.Name, 'Top', Form.Top);
      Form.Left := Ini.ReadInteger(Form.Name, 'Left', Form.Left);
      Form.Width := Ini.ReadInteger(Form.Name, 'Width', Form.Width);
      Form.Height := Ini.ReadInteger(Form.Name, 'Height', Form.Height);
      if (Form.Width  > Screen.Width)  and (959 < Screen.Width)  then Form.Width  := Screen.Width;
      if (Form.Height > Screen.Height) and (599 < Screen.Height) then Form.Height := Screen.Height;
      if (Form.Top > Screen.Height - Form.Height) then Form.Top := Screen.Height - Form.Height;
      if (Form.Top < 0) then Form.Top := 0;
      if (Form.Left > Screen.Width - Form.Width) then Form.Left := Screen.Width - Form.Width;
      if (Form.Left < 0) then Form.Left := 0;
      if Ini.ReadBool(Form.Name, 'Maximized', False) then Form.WindowState := wsMaximized;
    end
    else
      Form.Position := poDefault;
  except
    on E: Exception do myError(-1, 'myFormPosLoad: ' + E.Message);
  end;
end;

procedure TfrmGUIta.myFormPosSave(Form: TForm; Ini: TMemIniFile);
var
  w: TmyWinState;
begin
  try
    if chkSaveFormPos.Checked then
    if WindowState = wsMaximized then
    begin
      myToIni(cfg, Form.Name, 'Maximized', '1');
      if (Form.Name = frmGUIta.Name) and (lsWinState.Count > 0) then
      begin
        w := TmyWinState(lsWinState.Items[0]);
        myToIni(cfg, Form.Name, 'Left',   IntToStr(w.a[1]));
        myToIni(cfg, Form.Name, 'Top',    IntToStr(w.a[2]));
        myToIni(cfg, Form.Name, 'Width',  IntToStr(w.a[3]));
        myToIni(cfg, Form.Name, 'Height', IntToStr(w.a[4]));
      end;
    end
    else
    begin
      myToIni(cfg, Form.Name, 'Maximized', '0');
      myToIni(cfg, Form.Name, 'Left',   IntToStr(Form.Left));
      myToIni(cfg, Form.Name, 'Top',    IntToStr(Form.Top));
      myToIni(cfg, Form.Name, 'Width',  IntToStr(Form.Width));
      myToIni(cfg, Form.Name, 'Height', IntToStr(Form.Height));
    end;
  except
    on e: Exception do myError(-1, 'myFormPosSave: ' + e.Message);
  end;
end;

procedure TfrmGUIta.myLanguage(bRead: boolean; bDefault: boolean = False);
var
  Ini: TMemIniFile;
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

  procedure myLng1(a: array of TComponent);
  var
    i, k: integer;
  begin
    for k := 0 to High(a) do
      if a[k] is TLabel then
        with TLabel(a[k]) do
          if bRead then
            Caption := my1(s1, Name, Caption)
          else
            my2(s1, Name, Caption)
      else if a[k] is TEdit then
        with TEdit(a[k]) do
          if bRead then
          begin
            Hint := my1(s2, Name, Hint);
            ShowHint := Hint <> '';
          end
          else
          begin
            my2(s2, Name, Hint);
          end
      else if a[k] is TLabeledEdit then
        with TLabeledEdit(a[k]) do
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
      else if a[k] is TButton then
        with TButton(a[k]) do
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
      else if a[k] is TMenuItem then
        with TMenuItem(a[k]) do
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
      else if a[k] is TCheckBox then
        with TCheckBox(a[k]) do
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
      else if a[k] is TComboBox then
        with TComboBox(a[k]) do
          if bRead then
          begin
            Hint := my1(s2, Name, Hint);
            ShowHint := Hint <> '';
            if (Style = csDropDownList) then
              for i := 0 to Items.Count - 1 do
                Items[i] := Ini.ReadString(Name, IntToStr(i), Items[i]);
          end
          else
          begin
            my2(s2, Name, Hint);
            if (Style = csDropDownList) then
              for i := 0 to Items.Count - 1 do
                Ini.WriteString(Name, IntToStr(i), Items[i]);
          end
      else if a[k] is TSpinEdit then
        with TSpinEdit(a[k]) do
          if bRead then
          begin
            Hint := my1(s2, Name, Hint);
            ShowHint := Hint <> '';
          end
          else
            my2(s2, Name, Hint)
      else if a[k] is TListView then
        with TListView(a[k]) do
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
      else if a[k] is TPanel then
        for i := 0 to TPanel(a[k]).ControlCount - 1 do
          myLng1([TPanel(a[k]).Controls[i]])
      else if a[k] is TTabSheet then
      begin
        with TTabSheet(a[k]) do
          if bRead then
            Caption := my1(s1, Name, Caption)
          else
            my2(s1, Name, Caption);
        for i := 0 to TTabSheet(a[k]).ControlCount - 1 do
          myLng1([TTabSheet(a[k]).Controls[i]]);
      end
      else if a[k] is TPageControl then
      begin
        for i := 0 to TPageControl(a[k]).PageCount - 1 do
          myLng1([TPageControl(a[k]).Pages[i]]);
      end;
  end;

  procedure myLng4(a: array of TPopupMenu);
  var
    i, j: integer;
  begin
    for j := 0 to High(a) do
    begin
      for i := 0 to TPopupMenu(a[j]).Items.Count - 1 do
        myLng1([TPopupMenu(a[j]).Items[i]]);
    end;
  end;

  procedure myLng5(a: array of TPageControl);
  var
    i, j: integer;
  begin
    for j := 0 to High(a) do
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
    mes[2] := 'Usage: ffmpegGUIta [-start] [-o:"folder"] [<files>...]\n-start   start converting\n-o:"folder"   set output dir to folder\n-m -masks   use masks\n-p -profile   use default profile\n-p:"profile.ini"   use profile\n-c -split   cut file to fragments\n-i -images   file as image sequence (*.jpg)\n-s -single   all files as one job\n-a -add   add files to job\n-concat   concat files\n-concat2   concat:file1|file2\n-screengrab   add screengrab job';
    mes[3] := 'Creating file list';
    mes[4] := 'process completed, error code:';
    mes[5] := 'job completed for';
    mes[6] := 'Error';
    mes[7] := 'Select job to change convert parameters';
    mes[8] := 'Cancel';
    mes[9] := 'temporary';
    mes[10] := 'folder not found';
    mes[11] := 'cmdline is empty';
    mes[12] := 'file not found';
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
    mes[24] := 'is not divisible by 16';
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
    mes[43] := 'Expected output file size:';
    mes[44] := 'Side by side';
    mes[45] := 'Pause';
    mes[46] := 'Resume';
    mes[47] := 'Add screen capture job';
    mes[48] := 'Save file as';
    mes[49] := 'Open existing file';
    mes[50] := 'cannot test edited command lines';
    mes[51] := 'not found';
    mes[52] := '(default)';
    mes[53] := '(screengrab)';
    mes[54] := 'Warning';
    mes[55] := 'calculate';
    mes[56] := 'can''t save to file';
    mes[57] := 'File exists, overwrite?';
  end;
  s1 := sInidir + cmbLanguage.Text;
  if bRead and (not FileExistsUTF8(s1) or (bDefault and (cmbLanguage.Text = 'Default.lng'))) then
    Exit;
  Ini := TMemIniFile.Create(s1);
  s1 := 'Captions';
  s2 := 'Hints';
  s3 := 'Messages';
  try
    myLng1([Panel1]);
    myLng5([PageControl1, PageControl2, PageControl3, PageControl4]);
    myLng4([PopupMenuJobs, PopupMenuStreams, PopupMenuFiles, PopupMenuConsole, PopupMenuJournal, PopupMenuMediaInfo, PopupMenuStreamInfo]);
    for i := Low(mes) to High(mes) do
      if bRead then
        mes[i] := Ini.ReadString(s3, IntToStr(i), mes[i])
      else
        Ini.WriteString(s3, IntToStr(i), mes[i]);
  except
    on e: Exception do myError(-1, 'myLanguage: ' + e.Message);
  end;
  Ini.Free;
  if bRead then
  begin
    s1 := UpperCase(mes[6]); //Error
    if SynUNIXShellScriptSyn1.SecondKeyWords.IndexOf(s1) < 0 then
      SynUNIXShellScriptSyn1.SecondKeyWords.Add(s1);
  end;
end;

procedure TfrmGUIta.myChkCpuCount;
begin
  if (spnCpuCount.Value = 0) then
    spnCpuCount.Value := GetSystemThreadCount;
  if (spnCpuCount.Value = 0) then
    spnCpuCount.Value := 1;
end;

procedure TfrmGUIta.myDisComp;
var
  b, b1, b2: boolean;
  l: integer;
  jo: TJob;
begin
  b := (LVjobs.Selected <> nil);
  if b then
    jo := TJob(LVjobs.Selected.Data);
  if LVfiles.Selected <> nil then
    l := StrToIntDef(LVfiles.Selected.Caption, 0)
  else
    l := 0;
  if b and (l >= 0) and (l <= High(jo.f)) then
    b1 := FileExistsUTF8(jo.f[l].getval(sMyInputFN))
  else
    b1 := False;
  b2 := b and FileExistsUTF8(jo.getval(edtOfn.Name));
  btnMediaInfo2.Enabled := b2;
  btnPlayOut.Enabled := b2;
  btnCompare.Enabled := b1 and b2;
end;

procedure TfrmGUIta.myDisTab(w: TWinControl; b: boolean);
var
  c: TWinControl;
  d: TControl;
  i: integer;
begin
  c := w.Parent;
  for i := 0 to c.ControlCount - 1 do
  begin
    d := c.Controls[i];
    if w <> d then
      if (d is TComboBox) or (d is TCheckBox) or (d is TMemo) or (d is TLabel) or (d is TPanel) then
        d.Enabled := b;
  end;
  myError(0, 'myDisTab: ' + IfThen(b, 'enable', 'disable'));
end;

procedure TfrmGUIta.myBusy(b: boolean);
begin
  if not b then Screen.Cursor := crHourGlass;
  btnTest.Enabled := b;
  btnStart.Enabled := b;
  btnStop.Enabled := b;
  btnSuspend.Enabled := b;
  btnTestFiltersO.Enabled := b;
  btnTestFiltersV.Enabled := b;
  btnTestFiltersA.Enabled := b;
  if b then Screen.Cursor := crDefault;
end;

function TfrmGUIta.myGetCaptionCont(c: TCont): string;
var
  s, t: string;
  i: integer;
  e: extended;
begin
  s := c.getval('codec_tag_string');
  Result := c.getval('codec_name') + IfThen(Pos('[', s) = 0, ' ' + s);
  t := c.getval('codec_type');
  if t = 'video' then
  begin
    Result += ' ' + c.getval('width') + 'x' + c.getval('height');
    e := myValFPS([c.getval('r_frame_rate'), c.getval('avg_frame_rate')]);
    Result += ' ' + FloatToStr(e) + 'fps';
  end
  else if t = 'audio' then
    Result += ' ' + c.getval('channels') + 'ch ' + c.getval('sample_rate') + 'Hz';
  i := StrToIntDef(c.getval('bit_rate'), 0);
  if i > 100000 then
    Result += ' ' + IntToStr(Round(i / 1000)) + 'kbps'
  else if i > 10000 then
    Result += ' ' + FloatToStr(Round(i / 100) / 10) + 'kbps'
  else
    Result += ' ' + IntToStr(i) + 'bps';
  s := c.getval('TAG:language');
  if s <> '' then Result += ' ' + s;
  s := myGetTag(c, 'title');
  if s <> '' then Result += ' ' + s;
end;

function TfrmGUIta.myCalcOutSize(jo: TJob): string;
var
  r, q, p, rd: double;
  k, l, cv, ca, cs, sz: integer;
  s, t, fn, sExt: string;
  c: TCont;
  b: boolean;

  function my1(s: string): double;
  var
    i: integer;
  begin
    Val(s, Result, i);
    if i > 0 then
      Val(Copy(s, 1, i - 1), Result, i);
    if Pos('ki', LowerCase(s)) > 0 then Result := Result * 1024               else
    if Pos('k',  LowerCase(s)) > 0 then Result := Result * 1000               else
    if Pos('mi', LowerCase(s)) > 0 then Result := Result * 1024 * 1024        else
    if Pos('m',  LowerCase(s)) > 0 then Result := Result * 1000000            else
    if Pos('gi', LowerCase(s)) > 0 then Result := Result * 1024 * 1024 * 1024 else
    if Pos('g',  LowerCase(s)) > 0 then Result := Result * 1000000000;
  end;

begin
  Result := jo.getval(sMyTested); //return test calc output duration
  if Result <> '' then Exit;
  sExt := LowerCase(ExtractFileExt(jo.getval(edtOfn.Name)));
  //get bitrate per second for every checked tracks
  r := 0;  //output size
  cv := 0; //video count
  ca := 0; //audio count
  cs := 0; //other count
  b := False;
  rd := myGetDuration(jo);
  sz := 0; //file size
  for l := 0 to High(jo.f) do
  begin
    t := jo.f[l].getval('size');
    if t <> '' then sz += StrToIntDef(t, 0);
    for k := 0 to High(jo.f[l].s) do
    begin
      c := jo.f[l].s[k];
      if c.getval(sMyChecked) = '1' then
      begin
        t := c.getval('codec_type');
        if t = 'video' then
        begin
          if c.getval(cmbEncoderV.Name) = 'copy' then
          begin
            q := StrToIntDef(c.getval('bit_rate'), 0);
            if q = 0 then
            begin
              fn := jo.f[l].getval(sMyInputFN);
              s := myGetMediaInfo(fn, 'BitRate', Stream_Video, cv); //BitRate;; bps;N YFY;;;Bit rate in bps;
              q := StrToFloatDef(s, 1, fsp);
            end;
          end
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
          if sExt = '.mkv' then p := 1946 else
          if sExt = '.mp4' then p := 4477 else
          if sExt = '.avi' then p := 4500 else
          if sExt = '.3gp' then p := 1000 else
                                p := 10000;  //other files?
          inc(cv);
        end
        else if t = 'audio' then
        begin
          if c.getval(cmbEncoderA.Name) = 'copy' then
          begin
            q := StrToIntDef(c.getval('bit_rate'), 0);
            if q = 0 then
            begin
              fn := jo.f[l].getval(sMyInputFN);
              s := myGetMediaInfo(fn, 'BitRate', Stream_Audio, ca); //BitRate;; bps;N YFY;;;Bit rate in bps;
              q := StrToFloatDef(s, 1, fsp);
            end;
          end
          else
            q := my1(c.getval(edtBitRateA.Name));
          //additional bitrate per audio stream, more or less
          if sExt = '.mkv' then p := 1401 else
          if sExt = '.mp4' then p := 1126 else
          if sExt = '.avi' then p := 9650 else
          if sExt = '.3gp' then p :=  800 else
                                p := 10000;  //other files?
          inc(ca);
        end
        else
        begin
          q := 1;
          p := 0;
          inc(cs);
        end;
        myError(0, 'myCalcOutSize: ' + IntToStr(cv + ca + cs) + ' ' + t + ' bitrate=' + FloatToStr(q) + ' +' + FloatToStr(p));
        r += q + p;
        if q = 0 then b := True;
      end;
    end;
  end;
  if b then //if zero
  begin
    if (rd > 0) and (cv + ca + cs = 1) then
    begin
      r := 8 * sz / rd;
    end
    else
    begin
      Result := '?';
      Exit;
    end;
  end;
  //additional bitrate per file, more or less
  p := 0;
  if sExt = '.mkv' then
  begin
    p := 302;
    if (cv > 0) and (ca > 0) then
      p := p - 86 * (cv + ca - 1);
  end
  else if sExt = '.mp4' then
  begin
    if (cv > 0) and (ca > 0) then p := cv * (821 + 119) + ca * (631 + 117) + 879 else
    if (cv > 1) and (ca = 0) then p := cv * (821 + 119) else
    if (cv = 0) and (ca > 1) then p := ca * (631 + 117);
  end
  else if sExt = '.avi' then
  begin

  end;
  r += p;
  myError(0, 'myCalcOutSize: output bitrate=' + FloatToStr(r));
  //multiplicate to duration
  myError(0, 'myCalcOutSize: duration=' + FloatToStr(rd));
  if rd = 0 then
    r := r / 8
  else
    r := r / 8 * rd;
  //header, more or less
  //if sExt = '.mkv' then q := 1360 else
  //if sExt = '.mp4' then q := 3860 else
  //                      q := 5000;
  //r := r + q;
  myError(0, 'myCalcOutSize: output size=' + FloatToStr(r));
  Result := '~' + Trim(Format('%12.0n', [r]));
end;

function TfrmGUIta.myCalcEncV(c: TCont): string;
var
  s: string;
begin
  Result := c.getval(cmbEncoderV.Name);
  if Pos('codec_name', Result) > 0 then
  begin
    s := 'codec_name=' + c.getval('codec_name') + LineEnding;
    Result := myValStr(c.getval(cmbEncoderV.Name), s);
  end;
end;

function TfrmGUIta.myCalcEncA(c: TCont): string;
var
  s: string;
begin
  Result := c.getval(cmbEncoderA.Name);
  if Pos('codec_name', Result) > 0 then
  begin
    s := 'codec_name=' + c.getval('codec_name') + LineEnding;
    Result := myValStr(c.getval(cmbEncoderA.Name), s);
  end;
end;

function TfrmGUIta.myCalcEncS(c: TCont): string;
var
  s: string;
begin
  Result := c.getval(cmbEncoderS.Name);
  if Pos('codec_name', Result) > 0 then
  begin
    s := 'codec_name=' + c.getval('codec_name') + LineEnding;
    Result := myValStr(c.getval(cmbEncoderS.Name), s);
  end;
end;

function TfrmGUIta.myCalcBRv(c: TCont): string;
var
  fps: extended;
  w, h: integer;
  s: string;
  i: integer;
begin
  fps := myValFPS([c.getval('r_frame_rate'), c.getval('avg_frame_rate')]); //c.getval('outFPS'),
  if fps = 0 then
    fps := 30;
  w := 0;
  h := 0;
  myGetWH(c, w, h);
  s := 'w=' + IntToStr(w) + LineEnding
     + 'h=' + IntToStr(h) + LineEnding
     + 'fps=' + FloatToStr(fps) + LineEnding
     + '$koefv=' + c.getval(spnKoefV.Name) + LineEnding;
  i := StrToIntDef(c.getval('bit_rate'), 0) div 1000;
  if i = 0 then i := 2019;
  s += 'in_bitrate=' + IntToStr(i) + LineEnding;
  w := myValInt(c.getval(cmbBitrateV.Name), s);
  if w > 0 then
    Result := IntToStr(w) + 'k'
  else
    Result := '0';
  myError(0, 'myCalcBRv: ' + mes[55] + ' bitrate video=' + Result + ', formula=' + c.getval(cmbBitrateV.Name)
      + ' var=' + StringReplace(s, LineEnding, ' ', [rfReplaceAll]));
end;

function TfrmGUIta.myCalcBRa(c: TCont): string;
var
  i, ch: integer;
  s, t: string;
begin
  t := IfThen(c.getval(cmbSRate.Name) = '', c.getval('sample_rate'), c.getval(cmbSRate.Name));
  s := 'srate=' + t + LineEnding;
  t := c.getval('channels');
  s += 'in_ch=' + t + LineEnding;
  t := IfThen(c.getval(cmbChannels.Name) = '', t, c.getval(cmbChannels.Name));
  ch := StrToIntDef(t, 2);
  s += 'ch=' + t + LineEnding;
  i := StrToIntDef(c.getval('bit_rate'), 0) div 1000;
  if i = 0 then i := 111 * ch;
  s += 'in_bitrate=' + IntToStr(i) + LineEnding;
  s += '$koefa=' + c.getval(spnKoefA.Name) + LineEnding;
  i := myValInt(c.getval(cmbBitrateA.Name), s);
  if i > 0 then
    Result := IntToStr(i) + 'k'
  else
    Result := '0';
  myError(0, 'myCalcBRa: ' + mes[55] + ' bitrate audio=' + Result + ', formula=' + c.getval(cmbBitrateA.Name)
      + ' var=' + StringReplace(s, LineEnding, ' ', [rfReplaceAll]));
end;

procedure TfrmGUIta.myGetWH(c: TCont; out w, h: integer; b: boolean = False);
var
  i: integer;
  s: string;
  sar, dar: double;

  procedure my1(t: string; var w, h: integer);
  var
    w0, h0, w1, h1, w2, h2: integer;
    vars, sw, sh: string;
    sl: TStringList;

    procedure m(s: string);
    begin
      if Pos('in_w',  s) > 0 then vars += 'in_w=' + IntToStr(w) + LineEnding;
      if Pos('iw',    s) > 0 then vars += 'iw='   + IntToStr(w) + LineEnding;
      if Pos('in_h',  s) > 0 then vars += 'in_h=' + IntToStr(h) + LineEnding;
      if Pos('ih',    s) > 0 then vars += 'ih='   + IntToStr(h) + LineEnding;
      if Pos('a',     s) > 0 then vars += 'a='    + FloatToStr(w / h) + LineEnding;
      if Pos('sar',   s) > 0 then vars += 'sar='  + FloatToStr(sar) + LineEnding;
      if Pos('dar',   s) > 0 then vars += 'dar='  + FloatToStr(dar) + LineEnding;
      if Pos('out_w', s) > 0 then vars += 'out_w=' + IntToStr(w1) + LineEnding;
      if Pos('out_h', s) > 0 then vars += 'out_h=' + IntToStr(h1) + LineEnding;
      if Pos('ow',    s) > 0 then vars += 'ow='   + IntToStr(w1) + LineEnding;
      if Pos('oh',    s) > 0 then vars += 'oh='   + IntToStr(h1) + LineEnding;
      if Pos('hsub',  s) > 0 then vars += 'hsub=2' + LineEnding;
      if Pos('vsub',  s) > 0 then vars += 'vsub=1' + LineEnding;
      if Pos('ohsub',  s) > 0 then vars += 'ohsub=2' + LineEnding;
      if Pos('ovsub',  s) > 0 then vars += 'ovsub=1' + LineEnding;
    end;

  begin
    s := c.getval(t);
    if s = '' then Exit;
    w0 := w; //backup width
    h0 := h; //backup height
    sw := ''; //IntToStr(w);
    sh := ''; //IntToStr(h);
    sl := TStringList.Create;
    sl.Delimiter := ':';
    sl.DelimitedText := s;
    if sl.Count > 0 then
    begin
      sw := sl[0];
      if sl.Count > 1 then
        sh := sl[1];
    end;
    vars := '';
    m(sw);
    w1 := myValInt(sw, vars);
    vars := '';
    m(sh);
    h1 := myValInt(sh, vars);

    if sl.Count > 2 then  //and scale
    begin
    //720:576 16/9  scale=640:360:force_original_aspect_ratio=decrease      =450x360
      if Pos('force_original_aspect_ratio=decrease', s) > 0 then
      begin
        w2 := Round(h1 / h * w);  //=450
        h2 := Round(w1 / w * h);  //=512
        if h2 > h1 then w1 := w2 else
        if w2 > w1 then h1 := h2;
      end;
    //720:576 16/9  scale=640:360:force_original_aspect_ratio=increase      =640x512
      if Pos('force_original_aspect_ratio=increase', s) > 0 then
      begin
        w2 := Round(h1 / h * w);  //=450
        h2 := Round(w1 / w * h);  //=512
        if h2 < h1 then w1 := w2 else
        if w2 < w1 then h1 := h2;
      end;
    end;

    //1920:1080     scale=1280:-2         =1280x720
    //1080:1920     scale=720:-2          =720x1280
    //720:576 16/9  scale=720:-2          =720x576
    if (w1 > 0) and (h1 < 0) and (w > 0) and (h > 0) then
      h1 := Round(w1 / w * h / h1) * h1;

    //1920:1080     scale=-2:720          =1280x720
    //1080:1920     scale=-2:1280         =720x1280
    if (w1 < 0) and (h1 > 0) and (w > 0) and (h > 0) then
      w1 := Round(h1 / h * w / w1) * w1;

    w := w1;
    h := h1;
    myError(0, 'myGetWH.' + t + ': ' + mes[55] + ' ' + mes[22] + '=' + IntToStr(w) +    //width height
      ' ' + mes[23] + '=' + IntToStr(h) + ' ' + StringReplace(vars, LineEnding, ' ', [rfReplaceAll]));
    if (w <= 0) or (h <= 0) then
    begin
      w := w0;
      h := h0;
    end;
    sl.Free;
  end;

begin
  w := StrToIntDef(c.getval('width'), 0);
  h := StrToIntDef(c.getval('height'), 0);
  sar := myValSAR(c.getval('sample_aspect_ratio'));
  if (sar = 0) then sar := 1;
  dar := myValSAR(c.getval('display_aspect_ratio'));
  if (dar = 0) then if (w > 0) and (h > 0) then dar := w / h else dar := 16 / 9;
  myError(0, Format('myGetWH:1 %s %s=%d %s=%d sar=%n dar=%n', [mes[55], mes[22], w, mes[23], h, sar, dar], fsp)); //width height
  if b then //if not -noautorotate, if -autorotate
  begin
    s := c.getval('TAG:rotate');
    if (s = '90') or (s = '270') then
    begin
      i := w;
      w := h;
      h := i;
      myError(0, Format('myGetWH:2 %s autorotate %s=%d %s=%d', [mes[55], mes[22], w, mes[23], h])); //width height
    end;
  end;
  my1(cmbCrop.Name, w, h);
  my1(cmbScale.Name, w, h);
  my1(cmbPad.Name, w, h);
  if (StrToIntDef(c.getval(cmbRotate.Name), 7) in [0..3]) then
  begin
    i := w;
    w := h;
    h := i;
    myError(0, Format('myGetWH:3 %s rotate %s=%d %s=%d', [mes[55], mes[22], w, mes[23], h])); //width height
  end;
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
  if w > 1 then
    Val(Copy(s, 1, w - 1), Result, w);
  if c.CalcError then myError(0, 'myValInt: ' + c.CalcErrorText);
end;

function TfrmGUIta.myValStr(f, v: string): string;
var
  c: TCalcul;
begin
  c := TCalcul.Create;
  c.Variables := v;
  c.Formula := StringReplace(f, '\', '', [rfReplaceAll]);
  Result := c.calc;
  if c.CalcError then myError(0, 'myValStr: ' + c.CalcErrorText);
end;

function TfrmGUIta.myDirExists(dir, s: string): boolean;
begin
  Result := True;
  if not DirectoryExistsUTF8(dir) then
    if not ForceDirectoriesUTF8(dir) then
    begin
      myError(-1, 'myDirExists: ' + s + ' ' + mes[10] + ' - ' + dir); //folder not found
      Result := False;
    end;
end;

function TfrmGUIta.myExtrDirExist(d: string): string;
var
  i: integer;
begin
  Result := d;
  i := 0;
  while not DirectoryExistsUTF8(Result) and (i < 128) do
  begin
    Result := ExtractFileDir(Result);
    Inc(i);
  end;
end;

function TfrmGUIta.myFileExists(fn: string): boolean;
begin
  Result := FileExistsUTF8(fn);
  if not Result then myError(-1, 'myFileExists: ' + mes[12] + ': ' + fn); //file not found
end;

function TfrmGUIta.myChkFile(Sender: TObject): boolean;
var
  s: string;
begin
  s := myGet2(Sender);
  if s = '' then
    Result := False
  else
    Result := FileExistsUTF8(myExpandFN(s));
  if Result then
    TComboBox(Sender).ParentFont := True
  else
    TWinControl(Sender).Font.Color := ColorErrorText.ButtonColor;
end;

procedure TfrmGUIta.myError(i: integer; s: string);
begin
  if (i <> 0) or chkDebug.Checked then
  begin
    StatusBar1.SimpleText := s;
    memJournal.Lines.Add(FormatDateTime(cmbDateTime.Text, Now) + ' '
      + IfThen(i <> 0, mes[6] + ': ' + IntToStr(i) + ' ') + s);        //Error
  end;
  if (i <> 0) then //and (i <> 256) then //ffprobe -list_formats all /dev/video0
  begin
    PageControl1.ActivePage := TabJournal;
    memJournal.SelStart := Length(memJournal.Lines.Text);
  end;
end;

procedure TfrmGUIta.myFillFmtEnc;
var
  i: integer;
  sl: TStringList;
  Ini: TMemIniFile;
begin
  cmbFormat.Items.AddStrings([''], True);
  if chkGenDBuse.Checked then
  begin
    //load formats from custom files
    Screen.Cursor := crHourGlass;
    if not FileExistsUTF8(sInidir + 'get_video.db') then memJournal.Lines.Add(mes[6] + ': get_video.db: ' + mes[12]);
    sl := TStringList.Create;
    Ini := TMemIniFile.Create(sInidir + 'get_video.db');
    Ini.ReadSections(sl);
    cmbFormat.Items.AddStrings(sl);
    Ini.Free;
    if not FileExistsUTF8(sInidir + 'get_audio.db') then memJournal.Lines.Add(mes[6] + ': get_audio.db: ' + mes[12]);
    Ini := TMemIniFile.Create(sInidir + 'get_audio.db');
    Ini.ReadSections(sl);
    for i := 0 to sl.Count - 1 do myAdd2cmb(cmbFormat, sl[i]);
    Ini.Free;
    if not FileExistsUTF8(sInidir + 'get_subtitle.db') then memJournal.Lines.Add(mes[6] + ': get_subtitle.db: ' + mes[12]);
    Ini := TMemIniFile.Create(sInidir + 'get_subtitle.db');
    Ini.ReadSections(sl);
    for i := 0 to sl.Count - 1 do myAdd2cmb(cmbFormat, sl[i]);
    Ini.Free;
    sl.Free;
    Screen.Cursor := crDefault;
  end
  else
  begin
    myTredExe1(7, memConsole, 'm', 'muxers');
    myTredExe1(8, memMediaInfo, 'e', 'encoders');
  end;
  myChngEnc;
end;

procedure TfrmGUIta.myFillSGin(si: TStrings; ct: string);
var
  s, t, u: string;
  i, j: integer;
  sl: TStringList;
begin
  si.Clear;
  {$IFDEF MSWINDOWS}
  if (ct = 'video') or (ct = '') then
  begin
    si.Add('-f gdigrab -framerate 30 -i desktop');
    si.Add('-f gdigrab -framerate 30 -offset_x 10 -offset_y 20 -video_size 640x480 -show_region 1 -i desktop');
    si.Add('-f gdigrab -framerate 30 -i title=Calculator');
  end;
  j := myGetRunOut(myExpandFN(edtffmpeg.Text), ['-hide_banner', '-list_devices', 'true', '-f', 'dshow', '-i', 'NUL'], 1, s);
  if (j = 0) or (j = 1) then //return code is 1
  begin
    sl := TStringList.Create;
    sl.Text := s;
    for i := 0 to sl.Count - 1 do
    begin
      s := sl[i];
      if Pos('DirectShow video devices', s) > 0 then t := 'video';
      if Pos('DirectShow audio devices', s) > 0 then t := 'audio';
      j := Pos('  "', s);
      if (j > 0) and ((ct = t) or (ct = '')) then
      begin
        u := t + '=' + Copy(s, j + 2, Length(s));
        si.Add('-f dshow -i ' + u);
      end;
    end;
    sl.Free;
  end;
  {$ELSE}
  if (ct = 'video') or (ct = '') then
  begin
    si.Add('-f x11grab -framerate 30 -video_size ' + IntToStr(Screen.Width) + 'x'+ IntToStr(Screen.Height)
      + ' -i ' + GetEnvironmentVariableUTF8('DISPLAY'));
    sl := TStringList.Create;
    j := 0;
    while FileExistsUTF8('/dev/video' + IntToStr(j)) do
    begin
      //ffprobe -list_formats all -f v4l2 /dev/video0        error 256 - /dev/video0: Immediate exit requested
      //[video4linux2,v4l2 @ 0x55d8463c06c0] Raw       :     yuyv422 :           YUYV 4:2:2 : 640x480 352x288 320x240 176x144 160x120
      myGetRunOut(myExpandFN(edtffprobe.Text), ['-hide_banner', '-list_formats', 'all', '-f', 'v4l2', '/dev/video' + IntToStr(j)], 256, s);
      u := myBetween(s, '[video4linux2', LineEnding);
      myStr2List(u, ' ', sl);
      for i := sl.Count - 1 downto 0 do
      begin
        t := sl[i];
        if Pos('x', t) > 2 then
          si.Add('-f v4l2 -framerate 30 -video_size ' + t + ' -i /dev/video' + IntToStr(j))
        else
          Break;
      end;
      inc(j);
    end;
    sl.Free;
  end;
  if (ct = 'audio') or (ct = '') then
  begin
    if myGetRunOut(FindDefaultExecutablePath('pacmd'), ['list-sources'], s) <> 0 then Exit;
    sl := TStringList.Create;
    sl.Text := s;
    for i := 0 to sl.Count - 1 do
    begin
      s := sl[i];
      j := Pos('index:', s);//    index: 0
      if j > 0 then         //  * index: 1
      begin
        u := Copy(s, j + 7, 3);
        si.Add('-f pulse -i ' + u);
      end;
      j := Pos('name:', s); //        name: <alsa_output.pci-0000_00_1b.0.analog-stereo.monitor>
      if j > 0 then         //        name: <alsa_input.pci-0000_00_1b.0.analog-stereo>
      begin
        u := myBetween(s, '<', '>');
        si.Add('-f pulse -i ' + u);
      end;
    end;
    sl.Free;
  end;
  {$ENDIF}
end;

function TfrmGUIta.myNoJo(out jo: TJob): boolean;
begin
  Result := LVjobs.Selected = nil;
  if Result then Exit;
  jo := TJob(LVjobs.Selected.Data);
end;

function TfrmGUIta.myNoJoC(out jo: TJob; out c: TCont): boolean;
var
  i, l, k: integer;
  s: string;
begin
  Result := LVjobs.Selected = nil;
  if Result then Exit;
  jo := TJob(LVjobs.Selected.Data);
  Result := LVstreams.Selected = nil;
  if Result then Exit;
  s := LVstreams.Selected.Caption;
  i := Pos(':', s);
  l := StrToIntDef(Copy(s, 1, i - 1), -1);
  k := StrToIntDef(Copy(s, i + 1, Length(s)), -1);
  if (l >= 0) and (l <= High(jo.f)) and (k >= 0) and (k <= High(jo.f[l].s)) then
    c := jo.f[l].s[k]
  else
    Result := True;
end;

function TfrmGUIta.myGetCurrCont(jo: TJob; s: string): TCont;
var
  i, l, k: integer;
begin
  i := Pos(':', s);
  l := StrToIntDef(Copy(s, 1, i - 1), -1);
  k := StrToIntDef(Copy(s, i + 1, Length(s)), -1);
  if (l >= 0) and (l <= High(jo.f)) and (k >= 0) and (k <= High(jo.f[l].s)) then
    Result := jo.f[l].s[k]
  else
    Result := TCont.Create;
end;

procedure TfrmGUIta.myGetss4Compare(jo: TJob; rs: double = 0; rt: double = 0);
var
  rd, ri, ro, rm: double;
begin
  if Length(jo.f) = 0 then Exit;
  rd := myTimeStrToReal(jo.f[0].getval('duration'));
  if rs = 0 then rs := myTimeStrToReal(jo.getval(cmbDurationss2.Name));
  if rt = 0 then rt := myTimeStrToReal(jo.getval(cmbDurationt2.Name));
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
  jo.setval(sMyCompar1, myRealToTimeStr(ri, False));
  jo.setval(sMyCompar2, myRealToTimeStr(ro, False));
end;

function TfrmGUIta.myGetPic(ss, fn, fv: string; sm: TSynMemo): string;
var
  s: string;
  sl: TStringList;
begin
  Result := myGetDirTmp(fn) + 'tmp.bmp';
  sl := TStringList.Create;
  sl.Add('-hide_banner');
  s := LowerCase(ExtractFileExt(fn));
  if (s <> '.jpg') and (s <> '.jpeg') and (ss <> '') then
  begin
    sl.Add('-ss'); sl.Add(ss);
  end;
  sl.Add('-i'); sl.Add(fn);
  if fv <> '' then process.CommandToList(fv, sl);
  sl.Add('-frames'); sl.Add('1');
  sl.Add('-f'); sl.Add('image2');
  sl.Add('-y'); sl.Add(Result);
  myGetRunOut(myExpandFN(edtffmpeg.Text), sl, s);
  sm.Text := s;
  sl.Free;
end;

function TfrmGUIta.myGetFrame(nb: integer; fn, fv: string; sm: TSynMemo): string;
var
  s: string;
  sl: TStringList;
begin
  Result := myGetDirTmp(fn) + 'tmp.bmp';
  sl := TStringList.Create;
  sl.Add('-hide_banner');
  sl.Add('-i'); sl.Add(fn);
  if fv <> '' then process.CommandToList(fv, sl);
  sl.Add('-filter:v'); sl.Add('select=eq(n\,' + IntToStr(nb) + ')');
  sl.Add('-frames:v'); sl.Add('1');
  sl.Add('-f'); sl.Add('image2');
  sl.Add('-y'); sl.Add(Result);
  myGetRunOut(myExpandFN(edtffmpeg.Text), sl, s);
  sm.Text := s;
  sl.Free;
end;

function TfrmGUIta.myGetNumFrames(fn: string; sm: TSynMemo): integer;
var
  s: string;
begin
  Result := 0;
  if Pos(Lowercase(ExtractFileExt(fn)), '.mkv .webm') > 0 then
  begin
    myGetRunOut(myExpandFN(edtffprobe.Text), ['-v', 'error', '-select_streams', 'v:0',
    '-show_entries', 'stream_tags=NUMBER_OF_FRAMES,NUMBER_OF_FRAMES-eng',
    '-of', 'default=nokey=1:noprint_wrappers=1', fn], s);
    sm.Text := s;
    Result := StrToIntDef(s, 0);
  end
  else
  begin
    myGetRunOut(myExpandFN(edtffprobe.Text), ['-v', 'error', '-select_streams', 'v:0',
    '-show_entries', 'stream=nb_frames',
    '-of', 'default=nokey=1:noprint_wrappers=1', fn], s);
    sm.Text := s;
    Result := StrToIntDef(s, 0);
    //if s = 'N/A' then
  end;
  if Result = 0 then
  begin
    myGetRunOut(myExpandFN(edtffmpeg.Text), ['-hide_banner', '-i', fn, '-map', '0:v:0', '-c', 'copy', '-f', 'null', '-'], s);
    sm.Text := s;
    s := myBetween(s, 'frame=', ' ');
    Result := StrToIntDef(s, 0);
  end;
end;

function TfrmGUIta.myValSAR(s: string): extended;
var
  i: integer;
  s1, s2: string;
begin
  Result := 1;
  i := Pos(':', s);
  if i = 0 then
    i := Pos('/', s);
  if i > 0 then
  begin
    s1 := Copy(s, 1, i - 1);
    s2 := Copy(s, i + 1, Length(s));
    i := StrToIntDef(s2, 1);
    if i = 0 then
      i := 1;
    Result := StrToIntDef(s1, 1) / i;
  end
  else
    Result := StrToFloatDef(s, 1, fsp);
end;

function TfrmGUIta.myGetSAR(s: string): string;
begin
  //Result := StringReplace(s, ':', '/');
  Result := FloatToStr(myValSAR(s), fsp);
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
      Result := StrToFloatDef(s, 0, fsp);
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
    c := myGetCurrCont(jo, stream);
    Result := myValFPS([c.getval('r_frame_rate'), c.getval('avg_frame_rate')]);
  end
  else
  begin
    for l := 0 to High(jo.f) do
    for k := 0 to High(jo.f[l].s) do
    begin
      c := jo.f[l].s[k];
      if (c.getval(sMyChecked) = '1') and (c.getval('codec_type') = 'video') then
      begin
        Result := myValFPS([c.getval('r_frame_rate'), c.getval('avg_frame_rate')]);
        Break;
      end;
    end;
  end;
  if Result = 0 then Result := 30;
end;

procedure TfrmGUIta.myAdd2cmb(c: TComboBox; s: string; add: boolean = True);
begin
  if (c.Items.IndexOf(s) < 0) then
    if add then
      c.Items.Add(s)
    else
      c.Items.Insert(0, s);
end;

procedure TfrmGUIta.myGetClipboardFileNames(c: TCont; test: boolean = False);
var
{$IFDEF MSWINDOWS}
  h: HDROP;
  i, j, l: cardinal;
  w: WideString;
{$ELSE}
  i: integer;
  sl: TStringList;
{$ENDIF}
  st: TStringList;

  procedure my1(s: string);
  var
    i: integer;
  begin
    if DirectoryExistsUTF8(s) then
    begin
      st := TStringList.Create;
      if myGetFileList(s, myGetExtsFromMasks, st, True, True, test) then
      begin
        st.Sort;
        for i := 0 to st.Count - 1 do
          c.addval(st[i], myGetDirOut('', s, st[i]));
      end;
      st.Free;
    end
    else
    if FileExistsUTF8(s) then
      c.addval(s, myGetDirOut('', s));
  end;

begin
{$IFDEF MSWINDOWS}
  Windows.OpenClipboard(frmGUIta.Handle);
  try
    try
      h := Windows.GetClipboardData(CF_HDROP);
      if h > 0 then
      begin
        j := DragQueryFileW(h, $FFFFFFFF, nil, 0);
        for i := 0 to j - 1 do
        begin
          l := DragQueryFileW(h, i, nil, 0);
          SetLength(w, l);
          l := DragQueryFileW(h, i, @w[1], l + 1);
          SetLength(w, l);
          my1(UTF8Encode(w));
          if test then Break;
        end;
      end;
    except
      on e: Exception do myError(-1, 'myGetClipboardFileNames: ' + e.Message);
    end;
  finally
    Windows.CloseClipboard;
  end;
{$ELSE}
  if not Clipboard.HasFormat(CF_TEXT) then Exit;
  sl := TStringList.Create;
  try
    try
      sl.Text := ClipBoard.AsText;
      for i := 0 to sl.Count - 1 do
      begin
        if Pos('file://', sl[i]) = 1 then
          my1(Copy(sl[i], 8, length(sl[i]))) //remove protocol "file://"
        else
          my1(sl[i]);
        if test then Break;
      end;
    except
      on e: Exception do myError(-1, 'myGetClipboardFileNames: ' + e.Message);
    end;
  finally
    sl.Free;
  end;
{$ENDIF}
end;

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
  myError(0, Format('myWindowColorIsDark: r,g,b=%d,%d,%d', [r, g, b]));
end;

function TfrmGUIta.myGetExtsFromMasks: string;
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
      myStr2List(s, ';', SL);
      for j := 0 to SL.Count - 1 do
      begin
        s := '*' + SL[j] + ';';
        if Pos(s, Result) = 0 then
          Result += s;
      end;
      SL.Free;
    end;
  end
  else
    Result := edtFileExts.Text;
end;

procedure TfrmGUIta.myShowCaption(s: string);
begin
  frmGUIta.Caption := sCap
    + IfThen(DuraAll > 0, ', ' + mes[21] + ' = ' + myRealToTimeStr(DuraAll))  //Overall duration is
    + IfThen(DuraAl2 > 0, ', ' + mes[27] + ' = ' + IntToStr(DuraAl2))         //Files
    + IfThen(DuraJob <> '', ', ' + mes[32] + ' = ' + DuraJob)                 //Job
    + IfThen(s <> '', ', ' + s);
end;

procedure TfrmGUIta.myChngFormat;
var
  s: string;
  i: integer;
begin
  if cmbFormat.Text = '' then Exit;
  s := cmbExt.Text;
  i := cmbExt.Items.IndexOf(s);
  if (i > 0) and (i < cmbFormat.Items.Count) then
    cmbFormat.ItemIndex := i
  else
  if Pos(' ' + s + ' ', ' .jpg .jpeg .png .bmp .tif .tiff .webp .pbm .pcx .ppm ') > 0 then
    cmbFormat.Text := 'image2'
  else
  if Pos(' ' + s + ' ', ' .mkv .mka .mks ') > 0 then
    cmbFormat.Text := 'matroska'
  else
  if Pos(' ' + s + ' ', ' .mp4 .m4a .m4v .mj2 ') > 0 then
    cmbFormat.Text := 'mp4'
  else
  begin
    for i := 0 to cmbFormat.Items.Count - 1 do
    begin
      if Pos(s, '.' + cmbFormat.Items[i]) = 1 then
      begin
        cmbFormat.Text := cmbFormat.Items[i];
        Break;
      end;
    end;
  end;
  xmyChange0i(cmbFormat);
end;

procedure TfrmGUIta.myChngEnc;
var
  s: string;
  i: integer;

  procedure my1(cmb: TComboBox; t: string);
  var
    Ini: TMemIniFile;
    SL: TStringList;
  begin
    if FileExistsUTF8(sInidir + t) then
    begin
      Ini := TMemIniFile.Create(sInidir + t);
      SL := TStringList.Create;
      Ini.ReadSection(s, SL);
      if SL.Count > 0 then
      begin
        cmb.Items.AddStrings(['', 'copy', 'no'], True);
        cmb.Items.AddStrings(SL);
        if chkDebug.Checked then cmb.Items.Add('loaded from ' + t + ', total: ' + IntToStr(cmb.Items.Count - 3));
      end;
      SL.Free;
      Ini.Free;
    end;
  end;

  procedure xmyInItems(Sender: TObject);
  begin
    with (Sender as TComboBox) do
    if (Items.Count > 0) and (Items.IndexOf(Text) >= 0) then
      ParentFont := True
    else
      Font.Color := ColorErrorText.ButtonColor;
  end;

begin
  if not chkGenDBuse.Checked then Exit;
  s := cmbFormat.Text;
  if s = '' then
  begin
    i := cmbExt.Items.IndexOf(cmbExt.Text);
    if (i > 0) and (i < cmbFormat.Items.Count) then
      s := cmbFormat.Items[i];
  end;
  if s = '' then
  begin
    s := cmbExt.Text;
    if s = '.mkv' then s := 'matroska' else
    if s = '.mka' then s := 'matroska' else
    if s = '.mks' then s := 'matroska' else
    if s = '.m4a' then s := 'mp4' else
    if s = '.m4v' then s := 'mp4' else
    s := Copy(s, 2, Length(s));
  end;
  my1(cmbEncoderV, 'get_video.db');
  my1(cmbEncoderA, 'get_audio.db');
  my1(cmbEncoderS, 'get_subtitle.db');
  s := ' ' + s + ' ';
  if (cmbEncoderV.Items.Count > 0) then
  begin
    if (Pos(s, ' matroska mp4 mov ') > 0) then
      cmbEncoderV.Items.AddStrings([
       'iff(pos(codec_name,"h264 hevc")>0,"copy","libx264")'
      ,'iff(pos(codec_name,"h264 hevc")>0,"copy","libx265")'
      ,'iff(pos(codec_name,"h264 hevc")>0,"copy","h264_nvenc")'
      ,'iff(pos(codec_name,"h264 hevc")>0,"copy","hevc_nvenc")'
      {$IFDEF MSWINDOWS}
      ,'iff(pos(codec_name,"h264 hevc")>0,"copy","h264_qsv")'
      {$ELSE}
      ,'iff(pos(codec_name,"h264 hevc")>0,"copy","h264_vaapi")'
      {$ENDIF}
      ])
    else
    if (s = ' mp3 ') then
      cmbEncoderV.Items.Add('iff(pos(codec_name,"mjpeg")>0,"copy","")');
  end;
  if (cmbEncoderA.Items.Count > 0) then
  begin
    if (Pos(s, ' matroska mp4 mov ') > 0) then
      cmbEncoderA.Items.AddStrings([
       'iff(pos(codec_name,"ac3 mp3 aac")>0,"copy","aac")'
      ,'iff(pos(codec_name,"eac3 mp3 aac dts")>0,"copy","aac")'
      ])
    else
    if (s = ' mp3 ') then
      cmbEncoderA.Items.Add('iff(pos(codec_name,"mp3")>0,"copy","libmp3lame")');
  end;
  if (cmbEncoderS.Items.Count > 0) then
  begin
    if (Pos(s, ' matroska ') > 0) then
      cmbEncoderS.Items.Add('iff(pos(codec_name,"subrip ass webvtt")>0,"copy","srt")')
    else
    if (Pos(s, ' mp4 mov ') > 0) then
      cmbEncoderS.Items.Add('iff(pos(codec_name,"mov_text")>0,"copy","mov_text")');
  end;
  xmyInItems(cmbEncoderV);
  xmyInItems(cmbEncoderA);
  xmyInItems(cmbEncoderS);
end;

procedure TfrmGUIta.myMoveLi(lv: TListView; X, Y: integer); //drag and drop
var
  currentItem, nextItem, dragItem, dropItem: TListItem;
  i: integer;
  b: boolean;
begin
  dropItem := lv.GetItemAt(X, Y);
  currentItem := lv.Selected;
  b := lv.Selected.Checked;
  while currentItem <> nil do
  begin
    nextItem := nil;
    for i := 0 to lv.Items.Count - 1 do
      if (lv.Items[i].Selected) and (currentItem.Index <> i) then
      begin
        nextItem := lv.Items[i];
        break;
      end;
    if Assigned(dropItem) then
    begin
      dragItem := lv.Items.Insert(dropItem.Index);
      dragItem.Checked := b;
    end
    else
      dragItem := lv.Items.Add;
    dragItem.Assign(currentItem);
    currentItem.Free;
    currentItem := nextItem;
  end;
end;

function TfrmGUIta.myProfileRead(f: string; jo: TJob): boolean;
var
  s, t, u, v, lng: string;
  Ini: TMemIniFile;
  c: TCont;
  i, k, l, cv, ca, cs, cd: integer;
  ts: TTabSheet;
  b, bs: boolean;

  function myGetLngFromFNs(l: integer): string;
  var
    v, a: string;
    i: integer;
  begin
    Result := '';
    if Length(jo.f) = 0 then Exit;
    if (l < 0) or (l > High(jo.f)) then Exit;
    v := ExtractFileNameOnly(jo.f[0].getval(sMyInputFN));
    a := ExtractFileNameOnly(jo.f[l].getval(sMyInputFN));
    if Pos(v, a) = 1 then
    begin
      a := Trim(Copy(a, Length(v) + 2, Length(a)));
      for i := 1 to Length(a) do
        if a[i] in ['A'..'Z', 'a'..'z'] then
          Result += LowerCase(a[i])
        else
          Break;
    end;
  end;

  procedure my1;
  begin
    lng := c.getval('TAG:language');
    if (lng = '') and (l > 0) then
    begin
      lng := myGetLngFromFNs(l);
      if lng <> '' then
        c.setval('TAG:language', lng);
    end;
  end;

  procedure my2(wc: TWinControl);
  var
    i, j: integer;
  begin
    for i := 0 to wc.ControlCount - 1 do
    if wc.Controls[i] is TPanel then
      my2(TWinControl(wc.Controls[i]))
    else
    if wc.Controls[i] is TPageControl then
      for j := 0 to TPageControl(wc.Controls[i]).PageCount - 1 do
        my2(TPageControl(wc.Controls[i]).Pages[j])
    else
    begin
      v := wc.Controls[i].Name;
      s := Ini.ReadString(u, v, '');
      c.setval(v, s);
      if (s <> '') then b := True;
    end;
  end;

begin
  cv := -1;
  ca := -1;
  cs := -1;
  cd := -1;
  if f <> '' then myProfile2jo(f, jo);
  bs := jo.getval(sMySplitted) = '1';
  Ini := TMemIniFile.Create(TStringStream.Create(jo.getval(sMyProfile)));
  c := jo;
  u := '1';
  my2(TabOutput);
  for l := 0 to High(jo.f) do //read sets for every input file
  begin
    u := 'input' + IfThen(l > 0, IntToStr(l));
    i := l;
    while not Ini.SectionExists(u) and (i >= 0) do
    begin
      dec(i);
      u := 'input' + IfThen(i > 0, IntToStr(i));
    end;
    if not bs then
    begin
      jo.f[l].setval(cmbDurationss1.Name, Ini.ReadString(u, cmbDurationss1.Name, ''));
      jo.f[l].setval(cmbDurationt1.Name, Ini.ReadString(u, cmbDurationt1.Name, ''));
    end;
    jo.f[l].setval(cmbItsoffset.Name, Ini.ReadString(u, cmbItsoffset.Name, ''));
    //s := Ini.ReadString(u, cmbAddOptsI.Name, '');
    //if s <> '' then jo.f[l].setval(cmbAddOptsI.Name, s);
    //jo.f[l].setval(cmbAddOptsI.Name, Ini.ReadString(u, cmbAddOptsI.Name, ''));
    jo.f[l].setval(cmbAddOptsI1.Name, Ini.ReadString(u, cmbAddOptsI1.Name, ''));
    for k := 0 to High(jo.f[l].s) do //read stream sets
    begin
      c := jo.f[l].s[k];
      t := c.getval('codec_type');
      if t = 'video' then
      begin
        inc(cv);
        u := t + IfThen(cv > 0, IntToStr(cv));
        i := cv;
        while not Ini.SectionExists(u) and (i >= 0) do
        begin
          dec(i);
          u := t + IfThen(i > 0, IntToStr(i));
        end;
        ts := TabVideo;
      end
      else
      if t = 'audio' then
      begin
        inc(ca);
        u := t + IfThen(ca > 0, IntToStr(ca));
        i := ca;
        while not Ini.SectionExists(u) and (i >= 0) do
        begin
          dec(i);
          u := t + IfThen(i > 0, IntToStr(i));
        end;
        ts := TabAudio;
      end
      else
      if t = 'subtitle' then
      begin
        inc(cs);
        u := t + IfThen(cs > 0, IntToStr(cs));
        i := cs;
        while not Ini.SectionExists(u) and (i >= 0) do
        begin
          dec(i);
          u := t + IfThen(i > 0, IntToStr(i));
        end;
        ts := TabSubtitle;
      end
      else
      if t = 'data' then
      begin
        inc(cd);
        u := t + IfThen(cd > 0, IntToStr(cd));
        i := cd;
        while not Ini.SectionExists(u) and (i >= 0) do
        begin
          dec(i);
          u := t + IfThen(i > 0, IntToStr(i));
        end;
        ts := TabData;
      end
      else
        Continue;
      b := False;
      my2(ts);
      //check stream and metadata
      if t = 'video' then
      begin
        s := myCalcEncV(c);
        if s = '' then b := False;
        c.setval(edtEncoderV.Name, s);
        c.setval(edtBitrateV.Name, myCalcBRv(c));
        //my1;
        if b and ((cv = 0) or chkLangV1.Checked) then //1st or all
          c.setval(sMyChecked, '1')
        else
          c.setval(sMyChecked, '0');
      end
      else
      if t = 'audio' then
      begin
        s := myCalcEncA(c);
        if s = '' then b := False;
        c.setval(edtEncoderA.Name, s);
        c.setval(edtBitrateA.Name, myCalcBRa(c));
        my1;
        if b and ((ca = 0) or chkLangA1.Checked //1st or all or language
        or (chkLangA2.Checked and (lng <> '') and (Pos(LowerCase(lng) + ' ', LowerCase(cmbLangA.Text) + ' ') > 0))) then
          c.setval(sMyChecked, '1')
        else
          c.setval(sMyChecked, '0');
      end
      else
      if t = 'subtitle' then
      begin
        s := myCalcEncS(c);
        if s = '' then b := False;
        c.setval(edtEncoderS.Name, s);
        my1;
        if b and ((cs = 0) or chkLangS1.Checked //1st or all or language
        or (chkLangS2.Checked and (lng <> '') and (Pos(LowerCase(lng) + ' ', LowerCase(cmbLangS.Text) + ' ') > 0))) then
          c.setval(sMyChecked, '1')
        else
          c.setval(sMyChecked, '0');
      end;
    end;
  end;
  Ini.Free;
  Result := (cv >= 0) or (ca >= 0) or (cs >= 0) or (cd >= 0); //check job
  myTags(jo); //metadata
  jo.setval(edtOfn.Name, myGetOutputFN(jo));
end;

procedure TfrmGUIta.myParseIni(jo: TJob; l: integer; o: string);
var
  ini: TMemIniFile;
  sl, st: TStringList;
  s, v, a: string;
  i, j, k: integer;
  li: TListItem;
  bj: boolean;
  r: double;

  function my1(s: string): string;
  begin
    Result := StringsReplace(s, ['\:', '\r', '\n', '\#'], [':', #13, #10, '#'], [rfReplaceAll]);
  end;

begin
  if Length(jo.f) = 0 then Exit;
  if (l < 0) or (l > High(jo.f)) then Exit;
  sl := TStringList.Create;
  st := TStringList.Create;
  ini := TMemIniFile.Create(TStringStream.Create(o));
  ini.ReadSections(st);
  s := 'format';
  for j := 0 to st.Count - 1 do
  if Pos(s, st[j]) > 0 then
  begin
    v := st[j];
    a := Copy(v, Length(s) + 2, Length(st[j]));
    if a = 'tags' then a := 'TAG:';
    ini.ReadSection(v, sl);
    jo.f[l].setval('[' + v + '] begin', sdiv);
    for i := 0 to sl.Count - 1 do jo.f[l].setval(a + sl[i], my1(ini.ReadString(v, sl[i], '')));
    jo.f[l].setval('[' + v + '] end', sdiv);
  end;
  k := 0;
  s := 'streams.stream.' + IntToStr(k);
  while st.IndexOf(s) >= 0 do
  begin
    for j := 0 to st.Count - 1 do
    if Pos(s, st[j]) > 0 then
    begin
      v := st[j];
      if s = v then
      begin
        jo.f[l].AddStream;
        jo.AddMap(Format('%d:%d', [l, k]));
      end;
      if k <> High(jo.f[l].s) then Break;
      a := Copy(v, Length(s) + 2, Length(st[j]));
      if a = 'disposition'       then a := 'DISPOSITION:' else
      if a = 'tags'              then a := 'TAG:' else
      if Pos('side_data', a) > 0 then a := 'SIDE_DATA:';
      ini.ReadSection(v, sl);
      jo.f[l].s[k].setval('[' + v + '] begin', sdiv);
      for i := 0 to sl.Count - 1 do jo.f[l].s[k].setval(a + sl[i], my1(ini.ReadString(v, sl[i], '')));
      jo.f[l].s[k].setval('[' + v + '] end', sdiv);
    end;
    Inc(k);
    s := 'streams.stream.' + IntToStr(k);
  end;
  ini.Free;

  //metadata from avi //convert text encoding from ansi to utf8
  if (cmbMetadataCP.Text <> '') and (((cmbMetadataCPext.Text = '') and (Pos('�', o) > 0))
  or (Pos(LowerCase(ExtractFileExt(jo.f[l].getval(sMyInputFN))), cmbMetadataCPext.Text) > 0)) then
  begin
    a := cmbMetadataCP.Text;
    sl.Text := o;
    i := 0;
    k := -1;
    while i < sl.Count do
    begin
      s := sl[i];
      if (Pos('Stream #', s) > 2) then
      begin
        j := Pos(':', s);
        if j > 0 then
          k := myGetDigit0(Copy(s, j + 1, 4));
      end
      else
      if (Pos('Duration:', s) > 2) then
      begin
        jo.f[l].setval('Metadata:duration', Copy(s, 13, Length(s)));
      end
      else
      if (Length(s) > 0) and (s[1] = ' ') then
      begin
        s := LConvEncoding.ConvertEncoding(s, a, EncodingUTF8);
        j := Pos(':', s);
        v := Trim(Copy(s, 1, j - 1));
        s := Copy(s, j + 2, Length(s));
        if (k >= 0) and (k <= High(jo.f[l].s)) then
          jo.f[l].s[k].setval('Metadata:' + v, s)
        else
          jo.f[l].setval('Metadata:' + v, s);
      end;
      inc(i);
    end;
  end;
  sl.Free;
  st.Free;

  bj := myProfileRead('', jo); //read profile from saved profile.ini
  myGetss4Compare(jo);
  //add to listview or update listview item
  LVjobs.BeginUpdate;
  LVfiles.BeginUpdate;
  LVstreams.BeginUpdate;
  li := LVjobs.FindCaption(0, jo.getval(sMyIndex), False, True, False);
  if li = nil then
  begin
    li := LVjobs.Items.Add;
    li.ImageIndex := 0;
    li.Checked := bj;
    li.Caption := jo.getval(sMyIndex);                    //    number
    li.SubItems.Add(mes[33]); //added                     //0 - state
    s := jo.f[l].getval(sMyInputFN);
    li.SubItems.Add(myShrinkPath(s, LVjobs.Canvas, 555)); //1 - job name
    li.SubItems.Add(myGetFileSize(s));                    //2 - file size
    li.SubItems.Add(myCalcOutSize(jo));                   //3 - calculated output size
    s := jo.f[0].getval('duration');
    r := myTimeStrToReal(s);
    if r > 0 then s := myRealToTimeStr(r);
    li.SubItems.Add(s);                      //4 - duration
    DuraAll += r;
    inc(DuraAl2);
    myShowCaption('');
    myGetColumns56(jo, v, a);
    li.SubItems.Add(v);                      //5 - track infos
    li.SubItems.Add(a);                      //6 - track infos
    li.Data := Pointer(jo);
    if (LVjobs.Items.Count = 1) then
      LVjobs.Items[0].Selected := True;
  end
  else
  begin
    li.ImageIndex := 0;
    myGetColumns56(jo, v, a);
    li.SubItems[5] := v;
    li.SubItems[6] := a;
    li.Data := Pointer(jo);
  end;
  LVjobs.EndUpdate;
  LVfiles.EndUpdate;
  LVstreams.EndUpdate;
  if li.Selected then
    LVjobsSelectItem(nil, li, True);
end;

procedure TfrmGUIta.myTags(jo: TJob);
var
  s, t, u, v: string;
  l, k: integer;
  c: TCont;
  b0, b1: boolean;
begin
  b0 := jo.getval(chkMetadataGet.Name) = '1';
  b1 := jo.getval(chkMetadataGet1.Name) = '1';
  if jo.getval(chkMetadataGen.Name) = '1' then
  begin
    myGenTags(jo.getval(sMyOutputFNbak), s, v);
    if s <> '' then s := 'artist=' + s + LineEnding;
    jo.setval(memTagsOut.Name, s + 'title=' + v);
  end
  else
  if b0 then
  begin
    u := '';
    for l := 0 to High(jo.f) do
    begin
      for k := 0 to High(jo.f[l].sk) do
      begin
        s := jo.f[l].sk[k];
        v := jo.f[l].sv[k];
        if Pos('TAG:', s) = 1 then
        begin
          s := Copy(s, 5, Length(s));
          if Pos('�', v) > 0 then
            v := jo.f[l].getval('Metadata:' + s); //converted from ansi
          u += s + '=' + v;
          if (Length(v) > 0) and (v[Length(v)] <> #10) and (v[Length(v)] <> #13) then
            u += LineEnding;
        end;
      end;
    end;
    jo.setval(memTagsOut.Name, u);
  end
  else
    jo.setval(memTagsOut.Name,'');
  for l := 0 to High(jo.f) do
  for k := 0 to High(jo.f[l].s) do
  begin
    c := jo.f[l].s[k];
    t := c.getval('codec_type');
    if b0 then
    begin
      v := myGetTag(c, 'title');
      s := c.getval('TAG:language');
    end
    else
    if b1 then
    begin
      v := '';
      s := c.getval('TAG:language');
    end
    else
    begin
      v := '';
      s := '';
    end;
    if t = 'video' then
    begin
      c.setval(cmbTagTitleV.Name, v);
      c.setval(cmbTagLangV.Name, s);
    end
    else
    if t = 'audio' then
    begin
      c.setval(cmbTagTitleA.Name, v);
      c.setval(cmbTagLangA.Name, s);
    end
    else
    if t = 'subtitle' then
    begin
      c.setval(cmbTagTitleS.Name, v);
      c.setval(cmbTagLangS.Name, s);
    end;
  end;
end;

procedure TfrmGUIta.myGenTags(s: string; out a, t: string);
var
  i: integer;
begin
  i := Pos(' - ', s); //todo: regexp?
  if i > 0 then
  begin
    a := Copy(s, 1, i - 1);
    t := Copy(s, i + 3, Length(s));
  end
  else
  begin
    a := '';
    t := s;
  end;
end;

function TfrmGUIta.myGetTag(c: TCont; s: string): string;
var
  t: string;
begin
  Result := c.getval('TAG:' + s);
  if Pos('�', Result) > 0 then
  begin
    t := c.getval('Metadata:' + s);
    if t <> '' then Result := t;
  end;
end;

procedure TfrmGUIta.myGetColumns56(jo: TJob; out v, a: string);
var
  k, l: integer;
  t: string;
  c: TCont;
begin
  if jo.getval(chkMetadataGen.Name) = '1' then
    myGenTags(jo.getval(sMyOutputFNbak), v, a)
  else
  if (Length(jo.f) > 0) and (Pos(LowerCase(ExtractFileExt(jo.f[0].getval(sMyInputFN))), ' .mp3 .flac .m4a ') > 0) then
  begin
    v := myGetTag(jo.f[0], 'artist');
    a := myGetTag(jo.f[0], 'title');
  end
  else
  begin
    v := ''; a := '';
    for l := 0 to High(jo.f) do
    for k := 0 to High(jo.f[l].s) do
    begin
      c := jo.f[l].s[k];
      t := c.getval('codec_type');
      if t = 'video'    then v += myGetCaptionCont(c) + '; ' else
      if t = 'audio'    then a += myGetCaptionCont(c) + '; ';
    end;
  end;
end;

function TfrmGUIta.myGetInputFiles(jo: TJob; s: string; sl: TStrings): string;
var
  l: integer;

  procedure my3(l: integer);
  begin
    my2lst('-ss', jo.f[l].getval(cmbDurationss1.Name), sl);
    my2lst('-t', jo.f[l].getval(cmbDurationt1.Name), sl);
    my2lst('-itsoffset', jo.f[l].getval(cmbItsoffset.Name), sl);
    my2lst('', jo.f[l].getval(cmbAddOptsI.Name), sl);
    my2lst('', jo.f[l].getval(cmbAddOptsI1.Name), sl);
    my2lst('-i', jo.f[l].getval(sMyInputFN), sl);
  end;

begin
  if s = '' then
  begin
    Result := '';
    for l := 0 to High(jo.f) do
      my3(l);
  end
  else
  begin
    Result := myGetDigit2(s, l); //return stream number
    if (l >= 0) and (l <= High(jo.f)) then
      my3(l);
  end;
end;

function TfrmGUIta.myGetOutputFN(jo: TJob): string;
var
  s: string;
begin
  s := jo.getval(cmbRenameMask.Name);
  if s <> '' then
    s := myStrReplace(s, jo)
  else
    s := jo.getval(sMyOutputFNbak);
  Result := myGetOutFN(jo.getval(edtDirOut.Name), s, jo.getval(cmbExt.Name));
end;

procedure TfrmGUIta.myPlayOut(jo: TJob);
var
  s, t: string;
  sl: TStringList;
begin
  s := jo.getval(edtOfn.Name);
  if not myFileExists(s) then Exit;
  sl := TStringList.Create;
  t := myExpandFN(edtffplay.Text);
  if not chkPlayer2.Checked and not chkPlayer3.Checked and FileExistsUTF8(t) then
  begin
    sl.Add(t); sl.Add('-hide_banner');
    if chkffplayfs.Checked then sl.Add('-fs');
    if chkffplayexit.Checked then sl.Add('-autoexit');
    sl.Add(s);
    myTredExe2(False, sl, memConsole, 'p', edtffplay.Text + ' ' + s, swoShowNormal);
  end
  else
  if chkPlayer3.Checked and FileExistsUTF8(myExpandFN(cmbExtPlayer.Text)) then
  begin
    sl.Add(myExpandFN(cmbExtPlayer.Text));
    sl.Add(s);
    myTredExe2(False, sl, memConsole, 'p', cmbExtPlayer.Text + ' ' + s, swoShowNormal);
  end
  else
    OpenDocument(s);
  sl.Free;
end;

procedure TfrmGUIta.myTredExe1(mode: integer; m: TSynMemo; c, d: string);
var
  e: TThreadExec;
  li: TListItem;
begin
  e := TThreadExec.Create(mode, m);
  if Assigned(e.FatalException) then raise e.FatalException;
  e.OnTerminate := @onCnv3Terminate;
  e.Start;
  li := LVtrd.Items.Add;
  li.Caption := c;
  li.SubItems.Add(d);
  li.Data := Pointer(e);
  myError(0, 'myTredExe1: ' + d);
end;

procedure TfrmGUIta.myTredExe2(term: boolean; sl: TStringList; m: TSynMemo; c, d: string; swo: TShowWindowOptions = swoHIDE);
var
  e: TThreadExec;
  li: TListItem;
begin
  if d = '' then d := myList2Str(sl);
  e := TThreadExec.Create(term, sl, m, swo);
  if Assigned(e.FatalException) then raise e.FatalException;
  e.OnTerminate := @onCnv3Terminate;
  e.Start;
  li := LVtrd.Items.Add;
  li.Caption := c;
  li.SubItems.Add(d);
  li.Data := Pointer(e);
  myError(0, 'myTredExe2: ' + d);
end;

procedure TfrmGUIta.mylst2run(term: boolean; a: TStrings; run: TRun);
var
  l: integer;
begin
  if term then
  begin
    l := run.add(edtxterm.Text, []);
    process.CommandToList(edtxtermopts.Text, run.p[l].Parameters);
    if chkxtermwait.Checked then
    begin
      {$IFDEF MSWINDOWS}
      a.Add('&'); a.Add('pause');
      {$ELSE}
      a.Add(';'); a.Add('echo'); a.Add(chkxtermwait.Caption); a.Add(';'); a.Add('read'); a.Add('a');
      {$ENDIF}
    end;
    if chkxterm1str.Checked then
      run.p[l].Parameters.Add(myList2Str(a))
    else
      run.p[l].Parameters.AddStrings(a);
  end
  else
    run.add(a);
end;


procedure TfrmGUIta.myListBox1view(cmb: TComboBox);
var
  i: integer;
  pt: TPoint;
begin
  ListBox1.Items.Clear;
  if cmb = cmbProfile  then ListBox1.Tag := 1 else
  if cmb = cmbFormat   then ListBox1.Tag := 2 else
  if cmb = cmbExt      then ListBox1.Tag := 3 else
  if cmb = cmbEncoderV then ListBox1.Tag := 4 else
  if cmb = cmbEncoderA then ListBox1.Tag := 5;
  if cmb.Text = '' then
  begin
    if ListBox1.Visible then
      ListBox1.Items.AddStrings(cmb.Items);
  end
  else
  begin
    for i := 0 to cmb.Items.Count - 1 do
    if Pos(cmb.Text, cmb.Items[i]) > 0 then
    begin
      ListBox1.Items.Add(cmb.Items[i]);
    end;
    if ListBox1.Items.Count > 1 then
    begin
      pt := cmb.ClientToParent(TPoint.Create(0, 0), frmGUIta);
      ListBox1.Height := Min(pt.Y, Round(ListBox1.Canvas.TextHeight('X') * ListBox1.Items.Count * 1.3));
      ListBox1.Top := pt.Y - ListBox1.Height;
      ListBox1.Left := pt.X;
      ListBox1.Width := cmb.Width + 100;
      ListBox1.Selected[0] := True;
      ListBox1.Visible := True;
    end
    else
      ListBox1.Visible := False;
  end;
end;

function TfrmGUIta.myGetDuration(jo: TJob): double;
var
  l: integer;
  r1: double;
  function myDur1(l: integer): double;
  var
    rd, rt: double;
  begin
    rd := myTimeStrToReal(jo.f[l].getval('duration'));
    rd += myTimeStrToReal(jo.f[l].getval(cmbItsoffset.Name));
    rd -= myTimeStrToReal(jo.f[l].getval(cmbDurationss1.Name));
    rt := myTimeStrToReal(jo.f[l].getval(cmbDurationt1.Name));
    if (rt > 0) and (Pos('-loop 1', jo.f[l].getval(cmbAddOptsI.Name)) > 0) then Result := rt else
    if (rt > 0) and (rd > rt) then Result := rt else
    Result := rd;
  end;
begin
  Result := 0;
  for l := 0 to High(jo.f) do
  begin
    r1 := myDur1(l);
    if r1 > Result then Result := r1;
  end;
  myError(0, 'myGetDuration: ' + FloatToStr(Result));
end;

//------------------------------------------------------------------------------

procedure TfrmGUIta.btnAddFilesClick(Sender: TObject);
var
  od: TOpenDialog;
  i: integer;
  c: TCont;
begin
  od := TOpenDialog.Create(frmGUIta);
  od.Title := mes[49] + ' - ' + mes[0] + ' ' + TButton(Sender).Caption; //Open existing file - Video files
  od.InitialDir := myExtrDirExist(myExpandFN(cmbDirLast.Text, True));
  od.Filter := mes[0] + '|' + myGetExtsFromMasks + '|' + mes[29] + ' (' + AllFilesMask + ')|' + AllFilesMask; //Video files | All files
  od.Options := [ofEnableSizing, ofViewDetail, ofAllowMultiSelect, ofFileMustExist];
  if od.Execute then
  begin
    cmbDirLast.Text := ExtractFileDir(myUnExpandFN(od.FileName));
    c := TCont.Create;
    for i := 0 to od.Files.Count - 1 do
      c.addval(od.Files[i], myGetDirOut('', od.Files[i]));
    if (Sender = btnAddTracks)
    and (LVjobs.Selected <> nil) then myAdd2Job5(c, TJob(LVjobs.Selected.Data)) else
    if Sender = btnAddFiles1job  then myAdd_Job4(c) else
    if Sender = btnConcatFiles   then myAdd_Job7(c) else
    if Sender = btnConcat2Files  then myAdd_Job9(c) else
    if Sender = btnAddFileSplit  then myAddSplit(c) else
                                      myAddFiles(c);
    myAddStart;
    c.Free;
  end;
  od.Free;
end;

procedure TfrmGUIta.btnAddImageDirClick(Sender: TObject);
var
  od: TOpenDialog;
begin
  od := TOpenDialog.Create(frmGUIta);
  od.Title := mes[49] + ' - ' + btnAddImageDir.Caption; //Open existing file
  od.InitialDir := myExtrDirExist(myExpandFN(cmbDirLast.Text, True));
  od.Options := [ofEnableSizing, ofViewDetail, ofFileMustExist];
  if od.Execute then
  begin
    cmbDirLast.Text := myUnExpandFN(ExtractFileDir(od.FileName));
    myAdd_pics(od.FileName, '');
    myAddStart;
  end;
  od.Free;
end;

procedure myAddProtocols(s: TStrings);
begin
  frmGUIta.myFillSGin(s, '');
  s.Add('----------');
  s.Add('async:URL');
  s.Add('bluray:/mnt/bluray');
  s.Add('concat:URL1|URL2|...|URLN');
  s.Add('data:image/gif;base64,R0lGODdhCAAIAMIEAAAAAAAA//8AAP//AP///////////////ywAAAAACAAIAAADF0gEDLojDgdGiJdJqUX02iB4E8Q9jUMkADs=');
  s.Add('ftp://[user[:password]@]server[:port]/path/to/remote/resource.mpeg');
  s.Add('hls+http://host/path/to/remote/resource.m3u8');
  s.Add('hls+file://path/to/local/resource.m3u8');
  s.Add('http://server:port');
  s.Add('icecast://[username[:password]@]server:port/mountpoint');
  s.Add('mmsh://server[:port][/app][/playpath]');
  s.Add('pipe:0');
  s.Add('rtmp://[username:password@]server[:port][/app][/instance][/playpath]');
  s.Add('smb://[[domain:]user[:password@]]server[/share[/path[/file]]]');
  s.Add('sftp://[user[:password]@]server[:port]/path/to/remote/resource.mpeg');
  s.Add('-max_delay 500000 -rtsp_transport udp -i rtsp://server/video.mp4');
  s.Add('sctp://host:port[?options]');
  s.Add('udp://[multicast-address]:port');
  s.Add('----------');
  s.Add('-f alsa -i hw:0');
  s.Add('-f avfoundation -i "0:0"');
  s.Add('-format_code Hi50 -f decklink -i ''Intensity Pro''');
  s.Add('-f dshow -i video="Camera":audio="Microphone"');
  s.Add('-f fbdev -framerate 10 -i /dev/fb0');
  s.Add('-f gdigrab -framerate 6 -i desktop');
  s.Add('-f gdigrab -framerate 6 -offset_x 10 -offset_y 20 -video_size vga -i desktop');
  s.Add('-f iec61883 -i auto');
  s.Add('-f kmsgrab -i -');
  s.Add('-f lavfi color=c=pink');
  s.Add('-f libcdio -i /dev/sr0');
  s.Add('-f openal -i ''''');
  s.Add('-f oss -i /dev/dsp');
  s.Add('-f pulse -i default');
  s.Add('-f sndio -i /dev/audio0');
  s.Add('-f video4linux2 -framerate 30 -video_size hd720 -i /dev/video0');
  s.Add('-f x11grab -framerate 25 -video_size cif -i :0.0');
  s.Add('-f x11grab -framerate 25 -video_size cif -i :0.0+10,20');
  s.Add('----------');
  s.Add('-f lavfi -i buffer=width=320:height=240:pix_fmt=yuv410p:time_base=1/24:sar=1');
  s.Add('-f lavfi -i cellauto=f=pattern:s=200x400');
  s.Add('-f lavfi -i gradients=s=320x240');
  s.Add('-f lavfi -i mandelbrot=s=320x240');
  s.Add('-f lavfi -i mptestsrc=t=dc_luma');
  s.Add('-f lavfi -i frei0r_src=size=200x200:framerate=10:filter_name=partik0l:filter_params=1234');
  s.Add('-f lavfi -i life=f=pattern:s=300x300');
  s.Add('-f lavfi -i allrgb');
  s.Add('-f lavfi -i allyuv');
  s.Add('-f lavfi -i color=c=red@0.2:s=qcif:r=10');
  s.Add('-f lavfi -i haldclutsrc');
  s.Add('-f lavfi -i nullsrc=s=256x256,geq=random(1)*255:128:128');
  s.Add('-f lavfi -i pal75bars');
  s.Add('-f lavfi -i pal100bars');
  s.Add('-f lavfi -i rgbtestsrc');
  s.Add('-f lavfi -i smptebars');
  s.Add('-f lavfi -i smptehdbars');
  s.Add('-f lavfi -i testsrc');
  s.Add('-f lavfi -i testsrc2');
  s.Add('-f lavfi -i yuvtestsrc');
  s.Add('-f lavfi -i sierpinski');
  s.Add('----------');
  s.Add('-f lavfi -i abuffer=sample_rate=44100:sample_fmt=s16p:channel_layout=stereo');
  s.Add('-f lavfi -i aevalsrc=0');
  s.Add('-f lavfi -i aevalsrc="sin(440*2*PI*t):s=8000"');
  s.Add('-f lavfi -i afirsrc');
  s.Add('-f lavfi -i anullsrc=r=48000:cl=mono');
  s.Add('-f lavfi -i flite=text=''So fare thee well, poor devil of a Sub-Sub, whose commentator I am'':voice=slt');
  s.Add('-f lavfi -i anoisesrc=d=60:c=pink:r=44100:a=0.5');
  s.Add('-f lavfi -i hilbert');
  s.Add('-f lavfi -i sinc');
  s.Add('-f lavfi -i sine=f=220:b=4:d=5');
end;

procedure TfrmGUIta.btnAddProtocolClick(Sender: TObject);
var
  frmT: TfrmTrack;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmTrack, frmT);
  frmT.Font := frmGUIta.Font;
  frmT.Caption := btnAddProtocol.Caption;
  myAddProtocols(frmT.ComboBox1.Items);
  Screen.Cursor := crDefault;
  if frmT.ShowModal = mrOK then
  begin
    myAddFile1(frmT.ComboBox1.Text, myGetDirOut('', myGetDirTmp('') + 'tmp'));
    myAddStart;
  end;
  frmT.Free;
end;

procedure TfrmGUIta.btnAddScreenGrabClick(Sender: TObject);
var
  c: TCont;
begin
  if MessageDlg(mes[47], mtConfirmation, [mbYes, mbNo], 0) = mrYes then //Add screen capture job
  begin
    c := TCont.Create;
    myAdd_Job8(c, '');
    myAddStart;
    c.Free;
    PageControl1.ActivePage := TabConvJob;
  end;
end;

procedure TfrmGUIta.btnAddTrack1Click(Sender: TObject);
var
  frmT: TfrmTrack;
begin
  if LVjobs.Selected = nil then Exit;
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmTrack, frmT);
  frmT.Font := frmGUIta.Font;
  frmT.Caption := btnAddTrack1.Caption;
  myAddProtocols(frmT.ComboBox1.Items);
  Screen.Cursor := crDefault;
  if frmT.ShowModal = mrOK then
  begin
    myAdd2Job1(frmT.ComboBox1.Text, TJob(LVjobs.Selected.Data));
    myAddStart;
  end;
  frmT.Free;
end;

procedure TfrmGUIta.btnClearHistClick(Sender: TObject);
var
  i: integer;
begin
  i := StrToIntDef(cDefaultSets.getval(cmbRunCmd.Name), 0);
  while i < cmbRunCmd.Items.Count do
    cmbRunCmd.Items.Delete(i);
end;

procedure TfrmGUIta.btnCompareClick(Sender: TObject);
var
  jo: TJob;
  c: TCont;
  frmCompare: TfrmCompare;
  t, iv, ia, fv, fa, fn, map: string;
  k, l, nv, na: integer;
begin
  if not myFileExists(edtOfn.Text) then Exit;
  if myNoJo(jo) then Exit;
  iv := '';
  ia := '';
  fv := '';
  fa := '';
  nv := -1;
  na := -1;
  map := '';
  for l := 0 to High(jo.f) do
  for k := 0 to High(jo.f[l].s) do
  begin
    c := jo.f[l].s[k];
    if c.getval(sMyChecked) = '1' then
    begin
      t := c.getval('codec_type');
      if (t = 'video') and (iv = '') then
      begin
        nv := l;
        iv := IntToStr(k);
        fv := myGetFilter(jo, c, -1); //resize only filter
        if fv <> '' then fv := ' -filter:v "' + fv + '"';
      end
      else if (t = 'audio') and (ia = '') then
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
  fn := jo.f[l].getval(sMyInputFN);
  if not myFileExists(fn) then Exit;
  if iv <> '' then
  begin
    map := ' -map 0:' + iv;
    fa := '';
  end
  else if ia <> '' then
    fv := fa;
  Application.CreateForm(TfrmCompare, frmCompare);
  frmCompare.Font := frmGUIta.Font;
  frmCompare.SynMemo1.Font.Size := seFontSize.Value;
  frmCompare.Button1.Caption := mes[14]; //Source
  frmCompare.Button2.Caption := mes[15]; //Destination
  frmCompare.Button3.Caption := mes[16]; //Difference
  frmCompare.Button4.Caption := mes[44]; //Side by side
  frmCompare.b := False;
  frmCompare.Edit3.Text := fv + map;
  frmCompare.Edit4.Text := fa;
  frmCompare.Image1.Picture.Clear;
  frmCompare.Image2.Picture.Clear;
  frmCompare.Image3.Picture.Clear;
  frmCompare.Label1.Caption := fn;
  frmCompare.Label2.Caption := edtOfn.Text;
  if frmCompare.Edit1.Text <> jo.getval(sMyCompar1) then
    frmCompare.Edit1.Text := jo.getval(sMyCompar1)
  else
    frmCompare.Edit1Change(frmCompare.Edit1);
  if frmCompare.Edit2.Text <> jo.getval(sMyCompar2) then
    frmCompare.Edit2.Text := jo.getval(sMyCompar2)
  else
    frmCompare.Edit1Change(frmCompare.Edit2);
  frmCompare.Button4.Click;
  myFormPosLoad(frmCompare, cfg);
  frmCompare.ShowModal;
  myFormPosSave(frmCompare, cfg);
  jo.setval(sMyCompar1, frmCompare.Edit1.Text);
  jo.setval(sMyCompar2, frmCompare.Edit2.Text);
  frmCompare.Free;
end;

procedure TfrmGUIta.btnRunCmdClick(Sender: TObject);
var
  s, o: string;
  jo: TJob;
  sl: TStringList;
begin
  if LVjobs.Selected <> nil then
  begin
    jo := TJob(LVjobs.Selected.Data);
    s := myStrReplace(cmbRunCmd.Text, jo);
  end
  else
    s := myStrReplace(cmbRunCmd.Text);
  sl := TStringList.Create;
  process.CommandToList(s, sl);
  if chkRunInTerm.Checked then
    myTredExe2(True, sl, memConsole, 'r', '', swoShowNormal)
  else
  if chkRunInTred.Checked then
    myTredExe2(False, sl, memConsole, 'r', '', swoShowNormal)
  else
  begin
    myGetRunOut(s, o);
    memConsole.Text := o;
  end;
  sl.Free;
  if cmbRunCmd.Items.IndexOf(cmbRunCmd.Text) < 0 then
  begin
    cCmdIni.setval(cmbRunCmd.Text, '1');
    cmbRunCmd.Items.Add(cmbRunCmd.Text);
  end;
end;

procedure TfrmGUIta.btnCropClick(Sender: TObject);
var
  w, h, x, y: integer;
  jo: TJob;
  c: TCont;
  frmCrop: TfrmCrop;
  fn, str: string;
  sl: TStringList;
  s, t: string;

  procedure myGetWHXYcrop(v: TCont; var w, h, x, y: integer);
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
      Result := 'in_w=' + w1 + LineEnding
      + 'in_h=' + h1 + LineEnding
      + 'iw=' + w1 + LineEnding
      + 'ih=' + h1 + LineEnding
      + 'w=' + w2 + LineEnding
      + 'h=' + h2 + LineEnding
      + 'out_w=' + w2 + LineEnding
      + 'out_h=' + h2 + LineEnding
      + 'ow=' + w2 + LineEnding
      + 'oh=' + h2 + LineEnding
      + 'a=' + FloatToStr(iw / ih) + LineEnding
      + 'sar=' + FloatToStr(sar) + LineEnding
      + 'dar=' + FloatToStr(dar) + LineEnding
      + 'hsub=2' + LineEnding
      + 'vsub=1' + LineEnding
      //if pix_fmt=yuv420p
      + 'n=0' + LineEnding
      + 'pos=1' + LineEnding
      + 't=1' + LineEnding
      + 'x=' + IntToStr(x) + LineEnding
      + 'y=' + IntToStr(y) + LineEnding;
    end;

    procedure my2(s: string; var w, h, x, y: string);
    var
      SL: TStringList;
    begin
      SL := TStringList.Create;
      myStr2List(s, ':', SL);
      if SL.Count > 0 then w := SL.Strings[0];
      if SL.Count > 1 then h := SL.Strings[1];
      if SL.Count > 2 then x := SL.Strings[2];
      if SL.Count > 3 then y := SL.Strings[3];
      SL.Free;
    end;

  begin
    s := v.getval(cmbCrop.Name);
    if s = '' then
      Exit;
    iw := StrToIntDef(v.getval('width'), 0);
    ih := StrToIntDef(v.getval('height'), 0);
    sar := myValSAR(v.getval('sample_aspect_ratio'));
    if (sar = 0) then
      sar := 1;
    dar := myValSAR(v.getval('display_aspect_ratio'));
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
    my2(s, sw, sh, sx, sy);
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
    myError(0, Format('myGetWHXYcrop: %s crop %s %s=%d %s=%d x=%d y=%d vars=%s',
      [mes[55], s, mes[22], w, mes[23], h, x, y, vars]));
  end;

begin
  if myNoJoC(jo, c) then Exit;
  sl := TStringList.Create;
  sl.Add('-hide_banner');
  str := myGetInputFiles(jo, LVstreams.Selected.Caption, sl);
  if sl.Count > 0 then fn := sl[sl.Count - 1] else fn := '';
  if cmbCrop.Text = '' then
  begin
    Screen.Cursor := crHourGlass;
    sl.Add('-map'); sl.Add('0:' + str);
    sl.Add('-frames:v'); sl.Add('18');
    sl.Add('-filter:v'); sl.Add('framestep=150,cropdetect');
    sl.Add('-an');
    sl.Add('-f'); sl.Add('null');
    sl.Add('-y'); sl.Add(sDevNull);
    myGetRunOut(myExpandFN(edtffmpeg.Text), sl, s);
    sl.Clear;
    repeat
      t := myBetween(s, 'crop=', LineEnding);
      sl.Add(t);
    until t = '';
    sl.CustomSort(@myCompareWH);
    if sl.Count > 0 then
      cmbCrop.Text := sl[sl.Count - 1]
    else
      cmbCrop.Text := '';
    if chkDebug.Checked then
      memJournal.Lines.AddStrings(sl);
    Screen.Cursor := crDefault;
    xmyChange2v(cmbCrop);
  end;
  sl.Free;
  Application.CreateForm(TfrmCrop, frmCrop);
  frmCrop.Font := frmGUIta.Font;
  frmCrop.SynMemo1.Font.Size := seFontSize.Value;
  frmCrop.Edit1.Text := ' -map 0:' + str;
  frmCrop.Label2.Caption := fn;
  frmCrop.Edit2.Text := jo.getval(sMyCompar1);
  frmCrop.Show;
  frmCrop.Hide;
  w := 0; h := 0; x := 0; y := 0;
  myGetWHXYcrop(c, w, h, x, y);
  frmCrop.Caption := Format('%d:%d:%d:%d', [w, h, x, y]);
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
  myFormPosLoad(frmCrop, cfg);
  if frmCrop.ShowModal = mrOk then
  begin
    cmbCrop.Text := frmCrop.Caption;
    xmyChange2v(cmbCrop);
  end;
  myFormPosSave(frmCrop, cfg);
  frmCrop.Free;
end;

procedure TfrmGUIta.btnExtractTrackSClick(Sender: TObject);
var
  jo: TJob;
  c: TCont;
  s, t, str, fmt, ext, o: string;
  sd: TSaveDialog;
  sl: TStringList;
  function myCodec2Ext(s: string): string;
  begin
    if s = 'subrip' then Result := 'srt' else
                         Result := s;
  end;
begin
  if myNoJoC(jo, c) then Exit;
  sl := TStringList.Create;
  sl.Add(myExpandFN(edtffmpeg.Text)); sl.Add('-hide_banner');
  str := myGetInputFiles(jo, LVstreams.Selected.Caption, sl);
  sl.Add('-map'); sl.Add('0:' + str);
  sl.Add('-c'); sl.Add('copy');
  my2lst('-ss', jo.getval(cmbDurationss2.Name), sl);
  my2lst('-t', jo.getval(cmbDurationt2.Name), sl);
  //my2lst('-itsoffset', jo.getval(cmbItsoffset.Name), sl);
  if (sl.IndexOf('-ss') >= 0) or (sl.IndexOf('-t') >= 0) then begin sl.Add('-map_metadata'); sl.Add('-1'); end;
  o := jo.getval(sMyOutputFNbak);
  s := c.getval('TAG:language');
  if s <> '' then
  begin
    o += ' ' + s;
    s := myGetTag(c, 'title');
    if s <> '' then o += ' ' + s;
  end
  else
  begin
    t := c.getval('codec_type');
    if t = 'video'    then s := c.getval(cmbTagLangV.Name) else
    if t = 'audio'    then s := c.getval(cmbTagLangA.Name) else
    if t = 'subtitle' then s := c.getval(cmbTagLangS.Name) else
                           s := '';
    if s <> '' then o += ' ' + s;
  end;
  fmt := c.getval('codec_name');
  ext := '.' + myCodec2Ext(fmt);
  o := myGetOutFN(jo.getval(edtDirOut.Name), myValidFilename(o), ext);
  sd := TSaveDialog.Create(Self);
  sd.Title := fmt + ': ' + mes[48]; //Save file as
  sd.InitialDir := myExtrDirExist(ExtractFileDir(o));
  sd.Filter := mes[29] + ' (' + AllFilesMask + ')|' + AllFilesMask; //All files
  sd.FileName := o;
  if sd.Execute then
  begin
    sl.Add('-y'); sl.Add(sd.FileName);
    myTredExe2(chkxtermconv.Checked, sl, memConsole, 'x', '');
  end;
  sd.Free;
  sl.Free;
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

procedure TfrmGUIta.btnFindMediaInfoDllClick(Sender: TObject);
begin
  xmySelFile(edtMediaInfoDll);
end;

procedure TfrmGUIta.btnFindDirTmpClick(Sender: TObject);
begin
  xmySelDir(edtDirTmp);
end;

procedure TfrmGUIta.btnGenDBClick(Sender: TObject);
var
  frmGenDB: TfrmGenDB;
  i, j, e: integer;
  s, c, f, d, o, f2: string;
  sl: TStringList;
  Idv, Ida: TMemIniFile;
  only_text: string = ' ass jacosub lrc scc srt webvtt ffmetadata crc hash md5 framecrc framehash framemd5 uncodedframecrc ';
  only_audio: string = ' ac3 adts adx aiff alaw alsa amr aptx aptx_hd ast au caf daud dts eac3 f32be f32le f64be f64le g722 g723_1 g726 g726_le gsm pulse s16be s16le s24be s24le s32be s32le s8 truehd tta u16be u16le u24be u24le u32be u32le u8 voc w64 wav wv ';
  only_video: string = ' apng dirac dnxhd h261 h263 h264 mpeg1video mpeg2video rawvideo ';
  only_pic: string = ' gif ico image2 image2pipe mjpeg singlejpeg smjpeg webp ';
  other_fmt: string = ' null data fifo fifo_test tee yuv4mpegpipe ';
begin
  Application.CreateForm(TfrmGenDB, frmGenDB);
  frmGenDB.CheckListBox1.Items.AddStrings(cmbFormat.Items);
  frmGenDB.CheckListBox1.Items.Delete(0);
  myFormPosLoad(frmGenDB, cfg);
  if frmGenDB.ShowModal = mrOk then
  begin
    d := myGetDirTmp('');
    Idv := TMemIniFile.Create(sInidir + 'get_video.db');
    Ida := TMemIniFile.Create(sInidir + 'get_audio.db');
    //Ids := TMemIniFile.Create(sInidir + 'get_subtitle.db');
    sl := TStringList.Create;
    for i := 0 to frmGenDB.CheckListBox1.Items.Count - 1 do
    begin
      if frmGenDB.CheckListBox1.Checked[i] then
      begin
        f := frmGenDB.CheckListBox1.Items[i];
        if frmGenDB.CheckGroup1.Checked[0] then
        begin
          Idv.EraseSection(f);
          for j := 3 to cmbEncoderV.Items.Count - 1 do
          begin
            c := cmbEncoderV.Items[j];
            o := d + c + '.' + f;
            StatusBar1.SimpleText := o;
            Application.ProcessMessages;
            if Pos(' ' + f + ' ', only_text + only_audio + other_fmt) > 0 then
              Continue //skip no video formats
            else if f = 'mp3' then
              e := myGetRunOut(myExpandFN(edtffmpeg.Text), ['-v', 'error',
              '-f', 'lavfi', '-i', 'sine=d=1',
              '-i', 'data:image/gif;base64,R0lGODdhCAAIAMIEAAAAAAAA//8AAP//AP///////////////ywAAAAACAAIAAADF0gEDLojDgdGiJdJqUX02iB4E8Q9jUMkADs=',
              '-c:a', 'libmp3lame', '-c:v', c, '-map', '0:0', '-map', '1:0', '-f', f, '-y', o], s)
            else if f = 'flac' then
            begin
              if not FileExistsUTF8(d + '1tmp.mp3') then
              myGetRunOut(myExpandFN(edtffmpeg.Text), ['-v', 'error',
              '-f', 'lavfi', '-i', 'sine=d=1',
              '-i', 'data:image/gif;base64,R0lGODdhCAAIAMIEAAAAAAAA//8AAP//AP///////////////ywAAAAACAAIAAADF0gEDLojDgdGiJdJqUX02iB4E8Q9jUMkADs=',
              '-c:a', 'libmp3lame', '-c:v', 'mjpeg', '-map', '0:0', '-map', '1:0', '-f', 'mp3', '-y', d + '1tmp.mp3'], s);
              e := myGetRunOut(myExpandFN(edtffmpeg.Text), ['-v', 'error',
              '-i', d + '1tmp.mp3',
              '-c:a', 'flac', '-c:v', c, '-f', f, '-y', o], s);
            end
            else if Pos(' ' + f + ' ', only_pic) > 0 then
              e := myGetRunOut(myExpandFN(edtffmpeg.Text), ['-v', 'error',
              '-i', 'data:image/gif;base64,R0lGODdhCAAIAMIEAAAAAAAA//8AAP//AP///////////////ywAAAAACAAIAAADF0gEDLojDgdGiJdJqUX02iB4E8Q9jUMkADs=',
              '-c:v', c, '-f', f, '-y', o], s)
            else
              e := myGetRunOut(myExpandFN(edtffmpeg.Text), ['-v', 'error',
              '-f', 'lavfi', '-i', 'testsrc=d=2:s=176x144:r=2',
              '-c:v', c, '-f', f, '-y', o], s);
            if e = 0 then
            begin
              e := myGetRunOut(myExpandFN(edtffprobe.Text), ['-v', 'error', '-select_streams', 'v:0',
              '-show_entries', 'stream=codec_name,codec_type,width',
              '-of', 'default=noprint_wrappers=1', o], s);
              if chkDebug.Checked then memJournal.Lines.Add(s);
              if (e = 0) and (Pos('unknown', s) = 0) and (Pos('rawvideo', s) = 0)
              and (Pos('codec_type=video', s) > 0) and (Pos('width=0', s) = 0) then
                Idv.WriteString(f, c, '')
              else
                if e = 0 then e := -1;
            end;
            if (e <> 0) and FileExistsUTF8(o) then DeleteFileUTF8(o);
          end;
        end;
        if frmGenDB.CheckGroup1.Checked[1] then
        begin
          Ida.EraseSection(f);
          for j := 3 to cmbEncoderA.Items.Count - 1 do
          begin
            c := cmbEncoderA.Items[j];
            o := d + c + '.' + f;
            StatusBar1.SimpleText := o;
            Application.ProcessMessages;
            if Pos(' ' + f + ' ', only_text + only_video + only_pic + other_fmt) > 0 then
              Continue //skip no sound formats
            else
              e := myGetRunOut(myExpandFN(edtffmpeg.Text), ['-v', 'error',
              '-f', 'lavfi', '-i', 'sine=d=1',
              '-c:a', c, '-f', f, '-y', o], s);
            if e = 0 then
            begin
              e := myGetRunOut(myExpandFN(edtffprobe.Text), ['-v', 'error', '-select_streams', 'a:0',
              '-show_entries', 'stream=codec_name,codec_type',
              '-show_entries', 'format=format_name,duration',
              '-of', 'default=noprint_wrappers=1', o], s);
              if chkDebug.Checked then memJournal.Lines.Add(s);
              f2 := s;
              f2 := myBetween(f2, 'format_name=', LineEnding);
              if (e = 0) and (Pos('duration=N/A', s) = 0) and (Pos(f, f2) > 0) and (Pos('codec_type=audio', s) > 0) then
                Ida.WriteString(f, c, '')
              else
                if e = 0 then e := -1;
            end;
            if (e <> 0) and FileExistsUTF8(o) then DeleteFileUTF8(o);
          end;
        end;
      end;
    end;
    sl.Free;
    Idv.Free;
    Ida.Free;
    //Ids.Free;
    StatusBar1.SimpleText := mes[30] + ': ' + mes[34]; //'Process: completed';
  end;
  myFormPosSave(frmGenDB, cfg);
  frmGenDB.Free;
end;

procedure TfrmGUIta.btnLanguageClick(Sender: TObject);
begin
  if not FileExistsUTF8(sInidir + cmbLanguage.Text) then
  begin
    if MessageDlg(mes[12] + ' "' + cmbLanguage.Text + '" ' + mes[13], //file not found, create new?
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      myLanguage(False)
    else
      Exit;
  end;
  myOpenDoc(sInidir + cmbLanguage.Text);
end;

procedure TfrmGUIta.btnLogClearClick(Sender: TObject);
begin
  memConsole.Lines.Clear;
end;

procedure TfrmGUIta.btnLogSaveClick(Sender: TObject);
var
  i: integer;
  sd: TSaveDialog;
  ext: string = '.log';
begin
  sd := TSaveDialog.Create(Self);
  sd.Title := mes[48]; //Save file as
  sd.InitialDir := myExtrDirExist(myExpandFN(edtDirOut.Text, True));
  sd.Filter := '*.' + ext + '|*.' + ext + '|' + mes[29] + ' (' + AllFilesMask + ')|' + AllFilesMask; //All files
  sd.DefaultExt := ext;
  i := 0;
  repeat
    Inc(i);
    sd.FileName := IntToStr(i) + ext;
  until not FileExistsUTF8(AppendPathDelim(sd.InitialDir) + sd.FileName);
  if sd.Execute then
  try
    memConsole.Lines.SaveToFile(sd.FileName);
  except
    on E: Exception do myError(-1, 'btnLogSaveClick: ' + mes[56] + ' - ' + sd.FileName + ' ' + E.Message); //cant save to file
  end;
  sd.Free;
end;

procedure TfrmGUIta.btnMaskAddClick(Sender: TObject);
var
  li: TListItem;
  frmM: TfrmMaskProf;
begin
  Application.CreateForm(TfrmMaskProf, frmM);
  frmM.Font := frmGUIta.Font;
  frmM.Caption := btnMaskAdd.Caption;
  frmM.ComboBox1.Text := '';
  frmM.ComboBox2.Text := '';
  frmM.ComboBox3.Text := '';
  if frmM.ComboBox3.Items.Count = 0 then
    btnProfileGetItemsClick(nil);
  frmM.ComboBox3.Items.AddStrings(cmbProfile.Items);
  if frmM.ShowModal = mrOk then
  begin
    LVmasks.BeginUpdate;
    li := LVmasks.Items.Add;
    li.Checked := True;
    li.Caption := frmM.ComboBox1.Text;
    li.SubItems.Add(frmM.ComboBox2.Text);
    li.SubItems.Add(frmM.ComboBox3.Text);
    LVmasks.EndUpdate;
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
  frmM.Font := frmGUIta.Font;
  frmM.Caption := btnMaskEdit.Caption;
  frmM.ComboBox1.Text := LVmasks.Selected.Caption;
  frmM.ComboBox2.Text := LVmasks.Selected.SubItems[0];
  frmM.ComboBox3.Text := LVmasks.Selected.SubItems[1];
  if frmM.ComboBox3.Items.Count = 0 then
    btnProfileGetItemsClick(nil);
  frmM.ComboBox3.Items.AddStrings(cmbProfile.Items);
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
  LVmasks.BeginUpdate;
  LVmasks.Clear;
  li := LVmasks.Items.Add;
  li.Checked := True;
  li.Caption := '*';
  li.SubItems.Add('.avi;.vob;.mp*g;.mp4;.mov;.3gp;.3g2;.asf;.wmv');
  li.SubItems.Add('libx264 slow crf 18-aac-matroska.ini');
  li := LVmasks.Items.Add;
  li.Checked := True;
  li.Caption := '*';
  li.SubItems.Add('.jp*g;.png');
  li.SubItems.Add('photo to webp.ini');
  li := LVmasks.Items.Add;
  li.Checked := True;
  li.Caption := '*';
  li.SubItems.Add('.mp3;.flac');
  li.SubItems.Add('sound copy to mp3.ini');
  LVmasks.EndUpdate;
end;

procedure TfrmGUIta.btnMediaInfo1Click(Sender: TObject);
var
  s, t, fn: string;
  l: integer;
  sl: TStringList;
  h: cardinal;
  jo: TJob;
begin
  if myNoJo(jo) then Exit;
  if Sender = btnMediaInfo2 then
    fn := edtOfn.Text
  else
  begin
    if LVfiles.Selected <> nil then
      l := StrToIntDef(LVfiles.Selected.Caption, 0)
    else
      l := 0;
    if (l < 0) or (l > High(jo.f)) then Exit;
    fn := jo.f[l].getval(sMyInputFN);
  end;
  if chkMediaInfoDll.Checked then
  begin
    t := myExpandFN(edtMediaInfoDll.Text);
    if not MediaInfoDLL_Load(t) then
      MessageDlg(mes[20] + ' ' + edtMediaInfoDll.Text, mtError, [mbOK], 0) //Find file
    else
    begin
      h := MediaInfo_New();
      try
        try
          myMI_Open(h, fn);
          sl := TStringList.Create;
          sl.Text := myMI_Inform(h, 0);
          memMediaInfo.Clear;
          memMediaInfo.Lines.Add(t + ' ' + fn);
          memMediaInfo.Lines.AddStrings(sl);
          sl.Free;
          TabMediaInfo.TabVisible := True;
          PageControl1.ActivePage := TabMediaInfo;
        except
          on E: Exception do myError(-1, 'btnMediaInfo1Click: ' + E.Message);
        end;
      finally
        MediaInfo_Close(h);
      end;
    end;
  end
  else
  begin
    s := myExpandFN(edtMediaInfo.Text);
    if chkMediaInfoIsCli.Checked then
    begin
      myGetRunOut(s, [fn], t);
      memMediaInfo.Text := t;
      TabMediaInfo.TabVisible := True;
      PageControl1.ActivePage := TabMediaInfo;
    end
    else
    if myFileExists(s) then
    begin
      sl := TStringList.Create;
      sl.Add(s);
      sl.Add(fn);
      {$IFDEF MSWINDOWS}
      myExecProc(sl);
      {$ELSE}
      myTredExe2(False, sl, memConsole, 'i', '');
      {$ENDIF}
      sl.Free;
    end;
  end;
end;

procedure TfrmGUIta.btnFindOfnClick(Sender: TObject);
var
  sd: TSaveDialog;
begin
  sd := TSaveDialog.Create(Self);
  sd.Title := mes[48]; //Save file as
  sd.InitialDir := myExtrDirExist(ExtractFileDir(edtOfn.Text));
  sd.Filter := mes[29] + ' (' + AllFilesMask + ')|' + AllFilesMask; //All files
  sd.FileName := ExtractFileName(edtOfn.Text);
  if sd.Execute then
  begin
    edtOfn.Text := sd.FileName;
    xmyChange0(edtOfn);
  end;
  sd.Free;
end;

procedure TfrmGUIta.btnPlayOutClick(Sender: TObject);
var
  jo: TJob;
begin
  if myNoJo(jo) then Exit;
  myPlayOut(jo);
end;

procedure TfrmGUIta.btnProfileGetItemsClick(Sender: TObject);
var
  sl: TStringList;
begin
  Screen.Cursor := crHourGlass;
  cmbProfile.Items.Clear;
  cmbProfile.Items.Add(mes[52]); //(default)
  cmbProfile.Items.Add(mes[53]); //(screengrab)
  sl := TStringList.Create;
  myGetFileList(sInidir, '*.ini', sl, False, False, False);
  sl.Sort;
  cmbProfile.Items.AddStrings(sl);
  sl.Free;
  if chkDebug.Checked then memJournal.Lines.Add('btnProfileGetItemsClick: found ' + IntToStr(cmbProfile.Items.Count) + ' profiles');
  Screen.Cursor := crDefault;
end;

procedure TfrmGUIta.btnProfileSaveAsClick(Sender: TObject);
var
  Ini: TMemIniFile;
  sd: TSaveDialog;
  jo: TJob;
  c: TCont;
  s, t, u: string;
  k, l, cv, ca, cs, cd: integer;
begin
  if not myDirExists(sInidir, '') then Exit;
  if myNoJo(jo) then
  begin
    PageControl2.ActivePage := TabInput;
    PageControl2.ActivePage := TabVideo;
    PageControl2.ActivePage := TabAudio;
    PageControl2.ActivePage := TabSubtitle;
    PageControl2.ActivePage := TabData;
    PageControl2.ActivePage := TabOutput;
    s := edtEncoderV.Text
    + IfThen(cmbPreset.Text <> '', ' ' + cmbPreset.Text)
    + IfThen(cmbTune.Text <> '', ' ' + cmbTune.Text)
    + IfThen(cmbcrfv.Text <> '', ' crf ' + cmbcrfv.Text)
    + IfThen(cmbcqV.Text <> '', ' cq ' + cmbcqV.Text)
    + IfThen(cmbPass.Text <> '', ' ' + cmbPass.Text + 'pass')
    + IfThen(edtEncoderA.Text <> '', '-' + edtEncoderA.Text)
    + IfThen(cmbFormat.Text <> '', '-' + cmbFormat.Text,
     IfThen(cmbExt.Text <> '', '-' + Copy(cmbExt.Text, 2, Length(cmbExt.Text))))
    + '.ini';
  end
  else
  begin
    s := '';
    l := 0;
    //for l := 0 to High(jo.f) do
    for k := 0 to High(jo.f[l].s) do
    begin
      c := jo.f[l].s[k];
      t := c.getval('codec_type');
      if t = 'video' then
      begin
        t := c.getval(edtEncoderV.Name);
        if t <> '' then s += t;
        t := c.getval(cmbPreset.Name);
        if t <> '' then s += ' ' + t;
        t := c.getval(cmbTune.Name);
        if t <> '' then s += ' ' + t;
        t := c.getval(cmbcrfv.Name);
        if t <> '' then s += ' -crf ' + t;
        t := c.getval(cmbcqV.Name);
        if t <> '' then s += ' -cq ' + t;
        t := c.getval(cmbPass.Name);
        if t <> '' then s += ' ' + t + 'pass';
      end;
      if t = 'audio' then
      begin
        t := c.getval(edtEncoderA.Name);
        if t <> '' then s += '-' + t;
      end;
    end;
    t := jo.getval(cmbFormat.Name);
    if t <> '' then s += '-' + t;
    t := jo.getval(cmbExt.Name);
    if t <> '' then s += '-' + Copy(t, 2, Length(t));
  end;
  sd := TSaveDialog.Create(Self);
  sd.Title := mes[48]; //Save file as
  sd.InitialDir := sInidir;
  sd.Filter := '*.ini|*.ini|' + mes[29] + ' (' + AllFilesMask + ')|' + AllFilesMask; //All files
  sd.DefaultExt := '.ini';
  sd.FileName := s;
  if sd.Execute then
  begin
    if FileExistsUTF8(sd.FileName) then
    begin
      if MessageDlg(mes[57] + ' ' + sd.FileName, mtConfirmation, [mbOK, mbCancel], 0) = mrOK then //File exists, overwrite?
        DeleteFileUTF8(sd.FileName)
      else
        Exit;
    end;
    Ini := TMemIniFile.Create(sd.FileName);
    if jo = nil then
    begin
      mySet1(Ini, '1', [TabOutput], False);
      mySet1(Ini, 'input', [TabInput], False);
      mySet1(Ini, 'video', [TabVideo], False);
      mySet1(Ini, 'audio', [TabAudio], False);
      mySet1(Ini, 'subtitle', [TabSubtitle], False);
      mySet1(Ini, 'data', [TabData], False);
    end
    else
    begin
      cv := -1; ca := -1; cs := -1; cd := -1;
      mySaveCont(Ini, '1', [TabOutput], jo);
      for l := 0 to High(jo.f) do
      begin
        u := 'input' + IfThen(l > 0, IntToStr(l));
        mySaveCont(Ini, u, [TabInput], jo.f[l]);
        for k := 0 to High(jo.f[l].s) do
        begin
          c := jo.f[l].s[k];
          t := c.getval('codec_type');
          if t = 'video' then
          begin
            inc(cv);
            u := t + IfThen(cv > 0, IntToStr(cv));
            mySaveCont(Ini, u, [TabVideo], c);
          end
          else
          if t = 'audio' then
          begin
            inc(ca);
            u := t + IfThen(ca > 0, IntToStr(ca));
            mySaveCont(Ini, u, [TabAudio], c);
          end
          else
          if t = 'subtitle' then
          begin
            inc(cs);
            u := t + IfThen(cs > 0, IntToStr(cs));
            mySaveCont(Ini, u, [TabSubtitle], c)
          end
          else
          if t = 'data' then
          begin
            inc(cd);
            u := t + IfThen(cd > 0, IntToStr(cd));
            mySaveCont(Ini, u, [TabData], c);
          end;
        end;
      end;
    end;
    Ini.Free;
    cmbProfile.Items.Clear;
    myOpenDoc(sd.FileName);
    btnProfileGetItemsClick(nil);
    cmbProfile.Text := ExtractFileName(sd.FileName);
    xmyChange0(cmbProfile);
  end;
  sd.Free;
end;

procedure TfrmGUIta.btnRereadInfoClick(Sender: TObject);
var
  jo: TJob;
  l: integer;
  s: string;
begin
  if myNoJo(jo) then Exit;
  if (LVfiles.Selected = nil) then Exit;
  l := StrToIntDef(LVfiles.Selected.Caption, 0);
  if (l < 0) or (l > High(jo.f)) then Exit;
  Screen.Cursor := crHourGlass;
  myGetRunOut(myExpandFN(edtffprobe.Text), ['-hide_banner', '-show_format', '-show_streams', '-print_format', 'ini', '-i', jo.f[l].getval(sMyInputFN)], s);
  myParseIni(jo, l, s);
  LVjobsSelectItem(Sender, LVjobs.Selected, True);
  Screen.Cursor := crDefault;
end;

procedure TfrmGUIta.btnResetClick(Sender: TObject);
{$IFNDEF MSWINDOWS}
var
  s: string;
  i: integer;
{$ENDIF}

  procedure myDefaultLoad;
  var
    i: integer;
    procedure my2(c: TComponent);
    var
      i: integer;
    begin
      if (c is TComboBox) or (c is TCheckBox) or (c is TSpinEdit) or (c is TColorButton) then
        mySet2(c, cDefaultSets.getval(c.Name))
      else if c is TPanel then
        for i := 0 to TPanel(c).ControlCount - 1 do
          my2(TPanel(c).Controls[i])
      else if c is TPageControl then
        for i := 0 to TPageControl(c).PageCount - 1 do
          my2(TPageControl(c).Pages[i]);
    end;
  begin
    for i := 0 to TabSets1.ControlCount - 1 do
      my2(TabSets1.Controls[i]);
    for i := 0 to TabSets2.ControlCount - 1 do
      my2(TabSets2.Controls[i]);
    for i := 0 to TabScreenGrab.ControlCount - 1 do
      my2(TabScreenGrab.Controls[i]);
    for i := 0 to TabColors.ControlCount - 1 do
      my2(TabColors.Controls[i]);
  end;

  {$IFDEF MSWINDOWS}
  function myGetUserDir(dir: string): string;
  var
    Path: Array[0..MaxPathLen] of WideChar; //Allocate memory
  begin
    Path := '';
    if dir = 'VIDEOS' then
      SHGetSpecialFolderPathW(0, Path, CSIDL_MYVIDEO, false);
    Result := Path;
  end;
  {$ELSE}
  function myGetUserDir(dir: string): string;
  var
    s, o: string;
  begin
    Result := '';
    s := FindDefaultExecutablePath('xdg-user-dir');
    if not myFileExists(s) then Exit;
    if myGetRunOut(s, [dir], o) = 0 then
      Result := myUnExpandFN(Trim(o));
  end;
  {$ENDIF}

  procedure myGetTerminal;
  begin
    edtxtermGetItems(edtxterm);
    if edtxterm.Items.Count > 0 then
    begin
      edtxterm.ItemIndex := 0;
      edtxtermSelect(nil);
    end;
  end;

begin
  Screen.Cursor := crHourGlass;
  if Sender = btnReset then myDefaultLoad;
  if not FileExistsUTF8(myExpandFN(edtxterm.Text)) then myGetTerminal;
  myFindFiles(sDirApp, edtffmpeg.Text, edtffmpeg);
  myFindFiles(sDirApp, edtffprobe.Text, edtffprobe);
  myFindFiles(sDirApp, edtffplay.Text, edtffplay);
  myFindMediaInfo(True);
  myFindPlayers(True);
  edtDirOut.Text := myGetUserDir('VIDEOS');
  btnProfileGetItemsClick(nil);
  if cmbProfile.Items.Count > 0 then cmbProfile.ItemIndex := 0;
  //screen grab, fill items
  myFillSGin(cmbSGsource0.Items, 'video');
  myFillSGin(cmbSGsource2.Items, 'audio');
  cmbSGsource1.Items.AddStrings(cmbSGsource0.Items, True);
  cmbSGsource3.Items.AddStrings(cmbSGsource2.Items, True);
  //set defaults
  if cmbSGsource0.Items.Count > 0 then cmbSGsource0.ItemIndex := 0;
  if cmbSGsource1.Items.Count > 1 then cmbSGsource1.ItemIndex := 1;
  {$IFDEF MSWINDOWS}
  if cmbSGsource2.Items.Count > 0 then cmbSGsource2.ItemIndex := 0;
  if cmbSGsource3.Items.Count > 1 then cmbSGsource3.ItemIndex := 1;
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
  Screen.Cursor := crDefault;
end;

procedure TfrmGUIta.btnSaveCmdlineClick(Sender: TObject);
var
  sd: TSaveDialog;
  ext: string = {$IFDEF MSWINDOWS}'.bat'{$ELSE}'.sh'{$ENDIF};
  i: integer;
begin
  sd := TSaveDialog.Create(Self);
  sd.Title := mes[48]; //Save file as
  sd.InitialDir := myExtrDirExist(myExpandFN(edtDirOut.Text, True));
  sd.Filter := '*' + ext + '|*' + ext + '|' + mes[29] + ' (' + AllFilesMask + ')|' + AllFilesMask; //All files
  sd.DefaultExt := ext;
  i := 0;
  repeat
    Inc(i);
    sd.FileName := IntToStr(i) + ext;
  until not FileExistsUTF8(AppendPathDelim(sd.InitialDir) + sd.FileName);
  if sd.Execute then
  begin
    {$IFDEF MSWINDOWS}
    with TStringList.Create do
    try
      try
        Text := memCmdlines.Lines.Text;
        SaveToFile(sd.FileName);
      except
        on E: Exception do myError(-1, 'btnSaveCmdlineClick: cant save to file - ' + sd.FileName + ' ' + E.Message);
      end;
    finally
      Free;
    end;
    {$ELSE}
    try
      memCmdlines.Lines.SaveToFile(sd.FileName);
    except
      on E: Exception do myError(-1, 'btnSaveCmdlineClick: cant save to file - ' + sd.FileName + ' ' + E.Message);
    end;
    {$ENDIF}
  end;
  sd.Free;
end;

procedure TfrmGUIta.btnSaveSetsClick(Sender: TObject);
begin
  mySets(False);
  myHistory(False);
end;

procedure TfrmGUIta.btnStartClick(Sender: TObject);
var
  i, iMax: integer;
  t: TTabSheet;
  m: TSynMemo;
begin
  if LVtrd.Items.Count > 0 then Exit;
  if btnSuspend.Tag = 2 then
  begin
    btnSuspendClick(Sender);
    Exit;
  end;
  myBusy(False);
  myChkCpuCount;
  iMax := 0;
  for i := 0 to LVjobs.Items.Count - 1 do
    if LVjobs.Items[i].Checked then
    begin
      inc(iMax);
      if iMax >= spnCpuCount.Value then Break;
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
      t.Caption := mes[30] + ' ' + IntToStr(i + 1); //Process
      m := TSynMemo.Create(t);
      m.Parent := t;
      m.Align := alClient;
      m.Color := clWindow;
      m.Font.Color := clWindowText;
      m.Font.Size := seFontSize.Value;
      m.Highlighter := SynUNIXShellScriptSyn1;
    end;
    myTredExe1(0, m, 'c', mes[38]); //convert
    Sleep(2);
  end;
  PageControl3.ActivePageIndex := PageControl3.PageCount - 1;
  myBusy(True);
end;

procedure TfrmGUIta.btnStopClick(Sender: TObject);
var
  i, j: integer;
  s: string;
  e: TThreadExec;
begin
  if LVtrd.Items.Count = 0 then Exit;
  myBusy(False);
  if btnSuspend.Tag <> 0 then
  begin
    btnSuspend.Tag := 0;
    btnSuspend.Caption := mes[45]; //Pause
  end;
  for i := 0 to LVtrd.Items.Count - 1 do
  begin
    e := TThreadExec(LVtrd.Items[i].data);
    if e <> nil then
    begin
      e.p.Resume;
      if Pos('ffmpeg', e.p.Executable) > 0 then
      begin
        s := 'q';
        e.p.Input.Write(s[1], Length(s));
        j := 0;
        while e.p.Running and (j < 100) do
        begin
          Sleep(100);
          inc(j)
        end;
      end;
      e.Terminate;
      if e.p <> nil then
        e.p.Terminate(-2);
    end;
  end;
  myBusy(True);
end;

procedure TfrmGUIta.btnSuspendClick(Sender: TObject);
var
  i: integer;
  e: TThreadExec;
begin
  if LVtrd.Items.Count = 0 then Exit;
  myBusy(False);
  if btnSuspend.Tag = 0 then
  begin
    btnSuspend.Tag := 2;
    btnSuspend.Caption := mes[46]; //Resume
  end
  else
  begin
    btnSuspend.Tag := 0;
    btnSuspend.Caption := mes[45]; //Pause
  end;
  for i := 0 to LVtrd.Items.Count - 1 do
  begin
    e := TThreadExec(LVtrd.Items[i].data);
    if (e <> nil) and (e.p <> nil) then
      if btnSuspend.Tag = 0 then
        e.p.Resume
      else
        e.p.Suspend;
  end;
  myBusy(True);
end;

procedure TfrmGUIta.btnTestClick(Sender: TObject);
var
  li: TListItem;
begin
  if LVjobs.Selected = nil then Exit;
  li := LVtrd.FindCaption(0, 't', False, True, False);
  if li <> nil then Exit;
  myBusy(False);
  myTredExe1(1, SynMemo5, 't', mes[39]); //test
  TabConsole3.TabVisible := True;
  if chkDebug.Checked then
  PageControl1.ActivePage := TabConsole;
  PageControl3.ActivePage := TabConsole3;
  myBusy(True);
end;

procedure TfrmGUIta.btnTestFiltersOClick(Sender: TObject);
begin
  if LVjobs.Selected = nil then Exit;
  myBusy(False);
  myTredExe1(4, memConsole, 'f', btnTestFiltersO.Caption);
  PageControl3.ActivePage := TabConsole1;
  myBusy(True);
end;

procedure TfrmGUIta.btnTestFiltersVClick(Sender: TObject);
var
  jo: TJob;
  c: TCont;
  sl: TStringList;
  t, str, flt: string;
begin
  if myNoJoC(jo, c) then Exit;
  myBusy(False);
  sl := TStringList.Create;
  sl.Add(myExpandFN(edtffplay.Text)); sl.Add('-hide_banner');
  str := myGetInputFiles(jo, LVstreams.Selected.Caption, sl);
  flt := myGetFilter(jo, c);
  t := c.getval('codec_type');
  if t = 'video' then
  begin
    sl.Add('-vst'); sl.Add(str);
    my2lst('-vf', flt, sl);
    sl.Add('-an');
  end
  else
  if t = 'audio' then
  begin
    sl.Add('-ast'); sl.Add(str);
    my2lst('-af', flt, sl);
    sl.Add('-vn');
  end;
  my2lst('-ss', jo.getval(cmbDurationss2.Name), sl);
  my2lst('-t', jo.getval(cmbDurationt2.Name), sl);
  //my2lst('-itsoffset', jo.getval(cmbItsoffset.Name), sl);
  if chkffplayexit.Checked then sl.Add('-autoexit');
  myTredExe2(chkxtermconv.Checked, sl, memConsole, 'f', btnTestFiltersV.Caption, swoShowNormal);
  sl.Free;
  myBusy(True);
end;

procedure TfrmGUIta.btnVolumeDetectClick(Sender: TObject);
begin
  if LVjobs.Selected = nil then Exit;
  if LVstreams.Selected = nil then Exit;
  myTredExe1(6, memConsole, 'v', 'volumedetect');
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

procedure TfrmGUIta.chkCmdline4shellChange(Sender: TObject);
begin
  if chkCmdline4shell.Checked then chkUseEditedCmd.Checked := False;
  TabCmdlineShow(nil);
end;

procedure TfrmGUIta.chkColorJobsChange(Sender: TObject);
begin
  if chkColorJobs.Checked then
    LVjobs.OnCustomDrawSubItem := @LVjobsCustomDrawSubItem
  else
    LVjobs.OnCustomDrawSubItem := nil;
end;

procedure TfrmGUIta.chkColorMasksChange(Sender: TObject);
begin
  if chkColorMasks.Checked then
    LVmasks.OnCustomDrawSubItem := @LVmasksCustomDrawSubItem
  else
    LVmasks.OnCustomDrawSubItem := nil;
end;

procedure TfrmGUIta.chkGenDBuseChange(Sender: TObject);
begin
  if bUpdFromCode then Exit;
  myFillFmtEnc;
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
  bv, ba: boolean;
  i: integer;
begin
  if bUpdFromCode then Exit;
  f := '';
  m := '';
  i := -1;
  bv := chkSGmixvideo.Checked and chkSGsource0.Checked and chkSGsource1.Checked;
  ba := chkSGmixaudio.Checked and chkSGsource2.Checked and chkSGsource3.Checked;
  if bv then
  begin
    inc(i, 2);
    f := '[0][1]overlay=main_w-overlay_w-2:main_h-overlay_h-2[v]';
    m := '-map [v]';
  end
  else
  begin
    if chkSGsource0.Checked then
    begin
      inc(i);
      m += ' -map ' + IntToStr(i);
    end;
    if chkSGsource1.Checked then
    begin
      inc(i);
      m += ' -map ' + IntToStr(i);
    end;
  end;
  if ba then
  begin
    if f <> '' then f += ', ';
    f += Format('[%d][%d]amix[a]', [i + 1, i + 2]);
    m += ' -map [a]';
  end
  else
  begin
    if chkSGsource2.Checked then
    begin
      inc(i);
      m += ' -map ' + IntToStr(i);
    end;
    if chkSGsource3.Checked then
    begin
      inc(i);
      m += ' -map ' + IntToStr(i);
    end;
  end;
  cmbSGfiltercomplex.Text := f;
  cmbSGmaps.Text := Trim(m);
end;

procedure TfrmGUIta.chkSynColorChange(Sender: TObject);
begin
  if chkSynColor.Checked then  //if dark theme
  begin
    SynUNIXShellScriptSyn1.CommentAttri.Foreground := clLime;  //Green
    SynUNIXShellScriptSyn1.NumberAttri.Foreground := TColor($FF8888); //Blue
    SynUNIXShellScriptSyn1.SecondKeyAttri.Foreground := clRed; //Maroon
    SynUNIXShellScriptSyn1.StringAttri.Foreground := clYellow; //Olive
    SynUNIXShellScriptSyn1.SymbolAttri.Foreground := clAqua;  //Teal
    SynUNIXShellScriptSyn1.VarAttri.Foreground := clFuchsia;   //Purple
    SynIniSyn1.CommentAttri.Foreground := clLime;
    SynIniSyn1.KeyAttri.Foreground := TColor($FF8888);
    SynIniSyn1.SymbolAttri.Foreground := TColor($8888FF);
  end
  else //if light theme
  begin
    SynUNIXShellScriptSyn1.CommentAttri.Foreground := clGreen;
    SynUNIXShellScriptSyn1.NumberAttri.Foreground := clBlue;
    SynUNIXShellScriptSyn1.SecondKeyAttri.Foreground := clMaroon;
    SynUNIXShellScriptSyn1.StringAttri.Foreground := clOlive;
    SynUNIXShellScriptSyn1.SymbolAttri.Foreground := clTeal;
    SynUNIXShellScriptSyn1.VarAttri.Foreground := clPurple;
    SynIniSyn1.CommentAttri.Foreground := clGreen;
    SynIniSyn1.KeyAttri.Foreground := clBlue;
    SynIniSyn1.SymbolAttri.Foreground := clRed;
  end;
  if chkDebug.Checked then
    myWindowColorIsDark;
end;

procedure TfrmGUIta.chkMetadataWorkChange(Sender: TObject);
var
  b: boolean;
  //v, a: string;
  jo: TJob;
begin
  b := chkMetadataWork.Checked;
  chkMetadataClear.Enabled := b;
  chkMetadataGen.Enabled := b;
  chkMetadataGet.Enabled := b;
  chkMetadataGet1.Enabled := b;
  memTagsOut.Enabled := b;
  if bUpdFromCode then Exit;
  if b then
  begin
    if (Sender = chkMetadataGet) and chkMetadataGet.Checked then
    begin
      bUpdFromCode := True;
      chkMetadataGet1.Checked := False;
      bUpdFromCode := False;
      xmyChange0(chkMetadataGet1);
    end;
    if (Sender = chkMetadataGet1) and chkMetadataGet1.Checked then
    begin
      bUpdFromCode := True;
      chkMetadataGet.Checked := False;
      bUpdFromCode := False;
      xmyChange0(chkMetadataGet);
    end;
  end;
  if myNoJo(jo) then Exit;
  xmyChange0(Sender);
  myTags(jo);
  //myGetColumns56(jo, v, a);
  //LVjobs.Selected.SubItems[5] := v;
  //LVjobs.Selected.SubItems[6] := a;
  memTagsOut.Text := jo.getval(memTagsOut.Name);
end;

procedure TfrmGUIta.chkUseEditedCmdChange(Sender: TObject);
begin
  if bUpdFromCode then Exit;
  xmyChange0(Sender);
  if chkUseEditedCmd.Checked then
  begin
    chkCmdline4shell.Checked := False;
    xmyChange0(memCmdlines);
  end
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

procedure TfrmGUIta.cmbEncoderAChange(Sender: TObject);
var
  jo: TJob;
  c: TCont;
  b: boolean;
  s: string;
begin
  if not bUpdFromCode then myListBox1view(cmbEncoderA);
  xmyChange2i(Sender);
  if myNoJoC(jo, c) then Exit;
  edtEncoderA.Text := myCalcEncA(c);
  xmyChange2(edtEncoderA);
  s := edtEncoderA.Text;
  b := (s <> 'copy');
  myDisTab(cmbEncoderA, b);
  //pnlTagA.Enabled := chkMetadataWork.Checked;
  TabMetaDataA.Enabled := chkMetadataWork.Checked;
  if not b then Exit;
  cmbQualityA.Items.AddStrings([''], True);
  cmbBitrateA.Items.AddStrings(['', 'in_bitrate',
    'iff(in_bitrate/in_ch>64,ch*64,in_bitrate/in_ch*ch)',
    'iff(in_bitrate/in_ch>160,ch*160,in_bitrate/in_ch*ch)',
    'round(srate*ch*$koefa/1600000)*16',
    'round(srate*ch*$koefa/100000)'], True);
  cmbChannels.Items.AddStrings([''], True);
  if (s = 'aac') then
  begin
    cmbQualityA.Items.AddStrings(['0.32', '0.40', '0.56', '0.64', '0.80', '0.96', '1.12', '1.28', '1.44', '1.60', '1.92', '2.24', '2.56', '2.88', '3.20', '3.84', '4.48', '5.12']);
    cmbBitrateA.Items.AddStrings(['8', '16', '24', '32', '40', '48', '56', '64', '80', '96', '112', '128', '144', '160', '192', '224', '256', '288', '320', '384', '448', '512']);
    cmbChannels.Items.AddStrings(['1', '2', '3', '4', '5', '6', '8', '48']);
  end
  else
  if (s = 'opus') then
  begin
    //cmbQualityA.Text := '';
    cmbBitrateA.Items.AddStrings(['8', '16', '24', '32', '40', '48', '56', '64', '80', '96', '112', '128', '144', '160', '192', '224', '256', '288', '320', '384', '448', '510']);
    cmbChannels.Items.AddStrings(['1', '2']);
  end
  else
  if (s = 'libopus') then
  begin
    //cmbQualityA.Text := '';
    cmbBitrateA.Items.AddStrings(['8', '16', '24', '32', '40', '48', '56', '64', '80', '96', '112', '128', '144', '160', '192', '224', '256', '288', '320', '384', '448', '510']);
    cmbChannels.Items.AddStrings(['1', '2', '3', '4', '5', '6', '8', '255']);
  end
  else
  if (s = 'libmp3lame') then
  begin
    cmbQualityA.Items.AddStrings(['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']);
    cmbBitrateA.Items.AddStrings(['8', '16', '24', '32', '40', '48', '56', '64', '80', '96', '112', '128', '144', '160', '192', '224', '256', '288', '320']);
    cmbChannels.Items.AddStrings(['1', '2']);
  end
  else
  if (s = 'libtwolame') then
  begin
    cmbQualityA.Items.AddStrings(['-50', '-25', '-10', '-5', '0', '5', '10', '25', '50']);
    cmbBitrateA.Items.AddStrings(['8', '16', '24', '32', '48', '56', '64', '80', '96', '112', '128', '160', '192', '224', '256', '320', '384']);
    cmbChannels.Items.AddStrings(['1', '2']);
  end
  else
  if (s = 'libvorbis') then
  begin
    cmbQualityA.Items.AddStrings(['-1.0', '0', '1.0', '3.0', '5.0', '7.5', '10']);
    cmbBitrateA.Items.AddStrings(['45', '56', '64', '80', '96', '112', '128', '160', '192', '224', '256', '320', '384', '500']);
    cmbChannels.Items.AddStrings(['1', '2', '3', '4', '5', '6', '8', '255']);
  end
  else
  if (s = 'eac3') then
  begin
    //cmbQualityA.Text := '';
    cmbBitrateA.Items.AddStrings(['32', '48', '56', '64', '80', '96', '112', '128', '160', '192', '224', '256', '320', '384', '480', '640', '1536', '3072', '6144']);
    cmbChannels.Items.AddStrings(['1', '2', '3', '4', '5', '6']);
  end
  else
  if (s = 'ac3') then
  begin
    //cmbQualityA.Text := '';
    cmbBitrateA.Items.AddStrings(['32', '48', '56', '64', '80', '96', '112', '128', '160', '192', '224', '256', '320', '384', '480', '640']);
    cmbChannels.Items.AddStrings(['1', '2', '3', '4', '5', '6']);
  end
  else
  if (s = 'flac') then
  begin
    //cmbQualityA.Text := '';
    //cmbBitrateA.Text := '';
    cmbChannels.Items.AddStrings(['1', '2', '3', '4', '5', '6', '7', '8']);
  end
  else
  if (s = 'alac') then
  begin
    //cmbQualityA.Text := '';
    //cmbBitrateA.Text := '';
    cmbChannels.Items.AddStrings(['1', '2', '3', '4', '5', '6', '7', '8']);
  end
  else
  if (s = 'truehd') then
  begin
    //cmbQualityA.Text := '';
    //cmbBitrateA.Text := '';
    cmbChannels.Items.AddStrings(['6', '8']);
  end
  else
  if (s = 'tta') then
  begin
    //cmbQualityA.Text := '';
    //cmbBitrateA.Text := '';
    cmbChannels.Items.AddStrings(['1', '2', '4', '6', '8', '65535']);
  end
  else
  if (s = 'wavpack') then
  begin
    //cmbQualityA.Text := '';
    cmbBitrateA.Items.AddStrings(['196', '224', '256', '288', '320', '384', '448', '512', '1024', '2048']);
    cmbChannels.Items.AddStrings(['1', '2', '4', '6', '8', '256']);
  end
  ;
(*
#!/bin/bash
ENC=$(ffmpeg -hide_banner -encoders | grep '^[ ][A]' | cut -c 9-29)
echo $ENC > 1_list_srate.log
for a in $ENC
do
  PIX=$(ffmpeg -hide_banner -h "encoder=$a" | grep 'Supported sample rates:' | cut -c 29-)
  if [ ! -z "$PIX" ]; then
    echo "if s = '$a' then" >> 1_list_srate.log
    s="  cmbSRate.Items.AddStrings([''"
    for p in $PIX
    do
      s+=", '$p'"
    done
    s+="], True)"
    echo "$s" >> 1_list_srate.log
    echo "else" >> 1_list_srate.log
  fi
done
*)
  if s = 'aac' then
    cmbSRate.Items.AddStrings(['', '96000', '88200', '64000', '48000', '44100', '32000', '24000', '22050', '16000', '12000', '11025', '8000', '7350'], True)
  else
  if s = 'ac3' then
    cmbSRate.Items.AddStrings(['', '48000', '44100', '32000'], True)
  else
  if s = 'ac3_fixed' then
    cmbSRate.Items.AddStrings(['', '48000', '44100', '32000'], True)
  else
  if s = 'aptx' then
    cmbSRate.Items.AddStrings(['', '8000', '16000', '24000', '32000', '44100', '48000'], True)
  else
  if s = 'aptx_hd' then
    cmbSRate.Items.AddStrings(['', '8000', '16000', '24000', '32000', '44100', '48000'], True)
  else
  if s = 'libcodec2' then
    cmbSRate.Items.AddStrings(['', '8000'], True)
  else
  if s = 'dca' then
    cmbSRate.Items.AddStrings(['', '8000', '16000', '32000', '11025', '22050', '44100', '12000', '24000', '48000'], True)
  else
  if s = 'eac3' then
    cmbSRate.Items.AddStrings(['', '48000', '44100', '32000'], True)
  else
  if s = 'mlp' then
    cmbSRate.Items.AddStrings(['', '44100', '48000', '88200', '96000', '176400', '192000'], True)
  else
  if s = 'mp2' then
    cmbSRate.Items.AddStrings(['', '44100', '48000', '32000', '22050', '24000', '16000'], True)
  else
  if s = 'mp2fixed' then
    cmbSRate.Items.AddStrings(['', '44100', '48000', '32000', '22050', '24000', '16000'], True)
  else
  if s = 'libtwolame' then
    cmbSRate.Items.AddStrings(['', '16000', '22050', '24000', '32000', '44100', '48000'], True)
  else
  if s = 'libmp3lame' then
    cmbSRate.Items.AddStrings(['', '44100', '48000', '32000', '22050', '24000', '16000', '11025', '12000', '8000'], True)
  else
  if s = 'libshine' then
    cmbSRate.Items.AddStrings(['', '44100', '48000', '32000'], True)
  else
  if s = 'opus' then
    cmbSRate.Items.AddStrings(['', '48000'], True)
  else
  if s = 'libopus' then
    cmbSRate.Items.AddStrings(['', '48000', '24000', '16000', '12000', '8000'], True)
  else
  if s = 'pcm_dvd' then
    cmbSRate.Items.AddStrings(['', '48000', '96000'], True)
  else
  if s = 'real_144' then
    cmbSRate.Items.AddStrings(['', '8000'], True)
  else
  if s = 's302m' then
    cmbSRate.Items.AddStrings(['', '48000'], True)
  else
  if s = 'sbc' then
    cmbSRate.Items.AddStrings(['', '16000', '32000', '44100', '48000'], True)
  else
  if s = 'libspeex' then
    cmbSRate.Items.AddStrings(['', '8000', '16000', '32000'], True)
  else
  if s = 'truehd' then
    cmbSRate.Items.AddStrings(['', '44100', '48000', '88200', '96000', '176400', '192000'], True)
  else
    cmbSRate.Items.AddStrings([''], True);
end;

procedure TfrmGUIta.cmbEncoderSChange(Sender: TObject);
var
  jo: TJob;
  c: TCont;
  b: boolean;
  s: string;
begin
  xmyChange2i(Sender);
  if myNoJoC(jo, c) then Exit;
  edtEncoderS.Text := myCalcEncS(c);
  xmyChange2(edtEncoderS);
  s := edtEncoderS.Text;
  b := (s <> 'copy');
  myDisTab(cmbEncoderS, b);
  pnlTagS.Enabled := chkMetadataWork.Checked;
end;

procedure TfrmGUIta.cmbEncoderVChange(Sender: TObject);
var
  jo: TJob;
  c: TCont;
  b: boolean;
  s: string;
begin
  if not bUpdFromCode then myListBox1view(cmbEncoderV);
  xmyChange2i(Sender);
  if myNoJoC(jo, c) then Exit;
  edtEncoderV.Text := myCalcEncV(c);
  xmyChange2(edtEncoderV);
  s := edtEncoderV.Text;
  b := (s <> 'copy');
  myDisTab(cmbEncoderV, b);
  //pnlTagV.Enabled := chkMetadataWork.Checked;
  TabMetaDataV.Enabled := chkMetadataWork.Checked;
  if not b then Exit;
  Screen.Cursor := crHourGlass;
  cmbPreset.Items.AddStrings([''], True);
  cmbTune.Items.AddStrings([''], True);
  cmbQualityV.Items.AddStrings([''], True);
  cmbcrfv.Items.AddStrings([''], True);
  cmbcqV.Items.AddStrings([''], True);
  if Pos('libx264', s) = 1 then
  begin
    cmbPreset.Items.AddStrings(['ultrafast', 'superfast', 'veryfast', 'faster', 'fast', 'medium', 'slow', 'slower', 'veryslow', 'placebo']);
    cmbTune.Items.AddStrings(['film', 'animation', 'grain', 'stillimage', 'psnr', 'ssim', 'fastdecode', 'zerolatency']);
    //cmbQualityV.Text := '';
    cmbcrfv.Items.AddStrings(['0', '17', '18', '19', '20', '21', '22', '23', '25', '27', '30', '35']);
    //cmbcqV.Text := '';
  end
  else
  if Pos('libx265', s) = 1 then
  begin
    cmbPreset.Items.AddStrings(['ultrafast', 'superfast', 'veryfast', 'faster', 'fast', 'medium', 'slow', 'slower', 'veryslow', 'placebo']);
    cmbTune.Items.AddStrings(['psnr', 'ssim', 'grain', 'zerolatency', 'fastdecode']);
    //cmbQualityV.Text := '';
    cmbcrfv.Items.AddStrings(['0', '18', '19', '20', '21', '22', '23', '24', '25', '27', '30', '35', '40']);
    //cmbcqV.Text := '';
  end
  else
  if Pos('nvenc', s) > 0 then
  begin
    cmbPreset.Items.AddStrings(['default', 'slow', 'medium', 'fast', 'hp', 'hq', 'bd', 'll', 'llhq', 'llhp', 'lossless', 'losslesshp']);
    //cmbTune.Text := '';
    //cmbQualityV.Text := '';
    //cmbcrfV.Text := '';
    cmbcqV.Items.AddStrings(['0', '16', '17', '18', '19', '20', '21', '22', '23', '24', '26', '28', '30', '33', '35', '40']);
  end
  else
  if (s = 'h264_qsv') or (s = 'hevc_qsv') or (s = 'mpeg2_qsv') or (s = 'vp9_qsv') then
  begin
    cmbPreset.Items.AddStrings(['veryfast', 'faster', 'fast', 'medium', 'slow', 'slower', 'veryslow']);
    //cmbTune.Text := '';
    //cmbQualityV.Text := '';
    //cmbcrfV.Text := '';
    //cmbcqV.Text := '';
    //-global_quality 15
  end
  else
  if (s = 'libvpx') then
  begin
    //cmbPreset.Text := '';
    cmbTune.Items.AddStrings(['psnr', 'ssim']);
    //cmbQualityV.Text := '';
    cmbcrfv.Items.AddStrings(['0', '15', '16', '17', '18', '19', '20', '21', '23', '25', '27', '30', '35', '40']);
    //cmbcqV.Text := '';
  end
  else
  if (s = 'libvpx-vp9') then
  begin
    //cmbPreset.Text := '';
    cmbTune.Items.AddStrings(['psnr', 'ssim']);
    //cmbQualityV.Text := '';
    cmbcrfv.Items.AddStrings(['0', '15', '16', '17', '18', '19', '20', '21', '23', '25', '27', '30', '35', '40']);
    //cmbcqV.Text := '';
  end
  else
  if Pos('libwebp', s) > 0 then
  begin
    cmbPreset.Items.AddStrings(['none', 'default', 'picture', 'photo', 'drawing', 'icon', 'text']);
    //cmbTune.Text := '';
    cmbQualityV.Items.AddStrings(['0', '50', '65', '75', '85', '90', '95', '100']);
    //cmbcrfV.Text := '';
    //cmbcqV.Text := '';
  end
  else
  if s = 'mpeg4' then
  begin
    //cmbPreset.Text := '';
    //cmbTune.Text := '';
    cmbQualityV.Items.AddStrings(['1', '2', '3', '4', '5', '7', '15', '23', '31']);
    //cmbcrfV.Text := '';
    //cmbcqV.Text := '';
  end
  else
  if s = 'libxvid' then
  begin
    //cmbPreset.Text := '';
    //cmbTune.Text := '';
    cmbQualityV.Items.AddStrings(['1', '2', '3', '7', '12', '16', '23', '31']);
    //cmbcrfV.Text := '';
    //cmbcqV.Text := '';
  end
  else
  if s = 'jpeg2000'  then
  begin
    //cmbPreset.Text := '';
    //cmbTune.Text := '';
    cmbQualityV.Items.AddStrings(['0', '60', '75', '80', '85', '90', '95', '100']);
    //cmbcrfV.Text := '';
    //cmbcqV.Text := '';
  end
  else
  if s = 'libaom-av1'  then
  begin
    //cmbPreset.Text := '';
    cmbTune.Items.AddStrings(['psnr', 'ssim']);
    //cmbQualityV.Text := '';
    cmbcrfv.Items.AddStrings(['0', '15', '20', '25', '30', '35', '40']);
    //cmbcqV.Text := '';
  end
  else
  if s = 'libtheora' then
  begin
    //cmbPreset.Text := '';
    //cmbTune.Text := '';
    cmbQualityV.Items.AddStrings(['0', '2', '5', '7', '10']);
    //cmbcrfV.Text := '';
    //cmbcqV.Text := '';
  end
  else
  if s = 'prores' then
  begin
    //cmbPreset.Text := '';
    //cmbTune.Text := '';
    cmbQualityV.Items.AddStrings(['0', '2', '5', '7', '10']);
    //cmbcrfV.Text := '';
    //cmbcqV.Text := '';
  end;

(*
------
#!/bin/bash
ENC=$(ffmpeg -hide_banner -encoders | grep '^[ ][V]' | cut -c 9-29)
echo $ENC > pix_fmt.log
for v in $ENC
do
  PIX=$(ffmpeg -hide_banner -h "encoder=$v" | grep 'Supported pixel formats:' | cut -c 30-)
  echo "if s = '$v' then" >> pix_fmt.log
  s="  cmbpix_fmt.Items.AddStrings([''"
  for p in $PIX
  do
    s+=", '$p'"
  done
  s+="], True)"
  echo "$s" >> pix_fmt.log
  echo "else" >> pix_fmt.log
done
------
*)
  if s = 'a64multi' then
    cmbpix_fmt.Items.AddStrings(['', 'gray'], True)
  else
  if s = 'a64multi5' then
    cmbpix_fmt.Items.AddStrings(['', 'gray'], True)
  else
  if s = 'alias_pix' then
    cmbpix_fmt.Items.AddStrings(['', 'bgr24', 'gray'], True)
  else
  if s = 'amv' then
    cmbpix_fmt.Items.AddStrings(['', 'yuvj420p'], True)
  else
  if s = 'apng' then
    cmbpix_fmt.Items.AddStrings(['', 'rgb24', 'rgba', 'rgb48be', 'rgba64be', 'pal8', 'gray', 'ya8', 'gray16be', 'ya16be', 'monob'], True)
  else
  if s = 'asv1' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'asv2' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'libaom-av1' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p', 'yuv422p', 'yuv444p', 'yuv420p10le', 'yuv422p10le', 'yuv444p10le', 'yuv420p12le', 'yuv422p12le', 'yuv444p12le'], True)
  else
  if s = 'avrp' then
    cmbpix_fmt.Items.AddStrings(['', 'gbrp10le'], True)
  else
  if s = 'avui' then
    cmbpix_fmt.Items.AddStrings(['', 'uyvy422'], True)
  else
  if s = 'ayuv' then
    cmbpix_fmt.Items.AddStrings(['', 'yuva444p'], True)
  else
  if s = 'bmp' then
    cmbpix_fmt.Items.AddStrings(['', 'bgra', 'bgr24', 'rgb565le', 'rgb555le', 'rgb444le', 'rgb8', 'bgr8', 'rgb4_byte', 'bgr4_byte', 'gray', 'pal8', 'monob'], True)
  else
  if s = 'cinepak' then
    cmbpix_fmt.Items.AddStrings(['', 'rgb24', 'gray'], True)
  else
  if s = 'cljr' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv411p'], True)
  else
  if s = 'vc2' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p', 'yuv422p', 'yuv444p', 'yuv420p10le', 'yuv422p10le', 'yuv444p10le', 'yuv420p12le', 'yuv422p12le', 'yuv444p12le'], True)
  else
  if s = 'dnxhd' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv422p', 'yuv422p10le', 'yuv444p10le', 'gbrp10le'], True)
  else
  if s = 'dpx' then
    cmbpix_fmt.Items.AddStrings(['', 'gray', 'rgb24', 'rgba', 'abgr', 'gray16le', 'gray16be', 'rgb48le', 'rgb48be', 'rgba64le', 'rgba64be', 'gbrp10le', 'gbrp10be', 'gbrp12le', 'gbrp12be'], True)
  else
  if s = 'dvvideo' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv411p', 'yuv422p', 'yuv420p'], True)
  else
  if s = 'ffv1' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p', 'yuva420p', 'yuva422p', 'yuv444p', 'yuva444p', 'yuv440p', 'yuv422p', 'yuv411p', 'yuv410p', 'bgr0', 'bgra', 'yuv420p16le', 'yuv422p16le', 'yuv444p16le', 'yuv444p9le', 'yuv422p9le', 'yuv420p9le', 'yuv420p10le', 'yuv422p10le', 'yuv444p10le', 'yuv420p12le', 'yuv422p12le', 'yuv444p12le', 'yuva444p16le', 'yuva422p16le', 'yuva420p16le', 'yuva444p10le', 'yuva422p10le', 'yuva420p10le', 'yuva444p9le', 'yuva422p9le', 'yuva420p9le', 'gray16le', 'gray', 'gbrp9le', 'gbrp10le', 'gbrp12le', 'gbrp14le', 'gbrap10le', 'gbrap12le', 'ya8', 'gray10le', 'gray12le', 'gbrp16le', 'rgb48le', 'gbrap16le', 'rgba64le', 'gray9le', 'yuv420p14le', 'yuv422p14le', 'yuv444p14le', 'yuv440p10le', 'yuv440p12le'], True)
  else
  if s = 'ffvhuff' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p', 'yuv422p', 'yuv444p', 'yuv411p', 'yuv410p', 'yuv440p', 'gbrp', 'gbrp9le', 'gbrp10le', 'gbrp12le', 'gbrp14le', 'gbrp16le', 'gray', 'gray16le', 'yuva420p', 'yuva422p', 'yuva444p', 'gbrap', 'yuv420p9le', 'yuv420p10le', 'yuv420p12le', 'yuv420p14le', 'yuv420p16le', 'yuv422p9le', 'yuv422p10le', 'yuv422p12le', 'yuv422p14le', 'yuv422p16le', 'yuv444p9le', 'yuv444p10le', 'yuv444p12le', 'yuv444p14le', 'yuv444p16le', 'yuva420p9le', 'yuva420p10le', 'yuva420p16le', 'yuva422p9le', 'yuva422p10le', 'yuva422p16le', 'yuva444p9le', 'yuva444p10le', 'yuva444p16le', 'rgb24', 'bgra'], True)
  else
  if s = 'fits' then
    cmbpix_fmt.Items.AddStrings(['', 'gbrap16be', 'gbrp16be', 'gbrp', 'gbrap', 'gray16be', 'gray'], True)
  else
  if s = 'flashsv' then
    cmbpix_fmt.Items.AddStrings(['', 'bgr24'], True)
  else
  if s = 'flashsv2' then
    cmbpix_fmt.Items.AddStrings(['', 'bgr24'], True)
  else
  if s = 'flv' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'gif' then
    cmbpix_fmt.Items.AddStrings(['', 'rgb8', 'bgr8', 'rgb4_byte', 'bgr4_byte', 'gray', 'pal8'], True)
  else
  if s = 'h261' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'h263' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'h263_v4l2m2m' then
    cmbpix_fmt.Items.AddStrings([''], True)
  else
  if s = 'h263p' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'libx264' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p', 'yuvj420p', 'yuv422p', 'yuvj422p', 'yuv444p', 'yuvj444p', 'nv12', 'nv16', 'nv21', 'yuv420p10le', 'yuv422p10le', 'yuv444p10le', 'nv20le', 'gray', 'gray10le'], True)
  else
  if s = 'libx264rgb' then
    cmbpix_fmt.Items.AddStrings(['', 'bgr0', 'bgr24', 'rgb24'], True)
  else
  if s = 'h264_nvenc' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p', 'nv12', 'p010le', 'yuv444p', 'p016le', 'yuv444p16le', 'bgr0', 'rgb0', 'cuda'], True)
  else
  if s = 'h264_omx' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'h264_qsv' then
    cmbpix_fmt.Items.AddStrings(['', 'nv12', 'p010le', 'qsv'], True)
  else
  if s = 'h264_v4l2m2m' then
    cmbpix_fmt.Items.AddStrings([''], True)
  else
  if s = 'h264_vaapi' then
    cmbpix_fmt.Items.AddStrings(['', 'vaapi_vld'], True)
  else
  if s = 'nvenc' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p', 'nv12', 'p010le', 'yuv444p', 'p016le', 'yuv444p16le', 'bgr0', 'rgb0', 'cuda'], True)
  else
  if s = 'nvenc_h264' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p', 'nv12', 'p010le', 'yuv444p', 'p016le', 'yuv444p16le', 'bgr0', 'rgb0', 'cuda'], True)
  else
  if s = 'hap' then
    cmbpix_fmt.Items.AddStrings(['', 'rgba'], True)
  else
  if s = 'libx265' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p', 'yuvj420p', 'yuv422p', 'yuvj422p', 'yuv444p', 'yuvj444p', 'gbrp', 'yuv420p10le', 'yuv422p10le', 'yuv444p10le', 'gbrp10le', 'yuv420p12le', 'yuv422p12le', 'yuv444p12le', 'gbrp12le', 'gray', 'gray10le', 'gray12le'], True)
  else
  if s = 'nvenc_hevc' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p', 'nv12', 'p010le', 'yuv444p', 'p016le', 'yuv444p16le', 'bgr0', 'rgb0', 'cuda'], True)
  else
  if s = 'hevc_nvenc' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p', 'nv12', 'p010le', 'yuv444p', 'p016le', 'yuv444p16le', 'bgr0', 'rgb0', 'cuda'], True)
  else
  if s = 'hevc_qsv' then
    cmbpix_fmt.Items.AddStrings(['', 'nv12', 'p010le', 'qsv'], True)
  else
  if s = 'hevc_v4l2m2m' then
    cmbpix_fmt.Items.AddStrings([''], True)
  else
  if s = 'hevc_vaapi' then
    cmbpix_fmt.Items.AddStrings(['', 'vaapi_vld'], True)
  else
  if s = 'huffyuv' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv422p', 'rgb24', 'bgra'], True)
  else
  if s = 'jpeg2000' then
    cmbpix_fmt.Items.AddStrings(['', 'rgb24', 'yuv444p', 'gray', 'yuv420p', 'yuv422p', 'yuv410p', 'yuv411p', 'pal8'], True)
  else
  if s = 'libopenjpeg' then
    cmbpix_fmt.Items.AddStrings(['', 'rgb24', 'rgba', 'rgb48le', 'rgba64le', 'gbrp', 'gbrp9le', 'gbrp10le', 'gbrp12le', 'gbrp14le', 'gbrp16le', 'gray', 'ya8', 'gray16le', 'ya16le', 'gray10le', 'gray12le', 'gray14le', 'yuv420p', 'yuv422p', 'yuva420p', 'yuv440p', 'yuv444p', 'yuva422p', 'yuv411p', 'yuv410p', 'yuva444p', 'yuv420p9le', 'yuv422p9le', 'yuv444p9le', 'yuva420p9le', 'yuva422p9le', 'yuva444p9le', 'yuv420p10le', 'yuv422p10le', 'yuv444p10le', 'yuva420p10le', 'yuva422p10le', 'yuva444p10le', 'yuv420p12le', 'yuv422p12le', 'yuv444p12le', 'yuv420p14le', 'yuv422p14le', 'yuv444p14le', 'yuv420p16le', 'yuv422p16le', 'yuv444p16le', 'yuva420p16le', 'yuva422p16le', 'yuva444p16le', 'xyz12le'], True)
  else
  if s = 'jpegls' then
    cmbpix_fmt.Items.AddStrings(['', 'bgr24', 'rgb24', 'gray', 'gray16le'], True)
  else
  if s = 'ljpeg' then
    cmbpix_fmt.Items.AddStrings(['', 'bgr24', 'bgra', 'bgr0', 'yuvj420p', 'yuvj444p', 'yuvj422p', 'yuv420p', 'yuv444p', 'yuv422p'], True)
  else
  if s = 'magicyuv' then
    cmbpix_fmt.Items.AddStrings(['', 'gbrp', 'gbrap', 'yuv422p', 'yuv420p', 'yuv444p', 'yuva444p', 'gray'], True)
  else
  if s = 'mjpeg' then
    cmbpix_fmt.Items.AddStrings(['', 'yuvj420p', 'yuvj422p', 'yuvj444p'], True)
  else
  if s = 'mjpeg_qsv' then
    cmbpix_fmt.Items.AddStrings(['', 'nv12', 'qsv'], True)
  else
  if s = 'mjpeg_vaapi' then
    cmbpix_fmt.Items.AddStrings(['', 'vaapi_vld'], True)
  else
  if s = 'mpeg1video' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'mpeg2video' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p', 'yuv422p'], True)
  else
  if s = 'mpeg2_qsv' then
    cmbpix_fmt.Items.AddStrings(['', 'nv12', 'qsv'], True)
  else
  if s = 'mpeg2_vaapi' then
    cmbpix_fmt.Items.AddStrings(['', 'vaapi_vld'], True)
  else
  if s = 'mpeg4' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'libxvid' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'mpeg4_omx' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'mpeg4_v4l2m2m' then
    cmbpix_fmt.Items.AddStrings([''], True)
  else
  if s = 'msmpeg4v2' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'msmpeg4' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'msvideo1' then
    cmbpix_fmt.Items.AddStrings(['', 'rgb555le'], True)
  else
  if s = 'pam' then
    cmbpix_fmt.Items.AddStrings(['', 'rgb24', 'rgba', 'rgb48be', 'rgba64be', 'gray', 'ya8', 'gray16be', 'ya16be', 'monob'], True)
  else
  if s = 'pbm' then
    cmbpix_fmt.Items.AddStrings(['', 'monow'], True)
  else
  if s = 'pcx' then
    cmbpix_fmt.Items.AddStrings(['', 'rgb24', 'rgb8', 'bgr8', 'rgb4_byte', 'bgr4_byte', 'gray', 'pal8', 'monob'], True)
  else
  if s = 'pgm' then
    cmbpix_fmt.Items.AddStrings(['', 'gray', 'gray16be'], True)
  else
  if s = 'pgmyuv' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p', 'yuv420p16be'], True)
  else
  if s = 'png' then
    cmbpix_fmt.Items.AddStrings(['', 'rgb24', 'rgba', 'rgb48be', 'rgba64be', 'pal8', 'gray', 'ya8', 'gray16be', 'ya16be', 'monob'], True)
  else
  if s = 'ppm' then
    cmbpix_fmt.Items.AddStrings(['', 'rgb24', 'rgb48be'], True)
  else
  if s = 'prores' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv422p10le', 'yuv444p10le', 'yuva444p10le'], True)
  else
  if s = 'prores_aw' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv422p10le', 'yuv444p10le', 'yuva444p10le'], True)
  else
  if s = 'prores_ks' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv422p10le', 'yuv444p10le', 'yuva444p10le'], True)
  else
  if s = 'qtrle' then
    cmbpix_fmt.Items.AddStrings(['', 'rgb24', 'rgb555be', 'argb', 'gray'], True)
  else
  if s = 'r10k' then
    cmbpix_fmt.Items.AddStrings(['', 'gbrp10le'], True)
  else
  if s = 'r210' then
    cmbpix_fmt.Items.AddStrings(['', 'gbrp10le'], True)
  else
  if s = 'rawvideo' then
    cmbpix_fmt.Items.AddStrings([''], True)
  else
  if s = 'roqvideo' then
    cmbpix_fmt.Items.AddStrings(['', 'yuvj444p'], True)
  else
  if s = 'rv10' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'rv20' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'sgi' then
    cmbpix_fmt.Items.AddStrings(['', 'rgb24', 'rgba', 'rgb48le', 'rgb48be', 'rgba64le', 'rgba64be', 'gray16le', 'gray16be', 'gray'], True)
  else
  if s = 'snow' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p', 'yuv410p', 'yuv444p', 'gray'], True)
  else
  if s = 'sunrast' then
    cmbpix_fmt.Items.AddStrings(['', 'bgr24', 'pal8', 'gray', 'monow'], True)
  else
  if s = 'svq1' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv410p'], True)
  else
  if s = 'targa' then
    cmbpix_fmt.Items.AddStrings(['', 'bgr24', 'bgra', 'rgb555le', 'gray', 'pal8'], True)
  else
  if s = 'libtheora' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p', 'yuv422p', 'yuv444p'], True)
  else
  if s = 'tiff' then
    cmbpix_fmt.Items.AddStrings(['', 'rgb24', 'rgb48le', 'pal8', 'rgba', 'rgba64le', 'gray', 'ya8', 'gray16le', 'ya16le', 'monob', 'monow', 'yuv420p', 'yuv422p', 'yuv440p', 'yuv444p', 'yuv410p', 'yuv411p'], True)
  else
  if s = 'utvideo' then
    cmbpix_fmt.Items.AddStrings(['', 'gbrp', 'gbrap', 'yuv422p', 'yuv420p', 'yuv444p'], True)
  else
  if s = 'v210' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv422p10le', 'yuv422p'], True)
  else
  if s = 'v308' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv444p'], True)
  else
  if s = 'v408' then
    cmbpix_fmt.Items.AddStrings(['', 'yuva444p'], True)
  else
  if s = 'v410' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv444p10le'], True)
  else
  if s = 'libvpx' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p', 'yuva420p'], True)
  else
  if s = 'vp8_v4l2m2m' then
    cmbpix_fmt.Items.AddStrings([''], True)
  else
  if s = 'vp8_vaapi' then
    cmbpix_fmt.Items.AddStrings(['', 'vaapi_vld'], True)
  else
  if s = 'libvpx-vp9' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p', 'yuva420p', 'yuv422p', 'yuv440p', 'yuv444p', 'gbrp'], True)
  else
  if s = 'vp9_vaapi' then
    cmbpix_fmt.Items.AddStrings(['', 'vaapi_vld'], True)
  else
  if s = 'vp9_qsv' then
    cmbpix_fmt.Items.AddStrings(['', 'nv12', 'p010le', 'qsv'], True)
  else
  if s = 'libwebp_anim' then
    cmbpix_fmt.Items.AddStrings(['', 'bgra', 'yuv420p', 'yuva420p'], True)
  else
  if s = 'libwebp' then
    cmbpix_fmt.Items.AddStrings(['', 'bgra', 'yuv420p', 'yuva420p'], True)
  else
  if s = 'wmv1' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'wmv2' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'wrapped_avframe' then
    cmbpix_fmt.Items.AddStrings([''], True)
  else
  if s = 'xbm' then
    cmbpix_fmt.Items.AddStrings(['', 'monow'], True)
  else
  if s = 'xface' then
    cmbpix_fmt.Items.AddStrings(['', 'monow'], True)
  else
  if s = 'xwd' then
    cmbpix_fmt.Items.AddStrings(['', 'bgra', 'rgba', 'argb', 'abgr', 'rgb24', 'bgr24', 'rgb565be', 'rgb565le', 'bgr565be', 'bgr565le', 'rgb555be', 'rgb555le', 'bgr555be', 'bgr555le', 'rgb8', 'bgr8', 'rgb4_byte', 'bgr4_byte', 'pal8', 'gray', 'monow'], True)
  else
  if s = 'y41p' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv411p'], True)
  else
  if s = 'yuv4' then
    cmbpix_fmt.Items.AddStrings(['', 'yuv420p'], True)
  else
  if s = 'zlib' then
    cmbpix_fmt.Items.AddStrings(['', 'bgr24'], True)
  else
  if s = 'zmbv' then
    cmbpix_fmt.Items.AddStrings(['', 'pal8', 'rgb555le', 'rgb565le', 'bgr0'], True)
  else
    cmbpix_fmt.Items.AddStrings([''], True);
  Screen.Cursor := crDefault;
end;

procedure TfrmGUIta.cmbExtChange(Sender: TObject);
var
  jo: TJob;
begin
  if bUpdFromCode then Exit;
  myError(0, 'cmbExtChange: executed');
  myListBox1view(cmbExt);
  if myNoJo(jo) then Exit;
  xmyChange0i(cmbExt);
  bUpdFromCode := True;
  if Pos('.', cmbExt.Text) > 0 then edtOfn.Text := myGetOutputFN(jo);
  bUpdFromCode := False;
  xmyChange0(edtOfn);
  myChngFormat;
  myChngEnc;
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

procedure TfrmGUIta.cmbFontGetItems(Sender: TObject);
begin
  if TComboBox(Sender).Items.Count > 0 then Exit;
  Screen.Cursor := crHourGlass;
  cmbFont.Items.Clear;
  cmbFont.Items.Assign(Screen.Fonts);
  Screen.Cursor := crDefault;
end;

procedure TfrmGUIta.cmbFormatChange(Sender: TObject);
var
  s: string;
  i: integer;
  jo: TJob;
begin
  if bUpdFromCode then Exit;
  xmyChange0i(cmbFormat);
  s := cmbFormat.Text;
  if (s <> '') then
  begin
    i := cmbFormat.Items.IndexOf(s);
    if (i > 0) and (i < cmbExt.Items.Count) then
    begin
      bUpdFromCode := True;
      if s = 'image2' then
      begin
        if (cmbExt.Text = '') then cmbExt.Text := '-%06d.png';
      end
      else
      if s = 'tee' then
      begin
        if (cmbExt.Text <> '') then cmbExt.Text := '';
      end
      else
        cmbExt.ItemIndex := i;
      bUpdFromCode := False;
      xmyChange0i(cmbExt);
      if myNoJo(jo) then Exit;
      bUpdFromCode := True;
      if Pos('.', cmbExt.Text) > 0 then edtOfn.Text := myGetOutputFN(jo);
      bUpdFromCode := False;
      xmyChange0(edtOfn);
      myChngEnc;
      ListBox1.Visible := False;
    end
    else
    begin
      myListBox1view(cmbFormat);
    end;
  end;
end;

procedure TfrmGUIta.cmbLanguageChange(Sender: TObject);
begin
  if FileExistsUTF8(sInidir + cmbLanguage.Text) then
    myLanguage(True);
end;

procedure TfrmGUIta.cmbLanguageGetItems(Sender: TObject);
begin
  if TComboBox(Sender).Items.Count > 0 then Exit;
  cmbLanguage.Items.Clear;
  Screen.Cursor := crHourGlass;
  myGetFileList(sInidir, '*.lng', cmbLanguage.Items, False, False, False);
  cmbLanguage.Sorted := True;
  Screen.Cursor := crDefault;
end;

procedure TfrmGUIta.cmbProfileChange(Sender: TObject);
var
  i: integer;
  jo: TJob;
  s: string;
begin
  s := cmbProfile.Text;
  if FileExistsUTF8(sInidir + s)
  or (s = mes[52]) //(default)
  or (s = mes[53]) //(screengrab)
  then
  begin
    cmbProfile.ParentFont := True;
    if bUpdFromCode then Exit;
    if chkProfile2All.Checked then
    for i := 0 to LVjobs.Items.Count - 1 do
    begin
      jo := TJob(LVjobs.Items[i].Data);
      myProfileRead(s, jo);
      jo.setval(sMyTested, '');
      LVjobs.Items[i].SubItems[3] := myCalcOutSize(jo);
      //myGetColumns56(jo, v, a);
      //LVjobs.Items[i].SubItems[5] := v;
      //LVjobs.Items[i].SubItems[6] := a;
    end
    else
    begin
      if myNoJo(jo) then Exit;
      myProfileRead(s, jo);
      jo.setval(sMyTested, '');
      LVjobs.Selected.SubItems[3] := myCalcOutSize(jo);
      //myGetColumns56(jo, v, a);
      //LVjobs.Selected.SubItems[5] := v;
      //LVjobs.Selected.SubItems[6] := a;
    end;
    LVjobsSelectItem(Sender, LVjobs.Selected, True);
  end
  else
  begin
    cmbProfile.Font.Color := ColorErrorText.ButtonColor;
    if bUpdFromCode then Exit;
    myListBox1view(cmbProfile);
  end;
end;

procedure TfrmGUIta.cmbProfileExit(Sender: TObject);
begin
  if not ListBox1.Focused then
  ListBox1.Visible := False;
end;

procedure TfrmGUIta.cmbProfileGetItems(Sender: TObject);
begin
  if cmbProfile.Items.Count > 0 then Exit;
  btnProfileGetItemsClick(Sender);
end;

procedure TfrmGUIta.cmbProfileKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: integer;
  b1, b2: boolean;
begin
  if Shift = [] then
  case Key of
    VK_RETURN:
    begin
      Key := VK_UNKNOWN;
      frmGUIta.SelectNext(TComboBox(Sender), True, True);
      TComboBox(Sender).Text := ListBox1.GetSelectedText;
      if Sender = cmbProfile  then cmbProfileChange(cmbProfile)   else
      if Sender = cmbFormat   then cmbFormatChange(cmbFormat)     else
      if Sender = cmbExt      then cmbExtChange(cmbExt)           else
      if Sender = cmbEncoderV then cmbEncoderVChange(cmbEncoderV) else
      if Sender = cmbEncoderA then cmbEncoderAChange(cmbEncoderA);
      ListBox1.Visible := False;
    end;

    VK_DOWN:
    begin
      Key := VK_UNKNOWN;
      b1 := False;
      b2 := False;
      for i := 0 to ListBox1.Items.Count - 1 do
      if ListBox1.Selected[i] then
      begin
        ListBox1.Selected[i] := False;
        b1 := True;
      end
      else
      if b1 then
      begin
        ListBox1.Selected[i] := True;
        b2 := True;
        Break;
      end;
      if not b2 and (ListBox1.Items.Count > 0) then
      begin
        ListBox1.Selected[ListBox1.Items.Count - 1] := True;
      end;
    end;

    VK_UP:
    begin
      Key := VK_UNKNOWN;
      b1 := False;
      b2 := False;
      for i := ListBox1.Items.Count - 1 downto 0 do
      if ListBox1.Selected[i] then
      begin
        ListBox1.Selected[i] := False;
        b1 := True;
      end
      else
      if b1 then
      begin
        ListBox1.Selected[i] := True;
        b2 := True;
        Break;
      end;
      if not b2 and (ListBox1.Items.Count > 0) then
      begin
        ListBox1.Selected[0] := True;
      end;
    end;
  end;
end;

procedure TfrmGUIta.cmbRenameMaskChange(Sender: TObject);
var
  jo: TJob;
begin
  if bUpdFromCode then Exit;
  if myNoJo(jo) then Exit;
  xmyChange0(Sender);
  edtOfn.Text := myGetOutputFN(jo);
end;

procedure TfrmGUIta.cmbRunCmdGetItems(Sender: TObject);
var
  i: integer;
begin
  if TComboBox(Sender).Items.Count > 0 then Exit;
  Screen.Cursor := crHourGlass;
  for i := 0 to High(cCmdIni.sk) do
    myAdd2cmb(cmbRunCmd, cCmdIni.sk[i]);
  Screen.Cursor := crDefault;
end;

procedure TfrmGUIta.cmbScenarioChange(Sender: TObject);
var
  s: string;
begin
  xmyChange0(Sender);
  s := 'volume=' + FloatToStr(Round(-15 * math.Log2(2/Power(LVfiles.Items.Count, 2)))/10, fsp) + 'dB';
  case cmbScenario.ItemIndex of
    3, 4: //xfade + acrossfade
    begin
      cmbScenarioOpt1.Text := '';
      cmbScenarioOpt2.Text := '';
      cmbScenarioOpt3.Text := 'transition=pixelize'; //'xfade=' + opt3 + 'duration=' + opt4
      cmbScenarioOpt4.Text := '0.5';                 //'acrossfade=d=' + opt4
    end;
    5: //tblend
    begin
      cmbScenarioOpt1.Text := '';
      cmbScenarioOpt2.Text := '';
      cmbScenarioOpt3.Text := 'all_mode=multiply'; //tblend=
      cmbScenarioOpt4.Text := '3'; //fade duration
    end;
    6, 7, 10, 11: //overlay + amix, stack + amix
    begin
      cmbScenarioOpt1.Text := '';
      cmbScenarioOpt2.Text := s; //'amix,' + opt2
      cmbScenarioOpt3.Text := '';
      cmbScenarioOpt4.Text := '';
    end;
    8, 9: //overlay + acrossfade
    begin
      cmbScenarioOpt1.Text := '';
      cmbScenarioOpt2.Text := '';
      cmbScenarioOpt3.Text := '';
      cmbScenarioOpt4.Text := '0.5'; //fade duration
    end
    else
    begin
      cmbScenarioOpt1.Text := '';
      cmbScenarioOpt2.Text := '';
      cmbScenarioOpt3.Text := '';
      cmbScenarioOpt4.Text := '';
    end;
  end;
end;

procedure TfrmGUIta.cmbScenarioOpt3GetItems(Sender: TObject);
begin
  cmbScenarioOpt3.Items.Clear;
  cmbScenarioOpt3.Items.Add('');
  case cmbScenario.ItemIndex of
    3, 4:  //xfade
    begin
      cmbScenarioOpt3.Items.Add('transition=custom');
      cmbScenarioOpt3.Items.Add('transition=fade');
      cmbScenarioOpt3.Items.Add('transition=wipeleft');
      cmbScenarioOpt3.Items.Add('transition=wiperight');
      cmbScenarioOpt3.Items.Add('transition=wipeup');
      cmbScenarioOpt3.Items.Add('transition=wipedown');
      cmbScenarioOpt3.Items.Add('transition=slideleft');
      cmbScenarioOpt3.Items.Add('transition=slideright');
      cmbScenarioOpt3.Items.Add('transition=slideup');
      cmbScenarioOpt3.Items.Add('transition=slidedown');
      cmbScenarioOpt3.Items.Add('transition=circlecrop');
      cmbScenarioOpt3.Items.Add('transition=rectcrop');
      cmbScenarioOpt3.Items.Add('transition=distance');
      cmbScenarioOpt3.Items.Add('transition=fadeblack');
      cmbScenarioOpt3.Items.Add('transition=fadewhite');
      cmbScenarioOpt3.Items.Add('transition=radial');
      cmbScenarioOpt3.Items.Add('transition=smoothleft');
      cmbScenarioOpt3.Items.Add('transition=smoothright');
      cmbScenarioOpt3.Items.Add('transition=smoothup');
      cmbScenarioOpt3.Items.Add('transition=smoothdown');
      cmbScenarioOpt3.Items.Add('transition=circleopen');
      cmbScenarioOpt3.Items.Add('transition=circleclose');
      cmbScenarioOpt3.Items.Add('transition=vertopen');
      cmbScenarioOpt3.Items.Add('transition=vertclose');
      cmbScenarioOpt3.Items.Add('transition=horzopen');
      cmbScenarioOpt3.Items.Add('transition=horzclose');
      cmbScenarioOpt3.Items.Add('transition=dissolve');
      cmbScenarioOpt3.Items.Add('transition=pixelize');
      cmbScenarioOpt3.Items.Add('transition=diagtl');
      cmbScenarioOpt3.Items.Add('transition=diagtr');
      cmbScenarioOpt3.Items.Add('transition=diagbl');
      cmbScenarioOpt3.Items.Add('transition=diagbr');
      cmbScenarioOpt3.Items.Add('transition=hlslice');
      cmbScenarioOpt3.Items.Add('transition=hrslice');
      cmbScenarioOpt3.Items.Add('transition=vuslice');
      cmbScenarioOpt3.Items.Add('transition=vdslice');
      cmbScenarioOpt3.Items.Add('transition=hblur');
      cmbScenarioOpt3.Items.Add('transition=fadegrays');
      cmbScenarioOpt3.Items.Add('transition=wipetl');
      cmbScenarioOpt3.Items.Add('transition=wipetr');
      cmbScenarioOpt3.Items.Add('transition=wipebl');
      cmbScenarioOpt3.Items.Add('transition=wipebr');
    end;
    5:     //blend
    begin
      cmbScenarioOpt3.Items.Add('all_mode=addition');
      cmbScenarioOpt3.Items.Add('all_mode=grainmerge');
      cmbScenarioOpt3.Items.Add('all_mode=and');
      cmbScenarioOpt3.Items.Add('all_mode=average');
      cmbScenarioOpt3.Items.Add('all_mode=burn');
      cmbScenarioOpt3.Items.Add('all_mode=darken');
      cmbScenarioOpt3.Items.Add('all_mode=difference');
      cmbScenarioOpt3.Items.Add('all_mode=grainextract');
      cmbScenarioOpt3.Items.Add('all_mode=divide');
      cmbScenarioOpt3.Items.Add('all_mode=dodge');
      cmbScenarioOpt3.Items.Add('all_mode=freeze');
      cmbScenarioOpt3.Items.Add('all_mode=exclusion');
      cmbScenarioOpt3.Items.Add('all_mode=extremity');
      cmbScenarioOpt3.Items.Add('all_mode=glow');
      cmbScenarioOpt3.Items.Add('all_mode=hardlight');
      cmbScenarioOpt3.Items.Add('all_mode=hardmix');
      cmbScenarioOpt3.Items.Add('all_mode=heat');
      cmbScenarioOpt3.Items.Add('all_mode=lighten');
      cmbScenarioOpt3.Items.Add('all_mode=linearlight');
      cmbScenarioOpt3.Items.Add('all_mode=multiply');
      cmbScenarioOpt3.Items.Add('all_mode=multiply128');
      cmbScenarioOpt3.Items.Add('all_mode=negation');
      cmbScenarioOpt3.Items.Add('all_mode=normal');
      cmbScenarioOpt3.Items.Add('all_mode=or');
      cmbScenarioOpt3.Items.Add('all_mode=overlay');
      cmbScenarioOpt3.Items.Add('all_mode=phoenix');
      cmbScenarioOpt3.Items.Add('all_mode=pinlight');
      cmbScenarioOpt3.Items.Add('all_mode=reflect');
      cmbScenarioOpt3.Items.Add('all_mode=screen');
      cmbScenarioOpt3.Items.Add('all_mode=softlight');
      cmbScenarioOpt3.Items.Add('all_mode=subtract');
      cmbScenarioOpt3.Items.Add('all_mode=vividlight');
      cmbScenarioOpt3.Items.Add('all_mode=xor');
    end;
    11:      //xstack=fill=
    begin
      cmbScenarioOpt3.Items.Add('black');
      cmbScenarioOpt3.Items.Add('black:shortest=1');
      cmbScenarioOpt3.Items.Add('white');
    end
    else
    begin
      cmbScenarioOpt3.Items.Add('drawtext=fontsize=h/30:text=''%{localtime\:%a %b %d %Y}'':fontcolor=white');
      cmbScenarioOpt3.Items.Add('drawtext=fontsize=36:text=''%{pts\:hms}'':x=w-tw-10:y=h-th-10:fontcolor=yellow:box=1:boxcolor=0x00000000@1');
    end;
  end;
end;

procedure TfrmGUIta.cmbScenarioOpt4GetItems(Sender: TObject);
begin
  cmbScenarioOpt4.Items.Clear;
  cmbScenarioOpt4.Items.Add('');
  case cmbScenario.ItemIndex of
    3, 4, 5, 8, 9: //xfade, fade, acrossfade, fade duration
    begin
      cmbScenarioOpt4.Items.Add('0.5');
      cmbScenarioOpt4.Items.Add('1.0');
      cmbScenarioOpt4.Items.Add('1.5');
      cmbScenarioOpt4.Items.Add('2.0');
      cmbScenarioOpt4.Items.Add('2.5');
      cmbScenarioOpt4.Items.Add('3.0');
      cmbScenarioOpt4.Items.Add('3.5');
      cmbScenarioOpt4.Items.Add('4.0');
      cmbScenarioOpt4.Items.Add('4.5');
      cmbScenarioOpt4.Items.Add('5.0');
    end
  end;
end;

procedure TfrmGUIta.cmbSGsource0GetItems(Sender: TObject);
begin
  if TComboBox(Sender).Items.Count > 0 then Exit;
  myFillSGin(TComboBox(Sender).Items, 'video');
end;

procedure TfrmGUIta.cmbSGsource2GetItems(Sender: TObject);
begin
  if TComboBox(Sender).Items.Count > 0 then Exit;
  myFillSGin(TComboBox(Sender).Items, 'audio');
end;

procedure TfrmGUIta.edtDirOutChange(Sender: TObject);
begin
  xmyCheckDir(Sender);
end;

procedure TfrmGUIta.edtffmpegChange(Sender: TObject);
begin
  if myChkFile(edtffmpeg) then
    myFillFmtEnc;
end;

procedure TfrmGUIta.edtffmpegGetItems(Sender: TObject);
var
  t: string;
begin
  if TComboBox(Sender).Items.Count > 0 then Exit;
  t := Copy(TComboBox(Sender).Name, 4, 100) + GetExeExt;
  Screen.Cursor := crHourGlass;
  myFindFiles(sDirApp, t, TComboBox(Sender), False);
  Screen.Cursor := crDefault;
end;

procedure TfrmGUIta.edtMediaInfoDllGetItems(Sender: TObject);
begin
  if TComboBox(Sender).Items.Count > 0 then Exit;
  Screen.Cursor := crHourGlass;
  myFindMediaInfo(False);
  Screen.Cursor := crDefault;
end;

procedure TfrmGUIta.edtMediaInfoGetItems(Sender: TObject);
begin
  if TComboBox(Sender).Items.Count > 0 then Exit;
  Screen.Cursor := crHourGlass;
  myFindMediaInfo(False);
  Screen.Cursor := crDefault;
end;

procedure TfrmGUIta.edtOfnChange(Sender: TObject);
var
  jo: TJob;
  fn: string;
begin
  fn := edtOfn.Text;
  if FileExistsUTF8(fn) then
  begin
    pnlOfnSize.Caption := myGetFileSize(fn);
    edtOfn.ParentFont := True;
  end
  else
  begin
    pnlOfnSize.Caption := '';
    edtOfn.Font.Color := ColorErrorText.ButtonColor;
  end;
  if bUpdFromCode then Exit;
  if myNoJo(jo) then Exit;
  xmyChange0(edtOfn);
  if cmbRenameMask.Text = '' then
  begin
    jo.setval(edtDirOut.Name, ExtractFileDir(fn));
    jo.setval(sMyOutputFNbak, ExtractFileNameOnly(fn));
  end;
  bUpdFromCode := True;
  cmbExt.Text := ExtractFileExt(fn);
  bUpdFromCode := False;
  xmyChange0i(cmbExt);
  myChngFormat;
  myDisComp;
end;

procedure TfrmGUIta.edtxtermGetItems(Sender: TObject);
{$IFDEF MSWINDOWS}
begin
  if TComboBox(Sender).Items.Count > 0 then Exit;
  edtxterm.Items.Add('cmd.exe');
end;
{$ELSE}
var
  i: integer;
  s: string;
begin
  if TComboBox(Sender).Items.Count > 0 then Exit;
  i := myGetDesktopEnvironment;
  if i = 3 then
  begin
    s := FindDefaultExecutablePath('konsole');
    if s <> '' then edtxterm.Items.Add(s);
  end;
  s := FindDefaultExecutablePath('xterm');
  if s <> '' then edtxterm.Items.Add(s);
  s := FindDefaultExecutablePath('deepin-terminal');
  if s <> '' then edtxterm.Items.Add(s);
  s := FindDefaultExecutablePath('gnome-terminal');
  if s <> '' then edtxterm.Items.Add(s);
  //s := FindDefaultExecutablePath('io.elementary.terminal');
  //if s <> '' then edtxterm.Items.Add(s);
  if i <> 3 then
  begin
    s := FindDefaultExecutablePath('konsole');
    if s <> '' then edtxterm.Items.Add(s);
  end;
  s := FindDefaultExecutablePath('lxterminal');
  if s <> '' then edtxterm.Items.Add(s);
  s := FindDefaultExecutablePath('mate-terminal');
  if s <> '' then edtxterm.Items.Add(s);
  s := FindDefaultExecutablePath('terminator');
  if s <> '' then edtxterm.Items.Add(s);
  s := FindDefaultExecutablePath('terminology');
  if s <> '' then edtxterm.Items.Add(s);
  s := FindDefaultExecutablePath('xfce4-terminal');
  if s <> '' then edtxterm.Items.Add(s);
  edtxterm.Items.Add('sh');
end;
{$ENDIF}

procedure TfrmGUIta.edtxtermoptsGetItems(Sender: TObject);
begin
  if TComboBox(Sender).Items.Count > 0 then Exit;
  {$IFDEF MSWINDOWS}
  if LowerCase(edtxterm.Text) = 'cmd.exe' then
    edtxtermopts.Items.AddStrings(['/c', '/k', '/c chcp 65001', '/k chcp 65001'], True);
  {$ELSE}
  if Pos('deepin-terminal', edtxterm.Text) > 0 then edtxtermopts.Items.AddStrings(['-e sh -c'], True) else
  if Pos('gnome-terminal',  edtxterm.Text) > 0 then edtxtermopts.Items.AddStrings(['-- sh -c', '--wait -- sh -c'], True) else
  //if Pos('io.elementary.terminal', edtxterm.Text) > 0 then edtxtermopts.Items.AddStrings(['-e'], True) else
  if Pos('konsole',         edtxterm.Text) > 0 then edtxtermopts.Items.AddStrings(['-e sh -c', '--noclose -e sh -c'], True) else
  if Pos('lxterminal',      edtxterm.Text) > 0 then edtxtermopts.Items.AddStrings(['-e'], True) else
  if Pos('mate-terminal',   edtxterm.Text) > 0 then edtxtermopts.Items.AddStrings(['-e'], True) else
  if Pos('terminator',      edtxterm.Text) > 0 then edtxtermopts.Items.AddStrings(['-e'], True) else
  if Pos('terminology',     edtxterm.Text) > 0 then edtxtermopts.Items.AddStrings(['-e'], True) else
  if Pos('xfce4-terminal',  edtxterm.Text) > 0 then edtxtermopts.Items.AddStrings(['-x sh -c', '--hold -x sh -c'], True) else
  if Pos('xterm',           edtxterm.Text) > 0 then edtxtermopts.Items.AddStrings(['-e', '-hold -e'], True) else
  if edtxterm.Text = 'sh'                      then edtxtermopts.Items.AddStrings(['-c'], True) else
                                                    edtxtermopts.Items.Clear;
  {$ENDIF}
end;

procedure TfrmGUIta.edtxtermSelect(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  if LowerCase(edtxterm.Text) = 'cmd.exe' then edtxtermopts.Text := '/c';
  {$ELSE}
  edtxtermoptsGetItems(edtxtermopts);
  if edtxtermopts.Items.Count > 0 then edtxtermopts.ItemIndex := 0;
  {$ENDIF}
end;

procedure TfrmGUIta.FormChangeBounds(Sender: TObject);
var
  w: TmyWinState;
begin
  w := TmyWinState.Create;
  w.a[0] := integer(WindowState);
  w.a[1] := Left;
  w.a[2] := Top;
  w.a[3] := Width;
  w.a[4] := Height;
  lsWinState.Add(w);
  while lsWinState.Count > 3 do
    lsWinState.Delete(0);
  myError(0, Format('FormChangeBounds: %d  %4d,%4d,%4d,%4d', [WindowState, Left, Top, Width, Height]));
end;

procedure TfrmGUIta.FormCreate(Sender: TObject);
var
  s, t, u: string;
  sl: TStringList;
  i: integer;

  procedure myDefaultSave;
  var
    i: integer;
    procedure my1(c: TComponent);
    var
      i: integer;
    begin
      if (c is TComboBox) or (c is TCheckBox) or (c is TSpinEdit) or (c is TColorButton) then
        cDefaultSets.setval(c.Name, myGet2(c))
      else if c is TPanel then
        for i := 0 to TPanel(c).ControlCount - 1 do
          my1(TPanel(c).Controls[i])
      else if c is TPageControl then
        for i := 0 to TPageControl(c).PageCount - 1 do
          my1(TPageControl(c).Pages[i]);
    end;
  begin
    for i := 0 to TabSets1.ControlCount - 1 do
      my1(TabSets1.Controls[i]);
    for i := 0 to TabSets2.ControlCount - 1 do
      my1(TabSets2.Controls[i]);
    for i := 0 to TabScreenGrab.ControlCount - 1 do
      my1(TabScreenGrab.Controls[i]);
    for i := 0 to TabColors.ControlCount - 1 do
      my1(TabColors.Controls[i]);
    cDefaultSets.setval(pnlStreams.Name, IntToStr(pnlStreams.Width));
    cDefaultSets.setval(cmbRunCmd.Name, IntToStr(cmbRunCmd.Items.Count));
  end;

begin
  TabMediaInfo.TabVisible := False;
  TabConsole3.TabVisible := False;
  memJournal.Clear;
  sCap := 'ffmpegGUIta ' + taVersion + '.' + taRevision + ' alpha';
  frmGUIta.Caption := sCap;
  memJournal.Lines.Add(sCap + ' - ' + taBuildDate + ' - Free Pascal ' +
    fpcVersion + ' - Lazarus ' + lazVersion + '-' + lazRevision +
    ' - ' + TargetCPU + ' ' + TargetOS);
  Files2Add := TList.Create;
  cDefaultSets := TCont.Create;
  cCmdIni := TCont.Create;
  lsWinState := TList.Create;
  fsp.DecimalSeparator := '.'; //for StrToFloat('1234.567', fsp)
  if DefaultFormatSettings.ThousandSeparator = #226 then //error: Invalid UTF-8 string passed to pango_layout_set_text()
     DefaultFormatSettings.ThousandSeparator := #32;     //replace E2 with space
  iTabCount := PageControl3.PageCount; //backup page count, for thread count
  //set some defaults
  bUpdFromCode := True;
  edtffmpeg.Text := 'ffmpeg' + GetExeExt;
  edtffplay.Text := 'ffplay' + GetExeExt;
  edtffprobe.Text:= 'ffprobe' + GetExeExt;
  chkSynColor.Checked := myWindowColorIsDark;
  {$IFDEF MSWINDOWS}
  edtDirTmp.Text := '%TEMP%';
  edtDirOut.Text := '';
  edtMediaInfo.Text := '%ProgramFiles%\MediaInfo\MediaInfo.exe';
  edtMediaInfoDll.Text := '%ProgramFiles%\MediaInfo\MediaInfo.dll';
  cmbExtPlayer.Text := '%ProgramFiles%\Windows Media Player\wmplayer.exe';
  cmbDirLast.Text := 'C:\';
  //screen grab
  cmbSGsource0.Text := '-f gdigrab -framerate 30 -i desktop';
  chkSGsource1.Checked := False;
  cmbSGsource1.Text := '';
  chkSGsource2.Checked := False;
  cmbSGsource2.Text := '';
  cmbSGsource3.Text := '-f dshow -i audio="virtual-audio-capturer"';
  chkSGmixvideo.Checked := False;
  chkSGmixaudio.Checked := False;
  cmbSGfiltercomplex.Text := '';
  cmbSGmaps.Text := '';
  cmbSGcodecvideo.Text := '-c:v h264_nvenc -qp 0';
  cmbSGcodecaudio.Text := '-c:a pcm_s16le';
  cmbSGoutext.Text := '.mkv';
  chkCmdline4shell.Visible := False; //Linux only
  {$ELSE}
  edtDirTmp.Text := GetTempDir;
  edtDirOut.Text := '';
  edtMediaInfo.Text := 'mediainfo-gui';
  edtMediaInfoDll.Text:= 'libmediainfo.so';
  cmbExtPlayer.Text := 'vlc';
  cmbDirLast.Text := '~';
  edtxterm.Text := '';
  edtxtermopts.Text := '';
  chkxterm1str.Checked := True;
  //screen grab
  cmbSGsource0.Text := '-f x11grab -framerate 30 -video_size ' + IntToStr(Screen.Width) + 'x'+ IntToStr(Screen.Height)
  + ' -i ' + GetEnvironmentVariableUTF8('DISPLAY');
  cmbSGsource1.Text := '-f v4l2 -framerate 30 -video_size 160x120 -i /dev/video0';
  cmbSGsource2.Text := '-f pulse -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor';
  cmbSGsource3.Text := '-f pulse -i alsa_input.pci-0000_00_1b.0.analog-stereo';
  cmbSGfiltercomplex.Text := '[0][1]overlay=main_w-overlay_w-2:main_h-overlay_h-2[v], [2][3]amix=inputs=2[a]';
  cmbSGmaps.Text := '-map [v] -map [a]';
  cmbSGcodecvideo.Text := '-c:v libx264 -preset fast -crf 18';
  cmbSGcodecaudio.Text := '-c:a pcm_s16le';
  cmbSGoutext.Text := '.mkv';
  {$ENDIF}
  edtDirTmp.Items.Add('');
  edtDirTmp.Items.Add(edtDirTmp.Text);
  edtDirOut.Items.Add('');
  cmbDirLast.Items.Add('');
  cmbDirLast.Items.Add(cmbDirLast.Text);
  bUpdFromCode := False;
  //language
  s := myGetLocaleLanguage;
  if s <> '' then
  begin
    sl := TStringList.Create;
    t := '';
    u := '';
    for i := 0 to cmbLangsList.Items.Count - 1 do
    begin
      myStr2List(cmbLangsList.Items[i], '|', sl);
      if (sl.Count > 4) and (s = sl[2]) then
      begin
        s := sl[3];
        t := sl[0];
        u := sl[5];
        Break;
      end;
    end;
    sl.Free;
    cmbLanguage.Text := s + '.lng';
    cmbLangA.Text := t;
    u := 'cp' + u;
    if (u <> 'cp') and (u <> 'cp0') and (cmbMetadataCP.Items.IndexOf(u) >= 0) then
      cmbMetadataCP.Text := u;
  end;
  myDefaultSave; //save defaults to container
  //get inifile location
  sInifile := ChangeFileExt(Application.ExeName, '.cfg'); //default is portable
  sDirApp := ExtractFilePath(Application.ExeName);
  sInidir := GetAppConfigDirUTF8(False, False);  //"/home/user/.config/ffmpegGUIta/" or "C:\Users\user\AppData\Local\ffmpegGUIta\"
  s := GetAppConfigFileUTF8(False, True, False); //"~/.config/ffmpegGUIta/ffmpegGUIta.cfg" or "%AppData%\ffmpegGUIta\ffmpegGUIta.cfg"
  if DirectoryIsWritable(sDirApp) then
  begin
    if FileExistsUTF8(sIniFile) then sInidir := sDirApp else
    if FileExistsUTF8(s)        then sIniFile := s      else
                                     sInidir := sDirApp;
  end
  else
  begin
    if FileExistsUTF8(sIniFile) and not FileExistsUTF8(s) then
    begin
      if not DirectoryExistsUTF8(sInidir) then
        s := GetAppConfigFileUTF8(False, True, True); //create config dir
      FileUtil.CopyFile(sIniFile, s, False);
    end;
    sIniFile := s;
  end;
  sHistory := ChangeFileExt(sInifile, '.history');
  memJournal.Lines.Add(sInifile);
  memJournal.Lines.Add(sHistory);
  //load settings from inifile
  cfg := TMemIniFile.Create(sInifile);
  if FileExistsUTF8(sInifile) then //if config file exists then
    mySets(True)                   //load settings from config file
  else
  begin                            //assign some sets
    btnResetClick(nil);
    btnMaskResetClick(nil);
  end;
  hst := TMemIniFile.Create(sHistory);
  if FileExistsUTF8(sHistory) then myHistory(True);
  chk1instanceChange(nil);
  myLanguage(True, True); //load language
  if (cmbFont.Text <> 'default') or (seFontSize.Value <> 0) then seFontSizeChange(seFontSize);
  myChkCpuCount; //process count for single thread formats: png xvid etc
  btnProfileGetItemsClick(nil);
  myFillFmtEnc;
  bUpdFromCode := True;
  cmbProfileChange(nil);
  bUpdFromCode := False;
  chkColorJobsChange(nil);
  chkColorMasksChange(nil);
end;

procedure TfrmGUIta.FormDestroy(Sender: TObject);
begin
  if chkSaveOnExit.Checked then
  begin
    mySets(False);
    myHistory(False);
    myFormPosSave(frmGUIta, cfg);
  end;
  Files2Add.Free;
  cDefaultSets.Free;
  cCmdIni.Free;
  lsWinState.Free;
  cfg.Free;
  hst.Free;
end;

procedure TfrmGUIta.FormDropFiles(Sender: TObject; const FileNames: array of string);
var
  i, j: integer;
  s: string;
  sl: TStringList;
  p: TPoint;
  wc: TWinControl;
  w: word;
  c: TCont;
begin
  w := 0;
  p.x := 0;
  p.y := 0;
  GetCursorPos(p);
  wc := FindControl(WindowFromPoint(p));
  if wc.Name = btnAddFileSplit.Name then w := 1 else    //-c  cut file
  if wc.Name = btnAddImageDir.Name  then w := 2 else    //-i  images
  if wc.Name = btnAddFiles1job.Name then w := 4 else    //-s  single job
  if wc.Name = btnConcatFiles.Name  then w := 7 else    //-concat files
  if wc.Name = btnConcat2Files.Name then w := 9 else    //    concat:file1|file2|file3
  if (LVjobs.Selected <> nil) then
  begin
    if wc.Name = LVstreams.Name     then w := 5 else
    if wc.Name = LVfiles.Name       then w := 5 else
    if wc.Name = btnAddTracks.Name  then w := 5 else
    if wc.Name = btnAddTrack1.Name  then w := 5 else
    if wc.Name = edtOfn.Name        then w := 6;        //if not kde
  end;
  if chkDebug.Checked then memJournal.Lines.Add('FormDropFiles: ' + wc.Name + ' ' + IntToStr(w));
  c := TCont.Create;
  for i := Low(FileNames) to High(FileNames) do
  begin
    //StatusBar1.SimpleText := wc.Name + ' ' + mes[3] + Format(' %d', [High(c.sk)]);
    //Application.ProcessMessages;
    s := FileNames[i];
    if DirectoryExistsUTF8(s) then
    begin
      sl := TStringList.Create;
      if myGetFileList(s, myGetExtsFromMasks, sl, True, True, False) then
      begin
        sl.Sort;
        for j := 0 to sl.Count - 1 do
          c.addval(sl[j], myGetDirOut('', s, ExtractFilePath(sl[j])));
      end;
      sl.Free;
    end
    else
      c.addval(s, myGetDirOut('', s));
  end;
  if Length(c.sk) > 0 then
  try
    case w of
      0: myAddFiles(c);
      1: myAddSplit(c);
      2: myAdd_pics(c.sk[0], c.sv[0]);
      4: myAdd_Job4(c);
      5: myAdd2Job5(c, TJob(LVjobs.Selected.Data));
      6: begin
           edtOfn.Text := c.sk[0];
           xmyChange0(edtOfn);
         end;
      7: myAdd_Job7(c);
      9: myAdd_Job9(c);
    end;
    myAddStart;
  except
    on E: Exception do myError(-1, 'FormDropFiles: ' + E.Message);
  end;
  c.Free;
end;

procedure TfrmGUIta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and seFontSize.Enabled then
  case Key of
    VK_ADD: begin
      if seFontSize.Value = 0 then seFontSize.Value := 10 else seFontSize.Value := seFontSize.Value + 1;
      Key := 0;
    end;
    VK_SUBTRACT: begin
      if seFontSize.Value > 6 then seFontSize.Value := seFontSize.Value - 1;
      Key := 0;
    end;
    VK_MULTIPLY: begin
      seFontSize.Value := 9;
      Key := 0;
    end;
    VK_DIVIDE: begin
      cmbFont.Text := 'default';
      seFontSize.Value := 0;
      Key := 0;
    end;
  end;
  //myError(0, 'FormKeyDown: ' + IntToStr(Key) + ' ' + IntToStr(Integer(Shift)));
end;

procedure TfrmGUIta.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if (Shift = [ssCtrl]) and seFontSize.Enabled then
  begin
    if WheelDelta > 0 then
    begin
      if seFontSize.Value = 0 then seFontSize.Value := 10 else
      if seFontSize.Value < 20 then seFontSize.Value := seFontSize.Value + 1
    end
    else
      if seFontSize.Value > 6 then seFontSize.Value := seFontSize.Value - 1;
    Handled := True;
  end;
end;

procedure TfrmGUIta.FormResize(Sender: TObject);
begin
  if ListBox1.Visible then ListBox1.Visible := False;
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
  SL := TStringList.Create;
  try
    try
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
      end;
      //else if myGetFileList(GetCurrentDir, myGetExtsFromMasks, SL, True, True, True) then
      //  SL.Sort;
      if SL.Count > 0 then
        myParseParams(SL);
    except
      on E: Exception do myError(-1, 'FormShow: ' + E.Message);
    end;
  finally
    SL.Free;
  end;
  myFormPosLoad(frmGUIta, cfg);
end;

procedure TfrmGUIta.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i: integer;
begin
  //if ssLeft in Shift then
  if Shift * [ssShift, ssCtrl, ssAlt] = [] then
  begin
    i := ListBox1.GetIndexAtXY(X, Y);
    if (i >= 0) and (i < ListBox1.Items.Count) then
    begin
      case ListBox1.Tag of
        1: begin
          cmbProfile.Text := ListBox1.Items[i];
          cmbProfileChange(cmbProfile);
        end;
        2: begin
          cmbFormat.Text := ListBox1.Items[i];
          cmbFormatChange(cmbFormat);
        end;
        3: begin
          cmbExt.Text := ListBox1.Items[i];
          cmbExtChange(cmbExt);
        end;
        4: begin
          cmbEncoderV.Text := ListBox1.Items[i];
          cmbEncoderVChange(cmbEncoderV);
        end;
        5: begin
          cmbEncoderA.Text := ListBox1.Items[i];
          cmbEncoderAChange(cmbEncoderA);
        end;
      end;
      ListBox1.Visible := False;
    end;
  end;
end;

procedure TfrmGUIta.LVfilesClick(Sender: TObject);
begin
  if LVfiles.Selected = nil then
  begin
    myClear2([TabInput]);
    myDisTab(LVfiles, False);
  end;
end;

procedure TfrmGUIta.LVfilesDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  i, k, l: integer;
  jb, jo: TJob;
  c: TCont;
begin
  if Source = Sender then
  begin
    myMoveLi(TListView(Source), X, Y);
    if myNoJo(jb) then Exit;
    jo := TJob.Create;
    for i := 0 to High(jb.sk) do
    begin
      jo.addval(jb.sk[i], jb.sv[i]);
    end;
    SetLength(jo.f, Length(jb.f));
    for i := 0 to LVfiles.Items.Count - 1 do
    begin
      l := StrToIntDef(LVfiles.Items[i].Caption, -1);
      if (l < 0) or (l > High(jb.f)) then Exit;
      jo.f[i] := jb.f[l];
      LVfiles.Items[i].Caption := IntToStr(i);
    end;
    LVjobs.Selected.Data := Pointer(jo);
    for l := 0 to High(jo.f) do
    for k := 0 to High(jo.f[l].s) do
    begin
      SetLength(jo.m, Length(jo.m) + 1);
      jo.m[High(jo.m)] := Format('%d:%d', [l, k]);
    end;
    for i := 0 to LVstreams.Items.Count - 1 do
    if (i >= 0) and (i <= High(jo.m)) then
    begin
      c := myGetCurrCont(jo, jo.m[i]);
      LVstreams.Items[i].Checked := c.getval(sMyChecked) = '1';
      LVstreams.Items[i].Caption := jo.m[i];
      LVstreams.Items[i].SubItems[0] := (myGetCaptionCont(c));
    end;
  end
  else
  if Source = LVjobs then
  begin
    if myNoJo(jo) then Exit;
    for l := 0 to High(jo.f) do
    begin
      myAdd2Job1(jo.f[l].getval(sMyInputFN), jo);
    end;
    myAddStart;
  end;
end;

procedure TfrmGUIta.LVfilesDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = Sender) or (Source = LVjobs);
end;

procedure TfrmGUIta.LVfilesSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  l: integer;
  jo: TJob;
begin
  if not Selected then Exit;
  if myNoJo(jo) then Exit;
  if LVfiles.Selected = nil then Exit;
  myDisTab(LVfiles, True);
  l := StrToIntDef(LVfiles.Selected.Caption, -1);
  if (l < 0) or (l > High(jo.f)) then Exit;
  myCont2Tab(jo.f[l], TabInput);
  if bUpdFromCode then Exit;
  bUpdFromCode := True;
  if LVstreams.Selected <> nil then
    if myGetDigit0(LVstreams.Selected.Caption) <> l then
      LVstreams.Selected.Selected := False;
  bUpdFromCode := False;
end;

procedure TfrmGUIta.LVjobsClick(Sender: TObject);
begin
  if LVjobs.Selected = nil then
  begin
    edtOfn.Text := mes[7]; //Select job to change convert parameters
    myClear2([TabInput, TabOutput, TabVideo, TabAudio, TabSubtitle, TabData, TabContRows, TabCmdline]);
    LVfiles.Clear;
    LVstreams.Clear;
    myDisComp;
  end;
end;

procedure TfrmGUIta.LVjobsCustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  var DefaultDraw: Boolean);
var
  r: TRect;
  i, w, p: integer;
  style: TTextStyle;
begin
  if Sender <> LVjobs then Exit;
  if SubItem > Item.SubItems.Count then Exit;
  if Item.Data = nil then Exit;
  w := TListView(Sender).Columns[SubItem].Width;
  r := Item.DisplayRectSubItem(SubItem, drBounds);
  i := Item.ImageIndex;
  if not Item.Checked and (i = 0) then i := 4;
  if (i > 4) or (i < 0) then i := 4;
  Sender.Canvas.Font := LVjobs.Font;
  if Item.Selected then
  case i of
    0: begin
      Sender.Canvas.Font.Color := ColorAddedBack.ButtonColor;
      Sender.Canvas.Brush.Color := ColorAddedText.ButtonColor;
      Sender.Canvas.Pen.Color := ColorAddedText.ButtonColor;
    end;
    1: begin
      Sender.Canvas.Font.Color := ColorCompletedBack.ButtonColor;
      Sender.Canvas.Brush.Color := ColorCompletedText.ButtonColor;
      Sender.Canvas.Pen.Color := ColorCompletedText.ButtonColor;
    end;
    2: begin
      Sender.Canvas.Font.Color := ColorProgressBack.ButtonColor;
      Sender.Canvas.Brush.Color := ColorProgressText.ButtonColor;
      Sender.Canvas.Pen.Color := ColorProgressText.ButtonColor;
    end;
    3: begin
      Sender.Canvas.Font.Color := ColorErrorBack.ButtonColor;
      Sender.Canvas.Brush.Color := ColorErrorText.ButtonColor;
      Sender.Canvas.Pen.Color := ColorErrorText.ButtonColor;
    end;
    4: begin
      Sender.Canvas.Font.Color := clHighlightText;
      Sender.Canvas.Brush.Color := clHighlight;
      Sender.Canvas.Pen.Color := clHighlight;
    end;
  end
  else
  case i of
    0: begin
      Sender.Canvas.Font.Color := ColorAddedText.ButtonColor;
      Sender.Canvas.Brush.Color := ColorAddedBack.ButtonColor;
      Sender.Canvas.Pen.Color := ColorAddedBack.ButtonColor;
    end;
    1: begin
      Sender.Canvas.Font.Color := ColorCompletedText.ButtonColor;
      Sender.Canvas.Brush.Color := ColorCompletedBack.ButtonColor;
      Sender.Canvas.Pen.Color := ColorCompletedBack.ButtonColor;
    end;
    2: begin
      Sender.Canvas.Font.Color := ColorProgressText.ButtonColor;
      Sender.Canvas.Brush.Color := ColorProgressBack.ButtonColor;
      Sender.Canvas.Pen.Color := ColorProgressBack.ButtonColor;
    end;
    3: begin
      Sender.Canvas.Font.Color := ColorErrorText.ButtonColor;
      Sender.Canvas.Brush.Color := ColorErrorBack.ButtonColor;
      Sender.Canvas.Pen.Color := ColorErrorBack.ButtonColor;
    end;
    4: begin
      Sender.Canvas.Font.Color := clWindowText;
      Sender.Canvas.Brush.Color := clWindow;
      Sender.Canvas.Pen.Color := clWindow;
    end;
  end;
  p := w;
  if SubItem = 1 then
  begin
    if i = 2 then
    begin
      i := StrToIntDef(TJob(Item.Data).getval('progressbar'), 0);
      if (i > 0) and (i < 100) then
        p := w * i div 100;
    end;
  end;
  Sender.Canvas.Rectangle(r.Left, r.Top, r.Left + p, r.Bottom); //progressbar or background
  Sender.Canvas.Brush.Style := bsClear;
  //Sender.Canvas.TextOut(r.Left, r.Top, Item.SubItems[SubItem - 1]);
  style.Alignment := LVjobs.Column[SubItem].Alignment;
  Sender.Canvas.TextRect(r, r.Left, r.Top, Item.SubItems[SubItem - 1], style);
  Sender.Canvas.FillRect(r);
  DefaultDraw := False;
end;

procedure TfrmGUIta.LVjobsDragDrop(Sender, Source: TObject; X, Y: integer);
var
  l: integer;
  s: string;
  jo: TJob;
begin
  if Source = Sender then
    myMoveLi(TListView(Source), X, Y)
  else
  if Source = LVfiles then
  begin
    if myNoJo(jo) then Exit;
    if LVfiles.Selected <> nil then
      l := StrToIntDef(LVfiles.Selected.Caption, 0)
    else
      l := 0;
    if (l < 0) or (l > High(jo.f)) then Exit;
    s := jo.f[l].getval(sMyInputFN);
    myAddFile1(s, myGetDirOut('', s));
    myAddStart;
  end;
end;

procedure TfrmGUIta.LVjobsDragOver(Sender, Source: TObject; X, Y: integer;
  State: TDragState; var Accept: boolean);
begin
  Accept := (Source = Sender) or (Source = LVfiles)// or (Source = edtOfn);
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
    if Length(jo.f) > 0 then
    begin
      //DuraAll += myTimeStrToReal(jo.f[0].getval('duration'));
      DuraAll += myGetDuration(jo);
      inc(DuraAl2);
    end;
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
  i, l: integer;
  jo: TJob;
  c: TCont;
  li: TListItem;
begin
  if not Selected then Exit;
  if bUpdFromCode then Exit;
  if myNoJo(jo) then Exit;
  Screen.Cursor := crHourGlass;
  LVfiles.BeginUpdate;
  LVstreams.BeginUpdate;
  bUpdFromCode := True;
  LVfiles.Clear;
  LVstreams.Clear;
  myClear2([TabInput, TabOutput, TabVideo, TabAudio, TabSubtitle, TabData, TabContRows, TabCmdline]);
  myCont2Tab(jo, TabOutput);
  myChngEnc;
  for l := 0 to High(jo.f) do
  begin
    li := LVfiles.Items.Add;
    li.Caption := IntToStr(l);;
    li.SubItems.Add(jo.f[l].getval(sMyInputFN));
  end;
  for i := 0 to High(jo.m) do
  begin
    c := myGetCurrCont(jo, jo.m[i]);
    li := LVstreams.Items.Add;
    li.Checked := c.getval(sMyChecked) = '1';
    li.Caption := jo.m[i];
    li.SubItems.Add(myGetCaptionCont(c));
  end;
  LVfiles.EndUpdate;
  LVstreams.EndUpdate;
  cmbProfile.Text := jo.getval(cmbProfile.Name);
  bUpdFromCode := False;
  myDisComp;
  if (PageControl2.ActivePage = TabInput) then
  begin
    if (LVfiles.Items.Count > 0) then
      LVfiles.Items[0].Selected := True;
  end
  else
  if (PageControl2.ActivePage = TabVideo)
  or (PageControl2.ActivePage = TabAudio)
  or (PageControl2.ActivePage = TabSubtitle)
  or (PageControl2.ActivePage = TabData)     then TabVideoShow(PageControl2.ActivePage) else
  if (PageControl2.ActivePage = TabCmdline)  then TabCmdlineShow(Sender) else
  if (PageControl2.ActivePage = TabContRows) then TabContRowsShow(Sender);
  Screen.Cursor := crDefault;
end;

procedure TfrmGUIta.LVmasksCustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  var DefaultDraw: Boolean);
var
  r: TRect;
  i: integer;
  s: string;
begin
  if SubItem > Item.SubItems.Count then Exit;
  if Item.Selected then
  begin
    Sender.Canvas.Font.Color := clHighlightText;
    Sender.Canvas.Brush.Color := clHighlight;
  end
  else
  begin
    Sender.Canvas.Font.Color := clWindowText;
    Sender.Canvas.Brush.Color := clWindow;
  end;
  if SubItem = 2 then
  begin
    r := Item.DisplayRect(drBounds);
    for i := SubItem - 1 downto 0 do
      r.Left := r.Left + Sender.Column[i].Width;
    r.Left := r.Left + 2;
    r.Right := r.Left + Sender.Column[SubItem].Width;
    s := sInidir + Item.SubItems[1];
    if not FileExistsUTF8(s) then
    begin
      Sender.Canvas.Font := frmGUIta.Font;
      Sender.Canvas.Font.Color := ColorErrorText.ButtonColor;
      Sender.Canvas.Brush.Color := ColorErrorBack.ButtonColor;
      Sender.Canvas.FillRect(r);
      Sender.Canvas.TextRect(r, r.Left + 1, r.Top + 1, Item.SubItems[SubItem - 1]);
      DefaultDraw := False;
    {$IFDEF WINDOWS}
    end
    else
    begin
      Sender.Canvas.Font := frmGUIta.Font;
      Sender.Canvas.FillRect(r);
      Sender.Canvas.TextRect(r, r.Left + 1, r.Top + 1, Item.SubItems[SubItem - 1]);
      DefaultDraw := False;
    {$ENDIF}
    end;
  {$IFDEF WINDOWS}
  end
  else
  begin
    r := Item.DisplayRect(drBounds);
    for i := SubItem - 1 downto 0 do
      r.Left := r.Left + Sender.Column[i].Width;
    r.Left := r.Left + 2;
    r.Right := r.Left + Sender.Column[SubItem].Width;

    Sender.Canvas.Font := frmGUIta.Font;
    Sender.Canvas.FillRect(r);
    Sender.Canvas.TextRect(r, r.Left + 1, r.Top + 1, Item.SubItems[SubItem - 1]);
    DefaultDraw := False;
  {$ENDIF}
  end;
end;

procedure TfrmGUIta.LVstreamsClick(Sender: TObject);
begin
  if LVstreams.Selected = nil then
  begin
    myClear2([TabVideo, TabAudio, TabSubtitle, TabData, TabContRows]);
    PageControl2.ActivePage := TabOutput;
  end;
end;

procedure TfrmGUIta.LVstreamsDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  i: integer;
  jo: TJob;
begin
  if Source = Sender then
    myMoveLi(TListView(Source), X, Y);
  if myNoJo(jo) then Exit;
  for i := 0 to LVstreams.Items.Count - 1 do
    if (i >= 0) and (i <= High(jo.m)) then
      jo.m[i] := LVstreams.Items[i].Caption;
end;

procedure TfrmGUIta.LVstreamsDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = Sender);
end;

procedure TfrmGUIta.LVstreamsItemChecked(Sender: TObject; Item: TListItem);
var
  jo: TJob;
begin
  if bUpdFromCode then Exit;
  if myNoJo(jo) then Exit;
  jo.setval(sMyTested, '');
  myGetCurrCont(jo, Item.Caption).setval(sMyChecked, IfThen(Item.Checked, '1', '0'));
  LVjobs.Selected.SubItems[3] := myCalcOutSize(jo);
  if PageControl2.ActivePage = TabCmdline then
    TabCmdlineShow(Sender);
end;

procedure TfrmGUIta.LVstreamsSelectItem(Sender: TObject; Item: TListItem;
  Selected: boolean);
var
  jo: TJob;
  c: TCont;
  t: string;
  i, l: integer;
  ts: TTabSheet;
begin
  if not Selected then Exit;
  if myNoJoC(jo, c) then Exit;
  bUpdFromCode := True;
  Screen.Cursor := crHourGlass;
  l := myGetDigit0(LVstreams.Selected.Caption);
  for i := 0 to LVfiles.Items.Count - 1 do
    LVfiles.Items[i].Selected := i = l;
  t := c.getval('codec_type');
  if (PageControl2.ActivePage = TabVideo)
  or (PageControl2.ActivePage = TabAudio)
  or (PageControl2.ActivePage = TabSubtitle)
  or (PageControl2.ActivePage = TabData) then
  begin
    if t = 'video' then
    begin
      ts := TabVideo;
      myCont2Tab(c, ts); //fill edit fields from stream
      cmbBitrateVChange(cmbBitrateV);
      cmbEncoderVChange(cmbEncoderV);
    end
    else if t = 'audio' then
    begin
      ts := TabAudio;
      myCont2Tab(c, ts);
      cmbBitrateAChange(cmbBitrateA);
      cmbEncoderAChange(cmbEncoderA);
    end
    else if t = 'subtitle' then
    begin
      ts := TabSubtitle;
      myCont2Tab(c, ts);
      cmbEncoderSChange(cmbEncoderS);
    end
    else
    begin
      ts := TabData;
      myCont2Tab(c, ts);
      cmbEncoderSChange(cmbEncoderD);
    end;
    PageControl2.ActivePage := ts;
  end
  else
  if (PageControl2.ActivePage = TabContRows) then
    TabContRowsShow(nil);
  Screen.Cursor := crDefault;
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

procedure TfrmGUIta.mnuClearJobsClick(Sender: TObject);
//var
//  i: integer;
begin
  LVjobs.BeginUpdate;
  //i := LVjobs.Items.Count;
  //while i > 0 do
  //begin
  //  dec(i);
  //  TObject(LVjobs.Items[i].Data).Free;
  //  LVjobs.Items[i].Data := nil;
  //  LVjobs.Items[i].SubItems.Clear;
  //  LVjobs.Items[i].Delete;
  //end;
  LVjobs.Items.Clear; //memory leak
  LVjobs.EndUpdate;
  DuraAll := 0;
  DuraAl2 := 0;
  myShowCaption('');
  LVjobsClick(Sender);
end;

procedure TfrmGUIta.mnuCopyConsoleClick(Sender: TObject);
begin
  //memConsole.CopyToClipboard;
  if Sender is TMenuItem then with Sender as TMenuItem do
  if GetParentMenu is TPopupMenu then with GetParentMenu as TPopupMenu do
  if PopupComponent is TSynMemo then with PopupComponent as TSynMemo do begin
    CopyToClipboard;
  end;
end;

procedure TfrmGUIta.mnuDeleteFileClick(Sender: TObject);
var
  jo: TJob;
  i, k, l: integer;
begin
  if myNoJo(jo) then Exit;
  if LVfiles.Selected = nil then Exit;
  if LVfiles.Items.Count = 1 then Exit;
  for i := LVfiles.Selected.Index to LVfiles.Items.Count - 2 do
    jo.f[i] := jo.f[i + 1];
  SetLength(jo.f, Length(jo.f) - 1);
  SetLength(jo.m, 0);
  for l := 0 to High(jo.f) do
  for k := 0 to High(jo.f[l].s) do
  begin
    SetLength(jo.m, Length(jo.m) + 1);
    jo.m[High(jo.m)] := Format('%d:%d', [l, k]);
  end;
  LVjobsSelectItem(Sender, LVjobs.Selected, True);
end;

procedure TfrmGUIta.mnuDeleteJobClick(Sender: TObject);
begin
  if LVjobs.Selected <> nil then
  begin
    LVjobs.Selected.Delete;
    LVjobsItemChecked(Sender, nil);
  end;
end;

procedure TfrmGUIta.mnuOpenClick(Sender: TObject);
var
  jo: TJob;
begin
  if myNoJo(jo) then Exit;
  if Length(jo.f) > 0 then
    myOpenDoc(jo.f[0].getval(sMyInputFN));
end;

procedure TfrmGUIta.mnuPasteClick(Sender: TObject);
var
  c: TCont;
begin
  c := TCont.Create;
  myGetClipboardFileNames(c);
  if Length(c.sk) > 0 then
  begin
    if Sender = mnuPaste then
      myAddFiles(c)
    else
    if (LVjobs.Selected <> nil) and ((Sender = mnuPasteTracks) or (Sender = mnuPasteFiles)) then
      myAdd2Job5(c, TJob(LVjobs.Selected.Data));
    myAddStart;
  end;
  c.Free;
end;

procedure TfrmGUIta.mnuSaveJobClick(Sender: TObject);
var
  jo: TJob;
  sd: TSaveDialog;
  Ini: TMemIniFile;
  i, l, k: integer;
begin
  if myNoJo(jo) then Exit;
  sd := TSaveDialog.Create(Self);
  sd.Title := mes[48]; //Save file as
  sd.InitialDir := myExtrDirExist(myExpandFN(cmbDirLast.Text, True));
  sd.Filter := mes[29] + ' (' + AllFilesMask + ')|' + AllFilesMask; //All files
  sd.FileName := 'job ' + LVjobs.Selected.Caption + '.ffjob';
  if sd.Execute then
  begin
    if FileExistsUTF8(sd.FileName) then
    begin
      if MessageDlg(mes[57] + ' ' + sd.FileName, mtConfirmation, [mbOK, mbCancel], 0) = mrOK then //File exists, overwrite?
        DeleteFileUTF8(sd.FileName)
      else
        Exit;
    end;
    cmbDirLast.Text := ExtractFileDir(myUnExpandFN(sd.FileName));
    Ini := TMemIniFile.Create(sd.FileName);
    for i := 0 to LVjobs.Selected.SubItems.Count - 1 do
      Ini.WriteString('SubItems', IntToStr(i), LVjobs.Selected.SubItems[i]);
    for i := 0 to High(jo.sk) do
      Ini.WriteString('jo', jo.sk[i], StringReplace(jo.sv[i], LineEnding, '\n', [rfReplaceAll]));
    Ini.WriteBool('jo', sMyChecked, LVjobs.Selected.Checked);
    for i := 0 to High(jo.m) do
      Ini.WriteString('m', IntToStr(i), jo.m[i]);
    for l := 0 to High(jo.f) do
    begin
      for i := 0 to High(jo.f[l].sk) do
        Ini.WriteString('jo.f.' + IntToStr(l), jo.f[l].sk[i], StringReplace(jo.f[l].sv[i], LineEnding, '\n', [rfReplaceAll]));
      for k := 0 to High(jo.f[l].s) do
      begin
        for i := 0 to High(jo.f[l].s[k].sk) do
          Ini.WriteString('jo.f.' + IntToStr(l) + '.s.' + IntToStr(k), jo.f[l].s[k].sk[i], StringReplace(jo.f[l].s[k].sv[i], LineEnding, '\n', [rfReplaceAll]));
      end;
    end;
    Ini.Free;
  end;
  sd.Free;
end;

procedure TfrmGUIta.onCnv3Terminate(Sender: TObject);
var
  s: string;
  li: TListItem;
begin
  li := LVtrd.FindData(0, Pointer(Sender), True, False);
  if li <> nil then
  begin
    s := li.Caption + ': ' + mes[30] + ' ' + mes[31]; //Process terminated
    li.Data := nil;
    li.Delete;
    if LVtrd.Items.Count = 0 then
    begin
      DuraJob := '';
      myShowCaption('');
    end;
  end
  else
    s := Sender.ClassName + ' ' + mes[51]; //not found
  myError(0, 'onCnv3Terminate: ' + s);
end;

procedure TfrmGUIta.ontAutoStart(Sender: TObject);
begin
  tAutoStart.Enabled := False;
  tAutoStart.OnTimer := nil;
  tAutoStart.Free;
  btnStart.Click;
end;

procedure TfrmGUIta.PopupMenuJobsPopup(Sender: TObject);
var
  c: TCont;
  b: boolean;
begin
  c := TCont.Create;
  myGetClipboardFileNames(c, True);
  mnuPaste.Enabled := Length(c.sk) > 0;
  c.Free;
  b := LVjobs.Selected <> nil;
  mnuOpen.Enabled := b;
  mnuCheck.Enabled := LVjobs.Items.Count > 0;
  mnuCheck.Checked := b and LVjobs.Selected.Checked;
  mnuSaveJob.Enabled := b;
  mnuDeleteJob.Enabled := b and (LVtrd.Items.Count = 0);
  mnuClearJobs.Enabled := LVjobs.Items.Count > 0;
end;

procedure TfrmGUIta.PopupMenuStreamsPopup(Sender: TObject);
var
  c: TCont;
begin
  c := TCont.Create;
  myGetClipboardFileNames(c, True);
  mnuPasteTracks.Enabled := Length(c.sk) > 0;
  c.Free;
end;

procedure TfrmGUIta.PopupMenuFilesPopup(Sender: TObject);
var
  c: TCont;
  b: boolean;
begin
  c := TCont.Create;
  myGetClipboardFileNames(c, True);
  mnuPasteFiles.Enabled := Length(c.sk) > 0;
  c.Free;
  b := LVjobs.Selected <> nil;
  mnuMediainfo1.Enabled := b;
  mnuDeleteFile.Enabled := b and (LVfiles.Items.Count > 1);
end;

procedure TfrmGUIta.seFontSizeChange(Sender: TObject);
var
  f: TFont;
  g: TColor;

  procedure my1(c: TWinControl);
  var
    i, j: integer;
  begin
    for i := 0 to c.ControlCount - 1 do
    begin
      if (c.Controls[i] is TSynMemo) then
      begin
        c.Controls[i].Font.Size := seFontSize.Value;
      end
      else
      begin
        if not c.Controls[i].IsParentFont then
        begin
          g := c.Controls[i].Font.Color;
          c.Controls[i].Font := f;
          c.Controls[i].Font.Color := g;
        end;
        if (c.Controls[i] is TPageControl) then
          for j := 0 to TPageControl(c.Controls[i]).PageCount - 1 do
            my1(TWinControl(c.Controls[i]))
        else
        if (c.Controls[i] is TPanel) or (c.Controls[i] is TTabSheet) then
          my1(TWinControl(c.Controls[i]));
      end;
    end;
  end;

begin
  Screen.Cursor := crHourGlass;
  cmbFont.Enabled := False;
  seFontSize.Enabled := False;
  f := TFont.Create;
  f.Name := cmbFont.Text;
  f.Size := seFontSize.Value;
  frmGUIta.Font := f;
  my1(frmGUIta);
  StatusBar1.SimpleText := LVjobs.Font.Name + ' ' + IntToStr(LVjobs.Font.Size);
  cmbFont.Enabled := True;
  seFontSize.Enabled := True;
  Screen.Cursor := crDefault;
end;

procedure TfrmGUIta.Splitter1CanResize(Sender: TObject; var NewSize: Integer;
  var Accept: Boolean);
begin
  Accept := (NewSize > 300) and (NewSize < frmGUIta.Width - 300);
end;

procedure TfrmGUIta.SplitterLVjobsCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept := (NewSize > 399) and (NewSize < TabConvJob.Height - 100);
end;

procedure TfrmGUIta.SplitterLVstreamsCanResize(Sender: TObject; var NewSize: Integer;
  var Accept: Boolean);
begin
  Accept := (NewSize > 230) and (NewSize < frmGUIta.Width - 660);
end;

procedure TfrmGUIta.TabCmdlineShow(Sender: TObject);
var
  jo: TJob;
  run: TRun;
  l, k: integer;
  s, t: string;
begin
  if myNoJo(jo) then Exit;
  bUpdFromCode := True;
  chkUseEditedCmd.Checked := (jo.getval(chkUseEditedCmd.Name) = '1');
  if chkUseEditedCmd.Checked then
    memCmdlines.Text := jo.getval(memCmdlines.Name)
  else
  begin
    memCmdlines.Clear;
    run := TRun.Create;
    myGetRunFromJo(jo, run, 5, chkxtermconv.Checked);
    {$IFDEF MSWINDOWS}
    memCmdlines.Lines.Add('@echo off');
    memCmdlines.Lines.Add('chcp 65001');
    for l := 0 to High(run.p) do
    begin
      s := myQuotedStr(run.p[l].Executable);
      for k := 0 to run.p[l].Parameters.Count - 1 do
      begin
        t := run.p[l].Parameters[k];
        if Pos(LineEnding, t) > 0 then
        begin
          t := StringsReplace(t, [LineEnding, '"'], [' ^' + LineEnding, '^"'], [rfReplaceAll]);
          s += ' ^"' + t + '^"';
        end
        else
          s += ' ' + myQuotedStr(t);
      end;
      memCmdlines.Lines.Add(s);
    end;
    {$ELSE}
    memCmdlines.Lines.Add('#!/bin/bash');
    for l := 0 to High(run.p) do
    begin
      s := myQuotedStr(run.p[l].Executable);
      for k := 0 to run.p[l].Parameters.Count - 1 do
      begin
        t := run.p[l].Parameters[k];
        t := StringReplace(t, LineEnding, '\' + LineEnding, [rfReplaceAll]);
        s += ' ' + myQuotedStr(t);
      end;
      memCmdlines.Lines.Add(s);
    end;
    {$ENDIF}
    run.Free;
  end;
  bUpdFromCode := False;
end;

procedure TfrmGUIta.TabContRowsShow(Sender: TObject);
var
  jo: TJob;
  c: TCont;
  i, l: integer;
  sl: TStringList;
begin
  memStreamInfo.Clear;
  if myNoJo(jo) then Exit;
  sl := TStringList.Create;
  if (LVstreams.Selected = nil) then
  begin
    for i := 0 to High(jo.sk) do
      memStreamInfo.Lines.Add(jo.sk[i] + '=' + jo.sv[i]);
    for l := 0 to High(jo.f) do
    begin
      memStreamInfo.Lines.Add('[$inpu' + IntToStr(l) + ']');
      for i := 0 to High(jo.f[l].sk) do
      begin
        sl.Text := jo.f[l].sk[i] + '=' + jo.f[l].sv[i];
        memStreamInfo.Lines.AddStrings(sl);
      end;
    end;
  end
  else
  begin
    c := myGetCurrCont(jo, LVstreams.Selected.Caption);
    for i := 0 to High(c.sk) do
      memStreamInfo.Lines.Add(c.sk[i] + '=' + c.sv[i]);
  end;
  sl.Free;
end;

procedure TfrmGUIta.TabInputShow(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to LVstreams.Items.Count - 1 do
    LVstreams.Items[i].Selected := False;
  if (LVfiles.Selected = nil) and (LVfiles.Items.Count > 0) then
    LVfiles.Items[0].Selected := True;
end;

procedure TfrmGUIta.TabOutputShow(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to LVstreams.Items.Count - 1 do
    LVstreams.Items[i].Selected := False;
end;

procedure TfrmGUIta.TabSets1Show(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  xmyCheckFile(edtffmpeg);
  xmyCheckFile(edtffplay);
  xmyCheckFile(edtffprobe);
  xmyCheckFile(edtMediaInfo);
  xmyCheckFile(edtMediaInfoDll);
  xmyCheckFile(cmbExtPlayer);
  xmyCheckDir(edtDirTmp);
  xmyCheckDir(edtDirOut);
  xmyCheckDir(cmbDirLast);
  Screen.Cursor := crDefault;
end;

procedure TfrmGUIta.TabVideoShow(Sender: TObject);
var
  i, k, l, m, n: integer;
  s: string;
  jo: TJob;
begin
  if bUpdFromCode then Exit;
  if myNoJo(jo) then Exit;
  s := LowerCase(Copy(TTabSheet(Sender).Name, 4, 8));
  if LVstreams.Selected <> nil then
  begin
    if (s = myGetCurrCont(jo, LVstreams.Selected.Caption).getval('codec_type')) then
    begin
      LVstreamsSelectItem(Sender, LVstreams.Selected, True);
      Exit;
    end;
  end;
  bUpdFromCode := True;
  if LVfiles.Selected <> nil then
    l := StrToIntDef(LVfiles.Selected.Caption, 0)
  else
    l := -1;
  k := -1; //codec_type and checked and current file
  m := -1; //codec_type and checked
  n := -1; //codec_type
  for i := 0 to LVstreams.Items.Count - 1 do
  begin
    if (s = myGetCurrCont(jo, LVstreams.Items[i].Caption).getval('codec_type')) then
    begin
      if (k < 0) and LVstreams.Items[i].Checked and (myGetDigit0(LVstreams.Items[i].Caption) = l) then
        k := i;
      if (m < 0) and LVstreams.Items[i].Checked then
        m := i;
      if (m < 0) then
        n := i;
    end;
    LVstreams.Items[i].Selected := False;
  end;
  if (k >= 0) then i := k else
  if (m >= 0) then i := m else
  if (n >= 0) then i := n else
                   i := -1;
  bUpdFromCode := False;
  if (i >= 0) and (i < LVstreams.Items.Count) then
    LVstreams.Items[i].Selected := True;
end;

procedure TfrmGUIta.UniqueInstance1OtherInstance(Sender: TObject;
  ParamCount: Integer; const Parameters: array of String);
var
  SL: TStringList;
begin
  if ParamCount > 0 then
  begin
    SL := TStringList.Create;
    SL.AddStrings(Parameters);
    myParseParams(SL);
    SL.Free;
  end;
  BringToFront;
end;

procedure TfrmGUIta.UpDownDurat2Click(Sender: TObject; Button: TUDBtnType);
var
  ob: TComboBox;
  r1, r2: double;
begin
  if LVjobs.Selected = nil then Exit;
  if (Sender = UpDownDurat1) then  ob := cmbDurationt1 else
  if (Sender = UpDownDurat2) then  ob := cmbDurationt2 else
  if (Sender = UpDownDurass1) then ob := cmbDurationss1 else
  if (Sender = UpDownDurass2) then ob := cmbDurationss2 else
  if (Sender = UpDownItsoffset) then ob := cmbItsoffset;
  r1 := myTimeStrToReal(ob.Text);
  r2 := 1 / myGetFPS(TJob(LVjobs.Selected.Data), ''); // duration for 1 frame = 1 / fps
  if Button = btPrev then r1 := r1 - r2 else
  if Button = btNext then r1 := r1 + r2;
  ob.Text := myRealToTimeStr(r1);
end;

procedure TfrmGUIta.xmyChange0(Sender: TObject);
var
  jo: TJob;
begin
  if bUpdFromCode then Exit;
  if myNoJo(jo) then Exit;
  jo.setval((Sender as TControl).Name, myGet2(Sender));
end;

procedure TfrmGUIta.xmyChange0o(Sender: TObject);
var
  jo: TJob;
begin
  if bUpdFromCode then Exit;
  if myNoJo(jo) then Exit;
  jo.setval((Sender as TControl).Name, myGet2(Sender));
  jo.setval(sMyTested, '');
  LVjobs.Selected.SubItems[3] := myCalcOutSize(jo);
end;

procedure TfrmGUIta.xmyChange0i(Sender: TObject);
var
  jo: TJob;
begin
  if bUpdFromCode then Exit;
  if myNoJo(jo) then Exit;
  jo.setval((Sender as TControl).Name, myGet2(Sender));
  if (Sender is TComboBox) then
  if (Sender as TComboBox).Items.IndexOf((Sender as TComboBox).Text) < 0 then
    (Sender as TComboBox).Font.Color := ColorErrorText.ButtonColor //clRed
  else
    (Sender as TComboBox).ParentFont := True;
end;

procedure TfrmGUIta.xmyChange1(Sender: TObject);
var
  l: integer;
  jo: TJob;
begin
  if bUpdFromCode then Exit;
  if myNoJo(jo) then Exit;
  if LVfiles.Selected = nil then Exit;
  l := StrToIntDef(LVfiles.Selected.Caption, -1);
  if (l >= 0) and (l <= High(jo.f)) then
    jo.f[l].setval((Sender as TControl).Name, myGet2(Sender));
end;

procedure TfrmGUIta.xmyChange2(Sender: TObject);
var
  jo: TJob;
  c: TCont;
begin
  if bUpdFromCode then Exit;
  if myNoJoC(jo, c) then Exit;
  c.setval((Sender as TControl).Name, myGet2(Sender));
end;

procedure TfrmGUIta.xmyChange2i(Sender: TObject);
var
  jo: TJob;
  c: TCont;
begin
  if bUpdFromCode then Exit;
  if myNoJoC(jo, c) then Exit;
  c.setval((Sender as TControl).Name, myGet2(Sender));
  if (Sender is TComboBox) then
  if (Sender as TComboBox).Items.IndexOf((Sender as TComboBox).Text) < 0 then
    (Sender as TComboBox).Font.Color := ColorErrorText.ButtonColor //clRed
  else
    (Sender as TComboBox).ParentFont := True;
end;

procedure TfrmGUIta.xmyChange2v(Sender: TObject);
var
  jo: TJob;
  c: TCont;
begin
  if bUpdFromCode then Exit;
  if myNoJoC(jo, c) then Exit;
  c.setval((Sender as TControl).Name, myGet2(Sender));
  edtBitrateV.Text := myCalcBRv(c);
  xmyChange2(edtBitrateV);
  jo.setval(sMyTested, '');
  LVjobs.Selected.SubItems[3] := myCalcOutSize(jo);
end;

procedure TfrmGUIta.xmyChange2a(Sender: TObject);
var
  jo: TJob;
  c: TCont;
begin
  if bUpdFromCode then Exit;
  if myNoJoC(jo, c) then Exit;
  c.setval((Sender as TControl).Name, myGet2(Sender));
  edtBitrateA.Text := myCalcBRa(c);
  xmyChange2(edtBitrateA);
  jo.setval(sMyTested, '');
  LVjobs.Selected.SubItems[3] := myCalcOutSize(jo);
end;

procedure TfrmGUIta.xmyCheckDir(Sender: TObject);
begin
  if DirectoryExistsUTF8(myExpandFN(myGet2(Sender), True)) then
    TComboBox(Sender).ParentFont := True
  else
    TWinControl(Sender).Font.Color := ColorErrorText.ButtonColor; //clRed;
end;

procedure TfrmGUIta.xmyCheckFile(Sender: TObject);
begin
  if FileExistsUTF8(myExpandFN(myGet2(Sender))) then
    TComboBox(Sender).ParentFont := True
  else
    TWinControl(Sender).Font.Color := ColorErrorText.ButtonColor; //clRed;
end;

procedure TfrmGUIta.xmySelDir(Sender: TObject);
var
  s, t: string;
begin
  s := myExpandFN(myGet2(Sender), True);
  t := '';
  if SelectDirectory(mes[18], s, t) then  //Find folder
  begin
    TComboBox(Sender).Text := myUnExpandFN(t);
    TComboBox(Sender).ParentFont := True;
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
  od.Title := mes[20] + ' - ' + t; //Find file
  if (w <> '') then
  begin
    sExt := ExtractFileExt(w);
    od.InitialDir := myExtrDirExist(ExtractFileDir(myExpandFN(w)));
    w := ExtractFileName(w);
  end
  else
    w := t;
  od.FileName := w;
  od.Filter := w + '|' + w
    + IfThen(sExt <> '', '|' + mes[17] + ' (*' + sExt + ')|*' + sExt) //Executable
    + '|' + mes[29] + ' (' + AllFilesMask + ')|' + AllFilesMask;      //All files
  od.DefaultExt := sExt;
  if od.Execute then
  begin
    TComboBox(Sender).Text := myUnExpandFN(od.FileName);
    TComboBox(Sender).ParentFont := True;
  end;
  od.Free;
end;

end.
