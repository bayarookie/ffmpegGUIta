unit uThreadAddF;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, utf8process, Process, LazFileUtils, LazUTF8, //fileutil,
  IniFiles, ComCtrls, Math, ujobinfo, ubyutils;

type

  { TThreadAddF }

  TThreadAddF = class(TThread)
  private
    dt: TDateTime;
    jo: TJob;
    fStopIfError: boolean;
    filename: string;
    filenamew: string;
    filenum: integer;
    fcmd: string;
    fpar: TStringList;
    fStatus: string;
    fExitStatus: integer;
    procedure DataGet;
    procedure DataOut;
    procedure ShowJournal;
    procedure ShowStatus1;
    procedure ShowSynMemo;
  protected
    procedure Execute; override;
  public
    pr: TProcessUTF8;
    constructor Create(CreateSuspended: boolean);
  end;

implementation

uses ufrmGUIta;

{ TThreadAddF }

procedure TThreadAddF.DataGet;
var
  l: integer;
  s: string;
begin
  dt := Now;
  fStopIfError := frmGUIta.chkStopIfError.Checked;
  filenum := -1;
  fcmd := '';
  fpar.Clear;
  while Files2Add.Count > 0 do
  begin
    jo := TJob(Files2Add.Items[0]);
    for l := 0 to High(jo.f) do
    if jo.f[l].getval(sMyffprobe) = '0' then
    begin
      jo.f[l].setval(sMyffprobe, '1');
      filenamew := jo.f[l].getval(sMyFilename);
      filename := myGetAnsiFN(filenamew);
      s := LowerCase(ExtractFileExt(filename));
      fpar.Add('-hide_banner');
      fpar.Add('-show_format');
      fpar.Add('-show_streams');
      if s = '.vob' then
      begin
        fpar.Add('-analyzeduration'); fpar.Add('100M');
        fpar.Add('-probesize');       fpar.Add('100M');
      end;
      fpar.Add(filename);
      fcmd := frmGUIta.myStrReplace('$ffprobe');
      filenum := l;
      Break;
    end;
    if filenum < 0 then
      Files2Add.Delete(0)
    else
      Break;
  end;
  if fcmd > '' then
  begin
    frmGUIta.SynMemo6.Clear;
    frmGUIta.StatusBar1.SimpleText := filenamew;
  end;
end;

procedure TThreadAddF.DataOut;
var
  s, v, a, lng, styp: string;
  i, k, iv, ia, ia2: integer;
  r: double;
  sl: TStringList;
  Ini: TIniFile;
  li: TListItem;
  bj, bp: boolean;
  c: TCont;
