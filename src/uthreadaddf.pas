unit uThreadAddF;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, utf8process, Process, fileutil, IniFiles,
  ComCtrls, Math, ujobinfo, ubyutils;

type

  { TThreadAddF }

  TThreadAddF = class(TThread)
  private
    dt: TDateTime;
    jo: TJob;
    filename: string;
    filenamew: string;
    filenum: integer;
    fcmd: TStringList;
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
  filenum := -1;
  fcmd.Clear;
  while Files2Add.Count > 0 do
  begin
    jo := TJob(Files2Add.Items[0]);
    for l := 0 to High(jo.f) do
    if jo.f[l].getval('ffprobe') = '0' then
    begin
      jo.f[l].setval('ffprobe', '1');
      filenamew := jo.f[l].getval('filename');
      filename := myGetAnsiFN(filenamew);
      s := LowerCase(ExtractFileExt(filename));
      if s = '.vob' then
        s := ' -show_format -show_streams -analyzeduration 100M -probesize 100M "' + filename + '"'
      else
      {$IFDEF MSWINDOWS}
      if s = '.jpg' then
        s := ' -show_format -show_streams "' + ExtractShortPathNameUTF8(filenamew) + '"'
      else
      {$ENDIF}
        s := ' -show_format -show_streams "' + filename + '"';
      fcmd.Add(frmGUIta.myStrReplace('"$ffprobe"') + s);
      filenum := l;
      Break;
    end;
    if filenum < 0 then
      Files2Add.Delete(0)
    else
      Break;
  end;
  if fcmd.Count > 0 then
  begin
    frmGUIta.SynMemo6.Clear;
    frmGUIta.StatusBar1.SimpleText := filenamew;
  end;
end;

procedure TThreadAddF.DataOut;
var
  s, v, a, lng, styp: string;
  i, j, k, iv, ia, ia2: integer;
  r: double;
  sl: TStringList;
  Ini: TIniFile;
  li: TListItem;
  bj, bp: boolean;
