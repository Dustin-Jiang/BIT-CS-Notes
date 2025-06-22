object UserManageForm: TUserManageForm
  Left = 537
  Top = 205
  Width = 411
  Height = 433
  Caption = #29992#25143#31649#29702
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
    Caption = #29992#25143#21015#34920
  end
  object UsersListBox: TListBox
    Left = 8
    Top = 24
    Width = 137
    Height = 361
    ItemHeight = 16
    TabOrder = 0
    OnClick = HandleUserSelect
    OnDblClick = HandleUserSelect
  end
  object UserInfoGroupBox: TGroupBox
    Left = 152
    Top = 8
    Width = 233
    Height = 177
    Caption = #29992#25143#20449#24687
    TabOrder = 1
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
    object Label6: TLabel
      Left = 8
      Top = 132
      Width = 55
      Height = 16
      Caption = #35774#32622#26032#23494#30721
    end
    object PhoneNumDisplay: TEdit
      Left = 8
      Top = 108
      Width = 217
      Height = 24
      ReadOnly = True
      TabOrder = 0
    end
    object NameDisplay: TEdit
      Left = 8
      Top = 32
      Width = 217
      Height = 24
      TabOrder = 1
    end
    object IdDisplay: TEdit
      Left = 8
      Top = 68
      Width = 217
      Height = 24
      TabOrder = 2
    end
    object NewPasswordEdit: TEdit
      Left = 8
      Top = 148
      Width = 217
      Height = 24
      PasswordChar = '*'
      TabOrder = 3
    end
  end
  object UserPermissionRadioGroup: TRadioGroup
    Left = 152
    Top = 192
    Width = 233
    Height = 97
    Caption = #29992#25143#26435#38480
    Enabled = False
    Items.Strings = (
      #26222#36890#29992#25143
      #24037#20316#20154#21592
      #31649#29702#21592)
    TabOrder = 2
    OnClick = UserPermissionRadioGroupClick
  end
  object EditUserButton: TButton
    Left = 152
    Top = 360
    Width = 75
    Height = 25
    Caption = #20462#25913
    Enabled = False
    TabOrder = 3
    OnClick = EditUserButtonClick
  end
  object DeleteUserButton: TButton
    Left = 232
    Top = 360
    Width = 75
    Height = 25
    Caption = #21024#38500
    Enabled = False
    TabOrder = 4
    OnClick = DeleteUserButtonClick
  end
  object WorkerInfoGroupBox: TGroupBox
    Left = 152
    Top = 296
    Width = 233
    Height = 61
    Caption = #24037#20316#20154#21592#20449#24687
    TabOrder = 5
    Visible = False
    object Label5: TLabel
      Left = 8
      Top = 16
      Width = 22
      Height = 16
      Caption = #26657#21306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Microsoft YaHei UI'
      Font.Style = []
      ParentFont = False
    end
    object WorkerCampusComboBox: TComboBox
      Left = 8
      Top = 32
      Width = 217
      Height = 24
      Enabled = False
      ItemHeight = 16
      TabOrder = 0
    end
  end
  object ADODatabaseConnection: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Password=Test-0penGaussServer-DustinNas;Persi' +
      'st Security Info=True;User ID=cloudb;Data Source=PostgreSQL35W;I' +
      'nitial Catalog=clinic_manage'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 360
    Top = 360
  end
  object ADOUsersQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 112
    Top = 352
  end
  object ADOCampusQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 88
    Top = 352
  end
  object ADOUserDetailQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 64
    Top = 352
  end
  object ADOPermissionQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 40
    Top = 352
  end
  object ADOEditQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 112
    Top = 320
  end
end
