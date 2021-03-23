unit ufrmcrop;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazFileUtils, //FileUtil,
  SynMemo,
  {$IFNDEF LCL} Windows, Messages, {$ELSE} LMessages, LclType, {$ENDIF}
  Forms, Controls,
  ExtCtrls, Buttons, StdCtrls, ComCtrls;

type

  { TfrmCrop }

  TfrmCrop = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    btnY: TPanel;
    btnX: TPanel;
    btnH: TPanel;
    btnW: TPanel;
    Panel3: TPanel;
    ScrollBox1: TScrollBox;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    SynMemo1: TSynMemo;
    UpDown1: TUpDown;
    procedure btnYMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure btnYMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure CheckBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Edit2Change(Sender: TObject);
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
  btn: TPanel;

implementation

uses ufrmguita, ubyutils, ujobinfo;

{$R *.lfm}

procedure TfrmCrop.btnYMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  bMove := True;
  x0 := x;
  y0 := y;
  btn := TPanel(Sender);
end;

procedure TfrmCrop.btnYMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  bMove := False;
  btn := nil;
end;

procedure TfrmCrop.CheckBox1Change(Sender: TObject);
begin
  Panel2.Visible := CheckBox1.Checked;
  Splitter1.Visible := CheckBox1.Checked;
end;

procedure TfrmCrop.FormCreate(Sender: TObject);
begin
  fd := 0;
end;

procedure TfrmCrop.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if bMove and (btn <> nil) then
  begin
    btn.Left := btn.Left + x - x0;
    btn.Top := btn.Top + y - y0;
    myCrop;
  end;
end;

procedure TfrmCrop.Edit2Change(Sender: TObject);
var
  s, t: string;
begin
  t := myRealToTimeStr(myTimeStrToReal(Edit2.Text));
  s := frmGUIta.myGetPic(t, Label2.Caption, Edit1.Text, SynMemo1);
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
  ob: TEdit;
  rd, r, r1: real;
  jo: TJob;
begin
  if frmGUIta.LVjobs.Selected = nil then
    Exit;
  (Sender as TUpDown).Visible := False;
  AllowChange := False;
  ob := Edit2;
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

procedure TfrmCrop.HandleMessages(var Msg: tMsg; var Handled: boolean);
var
  c: TWinControl;
begin
  if (Msg.Message = LM_KEYDOWN) and (Msg.wParam in
    [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT]) then
  begin
    c := ActiveControl;
    if (c is TBitBtn) and ((c.Name = btnY.Name) or (c.Name = btnX.Name) or
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
begin
  btnW.Caption := IntToStr(btnW.Left + btnW.Width - btnX.Left);
  btnH.Caption := IntToStr(btnH.Top + btnH.Height - btnY.Top);
  btnX.Caption := IntToStr(btnX.Left);
  btnY.Caption := IntToStr(btnY.Top);
  Caption := btnW.Caption + ':' + btnH.Caption + ':' + btnX.Caption + ':' + btnY.Caption;
end;

end.