begin
  bj := False; //job is not checked, if no tracks
  if filenum > 0 then
  begin
    iv := 0; //need to get number of video if checked
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
  //fill output sets from ini
  Ini.ReadSection('1', sl);
  for i := 0 to sl.Count - 1 do
    jo.setval(sl[i], Ini.ReadString('1', sl[i], ''));
  s := frmGUIta.SynMemo6.Text;
  //information about the container format of the input multimedia stream
  sl.Text := myBetween(s, '[FORMAT]', '[/FORMAT]');
  for i := 0 to sl.Count - 1 do
  begin
    j := Pos('=', sl[i]);
    if j > 0 then
      jo.f[filenum].setval(Copy(sl[i], 1, j - 1), Copy(sl[i], j + 1, Length(sl[i])));
  end;
  jo.f[filenum].setval('-----', '-----=-----=-----');
  //fill input sets from ini
  Ini.ReadSection('input', sl);
  for i := 0 to sl.Count - 1 do
    jo.f[filenum].setval(sl[i], Ini.ReadString('input', sl[i], ''));
  //enumerate streams
  s := frmGUIta.SynMemo6.Text;
  repeat
    sl.Text := myBetween(s, '[STREAM]', '[/STREAM]');
    if (sl.Text = '') then
      Break;
    k := Length(jo.f[filenum].s);
    SetLength(jo.f[filenum].s, k + 1);
    SetLength(jo.m, Length(jo.m) + 1); //add for map tracks
    jo.m[High(jo.m)] := IntToStr(filenum) + ':' + IntToStr(k);
    jo.f[filenum].s[k] := TCont.Create;
    for i := 0 to sl.Count - 1 do
    begin
      j := Pos('=', sl[i]);
      if j > 0 then
        jo.f[filenum].s[k].setval(Copy(sl[i], 1, j - 1), Copy(sl[i], j + 1, Length(sl[i])));
    end;
    if (jo.f[filenum].s[k].getval('codec_name') = 'unknown') then
      Continue;
    jo.f[filenum].s[k].setval('-----', '-----=-----=-----');
    //fill stream sets from ini
    styp := jo.f[filenum].s[k].getval('codec_type');
    sl.Clear;
    Ini.ReadSection(styp, sl);
    for i := 0 to sl.Count - 1 do
      jo.f[filenum].s[k].setval(sl[i], Ini.ReadString(styp, sl[i], ''));
    //to check, or not to check, that is a question
    bp := sl.Count > 0;
    if (styp = 'video') then
    begin
      if bp and (iv < 0) then
      begin
        iv := k;
        jo.f[filenum].s[k].setval('Checked', '1');
        bj := True;
      end;
      {$IFDEF MSWINDOWS}
      if FileExistsUTF8(frmGUIta.myExpandFN(frmGUIta.edtMediaInfo.Text)) then
      begin
        i := StrToIntDef(jo.f[filenum].s[k].getval('bit_rate'), 0);
        if i = 0 then
        begin
          v := frmGUIta.myGetMediaInfo(filename, 'BitRate');
          i := StrToIntDef(v, 0);
          if i = 0 then
            v := frmGUIta.myGetMediaInfo(filename, 'BitRate_Nominal');
          jo.f[filenum].s[k].setval('bit_rate', v);
        end;
        r := frmGUIta.myValFPS([jo.f[filenum].s[k].getval('avg_frame_rate'), jo.f[filenum].s[k].getval('r_frame_rate')]);
        if r = 1000 then
        begin
          v := frmGUIta.myGetMediaInfo(filename, 'FrameRate');
          jo.f[filenum].s[k].setval('avg_frame_rate', v);
        end;
      end;
      {$ENDIF}
      jo.f[filenum].s[k].setval(frmGUIta.edtBitrateV.Name, frmGUIta.myCalcBRv(jo.f[filenum].s[k]));
      //title
      if frmGUIta.chkMetadataGet.Checked then
      begin
        v := jo.f[filenum].s[k].getval('TAG:title');
        jo.f[filenum].s[k].setval(frmGUIta.cmbTagTitleV.Name, v);
        v := jo.f[filenum].s[k].getval('TAG:language');
        jo.f[filenum].s[k].setval(frmGUIta.cmbTagLangV.Name, v);
      end;
    end
    else
    if (styp = 'audio') then
    begin
      lng := jo.f[filenum].s[k].getval('TAG:language');
      if (lng = '') and (filenum > 0) then
      begin
        lng := frmGUIta.myGetLngFromFNs(jo, filenum);
        if lng <> '' then
          jo.f[filenum].s[k].setval('TAG:language', lng);
      end;
      if bp and (frmGUIta.chkLangA1.Checked
      or (frmGUIta.chkLangA2.Checked and (lng <> '')
      and (Pos(LowerCase(lng) + ' ', LowerCase(frmGUIta.cmbLangA.Text) + ' ') > 0))) then
      begin
        ia := k;
        jo.f[filenum].s[k].setval('Checked', '1');
        bj := True;
      end;
      if bp and (ia2 < 0) then
        ia2 := k;
      jo.f[filenum].s[k].setval(frmGUIta.edtBitrateA.Name, frmGUIta.myCalcBRa(jo.f[filenum].s[k]));
      //title
      if frmGUIta.chkMetadataGet.Checked then
      begin
        v := jo.f[filenum].s[k].getval('TAG:title');
        jo.f[filenum].s[k].setval(frmGUIta.cmbTagTitleA.Name, v);
        v := jo.f[filenum].s[k].getval('TAG:language');
        jo.f[filenum].s[k].setval(frmGUIta.cmbTagLangA.Name, v);
      end;
    end
    else
    if (styp = 'subtitle') then
    begin
      lng := jo.f[filenum].s[k].getval('TAG:language');
      if (lng = '') and (filenum > 0) then
      begin
        lng := frmGUIta.myGetLngFromFNs(jo, filenum);
        if lng <> '' then
          jo.f[filenum].s[k].setval('TAG:language', lng);
      end;
      if bp and (frmGUIta.chkLangS1.Checked
      or (frmGUIta.chkLangS2.Checked and (lng <> '')
      and (Pos(LowerCase(lng) + ' ', LowerCase(frmGUIta.cmbLangS.Text) + ' ') > 0))) then
      begin
        jo.f[filenum].s[k].setval('Checked', '1');
        bj := True;
      end;
      //title
      if frmGUIta.chkMetadataGet.Checked then
      begin
        v := jo.f[filenum].s[k].getval('TAG:title');
        jo.f[filenum].s[k].setval(frmGUIta.cmbTagTitleS.Name, v);
        v := jo.f[filenum].s[k].getval('TAG:language');
        jo.f[filenum].s[k].setval(frmGUIta.cmbTagLangS.Name, v);
      end;
    end;
  until (s = '');
  Ini.Free;
  //if no audio is checked, check first audio track
  if (ia < 0) and (ia2 >= 0) then
  begin
    jo.f[filenum].s[ia2].setval('Checked', '1');
    bj := True;
  end;
  frmGUIta.myGetss4Compare(jo);
  s := myDTtoStr('yyyy-mm-dd hh:nn:ss ', Now) + mes[5] + ' ' + TimeToStr(Now - dt);
  if fExitStatus <> 0 then
    s := s + ' - ' + mes[6] + ': ' + IntToStr(fExitStatus);
  frmGUIta.StatusBar1.SimpleText := s;
  if frmGUIta.chkDebug.Checked or (fExitStatus <> 0) then
    frmGUIta.memJournal.Lines.Add(s);
  //add or update to listview
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
    li.Caption := jo.getval('index');
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
    frmGUIta.Caption := sCap + ' - ' + mes[21] + ' = ' + myRealToTimeStr(DuraAll)
      + ', ' + mes[27] + ' = ' + IntToStr(DuraAl2);
    frmGUIta.myGetCaptions(jo, v, a, s);
    li.SubItems.Add(v);
    li.SubItems.Add(a);
    li.Data := Pointer(jo);
    if (frmGUIta.LVjobs.Items.Count = 1) then
      frmGUIta.LVjobs.Items[0].Selected := True;
  end
  else
  for i := 0 to frmGUIta.LVjobs.Items.Count - 1 do
  begin
    if frmGUIta.LVjobs.Items[i].Caption = jo.getval('index') then
    begin
      frmGUIta.myGetCaptions(jo, v, a, s);
      frmGUIta.LVjobs.Items[i].SubItems[4] := v;
      frmGUIta.LVjobs.Items[i].SubItems[5] := a;
      frmGUIta.LVjobs.Items[i].Data := Pointer(jo);
      if frmGUIta.LVjobs.Items[i].Selected then
        frmGUIta.LVjobsSelectItem(nil, frmGUIta.LVjobs.Items[i], True);
      Break;
    end;
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
{
procedure TThreadAddF.Execute;
const
  READ_BYTES = 2048;
var
  MemStream: TMemoryStream;
  NumBytes, BytesRead: integer;
  sl: TStringList;
  i: integer;
  b: boolean;
begin
  b := True;
  while (not Terminated) and b do //?
  begin
    BytesRead := 0;
    sl := Nil;
    MemStream := TMemoryStream.Create;
    pr := TProcessUTF8.Create(nil);
    try
      Synchronize(@DataGet);
      if fcmd <> '' then
      begin
        fStatus := fcmd;
        Synchronize(@ShowJournal);
        Synchronize(@ShowStatus1);
        Synchronize(@ShowSynMemo);
        pr.CommandLine := fcmd;
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
        sl := TStringList.Create;
        sl.LoadFromStream(MemStream);
        for i := 0 to sl.Count - 1 do
        begin
          fStatus := sl[i];
          Synchronize(@ShowSynMemo);
        end;
        Synchronize(@DataOut);
      end
      else
        b := False;
    finally
      sl.Free;
      pr.Free;
      MemStream.Free;
    end;
  end;
end;
}
procedure TThreadAddF.Execute;
var
  scmd, Buffer, s, t: string;
  BytesAvailable: DWord;
  BytesRead: longint;
  i, j: integer;
