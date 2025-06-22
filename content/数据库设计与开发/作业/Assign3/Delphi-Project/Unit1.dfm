object WorkerMainForm: TWorkerMainForm
  Left = 308
  Top = 161
  Width = 986
  Height = 570
  Caption = #30005#33041#35786#25152#39044#32422#31649#29702#31995#32479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  OldCreateOrder = False
  OnClose = HandleClose
  OnCreate = FormCreate
  OnShow = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 44
    Height = 16
    Caption = #35786#25152#22320#28857
  end
  object Label2: TLabel
    Left = 712
    Top = 8
    Width = 22
    Height = 16
    Caption = #35843#35797
  end
  object Label3: TLabel
    Left = 160
    Top = 8
    Width = 44
    Height = 16
    Caption = #20540#29677#26102#38388
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 56
    Width = 297
    Height = 433
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Microsoft YaHei UI'
    TitleFont.Style = []
    OnMouseUp = DBGridSelect
    Columns = <
      item
        Expanded = False
        Visible = True
      end>
  end
  object RefreshButton: TButton
    Left = 8
    Top = 496
    Width = 57
    Height = 25
    Caption = #21047#26032
    TabOrder = 1
    OnClick = RefreshButtonClick
  end
  object CampusCombo: TComboBox
    Left = 8
    Top = 24
    Width = 145
    Height = 24
    ItemHeight = 16
    TabOrder = 2
    Text = 'CampusCombo'
    OnChange = CampusComboChange
  end
  object DebugText: TMemo
    Left = 712
    Top = 24
    Width = 249
    Height = 497
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object ScheduleCombo: TComboBox
    Left = 160
    Top = 24
    Width = 145
    Height = 24
    ItemHeight = 16
    TabOrder = 4
    Text = 'ScheduleCombo'
    OnChange = ScheduleComboChange
  end
  object RecordDetailGroupBox: TGroupBox
    Left = 312
    Top = 8
    Width = 393
    Height = 249
    Caption = #39044#32422#20449#24687
    TabOrder = 5
    object Label4: TLabel
      Left = 8
      Top = 16
      Width = 44
      Height = 16
      Caption = #29992#25143#22995#21517
    end
    object Label5: TLabel
      Left = 136
      Top = 16
      Width = 44
      Height = 16
      Caption = #29992#25143#30005#35805
    end
    object Label6: TLabel
      Left = 8
      Top = 96
      Width = 44
      Height = 16
      Caption = #30005#33041#22411#21495
    end
    object Label7: TLabel
      Left = 264
      Top = 16
      Width = 66
      Height = 16
      Caption = #24037#20316#20154#21592#22995#21517
    end
    object Label8: TLabel
      Left = 8
      Top = 56
      Width = 44
      Height = 16
      Caption = #39044#32422#22320#28857
    end
    object Label9: TLabel
      Left = 136
      Top = 56
      Width = 44
      Height = 16
      Caption = #39044#32422#26085#26399
    end
    object Label10: TLabel
      Left = 264
      Top = 56
      Width = 44
      Height = 16
      Caption = #21040#36798#26102#38388
    end
    object Label11: TLabel
      Left = 8
      Top = 136
      Width = 44
      Height = 16
      Caption = #38382#39064#25551#36848
    end
    object UserNameDisplay: TEdit
      Left = 8
      Top = 32
      Width = 121
      Height = 24
      ReadOnly = True
      TabOrder = 0
    end
    object UserPhoneNumDisplay: TEdit
      Left = 136
      Top = 32
      Width = 121
      Height = 24
      ReadOnly = True
      TabOrder = 1
    end
    object ComputerModelDisplay: TEdit
      Left = 8
      Top = 112
      Width = 377
      Height = 24
      ReadOnly = True
      TabOrder = 2
    end
    object WorkerNameDisplay: TEdit
      Left = 264
      Top = 32
      Width = 121
      Height = 24
      ReadOnly = True
      TabOrder = 3
    end
    object CampusDisplay: TEdit
      Left = 8
      Top = 72
      Width = 121
      Height = 24
      TabOrder = 4
    end
    object DateDisplay: TEdit
      Left = 136
      Top = 72
      Width = 121
      Height = 24
      TabOrder = 5
    end
    object ArriveTimeDisplay: TEdit
      Left = 264
      Top = 72
      Width = 121
      Height = 24
      TabOrder = 6
    end
    object DescriptionDisplay: TMemo
      Left = 8
      Top = 152
      Width = 377
      Height = 89
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 7
    end
  end
  object EditRecordGroupBox: TGroupBox
    Left = 312
    Top = 264
    Width = 393
    Height = 201
    Caption = #32534#36753#39044#32422#20449#24687
    TabOrder = 6
    object Label12: TLabel
      Left = 8
      Top = 16
      Width = 44
      Height = 16
      Caption = #39044#32422#29366#24577
    end
    object Label13: TLabel
      Left = 8
      Top = 56
      Width = 22
      Height = 16
      Caption = #22791#27880
    end
    object Label14: TLabel
      Left = 160
      Top = 16
      Width = 44
      Height = 16
      Caption = #25298#32477#29702#30001
    end
    object AppointmentStatusComboBox: TComboBox
      Left = 8
      Top = 32
      Width = 145
      Height = 24
      ItemHeight = 16
      TabOrder = 0
    end
    object WorkerCaptionDisplay: TMemo
      Left = 8
      Top = 72
      Width = 377
      Height = 89
      TabOrder = 1
    end
    object RejectReasonDisplay: TEdit
      Left = 160
      Top = 32
      Width = 225
      Height = 24
      TabOrder = 2
    end
    object SubmitButton: TButton
      Left = 8
      Top = 168
      Width = 75
      Height = 25
      Caption = #25552#20132
      TabOrder = 3
      OnClick = SubmitButtonClick
    end
  end
  object DebugButton: TButton
    Left = 72
    Top = 496
    Width = 75
    Height = 25
    Caption = 'Debug'
    TabOrder = 7
    Visible = False
    OnClick = DebugButtonClick
  end
  object ManagementGroupBox: TGroupBox
    Left = 312
    Top = 472
    Width = 393
    Height = 49
    Caption = #31649#29702#21151#33021
    TabOrder = 8
    object ManageUserButton: TButton
      Left = 8
      Top = 16
      Width = 75
      Height = 25
      Caption = #29992#25143#31649#29702
      TabOrder = 0
      OnClick = ManageUserButtonClick
    end
    object ManageScheduleButton: TButton
      Left = 88
      Top = 16
      Width = 105
      Height = 25
      Caption = #20540#29677#26102#38388#31649#29702
      TabOrder = 1
      OnClick = ManageScheduleButtonClick
    end
    object Button1: TButton
      Left = 304
      Top = 16
      Width = 75
      Height = 25
      Caption = #20844#21578#31649#29702
      TabOrder = 2
      OnClick = Button1Click
    end
    object CampusManageButton: TButton
      Left = 200
      Top = 16
      Width = 97
      Height = 25
      Caption = #35786#25152#22320#28857#31649#29702
      TabOrder = 3
      OnClick = CampusManageButtonClick
    end
  end
  object ADOclinic_manageConnection: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Password=Test-0penGaussServer-DustinNas;Persi' +
      'st Security Info=True;User ID=cloudb;Data Source=PostgreSQL35W;I' +
      'nitial Catalog=postgres'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 272
    Top = 496
  end
  object AppointmentDataSource: TDataSource
    DataSet = ADOappointmentQuery
    Left = 40
    Top = 456
  end
  object ADOcampusTable: TADOTable
    Connection = ADOclinic_manageConnection
    AfterOpen = ADOcampusTableAfterOpen
    TableName = 'campus'
    Left = 8
    Top = 96
    object ADOcampusTableid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object ADOcampusTablename: TWideStringField
      FieldName = 'name'
      Size = 255
    end
  end
  object ADOScheduleQuery: TADOQuery
    Connection = ADOclinic_manageConnection
    Parameters = <>
    Left = 160
    Top = 96
  end
  object ScheduleDataSet: TDataSource
    Left = 192
    Top = 96
  end
  object ADOappointmentQuery: TADOQuery
    Connection = ADOclinic_manageConnection
    Parameters = <>
    Left = 8
    Top = 456
  end
  object ADORecordDetailQuery: TADOQuery
    Connection = ADOclinic_manageConnection
    Parameters = <>
    Left = 328
    Top = 208
  end
  object RecordDetailDataSource: TDataSource
    DataSet = ADORecordDetailQuery
    Left = 360
    Top = 208
  end
  object ADORecordSubmitQuery: TADOQuery
    Connection = ADOclinic_manageConnection
    Parameters = <>
    Left = 328
    Top = 368
  end
  object ADODebugQuery: TADOQuery
    Connection = ADOclinic_manageConnection
    Parameters = <>
    Left = 240
    Top = 496
  end
end
