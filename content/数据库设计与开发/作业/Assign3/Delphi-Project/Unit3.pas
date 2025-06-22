unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ADODB, Unit4;

type
  TAppointmentForm = class(TForm)
    ADODatabaseConnection: TADOConnection;
    ADOUserQuery: TADOQuery;
    ADOAppointmentQuery: TADOQuery;
    AppointmentDataSource: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    AppointmentGroupBox: TGroupBox;
    Label2: TLabel;
    NameDisplay: TEdit;
    Label3: TLabel;
    IdDisplay: TEdit;
    PhoneNumDisplay: TEdit;
    Label4: TLabel;
    CampusComboBox: TComboBox;
    Label5: TLabel;
    ScheduleComboBox: TComboBox;
    Label6: TLabel;
    ComputerModelEdit: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    DescriptionEdit: TMemo;
    UserInfoGroupBox: TGroupBox;
    UpdateUserInfoButton: TButton;
    ADOScheduleQuery: TADOQuery;
    ADOCampusTable: TADOTable;
    ADOCampusTableid: TIntegerField;
    ADOCampusTablename: TWideStringField;
    ADOCampusTableaddress: TWideStringField;
    Label9: TLabel;
    RejectReasonDisplay: TEdit;
    StatusDisplay: TEdit;
    Label10: TLabel;
    ADORecordDetailQuery: TADOQuery;
    UpdateAppointmentButton: TButton;
    ADOUpdateQuery: TADOQuery;
    AnnouncementGroupBox: TGroupBox;
    AnnouncementListBox: TListBox;
    AnnouncementMemo: TMemo;
    ADOAnnouncementTable: TADOTable;
    NewAppointmentButton: TButton;
    DeleteAppointmentButton: TButton;

    procedure HandleCampusComboChange();
    procedure HandleDataGridSelect();
    procedure HandleAnnouncementDisplay();
    procedure HandleDeleteAppointment();
    procedure HandleNewAppointment();

    procedure ADOCampusTableAfterOpen(DataSet: TDataSet);
    procedure DBGridSelect(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure LoadUser();
    procedure LoadCampus();
    procedure LoadRecords();
    procedure LoadAnnouncements();
    procedure LoadRecordDetails(RecordId: Integer; LineIndex: Integer);
    procedure LoadSchedule(Campus: Integer);

    procedure HandleShow(Sender: TObject);
    procedure HandleClose(Sender: TObject; var Action: TCloseAction);
    procedure CampusComboChange(Sender: TObject);
    procedure AnnouncementListBoxClick(Sender: TObject);
    procedure UpdateUserInfoButtonClick(Sender: TObject);
    procedure UpdateAppointmentButtonClick(Sender: TObject);
    procedure DeleteAppointmentButtonClick(Sender: TObject);
    procedure NewAppointmentButtonClick(Sender: TObject);
  private
    SelectedId: Integer;
  public
    UserId: Integer;
  end;

var
  AppointmentForm: TAppointmentForm;

implementation

{$R *.dfm}

function TranslateStatus(Status: Integer): string;
begin
  case Status of
    0: Result := '上单问题未解决';
    1: Result := '预约待确认';
    2: Result := '预约已确认';
    3: Result := '预约已驳回';
    4: Result := '登记待受理';
    5: Result := '正在处理';
    6: Result := '已解决问题';
    7: Result := '建议返厂'; 
    8: Result := '交给明天解决';
    9: Result := '未到诊所';
  end;
end;

procedure TAppointmentForm.HandleShow(Sender: TObject);
begin
  ADOCampusTable.Active := True;
  
  LoadUser();
  LoadRecords();
  LoadAnnouncements();
end;

procedure TAppointmentForm.HandleClose(Sender: TObject; var Action: TCloseAction);
begin
  halt;
end;

procedure TAppointmentForm.LoadUser();
begin
  ADOUserQuery.Active := False;
  ADOUserQuery.SQL.Text := Format('SELECT * FROM clinic_user WHERE id = %d', [UserId]);
  ADOUserQuery.Active := True;

  if ADOUserQuery.RecordCount = 1 then
  begin
    NameDisplay.Text := ADOUserQuery.FieldByName('name').AsString;
    IdDisplay.Text := ADOUserQuery.FieldByName('school_id').AsString;
    PhoneNumDisplay.Text := ADOUserQuery.FieldByName('phone_number').AsString;
  end;
end;

procedure TAppointmentForm.ADOCampusTableAfterOpen(DataSet: TDataSet);
begin
  LoadCampus();
end;

procedure TAppointmentForm.LoadCampus();
begin
  CampusComboBox.Items.Clear;
  ADOCampusTable.Active := True;

  // 从第一条记录开始遍历
  ADOCampusTable.First;
  while not ADOCampusTable.Eof do
  begin
    // 将校区名称添加到ComboBox
    CampusComboBox.Items.Add(ADOCampusTablename.AsString);
    ADOCampusTable.Next;
  end;

  CampusComboBox.ItemIndex := -1;
  CampusComboBox.Text := '';
end;

procedure TAppointmentForm.LoadRecords();
begin
  ADOAppointmentQuery.Active := False;
  ADOAppointmentQuery.SQL.Text := Format('SELECT id, campus, date, description FROM appointment_view WHERE user_id = %d', [UserId]);
  ADOAppointmentQuery.Active := True;

  UpdateAppointmentButton.Enabled := False;
  DeleteAppointmentButton.Enabled := False;
end;

procedure TAppointmentForm.LoadSchedule(Campus: Integer);
begin
  ScheduleComboBox.Items.Clear;
  ScheduleComboBox.Text := '';
  ScheduleComboBox.ItemIndex := -1;
  ScheduleComboBox.Enabled := False;

  ADOScheduleQuery.Active := False;
  ADOScheduleQuery.SQL.Text := Format('SELECT * FROM schedule_view WHERE campus_id = %d', [Campus]);
  ADOScheduleQuery.Active := True;

  if not ADOScheduleQuery.IsEmpty then
  begin
    ADOScheduleQuery.First;
    while not ADOScheduleQuery.Eof do
    begin
      if ADOScheduleQuery.FieldByName('capacity').AsInteger > ADOScheduleQuery.FieldByName('appointed').AsInteger then
        ScheduleComboBox.Items.Add(ADOScheduleQuery.FieldByName('date').AsString);
      ADOScheduleQuery.Next;
    end;

    ScheduleComboBox.ItemIndex := -1;
    ScheduleComboBox.Text := '';
    ScheduleComboBox.Enabled := True;
  end;
end;

procedure TAppointmentForm.LoadAnnouncements();
begin
  ADOAnnouncementTable.Active := True;
  AnnouncementListBox.Items.Clear;

  if not ADOAnnouncementTable.IsEmpty then
  begin
    ADOAnnouncementTable.First;
    while not ADOAnnouncementTable.Eof do
    begin
      AnnouncementListBox.Items.Add(ADOAnnouncementTable.FieldByName('title').AsString);
      ADOAnnouncementTable.Next;
    end;
  end;
end;

procedure TAppointmentForm.CampusComboChange(Sender: TObject);
begin
  HandleCampusComboChange();
end;

procedure TAppointmentForm.HandleCampusComboChange();
var
  CampusId: Integer;
  NowId: Integer;
begin
  NowId := 0;
  ADOcampusTable.First;

  while NowId < CampusComboBox.ItemIndex do
  begin
    ADOcampusTable.Next;
    Inc(NowId);
  end;

  CampusId := ADOcampusTable.FieldByName('id').AsInteger;
  LoadSchedule(CampusId);
end;

procedure TAppointmentForm.DBGridSelect(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  HandleDataGridSelect();
end;

procedure TAppointmentForm.HandleDataGridSelect();
var
  DataSet: TDataSet;
begin
  if (DBGrid1.DataSource <> nil) and (DBGrid1.DataSource.DataSet <> nil) and not DBGrid1.DataSource.DataSet.IsEmpty then
  begin
    DataSet := DBGrid1.DataSource.DataSet;
    
    SelectedId := DataSet.FieldByName('id').AsInteger;
    LoadRecordDetails(SelectedId, DBGrid1.DataSource.DataSet.RecNo);
  end;
end;

procedure TAppointmentForm.LoadRecordDetails(RecordId: Integer; LineIndex: Integer);
var
  RecordDetailsQuery: string;
  Description: string;
  SplitPos: Integer;
  TempStr: string;
  SelectedLineIndex: Integer;
begin
  SelectedLineIndex := LineIndex;
  RecordDetailsQuery := Format('SELECT * FROM appointment_view WHERE id = %d', [RecordId]);

  ADORecordDetailQuery.SQL.Text := RecordDetailsQuery;
  ADORecordDetailQuery.Active := True; // 使用Active属性执行查询并保持结果集

  if ADORecordDetailQuery.IsEmpty then
  begin
    exit;
  end
  else
  begin
    ComputerModelEdit.Text := ADORecordDetailQuery.FieldByName('computer_model').AsString;

    StatusDisplay.Text := TranslateStatus(ADORecordDetailQuery.FieldByName('status').AsInteger);
    RejectReasonDisplay.Text := ADORecordDetailQuery.FieldByName('reject_reason').AsString;

    Description := ADORecordDetailQuery.FieldByName('description').AsString;
    DescriptionEdit.Lines.Clear;
    while Pos('\n', Description) > 0 do
    begin
      SplitPos := Pos('\n', Description);
      TempStr := Copy(Description, 1, SplitPos - 1);
      DescriptionEdit.Lines.Add(TempStr);
      Delete(Description, 1, SplitPos + 1);
    end;
    
    if Description <> '' then
      DescriptionEdit.Lines.Add(Description);
    
    CampusComboBox.ItemIndex := CampusComboBox.Items.IndexOf(ADORecordDetailQuery.FieldByName('campus').AsString);
    if CampusComboBox.ItemIndex <> -1 then
    begin
      HandleCampusComboChange();
      ScheduleComboBox.ItemIndex := ScheduleComboBox.Items.IndexOf(ADORecordDetailQuery.FieldByName('date').AsString);
    end;

    CampusComboBox.Text := ADORecordDetailQuery.FieldByName('campus').AsString;
    ScheduleComboBox.Text := ADORecordDetailQuery.FieldByName('date').AsString;

    UpdateAppointmentButton.Enabled := True;
    DeleteAppointmentButton.Enabled := True;
  end;
end;

procedure TAppointmentForm.UpdateUserInfoButtonClick(Sender: TObject);
begin
  ADOUpdateQuery.SQL.Text := Format(
    'UPDATE clinic_user SET name = ''%s'', phone_number = ''%s'' WHERE id = %d',
    [NameDisplay.Text, PhoneNumDisplay.Text, UserId]
  );

  try
    ADOUpdateQuery.ExecSQL;
  except
    on E: Exception do
      ShowMessage('用户信息更新失败: ' + E.Message);
  end;
end;

procedure TAppointmentForm.UpdateAppointmentButtonClick(Sender: TObject);
var
  ScheduleId: Integer;
begin
  ScheduleId := -1;

  ADOScheduleQuery.First;
  while not ADOScheduleQuery.Eof do
  begin
    if ADOScheduleQuery.FieldByName('date').AsString = ScheduleComboBox.Text then
    begin
      ScheduleId := ADOScheduleQuery.FieldByName('id').AsInteger;
      Break;
    end;
    ADOScheduleQuery.Next;
  end;

  if ScheduleId = -1 then
  begin
    ShowMessage('预约时间无效!');
    exit;
  end;

  ADOUpdateQuery.SQL.Text := Format(
    'UPDATE appointment_view SET schedule_id = %d, description = ''%s'', computer_model = ''%s'' WHERE id = %d',
    [ScheduleId, DescriptionEdit.Text, ComputerModelEdit.Text, SelectedId]
  );

  try
    ADOUpdateQuery.ExecSQL;
  except
    on E: Exception do
      ShowMessage('预约信息更新失败: ' + E.Message);
  end;
end;

procedure TAppointmentForm.AnnouncementListBoxClick(Sender: TObject);
begin
  HandleAnnouncementDisplay();
end;

procedure TAppointmentForm.HandleAnnouncementDisplay();
var
  AnnouncementId: Integer;
  Content: string;
begin
  AnnouncementId := -1;
  ADOAnnouncementTable.First;
  while not ADOAnnouncementTable.Eof do
  begin
    if AnnouncementListBox.ItemIndex = ADOAnnouncementTable.RecNo - 1 then
    begin
      AnnouncementId := ADOAnnouncementTable.FieldByName('id').AsInteger;
      Break;
    end;
    ADOAnnouncementTable.Next;
  end;

  if AnnouncementId = -1 then
  begin
    ShowMessage('公告无效!');
    exit;
  end;

  AnnouncementMemo.Lines.Clear;
  Content := ADOAnnouncementTable.FieldByName('content').AsString;

  while Pos('\n', Content) > 0 do
  begin
    Content := StringReplace(Content, '\n', #13#10, [rfReplaceAll]);
  end;
  AnnouncementMemo.Lines.Add(Content);
  AnnouncementMemo.Lines.Add('');
  AnnouncementMemo.Lines.Add('发布人: ' + ADOAnnouncementTable.FieldByName('editor_name').AsString);
  AnnouncementMemo.Lines.Add('发布时间: ' + ADOAnnouncementTable.FieldByName('publish_time').AsString);
end;

procedure TAppointmentForm.DeleteAppointmentButtonClick(Sender: TObject);
begin
  if MessageDlg('确认删除预约吗?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    HandleDeleteAppointment();
  end;
end;

procedure TAppointmentForm.HandleDeleteAppointment();
begin
  ADOUpdateQuery.Active := False;
  ADOUpdateQuery.SQL.Text := Format(
    'DELETE FROM appointment WHERE id = %d',
    [SelectedId]
  );
  ADOUpdateQuery.ExecSQL;
  LoadRecords();
end;

procedure TAppointmentForm.NewAppointmentButtonClick(Sender: TObject);
begin
  HandleNewAppointment();
end;

procedure TAppointmentForm.HandleNewAppointment();
var
  ModalForm: TNewAppointmentForm;
begin
  ModalForm := TNewAppointmentForm.Create(Self);
  ModalForm.UserId := UserId;
  try
    ModalForm.ShowModal();
    LoadRecords();
  finally
    ModalForm.Free;
  end;
end;

end.
