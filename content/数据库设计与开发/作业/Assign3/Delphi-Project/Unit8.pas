unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB;

type
  TCampusManageForm = class(TForm)
    ADODatabaseConnection: TADOConnection;
    ADOCampusQuery: TADOQuery;
    CampusListBox: TListBox;
    GroupBox1: TGroupBox;
    CampusNameEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    CampusAddressEdit: TEdit;
    UpdateCampusButton: TButton;
    DeleteCampusButton: TButton;
    NewCampusGroupBox: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    NewCampusAddressEdit: TEdit;
    SubmitNewCampusButton: TButton;
    NewCampusNameEdit: TEdit;
    ADOEditQuery: TADOQuery;

    procedure HandleShow(Sender: TObject);
    procedure HandleClearSelection();
    procedure HandleCampusSelect();
    procedure HandleUpdate();
    procedure HandleNew();
    procedure HandleDelete();
    
    procedure LoadCampus();
    procedure LoadCampusDetail();
    procedure CampusListBoxClick(Sender: TObject);
    procedure UpdateCampusButtonClick(Sender: TObject);
    procedure SubmitNewCampusButtonClick(Sender: TObject);
    procedure DeleteCampusButtonClick(Sender: TObject);
  private
    { Private declarations }
    SelectedId: Integer;
  public
    { Public declarations }
  end;

var
  CampusManageForm: TCampusManageForm;

implementation

{$R *.dfm}

procedure TCampusManageForm.HandleShow(Sender: TObject);
begin
  LoadCampus();
  HandleClearSelection();
end;

procedure TCampusManageForm.HandleClearSelection();
begin
  CampusListBox.ItemIndex := -1;
  CampusNameEdit.Text := '';
  CampusAddressEdit.Text := '';
  CampusNameEdit.Enabled := False;
  CampusAddressEdit.Enabled := False;

  NewCampusAddressEdit.Text := '';
  NewCampusNameEdit.Text := '';

  UpdateCampusButton.Enabled := False;
  DeleteCampusButton.Enabled := False;

  SelectedId := -1;
end;

procedure TCampusManageForm.LoadCampus();
begin
  ADOCampusQuery.Active := False;
  ADOCampusQuery.SQL.Text := 'SELECT * FROM campus';
  ADOCampusQuery.Active := True;

  ADOCampusQuery.First;
  CampusListBox.Items.Clear;
  while not ADOCampusQuery.Eof do
  begin
    CampusListBox.Items.Add(ADOCampusQuery.FieldByName('name').AsString);
    ADOCampusQuery.Next;
  end;
end;

procedure TCampusManageForm.CampusListBoxClick(Sender: TObject);
begin
  HandleCampusSelect();
end;

procedure TCampusManageForm.HandleCampusSelect();
var
  NowId: Integer;
begin
  NowId := 0;
  ADOCampusQuery.First;
  while NowId < CampusListBox.ItemIndex do
  begin
    ADOCampusQuery.Next;
    Inc(NowId);
  end;
  SelectedId := ADOCampusQuery.FieldByName('id').AsInteger;
  
  LoadCampusDetail();
end;

procedure TCampusManageForm.LoadCampusDetail();
begin
  CampusNameEdit.Text := ADOCampusQuery.FieldByName('name').AsString;
  CampusAddressEdit.Text := ADOCampusQuery.FieldByName('address').AsString;

  CampusNameEdit.Enabled := True;
  CampusAddressEdit.Enabled := True;

  UpdateCampusButton.Enabled := True;
  DeleteCampusButton.Enabled := True;
end;

procedure TCampusManageForm.UpdateCampusButtonClick(Sender: TObject);
begin
  HandleUpdate();
end;

procedure TCampusManageForm.HandleUpdate();
begin
  if SelectedId = -1 then
  begin
    ShowMessage('Please select a campus to update.');
    Exit;
  end;

  if (CampusNameEdit.Text = '') or (CampusAddressEdit.Text = '') then
  begin
    ShowMessage('请填写全部字段!');
    Exit;
  end;

  ADOEditQuery.Active := False;
  ADOEditQuery.SQL.Text := Format('UPDATE campus SET name = ''%s'', address = ''%s'' WHERE id = %d',
    [CampusNameEdit.Text, CampusAddressEdit.Text, SelectedId]);
  ADOEditQuery.ExecSQL;

  LoadCampus();
  LoadCampusDetail();
end;

procedure TCampusManageForm.SubmitNewCampusButtonClick(Sender: TObject);
begin
  HandleNew();
end;

procedure TCampusManageForm.DeleteCampusButtonClick(Sender: TObject);
begin
  if MessageDlg('确认删除吗? 关联的所有信息都将被删除', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    HandleDelete();
  end;
end;

procedure TCampusManageForm.HandleNew();
begin
  if (NewCampusNameEdit.Text = '') or (NewCampusAddressEdit.Text = '') then
  begin
    ShowMessage('请填写所有字段!');
    Exit;
  end;

  ADOEditQuery.Active := False;
  ADOEditQuery.SQL.Text := Format('INSERT INTO campus (name, address) VALUES (''%s'', ''%s'')',
    [NewCampusNameEdit.Text, NewCampusAddressEdit.Text]);
  ADOEditQuery.ExecSQL;

  LoadCampus();
  HandleClearSelection();
end;

procedure TCampusManageForm.HandleDelete();
begin
  if SelectedId = -1 then
  begin
    ShowMessage('Please select a campus to delete.');
    Exit;
  end;

  ADOEditQuery.Active := False;
  ADOEditQuery.SQL.Text := Format('DELETE FROM campus WHERE id = %d', [SelectedId]);
  ADOEditQuery.ExecSQL;

  LoadCampus();
  HandleClearSelection();
end;

end.
