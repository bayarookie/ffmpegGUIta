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
  Spin, Buttons, IntfGraphics, LCLType, Menus, fpImage,
  Masks,
  {$IFDEF MSWINDOWS}
  Windows, Registry, mediainfodll,
  {$ELSE}
  clipbrd,
  {$ENDIF}
  ucalcul, ufrmcompare, ujobinfo, utaversion, UniqueInstance2, cpucount,
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
    btnMaskReset: TButton;
    btnMaskEdit: TButton;
    btnMediaInfo1: TButton;
    btnMediaInfo2: TButton;
    btnPlayOut: TButton;
    btnProfileSaveAs: TButton;
    btnCmdRun: TButton;
    btnLogSave: TButton;
    btnLogClear: TButton;
    btnPlayIn: TButton;
    btnTest: TButton;
    btnStop: TButton;
    btnStart: TButton;
    btnSuspend: TButton;
    btnCmdStop: TButton;
    btnAddTracks: TButton;
    btnAddStop: TButton;
    btnAddPause: TButton;
    btnTestStop: TButton;
    btnTestPause: TButton;
    btnCrop: TButton;
    btnAddFileSplit: TButton;
    btnAddScreenGrab: TButton;
    btnSaveSets: TButton;
    btnReset: TButton;
    chkDirOutStruct: TCheckBox;
    chkCreateDosFN: TCheckBox;
    chkCreateSymLink: TCheckBox;
    chkStopIfError: TCheckBox;
    chkMetadataWork: TCheckBox;
    chkxtermconv: TCheckBox;
    chkMetadataClear: TCheckBox;
    chkMetadataGet: TCheckBox;
    chkSaveOnExit: TCheckBox;
    chk1instance: TCheckBox;
    chkAddTracks: TCheckBox;
    chkDebug: TCheckBox;
    chkLangA1: TCheckBox;
    chkLangA2: TCheckBox;
    chkLangS1: TCheckBox;
    chkLangS2: TCheckBox;
    chkPlayer2: TCheckBox;
    chkPlayer3: TCheckBox;
    chkPlayInTerm: TCheckBox;
    chkxterm1str: TCheckBox;
    chkSaveFormPos: TCheckBox;
    chkSynColor: TCheckBox;
    chkUseEditedCmd: TCheckBox;
    chkConcat: TCheckBox;
    chkFilterComplex: TCheckBox;
    chkRunInMem: TCheckBox;
    chkRunInTerm: TCheckBox;
    chkOEM: TCheckBox;
    chkUseMasks: TCheckBox;
    chkx264Pass1fast: TCheckBox;
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
    cmbTestDurationss: TComboBox;
    cmbTestDurationt: TComboBox;
    cmbTagTitleV: TComboBox;
    cmbTagTitleA: TComboBox;
    cmbTagTitleS: TComboBox;
    cmbx264preset: TComboBox;
    cmbx264tune: TComboBox;
    cmbDurationt2: TComboBox;
    cmbAddOptsV: TComboBox;
    cmbFilterComplex: TComboBox;
    cmbTagTitleOut: TComboBox;
    cmbTagLangV: TComboBox;
    edtDirOut: TComboBox;
    edtDirTmp: TComboBox;
    edtffmpeg: TComboBox;
    edtffplay: TComboBox;
    edtffprobe: TComboBox;
    edtBitrateA: TLabeledEdit;
    edtFileExts: TComboBox;
    edtMediaInfo: TComboBox;
    edtOfn: TLabeledEdit;
    edtxterm: TComboBox;
    edtxtermopts: TComboBox;
    ImageList1: TImageList;
    edtBitrateV: TLabeledEdit;
    edtOfna: TLabeledEdit;
    lblTagLangV: TLabel;
    lblCpuCount: TLabel;
    lblAddOptsS: TLabel;
    lblAddOptsV: TLabel;
    lblAddOptsA: TLabel;
    lblTagLangA: TLabel;
    lblTagLangS: TLabel;
    lblTagTitleOut: TLabel;
    lblDirLast: TLabel;
    lblDirOut: TLabel;
    lblDirTmp: TLabel;
    lblffmpeg: TLabel;
    lblffplay: TLabel;
    lblffprobe: TLabel;
    lblMediaInfo: TLabel;
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
    lblTestStartDurationTime: TLabel;
    lblTagTitleV: TLabel;
    lblTagTitleA: TLabel;
    lblTagTitleS: TLabel;
    lblx264preset: TLabel;
    lblx264tune: TLabel;
    lblxterm: TLabel;
    lblxtermopts: TLabel;
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
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    PopupMenu3: TPopupMenu;
    spnCpuCount: TSpinEdit;
    Splitter1: TSplitter;
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
    TabDefSets: TTabSheet;
    TabVideo: TTabSheet;
    TabAudio: TTabSheet;
    TabSubtitle: TTabSheet;
    procedure btnAddFilesClick(Sender: TObject);
    procedure btnAddPauseClick(Sender: TObject);
    procedure btnAddScreenGrabClick(Sender: TObject);
    procedure btnAddStopClick(Sender: TObject);
    procedure btnCompareClick(Sender: TObject);
    procedure btnCmdStopClick(Sender: TObject);
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
    procedure btnTestPauseClick(Sender: TObject);
    procedure btnTestStopClick(Sender: TObject);
    procedure chk1instanceChange(Sender: TObject);
    procedure chkAddTracksChange(Sender: TObject);
    procedure chkFilterComplexChange(Sender: TObject);
    procedure chkLangA1Change(Sender: TObject);
    procedure chkLangA2Change(Sender: TObject);
    procedure chkLangS1Change(Sender: TObject);
    procedure chkLangS2Change(Sender: TObject);
    procedure chkPlayer2Change(Sender: TObject);
    procedure chkPlayer3Change(Sender: TObject);
    procedure chkSynColorChange(Sender: TObject);
    procedure chkMetadataWorkChange(Sender: TObject);
    procedure chkUseEditedCmdChange(Sender: TObject);
    procedure chkUseMasksChange(Sender: TObject);
    procedure cmbBitrateAChange(Sender: TObject);
    procedure cmbBitrateVChange(Sender: TObject);
    procedure cmbEncoderVChange(Sender: TObject);
    procedure cmbExtChange(Sender: TObject);
    procedure cmbExtPlayerChange(Sender: TObject);
    procedure cmbExtPlayerGetItems(Sender: TObject);
    procedure cmbExtSelect(Sender: TObject);
    procedure cmbFontGetItems(Sender: TObject);
    procedure cmbFontSelect(Sender: TObject);
    procedure cmbFormatChange(Sender: TObject);
    procedure cmbFormatSelect(Sender: TObject);
    procedure cmbLanguageChange(Sender: TObject);
    procedure cmbLanguageGetItems(Sender: TObject);
    procedure cmbProfileChange(Sender: TObject);
    procedure cmbProfileGetItems(Sender: TObject);
    procedure cmbRunCmdGetItems(Sender: TObject);
    procedure edtDirOutChange(Sender: TObject);
    procedure edtffmpegChange(Sender: TObject);
    procedure edtffmpegGetItems(Sender: TObject);
    procedure edtOfnChange(Sender: TObject);
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
    procedure LVjobsCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: boolean);
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
    procedure onAddFTerminate(Sender: TObject);
    procedure onCmdrTerminate(Sender: TObject);
    procedure onConvTerminate(Sender: TObject);
    procedure onTestTerminate(Sender: TObject);
    procedure ontAutoStart(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure TabCmdlineShow(Sender: TObject);
    procedure TabContRowsShow(Sender: TObject);
    procedure TabVideoShow(Sender: TObject);
    procedure UniqueInstance1OtherInstance(Sender: TObject;
      ParamCount: Integer; Parameters: array of String);
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
    procedure myAddFiles(params: TStrings);
    {$IFDEF MSWINDOWS}
    procedure myAddFilesAsAVS1(fns: TStrings);
    procedure myAddFilesAsAVS2(fns: TStrings);
    function myGetAvs(fn: string): string;
    {$ENDIF}
    procedure myAddFileSplit(files: TStrings);
    procedure myAddFilesPlus(li: TListItem; files: TStrings);
    procedure myAddFileStart;
    procedure myFindFiles(dir: string; c: array of TObject; bSet2: boolean = True);
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
    procedure myDefaultSets;
    procedure myToIni(Ini: TIniFile; s1, s2, s3: string; t: Integer = 0);
    procedure mySets1(Ini: TIniFile; s: string; c: array of TComponent; bRead: boolean);
    procedure mySets4(Ini: TIniFile; bRead: boolean);
    procedure mySets(bRead: boolean);
    procedure myFormPosLoad(Form: TForm; Ini: TIniFile);
    procedure myFormPosSave(Form: TForm; Ini: TIniFile);
    procedure myLanguage(bRead: boolean);
  public
    { public declarations }
    procedure myError(i: integer; s: string);
    function myExpandFN(fn: string; dir: boolean = False): string;
    function myUnExpandFN(fn: string): string;
    function myGetDosOut(cmd: TJob; mem: TSynMemo): integer;
    function myGetDosOut2(cmd: string; mem: TSynMemo): integer;
    function myGetFilter(jo: TJob; v: TCont; all: boolean = True): string;
    procedure myGetCmdFromJo(jo: TJob; var cmd: TJob; mode: integer = 0);
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
    procedure myCmdFill1(cmdline: string; var cmd: TJob);
    function myCmdExtr(cmd: TJob): string;
    function myCmdFillPr(fil: TFil; b: boolean; var pr: TProcessUTF8): string;
    procedure myShowCaption(s: string);
  end;

const
  iMaxMask: integer = 31;

var
  frmGUIta: TfrmGUIta;
  sCap, sDirApp, sInidir, sInifile, sLngfile: string;
  fs: TFormatSettings;
  mes: array [0..32] of string;
  tAutoStart: TTimer;
  bUpdFromCode: boolean;
  aThrs: array of TThreadConv;
  aMems: array of TSynMemo;
  ThreadTest: TThreadTest;
  ThreadAddF: TThreadAddF;
  ThreadCmdr: TThreadExec;
  sdiv: string = '--------------------------------------------------------------------------------';
  DuraAll: double;
  DuraAl2: integer;
  DuraJob: string;
  Files2Add: TList;
  Counter: integer;
  myUnik: TUniqueInstance;
  cDefaultSets: TCont;
  cCmdIni: TCont;
  iTabCount: integer;
  sMyDTformat: string = 'yyyy-mm-dd hh:nn:ss';
  sMyFilename: string = 'my_filename';
  sMyDOSfname: string = 'my_dosfname';
  sMyffprobe: string = 'my_ffprobe';
  sMyCompleted: string = 'my_Completed';
  sMyChecked: string = 'my_Checked';

implementation

uses ubyUtils, ufrmsplash, ufrmcrop, ufrmgrab;

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
  Ini.StripQuotes := False;
  s := 'Main';
  mySets1(Ini, s, [TabDefSets], bRead);
  if not chkUseMasks.Checked then
    mySets1(Ini, s, [cmbProfile], bRead);
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

procedure TfrmGUIta.myAddFiles(params: TStrings);
var
  i, j: integer;
  s, t, o, d: string;
  ST: TStringList;
  procedure my1(fn: string);
  var
    jo: TJob;
    i, j: integer;
    s, e: string;
    sl: TStringList;
    Ini: TIniFile;
  begin
    jo := TJob.Create;
    Inc(Counter);
    jo.setval('index', IntToStr(Counter));
    jo.setval(sMyCompleted, '0');
    s := myGetProfile(ExtractFileName(fn));
    jo.setval(cmbProfile.Name, s);
    {$IFDEF MSWINDOWS}
    s := myGetAnsiFN(AppendPathDelim(sInidir) + s);
    {$ELSE}
    s := AppendPathDelim(sInidir) + s;
    {$ENDIF}
    Ini := TIniFile.Create(UTF8ToSys(s));
    Ini.StripQuotes := False;
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
      s := AppendPathDelim(s) + Copy(ExtractFilePath(fn), Length(d) + 1, Length(fn));
    e := jo.getval(cmbExt.Name);
    jo.setval(edtOfn.Name, myGetOutFN(s, fn, e));
    jo.AddFile(fn);
    {$IFDEF MSWINDOWS}
    jo.setval(edtOfna.Name, myGetOutFNa(s, jo.f[0].getval(sMyDOSfname), e));
    {$ENDIF}
    if chkAddTracks.Checked then
    begin
      sl := TStringList.Create;
      if myGetSimilarFiles(fn, sl) then
      for j := 0 to sl.Count - 1 do
        jo.AddFile(sl[j]);
      sl.Free;
    end;
    Files2Add.Add(Pointer(jo));
  end;

begin
  for i := 0 to params.Count - 1 do
  begin
    s := params[i];
    d := ExtractFilePath(s);
    if DirectoryExistsUTF8(s) then
    begin
      ST := TStringList.Create;
      if myGetFileList(s, myGetExts, ST, True) then
      begin
        ST.Sort;
        for j := 0 to ST.Count - 1 do
          my1(ST[j]);
      end;
      ST.Free;
    end
    else if (s > '') and (s[1] = '-') or (s[1] = '/') then
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
        if (o <> '') and (o[1] = '"') then
          o := StringReplace(o, '"', '', [rfReplaceAll]);
      end
      else if (t = 'h') then
        ShowMessage(StringReplace(mes[2], '\n', #13, [rfReplaceAll]))
      else
        my1(s);
    end
    else
      my1(s);
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
  jo, cmd: TJob;
  s, d: string;
begin
  s := '4:00';
  if not InputQuery(mes[25], mes[26], s) then
    Exit;
  r := myTimeStrToReal(s);
  for i := 0 to files.Count - 1 do
  begin
    cmd := TJob.Create;
    cmd.AddFile(myStrReplace('$ffprobe'));
    cmd.f[0].AddStream;
    cmd.f[0].s[0].addval('1', '-hide_banner');
    cmd.f[0].s[0].addval('2', '-show_format');
    cmd.f[0].s[0].addval('3', files[i]);
    myGetDosOut(cmd, SynMemo2);
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
      jo := TJob.Create;
      Inc(Counter);
      jo.setval('index', IntToStr(Counter));
      jo.setval(sMyCompleted, '0');
      jo.setval(cmbDurationt2.Name, myRealToTimeStr(r, False));
      jo.AddFile(files[i]);
      jo.f[0].setval(cmbDurationss1.Name, myRealToTimeStr(k, False));
      Files2Add.Add(Pointer(jo));
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
  Files2Add.Add(Pointer(jo));
  myAddFileStart;
end;

procedure TfrmGUIta.myAddFileStart;
begin
  if (ThreadAddF <> nil) then
  begin
    {$IFDEF MSWINDOWS}
    if ThreadAddF.Suspended then
      ThreadAddF.Resume;
    {$ENDIF}
    Exit;
  end;
  ThreadAddF := TThreadAddF.Create(True);
  if Assigned(ThreadAddF.FatalException) then
    raise ThreadAddF.FatalException;
  ThreadAddF.OnTerminate := @onAddFTerminate;
  ThreadAddF.Start;
  btnAddPause.Enabled := True;
  btnAddStop.Enabled := True;
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

procedure TfrmGUIta.myGetCmdFromJo(jo: TJob; var cmd: TJob; mode: integer = 0);
var
  i, k, l, cf, cv, ca, cs, ct, cd: integer;
  c, si, fi: TCont;
  rd,
  rsi, rso, rst, rti, rto, rtt: double;
  ssi, sso, sst, sti, sto, stt,
  s, co, ty, fc2, fn, fb, ni, vi, au, su, ma,
  so, tmp, f1p, sp1, sp2, fn1, fn2, fno, fnoa: string;
  bfi: boolean;
  sl: TStringList;

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
            fi.addval('v', '-filter:v:' + ni);
            fi.addval('v', s);
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
        if (c.getval(cmbPass.Name) = '2') then
        begin
          tmp := myStrReplace('$dirtmp');
          if tmp <> '' then
          begin
            if not myDirExists(tmp, '') then
              Exit;
            tmp := AppendPathDelim(tmp);
          end;
          s := ' -passlogfile:v:' + ni + ' "' + tmp + 'ff-tmp' + jo.getval('index') + ni + '"';
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
            fi.addval('a', '-filter:a:' + ni);
            fi.addval('a', s);
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

  procedure myaddvals(s: string; a: TCont);
  var
    i: integer;
  begin
    sl := TStringList.Create;
    process.CommandToList(s, sl);
    for i := 0 to sl.Count - 1 do
      a.addval(IntToStr(i), sl[i]);
    sl.Free;
  end;

  procedure my2(s, outfn: string);
  var
    i: integer;
  begin
    l := cmd.AddFile(myStrReplace('$ffmpeg'));
    k := cmd.f[l].AddStream;
    for i := 0 to High(si.sv) do
      cmd.f[l].s[k].addval(IntToStr(i), si.sv[i]); //inputs
    for i := 0 to High(fi.sv) do
      cmd.f[l].s[k].addval(IntToStr(i), fi.sv[i]); //filters
    s := myStrReplace(s, jo);
    myaddvals(s, cmd.f[l].s[k]);
    cmd.f[l].s[k].addval('outfn', outfn);
  end;

begin
  //mode, 0 = convert, 1 = test, 2 = play, 3 = show cmdline
  if (jo.getval(chkUseEditedCmd.Name) = '1') and (mode = 0) then
  begin
    sl := TStringList.Create;
    sl.Text := jo.getval(memCmdlines.Name);
    for i := 0 to sl.Count - 1 do
    begin
      l := cmd.AddFile('');
      k := cmd.f[l].AddStream;
      cmd.f[l].s[k].addval('1', sl[i]);
    end;
    sl.Free;
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
  si := TCont.Create; //inputs
  fi := TCont.Create; //filters
  // input params
  for l := 0 to High(jo.f) do
  begin
    ssi := jo.f[l].getval(cmbDurationss1.Name);
    if (mode = 1) and (rso = 0) then
    begin
      rsi := myTimeStrToReal(ssi);
      if (rsi < rst) then
        ssi := sst;
    end;
    if ssi <> '' then begin si.addval('', '-ss'); si.addval('', ssi); end;
    sti := jo.f[l].getval(cmbDurationt1.Name);
    if (mode = 1) and (rto = 0) then
    begin
      rti := myTimeStrToReal(sti);
      if (rti = 0) or (rti > rtt) then
        sti := stt;
    end;
    if sti <> '' then begin si.addval('', '-t'); si.addval('', sti); end;
    s := jo.f[l].getval(cmbAddOptsI.Name);
    if s <> '' then myaddvals(s, si);
    {$IFDEF MSWINDOWS}
    s := jo.f[l].getval(sMyDOSfname);
    {$ELSE}
    s := jo.f[l].getval(sMyFilename);
    {$ENDIF}
    if LowerCase(ExtractFileExt(s)) = '.vob' then
    begin
      si.addval('', '-analyzeduration');
      si.addval('', '100M');
      si.addval('', '-probesize');
      si.addval('', '100M');
    end;
    si.addval('', '-i');
    si.addval('', s);
  end;
  bfi := (jo.getval(chkFilterComplex.Name) = '1')
      or (jo.getval(chkConcat.Name) = '1');
  // --- if concat ---
  if (jo.getval(chkConcat.Name) = '1') then
  begin
    fi.addval('c', '-filter_complex');
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
          fi.addval('c', '[' + fn + ':' + ni + ']');
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
          fi.addval('c', '[' + fn + ':' + ni + ']');
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
    fi.addval('c', 'concat=n=' + IntToStr(cf) + ':v=' + IntToStr(cv + 1) +
      ':a=' + IntToStr(ca + 1));
    myaddvals(fc2, fi);
  end
  else
  // --- mix mux ---
  begin
    if (jo.getval(chkFilterComplex.Name) = '1') then
    begin
      s := jo.getval(cmbFilterComplex.Name);
      fi.addval('c', '-filter_complex');
      fi.addval('c', s);
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
      fno := myGetOutFN(ExtractFilePath(fno), jo.f[0].getval(sMyFilename),  ExtractFileExt(fno));
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
  if (sp1 <> '') and (mode <> 2) then
  begin
    //didnt work on mp4; s := ' -c:a pcm_s16le -ar:a 4000 -ac:a 1'; //1st pass audio for better synchronisation
    s := vi + au + su + ma + sp1 + so; //1st pass
    my2(s, fn1);
  end;
  s := vi + au + su + ma + sp2 + so;  //2nd pass or 1 pass
  my2(s, fn2);
end;

function TfrmGUIta.myGetDosOut(cmd: TJob; mem: TSynMemo): integer;
var
  Buffer, t, fStatus: string;
  BytesAvailable: DWord;
  BytesRead: longint;
  i, j, l: integer;
  pr: TProcessUTF8;
begin
  mem.Clear;
  for l := 0 to High(cmd.f) do
  begin
    Result := -1;
    pr := TProcessUTF8.Create(nil);
    try
      t := frmGUIta.myCmdFillPr(cmd.f[l], False, pr);
      if chkDebug.Checked then
        memJournal.Lines.Add(t);
      mem.Lines.Add(t);
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
end;

function TfrmGUIta.myGetDosOut2(cmd: string; mem: TSynMemo): integer;
const
  READ_BYTES = 2048;
var
  MemStream: TMemoryStream;
  NumBytes, BytesRead: integer;
  pr: TProcessUTF8;
begin
  Result := -1;
  BytesRead := 0;
  MemStream := TMemoryStream.Create;
  pr := TProcessUTF8.Create(nil);
  try
    pr.CommandLine := cmd;
    pr.Options := [poUsePipes, poStderrToOutPut];
    pr.ShowWindow := swoHIDE;
    pr.Execute;
    // read while the process is running
    while pr.Running do begin
      MemStream.SetSize(BytesRead + READ_BYTES); // make sure we have room
      // try reading it
      NumBytes := pr.Output.Read((MemStream.Memory + BytesRead)^, READ_BYTES);
      if NumBytes > 0 then
        Inc(BytesRead, NumBytes)
      else                                       // no data, wait 10 ms
        Sleep(10);
    end;
    // read last part
    repeat
      MemStream.SetSize(BytesRead + READ_BYTES);
      NumBytes := pr.Output.Read((MemStream.Memory + BytesRead)^, READ_BYTES);
      if NumBytes > 0 then
        Inc(BytesRead, NumBytes);
    until NumBytes <= 0;
    MemStream.SetSize(BytesRead);
    mem.Lines.LoadFromStream(MemStream);
    Result := pr.ExitStatus;
  finally
    pr.Free;
    MemStream.Free;
  end;
end;

procedure TfrmGUIta.myFindFiles(dir: string; c: array of TObject; bSet2: boolean = True);
var
  SL: TStringList;
  i, j: integer;
  s: string;
begin
  SL := TStringList.Create;
  {$IFDEF MSWINDOWS}
  if myGetFileList(dir, '*.exe', SL, True) then
  for i := 0 to High(c) do
  if (c[i] is TComboBox) then
  begin
    s := LowerCase(Copy(TComboBox(c[i]).Name, 4, 100)) + '.exe';
    for j := 0 to SL.Count - 1 do
      if s = LowerCase(ExtractFileName(SL[j])) then
        TComboBox(c[i]).Items.Add(myUnExpandFN(SL[j]));
    if bSet2 and (TComboBox(c[i]).Items.Count > 0) then
      TComboBox(c[i]).ItemIndex := TComboBox(c[i]).Items.Count - 1;
  end;
  {$ELSE}
  for i := 0 to High(c) do
    if (c[i] is TComboBox) then
    begin
      s := myGet2(c[i]);
      if FileExistsUTF8(myExpandFN(ExtractFileName(s))) then
        TComboBox(c[i]).Items.Add(ExtractFileName(s));
      if myGetFileList(dir, ExtractFileName(s), SL, True) then
        for j := 0 to SL.Count - 1 do
          myAdd2cmb(TComboBox(c[i]), myUnExpandFN(SL[j]));
      if FileExistsUTF8(myExpandFN(s)) then
        myAdd2cmb(TComboBox(c[i]), s);
      if bSet2 and (TComboBox(c[i]).Items.Count > 0) then
        TComboBox(c[i]).ItemIndex := 0;
    end;
  {$ENDIF}
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

  function myGetList(const Path2: string): boolean;
  var
    i, nStatus: integer;
    b: boolean;
    SR: TSearchRec;
    SL: TStringList;
  begin
    SL := TStringList.Create;
    myGetListFromStr(Mask, ';', SL);
    nStatus := FindFirstUTF8(AppendPathDelim(Path2) + '*', 0, SR);
    while nStatus = 0 do
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
      if frm.bCancel then
        Break;
      nStatus := FindNextUTF8(SR);
    end;
    FindCloseUTF8(SR);
    Result := not frm.bCancel;
    if frm.bCancel then
      Exit;
    if subdir then
    begin
      nStatus := FindFirstUTF8(AppendPathDelim(Path2) + '*', faDirectory, SR);
      while nStatus = 0 do
      begin
        frm.Label1.Caption := SR.Name;
        Application.ProcessMessages;
        if ((SR.Attr and faDirectory) <> 0) and (SR.Name <> '.') and
          (SR.Name <> '..') then
          myGetList(AppendPathDelim(Path2) + SR.Name);
        if frm.bCancel then
          Break;
        nStatus := FindNextUTF8(SR);
      end;
      FindCloseUTF8(SR);
    end;
    SL.Free;
    Result := not frm.bCancel;
  end;

begin
  Application.CreateForm(TfrmSplash, frm);
  try
    frm.Caption := mes[3] + ': ' + Path + ' - ' + Mask;
    frm.btnCancel.Caption := mes[8];
    frm.Label1.Caption := mes[3];
    frm.Show;
    Result := myGetList(Path);
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
  with Form do
  begin
    Position := poDesigned;
    Top := Ini.ReadInteger(Name, 'Top', Top);
    Left := Ini.ReadInteger(Name, 'Left', Left);
    Height := Ini.ReadInteger(Name, 'Height', Height);
    Width := Ini.ReadInteger(Name, 'Width', Width);
    if (Height > Screen.Height) then
      Height := Screen.Height;
    if (Width > Screen.Width) then
      Width := Screen.Width;
    if (Top > Screen.Height - Height) then
      Top := Screen.Height - Height;
    if (Top < 0) then
      Top := 0;
    if (Left > Screen.Width - Width) then
      Left := Screen.Width - Width;
    if (Left < 0) then
      Left := 0;
    if Ini.ReadBool(Name, 'Maximized', False) then
      Form.WindowState := wsMaximized;
  end
  else
    Position := poDefault;
end;

procedure TfrmGUIta.myFormPosSave(Form: TForm; Ini: TIniFile);
begin
  if chkSaveFormPos.Checked then
  with Form do
    if (WindowState = wsMaximized) then
      myToIni(Ini, Name, 'Maximized', '1')
    else
    begin
      myToIni(Ini, Name, 'Maximized', '0');
      myToIni(Ini, Name, 'Top', IntToStr(Top));
      myToIni(Ini, Name, 'Left', IntToStr(Left));
      myToIni(Ini, Name, 'Height', IntToStr(Height));
      myToIni(Ini, Name, 'Width', IntToStr(Width));
    end;
end;

procedure TfrmGUIta.myLanguage(bRead: boolean);
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
  s1 := AppendPathDelim(sInidir) + cmbLanguage.Text;
  if bRead and not FileExistsUTF8(s1) then
    Exit;
  if bRead then
  begin
    mes[0] := 'Video files';
    mes[1] := 'All files (*)|*';
    mes[2] := 'Usage: ffmpegGUIta [-start] [-o:"folder"] [<files>...]\n-start   start converting\n-o:"output" set output dir to folder';
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
  end;
  Ini := TIniFile.Create(UTF8ToSys(s1));
  Ini.StripQuotes := False;
  s1 := 'Captions';
  s2 := 'Hints';
  s3 := 'Messages';
  myLng5([PageControl1, PageControl2, PageControl3]);
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
  btnTest.Enabled := b1 and (ThreadTest = nil);
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
begin
  for l := 0 to High(jo.f) do
  for k := 0 to High(jo.f[l].s) do
  begin
    t := jo.f[l].s[k].getval('codec_type');
    if t = 'video' then
      v := v + myGetCaptionCont(jo.f[l].s[k]) + '; '
    else if t = 'audio' then
      a := a + myGetCaptionCont(jo.f[l].s[k]) + '; '
    else if t = 'subtitle' then
      s := s + myGetCaptionCont(jo.f[l].s[k]) + '; ';
  end;
end;

function TfrmGUIta.myCalcOutSize(jo: TJob): string;
var
  r, q: double;
  k, l: integer;
  t, sExt: string;

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
  //get bitrate per second for every checked tracks
  r := 0;
  for l := 0 to High(jo.f) do
  for k := 0 to High(jo.f[l].s) do
    if jo.f[l].s[k].getval('Checked') = '1' then
    begin
      t := jo.f[l].s[k].getval('codec_type');
      if t = 'video' then
      begin
        if jo.f[l].s[k].getval(cmbEncoderV.Name) = 'copy' then
          q := StrToIntDef(jo.f[l].s[k].getval('bit_rate'), 0)
        else
          q := my1(jo.f[l].s[k].getval(edtBitRateV.Name));
      end
      else if t = 'audio' then
      begin
        if jo.f[l].s[k].getval(cmbEncoderA.Name) = 'copy' then
          q := StrToIntDef(jo.f[l].s[k].getval('bit_rate'), 0)
        else
          q := my1(jo.f[l].s[k].getval(edtBitRateA.Name));
      end
      else
        q := 0;
      if chkDebug.Checked then
        memJournal.Lines.Add('calc out size: ' + t + ' bitrate=' + FloatToStr(q));
      r := r + q;
    end;
  sExt := LowerCase(ExtractFileExt(jo.getval(edtOfn.Name)));
  //additional bitrate, something like index
  if sExt = '.mkv' then
    q := 4000
  else if sExt = '.avi' then
    q := 10000
  else if sExt = '.mp4' then
    q := 4000
  else if sExt = '.3gp' then
    q := 3000
  else
    q := 10000;  //other files?
  r := r + q;
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
  //header, in bytes, it is temporary. It needs some research in future
  if sExt = '.mkv' then
    q := 1360
  else if sExt = '.mp4' then
    q := 3860
  else
    q := 10000;
  r := r + q;
  if chkDebug.Checked then
    memJournal.Lines.Add('calc out size: out size=' + FloatToStr(r));
  Result := Trim(Format('%12.0n', [r], fs));
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
begin
  l := 0;
  k := 0;
  if Length(s) <> 3 then Exit;
  l := StrToIntDef(s[1], 0);
  k := StrToIntDef(s[3], 0);
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
  cmd: TJob;
begin
  cmbEncoderV.Items.Clear;
  cmbEncoderA.Items.Clear;
  cmbEncoderS.Items.Clear;
  cmd := TJob.Create;
  cmd.AddFile(myStrReplace('$ffmpeg'));
  cmd.f[0].AddStream;
  cmd.f[0].s[0].addval('1', '-hide_banner');
  cmd.f[0].s[0].addval('2', '-encoders');
  myGetDosOut(cmd, SynMemo2);
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
  cmd: TJob;
begin
  cmbFormat.Items.Clear;
  cmbFormat.Items.Add('');
  cmbExt.Items.Clear;
  cmbExt.Items.Add('');
  cmd := TJob.Create;
  cmd.AddFile(myStrReplace('$ffmpeg'));
  cmd.f[0].AddStream;
  cmd.f[0].s[0].addval('1', '-hide_banner');
  cmd.f[0].s[0].addval('2', '-formats');
  myGetDosOut(cmd, SynMemo2);
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
  i: integer;
  cmd: TJob;
  sl: TStringList;
begin
  Result := myGetOutFN(myStrReplace('$dirtmp'), 'tmp', '.bmp');
  if ss = '' then
    ss := '0';
  cmd := TJob.Create;
  cmd.AddFile(myStrReplace('$ffmpeg'));
  cmd.f[0].AddStream;
  cmd.f[0].s[0].addval('1', '-hide_banner');
  cmd.f[0].s[0].addval('2', '-ss');
  cmd.f[0].s[0].addval('3', ss);
  cmd.f[0].s[0].addval('4', '-i');
  cmd.f[0].s[0].addval('5', myGetAnsiFN(fn));
  sl := TStringList.Create;
  process.CommandToList(fv, sl);
  for i := 0 to sl.Count - 1 do
    cmd.f[0].s[0].addval('6', sl[i]);
  sl.Free;
  cmd.f[0].s[0].addval('7', '-frames');
  cmd.f[0].s[0].addval('8', '1');
  cmd.f[0].s[0].addval('9', '-f');
  cmd.f[0].s[0].addval('10', 'image2');
  cmd.f[0].s[0].addval('11', '-y');
  cmd.f[0].s[0].addval('12', Result);
  i := myGetDosOut(cmd, sm);
  if i = 0 then
    st.SimpleText := ''
  else
  begin
    st.SimpleText := mes[6] + ' ' + IntToStr(i);
    Result := '';
  end;
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
  v: TCont;
begin
  if stream <> '' then
  begin
    myGetFileStreamNums(stream, l, k);
    Result := myValFPS(jo.f[l].s[k].getval('avg_frame_rate'));
    if Result = 0 then
      Result := myValFPS(jo.f[l].s[k].getval('r_frame_rate'));
    if Result = 0 then
      Result := 30;
  end
  else
  begin
    for l := 0 to High(jo.f) do
    for k := 0 to High(jo.f[l].s) do
    begin
      v := jo.f[l].s[k];
      if (v.getval('Checked') = '1') and (v.getval('codec_type') = 'video') then
      begin
        Result := myValFPS(v.getval('avg_frame_rate'));
        if Result = 0 then
          Result := myValFPS(v.getval('r_frame_rate'));
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
  cmd: TJob;
begin
  cmd := TJob.Create;
  cmd.AddFile(myStrReplace('$ffmpeg'));
  cmd.f[0].AddStream;
  cmd.f[0].s[0].addval('1', '-hide_banner');
  s := jo.getval(cmbDurationss2.Name);
  if s <> '' then
  begin
    cmd.f[0].s[0].addval('2', '-ss');
    cmd.f[0].s[0].addval('3', s);
  end;
  {$IFDEF MSWINDOWS}
  s := jo.f[l].getval(sMyDOSfname);
  {$ELSE}
  s := jo.f[l].getval(sMyFilename);
  {$ENDIF}
  cmd.f[0].s[0].addval('8', '-i');
  cmd.f[0].s[0].addval('9', s);
  j := -1;
  for i := 0 to High(jo.f[l].s) do
  begin
    if jo.f[l].s[i].getval('codec_type') = 'video' then
      inc(j); //count video tracks
    if i = k then Break;
  end;
  cmd.f[0].s[0].addval('10', '-frames:v');
  cmd.f[0].s[0].addval('11', '20');
  cmd.f[0].s[0].addval('12', '-filter:v:' + IntToStr(j)); //video track number
  cmd.f[0].s[0].addval('13', 'framestep=60, cropdetect');
  cmd.f[0].s[0].addval('14', '-an');
  cmd.f[0].s[0].addval('15', '-sn');
  cmd.f[0].s[0].addval('16', '-map');
  cmd.f[0].s[0].addval('17', '0:' + IntToStr(k)); //stream number
  cmd.f[0].s[0].addval('18', '-f');
  cmd.f[0].s[0].addval('19', 'avi');
  cmd.f[0].s[0].addval('20', '-y');
  {$IFDEF MSWINDOWS}
  cmd.f[0].s[0].addval('21', 'NUL');
  {$ELSE}
  cmd.f[0].s[0].addval('21', '/dev/null');
  {$ENDIF}
  myGetDosOut(cmd, SynMemo2);
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
  begin
    memJournal.Lines.Add(myCmdExtr(cmd));
    memJournal.Lines.AddStrings(sl);
  end;
  sl.Free;
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
      Result := cmbProfile.Text;
  end
  else
  begin
    Result := cmbProfile.Text;
  end;
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
  begin
    if Pos('"', Str) > 0 then
    begin
      if Pos('''', Str) > 0 then
      begin
        Result := AnsiQuotedStr(Str, '''');
      end
      else
        Result := '''' + Str + '''';
    end
    else
      Result := '"' + Str + '"';
  end
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

procedure TfrmGUIta.myCmdFill1(cmdline: string; var cmd: TJob);
var
  i, j, l: integer;
  sl, st: TStringList;
begin
  st := TStringList.Create;
  st.Text := cmdline;
  for j := 0 to st.Count - 1 do
  if st[j] <> '' then
  begin
    sl := TStringList.Create;
    process.CommandToList(st[j], sl);
    l := cmd.AddFile(sl[0]);
    cmd.f[l].AddStream;
    for i := 1 to sl.Count - 1 do
      cmd.f[l].s[0].addval(IntToStr(i), sl[i]);
    sl.Free;
  end;
  st.Free;
end;

function TfrmGUIta.myCmdExtr(cmd: TJob): string;
var
  k, l: integer;
begin
  Result := '';
  for l := 0 to High(cmd.f) do
  begin
    Result := Result + myGetStr(cmd.f[l].getval(sMyFilename));
    for k := 0 to High(cmd.f[l].s) do
      Result := Result + myGetStr(cmd.f[l].s[k].sv);
    Result := Result + LineEnding;
  end;
end;

function TfrmGUIta.myCmdFillPr(fil: TFil; b: boolean; var pr: TProcessUTF8): string;
var
  scmd, t: string;
  i, k: integer;
  sl: TStringList;
begin
  scmd := fil.getval(sMyFilename);
  if (scmd = '') then
  begin
    if (Length(fil.s) > 0) and (Length(fil.s[0].sv) > 0) then
      t := fil.s[0].sv[0];
    if b then
    begin
      pr.CommandLine := edtxterm.Text + ' ' + edtxtermopts.Text + ' ' + t;
      Result := myDTtoStr(sMyDTformat, Now) + ' - ' + edtxterm.Text + ' ' + edtxtermopts.Text + ' ' + t;
    end
    else
    begin
      pr.CommandLine := t;
      Result := myDTtoStr(sMyDTformat, Now) + ' - ' + t;
    end;
    Exit;
  end;
  t := '';
  for k := 0 to High(fil.s) do
    t := t + myGetStr(fil.s[k].sv);
  if b then
  begin
    pr.Executable := edtxterm.Text;
    sl := TStringList.Create;
    process.CommandToList(edtxtermopts.Text, sl);
    for i := 0 to sl.Count - 1 do
      pr.Parameters.Add(sl[i]);
    sl.Free;
    if chkxterm1str.Checked then
      pr.Parameters.Add(myGetStr(scmd) + ' ' + t)
    else
    begin
      for k := 0 to High(fil.s) do
      for i := 0 to High(fil.s[k].sv) do
        pr.Parameters.Add(fil.s[k].sv[i]);
    end;
    Result := myDTtoStr(sMyDTformat, Now) + ' - ' + edtxterm.Text + ' ' + edtxtermopts.Text + ' ' + scmd + ' ' + t
  end
  else
  begin
    pr.Executable := scmd;
    for k := 0 to High(fil.s) do
    for i := 0 to High(fil.s[k].sv) do
      pr.Parameters.Add(fil.s[k].sv[i]);
    Result := myDTtoStr(sMyDTformat, Now) + ' - ' + scmd + ' ' + t;
  end;
end;

procedure TfrmGUIta.myShowCaption(s: string);
begin
  frmGUIta.Caption := sCap
    + IfThen(DuraAll > 0, ', ' + mes[21] + ' = ' + myRealToTimeStr(DuraAll))
    + IfThen(DuraAl2 > 0, ', ' + mes[27] + ' = ' + IntToStr(DuraAl2))
    + IfThen(DuraJob <> '', ', ' + mes[32] + ' = ' + DuraJob)
    + IfThen(s <> '', ', ' + s);
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

procedure TfrmGUIta.btnAddPauseClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  if ThreadAddF <> nil then
    if ThreadAddF.Suspended then
      ThreadAddF.Resume
    else
      ThreadAddF.Suspend;
  {$ENDIF}
end;

procedure TfrmGUIta.btnAddScreenGrabClick(Sender: TObject);
var
  jo: TJob;
  s: string;
  li: TListItem;
  frmG: TfrmGrab;
begin
  Application.CreateForm(TfrmGrab, frmG);
  frmG.Caption := btnAddScreenGrab.Caption;
  if frmG.ShowModal = mrOK then
  begin
    jo := TJob.Create;
    Inc(Counter);
    jo.setval('index', IntToStr(Counter));
    jo.setval(sMyCompleted, '0');
    jo.AddFile(frmG.ComboBox1.Text);
    jo.f[0].setval(cmbAddOptsI.Name, frmG.ComboBox2.Text);
    jo.f[0].setval(sMyffprobe, '1');
    jo.AddFile(frmG.ComboBox3.Text);
    jo.f[1].setval(cmbAddOptsI.Name, frmG.ComboBox4.Text);
    jo.f[1].setval(sMyffprobe, '1');
    if Trim(edtDirOut.Text) <> '' then
      s := Trim(edtDirOut.Text)
    else
      s := edtDirTmp.Text;
    jo.setval(edtOfn.Name, myGetOutFN(s, 'screengrab', '.mpg'));
    SetLength(jo.f[0].s, 1);
    jo.f[0].s[0] := TCont.Create;
    jo.f[0].s[0].setval('codec_type', 'video');
    jo.f[0].s[0].setval('Checked', '1');
    jo.f[0].s[0].setval('TAG:title', 'screengrab');
    SetLength(jo.f[1].s, 1);
    jo.f[1].s[0] := TCont.Create;
    jo.f[1].s[0].setval('codec_type', 'audio');
    jo.f[1].s[0].setval('Checked', '1');
    jo.f[1].s[0].setval('TAG:title', 'audiograb');
    SetLength(jo.m, 2);
    jo.m[0] := '0:0';
    jo.m[1] := '1:0';
    li := LVjobs.Items.Add;
    li.Checked := True;
    li.Caption := IntToStr(Counter);
    li.SubItems.Add('screen grab');
    li.SubItems.Add('0');
    li.SubItems.Add('0');
    li.SubItems.Add('0');
    inc(DuraAl2);
    myShowCaption('');
    li.SubItems.Add('');
    li.SubItems.Add('');
    li.Data := Pointer(jo);
    if (LVjobs.Items.Count = 1) then
      LVjobs.Items[0].Selected := True;
  end;
  frmGrab.Free;
end;

procedure TfrmGUIta.btnAddStopClick(Sender: TObject);
begin
  if ThreadAddF <> nil then
  begin
    ThreadAddF.Terminate;
    if ThreadAddF.pr <> nil then
      ThreadAddF.pr.Terminate(-2);
    {$IFDEF MSWINDOWS}
    if ThreadAddF.Suspended then
      ThreadAddF.Resume;
    {$ENDIF}
  end;
end;

procedure TfrmGUIta.btnCompareClick(Sender: TObject);
var
  Ini: TIniFile;
  jo: TJob;
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
    with jo.f[l].s[k] do
      if getval('Checked') = '1' then
      begin
        ty := getval('codec_type');
        if (ty = 'video') and (iv = '') then
        begin
          nv := l;
          iv := IntToStr(k);
          if not bfi then
          begin
            fv := myGetFilter(jo, jo.f[l].s[k], False); //resize only filter
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

procedure TfrmGUIta.btnCmdStopClick(Sender: TObject);
begin
  if ThreadCmdr <> nil then
  begin
    ThreadCmdr.Terminate;
    if ThreadCmdr.pr <> nil then
      ThreadCmdr.pr.Terminate(-2);
    {$IFDEF MSWINDOWS}
    if ThreadCmdr.Suspended then
      ThreadCmdr.Resume;
    {$ENDIF}
  end;
end;

procedure TfrmGUIta.btnCmdRunClick(Sender: TObject);
var
  s: string;
  jo, cmd: TJob;
  sl: TStringList;
  i: integer;
  p: TProcessUTF8;
begin
  if LVjobs.Selected <> nil then
    jo := TJob(LVjobs.Selected.Data);
  s := myStrReplace(cmbRunCmd.Text, jo);
  sl := TStringList.Create;
  process.CommandToList(s, sl);
  if sl.Count > 0 then
  begin
    cmd := TJob.Create;
    cmd.AddFile(sl[0]);
    cmd.f[0].AddStream;
    for i := 1 to sl.Count - 1 do
      cmd.f[0].s[0].addval(IntToStr(i), sl[i]);
  end;
  sl.Free;
  if chkRunInTerm.Checked then
  begin
    p := TProcessUTF8.Create(nil);
    myCmdFillPr(cmd.f[0], True, p);
    p.Execute;
    p.Free;
  end
  else
  if chkRunInMem.Checked then
    myGetDosOut(cmd, SynMemo2)
  else
  begin
    if (ThreadCmdr <> nil) then
    begin
      {$IFDEF MSWINDOWS}
      if ThreadCmdr.Suspended then
        ThreadCmdr.Resume;
      {$ENDIF}
      Exit;
    end;
    ThreadCmdr := TThreadExec.Create(s, chkOEM.Checked, SynMemo2);
    if Assigned(ThreadCmdr.FatalException) then
      raise ThreadCmdr.FatalException;
    ThreadCmdr.OnTerminate := @onCmdrTerminate;
    ThreadCmdr.Start;
    btnCmdRun.Enabled := False;
    btnCmdStop.Enabled := True;
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
  co: TCont;
  frmCrop: TfrmCrop;
  Ini: TIniFile;
  iv, fn: string;
begin
  if myCantUpd(2) then
    Exit;
  jo := TJob(LVjobs.Selected.Data);
  myGetFileStreamNums(LVstreams.Selected.Caption, l, k);
  co := jo.f[l].s[k];
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
  myGetWHXYcrop(co, w, h, x, y);
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
  cmbProfileGetItems(nil);
  frmM.ComboBox3.Items.AddStrings(cmbProfile.Items);
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
  cmbProfileGetItems(nil);
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
  LVmasks.Clear;
  li := LVmasks.Items.Add;
  li.Checked := True;
  li.Caption := '*';
  li.SubItems.Add('.jp*g;.png');
  li.SubItems.Add('resize to png w160.ini');
  li := LVmasks.Items.Add;
  li.Checked := False;
  li.Caption := '*';
  li.SubItems.Add('.mp3;.ac3;.wav');
  li.SubItems.Add('sound to mp3 128k.ini');
  li := LVmasks.Items.Add;
  li.Checked := False;
  li.Caption := 'anim*';
  li.SubItems.Add('.avi;.mkv;.vob;.mp*g;.mp4;.mov;.flv;.3gp;.3g2;.asf;.wmv;.m2ts;.ts;.ogv;.webm;.rm;.qt');
  li.SubItems.Add('libx264 slow animation-libvo_aacenc-matroska.ini');
  li := LVmasks.Items.Add;
  li.Checked := True;
  li.Caption := '*';
  li.SubItems.Add('.avi;.mkv;.vob;.mp*g;.mp4;.mov;.flv;.3gp;.3g2;.asf;.wmv;.m2ts;.ts;.ogv;.webm;.rm;.qt');
  li.SubItems.Add('libx264 slow film w720-libvo_aacenc-matroska.ini');
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
  jo, cmd: TJob;
  c: TCont;
  s, ss, t, vf, af, vn, an, sn: string;
  k, l, filenum: integer;
  bfi: boolean;
  p: TProcessUTF8;
begin
  if LVjobs.Selected = nil then
    Exit;
  jo := TJob(LVjobs.Selected.Data);
  if chkPlayInTerm.Checked then
  begin
    cmd := TJob.Create;
    myGetCmdFromJo(jo, cmd, 2);
    cmd.f[0].s[0].addval('', '|');
    cmd.f[0].s[0].addval('', myStrReplace('$ffplay'));
    cmd.f[0].s[0].addval('', '-');
    p := TProcessUTF8.Create(nil);
    s := myCmdFillPr(cmd.f[0], chkPlayInTerm.Checked, p);
    if chkDebug.Checked then
      memJournal.Lines.Add(s);
    p.Execute;
    p.Free;
  end
  else
  begin
    cmd := TJob.Create;
    cmd.AddFile(myStrReplace('$ffplay'));
    cmd.f[0].AddStream;
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
            cmd.f[0].s[0].addval('1', '-vst');
            cmd.f[0].s[0].addval('2', IntToStr(k));
            if not bfi then
            begin
              vf := myGetFilter(jo, c);
              if vf <> '' then
              begin
                cmd.f[0].s[0].addval('3', '-vf');
                cmd.f[0].s[0].addval('4', vf);
              end;
            end;
          end
          else if (s = 'audio') and (an = '') then
          begin
            filenum := l;
            an := ' -ast ' + IntToStr(k);
            cmd.f[0].s[0].addval('5', '-ast');
            cmd.f[0].s[0].addval('6', IntToStr(k));
            if not bfi then
            begin
              af := myGetFilter(jo, c);
              if af <> '' then
              begin
                cmd.f[0].s[0].addval('7', '-af');
                cmd.f[0].s[0].addval('8', af);
              end;
            end;
          end
          else if (s = 'subtitle') and (sn = '') then
          begin
            sn := ' -sst ' + IntToStr(k);
            cmd.f[0].s[0].addval('9', '-sst');
            cmd.f[0].s[0].addval('10', IntToStr(k));
          end;
        end;
      end;
    end;
    if vn = '' then
      cmd.f[0].s[0].addval('11', '-vn');
    if an = '' then
      cmd.f[0].s[0].addval('12', '-an');
    if sn = '' then
      cmd.f[0].s[0].addval('13', '-sn'); //ffplay 1.0.10 - Missing argument for option 'sn'
    l := filenum;
    if (l < 0) or (l > High(jo.f)) then
      l := 0;
    ss := jo.f[l].getval(cmbDurationss1.Name);
    if ss <> '' then
    begin
      cmd.f[0].s[0].addval('14', '-ss');
      cmd.f[0].s[0].addval('15', ss);
    end
    else
    begin
      ss := jo.getval(cmbDurationss2.Name);
      if ss <> '' then
      begin
        cmd.f[0].s[0].addval('16', '-ss');
        cmd.f[0].s[0].addval('17', ss);
      end;
    end;
    t := jo.f[l].getval(cmbDurationt1.Name);
    if t <> '' then
    begin
      cmd.f[0].s[0].addval('18', '-t');
      cmd.f[0].s[0].addval('19', t);
    end
    else
    begin
      t := jo.getval(cmbDurationt2.Name);
      if t <> '' then
      begin
        cmd.f[0].s[0].addval('19', '-t');
        cmd.f[0].s[0].addval('20', t);
      end;
    end;
    {$IFDEF MSWINDOWS}
    s := jo.f[l].getval(sMyDOSfname);
    {$ELSE}
    s := jo.f[l].getval(sMyFilename);
    {$ENDIF}
    cmd.f[0].s[0].addval('21', '-i');
    cmd.f[0].s[0].addval('22', s);
    myGetDosOut(cmd, SynMemo2);
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
    myOpenDoc(s)
  else
  if chkPlayer3.Checked and FileExistsUTF8(myExpandFN(cmbExtPlayer.Text)) then
    myExecProc(myExpandFN(cmbExtPlayer.Text), [s])
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
    Ini.StripQuotes := False;
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

procedure TfrmGUIta.myDefaultSets;
var
  i: integer;
begin
  for i := 0 to Panel13.ControlCount - 1 do
    cDefaultSets.setval(Panel13.Controls[i].Name, myGet2(Panel13.Controls[i]));
  for i := 0 to Panel15.ControlCount - 1 do
    cDefaultSets.setval(Panel15.Controls[i].Name, myGet2(Panel15.Controls[i]));
  for i := 0 to TabDefSets.ControlCount - 1 do
    cDefaultSets.setval(TabDefSets.Controls[i].Name, myGet2(TabDefSets.Controls[i]));
  cDefaultSets.setval(chkMetadataWork.Name, myGet2(chkMetadataWork));
  cDefaultSets.setval(chkMetadataClear.Name, myGet2(chkMetadataClear));
  cDefaultSets.setval(chkConcat.Name, myGet2(chkConcat));
  cDefaultSets.setval(chkFilterComplex.Name, myGet2(chkFilterComplex));
  cDefaultSets.setval(chkx264Pass1fast.Name, myGet2(chkx264Pass1fast));
end;

procedure TfrmGUIta.btnResetClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Panel13.ControlCount - 1 do
    mySet2(Panel13.Controls[i], cDefaultSets.getval(Panel13.Controls[i].Name));
  for i := 0 to Panel15.ControlCount - 1 do
    mySet2(Panel15.Controls[i], cDefaultSets.getval(Panel15.Controls[i].Name));
  for i := 0 to TabDefSets.ControlCount - 1 do
    mySet2(TabDefSets.Controls[i], cDefaultSets.getval(TabDefSets.Controls[i].Name));
end;

procedure TfrmGUIta.btnSaveSetsClick(Sender: TObject);
begin
  mySets(False);
end;

procedure TfrmGUIta.btnStartClick(Sender: TObject);
var
  i: integer;
  t: TTabSheet;
begin
  btnStart.Enabled := False;
  if (spnCpuCount.Value = 0) then
    spnCpuCount.Value := 1;
  if ((High(aThrs) + 1) <> spnCpuCount.Value) then
  begin
    SetLength(aThrs, spnCpuCount.Value);
    SetLength(aMems, spnCpuCount.Value);
  end;
  for i := Low(aThrs) to High(aThrs) do
  begin
    if PageControl3.PageCount > iTabCount + i then
      t := PageControl3.Pages[iTabCount + i]
    else
    begin
      t := PageControl3.AddTabSheet;
      t.Caption := mes[30] + ' ' + IntToStr(i + 1);
    end;
    if aMems[i] = nil then
    begin
      aMems[i] := TSynMemo.Create(t);
      aMems[i].Parent := t;
      aMems[i].Align := alClient;
      aMems[i].Color := clWindow;
      aMems[i].Font.Color := clWindowText;
      aMems[i].Highlighter := SynUNIXShellScriptSyn1;
    end;
    aThrs[i] := TThreadConv.Create(i);
    if Assigned(aThrs[i].FatalException) then
      raise aThrs[i].FatalException;
    aThrs[i].OnTerminate := @onConvTerminate;
    aThrs[i].Start;
    Sleep(2);
  end;
  while PageControl3.PageCount > iTabCount + 1 + High(aThrs) do
    PageControl3.Pages[PageControl3.PageCount - 1].Destroy;
  btnSuspend.Enabled := True;
  btnStop.Enabled := True;
  if chkDebug.Checked then
    memJournal.Lines.Add('Threads started: ' + IntToStr(High(aThrs) + 1));
  PageControl3.ActivePageIndex := PageControl3.PageCount - 1;
end;

procedure TfrmGUIta.btnStopClick(Sender: TObject);
var
  i: integer;
begin
  for i := Low(aThrs) to High(aThrs) do
  begin
    if (aThrs[i] <> nil) then
    begin
      aThrs[i].pr.Input.WriteAnsiString('q'); //if ffmpeg
      Sleep(1000);
      aThrs[i].Terminate;
      if aThrs[i].pr <> nil then
        aThrs[i].pr.Terminate(-2);
      {$IFDEF MSWINDOWS}
      if aThrs[i].Suspended then
        aThrs[i].Resume;
      {$ENDIF}
    end;
  end;
end;

procedure TfrmGUIta.btnSuspendClick(Sender: TObject);
{$IFDEF MSWINDOWS}
var
  i: integer;
  s: string;
{$ENDIF}
begin
  {$IFDEF MSWINDOWS}
  s := '';
  for i := Low(aThrs) to High(aThrs) do
  begin
    if (aThrs[i] <> nil) then
    begin
      if aThrs[i].Suspended then
      begin
        aThrs[i].Resume;
        s := s + ' process ' + IntToStr(i + 1) + ' continued';
      end
      else
      begin
        aThrs[i].Suspend;
        s := s + ' process ' + IntToStr(i + 1) + ' suspended';
      end;
    end;
  end;
  StatusBar1.SimpleText := s;
  {$ENDIF}
end;

procedure TfrmGUIta.btnTestClick(Sender: TObject);
begin
  if LVjobs.Selected = nil then
    Exit;
  if (ThreadTest <> nil) then
  begin
    {$IFDEF MSWINDOWS}
    if ThreadTest.Suspended then
      ThreadTest.Resume
    else
      ThreadTest.Suspend;
    {$ENDIF}
    Exit;
  end;
  ThreadTest := TThreadTest.Create(LVjobs.Selected);
  if Assigned(ThreadTest.FatalException) then
    raise ThreadTest.FatalException;
  ThreadTest.OnTerminate := @onTestTerminate;
  ThreadTest.Start;
  btnTest.Enabled := False;
  btnTestPause.Enabled := True;
  btnTestStop.Enabled := True;
  PageControl3.ActivePage := TabConsole3;
end;

procedure TfrmGUIta.btnTestPauseClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  if ThreadTest <> nil then
    if ThreadTest.Suspended then
      ThreadTest.Resume
    else
      ThreadTest.Suspend;
  {$ENDIF}
end;

procedure TfrmGUIta.btnTestStopClick(Sender: TObject);
begin
  if ThreadTest <> nil then
  begin
    if ThreadTest.pr.Input <> nil then
      ThreadTest.pr.Input.WriteAnsiString('q');
    Sleep(1000);
    ThreadTest.Terminate;
    if ThreadTest.pr <> nil then
      ThreadTest.pr.Terminate(-2);
    {$IFDEF MSWINDOWS}
    if ThreadTest.Suspended then
      ThreadTest.Resume;
    {$ENDIF}
  end;
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
  cmbAddTracks.Enabled := chkAddTracks.Checked;
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
  cmbExtPlayer.Enabled := chkPlayer3.Checked;
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
  b, b2, b3, b4, b5: boolean;
  i: integer;
  s: string;
  c: TWinControl;
begin
  if (Sender is TComboBox) then
  begin
    with (Sender as TComboBox) do
    if Items.IndexOf(Text) < 0 then
      Font.Color := clRed
    else
      Font.Color := clWindowText;
  end;
  s := TComboBox(Sender).Text;
  b := (s <> 'copy');
  b2 := b and not chkFilterComplex.Checked;
  b3 := (Pos('x264', s) > 0);
  b4 := (Pos('x265', s) > 0);
  b5 := b and chkMetadataWork.Checked;
  c := TControl(Sender).Parent;
  for i := 0 to c.ControlCount - 1 do
    if c.Controls[i].Name <> TControl(Sender).Name then
      c.Controls[i].Enabled := (b and (c.Controls[i].Tag = 0))
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
  if cmbExt.Items.IndexOf(s) < 0 then
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
  cmbFormat.ItemIndex := cmbExt.ItemIndex;
  xmyChange0(cmbFormat);
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
  if cmbFormat.Items.IndexOf(cmbFormat.Text) < 0 then
    cmbFormat.Font.Color := clRed
  else
    cmbFormat.Font.Color := clWindowText;
  xmyChange0(Sender);
end;

procedure TfrmGUIta.cmbFormatSelect(Sender: TObject);
begin
  cmbExt.ItemIndex := cmbFormat.ItemIndex;
  cmbExtChange(Sender);
end;

procedure TfrmGUIta.cmbLanguageChange(Sender: TObject);
begin
  if FileExistsUTF8(AppendPathDelim(sInidir) + cmbLanguage.Text) then
    myLanguage(True);
end;

procedure TfrmGUIta.cmbLanguageGetItems(Sender: TObject);
begin
  cmbLanguage.Items.Clear;
  myGetFileList(sInidir, '*.lng', cmbLanguage.Items, False, False);
  cmbLanguage.Sorted := True;
end;

procedure TfrmGUIta.cmbProfileChange(Sender: TObject);
var
  s, c, se: string;
  Ini: TIniFile;
  jo: TJob;
  i, k, l: integer;
  t: TTabSheet;
begin
  s := AppendPathDelim(sInidir) + cmbProfile.Text;
  if not FileExistsUTF8(s) then
  begin
    TWinControl(Sender).Font.Color := clRed;
    Exit;
  end
  else
    TWinControl(Sender).Font.Color := clWindowText;
  if myCantUpd(0) then
    Exit;
  {$IFDEF MSWINDOWS}
  s := myGetAnsiFN(s);
  {$ENDIF}
  Ini := TIniFile.Create(UTF8ToSys(s));
  Ini.StripQuotes := False;
  jo := TJob(LVjobs.Selected.Data);
  jo.setval(cmbProfile.Name, cmbProfile.Text);
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
      c := jo.f[l].s[k].getval('codec_type');
      if c = 'video' then
        t := TabVideo
      else if c = 'audio' then
        t := TabAudio
      else if c = 'subtitle' then
        t := TabSubtitle
      else
        Continue;
      for i := 0 to t.ControlCount - 1 do
      if not (t.Controls[i].Tag in [1, 3]) then
      begin
        s := Ini.ReadString(c, t.Controls[i].Name, '');
        jo.f[l].s[k].setval(t.Controls[i].Name, s);
      end;
      if c = 'video' then
        jo.f[l].s[k].setval(edtBitrateV.Name, myCalcBRv(jo.f[l].s[k]))
      else if c = 'audio' then
        jo.f[l].s[k].setval(edtBitrateA.Name, myCalcBRa(jo.f[l].s[k]));
    end;
  end;
  Ini.Free;
  LVjobs.Selected.SubItems[2] := myCalcOutSize(jo);
  LVjobsSelectItem(Sender, LVjobs.Selected, True);
end;

procedure TfrmGUIta.cmbProfileGetItems(Sender: TObject);
begin
  cmbProfile.Items.Clear;
  myGetFileList(sInidir, '*.ini', cmbProfile.Items, False, False);
  cmbProfile.Sorted := True;
end;

procedure TfrmGUIta.cmbRunCmdGetItems(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to High(cCmdIni.sk) do
    myAdd2cmb(cmbRunCmd, cCmdIni.sk[i]);
end;

procedure TfrmGUIta.edtDirOutChange(Sender: TObject);
begin
  xmyCheckDir(Sender);
  chkDirOutStruct.Enabled := edtDirOut.Text <> '';
end;

procedure TfrmGUIta.edtffmpegChange(Sender: TObject);
var
  s: string;
begin
  s := myExpandFN(myGet2(Sender));
  if FileExistsUTF8(s) then
  begin
    myFillEnc;
    myFillFmt;
  end;
  xmyCheckFile(Sender);
end;

procedure TfrmGUIta.edtffmpegGetItems(Sender: TObject);
var
  s, t: string;
begin
  if TComboBox(Sender).Items.Count = 0 then
  begin
    s := sDirApp;
    t := Copy(TComboBox(Sender).Name, 4, 100);
    if not InputQuery(mes[20] + ' ' + t, mes[28], s) then
      Exit;
    myFindFiles(s, [Sender], False);
  end;
end;

procedure TfrmGUIta.edtOfnChange(Sender: TObject);
var
  sd, se: string;
begin
  sd := ExtractFileDir(edtOfn.Text);
  if (sd = '') or DirectoryExistsUTF8(sd) then
    TWinControl(Sender).Font.Color := clWindowText
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
end;

procedure TfrmGUIta.edtxtermSelect(Sender: TObject);
begin
  if edtxterm.Text = 'cmd.exe' then begin
    edtxtermopts.Text := '/c';
    chkxterm1str.Checked := False;
  end else
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
  end;
end;

procedure TfrmGUIta.FormCreate(Sender: TObject);
var
  b: boolean;
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
  iTabCount := PageControl3.PageCount;
  //get inifile location
  s := SysToUTF8(Application.ExeName);
  sDirApp := ExtractFilePath(s);
  if DirectoryIsWritable(sDirApp) then
    sInidir := sDirApp
  else
    sInidir := GetAppConfigDirUTF8(False, True);
  sInifile := AppendPathDelim(sInidir) + ExtractFileNameOnly(s) + '.cfg';
  b := FileExistsUTF8(sInifile);
  //hide some unused components
  {$IFDEF MSWINDOWS}
  btnAddScreenGrab.Visible := False; //not tested
  {$ELSE}
  btnAddFilesAsAvs1.Visible := False;
  btnAddFilesAsAvs2.Visible := False;
  btnSuspend.Visible := False; //pause external process doesnt work on linux
  btnAddPause.Visible := False;
  btnTestPause.Visible := False;
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
  edtDirOut.Text := 'C:\TEMP';
  edtMediaInfo.Text := 'MediaInfo.exe';
  cmbExtPlayer.Text := 'wmplayer.exe';
  cmbDirLast.Text := 'C:\';
  edtxterm.Text := 'cmd.exe';
  edtxterm.Items.Add('cmd.exe');
  edtxtermopts.Text := '/c';
  edtxtermopts.Items.Add('/c');
  edtxtermopts.Items.Add('/k');
  {$ELSE}
  edtffmpeg.Text := 'ffmpeg';
  edtffplay.Text := 'ffplay';
  edtffprobe.Text:= 'ffprobe';
  edtDirTmp.Text := '/tmp';
  edtDirOut.Text := '$HOME';
  edtMediaInfo.Text:= 'mediainfo-gui';
  cmbExtPlayer.Text := 'mplayer';
  cmbDirLast.Text := '$HOME';
  cmbFont.Text := 'Ubuntu';
  edtxterm.Text := '/bin/sh';
  edtxtermopts.Text := '-c';
  edtxterm.Items.Add('/bin/sh');
  edtxtermopts.Items.Add('-c');
  edtxterm.Items.Add('/usr/bin/xterm');
  edtxtermopts.Items.Add('-e');
  edtxterm.Items.Add('/usr/bin/konsole');
  edtxtermopts.Items.Add('--nofork -e');
  edtxtermopts.Items.Add('--nofork --hold -e');
  edtxterm.Items.Add('/usr/bin/gnome-terminal');
  edtxtermopts.Items.Add('-x');
  chkxterm1str.Checked := True;
  {$ENDIF}
  bUpdFromCode := False;
  chkSynColor.Checked := myWindowColorIsDark;
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
  //save defaults to containers
  myDefaultSets;
  if b then //if config file exists then load settings
  begin
    mySets(True); //load settings from config file
    chk1instanceChange(nil);
  end
  else //if config file doesnt exists then assign some sets
  begin
    chk1instanceChange(nil);
    myFindFiles(sDirApp, [edtffmpeg, edtffprobe, edtffplay, edtMediaInfo]);
    {$IFDEF MSWINDOWS}
    myFindMediaInfo;
    {$ENDIF}
    myFindPlayers(True);
    cmbProfileGetItems(nil);
    if cmbProfile.Items.Count > 0 then
      cmbProfile.ItemIndex := 0;
  end;
  frmGUIta.Font.Name := cmbFont.Text;
  //load language
  myLanguage(True);
  //if masks empty then set defaults
  if LVmasks.Items.Count = 0 then
    btnMaskResetClick(nil);
  //process count for one thread formats: png xvid etc
  if spnCpuCount.Value = 0 then
    spnCpuCount.Value := cpucount.GetLogicalCpuCount;
  SetLength(aThrs, spnCpuCount.Value);
  SetLength(aMems, spnCpuCount.Value);
  //TComboBox - did not work onChange, red color for not existed files
  edtffmpegChange(edtffmpeg); //and fill some comboboxes with codecs and formats
  xmyCheckFile(edtffplay);
  xmyCheckFile(edtffprobe);
  xmyCheckFile(edtMediaInfo);
  xmyCheckFile(cmbExtPlayer);
  xmyCheckDir(edtDirTmp);
  xmyCheckDir(edtDirOut);
  xmyCheckDir(cmbDirLast);
  cmbProfileChange(cmbProfile);
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

procedure TfrmGUIta.LVjobsCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: boolean);
var
  i: integer;
begin
  if (Sender = LVjobs) then
  begin
    if TJob(Item.Data) = nil then
      Exit;
    i := StrToIntDef(TJob(Item.Data).getval(sMyCompleted), 3);
    if (i > 3) or (i < 0) then
      i := 3;
    Item.ImageIndex := i;
  end;
  {$IFDEF MSWINDOWS}
  if Item.Selected then
  begin
    Sender.Canvas.Brush.Color := clHighlight;
    Sender.Canvas.Font.Color := clHighlightText;
  end
  else
  begin
    Sender.Canvas.Brush.Color := clWindow;
    Sender.Canvas.Font.Color := clWindowText;
  end;
  {$ENDIF}
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
  if chkUseMasks.Checked then
  begin
    cmbProfile.Text := jo.getval(cmbProfile.Name);
    cmbProfileChange(cmbProfile);
  end;
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
      Sender.Canvas.Font.Color := clRed;
      Sender.Canvas.FillRect(mRect);
      Sender.Canvas.TextRect(mRect, mRect.Left + 2, mRect.Top + 2, Item.SubItems[SubItem - 1]);
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
  LVjobs.Selected.SubItems[2] := myCalcOutSize(jo);
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
  s := myExpandFileNameCaseW(LVjobs.Selected.SubItems[0], b);
  if not b then
    s := LVjobs.Selected.SubItems[0];
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
var
  s: string;
begin
  if LVjobs.Selected = nil then
    Exit;
  s := TJob(LVjobs.Selected.Data).f[0].getval(sMyDOSfname);
  if LowerCase(ExtractFileExt(s)) = '.avs' then
    myOpenDoc(s);
end;

procedure TfrmGUIta.mnuOpenClick(Sender: TObject);
begin
  if myCantUpd(0) then
    Exit;
  myOpenDoc(LVjobs.Selected.SubItems[0]);
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

procedure TfrmGUIta.onAddFTerminate(Sender: TObject);
begin
  ThreadAddF := nil;
  btnAddPause.Enabled := False;
  btnAddStop.Enabled := False;
end;

procedure TfrmGUIta.onCmdrTerminate(Sender: TObject);
begin
  ThreadCmdr := nil;
  btnCmdRun.Enabled := True;
  btnCmdStop.Enabled := False;
end;

procedure TfrmGUIta.onConvTerminate(Sender: TObject);
var
  b: boolean;
  i: integer;
  s: string;
begin
  i := (Sender as TThreadConv).NumOfThread;
  if (i >= Low(aThrs)) and (i <= High(aThrs)) then
    aThrs[i] := nil;
  s := IntToStr(i + 1) + ': ' + mes[30] + ' ' + mes[31];
  if chkDebug.Checked then
    memJournal.Lines.Add(s);
  StatusBar1.SimpleText := s;
  b := False;
  for i := Low(aThrs) to High(aThrs) do
  begin
    if (aThrs[i] <> nil) then
    begin
      {$IFDEF MSWINDOWS}
      if aThrs[i].Suspended then
        aThrs[i].Resume;
      {$ENDIF}
      b := True;
    end;
  end;
  if b then
    Exit;
  btnStart.Enabled := True;
  btnSuspend.Enabled := False;
  btnStop.Enabled := False;
  DuraJob := '';
  myShowCaption('');
end;

procedure TfrmGUIta.onTestTerminate(Sender: TObject);
begin
  ThreadTest := nil;
  btnTest.Enabled := True;
  btnTestPause.Enabled := False;
  btnTestStop.Enabled := False;
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
  jo, cmd: TJob;
  k, l: integer;
  s: string;
begin
  if LVjobs.Selected = nil then Exit;
  bUpdFromCode := True;
  jo := TJob(LVjobs.Selected.Data);
  chkUseEditedCmd.Checked := (jo.getval(chkUseEditedCmd.Name) = '1');
  cmd := TJob.Create;
  myGetCmdFromJo(jo, cmd, 3);
  memCmdlines.Clear;
  if chkUseEditedCmd.Checked then
    memCmdlines.Text := jo.getval(memCmdlines.Name)
  else
  for l := 0 to High(cmd.f) do
  begin
    s := myGetStr(cmd.f[l].getval(sMyFilename));
    for k := 0 to High(cmd.f[l].s) do
      s := s + myGetStr(cmd.f[l].s[k].sv);
    memCmdlines.Lines.Add(s);
  end;
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
  ParamCount: Integer; Parameters: array of String);
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
  LVjobs.Selected.SubItems[2] := myCalcOutSize(TJob(LVjobs.Selected.Data));
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
  LVjobs.Selected.SubItems[2] := myCalcOutSize(TJob(LVjobs.Selected.Data));
end;

procedure TfrmGUIta.xmyCheckDir(Sender: TObject);
var
  s: string;
begin
  s := myExpandFN(myGet2(Sender), True);
  if DirectoryExistsUTF8(s) then
    TWinControl(Sender).Font.Color := clWindowText
  else
    TWinControl(Sender).Font.Color := clRed;
end;

procedure TfrmGUIta.xmyCheckFile(Sender: TObject);
var
  s: string;
begin
  s := myExpandFN(myGet2(Sender));
  if FileExistsUTF8(s) then
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
  {$IFDEF MSWINDOWS}
  sExt := '.exe';
  {$ELSE}
  sExt := '';
  {$ENDIF}
  w := myGet2(Sender);
  t := Copy((Sender as TControl).Name, 4, 20) + sExt;
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
