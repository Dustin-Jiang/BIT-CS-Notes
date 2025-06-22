object NewScheduleForm: TNewScheduleForm
  Left = 520
  Top = 289
  Width = 203
  Height = 249
  Caption = #26032#24314#20540#29677#26102#38388
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
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 22
    Height = 16
    Caption = #26085#26399
  end
  object Label5: TLabel
    Left = 8
    Top = 48
    Width = 22
    Height = 16
    Caption = #22320#28857
  end
  object Label3: TLabel
    Left = 8
    Top = 88
    Width = 44
    Height = 16
    Caption = #24320#22987#26102#38388
  end
  object Label4: TLabel
    Left = 88
    Top = 88
    Width = 44
    Height = 16
    Caption = #32467#26463#26102#38388
  end
  object Label6: TLabel
    Left = 8
    Top = 128
    Width = 22
    Height = 16
    Caption = #23481#37327
  end
  object CampusComboBox: TComboBox
    Left = 8
    Top = 64
    Width = 169
    Height = 24
    ItemHeight = 16
    TabOrder = 0
  end
  object ScheduleDatePicker: TDateTimePicker
    Left = 8
    Top = 24
    Width = 169
    Height = 24
    Date = 45792.737484814820000000
    Time = 45792.737484814820000000
    TabOrder = 1
  end
  object StartTimeEdit: TMaskEdit
    Left = 8
    Top = 104
    Width = 73
    Height = 24
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 2
    Text = '  :  '
  end
  object EndTimeEdit: TMaskEdit
    Left = 88
    Top = 104
    Width = 88
    Height = 24
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 3
    Text = '  :  '
  end
  object CapacityEdit: TEdit
    Left = 8
    Top = 144
    Width = 169
    Height = 24
    TabOrder = 4
  end
  object SubmitButton: TButton
    Left = 8
    Top = 176
    Width = 75
    Height = 25
    Caption = #25552#20132
    TabOrder = 5
    OnClick = SubmitButtonClick
  end
  object ADODatabaseConnection: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Password=Test-0penGaussServer-DustinNas;Persi' +
      'st Security Info=True;User ID=cloudb;Data Source=PostgreSQL35W;I' +
      'nitial Catalog=clinic_manage'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 152
    Top = 176
  end
  object ADOCampusQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 120
    Top = 176
  end
  object ADOEditQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 88
    Top = 176
  end
end
