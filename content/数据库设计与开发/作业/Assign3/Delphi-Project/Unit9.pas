unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, ComCtrls;

type
  TAnnouncementForm = class(TForm)
    AnnouncementListBox: TListBox;
    AnnouncementGroupBox: TGroupBox;
    Label1: TLabel;
    TitleEdit: TEdit;
    Label2: TLabel;
    ContentMemo: TMemo;
    SubmitButton: TButton;
    DeleteButton: TButton;
    NewButton: TButton;
    ADODatabaseConnection: TADOConnection;
    ADOAnnouncementQuery: TADOQuery;
    ADOEditQuery: TADOQuery;
    PriorityEdit: TEdit;
    Label3: TLabel;
    ExpireDateTimePicker: TDateTimePicker;
    Label4: TLabel;

    procedure HandleShow(Sender: TObject);
    procedure HandleSelect();
    procedure HandleUpdate();
    procedure HandleDelete();
    procedure HandleNew();
    procedure HandleInsert();

    procedure LoadAnnouncements();
    procedure LoadAnnouncement();

    procedure HandleClearSelection();
    procedure AnnouncementListBoxClick(Sender: TObject);
    procedure SubmitButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure NewButtonClick(Sender: TObject);
  private
    { Private declarations }
    SelectedId: Integer;
  public
    { Public declarations }
    UserId: Integer;
  end;

var
  AnnouncementForm: TAnnouncementForm;

implementation

{$R *.dfm}

procedure TAnnouncementForm.HandleShow(Sender: TObject);
begin
  ADOAnnouncementQuery.SQL.Text := 'SET timezone TO ''Asia/Shanghai''';
  ADOAnnouncementQuery.ExecSQL;
  LoadAnnouncements();
  HandleClearSelection();
end;

procedure TAnnouncementForm.LoadAnnouncements();
begin
  ADOAnnouncementQuery.Close;
  ADOAnnouncementQuery.SQL.Text := 'SELECT * FROM announcement_view';
  ADOAnnouncementQuery.Open;

  AnnouncementListBox.Items.Clear;
  while not ADOAnnouncementQuery.Eof do
  begin
    AnnouncementListBox.Items.Add(ADOAnnouncementQuery.FieldByName('Title').AsString);
    ADOAnnouncementQuery.Next;
  end;
end;

procedure TAnnouncementForm.HandleClearSelection();
begin
  AnnouncementListBox.ItemIndex := -1;
  TitleEdit.Text := '';
  ContentMemo.Text := '';
  SelectedId := -1;

  SubmitButton.Enabled := False;
  DeleteButton.Enabled := False;
end;

procedure TAnnouncementForm.AnnouncementListBoxClick(Sender: TObject);
begin
  HandleSelect();
end;

procedure TAnnouncementForm.HandleSelect();
var
  NowId: Integer;
begin
  if AnnouncementListBox.ItemIndex = -1 then
  begin
    HandleClearSelection();
    Exit;
  end;

  if SelectedId = -1313 then
  begin
    AnnouncementListBox.Items.Delete(AnnouncementListBox.Items.Count - 1);
    SelectedId := -1;
  end;

  NowId := 0;
  ADOAnnouncementQuery.First;
  while NowId < AnnouncementListBox.ItemIndex do
  begin
    ADOAnnouncementQuery.Next;
    Inc(NowId);
  end;

  SelectedId := ADOAnnouncementQuery.FieldByName('id').AsInteger;
  LoadAnnouncement();
end;

procedure TAnnouncementForm.LoadAnnouncement();
var
  Content: string;
begin
  if SelectedId < 0 then
    Exit;

  ADOEditQuery.Active := False;
  ADOEditQuery.SQL.Text := Format('SELECT * FROM announcement_view WHERE id = %d', [SelectedId]);
  ADOEditQuery.Active := True;

  if ADOEditQuery.IsEmpty then
  begin
    ShowMessage('Announcement not found.');
    HandleClearSelection();
    Exit;
  end;
  TitleEdit.Text := ADOEditQuery.FieldByName('title').AsString;
  Content := ADOEditQuery.FieldByName('content').AsString;
  PriorityEdit.Text := ADOEditQuery.FieldByName('priority').AsString;
  if not ADOEditQuery.FieldByName('expire_time').IsNull then
    ExpireDateTimePicker.DateTime := ADOEditQuery.FieldByName('expire_time').AsDateTime
  else
    ExpireDateTimePicker.DateTime := EncodeDate(2099, 12, 31) + EncodeTime(23, 59, 59, 0);

  SubmitButton.Enabled := True;
  DeleteButton.Enabled := True;
  TitleEdit.Enabled := True;
  ContentMemo.Enabled := True;

  ContentMemo.Lines.Clear;
  while Pos('\n', Content) > 0 do
  begin
    ContentMemo.Lines.Add(Copy(Content, 1, Pos('\n', Content) - 1));
    Delete(Content, 1, Pos('\n', Content) + 1);
  end;

  if Content <> '' then
    ContentMemo.Lines.Add(Content);
