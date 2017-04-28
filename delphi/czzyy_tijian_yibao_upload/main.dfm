object Form1: TForm1
  Left = 282
  Top = 193
  Width = 928
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 8
    Top = 8
    Width = 497
    Height = 345
    ColCount = 15
    TabOrder = 0
  end
  object ProgressBar1: TProgressBar
    Left = 480
    Top = 24
    Width = 150
    Height = 17
    TabOrder = 1
  end
  object btnUpload: TButton
    Left = 440
    Top = 376
    Width = 75
    Height = 25
    Caption = #25968#25454#19978#20256
    TabOrder = 2
    OnClick = btnUploadClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 416
    Width = 912
    Height = 25
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object Memo1: TMemo
    Left = 512
    Top = 8
    Width = 385
    Height = 345
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 4
  end
  object Button1: TButton
    Left = 240
    Top = 376
    Width = 75
    Height = 25
    Caption = #25968#25454#21152#36733
    TabOrder = 5
    OnClick = Button1Click
  end
  object OpenDialog1: TOpenDialog
    Left = 640
    Top = 16
  end
  object XLS: TXLSReadWriteII5
    ComponentVersion = '5.20.46'
    Version = xvExcel2007
    DirectRead = True
    DirectWrite = False
    OnReadCell = XLSReadCell
    Left = 696
    Top = 368
  end
end
