unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, Menus, Unit5, Unit6, Unit8, Unit9;

type
  TWorkerMainForm = class(TForm)
    ADOclinic_manageConnection: TADOConnection;
    DBGrid1: TDBGrid;
    AppointmentDataSource: TDataSource;
    RefreshButton: TButton;
    CampusCombo: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ADOcampusTable: TADOTable;
    ADOcampusTableid: TAutoIncField;
    ADOcampusTablename: TWideStringField;
    DebugText: TMemo;
    ScheduleCombo: TComboBox;
    ScheduleDataSet: TDataSource;
    ADOScheduleQuery: TADOQuery;
    ADOappointmentQuery: TADOQuery;
    ADORecordDetailQuery: TADOQuery;
    RecordDetailGroupBox: TGroupBox;
    RecordDetailDataSource: TDataSource;
    Label4: TLabel;
    UserNameDisplay: TEdit;
    Label5: TLabel;
    UserPhoneNumDisplay: TEdit;
    Label6: TLabel;
    ComputerModelDisplay: TEdit;
    Label7: TLabel;
    WorkerNameDisplay: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    CampusDisplay: TEdit;
    DateDisplay: TEdit;
    Label10: TLabel;
    ArriveTimeDisplay: TEdit;
    Label11: TLabel;
    DescriptionDisplay: TMemo;
    EditRecordGroupBox: TGroupBox;
    AppointmentStatusComboBox: TComboBox;
    Label12: TLabel;
    WorkerCaptionDisplay: TMemo;
    Label13: TLabel;
    RejectReasonDisplay: TEdit;
    Label14: TLabel;
    SubmitButton: TButton;
    ADORecordSubmitQuery: TADOQuery;
    DebugButton: TButton;
    ADODebugQuery: TADOQuery;
    ManagementGroupBox: TGroupBox;
    ManageUserButton: TButton;
    ManageScheduleButton: TButton;
    Button1: TButton;
    CampusManageButton: TButton;
    procedure RefreshButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CampusComboChange(Sender: TObject);
    procedure HandleCampusComboChange();
    procedure ScheduleComboChange(Sender: TObject);
    procedure HandleScheduleComboChange();
    procedure ADOcampusTableAfterOpen(DataSet: TDataSet);
    procedure UpdateSchedule(CampusId: Integer);
    procedure DBGridSelect(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure HandleDBGridSelect();
    procedure LoadRecordDetails(RecordId: Integer; LineIndex: Integer);
    procedure SubmitButtonClick(Sender: TObject);
    procedure DebugButtonClick(Sender: TObject);
    procedure HandleClose(Sender: TObject; var Action: TCloseAction);
    procedure ManageUserButtonClick(Sender: TObject);
    procedure ManageScheduleButtonClick(Sender: TObject);
    procedure CampusManageButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    SelectedLineIndex: Integer;
  public
    { Public declarations }
    UserId: Integer;
    IsAdmin: Boolean;
  end;

var
  WorkerMainForm: TWorkerMainForm;

implementation

{$R *.dfm}

procedure TWorkerMainForm.RefreshButtonClick(Sender: TObject);
begin
  HandleScheduleComboChange();
  if SelectedLineIndex <> -1 then
  begin
    DBGrid1.DataSource.DataSet.RecNo := SelectedLineIndex;
    LoadRecordDetails(
      DBGrid1.DataSource.DataSet.FieldByName('id').AsInteger,
      SelectedLineIndex
    );
  end;
end;

procedure TWorkerMainForm.FormCreate(Sender: TObject);
begin
  // 连接预约信息
  AppointmentDataSource.DataSet := ADOappointmentQuery;
  DBGrid1.DataSource := AppointmentDataSource;

  DBGrid1.Columns.Clear;
  // 设置为默认列显示模式，自动显示所有字段
  DBGrid1.Columns.State := csDefault;
  
  // 激活数据表
  ADOcampusTable.Active := True;

  // 设置时区信息
  ADODebugQuery.SQL.Text := 'SET timezone TO ''Asia/Shanghai''';
  ADODebugQuery.ExecSQL;

  AppointmentStatusComboBox.Items.Add('上单问题未解决');
  AppointmentStatusComboBox.Items.Add('预约待确认');
  AppointmentStatusComboBox.Items.Add('预约已确认');
  AppointmentStatusComboBox.Items.Add('预约已驳回');
  AppointmentStatusComboBox.Items.Add('登记待受理');
  AppointmentStatusComboBox.Items.Add('正在处理');
  AppointmentStatusComboBox.Items.Add('已解决问题');
  AppointmentStatusComboBox.Items.Add('建议返厂');
  AppointmentStatusComboBox.Items.Add('交给明天解决');
  AppointmentStatusComboBox.Items.Add('未到诊所');

  SelectedLineIndex := -1;

  ManagementGroupBox.Visible := IsAdmin;
end;

procedure TWorkerMainForm.HandleClose(Sender: TObject; var Action: TCloseAction);
begin
  halt;
end;

procedure TWorkerMainForm.ADOcampusTableAfterOpen(DataSet: TDataSet);
begin
  // 在校区表打开后的处理代码
  DebugText.Lines.Append('校区表已打开');
  
  // 清除并重新加载ComboBox的校区数据
  CampusCombo.Items.Clear;

  // 从第一条记录开始遍历
  ADOcampusTable.First;
  while not ADOcampusTable.Eof do
  begin
    // 将校区名称添加到ComboBox
    CampusCombo.Items.Add(ADOcampusTablename.AsString);
    DebugText.Lines.Append('校区: ' + ADOcampusTablename.AsString);
    ADOcampusTable.Next;
  end;
  
  // 如果有数据，默认选中第一项
  if CampusCombo.Items.Count > 0 then
  begin
    CampusCombo.ItemIndex := 0;
    HandleCampusComboChange();
  end
  else
    CampusCombo.ItemIndex := -1; // 没有可选项时设置为-1
end;

procedure TWorkerMainForm.UpdateSchedule(CampusId: Integer);
var
  ScheduleQuery: string;
begin
  DebugText.Lines.Append('校区ID: ' + IntToStr(CampusId));
  
  ScheduleQuery := Format('SELECT * FROM schedule WHERE campus_id = %d', [CampusId]);
  
  DebugText.Lines.Append('执行SQL: ' + ScheduleQuery);

  ADOScheduleQuery.SQL.Text := ScheduleQuery;
  ADOScheduleQuery.Active := True; // 使用Active属性执行查询并保持结果集
  ScheduleDataSet.DataSet := ADOScheduleQuery;
  
  ScheduleCombo.Items.Clear;
  ScheduleCombo.Text := '';
  ScheduleCombo.ItemIndex := -1;
  ScheduleCombo.Enabled := False;
  
  if not ADOScheduleQuery.IsEmpty then
  begin
    ADOScheduleQuery.First;
    while not ADOScheduleQuery.Eof do
    begin
      ScheduleCombo.Items.Add(ADOScheduleQuery.FieldByName('date').AsString);
      ADOScheduleQuery.Next;
    end;
    
    if ScheduleCombo.Items.Count > 0 then
    begin
      DebugText.Lines.Append('选择首个schedule');
      ScheduleCombo.ItemIndex := 0;
      HandleScheduleComboChange();
      ScheduleCombo.Enabled := True;
    end
    else
    begin
      DebugText.Lines.Append('没有schedule');
      ScheduleCombo.ItemIndex := -1;
      ScheduleCombo.Text := '';
    end;
  end
  else
  begin
    DebugText.Lines.Append('没有schedule');
    ScheduleCombo.ItemIndex := -1;
    ScheduleCombo.Text := '';
  end;
end;

procedure TWorkerMainForm.CampusComboChange(Sender: TObject);
begin
  HandleCampusComboChange();
end;

procedure TWorkerMainForm.HandleCampusComboChange();
var
  CampusId: Integer;
  NowId: Integer;
begin
  NowId := 0;
  ADOcampusTable.First;

  while NowId < CampusCombo.ItemIndex do
  begin
    ADOcampusTable.Next;
    Inc(NowId);
  end;

  CampusId := ADOcampusTable.FieldByName('id').AsInteger;
  UpdateSchedule(CampusId);
end;

procedure TWorkerMainForm.ScheduleComboChange(Sender: TObject);
begin
  HandleScheduleComboChange();
end;

procedure TWorkerMainForm.HandleScheduleComboChange();
var
  ScheduleId: Integer;
  NowId: Integer;
begin
  NowId := 0;
  ADOScheduleQuery.First;
  while NowId < ScheduleCombo.ItemIndex do
  begin
    ADOScheduleQuery.Next;
    Inc(NowId);
  end;
  ScheduleId := ADOScheduleQuery.FieldByName('id').AsInteger;

  DebugText.Lines.Append('选择的Schedule ID: ' + IntToStr(ScheduleId));

  ADOappointmentQuery.SQL.Text := Format('SELECT id, user_name, computer_model, description FROM appointment_view WHERE schedule_id = %d', [ScheduleId]);
  ADOappointmentQuery.Active := True;

  if ADOappointmentQuery.IsEmpty then
  begin
    DebugText.Lines.Append('没有找到相关的预约信息');
  end;
end;

procedure TWorkerMainForm.DBGridSelect(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  HandleDBGridSelect();
end;

procedure TWorkerMainForm.HandleDBGridSelect();
var
  DataSet: TDataSet;
  SelectedId: Integer;
begin
  if (DBGrid1.DataSource <> nil) and (DBGrid1.DataSource.DataSet <> nil) and not DBGrid1.DataSource.DataSet.IsEmpty then
  begin
    DataSet := DBGrid1.DataSource.DataSet;
    
    SelectedId := DataSet.FieldByName('id').AsInteger;
    DebugText.Lines.Append('选中行ID: ' + IntToStr(SelectedId));
    LoadRecordDetails(SelectedId, DBGrid1.DataSource.DataSet.RecNo);
  end
  else
  begin
    DebugText.Lines.Append('没有选中数据或数据集为空');
  end;
end;

procedure TWorkerMainForm.LoadRecordDetails(RecordId: Integer; LineIndex: Integer);
var
  RecordDetailsQuery: string;
  Description: string;
  SplitPos: Integer;
  TempStr: string;
begin
  SelectedLineIndex := LineIndex;
  DebugText.Lines.Append('选中行索引: ' + IntToStr(SelectedLineIndex));
  RecordDetailsQuery := Format('SELECT * FROM appointment_view WHERE id = %d', [RecordId]);
  DebugText.Lines.Append('执行SQL: ' + RecordDetailsQuery);

  ADORecordDetailQuery.SQL.Text := RecordDetailsQuery;
  ADORecordDetailQuery.Active := True; // 使用Active属性执行查询并保持结果集

  if ADORecordDetailQuery.IsEmpty then
  begin
    DebugText.Lines.Append('没有找到相关的记录信息');
  end
  else
  begin
    UserNameDisplay.Text := ADORecordDetailQuery.FieldByName('user_name').AsString;
    UserPhoneNumDisplay.Text := ADORecordDetailQuery.FieldByName('user_phone_number').AsString;
    ComputerModelDisplay.Text := ADORecordDetailQuery.FieldByName('computer_model').AsString;
    WorkerNameDisplay.Text := ADORecordDetailQuery.FieldByName('worker_name').AsString;
    DateDisplay.Text := ADORecordDetailQuery.FieldByName('date').AsString;
    CampusDisplay.Text := ADORecordDetailQuery.FieldByName('campus').AsString;
    ArriveTimeDisplay.Text := ADORecordDetailQuery.FieldByName('arrive_time').AsString;
    Description := ADORecordDetailQuery.FieldByName('description').AsString;
    AppointmentStatusComboBox.ItemIndex := ADORecordDetailQuery.FieldByName('status').AsInteger;
    WorkerCaptionDisplay.Text := ADORecordDetailQuery.FieldByName('worker_caption').AsString;
    RejectReasonDisplay.Text := ADORecordDetailQuery.FieldByName('reject_reason').AsString;
    
    DescriptionDisplay.Lines.Clear;
    
    while Pos('\n', Description) > 0 do
    begin
      SplitPos := Pos('\n', Description);
      TempStr := Copy(Description, 1, SplitPos - 1);
      DescriptionDisplay.Lines.Add(TempStr);
      Delete(Description, 1, SplitPos + 1);
    end;
    
    if Description <> '' then
      DescriptionDisplay.Lines.Add(Description);
  end;
end;

procedure TWorkerMainForm.SubmitButtonClick(Sender: TObject);
var
  SubmitQuery: string;
  i: Integer;
  WorkerCaption: string;
begin
  WorkerCaption := '';
  for i := 0 to WorkerCaptionDisplay.Lines.Count - 1 do
  begin
    if i = WorkerCaptionDisplay.Lines.Count - 1 then
      WorkerCaption := WorkerCaption + WorkerCaptionDisplay.Lines[i]
    else
      WorkerCaption := WorkerCaption + WorkerCaptionDisplay.Lines[i] + '\n';
  end;

  SubmitQuery := Format(
    'UPDATE appointment_view SET status = %d, reject_reason = ''%s'', worker_caption = ''%s'', worker_id = %d WHERE id = %d',
    [
      AppointmentStatusComboBox.ItemIndex,
      RejectReasonDisplay.Text, WorkerCaption,
      UserId,
      ADORecordDetailQuery.FieldByName('id').AsInteger
    ]
  );

  DebugText.Lines.Append('执行SQL: ' + SubmitQuery);
  
  ADORecordSubmitQuery.SQL.Text := SubmitQuery;
  ADORecordSubmitQuery.ExecSQL();

  DebugText.Lines.Append('提交成功');
  RefreshButtonClick(Sender);
end;

procedure TWorkerMainForm.DebugButtonClick(Sender: TObject);
begin
  DebugText.Lines.Add(inttostr(UserId));
end;

procedure TWorkerMainForm.ManageUserButtonClick(Sender: TObject);
var
  ModalForm: TUserManageForm;
begin
  ModalForm := TUserManageForm.Create(Self);
  try
    ModalForm.ShowModal();
  finally
    ModalForm.Free;
  end;
end;

procedure TWorkerMainForm.ManageScheduleButtonClick(Sender: TObject);
var
  ModalForm: TScheduleManageForm;
begin
  ModalForm := TScheduleManageForm.Create(Self);
  try
    ModalForm.ShowModal();
  finally
    ModalForm.Free;
  end;
end;

procedure TWorkerMainForm.CampusManageButtonClick(Sender: TObject);
var
  ModalForm: TCampusManageForm;
begin
  ModalForm := TCampusManageForm.Create(Self);
  try
    ADOcampusTable.Active := False;
    ModalForm.ShowModal();
    ADOcampusTable.Active := True;
  finally
    ModalForm.Free;
  end;
end;

procedure TWorkerMainForm.Button1Click(Sender: TObject);
var
  ModalForm: TAnnouncementForm;
begin
  ModalForm := TAnnouncementForm.Create(Self);
  ModalForm.UserId := UserId;
  try
    ModalForm.ShowModal();
  finally
    ModalForm.Free;
  end;
end;

end.
