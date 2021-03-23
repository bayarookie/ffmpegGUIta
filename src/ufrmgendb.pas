unit ufrmgendb;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  CheckLst, ComCtrls;

type

  { TfrmGenDB }

  TfrmGenDB = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckGroup1: TCheckGroup;
    CheckListBox1: TCheckListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
  private

  public

  end;

var
  frmGenDB: TfrmGenDB;

implementation

{$R *.lfm}

{ TfrmGenDB }

procedure TfrmGenDB.CheckBox1Change(Sender: TObject);
//var
//  i: integer;
begin
  if CheckBox1.Checked then
    CheckListBox1.CheckAll(TCheckBoxState.cbChecked)
  else
    CheckListBox1.CheckAll(TCheckBoxState.cbUnchecked);
  //for i := 0 to ListView1.Items.Count - 1 do
  //  ListView1.Items[i].Checked := CheckBox1.Checked;
end;

procedure TfrmGenDB.CheckBox2Change(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to CheckListBox1.Items.Count - 1 do
    if Pos(CheckListBox1.Items[i], 'avi matroska mp4 mp3') > 0 then
      CheckListBox1.Checked[i] := CheckBox2.Checked;
  //for i := 0 to ListView1.Items.Count - 1 do
  //  if Pos(ListView1.Items[i].Caption, 'avi matroska mp4 mp3') > 0 then
  //    ListView1.Items[i].Checked := CheckBox2.Checked;
end;

end.

