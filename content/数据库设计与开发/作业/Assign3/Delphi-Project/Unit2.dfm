object LoginForm: TLoginForm
  Left = 564
  Top = 236
  Width = 337
  Height = 300
  Caption = #30331#24405#21040' '#35786#25152#21518#21488#31649#29702#31995#32479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft YaHei UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object Label6: TLabel
    Left = 16
    Top = 128
    Width = 22
    Height = 16
    Caption = #23494#30721
  end
  object LoginPageControl: TPageControl
    Left = 8
    Top = 8
    Width = 305
    Height = 225
    ActivePage = LoginTabSheet
    TabOrder = 0
    object LoginTabSheet: TTabSheet
      Caption = #30331#24405
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 22
        Height = 16
        Caption = #23398#21495
      end
      object Label2: TLabel
        Left = 8
        Top = 48
        Width = 22
        Height = 16
        Caption = #23494#30721
      end
      object LoginIdEdit: TEdit
        Left = 8
        Top = 24
        Width = 281
        Height = 24
        TabOrder = 0
      end
      object LoginButton: TButton
        Left = 8
        Top = 168
        Width = 75
        Height = 25
        Caption = #30331#24405
        TabOrder = 2
        OnClick = LoginButtonClick
      end
      object LoginPwdEdit: TEdit
        Left = 8
        Top = 64
        Width = 281
        Height = 24
        ImeMode = imClose
        PasswordChar = '*'
        TabOrder = 1
      end
    end
    object RegisterTabSheet: TTabSheet
      Caption = #27880#20876
      ImageIndex = 1
      object Label3: TLabel
        Left = 8
        Top = 48
        Width = 22
        Height = 16
        Caption = #23494#30721
      end
      object Label4: TLabel
        Left = 8
        Top = 8
        Width = 22
        Height = 16
        Caption = #23398#21495
      end
      object Label5: TLabel
        Left = 8
        Top = 88
        Width = 44
        Height = 16
        Caption = #30830#35748#23494#30721
      end
      object Label7: TLabel
        Left = 8
        Top = 128
        Width = 22
        Height = 16
        Caption = #22995#21517
      end
      object Label8: TLabel
        Left = 136
        Top = 128
        Width = 44
        Height = 16
        Caption = #30005#35805#21495#30721
      end
      object RegisterUserNameEdit: TEdit
        Left = 8
        Top = 24
        Width = 281
        Height = 24
        TabOrder = 0
      end
      object RegisterButton: TButton
        Left = 8
        Top = 168
        Width = 75
        Height = 25
        Caption = #27880#20876
        TabOrder = 5
        OnClick = RegisterButtonClick
      end
      object RegisterPwdEdit1: TEdit
        Left = 8
        Top = 64
        Width = 281
        Height = 24
        ImeMode = imClose
        PasswordChar = '*'
        TabOrder = 1
      end
      object RegisterPwdEdit2: TEdit
        Left = 8
        Top = 104
        Width = 281
        Height = 24
        ImeMode = imClose
        PasswordChar = '*'
        TabOrder = 2
      end
      object UserNameEdit: TEdit
        Left = 8
        Top = 144
        Width = 121
        Height = 24
        TabOrder = 3
      end
      object PhoneNumEdit: TEdit
        Left = 136
        Top = 144
        Width = 153
        Height = 24
        TabOrder = 4
      end
    end
  end
  object LoginStatusBar: TStatusBar
    Left = 0
    Top = 242
    Width = 321
    Height = 19
    Panels = <
      item
        Text = #23601#32490
        Width = 150
      end>
  end
  object ADODatabaseConnection: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;User ID=cloudb;Da' +
      'ta Source=PostgreSQL35W;Initial Catalog=clinic_manage'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 280
    Top = 200
  end
  object ADOLoginQuery: TADOQuery
    Connection = ADODatabaseConnection
    Parameters = <>
    Left = 248
    Top = 200
  end
  object LoginDataSource: TDataSource
    DataSet = ADOLoginQuery
    Left = 216
    Top = 200
  end
end