begin
  bj := False; //job is not checked
  if filenum > 0 then
  begin
    iv := 0; //if video stream is checked then get number of stream
    ia := 0; //also for audio
  end
  else
  begin
    iv := -1;
    ia := -1;
  end;
  ia2 := -1;
  sl := TStringList.Create;
  s := jo.getval(frmGUIta.cmbProfile.Name);
  s := myGetAnsiFN(AppendPathDelim(sInidir) + s);
  Ini := TIniFile.Create(UTF8ToSys(s));
  //fill output sets from profile.ini
  Ini.ReadSectionValues('1', sl);
  for i := 0 to sl.Count - 1 do
    jo.setpair(sl[i]);
  s := frmGUIta.SynMemo6.Text;
  //information about container format of the input multimedia stream
  sl.Text := myBetween(s, '[FORMAT]', '[/FORMAT]');
  for i := 0 to sl.Count - 1 do
    jo.f[filenum].setpair(sl[i]);
  jo.f[filenum].setval('----------', '---------------------------------------------------------------------');
  //fill input sets from profile.ini
  Ini.ReadSectionValues('input', sl);
  for i := 0 to sl.Count - 1 do
    jo.f[filenum].setpair(sl[i]);
  //enumerate streams
  s := frmGUIta.SynMemo6.Text;
  repeat
    sl.Text := myBetween(s, '[STREAM]', '[/STREAM]');
    if (sl.Text = '') then
      Break;
    k := jo.f[filenum].AddStream;
    c := jo.f[filenum].s[k];
    jo.AddMap(IntToStr(filenum) + ':' + IntToStr(k));
    for i := 0 to sl.Count - 1 do
      c.setpair(sl[i]);
    if (c.getval('codec_name') = 'unknown') then
      Continue;
    c.setval('----------', '---------------------------------------------------------------------');
    //fill stream sets from profile.ini
    styp := c.getval('codec_type');
    sl.Clear;
    Ini.ReadSectionValues(styp, sl);
    for i := 0 to sl.Count - 1 do
      c.setpair(sl[i]);
    //to check, or not to check, that is a question
    bp := sl.Count > 0;
    if (styp = 'video') then
    begin
      if bp and (iv < 0) then
      begin
        iv := k;
        c.setval('Checked', '1');
        bj := True;
      end;
      {$IFDEF MSWINDOWS}
      if FileExistsUTF8(frmGUIta.myExpandFN(frmGUIta.edtMediaInfo.Text)) then
      begin
        i := StrToIntDef(c.getval('bit_rate'), 0);
        if i = 0 then
        begin
          v := frmGUIta.myGetMediaInfo(filename, 'BitRate');
          i := StrToIntDef(v, 0);
          if i = 0 then
            v := frmGUIta.myGetMediaInfo(filename, 'BitRate_Nominal');
          c.setval('bit_rate', v);
        end;
        r := frmGUIta.myValFPS([c.getval('avg_frame_rate'), c.getval('r_frame_rate')]);
        if r = 1000 then
        begin
          v := frmGUIta.myGetMediaInfo(filename, 'FrameRate');
          c.setval('avg_frame_rate', v);
        end;
      end;
      {$ENDIF}
      c.setval(frmGUIta.edtBitrateV.Name, frmGUIta.myCalcBRv(c));
      //title
      if frmGUIta.chkMetadataGet.Checked then
      begin
        v := c.getval('TAG:title');
        c.setval(frmGUIta.cmbTagTitleV.Name, v);
        v := c.getval('TAG:language');
        c.setval(frmGUIta.cmbTagLangV.Name, v);
      end;
    end
    else
    if (styp = 'audio') then
    begin
      lng := c.getval('TAG:language');
      if (lng = '') and (filenum > 0) then
      begin
        lng := frmGUIta.myGetLngFromFNs(jo, filenum);
        if lng <> '' then
          c.setval('TAG:language', lng);
      end;
      if bp and (frmGUIta.chkLangA1.Checked
      or (frmGUIta.chkLangA2.Checked and (lng <> '')
      and (Pos(LowerCase(lng) + ' ', LowerCase(frmGUIta.cmbLangA.Text) + ' ') > 0))) then
      begin
        ia := k;
        c.setval('Checked', '1');
        bj := True;
      end;
      if bp and (ia2 < 0) then
        ia2 := k;
      c.setval(frmGUIta.edtBitrateA.Name, frmGUIta.myCalcBRa(c));
      //title
      if frmGUIta.chkMetadataGet.Checked then
      begin
        v := c.getval('TAG:title');
        c.setval(frmGUIta.cmbTagTitleA.Name, v);
        v := c.getval('TAG:language');
        c.setval(frmGUIta.cmbTagLangA.Name, v);
      end;
    end
    else
    if (styp = 'subtitle') then
    begin
      lng := c.getval('TAG:language');
      if (lng = '') and (filenum > 0) then
      begin
        lng := frmGUIta.myGetLngFromFNs(jo, filenum);
        if lng <> '' then
          c.setval('TAG:language', lng);
      end;
      if bp and (frmGUIta.chkLangS1.Checked
      or (frmGUIta.chkLangS2.Checked and (lng <> '')
      and (Pos(LowerCase(lng) + ' ', LowerCase(frmGUIta.cmbLangS.Text) + ' ') > 0))) then
      begin
        c.setval('Checked', '1');
        bj := True;
      end;
      //title
      if frmGUIta.chkMetadataGet.Checked then
      begin
        v := c.getval('TAG:title');
        c.setval(frmGUIta.cmbTagTitleS.Name, v);
        v := c.getval('TAG:language');
        c.setval(frmGUIta.cmbTagLangS.Name, v);
      end;
    end;
  until (s = '');
  Ini.Free;
  //if audio track does not checked, check first audio track
  if (ia < 0) and (ia2 >= 0) then
  begin
    jo.f[filenum].s[ia2].setval('Checked', '1');
    bj := True;
  end;
  frmGUIta.myGetss4Compare(jo);
  s := myDTtoStr(sMyDTformat, Now) + ' ' + mes[5] + ' ' + TimeToStr(Now - dt);
  if fExitStatus <> 0 then
    s := s + ' - ' + mes[6] + ': ' + IntToStr(fExitStatus);
  frmGUIta.StatusBar1.SimpleText := s;
  if frmGUIta.chkDebug.Checked or (fExitStatus <> 0) then
    frmGUIta.memJournal.Lines.Add(s);
  //add to listview or update listview item
  v := '';
  a := '';
  s := '';
  if (filenum = 0) then
  begin
    if frmGUIta.chkMetadataGet.Checked then
      s := jo.f[0].getval('TAG:title')
    else
      s := '';
    jo.setval(frmGUIta.cmbTagTitleOut.Name, s);
    li := frmGUIta.LVjobs.Items.Add;
    li.Checked := bj;
    jo.setval('index', IntToStr(li.Index));
    li.Caption := IntToStr(li.Index + 1);
    li.SubItems.Add(mes[33]);
    li.SubItems.Add(filenamew);
    li.SubItems.Add(myGetFileSize(filename));
    li.SubItems.Add(frmGUIta.myCalcOutSize(jo));
    r := myTimeStrToReal(jo.f[0].getval('duration'));
    if r = 0 then
      s := jo.f[0].getval('duration')
    else
      s := myRealToTimeStr(r);
    li.SubItems.Add(s);
    DuraAll := DuraAll + r;
    inc(DuraAl2);
    frmGUIta.myShowCaption('');
    frmGUIta.myGetCaptions(jo, v, a, s);
    li.SubItems.Add(v);
    li.SubItems.Add(a);
    li.Data := Pointer(jo);
    if (frmGUIta.LVjobs.Items.Count = 1) then
      frmGUIta.LVjobs.Items[0].Selected := True;
  end
  else
  begin
    i := StrToIntDef(jo.getval('index'), 0);
    li := frmGUIta.LVjobs.Items[i];
    frmGUIta.myGetCaptions(jo, v, a, s);
    li.SubItems[5] := v;
    li.SubItems[6] := a;
    li.Data := Pointer(jo);
    if li.Selected then
      frmGUIta.LVjobsSelectItem(nil, li, True);
  end;
