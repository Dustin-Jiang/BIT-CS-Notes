unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, ExtCtrls, Mask, IdHashMessageDigest;

type
  TUserManageForm = class(TForm)
    ADODatabaseConnection: TADOConnection;
    UsersListBox: TListBox;
    Label1: TLabel;
    UserInfoGroupBox: TGroupBox;
    Label2: TLabel;
    NameDisplay: TEdit;
    Label3: TLabel;
    IdDisplay: TEdit;
    Label4: TLabel;
    PhoneNumDisplay: TEdit;
    UserPermissionRadioGroup: TRadioGroup;
    EditUserButton: TButton;
    DeleteUserButton: TButton;
    WorkerInfoGroupBox: TGroupBox;
    WorkerCampusComboBox: TComboBox;
    Label5: TLabel;
    ADOUsersQuery: TADOQuery;
    ADOCampusQuery: TADOQuery;
    NewPasswordEdit: TEdit;
    Label6: TLabel;
    ADOUserDetailQuery: TADOQuery;
    ADOPermissionQuery: TADOQuery;
    ADOEditQuery: TADOQuery;

    procedure HandleShow(Sender: TObject);
    procedure HandleUserSelect(Sender: TObject);

    procedure HandleDeleteUser();
    procedure HandleClearSelection();
    procedure HandleEditUser();
    procedure HandlePermissionChange();

    procedure LoadUsers();
    procedure LoadCampus();
    procedure LoadUserDetail();
    procedure DeleteUserButtonClick(Sender: TObject);
    procedure EditUserButtonClick(Sender: TObject);
    procedure UserPermissionRadioGroupClick(Sender: TObject);
  private
    SelectedUserId: Integer;
    SelectedUserPermission: Integer;
  public
    { Public declarations }
  end;

var
  UserManageForm: TUserManageForm;

implementation

{$R *.dfm}

function Md5(s: string): string;
var
  MyMD5: TIdHashMessageDigest5;
begin
  Result := '';
  MyMD5 := TIdHashMessageDigest5.Create;
  try
    Result := MyMD5.AsHex(MyMD5.HashValue(s));
  finally
    MyMD5.Free;
  end;
end;

procedure TUserManageForm.HandleShow(Sender: TObject);
begin
  LoadUsers();
  LoadCampus();
end;

procedure TUserManageForm.LoadUsers();
begin
  ADOUsersQuery.Active := False;
  ADOUsersQuery.SQL.Text := 'SELECT id, name, school_id FROM clinic_user';
  ADOUsersQuery.Active := True;

  ADOUsersQuery.First;
  UsersListBox.Items.Clear;
  while not ADOUsersQuery.Eof do
  begin
    UsersListBox.Items.Add(Format('%s - %s', [
      ADOUsersQuery.FieldByName('name').AsString,
      ADOUsersQuery.FieldByName('school_id').AsString
    ]));
    ADOUsersQuery.Next;
  end;
end;

procedure TUserManageForm.LoadCampus();
begin
  ADOCampusQuery.Active := False;
  ADOCampusQuery.SQL.Text := 'SELECT id, name FROM campus';
  ADOCampusQuery.Active := True;

  ADOCampusQuery.First;
  while not ADOCampusQuery.Eof do
  begin
    WorkerCampusComboBox.Items.Add(ADOCampusQuery.FieldByName('name').AsString);
    ADOCampusQuery.Next;
  end;

  if WorkerCampusComboBox.Items.Count > 0 then
    WorkerCampusComboBox.Enabled := True
  else
    WorkerCampusComboBox.Enabled := False;
end;

procedure TUserManageForm.HandleUserSelect(Sender: TObject);
var
  i: Integer;
begin
  ADOUsersQuery.First;
  i := 0;
  SelectedUserId := -1;

  while not ADOUsersQuery.Eof do
  begin
    if UsersListBox.ItemIndex = i then
    begin
      SelectedUserId := ADOUsersQuery.FieldByName('id').AsInteger;
      break;
    end;
    Inc(i);
    ADOUsersQuery.Next;
  end;

  if SelectedUserId <> -1 then
  begin
    LoadUserDetail();
  end;
end;

procedure TUserManageForm.LoadUserDetail();
begin
  ADOUserDetailQuery.Active := False;
  ADOUserDetailQuery.SQL.Text := Format('SELECT * FROM clinic_user WHERE id = %d', [SelectedUserId]);
  ADOUserDetailQuery.Active := True;

  if ADOUserDetailQuery.IsEmpty then
  begin
    ShowMessage('读取用户信息错误');
    exit;
  end;

  NameDisplay.Text := ADOUserDetailQuery.FieldByName('name').AsString;
  IdDisplay.Text := ADOUserDetailQuery.FieldByName('school_id').AsString;
  PhoneNumDisplay.Text := ADOUserDetailQuery.FieldByName('phone_number').AsString;

  UserPermissionRadioGroup.Enabled := True;
  EditUserButton.Enabled := True;
  DeleteUserButton.Enabled := True;
  
  ADOPermissionQuery.Active := False;
  ADOPermissionQuery.SQL.Text := Format('SELECT * FROM worker_view WHERE id = %d', [SelectedUserId]);
  ADOPermissionQuery.Active := True;

  if ADOPermissionQuery.IsEmpty then
  begin
    UserPermissionRadioGroup.ItemIndex := 0;
    SelectedUserPermission := 0;
    WorkerInfoGroupBox.Visible := False;
    exit;
  end;

  WorkerInfoGroupBox.Visible := True;
  WorkerCampusComboBox.Text := ADOPermissionQuery.FieldByName('campus').AsString;

  ADOPermissionQuery.Active := False;
  ADOPermissionQuery.SQL.Text := Format('SELECT id FROM admin WHERE id = %d', [SelectedUserId]);
  ADOPermissionQuery.Active := True;
  if ADOPermissionQuery.IsEmpty then
  begin
    UserPermissionRadioGroup.ItemIndex := 1;
    SelectedUserPermission := 1;
    exit;
  end;

  UserPermissionRadioGroup.ItemIndex := 2;
  SelectedUserPermission := 2;
