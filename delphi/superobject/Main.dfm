object frmMain: TfrmMain
  Left = 410
  Top = 231
  Width = 412
  Height = 281
  BorderStyle = bsSizeToolWin
  Caption = #26032#20013#26032#19968#21345#36890
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox3: TGroupBox
    Left = 2
    Top = 1
    Width = 393
    Height = 241
    Caption = #26597#35810'/'#28040#36153
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 29
      Width = 39
      Height = 13
      Caption = #36134#21495':    '
    end
    object Label2: TLabel
      Left = 24
      Top = 76
      Width = 39
      Height = 13
      Caption = #20313#39069':    '
    end
    object Label3: TLabel
      Left = 25
      Top = 164
      Width = 47
      Height = 13
      BiDiMode = bdLeftToRight
      Caption = #28040#36153':    '
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentColor = False
      ParentFont = False
    end
    object Label4: TLabel
      Left = 24
      Top = 53
      Width = 39
      Height = 13
      Caption = #21345#21495':    '
    end
    object Label5: TLabel
      Left = 208
      Top = 29
      Width = 39
      Height = 13
      Caption = #22995#21517':    '
    end
    object Label6: TLabel
      Left = 208
      Top = 53
      Width = 39
      Height = 13
      Caption = #29366#24577':    '
    end
    object edit_account: TEdit
      Left = 64
      Top = 24
      Width = 121
      Height = 21
      Color = clMenuHighlight
      TabOrder = 0
      Text = '101945'
    end
    object btnWSQuery: TButton
      Left = 143
      Top = 107
      Width = 111
      Height = 25
      Caption = #36134#25143#26597#35810
      TabOrder = 1
      OnClick = btnWSQueryClick
    end
    object btnWSCost: TButton
      Left = 63
      Top = 203
      Width = 111
      Height = 25
      Caption = 'WebService'#28040#36153
      TabOrder = 2
      OnClick = btnWSCostClick
    end
    object edit_money: TEdit
      Left = 65
      Top = 161
      Width = 264
      Height = 21
      Color = clMenuHighlight
      TabOrder = 3
      Text = '0'
    end
    object btnTPEQuery: TButton
      Left = 7
      Top = 107
      Width = 111
      Height = 25
      Caption = 'TPE'#26597#35810
      TabOrder = 4
      Visible = False
      OnClick = btnTPEQueryClick
    end
    object btnTPECost: TButton
      Left = 215
      Top = 203
      Width = 111
      Height = 25
      Caption = 'TPE'#28040#36153
      TabOrder = 5
      OnClick = btnTPECostClick
    end
    object edit_cardno: TEdit
      Left = 64
      Top = 48
      Width = 121
      Height = 21
      Color = clScrollBar
      Enabled = False
      TabOrder = 6
    end
    object edit_name: TEdit
      Left = 248
      Top = 24
      Width = 121
      Height = 21
      Color = clScrollBar
      Enabled = False
      TabOrder = 7
    end
    object edit_Condition: TEdit
      Left = 248
      Top = 48
      Width = 121
      Height = 21
      Color = clScrollBar
      Enabled = False
      TabOrder = 8
    end
    object edit_balance: TEdit
      Left = 64
      Top = 73
      Width = 305
      Height = 21
      Color = clScrollBar
      Enabled = False
      TabOrder = 9
    end
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 322
    Top = 121
  end
end
