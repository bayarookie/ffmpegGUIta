program ffmpegGUIta;

{$mode objfpc}{$H+}

uses
  {$DEFINE UseCThreads}
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazcontrols, ufrmGUIta, ufrmtrack, urun, utreds;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmGUIta, frmGUIta);
  Application.Run;
end.