end;

procedure TUserManageForm.DeleteUserButtonClick(Sender: TObject);
begin
  if MessageDlg('确认删除用户吗? 和用户关联的所有信息都将被删除', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    HandleDeleteUser();
  end;
end;

procedure TUserManageForm.HandleDeleteUser();
begin
  ADOEditQuery.Active := False;
  ADOEditQuery.SQL.Text := Format('DELETE FROM clinic_user WHERE id = %d', [SelectedUserId]);
  ADOEditQuery.ExecSQL;

  LoadUsers();
  HandleClearSelection();
end;

procedure TUserManageForm.HandleClearSelection();
begin
  UsersListBox.ItemIndex := -1;
  SelectedUserId := -1;

  NameDisplay.Text := '';
  IdDisplay.Text := '';
  PhoneNumDisplay.Text := '';

  UserPermissionRadioGroup.ItemIndex := -1;
  UserPermissionRadioGroup.Enabled := False;
  EditUserButton.Enabled := False;
  DeleteUserButton.Enabled := False;

  WorkerInfoGroupBox.Visible := False;
  WorkerCampusComboBox.Text := '';
  WorkerCampusComboBox.Enabled := False;
end;

procedure TUserManageForm.EditUserButtonClick(Sender: TObject);
begin
  if SelectedUserId <> -1 then
    HandleEditUser();
end;

procedure TUserManageForm.HandleEditUser();
var
  CampusId: Integer;
  NowId: Integer;
begin
  if (NameDisplay.Text = '') or (IdDisplay.Text = '') then
  begin
    ShowMessage('请填写完整的用户信息');
    exit;
  end;

  ADOEditQuery.Active := False;
  ADOEditQuery.SQL.Text := Format('UPDATE clinic_user SET name = ''%s'', school_id = ''%s'', phone_number = ''%s'' WHERE id = %d',
    [NameDisplay.Text, IdDisplay.Text, PhoneNumDisplay.Text, SelectedUserId]);
  ADOEditQuery.ExecSQL;

  if NewPasswordEdit.Text <> '' then
  begin
    ADOEditQuery.Active := False;
    ADOEditQuery.SQL.Text := Format('UPDATE clinic_user SET password = LOWER(''%s'') WHERE id = %d',
      [Md5(NewPasswordEdit.Text), SelectedUserId]);
    ADOEditQuery.ExecSQL;
  end;
  if UserPermissionRadioGroup.ItemIndex <> SelectedUserPermission then
  begin
    // 首先，根据原来的权限移除现有角色
    if (SelectedUserPermission = 2) then
    begin
      // 从管理员表中删除
      ADOEditQuery.Active := False;
      ADOEditQuery.SQL.Text := Format('DELETE FROM admin WHERE id = %d', [SelectedUserId]);
      ADOEditQuery.ExecSQL;
    end;

    if ((SelectedUserPermission = 1) or (SelectedUserPermission = 2)) and (UserPermissionRadioGroup.ItemIndex = 0) then
    begin
      // 从工作人员表中删除
      ADOEditQuery.Active := False;
      ADOEditQuery.SQL.Text := Format('DELETE FROM worker WHERE id = %d', [SelectedUserId]);
      ADOEditQuery.ExecSQL;
    end;
    
    // 然后，根据新的权限添加角色
    if UserPermissionRadioGroup.ItemIndex >= 1 then
    begin
      if SelectedUserPermission = 0 then
      begin
        // 新增工作人员
        ADOEditQuery.Active := False;
        NowId := 0;
        ADOCampusQuery.First;

        while NowId < WorkerCampusComboBox.ItemIndex do
        begin
          ADOCampusQuery.Next;
          Inc(NowId);
        end;

        CampusId := ADOCampusQuery.FieldByName('id').AsInteger;
        ADOEditQuery.SQL.Text := Format('INSERT INTO worker (id, campus) VALUES (%d, %d)', [SelectedUserId, CampusId]);
        ADOEditQuery.ExecSQL;
      end;
      
      // 如果是管理员，还需额外添加到管理员表
      if UserPermissionRadioGroup.ItemIndex = 2 then
      begin
        ADOEditQuery.Active := False;
        ADOEditQuery.SQL.Text := Format('INSERT INTO admin (id) VALUES (%d)', [SelectedUserId]);
        ADOEditQuery.ExecSQL;
      end;
    end;
  end;

  LoadUsers();
  LoadUserDetail();
end;

procedure TUserManageForm.UserPermissionRadioGroupClick(Sender: TObject);
begin
  HandlePermissionChange();
end;

procedure TUserManageForm.HandlePermissionChange();
begin
  if UserPermissionRadioGroup.ItemIndex = 0 then
  begin
    WorkerInfoGroupBox.Visible := False;
    WorkerCampusComboBox.Text := '';
  end
  else
  begin
    WorkerInfoGroupBox.Visible := True;
  end;
end;

end.
