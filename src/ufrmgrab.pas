unit ufrmgrab;

{$mode objfpc}{$H+}

interface

uses
  Forms, StdCtrls,
  Buttons, Classes;

type

  { TfrmGrab }

  TfrmGrab = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    chkMixVideo: TCheckBox;
    chkMixAudio: TCheckBox;
    cmbAddOptsO: TComboBox;
    cmbFilterComplex: TComboBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    ComboBox7: TComboBox;
    ComboBox8: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblAddOptsO: TLabel;
    procedure chkMixVideoChange(Sender: TObject);
    procedure ComboBox5Select(Sender: TObject);
    procedure ComboBox7Select(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmGrab: TfrmGrab;

implementation

{$R *.lfm}

{ TfrmGrab }

procedure TfrmGrab.chkMixVideoChange(Sender: TObject);
var
  s, t: string;
begin
  s := '';
  t := '';
  if chkMixVideo.Checked then
  begin
    s := '[0][1]overlay=main_w-overlay_w-2:main_h-overlay_h-2[v]';
    t := ' -map [v]';
  end;
  if chkMixAudio.Checked then
  begin
    if s <> '' then s := s + ', ';
    s := s + '[2][3]amix=inputs=2[a]';
    t := t + ' -map [a]';
  end;
  cmbFilterComplex.Text := s;
  cmbAddOptsO.Text := '-c:a libmp3lame -ar 44100 -q:a 1 -c:v libx264 -preset ultrafast -crf 18' + t;
end;

procedure TfrmGrab.ComboBox5Select(Sender: TObject);
begin
  ComboBox6.ItemIndex := ComboBox5.ItemIndex;
end;

procedure TfrmGrab.ComboBox7Select(Sender: TObject);
begin
  ComboBox8.ItemIndex := ComboBox7.ItemIndex;
end;

end.

