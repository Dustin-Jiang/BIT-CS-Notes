unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DB, ADODB, StdCtrls, Mask, IdHashMessageDigest, Unit1, Unit3;

type
  TLoginForm = class(TForm)
    LoginPageControl: TPageControl;
    LoginTabSheet: TTabSheet;
    RegisterTabSheet: TTabSheet;
    LoginIdEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    LoginButton: TButton;
    RegisterUserNameEdit: TEdit;
    RegisterButton: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LoginStatusBar: TStatusBar;
    ADODatabaseConnection: TADOConnection;
    ADOLoginQuery: TADOQuery;
    LoginPwdEdit: TEdit;
    RegisterPwdEdit1: TEdit;
    RegisterPwdEdit2: TEdit;
    LoginDataSource: TDataSource;
    UserNameEdit: TEdit;
    PhoneNumEdit: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    procedure LoginButtonClick(Sender: TObject);
    procedure HandleLogin(UserName: string; Password: string);
    procedure RegisterButtonClick(Sender: TObject);
    procedure HandleRegister(UserName: string; Password: string; Name: string; PhoneNum: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginForm: TLoginForm;

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

procedure TLoginForm.LoginButtonClick(Sender: TObject);
var
  Id: string;
  Pwd: string;
begin
  Id := LoginIdEdit.Text;
  Pwd := LoginPwdEdit.Text;

  if Length(Id) * Length(Pwd) = 0 then
  begin
    LoginStatusBar.Panels[0].Text := '请填写完整!';
    exit;
  end;
  HandleLogin(Id, Pwd);
end;

procedure TLoginForm.HandleLogin(UserName: string; Password: string);
var
  PwdMd5: string;
  Query: string;
  UserId: Integer;
begin
  PwdMd5 := Md5(Password);

  Query := Format('SELECT id FROM clinic_user WHERE school_id = ''%s''', [UserName]);
  ADOLoginQuery.SQL.Text := Query;
  ADOLoginQuery.Active := True;

  LoginStatusBar.Panels[0].Text := PwdMd5;

  if ADOLoginQuery.RecordCount = 0 then
  begin
    LoginStatusBar.Panels[0].Text := '用户不存在!';
    exit;
  end;

  ADOLoginQuery.Active := False;

  Query := Format(
    'SELECT id FROM clinic_user WHERE school_id = ''%s'' AND password_hash = LOWER(''%s'')',
    [UserName, PwdMd5]
  );

  ADOLoginQuery.SQL.Text := Query;
  ADOLoginQuery.Active := True;
  if ADOLoginQuery.RecordCount = 0 then
  begin
    LoginStatusBar.Panels[0].Text := '密码错误!';
    exit;
  end;

  UserId := ADOLoginQuery.FieldByName('id').AsInteger;

  Query := Format(
    'SELECT id FROM worker WHERE id = %d', [UserId]
  );
  ADOLoginQuery.Active := False;
  ADOLoginQuery.SQL.Text := Query;
  ADOLoginQuery.Active := True;
  if ADOLoginQuery.RecordCount = 1 then
  begin
    LoginStatusBar.Panels[0].Text := '工作人员';
    WorkerMainForm.IsAdmin := False;
    
    Query := Format(
      'SELECT id FROM admin WHERE id = %d', [UserId]
    );
    ADOLoginQuery.Active := False;
    ADOLoginQuery.SQL.Text := Query;
    ADOLoginQuery.Active := True;

    if ADOLoginQuery.RecordCount = 1 then
    begin
      LoginStatusBar.Panels[0].Text := '管理员';
      WorkerMainForm.IsAdmin := True;
    end;

    Self.Hide;
    WorkerMainForm.UserId := UserId;
    WorkerMainForm.Show;

    exit;
  end

  else
  begin
    LoginStatusBar.Panels[0].Text := '普通用户';

    Self.Hide;
    AppointmentForm.UserId := UserId;
    AppointmentForm.Show;

    exit;
  end;

end;

procedure TLoginForm.RegisterButtonClick(Sender: TObject);
var
  UserName: string;
  Password: string;
  PasswordConfirm: string;
  Name: string;
  PhoneNum: string;
begin
  UserName := RegisterUserNameEdit.Text;
  Password := RegisterPwdEdit1.Text;
  PasswordConfirm := RegisterPwdEdit2.Text;
  Name := UserNameEdit.Text;
  PhoneNum := PhoneNumEdit.Text;

  if Length(UserName) * Length(Password) * Length(PasswordConfirm) * Length(Name) * Length(PhoneNum) = 0 then
  begin
    LoginStatusBar.Panels[0].Text := '请填写完整!';
    exit;
  end;

  if CompareStr(Password, PasswordConfirm) <> 0 then
  begin
    LoginStatusBar.Panels[0].Text := '密码输入不一致!';
    exit;
  end;

  HandleRegister(UserName, Password, Name, PhoneNum);
end;

procedure TLoginForm.HandleRegister(UserName: string; Password: string; Name: string; PhoneNum: string);
var
  PwdMd5: string;
  Query: string;
begin
  PwdMd5 := Md5(Password);
  Query := Format('SELECT id FROM clinic_user WHERE school_id = ''%s''', [UserName]);
  ADOLoginQuery.SQL.Text := Query;
  ADOLoginQuery.Active := True;

  LoginStatusBar.Panels[0].Text := PwdMd5;

  if ADOLoginQuery.RecordCount <> 0 then
  begin
    LoginStatusBar.Panels[0].Text := '用户已存在!';
    exit;
  end;

  ADOLoginQuery.Active := False;

  Query := Format(
    'INSERT INTO clinic_user(school_id, name, phone_number, password_hash) VALUES (''%s'', ''%s'', ''%s'', LOWER(''%s''))',
    [UserName, Name, PhoneNum, PwdMd5]
  );

  ADOLoginQuery.SQL.Text := Query;
  LoginStatusBar.Panels[0].Text := Query;
  ADOLoginQuery.ExecSQL;

  LoginStatusBar.Panels[0].Text := '注册成功';
end;

end.
