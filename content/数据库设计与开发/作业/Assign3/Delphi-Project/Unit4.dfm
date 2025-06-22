object NewAppointmentForm: TNewAppointmentForm
  Left = 534
  Top = 212
  Width = 394
  Height = 344
  Caption = #26032#24314#39044#32422
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  OldCreateOrder = False
  OnShow = HandleShow
  PixelsPerInch = 96
  TextHeight = 16
  object AppointmentGroupBox: TGroupBox
    Left = 8
    Top = 0
    Width = 361
    Height = 297
    Caption = #39044#32422#20449#24687
    TabOrder = 0
    object Label5: TLabel
      Left = 8
      Top = 16
      Width = 22
      Height = 16
      Caption = #26657#21306
    end
    object Label6: TLabel
      Left = 184
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
      Top = 96
      Width = 44
      Height = 16
      Caption = #38382#39064#25551#36848
    end
    object CampusComboBox: TComboBox
      Left = 8
      Top = 32
      Width = 169
      Height = 24
      ItemHeight = 16
      TabOrder = 0
      OnChange = CampusComboChange
    end
    object ScheduleComboBox: TComboBox
      Left = 184
      Top = 32
      Width = 169
      Height = 24
      Enabled = False
      ItemHeight = 16
      TabOrder = 1
    end
    object ComputerModelEdit: TEdit
      Left = 8
      Top = 72
      Width = 345
      Height = 24
      TabOrder = 2
    end
    object DescriptionEdit: TMemo
      Left = 8
      Top = 112
      Width = 345
      Height = 145
      TabOrder = 3
    end
    object NewAppointmentButton: TButton
      Left = 8
      Top = 264
      Width = 75
      Height = 25
      Caption = #30830#23450
      TabOrder = 4
      OnClick = NewAppointmentButtonClick
    end
    object CancelButton: TButton
      Left = 88
      Top = 264
      Width = 75
      Height = 25
      Caption = #21462#28040
      TabOrder = 5
      OnClick = CancelButtonClick
    end
  end
  object ADODatabaseConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Password=Test-0penGaussServer-DustinNas;Persi' +
      'st Security Info=True;User ID=cloudb;Data Source=PostgreSQL35W;I' +
      'nitial Catalog=clinic_manage'
    LoginPrompt = False
    Left = 336
    Top = 264
  end
  object ADOCampusTable: TADOTable
    Connection = ADODatabaseConnection
    LockType = ltReadOnly
    TableName = 'campus'
    Left = 304
    Top = 264
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
  object ADOScheduleQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 272
    Top = 264
  end
  object ADOInsertQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 240
    Top = 264
  end
end
