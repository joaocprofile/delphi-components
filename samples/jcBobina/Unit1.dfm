object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 541
  ClientWidth = 817
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser1: TWebBrowser
    Left = 40
    Top = 56
    Width = 489
    Height = 401
    TabOrder = 0
    ControlData = {
      4C0000008A320000722900000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Button1: TButton
    Left = 552
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 552
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 2
    OnClick = Button2Click
  end
  object JcPDVBobina1: TJcPDVBobina
    WebBrowser = WebBrowser1
    HeaderFantasia = 'SIGDATA'
    HeaderEndereco = 'RUA JOSE TUFAO, 12'
    HeaderCidade = 'CAMPO GRANDE'
    HeaderEstado = 'MS'
    HeaderCep = '79033500'
    HeaderCNPJ = '08.053.005\0001-94'
    HeaderIE = '01245454'
    Left = 568
    Top = 48
  end
end