end;

procedure TAnnouncementForm.HandleUpdate();
begin
  if SelectedId = -1313 then
  begin
    HandleInsert();
    exit;
  end;

  if SelectedId < 0 then
  begin
    ShowMessage('Please select an announcement to update.');
    Exit;
  end;

  if (TitleEdit.Text = '') or (ContentMemo.Text = '') or (PriorityEdit.Text = '') then
  begin
    ShowMessage('请填写全部字段!');
    Exit;
  end;

  ADOEditQuery.Active := False;
  ADOEditQuery.SQL.Text := Format('UPDATE announcement SET title = ''%s'', content = ''%s'', priority = %d, expire_date = ''%s'', last_editor = %d WHERE id = %d',
    [TitleEdit.Text, ContentMemo.Text, StrToInt(PriorityEdit.Text), FormatDateTime('yyyy-mm-dd hh:nn:ss', ExpireDateTimePicker.DateTime), UserId, SelectedId]);
  ADOEditQuery.ExecSQL;

  LoadAnnouncements();
  HandleClearSelection();  
end;

procedure TAnnouncementForm.SubmitButtonClick(Sender: TObject);
begin
  HandleUpdate();
end;

procedure TAnnouncementForm.DeleteButtonClick(Sender: TObject);
begin
  if MessageDlg('确认删除吗? 关联的所有信息都将被删除', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    HandleDelete();
  end;
end;

procedure TAnnouncementForm.HandleDelete();
begin
  if SelectedId < 0 then
  begin
    ShowMessage('Please select an announcement to delete.');
    Exit;
  end;

  ADOEditQuery.Active := False;
  ADOEditQuery.SQL.Text := Format('DELETE FROM announcement WHERE id = %d', [SelectedId]);
  ADOEditQuery.ExecSQL;

  LoadAnnouncements();
  HandleClearSelection();
end;

procedure TAnnouncementForm.NewButtonClick(Sender: TObject);
begin
  HandleNew();
end;

procedure TAnnouncementForm.HandleNew();
begin
  SelectedId := -1313;
  TitleEdit.Text := '';
  ContentMemo.Text := '';
  PriorityEdit.Text := '';
  ExpireDateTimePicker.DateTime := EncodeDate(2099, 12, 31) + EncodeTime(23, 59, 59, 0);
  TitleEdit.Enabled := True;
  ContentMemo.Enabled := True;
  SubmitButton.Enabled := True;
  DeleteButton.Enabled := False;
  PriorityEdit.Enabled := True;
  ExpireDateTimePicker.Enabled := True;

  AnnouncementListBox.Items.Add('新公告');
  AnnouncementListBox.ItemIndex := AnnouncementListBox.Items.Count - 1;
end;

procedure TAnnouncementForm.HandleInsert();
var
  Content: string;
  i: Integer;
begin
   if (TitleEdit.Text = '') or (ContentMemo.Text = '') or (PriorityEdit.Text = '') then
  begin
    ShowMessage('请填写全部字段!');
    Exit;
  end;

  Content := '';
  for i := 0 to ContentMemo.Lines.Count - 1 do
  begin
    if i = ContentMemo.Lines.Count - 1 then
      Content := Content + ContentMemo.Lines[i]
    else
      Content := Content + ContentMemo.Lines[i] + '\n';
  end;

  ADOEditQuery.Active := False;
    ADOEditQuery.SQL.Text := Format('INSERT INTO announcement (title, content, priority, expire_time, last_editor) VALUES (''%s'', ''%s'', %d, ''%s'', %d)',
    [TitleEdit.Text, Content, StrToInt(PriorityEdit.Text), FormatDateTime('yyyy-mm-dd hh:nn:ss', ExpireDateTimePicker.DateTime), UserId]);
  ADOEditQuery.ExecSQL;

  LoadAnnouncements();
  HandleClearSelection();  
end;

end.
