unit ufrmgrab;

{$mode objfpc}{$H+}

interface

uses
  Forms, StdCtrls,
  Buttons;

type

  { TfrmGrab }

  TfrmGrab = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmGrab: TfrmGrab;

implementation

{$R *.lfm}

end.

