object CampusManageForm: TCampusManageForm
  Left = 461
  Top = 204
  Width = 305
  Height = 321
  Caption = #31649#29702#35786#25152#22320#28857
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
  object CampusListBox: TListBox
    Left = 8
    Top = 8
    Width = 121
    Height = 265
    ItemHeight = 16
    TabOrder = 0
    OnClick = CampusListBoxClick
  end
  object GroupBox1: TGroupBox
    Left = 136
    Top = 8
    Width = 145
    Height = 129
    Caption = #32534#36753#20449#24687
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 22
      Height = 16
      Caption = #21517#31216
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Microsoft YaHei UI'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 56
      Width = 22
      Height = 16
      Caption = #22320#22336
    end
    object CampusNameEdit: TEdit
      Left = 8
      Top = 32
      Width = 129
      Height = 24
      TabOrder = 0
    end
    object CampusAddressEdit: TEdit
      Left = 8
      Top = 72
      Width = 129
      Height = 24
      TabOrder = 1
    end
    object UpdateCampusButton: TButton
      Left = 8
      Top = 96
      Width = 57
      Height = 25
      Caption = #26356#26032
      TabOrder = 2
      OnClick = UpdateCampusButtonClick
    end
    object DeleteCampusButton: TButton
      Left = 72
      Top = 96
      Width = 65
      Height = 25
      Caption = #21024#38500
      TabOrder = 3
      OnClick = DeleteCampusButtonClick
    end
  end
  object NewCampusGroupBox: TGroupBox
    Left = 136
    Top = 144
    Width = 145
    Height = 129
    Caption = #26032#24314#22320#28857
    TabOrder = 2
    object Label3: TLabel
      Left = 8
      Top = 16
      Width = 22
      Height = 16
      Caption = #21517#31216
    end
    object Label4: TLabel
      Left = 8
      Top = 56
      Width = 22
      Height = 16
      Caption = #22320#22336
    end
    object NewCampusNameEdit: TEdit
      Left = 8
      Top = 32
      Width = 129
      Height = 24
      TabOrder = 0
    end
    object NewCampusAddressEdit: TEdit
      Left = 8
      Top = 72
      Width = 129
      Height = 24
      TabOrder = 1
    end
    object SubmitNewCampusButton: TButton
      Left = 8
      Top = 96
      Width = 129
      Height = 25
      Caption = #25552#20132
      TabOrder = 2
      OnClick = SubmitNewCampusButtonClick
    end
  end
  object ADODatabaseConnection: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Password=Test-0penGaussServer-DustinNas;Persi' +
      'st Security Info=True;User ID=cloudb;Data Source=PostgreSQL35W;I' +
      'nitial Catalog=clinic_manage'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 96
    Top = 240
  end
  object ADOCampusQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 64
    Top = 240
  end
  object ADOEditQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 32
    Top = 240
  end
end
