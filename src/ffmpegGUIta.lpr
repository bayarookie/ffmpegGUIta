program ffmpegGUIta;

{$mode objfpc}{$H+}

uses
  {$DEFINE UseCThreads}
  {$IFDEF UNIX}
  {$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}
  clocale,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  sysutils, Forms, ufrmGUIta;

{$R *.res}

var
  dt_start: TDateTime;

begin
  dt_start := Now;
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmGUIta, frmGUIta);
  if frmGUIta.chkDebug.Checked then
    frmGUIta.memJournal.Lines.Add('main form loaded: ' + FormatDateTime('s.zzz', Now - dt_start));
  Application.Run;
end.

