object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Main Form'
  ClientHeight = 392
  ClientWidth = 706
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object JcTDIForm: TJcTDIForm
    Left = 0
    Top = 41
    Width = 706
    Height = 332
    NumForms = 0
    BackgroundImage.Left = 0
    BackgroundImage.Top = 0
    BackgroundImage.Width = 706
    BackgroundImage.Height = 306
    BackgroundImage.Align = alClient
    BackgroundImage.ExplicitWidth = 105
    BackgroundImage.ExplicitHeight = 105
    Align = alClient
    BackgroundColor = clWhite
    TabOrder = 0
    ExplicitLeft = 96
    ExplicitTop = 56
    ExplicitWidth = 505
    ExplicitHeight = 257
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 706
    Height = 41
    Align = alTop
    TabOrder = 1
    ExplicitLeft = 112
    ExplicitTop = 16
    ExplicitWidth = 185
    object Button1: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Form1'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 97
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Form2'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 624
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Close'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 373
    Width = 706
    Height = 19
    Panels = <>
    ExplicitLeft = 296
    ExplicitTop = 344
    ExplicitWidth = 0
  end
end
