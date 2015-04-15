unit ufrmGUIta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, StdCtrls, IniFiles, LclIntf, Process, UTF8Process, LConvEncoding,
  SynMemo, synhighlighterunixshellscript, StrUtils, LCLVersion, types, Math,
  Spin, Buttons, IntfGraphics, LCLType, Menus, fpImage, dateutils, clipbrd,
  {$IFDEF MSWINDOWS}
  Windows, Registry, mediainfodll,
  {$ENDIF}
  ucalcul, ufrmcompare, ujobinfo, utaversion, UniqueInstance2,
  uthreadconv, uthreadtest, uthreadaddf, uthreadexec;

type

  { TfrmGUIta }

  TfrmGUIta = class(TForm)
    btnCompare: TButton;
    btnAddFiles: TButton;
    btnAddFilesAsAvs1: TButton;
    btnAddFilesAsAvs2: TButton;
    btnFindDirOut: TBitBtn;
    btnFindExtPlayer: TBitBtn;
    btnFindffmpeg: TBitBtn;
    btnFindOfn: TBitBtn;
    btnFindffplay: TBitBtn;
    btnFindffprobe: TBitBtn;
    btnFindMediaInfo: TBitBtn;
    btnFindDirTmp: TBitBtn;
    btnLanguage: TButton;
    btnMediaInfo2: TButton;
    btnPlayOut: TButton;
    btnProfileSaveAs: TButton;
    btnCmdRun: TButton;
    btnLogSave: TButton;
    btnLogClear: TButton;
    btnPlayIn: TButton;
    btnTest: TButton;
    btnMediaInfo1: TButton;
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
    chkSaveFormPos: TCheckBox;
    chk1instance: TCheckBox;
    chkAddTracks: TCheckBox;
    chkRunInMem: TCheckBox;
    chkConcat: TCheckBox;
    chkRunInWindow: TCheckBox;
    chkDebug: TCheckBox;
    chkOEM: TCheckBox;
    chkx264Pass1fast: TCheckBox;
    chkPlayer2: TCheckBox;
    chkPlayer3: TCheckBox;
    cmbAddOptsS: TComboBox;
    cmbAddOptsI: TComboBox;
    cmbAddOptsO: TComboBox;
    cmbAddOptsA: TComboBox;
    cmbBitrateA: TComboBox;
    cmbBitrateV: TComboBox;
    cmbChannels: TComboBox;
    cmbDurationss1: TComboBox;
    cmbDurationss2: TComboBox;
    cmbDurationt1: TComboBox;
    cmbhqdn3d: TComboBox;
    cmbLangA: TComboBox;
    cmbLangS: TComboBox;
    cmbSetDAR: TComboBox;
    cmbEncoderA: TComboBox;
    cmbEncoderS: TComboBox;
    cmbEncoderV: TComboBox;
    cmbExt: TComboBox;
    cmbFiltersA: TComboBox;
    cmbFiltersV: TComboBox;
    cmbFormat: TComboBox;
    cmbLanguage: TComboBox;
    cmbProfile: TComboBox;
    cmbCrop: TComboBox;
    cmbPad: TComboBox;
    cmbPass: TComboBox;
    cmbRotate: TComboBox;
    cmbRunCmd: TComboBox;
    cmbScale: TComboBox;
    cmbSRate: TComboBox;
    cmbx264preset: TComboBox;
    cmbx264tune: TComboBox;
    cmbExtPlayer: TComboBox;
    cmbFont: TComboBox;
    cmbDirLast: TComboBox;
    cmbDurationt2: TComboBox;
    cmbTestDurationss: TComboBox;
    cmbTestDurationt: TComboBox;
    cmbLangsList: TComboBox;
    cmbAddOptsV: TComboBox;
    edtBitrateA: TLabeledEdit;
    edtDirOut: TLabeledEdit;
    edtDirTmp: TLabeledEdit;
    edtffmpeg: TLabeledEdit;
    edtffplay: TLabeledEdit;
    edtffprobe: TLabeledEdit;
    edtFileExts: TLabeledEdit;
    edtMediaInfo: TLabeledEdit;
    edtOfn: TLabeledEdit;
    edtxterm: TLabeledEdit;
    edtxtermopts: TLabeledEdit;
    ImageList1: TImageList;
    edtBitrateV: TLabeledEdit;
    edtOfna: TLabeledEdit;
    lblAddOptsI: TLabel;
    lblDurationss1: TLabel;
    lblDurationss2: TLabel;
    lblDurationt1: TLabel;
    lblLangA: TLabel;
    lblLangS: TLabel;
    lblTestStartDurationTime: TLabel;
    lblDurationt2: TLabel;
    lblDirLast: TLabel;
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
    lblx264preset: TLabel;
    lblx264tune: TLabel;
    LVfiles: TListView;
    LVjobs: TListView;
    LVstreams: TListView;
    memCmdlines: TMemo;
    mnuCheck: TMenuItem;
    mnuPasteTracks: TMenuItem;
    mnuMediaInfo: TMenuItem;
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
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    spnKoefA: TSpinEdit;
    spnKoefV: TSpinEdit;
    StatusBar1: TStatusBar;
    memJournal: TSynMemo;
    SynMemo2: TSynMemo;
    SynMemo3: TSynMemo;
    SynMemo4: TSynMemo;
    SynMemo5: TSynMemo;
    SynMemo6: TSynMemo;
    SynUNIXShellScriptSyn1: TSynUNIXShellScriptSyn;
    TabDefSets: TTabSheet;
    TabJournal: TTabSheet;
    TabConsole: TTabSheet;
    TabConsole1: TTabSheet;
    TabConsole2: TTabSheet;
    TabConvJob: TTabSheet;
    TabOutput: TTabSheet;
    TabContRows: TTabSheet;
    TabConsole3: TTabSheet;
    TabConsole4: TTabSheet;
    TabCmdline: TTabSheet;
    TabInput: TTabSheet;
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
    procedure btnMediaInfo1Click(Sender: TObject);
    procedure btnFindOfnClick(Sender: TObject);
    procedure btnPlayInClick(Sender: TObject);
    procedure btnPlayOutClick(Sender: TObject);
    procedure btnProfileSaveAsClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnSuspendClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnTestPauseClick(Sender: TObject);
    procedure btnTestStopClick(Sender: TObject);
    procedure chk1instanceChange(Sender: TObject);
    procedure chkPlayer2Change(Sender: TObject);
    procedure chkPlayer3Change(Sender: TObject);
    procedure cmbBitrateAChange(Sender: TObject);
    procedure cmbBitrateVChange(Sender: TObject);
    procedure cmbEncoderVChange(Sender: TObject);
    procedure cmbExtChange(Sender: TObject);
    procedure cmbExtPlayerChange(Sender: TObject);
    procedure cmbExtSelect(Sender: TObject);
    procedure cmbFontGetItems(Sender: TObject);
    procedure cmbFontSelect(Sender: TObject);
    procedure cmbFormatChange(Sender: TObject);
    procedure cmbFormatSelect(Sender: TObject);
    procedure cmbLanguageChange(Sender: TObject);
    procedure cmbProfileChange(Sender: TObject);
    procedure edtOfnChange(Sender: TObject);
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
    procedure LVstreamsClick(Sender: TObject);
    procedure LVstreamsExit(Sender: TObject);
    procedure LVstreamsItemChecked(Sender: TObject; Item: TListItem);
    procedure LVstreamsSelectItem(Sender: TObject; Item: TListItem;
      Selected: boolean);
    procedure mnuCheckClick(Sender: TObject);
    procedure mnuCopyAsAvsClick(Sender: TObject);
    procedure mnuEditAvsClick(Sender: TObject);
    procedure mnuOpenClick(Sender: TObject);
    procedure mnuPasteClick(Sender: TObject);
    procedure onAddFTerminate(Sender: TObject);
    procedure onCmdrTerminate(Sender: TObject);
    procedure onConvTerminate(Sender: TObject);
    procedure onTestTerminate(Sender: TObject);
    procedure ontAutoStart(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure TabCmdlineShow(Sender: TObject);
    procedure TabContRowsShow(Sender: TObject);
    procedure TabInputShow(Sender: TObject);
    procedure TabVideoShow(Sender: TObject);
    procedure UniqueInstance1OtherInstance(Sender: TObject;
      ParamCount: Integer; Parameters: array of String);
    procedure xmyChange0(Sender: TObject);
    procedure xmyChange0i(Sender: TObject);
    procedure xmyChange0o(Sender: TObject);
    procedure xmyChange1(Sender: TObject);
    procedure xmyChange1v(Sender: TObject);
    procedure xmyChange1a(Sender: TObject);
    procedure xmyChange1o(Sender: TObject);
    procedure xmyCheckDir(Sender: TObject);
    procedure xmyCheckFile(Sender: TObject);
    procedure xmySelDir(Sender: TObject);
    procedure xmySelFile(Sender: TObject);
  private
    { private declarations }
    procedure myAddFiles(files: TStrings);
    {$IFDEF MSWINDOWS}
    procedure myAddFilesAsAVS1(fns: TStrings);
    procedure myAddFilesAsAVS2(fns: TStrings);
    {$ENDIF}
    procedure myAddFileSplit(files: TStrings);
    procedure myAddFilesPlus(li: TListItem; files: TStrings);
    procedure myAddFileStart;
    procedure myFindFiles(dir: string; c: array of TObject);
    function myGetFileList(const Path, Mask: string; List: TStrings;
      subdir: boolean = False; fullpath: boolean = True): boolean;
    function myGetSimilarFiles(fn: string; List: TStrings): boolean;
    procedure myFormPosLoad(Form: TForm; Ini: TIniFile);
    procedure myFormPosSave(Form: TForm; Ini: TIniFile);
    procedure myLanguage(bRead: boolean);
    procedure mySets(bRead: boolean);
    procedure myDisComp;
    function myGetCaptionCont(p: TCont): string;
    procedure myGetWH(v: TCont; var w, h: integer);
    procedure myGetWHXYcrop(v: TCont; var w, h, x, y: integer);
    procedure myGetWHXYscale(v: TCont; var w, h: integer);
    procedure myGetWHXY(s: string; var w, h, x, y: string);
    function myValInt(f, v: string): integer;
    function myDirExists(dir, mes: string): boolean;
    {$IFDEF MSWINDOWS}
    function myGetAvs(fn: string): string;
    {$ENDIF}
    function myError(i: integer; w: string): integer;
    procedure myFillEnc;
    procedure myFillFmt;
    function myCantUpd(i: integer = 0): boolean;
    function myAutoCrop(jo: TJob; co: TCont): string;
    procedure myGetClipboardFileNames(files: TStrings; test: boolean = False);
    function myGetColor: integer;
  public
    { public declarations }
    function myExpandFN(fn: string): string;
    function myUnExpandFN(fn: string): string;
    function myGetDosOut(cmd, beg, fin: string; mem: TSynMemo;
      stb: TStatusBar; OEM: boolean = True): integer;
    function myGetDosOut2(cmd: string; mem: TSynMemo): integer;
    function myGetFilter(jo: TJob; v: TCont; all: boolean = True): string;
    function myGetCmdFromJo(jo: TJob; test: boolean = False): string;
    function myGetPic(ss, fn, fv: string; sm: TSynMemo; st: TStatusBar): string;
    function myStrReplace(s: string): string;
    function myValFPS(a: array of string): extended;
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
  end;

var
  frmGUIta: TfrmGUIta;
  sCap, sDirApp, sInidir, sInifile, sLngfile: string;
  fs: TFormatSettings;
  mes: array [0..27] of string;
  tAutoStart: TTimer;
  bUpdFromCode: boolean;
  ThreadConv: TThreadConv;
  ThreadTest: TThreadTest;
  ThreadAddF: TThreadAddF;
  ThreadCmdr: TThreadExec;
  sdiv: string =
  '--------------------------------------------------------------------------------';
  DuraAll: double;
  DuraAl2: integer;
  Files2Add: TList;
  Counter: integer;
  myUnik: TUniqueInstance;

implementation

uses ubyUtils, ufrmsplash, ufrmcrop, ufrmgrab;

{$R *.lfm}

procedure myToIni(Ini: TIniFile; s1, s2, s3: string);
begin
  if s3 = '' then
    Ini.DeleteKey(s1, s2)
  else if Ini.ReadString(s1, s2, '') <> s3 then
  begin
    if (s3[1] = '"') and (s3[Length(s3)] = '"') then
      s3 := '''' + s3 + '''';
    Ini.WriteString(s1, s2, s3);
  end;
end;

procedure mySets1(Ini: TIniFile; s: string; c: array of TComponent; bRead: boolean);
var
  k, i: integer;
begin
  for k := Low(c) to High(c) do
    if TWinControl(c[k]).Enabled and (TWinControl(c[k]).Tag = 0) then
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
              myToIni(Ini, s, Name, Text);
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
            myToIni(Ini, s, Name, IntToStr(Value))
      else if c[k] is TCheckBox then
        with TCheckBox(c[k]) do
          if bRead then
            Checked := Ini.ReadBool(s, Name, Checked)
          else
            myToIni(Ini, s, Name, IfThen(Checked, '1', ''))
      else if c[k] is TPanel then
        for i := 0 to TPanel(c[k]).ControlCount - 1 do
          mySets1(Ini, s, [TPanel(c[k]).Controls[i]], bRead);
end;

procedure mySets2(Ini: TIniFile; s: string; ts: array of TTabSheet; bRead: boolean);
var
  i, j: integer;
begin
  for j := Low(ts) to High(ts) do
    for i := 0 to TTabSheet(ts[j]).ControlCount - 1 do
      mySets1(Ini, s, [TTabSheet(ts[j]).Controls[i]], bRead);
end;

procedure mySets3(Ini: TIniFile; s: string; c: array of TComponent; bRead: boolean);
var
  i, k: integer;
  w: string;
begin
  for k := Low(c) to High(c) do
    if c[k] is TComboBox then
      with TComboBox(c[k]) do
        if bRead then
        begin
          Text := Ini.ReadString(s, Name, Text);
          i := 0;
          repeat
            w := Ini.ReadString(Name, IntToStr(i), '');
            if w <> '' then
              frmGUIta.myAdd2cmb(TComboBox(c[k]), w);
            Inc(i);
          until w = '';
        end
        else
        begin
          myToIni(Ini, s, Name, Text);
          for i := 0 to Items.Count - 1 do
            myToIni(Ini, Name, IntToStr(i), Items[i]);
        end;
end;

procedure myGetValsFromCont(t: TTabSheet; v: TCont);
var
  i: integer;
begin
  for i := 0 to t.ControlCount - 1 do
    if (t.Controls[i] is TComboBox) then
    begin
      if TComboBox(t.Controls[i]).ReadOnly then
        TComboBox(t.Controls[i]).ItemIndex :=
          StrToIntDef(v.getval(t.Controls[i].Name), -1)
      else
        TComboBox(t.Controls[i]).Text := v.getval(t.Controls[i].Name);
    end
    else if (t.Controls[i] is TLabeledEdit) then
      TLabeledEdit(t.Controls[i]).Text := v.getval(t.Controls[i].Name)
    else if (t.Controls[i] is TCheckBox) then
      TCheckBox(t.Controls[i]).Checked := v.getval(t.Controls[i].Name) = '1'
    else if (t.Controls[i] is TSpinEdit) then
    begin
      TSpinEdit(t.Controls[i]).Value := StrToIntDef(v.getval(t.Controls[i].Name), 0);
      TSpinEdit(t.Controls[i]).Text := v.getval(t.Controls[i].Name);
    end;
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
  else if (Sender is TCheckBox) then
    Result := IfThen(TCheckBox(Sender).Checked, '1', '0')
  else if (Sender is TSpinEdit) then
    Result := TSpinEdit(Sender).Text
  else
    Result := '';
end;

procedure myClear2(ts: array of TTabSheet);
var
  i, j: integer;
begin
  for j := Low(ts) to High(ts) do
  begin
    for i := 0 to TTabSheet(ts[j]).ControlCount - 1 do
      if TTabSheet(ts[j]).Controls[i] is TLabeledEdit then
        TLabeledEdit(TTabSheet(ts[j]).Controls[i]).Text := ''
      else if TTabSheet(ts[j]).Controls[i] is TComboBox then
        TComboBox(TTabSheet(ts[j]).Controls[i]).Text := ''
      else if TTabSheet(ts[j]).Controls[i] is TSpinEdit then
        TSpinEdit(TTabSheet(ts[j]).Controls[i]).Text := '1'
      else if TTabSheet(ts[j]).Controls[i] is TSynMemo then
        TSynMemo(TTabSheet(ts[j]).Controls[i]).Clear
      else if TTabSheet(ts[j]).Controls[i] is TMemo then
        TMemo(TTabSheet(ts[j]).Controls[i]).Clear;
  end;
end;

{ TfrmGUIta }

procedure TfrmGUIta.myAddFiles(files: TStrings);
var
  i, j: integer;
  jo: TJob;
  c: TCont;
  sl: TStringList;
begin
  for i := 0 to files.Count - 1 do
  begin
    jo := TJob.Create;
    c := TCont.Create;
    jo.files.AddObject(files[i], c);
    jo.filecnt := -1;
    Inc(Counter);
    jo.setval('index', IntToStr(Counter));
    jo.setval('Completed', '0');
    if chkAddTracks.Checked then
    begin
      sl := TStringList.Create;
      if myGetSimilarFiles(files[i], sl) then
      for j := 0 to sl.Count - 1 do
      begin
        c := TCont.Create;
        jo.files.AddObject(sl[j], c);
      end;
      sl.Free;
    end;
    Files2Add.Add(Pointer(jo));
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
{$ENDIF}

{$IFDEF MSWINDOWS}
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
{$ENDIF}

procedure TfrmGUIta.myAddFileSplit(files: TStrings);
var
  i: integer;
  j, k, r: double;
  jo: TJob;
  c: TCont;
  s, d: string;
begin
  s := '4:00';
  if not InputQuery(mes[25], mes[26], s) then
    Exit;
  r := myTimeStrToReal(s);
  for i := 0 to files.Count - 1 do
  begin
    s := files[i];
    d := myStrReplace('"$ffprobe"') + ' -show_streams "' + s + '"';
    //myGetDosOut(d, '', '', SynMemo2, StatusBar1);
    myGetDosOut2(d, SynMemo2);
    d := SynMemo2.Text;
    d := myBetween(d, 'Duration: ', ',');
    j := myTimeStrToReal(d);
    {$IFDEF MSWINDOWS}
    if (j = 0) and FileExistsUTF8(myExpandFN(frmGUIta.edtMediaInfo.Text)) then
    begin
      d := myGetMediaInfo(s, 'Duration', Stream_General);
      j := StrToFloatDef(d, 1) / 1000;
    end;
    {$ENDIF}
    k := 0;
    while k < j do
    begin
      jo := TJob.Create;
      c := TCont.Create;
      jo.files.AddObject(s, c);
      Inc(Counter);
      jo.setval('index', IntToStr(Counter));
      jo.setval('Completed', '0');
      jo.setval('cmbDurationss', myRealToTimeStr(k, False));
      jo.setval('cmbDurationt', myRealToTimeStr(r, False));
      Files2Add.Add(Pointer(jo));
      k := k + r;
    end;
  end;
  myAddFileStart;
end;

procedure TfrmGUIta.myAddFilesPlus(li: TListItem; files: TStrings);
var
  jo: TJob;
  c: TCont;
  i: integer;
begin
  jo := TJob(li.Data);
  for i := 0 to files.Count - 1 do
  begin
    c := TCont.Create;
    jo.files.AddObject(files[i], c);
  end;
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
  s: string;
  i: integer;

  procedure my1(c: TComboBox);
  var
    t, n: string;
  begin
    t := v.getval(c.Name);
    n := LowerCase(Copy(c.Name, 4, Length(c.Name)));
    if t <> '' then
      s := IfThen(s <> '', s + ', ') + n + '=' + t;
  end;
  procedure my2(r: string);
  var
    p: string;
    i: integer;
  begin
    if r = '' then
      Exit;
    if Pos('$input', r) > 0 then
    begin
      p := myGetAnsiFN(jo.files[0]);
      p := StringReplace(p, '\', '/', [rfReplaceAll]);
      p := StringReplace(p, ':', '\:', [rfReplaceAll]);
      r := StringReplace(r, '$input', p, [rfReplaceAll]);
    end;
    for i := 0 to jo.files.Count - 1 do
    if Pos('$inpu' + IntToStr(i), r) > 0 then
    begin
      p := myGetAnsiFN(jo.files[i]);
      p := StringReplace(p, '\', '/', [rfReplaceAll]);
      p := StringReplace(p, ':', '\:', [rfReplaceAll]);
      r := StringReplace(r, '$inpu' + IntToStr(i), p, [rfReplaceAll]);
    end;
    s := IfThen(s <> '', s + ', ') + r;
  end;

begin
  s := '';
  my1(cmbCrop);
  my1(cmbScale);
  my1(cmbPad);
  if all then
    my1(cmbhqdn3d);
  i := StrToIntDef(v.getval(cmbRotate.Name), 7);
  if i in [0..6] then
    s := IfThen(s <> '', s + ', ');
  case i of
    0..3: s := s + 'transpose=' + IntToStr(i);
    4: s := s + 'hflip';
    5: s := s + 'vflip';
    6: s := s + 'hflip, vflip';
    else
      if chkDebug.Checked then
        memJournal.Lines.Add('rotate not in range: ' + IntToStr(i));
  end;
  my1(cmbSetDAR);
  my2(v.getval(cmbFiltersV.Name));
  my2(v.getval(cmbFiltersA.Name));
  Result := s;
end;

function TfrmGUIta.myGetCmdFromJo(jo: TJob; test: boolean = False): string;
var
  i, k, cf, cv, ca, cs, ct, cd: integer;
  c: TCont;
  rd,
  rsi, rso, rst, rti, rto, rtt: double;
  ssi, sso, sst, sti, sto, stt,
  s, co, ty, si, fc, fc2, f, fn, fb, ni, vi, au, su, ma,
  so, tmp, f1p, sp1, sp2, fn1, fn2, fno, fnoa: string;
  ai: TStringList;

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
        s := myGetFilter(jo, c);
        f := f + IfThen(s <> '', ' -filter:v:' + ni + ' "' + s + '"');
        s := c.getval(edtBitrateV.Name);
        vi := vi + IfThen(s <> '', ' -b:v:' + ni + ' ' + s);
        if (co = 'libx264') or (co = 'libx264rgb') then
        begin
          s := c.getval(cmbx264preset.Name);
          vi := vi + IfThen(s <> '', ' -preset ' + s);
          s := c.getval(cmbx264tune.Name);
          vi := vi + IfThen(s <> '', ' -tune ' + s);
          f1p := IfThen(c.getval(chkx264Pass1fast.Name) = '1', ' -fastfirstpass 1');
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
          sp1 := ' -pass 1 -passlogfile "' + tmp + 'ff-tmp"' + f1p;
          sp2 := ' -pass 2 -passlogfile "' + tmp + 'ff-tmp"';
        end;
        s := c.getval(cmbAddOptsV.Name);
        vi := vi + IfThen(s <> '', ' ' + s);
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
        s := myGetFilter(jo, c);
        f := f + IfThen(s <> '', ' -filter:a:' + ni + ' "' + s + '"');
        s := c.getval(edtBitrateA.Name);
        au := au + IfThen(s <> '', ' -b:a:' + ni + ' ' + s);
        s := c.getval(cmbSRate.Name);
        au := au + IfThen(s <> '', ' -ar:a:' + ni + ' ' + s);
        s := c.getval(cmbChannels.Name);
        au := au + IfThen(s <> '', ' -ac:a:' + ni + ' ' + s);
        s := c.getval(cmbAddOptsA.Name);
        au := au + IfThen(s <> '', ' ' + s);
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

begin
  // -ss input, output, test
  ssi := '';
  sso := jo.getval(cmbDurationss2.Name);
  sst := IfThen(test, Trim(cmbTestDurationss.Text));
  // -t input, output, test
  sti := '';
  sto := jo.getval(cmbDurationt2.Name);
  stt := IfThen(test, Trim(cmbTestDurationt.Text));
  // calc time range for test
  rd := myTimeStrToReal(jo.getval('duration'));
  rso := myTimeStrToReal(sso);
  rto := myTimeStrToReal(sto);
  if test then
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
  ai := TStringList.Create;
  si := '"$ffmpeg"';
  fc := '';
  fc2 := '';
  f := '';
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
  //--- concat ---
  if (jo.getval(chkConcat.Name) = '1') then
  begin
    fc := ' -filter_complex "';
    for k := 0 to High(jo.a) do
    begin
      c := jo.a[k];
      if c.getval('Checked') = '1' then
      begin
        fn := c.getval('filenum');
        ni := c.getval('index');
        if fn <> fb then
          Inc(cf);
        fb := fn;
        ty := c.getval('codec_type');
        if ty = 'video' then
        begin
          fc := fc + '[' + fn + ':' + ni + '] ';
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
          fc := fc + '[' + fn + ':' + ni + '] ';
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
    fc := fc + 'concat=n=' + IntToStr(cf) + ':v=' + IntToStr(cv + 1) +
      ':a=' + IntToStr(ca + 1) + fc2 + '"';
    for k := 0 to jo.files.Count - 1 do
    begin
      c := TCont(jo.files.Objects[k]);
      ssi := c.getval(cmbDurationss1.Name);
      if test and (rso = 0) then
      begin
        rsi := myTimeStrToReal(ssi);
        if (rsi < rst) then
          ssi := sst;
      end;
      si := si + IfThen(ssi <> '', ' -ss ' + ssi);
      sti := c.getval(cmbDurationt1.Name);
      if test and (rto = 0) then
      begin
        rti := myTimeStrToReal(sti);
        if (rti = 0) or (rti > rtt) then
          sti := stt;
      end;
      si := si + IfThen(sti <> '', ' -t ' + sti);
      s := c.getval(cmbAddOptsI.Name);
      si := si + IfThen(s <> '', ' ' + s);
      si := si + ' -i "' + myGetAnsiFN(jo.files[k]) + '"';
    end;
  end
  else //mix mux
  begin
    //only files with checked tracks
    for k := 0 to High(jo.a) do
    begin
      c := jo.a[k];
      if c.getval('Checked') = '1' then
      begin
        s := c.getval('filenum');
        if ai.IndexOf(s) < 0 then
          ai.Add(s);
      end;
    end;
    //map and params for every track
    for k := 0 to High(jo.a) do
    begin
      c := jo.a[k];
      if c.getval('Checked') = '1' then
      begin
        s := c.getval('filenum');
        i := ai.IndexOf(s);
        s := IntToStr(i);
        ma := ma + ' -map ' + s + ':' + c.getval('index');
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
    //input params
    for i := 0 to ai.Count - 1 do
    begin
      k := StrToIntDef(ai[i], -1);
      if k >= 0 then
      begin
        c := TCont(jo.files.Objects[k]);
        ssi := c.getval(cmbDurationss1.Name);
        if test and (rso = 0) then
        begin
          rsi := myTimeStrToReal(ssi);
          if (rsi < rst) then
            ssi := sst;
        end;
        si := si + IfThen(ssi <> '', ' -ss ' + ssi);
        sti := c.getval(cmbDurationt1.Name);
        if test and (rto = 0) then
        begin
          rti := myTimeStrToReal(sti);
          if (rti = 0) or (rti > rtt) then
            sti := stt;
        end;
        si := si + IfThen(sti <> '', ' -t ' + sti);
        s := c.getval(cmbAddOptsI.Name);
        si := si + IfThen(s <> '', ' ' + s);
        si := si + ' -i "' + myGetAnsiFN(jo.files[k]) + '"';
      end;
    end;
  end;
  ai.Free;
  if vi = '' then vi := ' -vn'; //no video
  if au = '' then au := ' -an'; //no audio
  if su = '' then su := ' -sn'; //no subtitle
  // params for output file
  if test then
  begin
    if (rso > 0) and (rso < rst) then
      sso := sst;
    if (rto = 0) or (rto > rtt) and (rtt > 0) then
      sto := stt;
  end;
  so := so + IfThen(sso <> '', ' -ss ' + sso) + IfThen(sto <> '', ' -t ' + sto);
  s := jo.getval(cmbAddOptsO.Name);
  so := so + IfThen(s <> '', ' ' + s);
  s := jo.getval(cmbFormat.Name);
  so := so + IfThen(s <> '', ' -f ' + s);
  // output filename
  fno := jo.getval(edtOfn.Name);
  if fno <> '' then
  begin
    if FileExistsUTF8(fno) then
    begin
      fno := myGetOutFN(ExtractFilePath(fno), jo.files[0],  ExtractFileExt(fno));
      jo.setval(edtOfn.Name, fno);
    end;
    {$IFDEF MSWINDOWS}
    fnoa := jo.getval(edtOfna.Name); //short filename
    if FileExistsUTF8(fnoa) then
    begin
      fnoa := myGetOutFNa(ExtractFilePath(fnoa), jo.files[0], ExtractFileExt(fnoa));
      jo.setval(edtOfna.Name, fnoa);
    end;
    fn1 := ' -y NUL' + jo.getval(cmbExt.Name);
    {$ELSE}
    fnoa := fno;
    fn1 := ' -y /dev/null';
    {$ENDIF}
    fn2 := ' -y "' + fnoa +'"';
  end
  else
  begin
    fn1 := '';
    fn2 := '';
  end;
  // final
  if sp1 <> '' then
    Result := si + fc + f + vi + au + su + ma + sp1 + so + fn1 + LineEnding
            + si + fc + f + vi + au + su + ma + sp2 + so + fn2
  else
    Result := si + fc + f + vi + au + su + ma + so + fn2;
  Result := myStrReplace(Result);
end;

function TfrmGUIta.myGetDosOut(cmd, beg, fin: string; mem: TSynMemo;
  stb: TStatusBar; OEM: boolean = True): integer;
var
  Buffer, s, t, scp: string;
  BytesAvailable: DWord;
  BytesRead: longint;
  i, j: integer;
  pr: TProcessUTF8;
begin
  mem.Clear;
  if beg <> '' then
    mem.Lines.Add(beg);
  mem.Lines.Add(cmd);
  scp := GetConsoleTextEncoding;
  mem.Lines.Add(sdiv);
  pr := TProcessUTF8.Create(nil);
  try
    pr.CommandLine := cmd;
    pr.Options := [poUsePipes, poStderrToOutPut];
    pr.ShowWindow := swoHide;
    pr.Execute;
    t := '';
    repeat
      BytesAvailable := pr.Output.NumBytesAvailable;
      BytesRead := 0;
      while BytesAvailable > 0 do
      begin
        SetLength(Buffer, BytesAvailable);
        BytesRead := pr.OutPut.Read(Buffer[1], BytesAvailable);
        s := copy(Buffer, 1, BytesRead);
        if OEM then
          s := ConvertEncoding(s, scp, EncodingUTF8);
        t := t + s;
        repeat
          i := Pos(#13, t);
          j := Pos(#10, t);
          if (i > 0) and (j <> i + 1) then //carrier return, no line feed
          begin
            if (j > i + 1) then j := i;
            s := Copy(t, 1, i - 1);
            Delete(t, 1, Max(i, j));
            stb.SimpleText := s;
          end else
          if ((i > 0) and (j = i + 1))  //crlf
          or ((i = 0) and (j > 0))      //lf
          or ((i > j) and (j > 0)) then //lf, cr
          begin
            if (i = 0) or (i > j) then i := j;
            s := Copy(t, 1, Min(i, j) - 1);
            Delete(t, 1, Max(i, j));
            stb.SimpleText := s;
            mem.Lines.Add(s);
          end;
          Application.ProcessMessages;
        until i = 0;
        BytesAvailable := pr.Output.NumBytesAvailable;
      end;
      Sleep(2);
    until not pr.Running;
    if (t <> '') then
      mem.Lines.Add(t);
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
  Result := pr.ExitStatus;
  pr.Free;
  if Result = 0 then
    stb.SimpleText := ''
  else
    stb.SimpleText := fin + ' ' + IntToStr(Result);
end;

function TfrmGUIta.myGetDosOut2(cmd: string; mem: TSynMemo): integer;
const
  READ_BYTES = 2048;
var
  MemStream: TMemoryStream;
  NumBytes, BytesRead: integer;
  //sl: TStringList;
  //i: integer;
  pr: TProcessUTF8;
begin
  //pr := TProcessUTF8.Create(nil);
  //pr.CommandLine := cmd;
  //pr.Options := [poWaitOnExit, poUsePipes, poStderrToOutPut];
  //pr.ShowWindow := swoHide;
  //pr.Execute;
  //mem.Lines.LoadFromStream(pr.Output);
  //Result := pr.ExitStatus;
  //pr.Free;

  Result := -1;
  BytesRead := 0;
  //sl := Nil;
  MemStream := TMemoryStream.Create;
  pr := TProcessUTF8.Create(nil);
  try
    pr.CommandLine := cmd;
    pr.Options := [poUsePipes, poStderrToOutPut];
    pr.ShowWindow := swoHide;
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
    //sl := TStringList.Create;
    //sl.LoadFromStream(MemStream);
    //for i := 0 to sl.Count - 1 do
    //  mem.Lines.Add(sl[i]);
    Result := pr.ExitStatus;
  finally
    //sl.Free;
    pr.Free;
    MemStream.Free;
  end;
end;

procedure TfrmGUIta.myFindFiles(dir: string; c: array of TObject);
var
  SL: TStringList;
  i, j: integer;
  s, t: string;
begin
  SL := TStringList.Create;
  {$IFDEF MSWINDOWS}
  s := '*.exe';
  {$ELSE}
  s := '*';
  {$ENDIF}
  if myGetFileList(dir, s, SL, True) then
    for i := 0 to High(c) do
    begin
      {$IFDEF MSWINDOWS}
      s := LowerCase(myExpandFN(myGet2(c[i])));
      {$ELSE}
      s := myExpandFN(myGet2(c[i]));
      {$ENDIF}
      for j := 0 to SL.Count - 1 do
      begin
        {$IFDEF MSWINDOWS}
        t := LowerCase(SL[j]);
        {$ELSE}
        t := SL[j];
        {$ENDIF}
        if s = t then
          Break
        else
        if ExtractFileName(s) = ExtractFileName(t) then
        begin
          mySet2(c[i], myUnExpandFN(SL[j]));
          Break;
        end;
      end;
    end;
  SL.Free;
end;

function TfrmGUIta.myExpandFN(fn: string): string;
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
      if not (DirectoryExistsUTF8(Result) or FileExistsUTF8(Result)) then
        Result := FindDefaultExecutablePath(ExtractFileName(fn), sDirApp);
    end;
  end;
end;

function TfrmGUIta.myUnExpandFN(fn: string): string;
begin
  {$IFDEF MSWINDOWS}
  if Pos(LowerCase(sDirApp), LowerCase(fn)) = 1 then
    fn := ExtractRelativePath(sDirApp, fn)
  else if Pos(LowerCase(ExtractFileDir(sDirApp)), LowerCase(fn)) = 1 then
    fn := ExtractRelativePath(Application.ExeName, fn);
  {$ENDIF}
  Result := myUnExpandEnvs(fn);
end;

function TfrmGUIta.myStrReplace(s: string): string;
var
  p: string;
begin
  Result := s;
  Result := StringReplace(Result, '$dirtmp', myExpandFN(edtDirTmp.Text), [rfReplaceAll]);
  Result := StringReplace(Result, '$dirout', myExpandFN(edtDirOut.Text), [rfReplaceAll]);
  Result := StringReplace(Result, '$ffmpeg', myExpandFN(edtffmpeg.Text), [rfReplaceAll]);
  Result := StringReplace(Result, '$ffplay', myExpandFN(edtffplay.Text), [rfReplaceAll]);
  Result := StringReplace(Result, '$ffprobe', myExpandFN(edtffprobe.Text),
    [rfReplaceAll]);
  if LVjobs.Selected = nil then
    Exit;
  p := myGetAnsiFN(LVjobs.Selected.SubItems[0]);
  Result := StringReplace(Result, '$input', p, [rfReplaceAll]);
  p := ExtractFileDir(p);
  Result := StringReplace(Result, '$dirinp', p, [rfReplaceAll]);
  Result := StringReplace(Result, '$output',
  {$IFDEF MSWINDOWS}
    TJob(LVjobs.Selected.Data).getval(edtOfna.Name), [rfReplaceAll]);
  {$ELSE}
    TJob(LVjobs.Selected.Data).getval(edtOfn.Name), [rfReplaceAll]);
  {$ENDIF}
end;

function TfrmGUIta.myGetFileList(const Path, Mask: string; List: TStrings;
  subdir: boolean = False; fullpath: boolean = True): boolean;
var
  SL: TStringList;
  frm: TfrmSplash;

  function myGetList(const Path2: string): boolean;
  var
    i, nStatus: integer;
    SR: TSearchRec;
  begin
    for i := 0 to SL.Count - 1 do
    begin
      nStatus := FindFirstUTF8(AppendPathDelim(Path2) + SL.Strings[i], 0, SR);
      while nStatus = 0 do
      begin
        List.Add(IfThen(fullpath, AppendPathDelim(Path2)) + SR.Name);
        if frm.bCancel then
          Break;
        nStatus := FindNextUTF8(SR);
      end;
      FindCloseUTF8(SR);
      Result := not frm.bCancel;
      if frm.bCancel then
        Exit;
    end;
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
    Result := not frm.bCancel;
  end;

begin
  Application.CreateForm(TfrmSplash, frm);
  try
    frm.Caption := mes[3] + ': ' + Path + ' - ' + Mask;
    frm.btnCancel.Caption := mes[8];
    frm.Label1.Caption := mes[3];
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
  i: Longint;
  SR: TSearchRec;
begin
  i := FindFirstUTF8(ChangeFileExt(fn, '') + '*', 0, SR);
  while i = 0 do
  begin
    if ExtractFileName(fn) <> SR.Name then
      List.Add(ExtractFilePath(fn) + SR.Name);
    i := FindNextUTF8(SR);
  end;
  FindCloseUTF8(SR);
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
      else if c[k] is TTabSheet then
        with TTabSheet(c[k]) do
          if bRead then
            Caption := my1(s1, Name, Caption)
          else
            my2(s1, Name, Caption)
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
          for i := 0 to Columns.Count - 1 do
            if bRead then
              Column[i].Caption := Ini.ReadString(Name, IntToStr(i), Column[i].Caption)
            else
              Ini.WriteString(Name, IntToStr(i), Column[i].Caption);
  end;

  procedure myLng2(a: array of TTabSheet);
  var
    i, j: integer;
  begin
    for j := Low(a) to High(a) do
    begin
      myLng1([a[j]]);
      for i := 0 to TTabSheet(a[j]).ControlCount - 1 do
        myLng1([TTabSheet(a[j]).Controls[i]]);
    end;
  end;

  procedure myLng3(a: array of TPanel);
  var
    i, j: integer;
  begin
    for j := Low(a) to High(a) do
    begin
      for i := 0 to TPanel(a[j]).ControlCount - 1 do
        myLng1([TPanel(a[j]).Controls[i]]);
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
        myLng2([TPageControl(a[j]).Pages[i]]);
    end;
  end;

begin
  s1 := AppendPathDelim(sDirApp) + cmbLanguage.Text;
  if bRead and not FileExistsUTF8(s1) then
  begin
    if sInidir = sDirApp then
      Exit;
    s1 := AppendPathDelim(sInidir) + cmbLanguage.Text;
    if not FileExistsUTF8(s1) then
      Exit;
  end
  else
  if not DirectoryIsWritable(sDirApp) then
    s1 := AppendPathDelim(sInidir) + cmbLanguage.Text;
  Ini := TIniFile.Create(UTF8ToSys(s1));
  s1 := 'Captions';
  s2 := 'Hints';
  s3 := 'Messages';
  myLng5([PageControl1, PageControl2, PageControl3]);
  myLng3([Panel1, Panel2, Panel3]);
  myLng1([LVjobs]);
  myLng4([PopupMenu1, PopupMenu2]);
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

procedure TfrmGUIta.mySets(bRead: boolean);
var
  Ini: TIniFile;
  s: string;
  i: integer;
begin
  if not FileExistsUTF8(sInifile) and bRead then
    Exit;
  Ini := TIniFile.Create(UTF8ToSys(sInifile));
  s := 'Main';
  mySets2(Ini, s, [TabDefSets, TabConsole1], bRead);
  mySets1(Ini, s, [cmbProfile], bRead);
  mySets3(Ini, s, [cmbRunCmd, cmbExtPlayer], bRead);
  if bRead then
  begin
    for i := 0 to LVjobs.Columns.Count - 1 do
      LVjobs.Column[i].Width :=
        Ini.ReadInteger(LVjobs.Name, IntToStr(i), LVjobs.Column[i].Width);
    myFormPosLoad(frmGUIta, Ini);
  end
  else
  begin
    for i := 0 to LVjobs.Columns.Count - 1 do
      myToIni(Ini, LVjobs.Name, IntToStr(i), IntToStr(LVjobs.Column[i].Width));
    myFormPosSave(frmGUIta, Ini);
    if edtDirOut.Text = '' then
      Ini.WriteString(s, edtDirOut.Name, '');
  end;
  Ini.Free;
end;

procedure TfrmGUIta.myDisComp;
var
  b, b1, b2, b3: boolean;
  i: integer;
begin
  b := (ThreadConv <> nil);
  btnStart.Enabled := not b;
  btnSuspend.Enabled := b;
  btnStop.Enabled := b;
  b := (LVjobs.Selected <> nil);
  for i := 0 to TabConvJob.ControlCount - 1 do
    TControl(TabConvJob.Controls[i]).Enabled := b;
  b1 := b and FileExistsUTF8(LVjobs.Selected.SubItems[0]);
  btnPlayIn.Enabled := b1;
  mnuOpen.Enabled := b1;
  mnuView.Enabled := b1;
  b3 := FileExistsUTF8(myExpandFN(edtMediaInfo.Text));
  mnuMediaInfo.Enabled := b1 and b3;
  btnMediaInfo1.Enabled := b1 and b3;
  btnTest.Enabled := b1 and (ThreadTest = nil);
  b2 := b and FileExistsUTF8(TJob(LVjobs.Selected.Data).getval(edtOfn.Name));
  btnMediaInfo2.Enabled := b2 and b3;
  btnPlayOut.Enabled := b2;
  btnCompare.Enabled := b1 and b2;
  b3 := b1 and (LowerCase(ExtractFileExt(LVjobs.Selected.SubItems[0])) = '.avs');
  mnuEditAvs.Enabled := b3;
  mnuCopyAsAvs.Enabled := b1 and not b3;
  chkConcat.Enabled := b and (TJob(LVjobs.Selected.Data).files.Count > 1);
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
  end;
end;

procedure TfrmGUIta.myGetCaptions(jo: TJob; var v, a, s: string);
var
  k: integer;
  t: string;
begin
  for k := 0 to High(jo.a) do
  begin
    t := jo.a[k].getval('codec_type');
    if t = 'video' then
      v := v + myGetCaptionCont(jo.a[k]) + '; '
    else if t = 'audio' then
      a := a + myGetCaptionCont(jo.a[k]) + '; '
    else if t = 'subtitle' then
      s := s + myGetCaptionCont(jo.a[k]) + '; ';
  end;
end;

function TfrmGUIta.myCalcOutSize(jo: TJob): string;
var
  r, q: double;
  k: integer;
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
  r := 0;
  for k := 0 to High(jo.a) do
    if jo.a[k].getval('Checked') = '1' then
    begin
      t := jo.a[k].getval('codec_type');
      if t = 'video' then
      begin
        if jo.a[k].getval(cmbEncoderV.Name) = 'copy' then
          q := StrToIntDef(jo.a[k].getval('bit_rate'), 0)
        else
          q := my1(jo.a[k].getval(edtBitRateV.Name));
      end
      else if t = 'audio' then
      begin
        if jo.a[k].getval(cmbEncoderA.Name) = 'copy' then
          q := StrToIntDef(jo.a[k].getval('bit_rate'), 0)
        else
          q := my1(jo.a[k].getval(edtBitRateA.Name));
      end
      else
        q := 0;
      if chkDebug.Checked then
        memJournal.Lines.Add('calc out size: ' + t + ' bitrate=' + FloatToStr(q));
      r := r + q;
    end;
  sExt := LowerCase(ExtractFileExt(jo.getval(edtOfn.Name)));
  if sExt = '.mkv' then
    q := 3500
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
  if jo.getval(cmbDurationt2.Name) <> '' then
    q := myTimeStrToReal(jo.getval(cmbDurationt2.Name))
  else
    q := myTimeStrToReal(jo.getval('duration'));
  if chkDebug.Checked then
    memJournal.Lines.Add('calc out size: duration=' + FloatToStr(q));
  r := r / 8 * q;
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

{$IFDEF MSWINDOWS}
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

function TfrmGUIta.myError(i: integer; w: string): integer;
var
  w2: string;
begin
  Result := i;
  case i of
    0: Exit;
    else
    begin
      w2 := IntToStr(i);
      Result := 6;
    end;
  end;
  memJournal.Lines.Add(mes[6] + ': ' + w2 + ' ' + w);
  PageControl1.ActivePage := TabJournal;
end;

procedure TfrmGUIta.myFillEnc;
var
  s: string;
  i: integer;
begin
  cmbEncoderV.Items.Clear;
  cmbEncoderA.Items.Clear;
  cmbEncoderS.Items.Clear;
  s := myStrReplace('"$ffmpeg"') + ' -encoders';
  //myGetDosOut(s, '', '', SynMemo2, StatusBar1);
  myGetDosOut2(s, SynMemo2);
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
begin
  cmbFormat.Items.Clear;
  cmbFormat.Items.Add('');
  cmbExt.Items.Clear;
  cmbExt.Items.Add('');
  s := myStrReplace('"$ffmpeg"') + ' -formats';
  //myGetDosOut(s, '', '', SynMemo2, StatusBar1);
  myGetDosOut2(s, SynMemo2);
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
  Result := bUpdFromCode or (LVjobs.Selected = nil) or
    ((i = 1) and (LVstreams.Selected = nil));
end;

procedure TfrmGUIta.myGetss4Compare(jo: TJob; rs: double = 0; rt: double = 0);
var
  rd, ri, ro, rm: double;
begin
  rd := myTimeStrToReal(jo.getval('duration'));
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
  s, sf: string;
begin
  sf := myGetAnsiFN(fn);
  Result := myGetOutFN(myStrReplace('$dirtmp'), 'tmp', '.bmp');
  if ss = '' then
    ss := '0';
  s := myStrReplace('"$ffmpeg"') + ' -ss ' + ss + ' -i "' + sf + '"' +
    fv + ' -frames 1 -f image2 -y "' + Result + '"';
  myGetDosOut(s, '', '', sm, st);
  //myGetDosOut2(s, sm);
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

function TfrmGUIta.myAutoCrop(jo: TJob; co: TCont): string;
var
  s, c, m, ss, si: string;
  sl: TStringList;
  k: integer;
begin
  ss := jo.getval(cmbDurationss2.Name);
  si := myStrReplace('"$ffmpeg"') + IfThen(ss <> '', ' -ss ' + ss);
  for k := 0 to jo.files.Count - 1 do
    si := si + ' -i "' + myGetAnsiFN(jo.files[k]) + '"';
  if (co.getval('codec_type') = 'video') then
    m := ' -map ' + co.getval('filenum') + ':' + co.getval('index');
  si := si + ' -frames:v 20 -vf "framestep=60, cropdetect" -an -sn' + m + ' -y NUL.mkv';
  //myGetDosOut(si, '', '', SynMemo2, StatusBar1);
  myGetDosOut2(si, SynMemo2);
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
    memJournal.Lines.Add(si);
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
        if myGetFileList(s, edtFileExts.Text, sl2, True) then
        begin
          sl2.Sort;
          files.AddStrings(sl2);
        end;
        sl2.Free;
      end
      else
      if FileExists(s) then
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
function TfrmGUIta.myGetColor: integer;
var
  b: Graphics.TBitmap;
  t: TLazIntfImage;
begin
  b := Graphics.TBitmap.Create;
  b.SetSize(1, 1);
  b.Canvas.Brush.Color := memJournal.Color;
  b.Canvas.FillRect(0, 0, 0, 0);
  t := b.CreateIntfImage;
  Result := t.Colors[0, 0].red + t.Colors[0, 0].green + t.Colors[0, 0].blue;
  t.Free;
  b.Free;
end;

//------------------------------------------------------------------------------

procedure TfrmGUIta.btnAddFilesClick(Sender: TObject);
var
  od: TOpenDialog;
begin
  od := TOpenDialog.Create(frmGUIta);
  if DirectoryExistsUTF8(myExpandFN(cmbDirLast.Text)) then
    od.InitialDir := myExpandFN(cmbDirLast.Text);
  od.Filter := mes[0] + '|' + edtFileExts.Text + '|' + mes[1];
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
  c: TCont;
  s: string;
  li: TListItem;
  frmGrab: TfrmGrab;
begin
  Application.CreateForm(TfrmGrab, frmGrab);
  if frmGrab.ShowModal = mrOK then
  begin
    jo := TJob.Create;
    c := TCont.Create;
    c.setval(cmbAddOptsI.Name, frmGrab.ComboBox2.Text);
    jo.files.AddObject(frmGrab.ComboBox1.Text, c);
    c := TCont.Create;
    c.setval(cmbAddOptsI.Name, frmGrab.ComboBox4.Text);
    jo.files.AddObject(frmGrab.ComboBox3.Text, c);
    jo.filecnt := 1;
    Inc(Counter);
    jo.setval('index', IntToStr(Counter));
    jo.setval('Completed', '0');
    if Trim(edtDirOut.Text) <> '' then
      s := Trim(edtDirOut.Text)
    else
      s := edtDirTmp.Text;
    jo.setval(edtOfn.Name, myGetOutFN(s, 'screengrab', '.mpg'));
    SetLength(jo.a, 2);
    jo.a[0] := TCont.Create;
    jo.a[0].setval('filenum', '0');
    jo.a[0].setval('index', '0');
    jo.a[0].setval('codec_type', 'video');
    jo.a[0].setval('Checked', '1');
    jo.a[1] := TCont.Create;
    jo.a[1].setval('filenum', '1');
    jo.a[1].setval('index', '0');
    jo.a[1].setval('codec_type', 'audio');
    jo.a[1].setval('Checked', '1');


    li := LVjobs.Items.Add;
    li.Checked := True;
    li.Caption := IntToStr(Counter);
    li.SubItems.Add('screen grab');
    li.SubItems.Add('0');
    li.SubItems.Add('0');
    li.SubItems.Add('0');
    inc(DuraAl2);
    frmGUIta.Caption := sCap + ' - ' + mes[21] + ' = ' + myRealToTimeStr(DuraAll)
      + ', ' + mes[27] + ' = ' + IntToStr(DuraAl2);
    li.SubItems.Add('');
    li.SubItems.Add('');
    li.Data := Pointer(jo);
    if (LVjobs.Items.Count = 1) then
    begin
      LVjobs.Items[0].Selected := True;
      LVjobsSelectItem(nil, LVjobs.Items[0], True);
    end;
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
  ty, iv, ia, fv, fa, nv, na, fn, map: string;
  k: integer;
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
  nv := '-1';
  na := '-1';
  map := '';
  for k := 0 to High(jo.a) do
    with jo.a[k] do
      if getval('Checked') = '1' then
      begin
        ty := getval('codec_type');
        if (ty = 'video') and (iv = '') then
        begin
          iv := getval('index');
          fv := myGetFilter(jo, jo.a[k], False);
          fv := IfThen(fv <> '', ' -filter:v "' + fv + '"');
          nv := getval('filenum');
        end
        else if (ty = 'audio') and (ia = '') then
        begin
          ia := getval('index');
          fa := ' -filter_complex "showwaves=s=1200x480:mode=line"';
          na := getval('filenum');
        end;
      end;
  k := StrToIntDef(nv, -1);
  if (k < 0) or (k >= jo.files.Count) then
    k := StrToIntDef(na, -1);
  if (k < 0) or (k >= jo.files.Count) then
    k := 0;
  fn := jo.files[k];
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
  Ini := TIniFile.Create(sInifile);
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
  sl: TStringList;
  i: integer;
  st: array of string;
begin
  s := myStrReplace(cmbRunCmd.Text);
  if chkRunInWindow.Checked then
  begin
    sl := TStringList.Create;
    s := edtxterm.Text + ' ' + edtxtermopts.Text + ' ' + s;
    process.CommandToList(s, sl);
    for i := 1 to sl.Count - 1 do
    begin
      SetLength(st, i);
      st[i - 1] := sl[i];
    end;
    ExecuteProcess(sl[0], st);
    //myExecProc1(s);
    //myExecProc(sl[0], st);
    sl.Free;
  end
  else
  if chkRunInMem.Checked then
  begin
    //myGetDosOut(s, '', '', SynMemo2, StatusBar1);
    myGetDosOut2(s, SynMemo2);
  end
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
  myAdd2cmb(cmbRunCmd, cmbRunCmd.Text, False);
end;

procedure TfrmGUIta.btnCropClick(Sender: TObject);
var
  k, w, h, x, y: integer;
  jo: TJob;
  co: TCont;
  frmCrop: TfrmCrop;
  Ini: TIniFile;
  iv, nv, fn: string;
begin
  if myCantUpd(1) then
    Exit;
  jo := TJob(LVjobs.Selected.Data);
  co := TCont(LVstreams.Selected.Data);
  if cmbCrop.Text = '' then
  begin
    cmbCrop.Text := myAutoCrop(jo, co);
    xmyChange1v(cmbCrop);
  end;
  iv := '';
  nv := '';
  for k := 0 to High(jo.a) do
    with jo.a[k] do
      if (getval('Checked') = '1') and (getval('codec_type') = 'video') and
        (iv = '') then
      begin
        iv := getval('index');
        nv := getval('filenum');
      end;
  k := StrToIntDef(nv, -1);
  if (k < 0) or (k >= jo.files.Count) then
    k := 0;
  fn := jo.files[k];
  if not FileExistsUTF8(fn) then
    Exit;
  Application.CreateForm(TfrmCrop, frmCrop);
  if iv <> '' then
    iv := ' -map 0:' + iv;
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
  Ini := TIniFile.Create(sInifile);
  myFormPosLoad(frmCrop, Ini);
  if frmCrop.ShowModal = mrOk then
  begin
    cmbCrop.Text := frmCrop.Caption;
    xmyChange1v(cmbCrop);
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
  //ExecuteProcess('notepad.exe', [UTF8ToSys(s)]);
  //myLanguage(True);
  myOpenDoc(s);
  cmbLanguage.Items.Clear;
  //myGetFileList(d, '*.lng', cmbLanguage.Items, False, False);
  myGetFileList(sDirApp, '*.lng', cmbLanguage.Items, False, False);
  if sInidir <> sDirApp then
    myGetFileList(sInidir, '*.lng', cmbLanguage.Items, False, False);
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
  sd.InitialDir := myExpandFN(edtDirOut.Text);
  sd.Filter := '*.log|*.log|' + mes[1];
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

procedure TfrmGUIta.btnMediaInfo1Click(Sender: TObject);
var
  s, fn: string;
  {$IFDEF MSWINDOWS}
  se: string;
  sl: TStringList;
  h: cardinal;
  {$ENDIF}
begin
  if myCantUpd(0) then
    Exit;
  {$IFDEF MSWINDOWS}
  s := myGetAnsiFN(myExpandFN(edtMediaInfo.Text));
  if not FileExistsUTF8(s) then
    xmySelFile(edtMediaInfo);
  s := myGetAnsiFN(myExpandFN(edtMediaInfo.Text));
  if not FileExistsUTF8(s) then
    Exit;
  fn := IfThen(Sender = btnMediaInfo2, edtOfn.Text, LVjobs.Selected.SubItems[0]);
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
  fn := IfThen(Sender = btnMediaInfo2, edtOfn.Text, LVjobs.Selected.SubItems[0]);
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
  sd.Filter := mes[1];
  sd.FileName := ExtractFileName(edtOfn.Text);
  if sd.Execute then
    edtOfn.Text := sd.FileName;
  sd.Free;
end;

procedure TfrmGUIta.btnPlayInClick(Sender: TObject);
var
  jo: TJob;
  s, ss, t, si, vf, af, vn, an, sn, filenum: string;
  k: integer;
begin
  if LVjobs.Selected = nil then
    Exit;
  jo := TJob(LVjobs.Selected.Data);
  vf := '';
  af := '';
  vn := '';
  an := '';
  sn := '';
  filenum := '';
  for k := 0 to High(jo.a) do
    with jo.a[k] do
      if (getval('Checked') = '1') then
      begin
        s := getval('codec_type');
        if (s = 'video') and (vn = '') then
        begin
          vn := ' -vst ' + getval('index');
          vf := myGetFilter(jo, jo.a[k]);
          vf := IfThen(vf <> '', ' -vf "' + vf + '"');
          filenum := getval('filenum');
        end
        else if (s = 'audio') and (an = '') then
        begin
          an := ' -ast ' + getval('index');
          af := myGetFilter(jo, jo.a[k]);
          af := IfThen(af <> '', ' -af "' + af + '"');
        end
        else if (s = 'subtitle') and (sn = '') then
          sn := ' -sst ' + getval('index');
      end;
  if vn = '' then
    vn := ' -vn';
  if an = '' then
    an := ' -an';
  if sn = '' then
    sn := ' -sn'; //ffplay 1.0.10 - Missing argument for option 'sn'
  k := StrToIntDef(filenum, 0);
  if (k < 0) or (k >= jo.files.Count) then
    k := 0;
  si := '"$ffplay"';
  ss := jo.getval(cmbDurationss2.Name);
  si := si + IfThen(ss <> '', ' -ss ' + ss);
  s := TCont(jo.files.Objects[k]).getval(cmbDurationss1.Name);
  si := si + IfThen((ss = '') and (s <> ''), ' -ss ' + s);
  t := jo.getval(cmbDurationt2.Name);
  si := si + IfThen(t <> '', ' -t ' + t);
  s := TCont(jo.files.Objects[k]).getval(cmbDurationt1.Name);
  si := si + IfThen((t = '') and (s <> ''), ' -ss ' + s);
  si := si + ' -i "' + myGetAnsiFN(jo.files[k]) + '" -autoexit';
  s := myStrReplace(si + vf + af + vn + an + sn);
  if chkDebug.Checked then
    memJournal.Lines.Add(s);
  myExecProc1(s);
end;

procedure TfrmGUIta.btnPlayOutClick(Sender: TObject);
var
  s, sx: string;
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
  begin
    sx := myExpandFN(cmbExtPlayer.Text);
    if not FileExistsUTF8(sx) then
    begin
      xmySelFile(cmbExtPlayer);
      sx := myExpandFN(cmbExtPlayer.Text);
    end;
    if FileExistsUTF8(sx) then
      myExecProc(sx, [s])
    else if chkDebug.Checked then
      memJournal.Lines.Add(mes[12] + ' ' + sx);
  end
  else
  begin
    s := myStrReplace('"$ffplay"') + ' -i "' + s + '" -autoexit';
    myExecProc1(s);
  end;
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
  sd.Filter := '*.ini|*.ini|' + mes[1];
  sd.DefaultExt := '.ini';
  if not myDirExists(sd.InitialDir, '') then
    Exit;
  b := (cmbEncoderV.Text = 'libx264') or (cmbEncoderV.Text = 'libx264rgb');
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
    Ini := TIniFile.Create(UTF8ToSys(s));
    myToIni(Ini, '1', cmbFormat.Name, cmbFormat.Text);
    myToIni(Ini, '1', cmbExt.Name, cmbExt.Text);
    myToIni(Ini, '1', cmbAddOptsO.Name, cmbAddOptsO.Text);
    myToIni(Ini, '1', cmbDurationss2.Name, cmbDurationss2.Text);
    myToIni(Ini, '1', cmbDurationt2.Name, cmbDurationt2.Text);
    mySets2(Ini, 'input', [TabInput], False);
    mySets2(Ini, 'video', [TabVideo], False);
    mySets2(Ini, 'audio', [TabAudio], False);
    mySets2(Ini, 'subtitle', [TabSubtitle], False);
    Ini.Free;
    cmbProfile.Items.Clear;
    if not FileExistsUTF8(sd.FileName) then
      RenameFileUTF8(s, sd.FileName);
    myOpenDoc(myGetAnsiFN(sd.FileName));
    myGetFileList(sInidir, '*.ini', cmbProfile.Items, False, False);
    cmbProfile.Sorted := True;
  end;
end;

procedure TfrmGUIta.btnStartClick(Sender: TObject);
begin
  if (ThreadConv <> nil) then
  begin
    {$IFDEF MSWINDOWS}
    if ThreadConv.Suspended then
      ThreadConv.Resume;
    {$ENDIF}
    Exit;
  end;
  ThreadConv := TThreadConv.Create(myStrReplace('$dirtmp'));
  if Assigned(ThreadConv.FatalException) then
    raise ThreadConv.FatalException;
  ThreadConv.OnTerminate := @onConvTerminate;
  ThreadConv.Start;
  btnStart.Enabled := False;
  btnSuspend.Enabled := True;
  btnStop.Enabled := True;
  PageControl3.ActivePage := TabConsole2;
end;

procedure TfrmGUIta.btnStopClick(Sender: TObject);
begin
  if ThreadConv <> nil then
  begin
    ThreadConv.pr.Input.WriteAnsiString('q');
    Sleep(2000);
    ThreadConv.Terminate;
    if ThreadConv.pr <> nil then
      ThreadConv.pr.Terminate(-2);
    {$IFDEF MSWINDOWS}
    if ThreadConv.Suspended then
      ThreadConv.Resume;
    {$ENDIF}
  end;
end;

procedure TfrmGUIta.btnSuspendClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  if ThreadConv <> nil then
    if ThreadConv.Suspended then
      ThreadConv.Resume
    else
      ThreadConv.Suspend;
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
  ThreadTest := TThreadTest.Create(myStrReplace('$dirtmp'), LVjobs.Selected);
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
  mySets(False);
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

procedure TfrmGUIta.cmbBitrateAChange(Sender: TObject);
var
  b: boolean;
begin
  b := Pos('$koefa', cmbBitrateA.Text) > 0;
  spnKoefA.Enabled := b;
  lblkoefA.Enabled := b;
  if myCantUpd(1) then
    Exit;
  xmyChange1(Sender);
  edtBitrateA.Text := myCalcBRa(TCont(LVstreams.Selected.Data));
end;

procedure TfrmGUIta.cmbBitrateVChange(Sender: TObject);
var
  b: boolean;
begin
  b := Pos('$koefv', cmbBitrateV.Text) > 0;
  spnKoefV.Enabled := b;
  lblkoefV.Enabled := b;
  if myCantUpd(1) then
    Exit;
  xmyChange1(Sender);
  edtBitrateV.Text := myCalcBRv(TCont(LVstreams.Selected.Data));
end;

procedure TfrmGUIta.cmbEncoderVChange(Sender: TObject);
var
  b, b2: boolean;
  i: integer;
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
  b := (TComboBox(Sender).Text <> 'copy');
  b2 := b and ((TComboBox(Sender).Text = 'libx264') or
    (TComboBox(Sender).Text = 'libx264rgb'));
  c := TControl(Sender).Parent;
  for i := 0 to c.ControlCount - 1 do
    if c.Controls[i].Name <> TControl(Sender).Name then
      if Pos('x264', c.Controls[i].Name) > 0 then
        c.Controls[i].Enabled := b2
      else
      //c.Controls[i].Enabled := b and (c.Controls[i].Tag = 0);
        c.Controls[i].Enabled := b;
  xmyChange1(Sender);
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
  if (Length(s) = 0) or ((Length(s) > 0) and (s[1] <> '.')) then
    s := '.' + s;
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
  myLanguage(True);
end;

procedure TfrmGUIta.cmbProfileChange(Sender: TObject);
var
  s, c, se: string;
  Ini: TIniFile;
  jo: TJob;
  f: TCont;
  i, k: integer;
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
  s := myGetAnsiFN(s);
  Ini := TIniFile.Create(UTF8ToSys(s));
  jo := TJob(LVjobs.Selected.Data);
  jo.setval(cmbFormat.Name, Ini.ReadString('1', cmbFormat.Name, ''));
  se := Ini.ReadString('1', cmbExt.Name, '');
  jo.setval(cmbExt.Name, se);
  jo.setval(edtOfn.Name, ChangeFileExt(jo.getval(edtOfn.Name), se));
  {$IFDEF MSWINDOWS}
  jo.setval(edtOfna.Name, ChangeFileExt(jo.getval(edtOfna.Name), se));
  {$ENDIF}
  //jo.setval(cmbAddOptsI.Name, Ini.ReadString('1', cmbAddOptsI.Name, ''));
  jo.setval(cmbAddOptsO.Name, Ini.ReadString('1', cmbAddOptsO.Name, ''));
  jo.setval(cmbDurationss2.Name, Ini.ReadString('1', cmbDurationss2.Name, ''));
  jo.setval(cmbDurationt2.Name, Ini.ReadString('1', cmbDurationt2.Name, ''));
  for k := 0 to jo.files.Count - 1 do
  begin
    f := TCont(jo.files.Objects[k]);
    for i := 0 to TabInput.ControlCount - 1 do
    begin
      s := Ini.ReadString('input', TabInput.Controls[i].Name, '');
      f.setval(TabInput.Controls[i].Name, s);
    end;
  end;
  for k := 0 to High(jo.a) do
  begin
    c := jo.a[k].getval('codec_type');
    if c = 'video' then
      t := TabVideo
    else if c = 'audio' then
      t := TabAudio
    else if c = 'subtitle' then
      t := TabSubtitle
    else
      Continue;
    for i := 0 to t.ControlCount - 1 do
    begin
      s := Ini.ReadString(c, t.Controls[i].Name, '');
      jo.a[k].setval(t.Controls[i].Name, s);
    end;
    if c = 'video' then
      jo.a[k].setval(edtBitrateV.Name, myCalcBRv(jo.a[k]))
    else if c = 'audio' then
      jo.a[k].setval(edtBitrateA.Name, myCalcBRa(jo.a[k]));
  end;
  Ini.Free;
  LVjobs.Selected.SubItems[2] := myCalcOutSize(jo);
  LVjobsSelectItem(Sender, LVjobs.Selected, True);
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
  else
    edtOfna.Text := myGetOutFNa(sd, LVjobs.Selected.SubItems[0], se);
  {$ENDIF}
  cmbExt.Text := se;
  cmbExtChange(cmbExt);
  xmyChange0(cmbFormat);
end;

procedure TfrmGUIta.FormCreate(Sender: TObject);
var
  b: boolean;
  s, t: string;
  i: integer;
  sl: TStringList;
  {$IFDEF MSWINDOWS}
  reg: TRegistry;
  p: PChar;
  {$ENDIF}
  procedure my1(a: array of string);
  var
    i: integer;
    s: string;
  begin
    for i := Low(a) to High(a) do
    begin
      s := a[i];
      if FileExists(FindDefaultExecutablePath(s)) then
        cmbExtPlayer.Items.Add(s);
    end;
    if cmbExtPlayer.Items.Count > 0 then
      cmbExtPlayer.Text := cmbExtPlayer.Items[0];
  end;

begin
  memJournal.Clear;
  sCap := 'ffmpegGUIta ' + taVersion + '.' + taRevision + ' alpha';
  frmGUIta.Caption := sCap;
  memJournal.Lines.Add(sCap + ' - ' + taBuildDate + ' - Free Pascal ' +
    fpcVersion + ' - Lazarus ' + lazVersion + '-' + lazRevision +
    ' - ' + TargetCPU + ' ' + TargetOS);
  SynMemo2.Clear;
  SynMemo3.Clear;
  SynMemo4.Clear;
  SynMemo5.Clear;
  SynMemo6.Clear;
  if myGetColor < 400 then  //if dark theme
  begin
    SynUNIXShellScriptSyn1.CommentAttri.Foreground := clLime;  //Green
    SynUNIXShellScriptSyn1.NumberAttri.Foreground := clAqua;  //Blue
    SynUNIXShellScriptSyn1.SecondKeyAttri.Foreground := clRed; //Maroon
    SynUNIXShellScriptSyn1.StringAttri.Foreground := clYellow; //Olive
    //SynUNIXShellScriptSyn1.SymbolAttri.Foreground := clAqua;  //Teal
    SynUNIXShellScriptSyn1.VarAttri.Foreground := clFuchsia;   //Purple
  end;
  Files2Add := TList.Create;
  Counter := 0;
  fs.DecimalSeparator := '.';
  fs.ThousandSeparator := ' ';
  DuraAll := 0;
  {$IFDEF MSWINDOWS}
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
  {$ENDIF}
  sDirApp := ExtractFilePath(Application.ExeName);
  if DirectoryIsWritable(sDirApp) then
    sInidir := sDirApp
  else
    sInidir := GetAppConfigDirUTF8(False, True);
  sInifile := AppendPathDelim(sInidir) + ExtractFileNameOnly(Application.ExeName) + '.cfg';
  b := FileExistsUTF8(sInifile);
  if b then
  begin
    bUpdFromCode := True;
    mySets(True);
    bUpdFromCode := False;
    if chk1instance.Checked then
    begin
      myUnik := TUniqueInstance.Create(Self);
      myUnik.OnOtherInstance := @UniqueInstance1OtherInstance;
      myUnik.Enabled := True;
      myUnik.Loaded;
    end;
  end
  else
  begin
    cmbDirLast.Text := GetCurrentDir;
    {$IFDEF MSWINDOWS}
    s := 'C:\TEMP';
    if DirectoryExistsUTF8(s) then
      edtDirOut.Text := s;
    cmbExtPlayer.Items.Add('%ProgramFiles%\Windows Media Player\wmplayer.exe');
    edtxterm.Text := 'cmd.exe';
    edtxtermopts.Text := '/c';
    {$ELSE}
    edtffmpeg.Text := 'ffmpeg';
    edtffplay.Text := 'ffplay';
    edtffprobe.Text:= 'ffprobe';
    edtDirTmp.Text := '/tmp';
    edtDirOut.Text := '$HOME';
    edtMediaInfo.Text:= 'mediainfo-gui';
    my1(['vlc', 'dragon', 'avplay', 'ffplay', 'mplayer', 'totem', 'xine']);
    cmbDirLast.Text := '$HOME';
    cmbFont.Text := 'Ubuntu';
    edtxterm.Text := '/usr/bin/xterm';
    edtxtermopts.Text := '-e';
    if FileExists('/usr/bin/x-terminal-emulator') then
      edtxterm.Text := '/usr/bin/x-terminal-emulator';
    if FileExists('/usr/bin/gnome-terminal') then
    begin
      edtxterm.Text :='/usr/bin/gnome-terminal';
      edtxtermopts.Text := '-x';
    end;
    {$ENDIF}
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
  end;
  frmGUIta.Font.Name := cmbFont.Text;
  //messages
  mes[0] := 'Video files';
  mes[1] := 'All files (*)|*';
  mes[2] := 'Usage: ffmpegGUIta [-start] [<video files>...]\n-start: start converting';
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
  s := UpperCase(mes[6]);
  if SynUNIXShellScriptSyn1.SecondKeyWords.IndexOf(s) < 0 then
    SynUNIXShellScriptSyn1.SecondKeyWords.Add(s);
  //end of mes
  myGetFileList(sDirApp, '*.lng', cmbLanguage.Items, False, False);
  if sInidir <> sDirApp then
    myGetFileList(sInidir, '*.lng', cmbLanguage.Items, False, False);
  cmbLanguage.Sorted := True;
  if cmbLanguage.Text <> '' then
    if cmbLanguage.Items.IndexOf(cmbLanguage.Text) >= 0 then
      myLanguage(True);
  myGetFileList(sInidir, '*.ini', cmbProfile.Items, False, False);
  cmbProfile.Sorted := True;
  if cmbProfile.Text <> '' then
  begin
    if cmbProfile.Items.IndexOf(cmbProfile.Text) >= 0 then
      cmbProfileChange(cmbProfile);
  end
  else
  begin
    if cmbProfile.Items.Count > 0 then
      cmbProfile.ItemIndex := 0;
  end;
  if not b then
  begin
    myFindFiles(sDirApp, [edtffmpeg, edtffprobe, edtffplay, edtMediaInfo, cmbExtPlayer]);
    {$IFDEF MSWINDOWS}
    if not FileExistsUTF8(myExpandFN(edtMediaInfo.Text)) then
    begin
      reg := TRegistry.Create;
      try
        Reg.RootKey := HKEY_CLASSES_ROOT;
        if Reg.OpenKeyReadOnly('\SystemFileAssociations\.avi\Shell\MediaInfo') then
        begin
          s := Reg.ReadString('Icon');
          p := PChar(s);
          s := AnsiExtractQuotedStr(p, '"');
          if FileExistsUTF8(s) then
            mySet2(edtMediaInfo, myUnExpandFN(s))
          else
            s := '';
        end;
        if (s = '') and Reg.OpenKeyReadOnly(
          '\Local Settings\Software\Microsoft\Windows\Shell\MuiCache') then
        begin
          sl := TStringList.Create;
          Reg.GetValueNames(sl);
          for i := 0 to sl.Count - 1 do
          begin
            s := sl[i];
            if (Pos('mediainfo.exe', LowerCase(s)) > 0) and FileExistsUTF8(s) then
            begin
              mySet2(edtMediaInfo, myUnExpandFN(s));
              Break;
            end;
          end;
        end;
        Reg.CloseKey;
      except
        on E: Exception do
          ShowMessage(E.Message);
      end;
      reg.Free;
    end;
    {$ENDIF}
    {$IFDEF MSWINDOWS}
    if not FileExistsUTF8(myExpandFN(cmbExtPlayer.Text)) then
    begin
      reg := TRegistry.Create;
      try
        Reg.RootKey := HKEY_CLASSES_ROOT;
        if Reg.OpenKeyReadOnly('\Applications\mpc-hc.exe\shell\open\command') then
        begin
          s := Reg.ReadString('');
          s := Copy(s, 2, Length(s) - 7);
          if FileExistsUTF8(s) then
          begin
            s := myUnExpandFN(s);
            mySet2(cmbExtPlayer, s);
            myAdd2cmb(cmbExtPlayer, s);
          end
          else
            s := '';
        end;
        Reg.CloseKey;
      except
        on E: Exception do
          ShowMessage(E.Message);
      end;
      reg.Free;
    end;
    if FileExistsUTF8(myExpandFN(cmbExtPlayer.Text)) then
      chkPlayer3.Checked := True;
    {$ENDIF}
  end;
  {$IFDEF MSWINDOWS}
  xmyCheckFile(edtffmpeg);
  xmyCheckFile(edtffprobe);
  xmyCheckFile(edtffplay);
  xmyCheckFile(edtMediaInfo);
  xmyCheckFile(cmbExtPlayer);
  cmbProfileChange(cmbProfile);
  {$ENDIF}
  myFillEnc;
  myFillFmt;
end;

procedure TfrmGUIta.FormDestroy(Sender: TObject);
begin
  mySets(False);
  Files2Add.Free;
end;

procedure TfrmGUIta.FormDropFiles(Sender: TObject; const FileNames: array of string);
var
  i: integer;
  SL, ST: TStringList;
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
      if DirectoryExistsUTF8(FileNames[i]) then
      begin
        SL := TStringList.Create;
        if myGetFileList(FileNames[i], edtFileExts.Text, SL, True) then
        begin
          SL.Sort;
          ST.AddStrings(SL);
        end;
        SL.Free;
      end
      else
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
  {$IFDEF MSWINDOWS}
  SLp: TStringList;
  {$ENDIF}
  SL, SL1: TStringList;
  i: integer;
  s, t: string;
  b: boolean;
begin
  try
    SL1 := TStringList.Create;
    if ParamCount > 0 then
    begin
      {$IFDEF MSWINDOWS}
      SLp := TStringList.Create;
      CommandToList(UTF8Encode(WideString(GetCommandLineW)), SLp);
      while SLp.Count <= ParamCount do
        SLp.Add('');
      {$ENDIF}
      for i := 1 to ParamCount do
      begin
        s := ParamStr(i); //UTF8 from Lazarus for test params
        {$IFDEF MSWINDOWS}
        if not (FileExistsUTF8(s) or DirectoryExistsUTF8(s)) then
          s := SLp[i]; //UTF16 from Windows apps
        {$ENDIF}
        b := False;
        if Pos('~', s) > 0 then
        begin
          t := myExpandFileNameCaseW(s, b);
          if b then
            s := t;
        end;
        if FileExistsUTF8(s) or DirectoryExistsUTF8(s) then
        begin
          if DirectoryExistsUTF8(s) then
          begin
            SL := TStringList.Create;
            if myGetFileList(s, edtFileExts.Text, SL, True) then
            begin
              SL.Sort;
              SL1.AddStrings(SL);
            end;
            SL.Free;
          end
          else
            SL1.Add(s);
        end
        else if (s[1] = '-') or (s[1] = '/') then
        begin
          t := Copy(LowerCase(s), 2, Length(s));
          if (t = 'start') then
          begin
            tAutoStart := TTimer.Create(Self);
            tAutoStart.Enabled := False;
            tAutoStart.Interval := 5000;
            tAutoStart.OnTimer := @ontAutoStart;
            tAutoStart.Enabled := True;
          end
          else
          if (Copy(t, 1, 2) = 'o:') then
          begin
            edtDirOut.Text := StringReplace(Copy(s, 4, Length(s)), '"', '', [rfReplaceAll]);
          end
          else
            ShowMessage(StringReplace(mes[2], '\n', #13, [rfReplaceAll]));
        end;
      end;
      {$IFDEF MSWINDOWS}
      SLp.Free;
      {$ENDIF}
    end
    else if myGetFileList(GetCurrentDir, edtFileExts.Text, SL1, True) then
      SL1.Sort;
    myAddFiles(SL1);
    SL1.Free;
  except
    on E: Exception do
      ShowMessage(E.Message)
  end;
end;

procedure TfrmGUIta.LVfilesSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  i, j, k, l: integer;
  jo: TJob;
  s: string;
begin
  if (LVjobs.Selected <> nil) and (LVfiles.Selected <> nil) then
  begin
    jo := TJob(LVjobs.Selected.Data);
    l := LVfiles.Selected.Index;
    if (l >= 0) and (l < jo.files.Count) then
    begin
      myGetValsFromCont(TabInput, TCont(jo.files.Objects[l]));
      if bUpdFromCode then
        Exit;
      bUpdFromCode := True;
      j := -1;
      k := -1;
      for i := 0 to LVstreams.Items.Count - 1 do
      begin
        s := TCont(LVstreams.Items[i].Data).getval('filenum');
        if (s = IntToStr(l)) then
        begin
          if (j < 0) and LVstreams.Items[i].Checked then
            j := i;
          if (k < 0) then
            k := i;
        end;
        LVstreams.Items[i].Selected := False;
      end;
      if (j >= 0) then
        i := j
      else if (k >= 0) then
        i := k
      else
        i := -1;
      bUpdFromCode := False;
      if (i >= 0) then
        LVstreams.Items[i].Selected := True;
    end;
  end;
end;

procedure TfrmGUIta.LVjobsClick(Sender: TObject);
begin
  if LVjobs.Selected = nil then
  begin
    edtOfn.EditLabel.Caption := mes[7];
    myClear2([TabInput, TabOutput, TabVideo, TabAudio, TabSubtitle, TabContRows, TabCmdline]);
    LVfiles.Clear;
    LVstreams.Clear;
  end;
  myDisComp;
end;

procedure TfrmGUIta.LVjobsContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: boolean);
begin
  if LVjobs.Selected = nil then
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
    i := StrToIntDef(TJob(Item.Data).getval('Completed'), 3);
    if (i > 3) or (i < 0) then
      i := 3;
    Item.ImageIndex := i;
  end;
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
end;

procedure TfrmGUIta.LVjobsDragDrop(Sender, Source: TObject; X, Y: integer);
var
  currentItem, nextItem, dragItem, dropItem: TListItem;
  i: integer;
begin
  if Sender = Source then
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
  if Source = LVstreams then
    LVstreamsExit(nil);
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
      DuraAll := DuraAll + myTimeStrToReal(jo.getval('duration'));
      inc(DuraAl2);
    end;
  frmGUIta.Caption := sCap + ' - ' + mes[21] + ' = ' + myRealToTimeStr(DuraAll)
    + ', ' + mes[27] + ' = ' + IntToStr(DuraAl2);
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
  k: integer;
  jo: TJob;
  li: TListItem;
begin
  bUpdFromCode := True;
  LVfiles.Clear;
  LVstreams.Clear;
  myClear2([TabInput, TabOutput, TabVideo, TabAudio, TabSubtitle, TabContRows, TabCmdline]);
  if LVjobs.Selected <> nil then
    jo := TJob(LVjobs.Selected.Data)
  else
    jo := TJob(Item.Data);
  for k := 0 to jo.files.Count - 1 do
  begin
    li := LVfiles.Items.Add;
    li.Caption := IntToStr(k);;
    li.SubItems.Add(jo.files[k]);
  end;
  myGetValsFromCont(TabOutput, jo);
  for k := 0 to High(jo.a) do
  begin
    li := LVstreams.Items.Add;
    li.Checked := jo.a[k].getval('Checked') = '1';
    li.Caption := jo.a[k].getval('filenum') + ':' + jo.a[k].getval('index');
    li.SubItems.Add(myGetCaptionCont(jo.a[k]));
    li.Data := Pointer(jo.a[k]);
  end;
  bUpdFromCode := False;
  myDisComp;
  if LVstreams.Items.Count = 1 then
  begin
    LVstreams.Items[0].Selected := True;
    LVstreamsSelectItem(Sender, LVstreams.Selected, True);
  end
  else
    TabVideoShow(PageControl2.ActivePage);
end;

procedure TfrmGUIta.LVstreamsClick(Sender: TObject);
begin
  if LVstreams.Selected = nil then
  begin
    myClear2([TabVideo, TabAudio, TabSubtitle, TabContRows]);
    PageControl2.ActivePage := TabOutput;
  end;
end;

procedure TfrmGUIta.LVstreamsExit(Sender: TObject);
var
  i: integer;
begin
  if myCantUpd(0) then
    Exit;
  for i := 0 to LVstreams.Items.Count - 1 do
    TJob(LVjobs.Selected.Data).a[i] := TCont(LVstreams.Items[i].Data);
end;

procedure TfrmGUIta.LVstreamsItemChecked(Sender: TObject; Item: TListItem);
var
  s: string;
begin
  if myCantUpd(0) then
    Exit;
  s := IfThen(Item.Checked, '1', '0');
  TCont(Item.Data).setval('Checked', s);
  TJob(LVjobs.Selected.Data).a[Item.Index].setval('Checked', s);
  LVjobs.Selected.SubItems[2] := myCalcOutSize(TJob(LVjobs.Selected.Data));
  if PageControl2.ActivePage = TabCmdline then
    TabCmdlineShow(Sender);
end;

procedure TfrmGUIta.LVstreamsSelectItem(Sender: TObject; Item: TListItem;
  Selected: boolean);
var
  c: TCont;
  s: string;
  ts: TTabSheet;
begin
  if bUpdFromCode then
    Exit;
  bUpdFromCode := True;
  if LVstreams.Selected <> nil then
    c := TCont(LVstreams.Selected.Data)
  else
    c := TCont(Item.Data);
  TabVideo.Enabled := False;
  TabAudio.Enabled := False;
  TabSubtitle.Enabled := False;
  s := c.getval('codec_type');
  if s = 'video' then
  begin
    myGetValsFromCont(TabVideo, c);
    TabVideo.Enabled := True;
    ts:= TabVideo;
    cmbBitrateVChange(cmbBitrateV);
    cmbEncoderVChange(cmbEncoderV);
  end
  else if s = 'audio' then
  begin
    myGetValsFromCont(TabAudio, c);
    TabAudio.Enabled := True;
    ts := TabAudio;
    cmbBitrateAChange(cmbBitrateA);
    cmbEncoderVChange(cmbEncoderA);
  end
  else if s = 'subtitle' then
  begin
    myGetValsFromCont(TabSubtitle, c);
    TabSubtitle.Enabled := True;
    ts := TabSubtitle;
    cmbEncoderVChange(cmbEncoderS);
  end;
  if (PageControl2.ActivePage = TabVideo)
  or (PageControl2.ActivePage = TabAudio)
  or (PageControl2.ActivePage = TabSubtitle) then
    PageControl2.ActivePage := ts
  else if (PageControl2.ActivePage = TabInput) then
    TabInputShow(nil)
  else if (PageControl2.ActivePage = TabOutput) then
  begin
    cmbFormatChange(cmbFormat);
    cmbExtChange(cmbExt);
  end
  else if (PageControl2.ActivePage = TabContRows) then
    TabContRowsShow(nil)
  else if (PageControl2.ActivePage = TabCmdline) then
    TabCmdlineShow(nil);
  bUpdFromCode := False;
end;

procedure TfrmGUIta.mnuCheckClick(Sender: TObject);
var
  i: integer;
begin
  mnuCheck.Checked := not mnuCheck.Checked;
  for i := 0 to LVjobs.Items.Count - 1 do
    LVjobs.Items[i].Checked := mnuCheck.Checked;
end;

procedure TfrmGUIta.mnuCopyAsAvsClick(Sender: TObject);
{$IFDEF MSWINDOWS}
var
  s: string;
  sl: TStringList;
  b: boolean;
  {$ENDIF}
begin
  if LVjobs.Selected = nil then
    Exit;
  {$IFDEF MSWINDOWS}
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

procedure TfrmGUIta.mnuEditAvsClick(Sender: TObject);
var
  s: string;
begin
  if LVjobs.Selected = nil then
    Exit;
  s := myGetAnsiFN(LVjobs.Selected.SubItems[0]);
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
    if (Sender = mnuPasteTracks) and (LVjobs.Selected <> nil) then
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
begin
  ThreadConv := nil;
  btnStart.Enabled := True;
  btnSuspend.Enabled := False;
  btnStop.Enabled := False;
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

procedure TfrmGUIta.TabCmdlineShow(Sender: TObject);
begin
  if (LVjobs.Selected <> nil) then
    memCmdlines.Text := myGetCmdFromJo(TJob(LVjobs.Selected.Data));
end;

procedure TfrmGUIta.TabContRowsShow(Sender: TObject);
var
  i: integer;
  jo: TJob;
  c: TCont;
begin
  SynMemo4.Clear;
  if LVjobs.Selected <> nil then
  begin
    jo := TJob(LVjobs.Selected.Data);
    if LVstreams.Selected = nil then
    begin
      for i := 0 to jo.files.Count - 1 do
        SynMemo4.Lines.Add('$inpu' + IntToStr(i) + '=' + jo.files[i]);
      for i := 0 to jo.sk.Count - 1 do
        SynMemo4.Lines.Add(jo.sk[i] + '=' + jo.sv[i]);
    end
    else
    begin
      c := TCont(LVstreams.Selected.Data);
      for i := 0 to c.sk.Count - 1 do
        SynMemo4.Lines.Add(c.sk[i] + '=' + c.sv[i]);
    end;
  end;
end;

procedure TfrmGUIta.TabInputShow(Sender: TObject);
var
  i: integer;
  s: string;
  jo: TJob;
begin
  if (LVjobs.Selected <> nil) then
  begin
    for i := 0 to LVfiles.Items.Count - 1 do
      LVfiles.Items[i].Selected := False;
    jo := TJob(LVjobs.Selected.Data);
    if (LVstreams.Selected <> nil) then
      s := TCont(LVstreams.Selected.Data).getval('filenum')
    else
      s := '0';
    i := StrToIntDef(s, -1);
    if (i >= 0) and (i < jo.files.Count) then
      LVfiles.Items[i].Selected := True;
  end;
end;

procedure TfrmGUIta.TabVideoShow(Sender: TObject);
var
  i, j, k: integer;
  s: string;
begin
  if myCantUpd(0) then
    Exit;
  bUpdFromCode := True;
  j := -1;
  k := -1;
  for i := 0 to LVstreams.Items.Count - 1 do
  begin
    s := TCont(LVstreams.Items[i].Data).getval('codec_type');
    if (s = LowerCase(Copy(TTabSheet(Sender).Name, 4, 8))) then
    begin
      if (j < 0) and LVstreams.Items[i].Checked then
        j := i;
      if (k < 0) then
        k := i;
    end;
    LVstreams.Items[i].Selected := False;
  end;
  if (j >= 0) then
    i := j
  else if (k >= 0) then
    i := k
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
  sl: TStringList;
begin
  sl := TStringList.Create;
  for i := Low(Parameters) to High(Parameters) do
    sl.Add(Parameters[i]);
  if sl.Count > 0 then
    myAddFiles(sl);
  sl.Free;
  BringToFront;
end;

procedure TfrmGUIta.xmyChange0i(Sender: TObject);
var
  s1, s2: string;
  i: integer;
  jo: TJob;
begin
  if myCantUpd(0) then
    Exit;
  s1 := (Sender as TControl).Name;
  s2 := myGet2(Sender);
  jo := TJob(LVjobs.Selected.Data);
  if (LVfiles.Selected <> nil) then
    i := LVfiles.Selected.Index
  else
    i := -1;
  if (i >= 0) and (i < jo.files.Count) then
    TCont(TJob(LVjobs.Selected.Data).files.Objects[i]).setval(s1, s2);
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
  myDisComp;
end;

procedure TfrmGUIta.xmyChange0o(Sender: TObject);
begin
  if myCantUpd(0) then
    Exit;
  xmyChange0(Sender);
  LVjobs.Selected.SubItems[2] := myCalcOutSize(TJob(LVjobs.Selected.Data));
end;

procedure TfrmGUIta.xmyChange1(Sender: TObject);
var
  s1, s2: string;
begin
  if myCantUpd(1) then
    Exit;
  s1 := (Sender as TControl).Name;
  s2 := myGet2(Sender);
  TCont(LVstreams.Selected.Data).setval(s1, s2);
  TJob(LVjobs.Selected.Data).a[LVstreams.Selected.Index].setval(s1, s2);
end;

procedure TfrmGUIta.xmyChange1v(Sender: TObject);
begin
  if myCantUpd(1) then
    Exit;
  xmyChange1(Sender);
  edtBitrateV.Text := myCalcBRv(TJob(LVjobs.Selected.Data).a[LVstreams.Selected.Index]);
end;

procedure TfrmGUIta.xmyChange1a(Sender: TObject);
begin
  if myCantUpd(1) then
    Exit;
  xmyChange1(Sender);
  edtBitrateA.Text := myCalcBRa(TJob(LVjobs.Selected.Data).a[LVstreams.Selected.Index]);
end;

procedure TfrmGUIta.xmyChange1o(Sender: TObject);
begin
  if myCantUpd(1) then
    Exit;
  xmyChange1(Sender);
  LVjobs.Selected.SubItems[2] := myCalcOutSize(TJob(LVjobs.Selected.Data));
end;

procedure TfrmGUIta.xmyCheckDir(Sender: TObject);
var
  s: string;
begin
  s := myExpandFN(myGet2(Sender));
  {$IFDEF MSWINDOWS}
  if Copy(s, 2, 1) <> ':' then
  {$ELSE}
  if Copy(s, 1, 1) <> '/' then
  {$ENDIF}
    s := sDirApp + s;
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
  s := myExpandFN(myGet2(Sender));
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
    w := myExpandFN(w);
    {$IFDEF MSWINDOWS}
    if Copy(w, 2, 1) <> ':' then
    {$ELSE}
    if Copy(w, 1, 1) <> '/' then
    {$ENDIF}
      w := sDirApp + w;
    od.InitialDir := ExtractFileDir(w);
    w := ExtractFileName(w);
    od.FileName := w;
  end
  else
  begin
    w := Copy((Sender as TControl).Name, 4, 20) + sExt;
    od.FileName := w;
  end;
  if sExt <> '' then
    od.Filter := w + '|' + w + '|' + mes[17] + ' (*' + sExt + ')|*' + sExt + '|' + mes[1]
  else
    od.Filter := w + '|' + w + '|' + mes[1];
  od.DefaultExt := sExt;
  if od.Execute then
  begin
    mySet2(Sender, myUnExpandFN(od.FileName));
    TWinControl(Sender).Font.Color := clWindowText;
  end;
  od.Free;
end;

end.