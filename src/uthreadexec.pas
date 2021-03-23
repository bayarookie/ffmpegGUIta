unit uthreadexec;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, utf8process, process, LConvEncoding, comctrls, LCLproc,
  Math, synmemo, dateutils, urun, ujobinfo, ubyUtils;

type

  { TThreadExec }

  TThreadExec = class(TThread)
  private
    run: TRun;
    li: TListItem;
    jo: TJob;
    filenum: integer;
    fstream: string;
    dt: TDateTime;
    fmemo: TSynMemo;
    fStatus: string;
    fExitStatus: integer;
    fmode: integer;      //modes: 0=convert, 1=test, 2=add jobs, 3=other, 4=play, 6=volumedetect
    fterm: boolean;      //run in terminal: ffmpeg -i input - | ffplay -
    fswo: TShowWindowOptions;
    fDuration: double;
    procedure DataGet;
    procedure DataOut;
    procedure ShowJournal;
    procedure ShowStatus1;
    procedure ShowSynMemo;
  protected
    procedure Execute; override;
  public
    p: TProcessUTF8;
    //constructor Create(cmd: string; mem: TSynMemo);
    //constructor Create(exe: string; a: array of string; mem: TSynMemo);
    constructor Create(term: boolean; a: TStringList; mem: TSynMemo; swo: TShowWindowOptions = swoHIDE);
    constructor Create(mode: integer; mem: TSynMemo);
  end;

implementation

uses ufrmGUIta;

{ TThreadExec }

procedure TThreadExec.DataGet;
var
  i, l: integer;
  sl: TStringList;
begin
  dt := Now;
  case fmode of
    0: begin //0=convert
      SetLength(run.p, 0);
      DuraJob := '';
      for i := 0 to frmGUIta.LVjobs.Items.Count - 1 do
      begin
        li := frmGUIta.LVjobs.Items[i];
        if li.Checked then
        begin
          li.Checked := False;
          fmemo.Clear;
          jo := TJob(li.Data);
          fterm := frmGUIta.chkxtermconv.Checked;
          frmGUIta.myGetRunFromJo(jo, run, 0, fterm);
          frmGUIta.myDirExists(ExtractFileDir(jo.getval(frmGUIta.edtOfn.Name)), 'convert');
          fDuration := frmGUIta.myGetDuration(jo);
          jo.setval(sMyCompleted, '2');
          li.ImageIndex := 2;
          li.SubItems[0] := mes[35]; //in progress
          frmGUIta.LVjobs.Refresh;
          DuraJob := li.Caption;
          frmGUIta.LVjobsItemChecked(nil, nil);
          Break;
        end;
      end;
    end;
    1: begin //1=test
      fmemo.Clear;
      li := frmGUIta.LVjobs.Selected;
      jo := TJob(li.Data);
      fterm := frmGUIta.chkxtermconv.Checked;
      frmGUIta.myGetRunFromJo(jo, run, 1, fterm);
      frmGUIta.myDirExists(ExtractFileDir(jo.getval(frmGUIta.edtOfn.Name)), 'test');
      fDuration := frmGUIta.myGetDuration(jo);
      jo.setval(sMyCompleted, '2');
      li.ImageIndex := 2;
      frmGUIta.LVjobs.Refresh;
    end;
    2: begin //2=add jobs
      SetLength(run.p, 0);
      filenum := -1;
      while Files2Add.Count > 0 do
      begin
        jo := TJob(Files2Add.Items[0]);
        for l := 0 to High(jo.f) do
        if jo.f[l].getval(sMyffprobe) <> '1' then
        begin
          fmemo.Clear;
          jo.f[l].setval(sMyffprobe, '1');
          i := run.add(frmGUIta.myExpandFN(frmGUIta.edtffprobe.Text), ['-hide_banner', '-show_format', '-show_streams', '-print_format', 'ini']);
          process.CommandToList(jo.f[l].getval(frmGUIta.cmbAddOptsI.Name), run.p[i].Parameters);
          run.p[i].Parameters.AddStrings(['-i', jo.f[l].getval(sMyInputFN)]);
          filenum := l;
          //DebuglnThreadLog(['add jobs - ', FormatDateTime(frmGUIta.cmbDateTime.Text, dt), ' ', filenum]);
          Break;
        end;
        if filenum < 0 then
          Files2Add.Delete(0)
        else
          Break;
      end;
    end;
    4: begin //4=play
      fmemo.Clear;
      li := frmGUIta.LVjobs.Selected;
      jo := TJob(li.Data);
      fterm := True;
      frmGUIta.myGetRunFromJo(jo, run, 4, fterm);
    end;
    6: begin //6=volumedetect
      fmemo.Clear;
      li := frmGUIta.LVjobs.Selected;
      jo := TJob(li.Data);
      fstream := myGetDigit2(frmGUIta.LVstreams.Selected.Caption, filenum); //return stream number
      sl := TStringList.Create;
      sl.Add(frmGUIta.myExpandFN(frmGUIta.edtffmpeg.Text)); sl.Add('-hide_banner');
      frmGUIta.myGetInputFiles(jo, frmGUIta.LVstreams.Selected.Caption, sl);
      sl.Add('-map'); sl.Add('0:' + fstream);
      sl.Add('-filter:a'); sl.Add('volumedetect');
      my2lst('-ss', jo.getval(frmGUIta.cmbDurationss2.Name), sl);
      my2lst('-t', jo.getval(frmGUIta.cmbDurationt2.Name), sl);
      sl.Add('-f'); sl.Add('null');
      sl.Add(sDevNull);
      run.add(sl);
      sl.Free;
    end;
    7: begin //7=muxers
      fmemo.Clear;
      run.add(frmGUIta.myExpandFN(frmGUIta.edtffmpeg.Text), ['-hide_banner', '-muxers']);
    end;
    8: begin //8=encoders
      fmemo.Clear;
      run.add(frmGUIta.myExpandFN(frmGUIta.edtffmpeg.Text), ['-hide_banner', '-encoders']);
    end;
  end;