end;

procedure TThreadAddF.ShowJournal;
begin
  frmGUIta.memJournal.Lines.Add(fStatus);
end;

procedure TThreadAddF.ShowStatus1;
begin
  frmGUIta.StatusBar1.SimpleText := fStatus;
end;

procedure TThreadAddF.ShowSynMemo;
begin
  frmGUIta.SynMemo6.Lines.Add(fStatus);
end;

procedure TThreadAddF.Execute;
var
  Buffer, s, t: string;
  BytesAvailable: DWord;
  BytesRead: longint;
  i, j: integer;
begin
  //scp := GetConsoleTextEncoding;
  while (not Terminated) and (fExitStatus = 0) do
  begin
    Synchronize(@DataGet);
    if fcmd = '' then
      Exit;
    while (not Terminated) and (fcmd > '') and (fExitStatus = 0) do
    begin
      fExitStatus := -1;
      fStatus := fcmd + ' ' + StringReplace(fpar.Text, LineEnding, ' ', [rfReplaceAll]);
      Synchronize(@ShowJournal);
      Synchronize(@ShowStatus1);
      Synchronize(@ShowSynMemo);
      pr := TProcessUTF8.Create(nil);
      try
        //pr.CurrentDirectory := fdir;
        pr.Executable := fcmd;
        pr.Parameters.AddStrings(fpar);
        pr.Options := [poUsePipes, poStderrToOutPut];
        pr.ShowWindow := swoHIDE;
        pr.Execute;
        fcmd := '';
        t := '';
        repeat
          Sleep(2);
          BytesAvailable := pr.Output.NumBytesAvailable;
          BytesRead := 0;
          while BytesAvailable > 0 do
          begin
            SetLength(Buffer, BytesAvailable);
            BytesRead := pr.OutPut.Read(Buffer[1], BytesAvailable);
            s := copy(Buffer, 1, BytesRead);
            //if fOEM then
            //  s := ConvertEncoding(s, scp, EncodingUTF8);
            t := t + s;
            repeat
              i := Pos(#13, t);
              j := Pos(#10, t);
              if (i > 0) and (j <> i + 1) then //carrier return, no line feed
              begin
                if (j > i + 1) then j := i;
                fStatus := Copy(t, 1, i - 1);
                Delete(t, 1, Max(i, j));
                Synchronize(@ShowStatus1);
              end else
              if ((i > 0) and (j = i + 1))  //crlf
              or ((i = 0) and (j > 0))      //lf
              or ((i > j) and (j > 0)) then //lf, cr
              begin
                if (i = 0) or (i > j) then i := j;
                fStatus := Copy(t, 1, Min(i, j) - 1);
                Delete(t, 1, Max(i, j));
                //Synchronize(@ShowStatus1);
                Synchronize(@ShowSynMemo);
              end;
            until i = 0;
            BytesAvailable := pr.Output.NumBytesAvailable;
          end;
        until Terminated or not pr.Running;
        if (t <> '') then
        begin
          fStatus := t;
          Synchronize(@ShowSynMemo);
        end;
        fExitStatus := pr.ExitStatus;
      finally
        pr.Free;
      end;
    end;
    Synchronize(@DataOut);
    if not fStopIfError and (fExitStatus <> 0) then
      fExitStatus := 0;
  end;
end;

constructor TThreadAddF.Create(CreateSuspended: boolean);
begin
  FreeOnTerminate := True;
  fcmd := '';
  fpar := TStringList.Create;
  fExitStatus := 0;
  inherited Create(CreateSuspended);
end;

end.
