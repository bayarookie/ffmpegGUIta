unit ufrmsplash;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls;

type

  { TfrmSplash }

  TfrmSplash = class(TForm)
    btnCancel: TButton;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    procedure btnCancelClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    bCancel: boolean;
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.lfm}

{ TfrmSplash }

procedure TfrmSplash.btnCancelClick(Sender: TObject);
begin
  bCancel := True;
end;

end.

