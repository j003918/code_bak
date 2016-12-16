object frmLogin: TfrmLogin
  Left = 467
  Top = 235
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsNone
  Caption = 'frmLogin'
  ClientHeight = 162
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 377
    Height = 145
    TabOrder = 0
    object Label1: TLabel
      Left = 107
      Top = 24
      Width = 48
      Height = 13
      Caption = #29992#25143#21517'    '
    end
    object Label2: TLabel
      Left = 107
      Top = 56
      Width = 48
      Height = 13
      Caption = #23494'    '#30721'    '
    end
    object txtUserName: TEdit
      Left = 155
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object txtPassWord: TEdit
      Left = 155
      Top = 56
      Width = 121
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
    object btnLogin: TButton
      Left = 201
      Top = 88
      Width = 75
      Height = 25
      Caption = #30331#24405
      TabOrder = 2
      OnClick = btnLoginClick
    end
    object btnClose: TButton
      Left = 107
      Top = 88
      Width = 75
      Height = 25
      Caption = #36864#20986
      TabOrder = 3
      OnClick = btnCloseClick
    end
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 328
    Top = 32
  end
end
