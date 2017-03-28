object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  Caption = 'frmLogin'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 35
    Width = 48
    Height = 13
    Caption = #29992#25143#21517#65306
  end
  object Label2: TLabel
    Left = 32
    Top = 72
    Width = 48
    Height = 13
    Caption = #23494'    '#30721#65306
  end
  object Edit1: TEdit
    Left = 96
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 96
    Top = 69
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
    Text = 'Edit1'
  end
  object btn_login: TButton
    Left = 264
    Top = 30
    Width = 75
    Height = 25
    Caption = #30331#24405
    TabOrder = 2
    OnClick = btn_loginClick
  end
  object Button2: TButton
    Left = 264
    Top = 61
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 3
    OnClick = Button2Click
  end
end
