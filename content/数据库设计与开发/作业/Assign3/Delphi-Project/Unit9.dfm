object AnnouncementForm: TAnnouncementForm
  Left = 527
  Top = 201
  Width = 412
  Height = 298
  Caption = #31649#29702#20844#21578
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
  object AnnouncementListBox: TListBox
    Left = 8
    Top = 8
    Width = 121
    Height = 209
    ItemHeight = 16
    TabOrder = 0
    OnClick = AnnouncementListBoxClick
  end
  object AnnouncementGroupBox: TGroupBox
    Left = 136
    Top = 8
    Width = 249
    Height = 241
    Caption = #32534#36753#20844#21578
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 22
      Height = 16
      Caption = #26631#39064
    end
    object Label2: TLabel
      Left = 8
      Top = 96
      Width = 22
      Height = 16
      Caption = #20869#23481
    end
    object Label3: TLabel
      Left = 8
      Top = 56
      Width = 33
      Height = 16
      Caption = #20248#20808#32423
    end
    object Label4: TLabel
      Left = 88
      Top = 56
      Width = 44
      Height = 16
      Caption = #36807#26399#26102#38388
    end
    object TitleEdit: TEdit
      Left = 8
      Top = 32
      Width = 233
      Height = 24
      TabOrder = 0
    end
    object ContentMemo: TMemo
      Left = 8
      Top = 112
      Width = 233
      Height = 89
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object SubmitButton: TButton
      Left = 8
      Top = 208
      Width = 75
      Height = 25
      Caption = #25552#20132
      TabOrder = 2
      OnClick = SubmitButtonClick
    end
    object DeleteButton: TButton
      Left = 88
      Top = 208
      Width = 75
      Height = 25
      Caption = #21024#38500
      TabOrder = 3
      OnClick = DeleteButtonClick
    end
    object PriorityEdit: TEdit
      Left = 8
      Top = 72
      Width = 73
      Height = 24
      TabOrder = 4
    end
    object ExpireDateTimePicker: TDateTimePicker
      Left = 88
      Top = 72
      Width = 154
      Height = 24
      Date = 73050.999988425930000000
      Time = 73050.999988425930000000
      TabOrder = 5
    end
  end
  object NewButton: TButton
    Left = 8
    Top = 224
    Width = 123
    Height = 25
    Caption = #26032#24314#20844#21578
    TabOrder = 2
    OnClick = NewButtonClick
  end
  object ADODatabaseConnection: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Password=Test-0penGaussServer-DustinNas;Persi' +
      'st Security Info=True;User ID=cloudb;Data Source=PostgreSQL35W;I' +
      'nitial Catalog=clinic_manage'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 88
    Top = 176
  end
  object ADOAnnouncementQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 56
    Top = 176
  end
  object ADOEditQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 24
    Top = 176
  end
end
