unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ComCtrls, DB, ADODB;

type
  TNewScheduleForm = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ScheduleDatePicker: TDateTimePicker;
    StartTimeEdit: TMaskEdit;
    EndTimeEdit: TMaskEdit;
    CampusComboBox: TComboBox;
    CapacityEdit: TEdit;
    SubmitButton: TButton;
    ADODatabaseConnection: TADOConnection;
    ADOCampusQuery: TADOQuery;
    ADOEditQuery: TADOQuery;

    procedure HandleShow(Sender: TObject);
    procedure HandleInsert();

    procedure LoadCampus();
    procedure SubmitButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NewScheduleForm: TNewScheduleForm;

implementation

{$R *.dfm}

procedure TNewScheduleForm.HandleShow(Sender: TObject);
begin
  ScheduleDatePicker.DateTime := Now;
  LoadCampus();
end;

procedure TNewScheduleForm.LoadCampus();
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

procedure TNewScheduleForm.HandleInsert();
var
  CampusId: Integer;
  NowId: Integer;
begin
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
    'INSERT INTO schedule (date, start_time, end_time, campus_id, capacity) VALUES (''%s'', ''%s'', ''%s'', %d, %d)',
    [FormatDateTime('yyyy-mm-dd', ScheduleDatePicker.Date), StartTimeEdit.Text, EndTimeEdit.Text, CampusId, StrToInt(CapacityEdit.Text)]
  );
  ADOEditQuery.ExecSQL;
  
  ModalResult := mrOk;
end;

procedure TNewScheduleForm.SubmitButtonClick(Sender: TObject);
begin
  HandleInsert();
end;

end.