begin
  //scp := GetConsoleTextEncoding;
  while (not Terminated) and True do
  begin
    Synchronize(@DataGet);
    if fcmd.Count = 0 then
      Exit;
    while (not Terminated) and (fcmd.Count > 0) and (fExitStatus = 0) do
    begin
      fExitStatus := -1;
      scmd := fcmd[0];
      fcmd.Delete(0);
      if scmd = '' then
      begin
        fStatus := mes[6] + ': ' + mes[11];
        Synchronize(@ShowSynMemo);
        Break;
      end;
      fStatus := scmd;
      Synchronize(@ShowJournal);
      Synchronize(@ShowStatus1);
      Synchronize(@ShowSynMemo);
      pr := TProcessUTF8.Create(nil);
      try
        //pr.CurrentDirectory := fdir;
        pr.CommandLine := scmd;
        pr.Options := [poUsePipes{$IFDEF MSWINDOWS}, poStderrToOutPut{$ENDIF}]; //without stderr - infinite run
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
                Synchronize(@ShowStatus1);
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
  end;
end;

constructor TThreadAddF.Create(CreateSuspended: boolean);
begin
  FreeOnTerminate := True;
  fcmd := TStringList.Create;
  fExitStatus := 0;
  inherited Create(CreateSuspended);
end;

end.
