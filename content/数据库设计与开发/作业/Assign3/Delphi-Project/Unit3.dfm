object AppointmentForm: TAppointmentForm
  Left = 469
  Top = 176
  Width = 546
  Height = 561
  Caption = #30005#33041#35786#25152#39044#32422#31995#32479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  OldCreateOrder = False
  OnClose = HandleClose
  OnShow = HandleShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 44
    Height = 16
    Caption = #24050#26377#39044#32422
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 24
    Width = 289
    Height = 201
    DataSource = AppointmentDataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Microsoft YaHei UI'
    TitleFont.Style = []
    OnMouseUp = DBGridSelect
  end
  object AppointmentGroupBox: TGroupBox
    Left = 304
    Top = 184
    Width = 217
    Height = 297
    Caption = #39044#32422#20449#24687
    TabOrder = 1
    object Label5: TLabel
      Left = 8
      Top = 16
      Width = 22
      Height = 16
      Caption = #26657#21306
    end
    object Label6: TLabel
      Left = 112
      Top = 16
      Width = 44
      Height = 16
      Caption = #39044#32422#26102#38388
    end
    object Label7: TLabel
      Left = 8
      Top = 56
      Width = 44
      Height = 16
      Caption = #30005#33041#22411#21495
    end
    object Label8: TLabel
      Left = 8
      Top = 176
      Width = 44
      Height = 16
      Caption = #38382#39064#25551#36848
    end
    object Label9: TLabel
      Left = 8
      Top = 96
      Width = 44
      Height = 16
      Caption = #39044#32422#29366#24577
    end
    object Label10: TLabel
      Left = 8
      Top = 136
      Width = 44
      Height = 16
      Caption = #25298#32477#29702#30001
    end
    object CampusComboBox: TComboBox
      Left = 8
      Top = 32
      Width = 97
      Height = 24
      ItemHeight = 16
      TabOrder = 0
      OnChange = CampusComboChange
    end
    object ScheduleComboBox: TComboBox
      Left = 112
      Top = 32
      Width = 97
      Height = 24
      ItemHeight = 16
      TabOrder = 1
    end
    object ComputerModelEdit: TEdit
      Left = 8
      Top = 72
      Width = 201
      Height = 24
      TabOrder = 2
    end
    object DescriptionEdit: TMemo
      Left = 8
      Top = 192
      Width = 201
      Height = 65
      TabOrder = 3
    end
    object RejectReasonDisplay: TEdit
      Left = 8
      Top = 152
      Width = 193
      Height = 24
      ReadOnly = True
      TabOrder = 4
    end
    object StatusDisplay: TEdit
      Left = 8
      Top = 112
      Width = 201
      Height = 24
      ReadOnly = True
      TabOrder = 5
    end
    object UpdateAppointmentButton: TButton
      Left = 8
      Top = 264
      Width = 75
      Height = 25
      Caption = #26356#26032
      TabOrder = 6
      OnClick = UpdateAppointmentButtonClick
    end
    object DeleteAppointmentButton: TButton
      Left = 88
      Top = 264
      Width = 75
      Height = 25
      Caption = #21024#38500
      TabOrder = 7
      OnClick = DeleteAppointmentButtonClick
    end
  end
  object UserInfoGroupBox: TGroupBox
    Left = 304
    Top = 8
    Width = 217
    Height = 169
    Caption = #20010#20154#20449#24687
    TabOrder = 2
    object Label2: TLabel
      Left = 8
      Top = 16
      Width = 22
      Height = 16
      Caption = #22995#21517
    end
    object Label3: TLabel
      Left = 8
      Top = 53
      Width = 22
      Height = 16
      Caption = #23398#21495
    end
    object Label4: TLabel
      Left = 8
      Top = 92
      Width = 44
      Height = 16
      Caption = #30005#35805#21495#30721
    end
    object PhoneNumDisplay: TEdit
      Left = 8
      Top = 108
      Width = 201
      Height = 24
      ReadOnly = True
      TabOrder = 0
      Text = 'PhoneNumDisplay'
    end
    object NameDisplay: TEdit
      Left = 8
      Top = 32
      Width = 201
      Height = 24
      TabOrder = 1
      Text = 'NameDisplay'
    end
    object IdDisplay: TEdit
      Left = 8
      Top = 68
      Width = 201
      Height = 24
      TabOrder = 2
      Text = 'IdDisplay'
    end
    object UpdateUserInfoButton: TButton
      Left = 8
      Top = 136
      Width = 75
      Height = 25
      Caption = #26356#26032
      TabOrder = 3
      OnClick = UpdateUserInfoButtonClick
    end
  end
  object AnnouncementGroupBox: TGroupBox
    Left = 8
    Top = 232
    Width = 289
    Height = 281
    Caption = #20844#21578
    TabOrder = 3
    object AnnouncementListBox: TListBox
      Left = 8
      Top = 16
      Width = 121
      Height = 257
      ItemHeight = 16
      TabOrder = 0
      OnDblClick = AnnouncementListBoxClick
    end
    object AnnouncementMemo: TMemo
      Left = 128
      Top = 16
      Width = 153
      Height = 257
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object NewAppointmentButton: TButton
    Left = 304
    Top = 488
    Width = 217
    Height = 25
    Caption = #26032#24314#39044#32422
    TabOrder = 4
    OnClick = NewAppointmentButtonClick
  end
  object ADODatabaseConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Password=Test-0penGaussServer-DustinNas;Persi' +
      'st Security Info=True;User ID=cloudb;Data Source=PostgreSQL35W;I' +
      'nitial Catalog=clinic_manage'
    LoginPrompt = False
    Left = 264
    Top = 96
  end
  object ADOUserQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 80
    Top = 96
  end
  object ADOAppointmentQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 48
    Top = 96
  end
  object AppointmentDataSource: TDataSource
    DataSet = ADOAppointmentQuery
    Left = 16
    Top = 96
  end
  object ADOScheduleQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 112
    Top = 96
  end
  object ADOCampusTable: TADOTable
    Connection = ADODatabaseConnection
    LockType = ltReadOnly
    AfterOpen = ADOCampusTableAfterOpen
    TableName = 'campus'
    Left = 144
    Top = 96
    object ADOCampusTableid: TIntegerField
      FieldName = 'id'
    end
    object ADOCampusTablename: TWideStringField
      FieldName = 'name'
      Size = 255
    end
    object ADOCampusTableaddress: TWideStringField
      FieldName = 'address'
      Size = 255
    end
  end
  object ADORecordDetailQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 176
    Top = 96
  end
  object ADOUpdateQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 208
    Top = 96
  end
  object ADOAnnouncementTable: TADOTable
    Connection = ADODatabaseConnection
    LockType = ltReadOnly
    TableName = 'announcement_view'
    Left = 256
    Top = 472
  end
end