end;

procedure TThreadExec.DataOut;
var
  s, t: string;
  i, j: int64;
  d, e, f: double;
begin
  case fmode of
    0: begin //0=convert
      t := jo.getval(frmGUIta.edtOfn.Name);
      if fExitStatus = 0 then
      begin
        jo.setval(sMyCompleted, '1');
        li.ImageIndex := 1;
        li.SubItems[0] := mes[34]  //completed
      end
      else
      begin
        jo.setval(sMyCompleted, '3');
        li.ImageIndex := 3;
        li.SubItems[0] := mes[36]; //error
      end;
      if li.Selected then
        frmGUIta.LVjobsSelectItem(nil, li, True);
      s := li.Caption + ': ' + FormatDateTime(frmGUIta.cmbDateTime.Text, Now)
        + ' ' + mes[5] + ' ' + TimeToStr(Now - dt);
      if fExitStatus <> 0 then
      begin
        s := s + ' - ' + mes[6] + ': ' + IntToStr(fExitStatus);
        fmemo.Lines.Add(s);
        fmemo.Lines.SaveToFile(ChangeFileExt(t, '_error.log'));
      end;
      frmGUIta.memJournal.Lines.Add(s);
      frmGUIta.StatusBar1.SimpleText := s;
      if frmGUIta.spnCpuCount.Value = 1 then
        frmGUIta.memJournal.Lines.Add(sdiv);
      fmemo.Lines.Add(sdiv);
      frmGUIta.LVjobs.Refresh;
    end;
    1: begin //1=test
      fmode := -1; //do not cycle
      if fExitStatus = 0 then
      begin
        jo.setval(sMyCompleted, '0');
        li.ImageIndex := 0;
      end
      else
      begin
        jo.setval(sMyCompleted, '3');
        li.ImageIndex := 3;
      end;
      t := jo.getval(frmGUIta.edtOfn.Name);
      s := FormatDateTime(frmGUIta.cmbDateTime.Text, Now) + ' ' + mes[5] + ' ' + FormatDateTime('n:ss.zzz', Now - dt, [fdoInterval]); //job completed for
      if fExitStatus <> 0 then
      begin
        s := s + ' - ' + mes[6] + ': ' + IntToStr(p.ExitStatus); //Error
        fmemo.Lines.Add(s);
        fmemo.Lines.SaveToFile(ChangeFileExt(t, '_error.log'));
        frmGUIta.memJournal.Lines.Add(s);
      end
      else
      begin
        i := MilliSecondsBetween(dt, Now);
        d := myTimeStrToReal(jo.f[0].getval('duration'));
        e := myTimeStrToReal(frmGUIta.cmbTestDurationt.Text);
        if (d <> 0) and (e > d) then
          e := d;
        if e <> 0 then
          f := d / e * i / 1000;
        frmGUIta.memJournal.Lines.Add(s);
        frmGUIta.memJournal.Lines.Add(mes[19] + ' ~' + myRealToTimeStr(f, False)); //Expected time of converting this file is:
        j := myGetFileSizeInt(t);
        if (j > 0) then
          f := d / e * j;
        s := '~' + Format('%12.0n', [f]);
        frmGUIta.memJournal.Lines.Add(mes[43] + ' ' + s); //Expected output file size:
        jo.setval(sMyTested, s);
        li.SubItems[3] := s;
      end;
      frmGUIta.memJournal.Lines.Add(sdiv);
      fmemo.Lines.Add(sdiv);
      frmGUIta.LVjobs.Refresh;
      if li.Selected then
        frmGUIta.LVjobsSelectItem(nil, li, True);
      if fExitStatus = 0 then
        frmGUIta.myPlayOut(jo);
    end;
    2: begin //2=add jobs
      frmGUIta.myParseIni(jo, filenum, fmemo.Text);
      s := mes[5] + ' ' + FormatDateTime('s.zzz', Now - dt);
      if fExitStatus <> 0 then s += ' - ' + mes[6] + ': ' + IntToStr(fExitStatus);
      frmGUIta.myError(fExitStatus, s);
    end;
    3, 4: begin //3=other, 4=play
      fmode := -1; //do not cycle
    end;
    6: begin //6=volumedetect
      fmode := -1; //do not cycle
      for i := 0 to fmemo.Lines.Count - 1 do
      begin
        s := fmemo.Lines[i];
        j := Pos('max_volume:', s);
        if j > 0 then //max_volume: -21.9 dB
        begin
          s := Copy(s, j + 12, Length(s) - 2 - j - 12);
          s := FloatToStr(-1 * StrToFloat(s, fsp), fsp);
          t := jo.f[filenum].s[StrToInt(fstream)].getval(frmGUIta.cmbFiltersA.Name);
          if t <> '' then t += ',';
          s := t + 'volume=' + s + 'dB';
          jo.f[filenum].s[StrToInt(fstream)].setval(frmGUIta.cmbFiltersA.Name, s);
          //if li.Selected then
          //  frmGUIta.LVjobsSelectItem(nil, li, True);
          if frmGUIta.LVstreams.Selected <> nil then
            frmGUIta.LVstreamsSelectItem(nil, frmGUIta.LVstreams.Selected, True);
        end;
      end;
    end;
    7: begin //7=muxers
      fmode := -1; //do not cycle
      for i := 0 to fmemo.Lines.Count - 1 do
      begin
        s := fmemo.Lines[i];
        if Copy(s, 1, 3) = '  E' then
        begin
          s := Trim(Copy(s, 5, 100));
          j := Pos(' ', s);
          if j > 0 then s := Copy(s, 1, j - 1);
          j := Pos(',', s);
          if j > 0 then s := Copy(s, 1, j - 1);
          frmGUIta.cmbFormat.Items.Add(s);
        end;
      end;
      frmGUIta.cmbExt.Items.Clear;
      for i := 0 to frmGUIta.cmbFormat.Items.Count - 1 do
      begin
        s := '.' + frmGUIta.cmbFormat.Items[i];
        if s = '.matroska' then s := '.mkv' else
        if s = '.bink'     then s := '.bik' else
        if s = '.image2'   then s := '-%05d.png' else
        if s = '.segment'  then s := '-%05d.mkv';
        frmGUIta.cmbExt.Items.Add(s);
      end;
    end;
    8: begin //8=encoders
      fmode := -1; //do not cycle
      frmGUIta.cmbEncoderV.Items.AddStrings(['', 'copy', 'no'], True);
      frmGUIta.cmbEncoderA.Items.AddStrings(['', 'copy', 'no'], True);
      frmGUIta.cmbEncoderS.Items.AddStrings(['', 'copy', 'no'], True);
      if frmGUIta.cmbEncoderD.Items.Count = 0 then
        frmGUIta.cmbEncoderD.Items.AddStrings(['', 'copy']);
      for i := 0 to fmemo.Lines.Count - 1 do
      begin
        s := fmemo.Lines[i];
        if Length(s) > 30 then
        case s[2] of
          'V': frmGUIta.cmbEncoderV.Items.Add(Trim(Copy(s, 9, 21)));
          'A': frmGUIta.cmbEncoderA.Items.Add(Trim(Copy(s, 9, 21)));
          'S': frmGUIta.cmbEncoderS.Items.Add(Trim(Copy(s, 9, 21)));
        end;
      end;
    end;
  end;
