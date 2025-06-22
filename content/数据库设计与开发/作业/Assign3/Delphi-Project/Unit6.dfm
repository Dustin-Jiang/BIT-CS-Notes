object ScheduleManageForm: TScheduleManageForm
  Left = 494
  Top = 240
  Width = 410
  Height = 272
  Caption = #20540#29677#26102#38388#31649#29702
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
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 44
    Height = 16
    Caption = #20540#29677#26102#38388
  end
  object ScheduleListBox: TListBox
    Left = 8
    Top = 24
    Width = 185
    Height = 201
    ItemHeight = 16
    TabOrder = 0
    OnClick = ScheduleListBoxClick
  end
  object ScheduleDetailGroupBox: TGroupBox
    Left = 200
    Top = 8
    Width = 185
    Height = 185
    Caption = #35814#32454#20449#24687
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 16
      Width = 22
      Height = 16
      Caption = #26085#26399
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Microsoft YaHei UI'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 96
      Width = 44
      Height = 16
      Caption = #24320#22987#26102#38388
    end
    object Label4: TLabel
      Left = 88
      Top = 96
      Width = 44
      Height = 16
      Caption = #32467#26463#26102#38388
    end
    object Label5: TLabel
      Left = 8
      Top = 56
      Width = 22
      Height = 16
      Caption = #22320#28857
    end
    object Label6: TLabel
      Left = 8
      Top = 136
      Width = 22
      Height = 16
      Caption = #23481#37327
    end
    object ScheduleDatePicker: TDateTimePicker
      Left = 8
      Top = 32
      Width = 169
      Height = 24
      Date = 45792.737484814820000000
      Time = 45792.737484814820000000
      TabOrder = 0
    end
    object StartTimeEdit: TMaskEdit
      Left = 8
      Top = 112
      Width = 73
      Height = 24
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 1
      Text = '  :  '
    end
    object EndTimeEdit: TMaskEdit
      Left = 88
      Top = 112
      Width = 88
      Height = 24
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 2
      Text = '  :  '
    end
    object CampusComboBox: TComboBox
      Left = 8
      Top = 72
      Width = 169
      Height = 24
      ItemHeight = 16
      TabOrder = 3
    end
    object CapacityEdit: TEdit
      Left = 8
      Top = 152
      Width = 169
      Height = 24
      TabOrder = 4
    end
  end
  object UpdateScheduleButton: TButton
    Left = 200
    Top = 200
    Width = 57
    Height = 25
    Caption = #26356#26032
    TabOrder = 2
    OnClick = UpdateScheduleButtonClick
  end
  object DeleteScheduleButton: TButton
    Left = 264
    Top = 200
    Width = 57
    Height = 25
    Caption = #21024#38500
    TabOrder = 3
    OnClick = DeleteScheduleButtonClick
  end
  object NewScheduleButton: TButton
    Left = 328
    Top = 200
    Width = 57
    Height = 25
    Caption = #26032#24314
    TabOrder = 4
    OnClick = NewScheduleButtonClick
  end
  object ADODatabaseConnection: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Password=Test-0penGaussServer-DustinNas;Persi' +
      'st Security Info=True;User ID=cloudb;Data Source=PostgreSQL35W;I' +
      'nitial Catalog=clinic_manage'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 160
    Top = 192
  end
  object ADOScheduleQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 128
    Top = 192
  end
  object ADOScheduleDetailQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 96
    Top = 192
  end
  object ADOCampusQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 64
    Top = 192
  end
  object ADOEditQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 32
    Top = 192
  end
end
