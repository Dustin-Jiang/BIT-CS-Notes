unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ADODB, DB;

type
  TNewAppointmentForm = class(TForm)
    AppointmentGroupBox: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    CampusComboBox: TComboBox;
    ScheduleComboBox: TComboBox;
    ComputerModelEdit: TEdit;
    DescriptionEdit: TMemo;
    NewAppointmentButton: TButton;
    CancelButton: TButton;
    ADODatabaseConnection: TADOConnection;
    ADOCampusTable: TADOTable;
    ADOCampusTableid: TIntegerField;
    ADOCampusTablename: TWideStringField;
    ADOCampusTableaddress: TWideStringField;
    ADOScheduleQuery: TADOQuery;
    ADOInsertQuery: TADOQuery;

    procedure LoadCampus();
    procedure LoadSchedule(Campus: Integer);

    procedure HandleCampusComboChange();
    procedure HandleNewAppointment();

    procedure HandleShow(Sender: TObject);
    procedure CampusComboChange(Sender: TObject);
    procedure NewAppointmentButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    UserId: Integer;
  end;

var
  NewAppointmentForm: TNewAppointmentForm;

implementation

{$R *.dfm}

procedure TNewAppointmentForm.HandleShow(Sender: TObject);
begin
  LoadCampus();
end;

procedure TNewAppointmentForm.LoadCampus();
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

procedure TNewAppointmentForm.LoadSchedule(Campus: Integer);
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

procedure TNewAppointmentForm.CampusComboChange(Sender: TObject);
begin
  HandleCampusComboChange();
end;

procedure TNewAppointmentForm.HandleCampusComboChange();
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

procedure TNewAppointmentForm.NewAppointmentButtonClick(Sender: TObject);
begin
  HandleNewAppointment();
end;

procedure TNewAppointmentForm.HandleNewAppointment();
var
  Description: string;
  ScheduleId: Integer;
  i: Integer;
begin
  Description := '';

  for i := 0 to DescriptionEdit.Lines.Count - 1 do
  begin
    if i = 0 then
      Description := DescriptionEdit.Lines[i]
    else
      Description := Description + '\n' + DescriptionEdit.Lines[i];
  end;

  if ((ScheduleComboBox.ItemIndex = -1) or (CampusComboBox.ItemIndex = -1)) then
  begin
    ShowMessage('请选择预约时间');
    Exit;
  end;

  ADOScheduleQuery.First;
  ScheduleId := -1;
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
    ShowMessage('预约时间错误');
    Exit;
  end;

  if Description = '' then
  begin
    ShowMessage('请输入预约描述');
    Exit;
  end;

  if ComputerModelEdit.Text = '' then
  begin
    ShowMessage('请输入电脑型号');
    Exit;
  end;

  ADOInsertQuery.SQL.Text := Format(
    'INSERT INTO appointment(user_id, description, computer_model, schedule_id) VALUES (%d, ''%s'', ''%s'', %d)',
    [UserId, Description, ComputerModelEdit.Text, ScheduleId]
  );

  ADOInsertQuery.ExecSQL;

  ModalResult := mrOk;
end;

procedure TNewAppointmentForm.CancelButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
