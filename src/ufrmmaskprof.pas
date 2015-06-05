unit ufrmmaskprof;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type

  { TfrmMaskProf }

  TfrmMaskProf = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmMaskProf: TfrmMaskProf;

implementation

{$R *.lfm}

end.

