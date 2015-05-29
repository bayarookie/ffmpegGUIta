unit ufrmcrop;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynMemo,
  {$IFNDEF LCL} Windows, Messages, {$ELSE} LclIntf, LMessages, LclType, {$ENDIF}
  Forms, Controls, Graphics, Dialogs,
  ExtCtrls, Buttons, StdCtrls, ComCtrls;

type

  { TfrmCrop }

  TfrmCrop = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    btnH: TBitBtn;
    btnW: TBitBtn;
    btnY: TBitBtn;
    btnX: TBitBtn;
    CheckBox1: TCheckBox;
    Image1: TImage;
    Label1: TLabel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    ScrollBox1: TScrollBox;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    SynMemo1: TSynMemo;
    UpDown1: TUpDown;
    procedure btnHMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure btnWMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure btnXMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure btnXMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure btnXMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure btnYMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure CheckBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure UpDown1ChangingEx(Sender: TObject; var AllowChange: boolean;
      NewValue: smallint; Direction: TUpDownDirection);
  private
    { private declarations }
    fd: real;
    procedure HandleMessages(var Msg: tMsg; var Handled: boolean);
  public
    { public declarations }
    procedure myCrop;
  end;

var
  frmCrop: TfrmCrop;
  bMove: boolean;
  x0, y0: integer;

implementation

uses ufrmguita, ubyutils, ujobinfo;

{$R *.lfm}

procedure TfrmCrop.btnXMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if Button <> mbLeft then
    bMove := False
  else
  begin
    bMove := True;
    x0 := x;
    y0 := y;
  end;
end;

procedure TfrmCrop.btnWMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  if bMove then
  begin
    btnW.Left := btnW.Left + x - x0;
    btnW.Top := btnW.Top + y - y0;
    myCrop;
  end;
end;

procedure TfrmCrop.btnHMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  if bMove then
  begin
    btnH.Left := btnH.Left + x - x0;
    btnH.Top := btnH.Top + y - y0;
    myCrop;
  end;
end;

procedure TfrmCrop.btnXMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  if bMove then
  begin
    btnX.Left := btnX.Left + x - x0;
    btnX.Top := btnX.Top + y - y0;
    btnW.Left := btnW.Left + x - x0;
    btnW.Top := btnW.Top + y - y0;
    myCrop;
  end;
end;

procedure TfrmCrop.btnXMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  bMove := False;
end;

procedure TfrmCrop.btnYMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  if bMove then
  begin
    btnY.Left := btnY.Left + x - x0;
    btnY.Top := btnY.Top + y - y0;
    btnH.Left := btnH.Left + x - x0;
    btnH.Top := btnH.Top + y - y0;
    myCrop;
  end;
end;

procedure TfrmCrop.CheckBox1Change(Sender: TObject);
begin
  Panel2.Visible := CheckBox1.Checked;
  Splitter1.Visible := CheckBox1.Checked;
end;

procedure TfrmCrop.FormCreate(Sender: TObject);
begin
  Label1.Caption := '';
  fd := 0;
end;

procedure TfrmCrop.LabeledEdit1Change(Sender: TObject);
var
  s: string;
begin
  s := frmGUIta.myGetPic(TLabeledEdit(Sender).Text,
    TLabeledEdit(Sender).EditLabel.Caption, LabeledEdit2.Text, SynMemo1, StatusBar1);
  if FileExistsUTF8(s) then
  begin
    Image1.Picture.LoadFromFile(s);
    DeleteFileUTF8(s);
  end
  else
    Image1.Picture.Clear;
end;

procedure TfrmCrop.UpDown1ChangingEx(Sender: TObject; var AllowChange: boolean;
  NewValue: smallint; Direction: TUpDownDirection);
var
  ob: TLabeledEdit;
  rd, r, r1: real;
  jo: TJob;
begin
  (Sender as TUpDown).Enabled := False;
  AllowChange := False;
  if frmGUIta.LVjobs.Selected = nil then
    Exit;
  ob := LabeledEdit1;
  jo := TJob(frmGUIta.LVjobs.Selected.Data);
  rd := myTimeStrToReal(jo.getval('duration'));
  r1 := myTimeStrToReal(ob.Text);
  if fd = 0 then
  begin
    fd := frmGUIta.myGetFPS(jo, frmGUIta.LVstreams.Selected.Caption);
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
  (Sender as TUpDown).Enabled := True;
end;

procedure TfrmCrop.HandleMessages(var Msg: tMsg; var Handled: boolean);
var
  c: TWinControl;
begin
  if (Msg.Message = LM_KEYDOWN) and (Msg.wParam in
    [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT]) then
  begin
    c := ActiveControl;
    if (c is TBitBtn) and ((c.Name = btnX.Name) or (c.Name = btnY.Name) or
      (c.Name = btnW.Name) or (c.Name = btnH.Name)) then
    begin
      case Msg.wParam of
        VK_UP: c.Top := c.Top - 1;
        VK_DOWN: c.Top := c.Top + 1;
        VK_LEFT: c.Left := c.Left - 1;
        VK_RIGHT: c.Left := c.Left + 1;
      end;
      Handled := True;
      myCrop;
    end;
  end;
end;

procedure TfrmCrop.myCrop;
var
  w, h: integer;
  s: string;
begin
  w := btnW.Left + btnW.Width - btnX.Left;
  h := btnH.Top + btnH.Height - btnY.Top;
  Caption := IntToStr(w) + ':' + IntToStr(h) + ':' + IntToStr(btnX.Left) +
    ':' + IntToStr(btnY.Top);
  btnW.Caption := IntToStr(w);
  btnH.Caption := IntToStr(h);
  btnX.Caption := IntToStr(btnX.Left);
  btnY.Caption := IntToStr(btnY.Top);
  if (w mod 16) <> 0 then
    s := mes[22] + ' ' + mes[24];
  if (h mod 16) <> 0 then
  begin
    if (s <> '') then
      s := s + ', ';
    s := s + mes[23] + ' ' + mes[24];
  end;
  Label1.Caption := s;
end;

end.







