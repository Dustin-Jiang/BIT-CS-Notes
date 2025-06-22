unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ComCtrls, DB, ADODB, Unit7;

type
  TScheduleManageForm = class(TForm)
    ScheduleListBox: TListBox;
    Label1: TLabel;
    ScheduleDetailGroupBox: TGroupBox;
    Label2: TLabel;
    ScheduleDatePicker: TDateTimePicker;
    StartTimeEdit: TMaskEdit;
    EndTimeEdit: TMaskEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    CampusComboBox: TComboBox;
    CapacityEdit: TEdit;
    Label6: TLabel;
    ADODatabaseConnection: TADOConnection;
    ADOScheduleQuery: TADOQuery;
    ADOScheduleDetailQuery: TADOQuery;
    ADOCampusQuery: TADOQuery;
    UpdateScheduleButton: TButton;
    DeleteScheduleButton: TButton;
    NewScheduleButton: TButton;
    ADOEditQuery: TADOQuery;

    procedure HandleShow(Sender: TObject);

    procedure HandleSelectSchedule();
    procedure HandleClearSelection();
    procedure HandleUpdate();
    procedure HandleDelete();

    procedure LoadSchedules();
    procedure LoadCampus();
    procedure LoadScheduleDetails();
    
    procedure ScheduleListBoxClick(Sender: TObject);
    procedure UpdateScheduleButtonClick(Sender: TObject);
    procedure DeleteScheduleButtonClick(Sender: TObject);
    procedure NewScheduleButtonClick(Sender: TObject);
  private
    { Private declarations }
    SelectedId: Integer;
  public
    { Public declarations }
  end;

var
  ScheduleManageForm: TScheduleManageForm;

implementation

{$R *.dfm}

procedure TScheduleManageForm.HandleShow(Sender: TObject);
begin
  LoadSchedules();
  LoadCampus();
  HandleClearSelection();
end;

procedure TScheduleManageForm.LoadSchedules();
begin
  ScheduleListBox.Items.Clear;
  ADOScheduleQuery.Active := False;
  ADOScheduleQuery.SQL.Text := 'SELECT * FROM schedule_view';
  ADOScheduleQuery.Active := True;

  while not ADOScheduleQuery.Eof do
  begin
    ScheduleListBox.Items.Add(Format(
      '%s - %s',
      [ADOScheduleQuery.FieldByName('date').AsString, ADOScheduleQuery.FieldByName('campus').AsString]
    ));
    ADOScheduleQuery.Next;
  end;
end;

procedure TScheduleManageForm.LoadCampus();
begin
  ADOCampusQuery.Active := False;
  ADOCampusQuery.SQL.Text := 'SELECT id, name FROM campus';
  ADOCampusQuery.Active := True;

  ADOCampusQuery.First;
  while not ADOCampusQuery.Eof do
  begin
    CampusComboBox.Items.Add(ADOCampusQuery.FieldByName('name').AsString);
    ADOCampusQuery.Next;
  end;

  if CampusComboBox.Items.Count > 0 then
    CampusComboBox.Enabled := True
  else
    CampusComboBox.Enabled := False;
end;

procedure TScheduleManageForm.ScheduleListBoxClick(Sender: TObject);
begin
  HandleSelectSchedule();
end;

procedure TScheduleManageForm.HandleClearSelection();
begin
  ScheduleListBox.ItemIndex := -1;
  ScheduleDatePicker.Date := Now;
  StartTimeEdit.Text := '';
  EndTimeEdit.Text := '';
  CampusComboBox.Text := '';
  CapacityEdit.Text := '';

  ScheduleDatePicker.Enabled := False;
  StartTimeEdit.Enabled := False;
  EndTimeEdit.Enabled := False;
  CampusComboBox.Enabled := False;
  CapacityEdit.Enabled := False;
  SelectedId := -1;
end;

procedure TScheduleManageForm.HandleSelectSchedule();
var
  i: Integer;
