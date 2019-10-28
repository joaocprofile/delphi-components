{******************************************************************************}
{ Jc Components                                                                }
{ Library created inherited from TCustomControl VCL                                    }
{                                                                              }
{ Copyright(c) 2006 - João Carvalho -                                          }
{ GitHub: https://github.com/joaokvalho                                        }
{                                                                              }
{******************************************************************************
|* Historic
|*
|* 10/06/2006:  João Carvalho
|* - First Version: Creation and Distribution of the First Version
******************************************************************************}

unit JcButton;

interface

uses
  Windows, Vcl.Forms, Messages, SysUtils, Classes, Controls, Graphics, Buttons,
  ActnList, StrUtils;

type
  TCaptionAlign = (acLeft, acRight, acCenter);
  TBtnState = (bsNormal, bsOver, bsDown);
  TButtonLayout = (blGlyphLeft, blGlyphRight, blGlyphTop, blGlyphBottom);

  TColorScheme = (csDefault, csBlue, csGray, csGreen, csRed, csCustom);

  TJcButton = class(TCustomControl)
  private
    FColorFace: TColor;
    FColorGrad: TColor;
    FColorBorder: TColor;
    FColorLight: TColor;
    FColorDark: TColor;
    FColorText: TColor;
    FOverColorFace: TColor;
    FOverColorGrad: TColor;
    FOverColorBorder: TColor;
    FOverColorLight: TColor;
    FOverColorDark: TColor;
    FOverColorText: TColor;
    FDownColorFace: TColor;
    FDownColorGrad: TColor;
    FDownColorBorder: TColor;
    FDownColorLight: TColor;
    FDownColorDark: TColor;
    FDownColorText: TColor;
    FDisabledColorFace: TColor;
    FDisabledColorGrad: TColor;
    FDisabledColorBorder: TColor;
    FDisabledColorLight: TColor;
    FDisabledColorDark: TColor;
    FDisabledColorText: TColor;
    FColorFocusRect: TColor;
    FFocused: Boolean;

    FColorScheme: TColorScheme;
    FCtl3D: boolean;
    FLayout: TButtonLayout;
    FGlyph: TBitmap;
    FTransparentGlyph: Boolean;
    FGradient: Boolean;
    FSpacing: integer;
    FModalResult: TModalResult;
    FCancel: Boolean;
    FCaptionAlign: TCaptionAlign;
    FDefault: Boolean;
    FHotTrack: Boolean;
    FClicked: Boolean;
    procedure SetColors(Index: integer; Value: TColor);
    procedure SetColorScheme(Value: TColorScheme);
    procedure SetCtl3D(Value: Boolean);
    procedure SetLayout(Value: TButtonLayout);
    procedure SetGlyph(Value: TBitmap);
    procedure SetTransparentGlyph(Value: Boolean);
    procedure SetGradient(Value: Boolean);
    procedure SetSpacing(Value: Integer);
    procedure SetModalResult(Value: TModalResult);
    procedure SetDefault(Value: Boolean);
    procedure GradientFillRect(Canvas: TCanvas; Rect: TRect;
                   StartColor, EndColor: TColor);
    procedure SetCaptionAlign(const Value: TCaptionAlign);
protected
    FBtnState: TBtnState;
    procedure Paint; override;
    procedure MouseEnter(var msg: TMessage); message CM_MOUSEENTER;
    procedure MouseLeave(var msg: TMessage); message CM_MOUSELEAVE;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove (Shift: TShiftState; X, Y: Integer); override;
    procedure WMSetFocus(var msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMKeyUp(var msg: TWMKeyUp); message WM_KEYUP;
    procedure WMKeyDown(var msg: TWMKeyDown); message WM_KEYDOWN;
    procedure CMDialogKey(var msg: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMDialogChar(var msg: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMTextChanged (var msg: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var msg: TMessage); message CM_FONTCHANGED;
    procedure CMEnabledChanged (var msg: TMessage); message CM_ENABLEDCHANGED;
    function GetColorScheme: TStringList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
  published
    property ColorFace: TColor index 0 read FColorFace write SetColors;
    property ColorGrad: TColor index 1 read FColorGrad write SetColors;
    property ColorDark: TColor index 2 read FColorDark write SetColors;
    property ColorLight: TColor index 3 read FColorLight write SetColors;
    property ColorBorder: TColor index 4 read FColorBorder write SetColors;
    property ColorText: TColor index 5 read FColorText write SetColors;
    property OverColorFace: TColor index 6 read FOverColorFace write SetColors;
    property OverColorGrad: TColor index 7 read FOverColorGrad write SetColors;
    property OverColorDark: TColor index 8 read FOverColorDark write SetColors;
    property OverColorLight: TColor index 9 read FOverColorLight write SetColors;
    property OverColorBorder: TColor index 10 read FOverColorBorder write SetColors;
    property OverColorText: TColor index 11 read FOverColorText write SetColors;
    property DownColorFace: TColor index 12 read FDownColorFace write SetColors;
    property DownColorGrad: TColor index 13 read FDownColorGrad write SetColors;
    property DownColorDark: TColor index 14 read FDownColorDark write SetColors;
    property DownColorLight: TColor index 15 read FDownColorLight write SetColors;
    property DownColorBorder: TColor index 16 read FDownColorBorder write SetColors;
    property DownColorText: TColor index 17 read FDownColorText write SetColors;
    property DisabledColorFace: TColor index 18 read FDisabledColorFace write SetColors;
    property DisabledColorGrad: TColor index 19 read FDisabledColorGrad write SetColors;
    property DisabledColorDark: TColor index 20 read FDisabledColorDark write SetColors;
    property DisabledColorLight: TColor index 21 read FDisabledColorLight write SetColors;
    property DisabledColorBorder: TColor index 22 read FDisabledColorBorder write SetColors;
    property DisabledColorText: TColor index 23 read FDisabledColorText write SetColors;
    property ColorFocusRect: TColor index 24 read FColorFocusRect write SetColors;
    property ColorScheme: TColorScheme read FColorScheme write SetColorScheme;
    property Ctl3D: Boolean read FCtl3D write SetCtl3D;
    property Layout: TButtonLayout read FLayout write SetLayout;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property Spacing: integer read FSpacing write SetSpacing;
    property TransparentGlyph: Boolean read FTransparentGlyph write SetTransparentGlyph;
    property Gradient: Boolean read FGradient write SetGradient;

    property HotTrack: Boolean read FHotTrack write FHotTrack;
    property Action;
    property Align;
    property Anchors;
    property BiDiMode;
    property Cancel: Boolean read FCancel write FCancel default False;
    property Caption;
    property CaptionAlign: TCaptionAlign read FCaptionAlign write SetCaptionAlign;
    property Constraints;
    property Default: Boolean read FDefault write SetDefault default False;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ModalResult: TModalResult read FModalResult write SetModalResult default 0;
    property ParentBiDiMode;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Jc Components', [TJcButton]);
end;

constructor TJcButton.Create(AOwner: TComponent);
begin
  inherited;
  Width:= 75;
  Height:= 25;
  FCtl3D:= True;
  FGlyph:= TBitmap.Create;
  TransparentGlyph:= True;
  FGradient:= False;
  TabStop:= True;
  FSpacing:= 4;
  FCancel:= False;
  FDefault:= False;
  FHotTrack:= True;
  ColorScheme:= csDefault;
  FClicked:= False;
  FOverColorGrad:= clWhite;
  FDownColorGrad:= clWhite;
  FDisabledColorGrad:= clWhite;
  FColorSCheme := csDefault;
end;

destructor TJcButton.Destroy;
begin
  FreeAndNil(FGlyph);

  inherited;
end;

procedure TJcButton.Paint;
var
  BtnBmp: TBitmap;
  CaptionRect: TRect;
  GlyphLeft, GlyphTop, TextTop, TextLeft, TextWidth, TextHeight: integer;
  FaceColor, GradColor, LightColor, DarkColor, BorderColor, TextColor: TColor;
begin
  LightColor := FColorLight;
  FaceColor :=  FColorFace;
  GradColor := FColorGrad;
  DarkColor := FColorDark;
  BorderColor := FColorBorder;
  TextColor  := FColorText;

  BtnBmp:= TBitmap.Create;
  BtnBmp.Width:= Width;
  BtnBmp.Height:= Height;

  case FBtnState of
    bsNormal: begin
                FaceColor:= FColorFace;
                GradColor:= FColorGrad;
                LightColor:= FColorLight;
                DarkColor:= FColorDark;
                BorderColor:= FColorBorder;
                TextColor:= FColorText;
              end;

    bsOver:   begin
                FaceColor:= FOverColorFace;
                GradColor:= FOverColorGrad;
                LightColor:= FOverColorLight;
                DarkColor:= FOverColorDark;
                BorderColor:= FOverColorBorder;
                TextColor:= FOverColorText;
              end;

    bsDown:   begin
                FaceColor:= FDownColorFace;
                GradColor:= FDownColorGrad;
                LightColor:= FDownColorLight;
                DarkColor:= FDownColorDark;
                BorderColor:= FDownColorBorder;
                TextColor:= FDownColorText;
              end;
  end;
  if not Enabled then begin
    FaceColor:= FDisabledColorFace;
    GradColor:= FDisabledColorGrad;
    LightColor:= FDisabledColorLight;
    DarkColor:= FDisabledColorDark;
    BorderColor:= FDisabledColorBorder;
    TextColor:= FDisabledColorText;
  end;

  with BtnBmp.Canvas do begin
    Brush.Color:= FaceColor;
    Brush.Style:= bsSolid;
    Rectangle(0, 0, Width, Height);
  end;

  if FGradient then
    GradientFillRect(BtnBmp.Canvas, Rect(0, 0, Width, Height), FaceColor, GradColor);

  BtnBmp.Canvas.Font := Font;
  BtnBmp.Canvas.Font.Color:= TextColor;
  TextWidth:= BtnBmp.Canvas.TextWidth(Caption);
  TextHeight:= BtnBmp.Canvas.TextHeight(Caption);
  TextTop:= (Height - TextHeight) div 2;
  TextLeft:= (Width - TextWidth) div 2;

  if not Glyph.Empty then begin
    GlyphLeft := 0;
    GlyphTop := 0;
    case FLayout of
      blGlyphLeft:   begin
                       GlyphTop:= (Height - FGlyph.Height) div 2;
                       GlyphLeft:= TextLeft - FGlyph.Width div 2;
                       inc(TextLeft, FGlyph.Width div 2);
                       if not (Caption = '') then begin
                         GlyphLeft:= GlyphLeft - FSpacing div 2 - FSpacing mod 2;
                         inc(TextLeft, FSpacing div 2);
                       end;
                     end;
      blGlyphRight:  begin
                       GlyphTop:= (Height - FGlyph.Height) div 2;
                       GlyphLeft:= TextLeft + TextWidth - FGlyph.Width div 2;
                       inc(TextLeft, - FGlyph.Width div 2);
                       if not (Caption = '') then begin
                         GlyphLeft:= GlyphLeft + FSpacing div 2 + FSpacing mod 2;
                         inc(TextLeft, - FSpacing div 2);
                       end;
                     end;
      blGlyphTop:    begin
                       GlyphLeft:= (Width - FGlyph.Width) div 2;
                       GlyphTop:= TextTop - FGlyph.Height div 2 - FGlyph.Height mod 2;
                       inc(TextTop, FGlyph.Height div 2);
                       if not (Caption = '') then begin
                         GlyphTop:= GlyphTop - FSpacing div 2 - FSpacing mod 2;
                         inc(TextTop, + FSpacing div 2);
                       end;
                     end;
      blGlyphBottom: begin
                       GlyphLeft:= (Width - FGlyph.Width) div 2;
                       GlyphTop:= TextTop + TextHeight - Glyph.Height div 2;
                       inc(TextTop, - FGlyph.Height div 2);
                       if not (Caption = '') then begin
                         GlyphTop:= GlyphTop + FSpacing div 2 + FSpacing mod 2;
                         inc(TextTop, - FSpacing div 2);
                       end;
                     end;
    end;
    
    if FBtnState = bsDown then begin
      inc(GlyphTop, 1);
      inc(GlyphLeft, 1);
    end;
    FGlyph.TransparentColor:= FGlyph.Canvas.Pixels[0, 0];
    FGlyph.Transparent:= FTransparentGlyph;
    BtnBmp.Canvas.Draw(GlyphLeft, GlyphTop, FGlyph);
  end;
  if FBtnState = bsDown then begin
    inc(TextTop);
    inc(TextLeft);
  end;
  with CaptionRect do begin
    Top:= TextTop;
    Left:=TextLeft;
    Right:= Left + TextWidth;
    Bottom:= Top + TextHeight;
  end;

  if Caption <> '' then begin
    BtnBmp.Canvas.Brush.Style:= bsClear;
    DrawText(BtnBmp.Canvas.Handle,
             PChar(Caption),
             length(Caption),
             CaptionRect,
             DT_CENTER or DT_VCENTER or DT_SINGLELINE or DT_NOCLIP);
  end;

  with BtnBmp.Canvas do begin
    Pen.Style:= psSolid;
    Brush.Color:= FaceColor;
    Pen.Color:= BorderColor;
    Brush.Style:= bsClear;
    Rectangle(0, 0, Width, Height);

    if Ctl3D then begin
      Pen.Color:= LightColor;
      MoveTo(1, Height-2);
      LineTo(1, 1);
      LineTo(Width -1 , 1);

      Pen.Color:= DarkColor;
      MoveTo(Width-2, 1);
      LineTo(Width-2, Height-2);
      LineTo(1, Height-2);
    end;
  end;

  if FFocused then begin
    BtnBmp.Canvas.Pen.Color:= FColorFocusRect;
    BtnBmp.Canvas.Brush.Style:= bsClear;
    BtnBmp.Canvas.Rectangle(3, 3, Width-3, Height-3)
  end;

  Canvas.Draw(0, 0, BtnBmp);
  BtnBmp.Free;
end;

procedure TJcButton.Click;
var
  Form: TCustomForm;
begin
  Form := GetParentForm(Self);
  if (Form <> nil) then
    Form.ModalResult := ModalResult;
  inherited Click;
end;

procedure TJcButton.MouseEnter(var msg: TMessage);
begin
  if csDesigning in ComponentState then exit;
  if not FHotTrack then exit;
  if FClicked then
    FBtnState:= bsDown
  else
    FBtnState:= bsOver;
  Paint;
end;

procedure TJcButton.MouseLeave(var msg: TMessage);
begin
  inherited;
  FBtnState:= bsNormal;
  Paint;
end;

procedure TJcButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button <> mbLeft then Exit;
  FClicked:= True;
  FBtnState:= bsDown;
  if TabStop then SetFocus;
  Paint;
end;

procedure TJcButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FClicked:= False;
  if (x>0) and (y>0) and (x<width) and (y<height) then
    if FHotTrack then FBtnState:= bsOver
  else
    FBtnState:= bsNormal;
  Paint;
end;

procedure TJcButton.MouseMove (Shift: TShiftState; X, Y: Integer);
begin
  inherited;
end;

procedure TJcButton.WMSetFocus(var msg: TWMSetFocus);
begin
  FFocused:= true;
  Paint;
end;

procedure TJcButton.WMKillFocus(var msg: TWMKillFocus);
begin
  FFocused:= false;
  FBtnState:= bsNormal;
  Paint;
end;

procedure TJcButton.WMKeyDown(var msg: TWMKeyDown);
begin
  if msg.CharCode = VK_SPACE then FBtnState:= bsDown;
  if msg.CharCode = VK_RETURN then Click;
  Paint;
end;

procedure TJcButton.WMKeyUp(var msg: TWMKeyUp);
begin
  if (msg.CharCode = VK_SPACE) then begin
    FBtnState:= bsNormal;
    Paint;
    Click;
  end;
end;

procedure TJcButton.CMTextChanged (var msg: TMessage);
begin
  Invalidate;
end;

procedure TJcButton.SetCtl3D(Value: Boolean);
begin
  FCtl3D:= Value;
  Invalidate;
end;

procedure TJcButton.SetLayout(Value: TButtonLayout);
begin
  FLayout:= Value;
  Invalidate;
end;

procedure TJcButton.SetGlyph(Value: TBitmap);
begin
  FGlyph.Assign(Value);
  Invalidate;
end;

procedure TJcButton.SetSpacing(Value: integer);
begin
  FSpacing:= Value;
  Invalidate;
end;

procedure TJcButton.SetTransparentGlyph(Value: Boolean);
begin
  FTransparentGlyph:= Value;
  Invalidate;
end;

procedure TJcButton.SetGradient(Value: Boolean);
begin
  FGradient:= Value;
  Invalidate;
end;

procedure TJcButton.CMFontChanged(var msg: TMessage);
begin
  Invalidate;
end;

procedure TJcButton.CMDialogKey(var msg: TCMDialogKey);
begin
  with msg do begin
    if  (((CharCode = VK_RETURN) and FFocused) or
         ((CharCode = VK_ESCAPE) and FCancel)) and
         (KeyDataToShiftState(KeyData) = []) and CanFocus then
    begin
      Click;
      Result := 1;
    end else if FDefault  then begin
      Click;
      Result := 1;
    end
    else inherited;
  end;
end;

procedure TJcButton.CMEnabledChanged(var msg: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TJcButton.CMDialogChar(var msg: TCMDialogChar);
begin
  with msg do
    if IsAccel(CharCode, Caption) and Enabled then begin
      Click;
      Result := 1;
    end;
end;

procedure TJcButton.SetModalResult(Value: TModalResult);
begin
  FModalResult:= Value;
end;
{
procedure TJcButton.SetCancel(Value: Boolean);
begin
  FCancel:= Value;
end;}

procedure TJcButton.SetDefault(Value: Boolean);
var
  Form: TCustomForm;
begin
  FDefault := Value;
  if HandleAllocated then
  begin
    Form := GetParentForm(Self);
    if Form <> nil then
      Form.Perform(CM_FOCUSCHANGED, 0, Longint(Form.ActiveControl));
  end;
end;

procedure TJcButton.SetCaptionAlign(const Value: TCaptionAlign);
var
  i, W, Space: Integer;
  S: String;
begin
  if FCaptionAlign <> Value then
    FCaptionAlign := Value;

  if trim(Self.Caption) <> '' then
  begin
    Self.Caption := Trim(Self.Caption);

    for I := 0 to 10 do
    begin
      W := Canvas.TextWidth(Self.Caption);
      Space := Self.Width - w;
      space := (space div 10);
      S := DupeString(' ', space);

      case Value of
        acLeft: Self.Caption   := '  '+Self.Caption + S;
        acRight: Self.Caption  := S + Self.Caption+'  ';
        acCenter: Self.Caption := Self.Caption;
      end;
    end;
  end;
end;

procedure TJcButton.SetColors(Index: Integer; Value: TColor);
begin
  case Index of
    0: FColorFace:= Value;
    1: FColorGrad:= Value;
    2: FColorDark:= Value;
    3: FColorLight:= Value;
    4: FColorBorder:= Value;
    5: FColorText:= Value;
    6: FOverColorFace:= Value;
    7: FOverColorGrad:= Value;
    8: FOverColorDark:= Value;
    9: FOverColorLight:= Value;
    10: FOverColorBorder:= Value;
    11: FOverColorText:= Value;
    12: FDownColorFace:= Value;
    13: FDownColorGrad:= Value;
    14: FDownColorDark:= Value;
    15: FDownColorLight:= Value;
    16: FDownColorBorder:= Value;
    17: FDownColorText:= Value;
    18: FDisabledColorFace:= Value;
    19: FDisabledColorGrad:= Value;
    20: FDisabledColorDark:= Value;
    21: FDisabledColorLight:= Value;
    22: FDisabledColorBorder:= Value;
    23: FDisabledColorText:= Value;
    24: FColorFocusRect:= Value;
  end;
  ColorScheme:= csCustom;
  Invalidate;
end;

procedure TJcButton.SetColorScheme(Value: TColorScheme);
begin
  FColorScheme:= Value;
  case FColorScheme of
  csDefault:     begin
                   ColorBorder:= clSilver;
                   ColorFocusRect:=  clWhite;
                   ColorFace:= clWhite;
                   ColorGrad:= clWhite;
                   ColorLight:= clWhite;
                   ColorDark:= clWhite;
                   ColorText:= clGray;

                   OverColorBorder:= clSilver;
                   OverColorFace:= $00EEEEEE;
                   OverColorGrad:= $00EEEEEE;
                   OverColorLight:= $00EEEEEE;
                   OverColorDark:= $00EEEEEE;
                   OverColorText:= clGray;

                   DownColorBorder:= clSilver;
                   DownColorFace:= clWhite;
                   DownColorGrad:= clWhite;
                   DownColorLight:= clWhite;
                   DownColorDark:= clWhite;
                   DownColorText:= clGray;

                   DisabledColorBorder:= clGray;
                   DisabledColorFace:= $00EEEEEE;
                   DisabledColorGrad:= clWhite;
                   DisabledColorLight:= clWhite;
                   DisabledColorDark:= $00D2D2D2;
                   DisabledColorText:= clGray;


                   Gradient:= true;
                 end;
  csBlue:      begin
                   ColorBorder:=$00E9C2AB;
                   ColorDark:=$00FFA054;
                   ColorFace:=$00FFA054;
                   ColorFocusRect:= $00FFA054;
                   ColorGrad:=$00FFA054;
                   ColorLight:=$00FFA054;
                   ColorText:=clWhite;

                   DisabledColorBorder:=$00D2D2D2;
                   DisabledColorDark:=$00EEEEEE;
                   DisabledColorFace:=$00EEEEEE;
                   DisabledColorGrad:=$00EEEEEE;
                   DisabledColorLight:=$00EEEEEE;
                   DisabledColorText:=$00D2D2D2;

                   DownColorBorder:=$00E9C2AB;
                   DownColorDark:=$00FA8C54;
                   DownColorFace:=$00FA8C54;
                   DownColorGrad:=$00FA8C54;
                   DownColorLight:=$00FA8C54;
                   DownColorText:=clWhite;

                   OverColorBorder:=$00E9C2AB;
                   OverColorDark:=$00FA8C54;
                   OverColorFace:=$00FA8C54;
                   OverColorGrad:=$00FA8C54;
                   OverColorLight:=$00FA8C54;
                   OverColorText:=clWhite;

                   Gradient:= True;
                  end;
  csGray:      begin
                   ColorBorder:=$00E9C2AB;
                   ColorDark:=$00A79583;
                   ColorFace:=$00A79583;
                   ColorFocusRect:= $00A79583;
                   ColorGrad:=$00A79583;
                   ColorLight:=$00A79583;
                   ColorText:=clWhite;

                   DisabledColorBorder:=$00D2D2D2;
                   DisabledColorDark:=$00EEEEEE;
                   DisabledColorFace:=$00EEEEEE;
                   DisabledColorGrad:=$00EEEEEE;
                   DisabledColorLight:=$00EEEEEE;
                   DisabledColorText:=$00D2D2D2;

                   DownColorBorder:=$00E9C2AB;
                   DownColorDark:=$00A78B83;
                   DownColorFace:=$00A78B83;
                   DownColorGrad:=$00A78B83;
                   DownColorLight:=$00A78B83;
                   DownColorText:=clWhite;

                   OverColorBorder:=$00E9C2AB;
                   OverColorDark:=$00A78B83;
                   OverColorFace:=$00A78B83;
                   OverColorGrad:=$00A78B83;
                   OverColorLight:=$00A78B83;
                   OverColorText:=clWhite;

                   Gradient:= True;
                end;
  csGreen:      begin
                   ColorBorder:=$00E9C2AB;
                   ColorDark:=$0084AC10;
                   ColorFace:=$0084AC10;
                   ColorFocusRect:= $0084AC10;
                   ColorGrad:=$0084AC10;
                   ColorLight:=$0084AC10;
                   ColorText:=clWhite;

                   DisabledColorBorder:=$00D2D2D2;
                   DisabledColorDark:=$00EEEEEE;
                   DisabledColorFace:=$00EEEEEE;
                   DisabledColorGrad:=$00EEEEEE;
                   DisabledColorLight:=$00EEEEEE;
                   DisabledColorText:=$00D2D2D2;

                   DownColorBorder:=$00E9C2AB;
                   DownColorDark:=$00849610;
                   DownColorFace:=$00849610;
                   DownColorGrad:=$00849610;
                   DownColorLight:=$00849610;
                   DownColorText:=clWhite;

                   OverColorBorder:=$00E9C2AB;
                   OverColorDark:=$00849610;
                   OverColorFace:=$00849610;
                   OverColorGrad:=$00849610;
                   OverColorLight:=$00849610;
                   OverColorText:=clWhite;

                   Gradient:= True;
               end;
  csRed:      begin
                   ColorBorder:=clSilver;
                   ColorDark:=$004F4FFF;
                   ColorFace:=$004F4FFF;
                   ColorFocusRect:= $004F4FFF;
                   ColorGrad:=$004F4FFF;
                   ColorLight:=$004F4FFF;
                   ColorText:=clWhite;

                   DisabledColorBorder:=clSilver;
                   DisabledColorDark:=$00EAEAFF;
                   DisabledColorFace:=$00EAEAFF;
                   DisabledColorGrad:=$00EAEAFF;
                   DisabledColorLight:=$00EAEAFF;
                   DisabledColorText:=clSilver;

                   DownColorBorder:=clGray;
                   DownColorDark:=$003535FF;
                   DownColorFace:=$003535FF;
                   DownColorGrad:=$003535FF;
                   DownColorLight:=$003535FF;
                   DownColorText:=clWhite;

                   OverColorBorder:=clGray;
                   OverColorDark:=$003535FF;
                   OverColorFace:=$003535FF;
                   OverColorGrad:=$003535FF;
                   OverColorLight:=$003535FF;
                   OverColorText:=clWhite;

                   Gradient:= True;
                  end;
  end;
  Invalidate;
  FColorScheme:= Value;
end;



procedure TJcButton.GradientFillRect(Canvas: TCanvas; Rect: TRect;
                StartColor, EndColor: TColor);
var
  Steps: Integer;
  StartR, StartG, StartB, EndR, EndG, EndB: Byte;
  CrrR, CrrG, CrrB: Double;
  IncR, IncG, incB: Double;
  i: integer;
begin
  Steps:= Rect.Bottom - Rect.Top;

  StartR:= GetRValue(StartColor);  EndR:= GetRValue(EndColor);
  StartG:= GetGValue(StartColor);  EndG:= GetGValue(EndColor);
  StartB:= GetBValue(StartColor);  EndB:= GetBValue(EndColor);

  IncR:= (EndR - StartR) / steps;
  IncG:= (EndG - StartG) / steps;
  IncB:= (EndB - StartB) / steps;

  CrrR:= StartR;
  CrrG:= StartG;
  CrrB:= StartB;

  for i:= 0 to Steps do begin
    Canvas.Pen.Color:= RGB(Round(CrrR), Round(CrrG), Round(CrrB));
    Canvas.MoveTo(Rect.Left, i);
    Canvas.LineTo(Rect.Right + Rect.Left, i);
    CrrR:= CrrR + IncR;
    CrrG:= CrrG + IncG;
    CrrB:= CrrB + IncB;
  end;
end;

function TJcButton.GetColorScheme: TStringList;
begin
  Result:= TStringList.Create;
  with Result do begin
    Add('ColorFace:= '+ ColorToString(ColorFace) + ';');
    Add('ColorGrad:= '+ ColorToString(ColorGrad) + ';');
    Add('ColorLight:= '+ ColorToString(ColorLight) + ';');
    Add('ColorDark:= '+ ColorToString(ColorDark) + ';');
    Add('ColorBorder:= '+ ColorToString(ColorBorder) + ';');
    Add('ColorText:= '+ ColorToString(ColorText) + ';');
    Add('OverColorFace:= '+ ColorToString(OverColorFace) + ';');
    Add('OverColorGrad:= '+ ColorToString(OverColorGrad) + ';');
    Add('OverColorLight:= '+ ColorToString(OverColorLight) + ';');
    Add('OverColorDark:= '+ ColorToString(OverColorDark) + ';');
    Add('OverColorBorder:= '+ ColorToString(OverColorBorder) + ';');
    Add('OverColorText:= '+ ColorToString(OverColorText) + ';');
    Add('DownColorFace:= '+ ColorToString(DownColorFace) + ';');
    Add('DownColorGrad:= '+ ColorToString(DownColorGrad) + ';');
    Add('DownColorLight:= '+ ColorToString(DownColorLight) + ';');
    Add('DownColorDark:= '+ ColorToString(DownColorDark) + ';');
    Add('DownColorBorder:= '+ ColorToString(DownColorBorder) + ';');
    Add('DownColorText:= '+ ColorToString(DownColorText) + ';');
    Add('DisabledColorFace:= '+ ColorToString(DisabledColorFace) + ';');
    Add('DisabledColorGrad:= '+ ColorToString(DisabledColorGrad) + ';');
    Add('DisabledColorLight:= '+ ColorToString(DisabledColorLight) + ';');
    Add('DisabledColorDark:= '+ ColorToString(DisabledColorDark) + ';');
    Add('DisabledColorBorder:= '+ ColorToString(DisabledColorBorder) + ';');
    Add('DisabledColorText:= '+ ColorToString(DisabledColorText) + ';');
    Add('ColorFocusRect:=  '+ ColorToString(ColorFocusRect) + ';');
  end;
end;

end.

