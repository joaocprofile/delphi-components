object SFormDBDateEdit: TSFormDBDateEdit
  Left = 265
  Top = 259
  BorderStyle = bsNone
  Caption = '...'
  ClientHeight = 169
  ClientWidth = 187
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object PanBack: TPanel
    Left = 0
    Top = 0
    Width = 187
    Height = 169
    Align = alClient
    BorderWidth = 1
    Color = clWhite
    TabOrder = 0
    DesignSize = (
      187
      169)
    object LblTitle: TLabel
      Left = 25
      Top = 5
      Width = -117
      Height = 13
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Calend'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      ExplicitWidth = 148
    end
    object StrGrid: TStringGrid
      Left = 2
      Top = 21
      Width = 183
      Height = 146
      Align = alClient
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      BorderStyle = bsNone
      ColCount = 7
      Ctl3D = False
      DefaultColWidth = 25
      DefaultRowHeight = 16
      DefaultDrawing = False
      FixedColor = clWhite
      FixedCols = 0
      RowCount = 7
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [goVertLine, goTabs]
      ParentColor = True
      ParentCtl3D = False
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 0
      OnClick = StrGridClick
      OnDblClick = StrGridDblClick
      OnDrawCell = StrGridDrawCell
      OnKeyPress = StrGridKeyPress
      ExplicitTop = 24
      ColWidths = (
        25
        25
        25
        25
        25
        25
        31)
    end
    object P_Middle: TPanel
      Left = 2
      Top = 2
      Width = 183
      Height = 19
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object LblMonth: TLabel
        Left = 36
        Top = 3
        Width = 108
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = 'Janeiro 2006'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 13597255
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object BtnLastAno: TSpeedButton
        Left = 2
        Top = 2
        Width = 16
        Height = 15
        Hint = 'Ano Anterior'
        Flat = True
        Glyph.Data = {
          DA020000424DDA0200000000000036000000280000000D0000000D0000000100
          200000000000A4020000120B0000120B00000000000000000000FFFFFF00FFFF
          FF00FDFDFD00F5F5F500E6E6E600DBDBDB00D7D7D700DADADA00E3E3E300F1F1
          F100FBFBFB00FFFFFF00FFFFFF00FFFFFF00FCFCFC00EBEBEB00C8C8C800A2A2
          A2008A8A8A00838383008A8A8A00A0A0A000C2C2C200E3E3E300F8F8F800FEFE
          FE00FDFDFD00EBEBEB00C2C2C200BEBEBE00D6D4D300DCDCDB00D1D1D000B4B4
          B5008D8E8E0086868600B3B3B300E0E0E000FAFAFA00F5F5F500D1D1D100E2E2
          E200F3F3F300F2F3F300F2F3F100EBECEB00E0DFDF00CCCBC900A3A3A3008787
          8700BBBBBB00ECECEC00E5E5E500E4E4E400F7F8FB00FBFAFC00FCFBFC00F6F6
          F600F6F7F600EDEEED00DCDCDC00C7C7C7009A9C9C009F9F9F00DFDFDF00E1E1
          E000F9FAFA00FBFDFD00DDDDDE006E6E6E00D0CFD000DBDAD9006C6C6C00C0BF
          BF00D5D6D500B6B6B40095959500D7D7D700E1E0E000EDECED008C8D8D004242
          420040404000797979004242420040404000C0C0BF00D8DADA00BABBBB009696
          9600D6D6D600DBDBDE00BCBCBC005151510040404000404040004C4C4C004040
          400040404000BBBABB00D2D2D500B9B9BA0099999900D8D8D800D1D1D200DFDF
          E000DBDBDB008B8B8B0044444400B5B5B5008A8A8A0044444400B0B1B100C4C5
          C600ADB0AF00A1A1A100DDDDDD00C7C8C700C8C8C800CECECE00D3D2D300BFBF
          BF00C5C8C500D3D4D300B8B7B800B4B4B400B5B5B600A8AAAB00B5B5B500E7E7
          E700DFE1E000BFBEC000BEBDBE00C3C3C200CAC9C900CAC9C900C5C5C500BBBA
          BB00B2B0B200A9A8A700B0B0B000D2D2D200F4F4F400FDFDFD00CFCECE00BEBF
          BD00BFBCBD00C2C0BF00C0BFC000BCBABA00B2B2B000A9A7A700AFABAD00D0D0
          CF00EFEFEF00FCFCFC00FFFFFF00FBFBFB00D6D3D500CBC9C900C0BCBD00C0BC
          BD00C0BCBD00C0BCBD00C3C0C100DEDEDD00F4F4F400FCFCFC00FFFFFF00}
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnLastAnoClick
      end
      object BtnNextAno: TSpeedButton
        Left = 162
        Top = 2
        Width = 16
        Height = 15
        Hint = 'Pr'#243'ximo Ano'
        Flat = True
        Glyph.Data = {
          DA020000424DDA0200000000000036000000280000000D0000000D0000000100
          200000000000A4020000120B0000120B00000000000000000000FFFFFF00FFFF
          FF00FDFDFD00F5F5F500E6E6E600DBDBDB00D7D7D700DADADA00E3E3E300F1F1
          F100FBFBFB00FFFFFF00FFFFFF00FFFFFF00FCFCFC00EBEBEB00C8C8C800A2A2
          A2008A8A8A00838383008A8A8A00A0A0A000C2C2C200E3E3E300F8F8F800FEFE
          FE00FDFDFD00EBEBEB00C2C2C200BEBEBE00D6D4D300DCDCDB00D1D1D000B4B4
          B5008D8E8E0086868600B3B3B300E0E0E000FAFAFA00F5F5F500D1D1D100E2E2
          E200F3F3F300F2F3F300F2F3F100EBECEB00E0DFDF00CCCBC900A3A3A3008787
          8700BBBBBB00ECECEC00E5E5E500E4E4E400F3F4F700FBFAFC00FCFBFC00F6F6
          F600F6F7F600EDEEED00E0E0E000C7C7C7009A9C9C009F9F9F00DFDFDF00E1E1
          E000F9FAFA00CFD1D1006E6E6E00DDDDDD00D0CFD0006D6D6D00D5D5D500E9E8
          E800D5D6D500B6B6B40095959500D7D7D700E1E0E000FAF9FA00CFD0D0004040
          40004242420079797900404040004242420085858500CDCFCF00BABBBB009696
          9600D6D6D600DBDBDE00F4F5F500CACACA0040404000404040004C4C4C004040
          4000404040004F4F4F00A4A4A600B9B9BA0099999900D8D8D800D1D1D200DFDF
          E000BABABA00444444008C8C8D00B5B5B5004444440089898900CDCECE00C4C5
          C600ADB0AF00A1A1A100DDDDDD00C7C8C700C8C8C800BEBEBE00BCBBBC00D6D6
          D600C5C8C500BDBEBD00CDCCCD00C2C2C200B5B5B600A8AAAB00B5B5B500E7E7
          E700DFE1E000BFBEC000BEBDBE00C3C3C200CAC9C900CAC9C900C5C5C500BBBA
          BB00B2B0B200A9A8A700B0B0B000D2D2D200F4F4F400FDFDFD00CFCECE00BEBF
          BD00BFBCBD00C2C0BF00C0BFC000BCBABA00B2B2B000A9A7A700AFABAD00D0D0
          CF00EFEFEF00FCFCFC00FFFFFF00FBFBFB00D6D3D500CBC9C900C0BCBD00C0BC
          BD00C0BCBD00C0BCBD00C3C0C100DEDEDD00F4F4F400FCFCFC00FFFFFF00}
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnNextAnoClick
      end
      object BtnNextMes: TSpeedButton
        Left = 145
        Top = 2
        Width = 16
        Height = 15
        Hint = 'Pr'#243'ximo M'#234's'
        Flat = True
        Glyph.Data = {
          DA020000424DDA0200000000000036000000280000000D0000000D0000000100
          200000000000A4020000120B0000120B00000000000000000000FFFFFF00FFFF
          FF00FDFDFD00F5F5F500E6E6E600DBDBDB00D7D7D700DADADA00E3E3E300F1F1
          F100FBFBFB00FFFFFF00FFFFFF00FFFFFF00FCFCFC00EBEBEB00C8C8C800A2A2
          A2008A8A8A00838383008A8A8A00A0A0A000C2C2C200E3E3E300F8F8F800FEFE
          FE00FDFDFD00EBEBEB00C2C2C200BEBEBE00D6D4D300DCDCDB00D1D1D000B4B4
          B5008D8E8E0086868600B3B3B300E0E0E000FAFAFA00F5F5F500D1D1D100E2E2
          E200F3F3F300F2F3F300F2F3F100EBECEB00E0DFDF00CCCBC900A3A3A3008787
          8700BBBBBB00ECECEC00E5E5E500E4E4E400F7F8FB00FBFAFC00F8F7F800FAFA
          FA00F6F7F600EDEEED00E0E0E000C7C7C7009A9C9C009F9F9F00DFDFDF00E1E1
          E000F9FAFA00FBFDFD00FCFCFD00D0CFD0006E6E6E00DBDAD900F3F3F200E9E8
          E800D5D6D500B6B6B40095959500D7D7D700E1E0E000FAF9FA00FBFCFC00FAFB
          FA00CFCECE00404040004242420088888700DEDEDD00D8DADA00BABBBB009696
          9600D6D6D600DBDBDE00F4F5F500F4F4F400F1F1F100C7C7C800404040004040
          400050505000AFAFAF00D2D2D500B9B9BA0099999900D8D8D800D1D1D200DFDF
          E000E1E1E100E2E2E200BBBBBD00444444008A8A8A00D6D6D700D4D5D500C4C5
          C600ADB0AF00A1A1A100DDDDDD00C7C8C700C8C8C800CECECE00D3D2D300C4C4
          C400C0C1C000D3D4D300CDCCCD00C2C2C200B5B5B600A8AAAB00B5B5B500E7E7
          E700DFE1E000BFBEC000BEBDBE00C3C3C200CAC9C900CAC9C900C5C5C500BBBA
          BB00B2B0B200A9A8A700B0B0B000D2D2D200F4F4F400FDFDFD00CFCECE00BEBF
          BD00BFBCBD00C2C0BF00C0BFC000BCBABA00B2B2B000A9A7A700AFABAD00D0D0
          CF00EFEFEF00FCFCFC00FFFFFF00FBFBFB00D6D3D500CBC9C900C0BCBD00C0BC
          BD00C0BCBD00C0BCBD00C3C0C100DEDEDD00F4F4F400FCFCFC00FFFFFF00}
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnNextMesClick
      end
      object BtnLastMes: TSpeedButton
        Left = 18
        Top = 2
        Width = 16
        Height = 15
        Hint = 'M'#234's Anterior'
        Flat = True
        Glyph.Data = {
          DA020000424DDA0200000000000036000000280000000D0000000D0000000100
          200000000000A4020000120B0000120B00000000000000000000FFFFFF00FFFF
          FF00FDFDFD00F5F5F500E6E6E600DBDBDB00D7D7D700DADADA00E3E3E300F1F1
          F100FBFBFB00FFFFFF00FFFFFF00FFFFFF00FCFCFC00EBEBEB00C8C8C800A2A2
          A2008A8A8A00838383008A8A8A00A0A0A000C2C2C200E3E3E300F8F8F800FEFE
          FE00FDFDFD00EBEBEB00C2C2C200BEBEBE00D6D4D300DCDCDB00D1D1D000B4B4
          B5008D8E8E0086868600B3B3B300E0E0E000FAFAFA00F5F5F500D1D1D100E2E2
          E200F3F3F300F2F3F300F2F3F100EBECEB00E0DFDF00CCCBC900A3A3A3008787
          8700BBBBBB00ECECEC00E5E5E500E4E4E400F7F8FB00FBFAFC00FCFBFC00FAFA
          FA00F6F7F600E9EAE900E0E0E000C7C7C7009A9C9C009F9F9F00DFDFDF00E1E1
          E000F9FAFA00FBFDFD00FCFCFD00FCFBFC00DDDDDD006D6D6D00C9C9C900E9E8
          E800D5D6D500B6B6B40095959500D7D7D700E1E0E000FAF9FA00FBFCFC00EDEE
          ED008C8B8B004242420040404000C9C9C700E9E9E800D8DADA00BABBBB009696
          9600D6D6D600DBDBDE00F4F5F500F4F4F400B9B9B90050505000404040004040
          4000C0BFC000E2E1E200D2D2D500B9B9BA0099999900D8D8D800D1D1D200DFDF
          E000E1E1E100E2E2E200DBDBDD008B8B8B0044444400B6B6B700D4D5D500C4C5
          C600ADB0AF00A1A1A100DDDDDD00C7C8C700C8C8C800CECECE00D3D2D300D6D6
          D600D7D8D700BDBEBD00BDBCBD00C2C2C200B5B5B600A8AAAB00B5B5B500E7E7
          E700DFE1E000BFBEC000BEBDBE00C3C3C200CAC9C900CAC9C900C5C5C500BBBA
          BB00B2B0B200A9A8A700B0B0B000D2D2D200F4F4F400FDFDFD00CFCECE00BEBF
          BD00BFBCBD00C2C0BF00C0BFC000BCBABA00B2B2B000A9A7A700AFABAD00D0D0
          CF00EFEFEF00FCFCFC00FFFFFF00FBFBFB00D6D3D500CBC9C900C0BCBD00C0BC
          BD00C0BCBD00C0BCBD00C3C0C100DEDEDD00F4F4F400FCFCFC00FFFFFF00}
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnLastMesClick
      end
    end
  end
end