begin
  i := 0;
  SelectedId := -1;
  ADOScheduleQuery.First;
  while not ADOScheduleQuery.Eof do
  begin
    if i = ScheduleListBox.ItemIndex then
    begin
      SelectedId := ADOScheduleQuery.FieldByName('id').AsInteger;
      LoadScheduleDetails();
      Break;
    end;
    Inc(i);
    ADOScheduleQuery.Next;
  end;
end;

procedure TScheduleManageForm.LoadScheduleDetails();
begin
  if SelectedId < 0 then
    Exit;

  ADOScheduleDetailQuery.Active := False;
  ADOScheduleDetailQuery.SQL.Text := Format('SELECT * FROM schedule_view WHERE id = %d', [SelectedId]);
  ADOScheduleDetailQuery.Active := True;

  if not ADOScheduleDetailQuery.IsEmpty then
  begin
    ScheduleDatePicker.Date := ADOScheduleDetailQuery.FieldByName('date').AsDateTime;
    StartTimeEdit.Text := ADOScheduleDetailQuery.FieldByName('start_time').AsString;
    EndTimeEdit.Text := ADOScheduleDetailQuery.FieldByName('end_time').AsString;
    CampusComboBox.Text := ADOScheduleDetailQuery.FieldByName('campus').AsString;
    CapacityEdit.Text := IntToStr(ADOScheduleDetailQuery.FieldByName('capacity').AsInteger);

    ScheduleDatePicker.Enabled := True;
    StartTimeEdit.Enabled := True;
    EndTimeEdit.Enabled := True;
    CampusComboBox.Enabled := True;
    CapacityEdit.Enabled := True;
  end;
end;

procedure TScheduleManageForm.UpdateScheduleButtonClick(Sender: TObject);
begin
  HandleUpdate();
end;

procedure TScheduleManageForm.HandleUpdate();
var
  CampusId: Integer;
  NowId: Integer;
begin
  if SelectedId < 0 then
    Exit;

  NowId := 0;
  ADOCampusQuery.First;
  while NowId < CampusComboBox.ItemIndex do
  begin
    ADOCampusQuery.Next;
    Inc(NowId);
  end;
  CampusId := ADOCampusQuery.FieldByName('id').AsInteger;

  ADOEditQuery.Active := False;
  ADOEditQuery.SQL.Text := Format('SELECT id FROM schedule_view WHERE date = ''%s'' and campus_id = %d', [FormatDateTime('yyyy-mm-dd', ScheduleDatePicker.Date), CampusId]);
  ADOEditQuery.Active := True;

  if ADOEditQuery.RecordCount <> 0 then
  begin
    ShowMessage('当前选择的日期和校区已经存在值班安排!');
    Exit;
  end;
  
  ADOEditQuery.Active := False;
  ADOEditQuery.SQL.Text := Format(
    'UPDATE schedule SET date = ''%s'', start_time = ''%s'', end_time = ''%s'', campus_id = %d, capacity = %d WHERE id = %d',
    [FormatDateTime('yyyy-mm-dd', ScheduleDatePicker.Date), StartTimeEdit.Text, EndTimeEdit.Text, CampusId, StrToInt(CapacityEdit.Text), SelectedId]
  );
  ADOEditQuery.ExecSQL;

  LoadScheduleDetails();
end;

procedure TScheduleManageForm.DeleteScheduleButtonClick(Sender: TObject);
begin
  if MessageDlg('确认删除吗? 关联的所有信息都将被删除', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    HandleDelete();
  end;
end;

procedure TScheduleManageForm.HandleDelete();
begin
  if SelectedId < 0 then
    Exit;

  ADOEditQuery.Active := False;
  ADOEditQuery.SQL.Text := Format('DELETE FROM schedule WHERE id = %d', [SelectedId]);
  ADOEditQuery.ExecSQL;

  LoadSchedules();
  HandleClearSelection();
end;

procedure TScheduleManageForm.NewScheduleButtonClick(Sender: TObject);
var
  ModalForm: TNewScheduleForm;
begin
  ModalForm := TNewScheduleForm.Create(Self);
  try
    if ModalForm.ShowModal() = mrOk then
    begin
      LoadSchedules();
      HandleClearSelection();
    end;
  finally
    ModalForm.Free;
  end;
end;

end.
