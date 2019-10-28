object fDicasDBGrid: TfDicasDBGrid
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Samples'
  ClientHeight = 366
  ClientWidth = 531
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object JcDBGrid1: TJcDBGrid
    Left = 0
    Top = 0
    Width = 531
    Height = 366
    Align = alClient
    DataSource = DataSource
    FixedColor = clGray
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    ColorFirst = 16759225
    ColorFirstFont = clBlack
    ColorSecond = clWhite
    Columns = <
      item
        Expanded = False
        FieldName = 'Codigo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nome'
        Width = 429
        Visible = True
      end>
  end
  object ClientDataSet: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 96
    Top = 112
    object ClientDataSetCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object ClientDataSetNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object ClientDataSetAtivo: TStringField
      FieldName = 'Ativo'
    end
    object ClientDataSetCidade: TStringField
      FieldName = 'Cidade'
      Size = 50
    end
  end
  object DataSource: TDataSource
    DataSet = ClientDataSet
    Left = 168
    Top = 112
  end
end