end;

procedure TThreadExec.ShowJournal;
begin
  frmGUIta.memJournal.Lines.Add(fStatus);
end;

procedure TThreadExec.ShowStatus1;
var
  i: integer;
  rd: double;
begin
  frmGUIta.StatusBar1.SimpleText := fStatus;
  //frame=  549 fps=101 q=-0.0 Lsize=   66489kB time=00:00:09.13 bitrate=59636.0kbits/s speed=1.68x
  i := Pos('time=', fStatus);
  if i > 0 then
  begin
    rd := myTimeStrToReal(Copy(fStatus, i + 5, 11));
    i := Round(rd / fDuration * 100);
    //frmGUIta.myError(0, 'ShowStatus1: ' + FloatToStr(rd, fsp) + ' ' + IntToStr(i) + '%');
    jo.setval('progressbar', IntToStr(i));
    if i > 0 then
      li.SubItems[0] := IntToStr(i) + '%';
    frmGUIta.LVjobs.Refresh;
  end;
end;

procedure TThreadExec.ShowSynMemo;
begin
  fmemo.Lines.Add(fStatus);
end;

procedure TThreadExec.Execute;
var
  Buffer, t: string;
  BytesAvailable: longint;
  l: integer;

  procedure mystr2mem;
  var
    i, j: integer;
    BytesRead: longint;
  begin
    SetLength(Buffer, BytesAvailable);
    BytesRead := p.OutPut.Read(Buffer[1], BytesAvailable);
    t += Copy(Buffer, 1, BytesRead);
    repeat
      i := Pos(#13, t); //cr
      j := Pos(#10, t); //lf
      if (i > 0) and ((j = 0) or (j > i + 1)) then //cr
      begin
        if (j > i + 1) then j := i;
        fStatus := TimeToStr(Now - dt) + ' ' + Copy(t, 1, i - 1);
        Synchronize(@ShowStatus1);
        Delete(t, 1, Max(i, j));
      end
      else
      if ((i > 0) and (j = i + 1))  //crlf
      or ((i = 0) and (j > 0))      //lf
      or ((i > j) and (j > 0)) then //lf, cr
      begin
        if (i = 0) or (i > j) then i := j;
        fStatus := Copy(t, 1, Min(i, j) - 1);
        Synchronize(@ShowSynMemo);
        Delete(t, 1, Max(i, j));
      end;
    until (i = 0) and (j = 0);
  end;

begin
  fExitStatus := 0;
  while not Terminated and (fExitStatus = 0) and (fmode > -1) do
  begin
    Synchronize(@DataGet);
    if Length(run.p) = 0 then Break;
    for l := 0 to High(run.p) do
    begin
      //DebuglnThreadLog(['1 - ', FormatDateTime(frmGUIta.cmbDateTime.Text, dt), ' ', l]);
      fExitStatus := -1;
      p := run.p[l];
      fStatus := FormatDateTime(frmGUIta.cmbDateTime.Text, Now) + ' ' + IntToStr(l) + ' ' + myQuotedStr(p.Executable) + myList2Str(p.Parameters);
      Synchronize(@ShowJournal);
      Synchronize(@ShowStatus1);
      Synchronize(@ShowSynMemo);
      //DebuglnThreadLog(['2 - ', fStatus]);
      if fterm then
      try
        try
          p.Execute;
          while p.Running do
            Sleep(2);
          fExitStatus := p.ExitStatus;
        except
          on e: Exception do
          begin
            if fExitStatus = 0 then fExitStatus := 1;
            fStatus := mes[6] + ': ' + e.Message; //error
            Synchronize(@ShowJournal);
            Synchronize(@ShowStatus1);
            Synchronize(@ShowSynMemo);
          end;
        end;
      finally
        p.Free;
      end
      else
      try
        try
          p.Options := [poUsePipes, poStderrToOutPut];
          p.ShowWindow := fswo;
          p.Execute;
          t := '';
          while p.Running do
          begin
            BytesAvailable := p.Output.NumBytesAvailable;
            if BytesAvailable > 0 then
              myStr2mem
            else
              Sleep(2);
          end;
          BytesAvailable := p.Output.NumBytesAvailable;
          while BytesAvailable > 0 do
          begin
            myStr2mem;
            BytesAvailable := p.Output.NumBytesAvailable;
          end;
          fExitStatus := p.ExitStatus;
        except
          on e: Exception do
          begin
            if fExitStatus = 0 then fExitStatus := 1;
            fStatus := mes[6] + ': ' + e.Message; //error
            Synchronize(@ShowJournal);
            Synchronize(@ShowStatus1);
            Synchronize(@ShowSynMemo);
          end;
        end;
      finally
        p.Free;
      end;
      //DebuglnThreadLog(['4 - ', fExitStatus, ' ', Terminated]);
      if (fExitStatus <> 0) or Terminated then Break;
    end;
    Synchronize(@DataOut);
    if not frmGUIta.chkStopIfError.Checked then fExitStatus := 0;
  end;
end;

//constructor TThreadExec.Create(cmd: string; mem: TSynMemo);
//begin
//  FreeOnTerminate := True;
//  run := TRun.Create;
//  if cmd <> '' then
//  begin
//    run.add('');
//    run.p[0].ParseCmdLine(cmd);
//  end;
//  fmemo := mem;
//  fmemo.Clear;
//  fmode := 3;
//  inherited Create(True);
//end;

//constructor TThreadExec.Create(exe: string; a: array of string; mem: TSynMemo);
//begin
//  FreeOnTerminate := True;
//  run := TRun.Create;
//  if exe <> '' then
//    run.add(exe, a);
//  fmemo := mem;
//  fmemo.Clear;
//  fmode := 3;
//  inherited Create(True);
//end;

constructor TThreadExec.Create(term: boolean; a: TStringList; mem: TSynMemo; swo: TShowWindowOptions = swoHIDE);
begin
  FreeOnTerminate := True;
  run := TRun.Create;
  if a.Count > 0 then
    frmGUIta.mylst2run(term, a, run);
  fmemo := mem;
  fmemo.Clear;
  fmode := 3; //modes: 3=other
  fterm := term;
  fswo := swo;
  inherited Create(True);
end;

constructor TThreadExec.Create(mode: integer; mem: TSynMemo);
begin                        //modes: 0=convert, 1=test, 2=add jobs, 4=play, 5=cmdline
  FreeOnTerminate := True;
  run := TRun.Create;
  fmemo := mem;
  fmode := mode;
  fterm := False;
  fswo := swoHIDE;
  inherited Create(True);
end;

end.

