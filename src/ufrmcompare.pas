unit ufrmcompare;

{$mode objfpc}{$H+}

interface

uses
  Classes, LazFileUtils, //FileUtil,
  SynMemo, Forms, Graphics,
  ExtCtrls, StdCtrls, Math, IntfGraphics, LCLType, ComCtrls, Spin, fpImage;

type

  { TfrmCompare }

  TfrmCompare = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    ScrollBox1: TScrollBox;
    SpinEdit1: TSpinEdit;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    SynMemo1: TSynMemo;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure UpDown1ChangingEx(Sender: TObject; var AllowChange: boolean;
      NewValue: smallint; Direction: TUpDownDirection);
  private
    { private declarations }
    fd: real;
  public
    { public declarations }
    b: boolean;
  end;

var
  frmCompare: TfrmCompare;

implementation

uses ufrmguita, ubyutils, ujobinfo;

{$R *.lfm}

{ TfrmCompare }

procedure TfrmCompare.Button1Click(Sender: TObject);
begin
  Image1.Visible := True;
  Image2.Visible := False;
  Image3.Visible := False;
  Caption := Button1.Caption;
end;

procedure TfrmCompare.Button2Click(Sender: TObject);
begin
  Image2.Visible := True;
  Image1.Visible := False;
  Image3.Visible := False;
  Caption := Button2.Caption;
end;

procedure TfrmCompare.Button3Click(Sender: TObject);
var
  x, y, xMin, yMin: integer;
  t1, t2, t3: TLazIntfImage;
  c3: TFPColor;
  i: integer;
begin
  Image3.Visible := True;
  Image1.Visible := False;
  Image2.Visible := False;
  Caption := Button3.Caption;
  if b then
    Exit;
  Image3.Picture.Clear;
  Image3.Picture.Bitmap.SetSize(Max(Image1.Width, Image2.Width),
    Max(Image1.Height, Image2.Height));
  t1 := Image1.Picture.Bitmap.CreateIntfImage;
  t2 := Image2.Picture.Bitmap.CreateIntfImage;
  xMin := Min(Image1.Width, Image2.Width);
  yMin := Min(Image1.Height, Image2.Height);
  t3 := TLazIntfImage.Create(0, 0);
  t3.LoadFromBitmap(Image3.Picture.Bitmap.Handle, Image3.Picture.Bitmap.MaskHandle);
  try
    for y := 0 to yMin - 1 do
    begin
      for x := 0 to xMin - 1 do
      begin
        i := abs(t1.Colors[x, y].red - t2.Colors[x, y].red) * SpinEdit1.Value;
        if i > 65535 then
          i := 65535;
        c3.red := i;
        i := abs(t1.Colors[x, y].green - t2.Colors[x, y].green) * SpinEdit1.Value;
        if i > 65535 then
          i := 65535;
        c3.green := i;
        i := abs(t1.Colors[x, y].blue - t2.Colors[x, y].blue) * SpinEdit1.Value;
        if i > 65535 then
          i := 65535;
        c3.blue := i;
        t3.Colors[x, y] := c3;
      end;
    end;
    Image3.Picture.Bitmap.LoadFromIntfImage(t3);
  except
  end;
  t1.Free;
  t2.Free;
  t3.Free;
  b := True;
end;

procedure TfrmCompare.CheckBox1Change(Sender: TObject);
begin
  Panel2.Visible := CheckBox1.Checked;
  Splitter1.Visible := CheckBox1.Checked;
end;

procedure TfrmCompare.FormCreate(Sender: TObject);
begin
  fd := 0;
end;

procedure TfrmCompare.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 27 then
    Close
  else if Key = VK_NEXT then
    ScrollBox1.VertScrollBar.Position := ScrollBox1.VertScrollBar.Position + 120
  else if Key = VK_PRIOR then
    ScrollBox1.VertScrollBar.Position := ScrollBox1.VertScrollBar.Position - 120;
end;

procedure TfrmCompare.LabeledEdit1Change(Sender: TObject);
var
  s: string;
begin
  b := False;
  if Sender = LabeledEdit1 then
    s := LabeledEdit3.Text
  else
    s := LabeledEdit4.Text;
  s := frmGUIta.myGetPic(TLabeledEdit(Sender).Text,
    TLabeledEdit(Sender).EditLabel.Caption, s, SynMemo1, StatusBar1);
  if FileExistsUTF8(s) then
  begin
    if Sender = LabeledEdit1 then
      Image1.Picture.LoadFromFile(s)
    else
      Image2.Picture.LoadFromFile(s);
    DeleteFileUTF8(s);
  end
  else
  begin
    if Sender = LabeledEdit1 then
      Image1.Picture.Clear
    else
      Image2.Picture.Clear;
  end;
  if Image3.Visible then
    Button3Click(nil);
end;

procedure TfrmCompare.SpinEdit1Change(Sender: TObject);
begin
  b := False;
  if Image3.Visible then
    Button3Click(nil);
end;

procedure TfrmCompare.UpDown1ChangingEx(Sender: TObject; var AllowChange: boolean;
  NewValue: smallint; Direction: TUpDownDirection);
var
  ob: TLabeledEdit;
  rd, r, r1: real;
  jo: TJob;
begin
  if frmGUIta.LVjobs.Selected = nil then
    Exit;
  (Sender as TUpDown).Visible := False;
  AllowChange := False;
  if Sender = UpDown1 then
    ob := LabeledEdit1
  else
    ob := LabeledEdit2;
  jo := TJob(frmGUIta.LVjobs.Selected.Data);
  rd := myTimeStrToReal(jo.f[0].getval('duration'));
  r1 := myTimeStrToReal(ob.Text);
  if fd = 0 then
  begin
    fd := frmGUIta.myGetFPS(jo, '');
    fd := 1 / fd;
  end;
  if NewValue < TUpDown(Sender).Position then
    r := r1 - fd
  else
    r := r1 + fd;
  if r < 0 then
    r := 0;
  if r > rd then
    r := rd;
  ob.Text := myRealToTimeStr(r);
  (Sender as TUpDown).Visible := True;
end;

end.
