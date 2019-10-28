{******************************************************************************}
{ Jc Components                                                                }
{ Library created inherited from TCustomMaskEdit VCL                                    }
{                                                                              }
{ Copyright(c) 2006 - João Carvalho -                                          }
{ GitHub: https://github.com/joaokvalho                                        }
{                                                                              }
{******************************************************************************
|* Historic
|*
|* 22/06/2006:  João Carvalho
|* - First Version: Creation and Distribution of the First Version
******************************************************************************}

unit JcDateEdit;

interface

uses
  Windows, SysUtils, Messages, Classes, Controls, Forms, Graphics, Menus,
  StdCtrls, Mask, Dialogs, ComCtrls, Grids, ExtCtrls, Buttons, Math,
  dateUtils, JcCustomClass;

type
  TRangeCentury = 0..99;
  TJcDateEdit = class(TJcCustomMaskEdit)
  private
    FAlignment: TAlignment;
    FAssumeDefault: Boolean;
    FAutoHideCalendar: Boolean;
    FBaseChar: Char;
    FButton: TSpeedButton;
    FCanvas: TControlCanvas;
    FCentury: Boolean;
    FDate: TDateTime;
    FFocused: Boolean;
    FGlyph: TBitmap;
    FHintBtn: string;
    FShowButton: Boolean;
    FWinBack: TWinControl;
    FOverCentury: TRangeCentury;
    FOnBtnClick: TNotifyEvent;
    FOnDateError: TNotifyEvent;
    FReadOnly: Boolean;
    procedure ButtonClick(Sender: TObject);
    procedure ChangeGlyph(Sender: TObject);
    procedure CreateButton;
    procedure DateChange;
    procedure DateError;
    procedure DecodeStrDate(ADate: string; var Year, Month, Day: Word);
    procedure SetAlignment(Alig: TAlignment);
    procedure SetBaseChar(C: Char);
    procedure SetButtonSize;
    procedure SetCentury(Bool: Boolean);
    procedure SetDateText(S: string);
    procedure SetDateValue(ADate: TDateTime);
    procedure SetEnabledBtn(Value: Boolean);
    procedure SetGlyph(Value: TBitmap);
    procedure SetHintBtn(Value: string);
    procedure SetMask;
    procedure SetShowButton(const Value: Boolean);
    procedure SetShowCaret;
    procedure CMEnter(var Msg: TCMEnter); message CM_ENTER;
    procedure CMExit(var Msg: TCMExit); message CM_EXIT;
    procedure WMMouse(var Msg: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMSetFocus(var Msg: TMessage); message WM_SETFOCUS;
    function AssumeDefaultDate(ADate: string): string;
    function DaysInMonth(Month, Year: Integer): Integer;
    function ExtractInvalidChar(S: string): string;
    function FormatStrDate(S: string): string;
    function GetCursorHeight: Integer;
    function GetDateInStr(S: string): TDateTime;
    function GetDateText: string;
    function GetDateValue: TDateTime;
    function GetEditMask: string;
    function GetEnabledBtn: Boolean;
    function GetFormatMask: string;
    function GetMemberDate(S: string; Memb: Integer): string;
    function IsEmptyDate(S: string): Boolean;
    function IsLeapYear(Year: Word): Boolean;
    function IsValidDate(S: string): Boolean;
    function NoSpaces(S: string): string;
    function Val(S: string): Integer;
    procedure SetReadOnly(const Value: Boolean);
    function GetReadOnly: Boolean;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure setEditRect; override;
    procedure Change; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ShowCalendar;
  published
    property Anchors;
    property Alignment: TAlignment read FAlignment write SetAlignment default
      taLeftJustify;
    property AssumeDefault: Boolean read FAssumeDefault write FAssumeDefault
      default True;
    property AutoHideCalendar: Boolean read FAutoHideCalendar write
      FAutoHideCalendar default True;
    property AutoSelect;
    property AutoSize;
    property BaseChar: Char read FBaseChar write SetBaseChar default '_';
    property BorderStyle;
    property Century: Boolean read FCentury write SetCentury default True;
    property Color;
    property Constraints;
    property Ctl3D;
    property DateText: string read GetDateText write SetDateText;
    property DateValue: TDateTime read GetDateValue write SetDateValue;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property EnabledBtn: Boolean read GetEnabledBtn write SetEnabledBtn default
      True;
    property Font;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property HideSelection;
    property HintBtn: string read FHintBtn write SetHintBtn;
    property OverCentury: TRangeCentury read FOverCentury write FOverCentury
      default 0;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
    property ShowHint;
    property ShowButton: Boolean read FShowButton write SetShowButton default
      False;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnBtnClick: TNotifyEvent read FOnBtnClick write FOnBtnClick;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDateError: TNotifyEvent read FOnDateError write FOnDateError;
    property OnDblClick;
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

  TSFormDateEdit = class(TForm)
    PanBack: TPanel;
    LblTitle: TLabel;
    StrGrid: TStringGrid;
    P_Middle: TPanel;
    LblMonth: TLabel;
    BtnLastAno: TSpeedButton;
    BtnNextAno: TSpeedButton;
    BtnNextMes: TSpeedButton;
    BtnLastMes: TSpeedButton;
    procedure StrGridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StrGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure BtnNextAnoClick(Sender: TObject);
    procedure BtnNextMesClick(Sender: TObject);
    procedure BtnLastMesClick(Sender: TObject);
    procedure BtnLastAnoClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StrGridKeyPress(Sender: TObject; var Key: Char);
    procedure StrGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StrGridClick(Sender: TObject);
    procedure StrGridDblClick(Sender: TObject);
    procedure PanMonthMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanMonthMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormDeactivate(Sender: TObject);
  private
    FActiveDate: TDate;
    FBackColor: TColor;
    FChangingCel: Boolean;
    FLastX: Integer;
    FLastY: Integer;
    FOnwerEdt: TJcDateEdit;
    FTextColor: TColor;
    procedure MonthChanged;
    procedure SetColors(TextColor, BackColor: TColor);
    function BeginOfMonth(ADate: TDate): TDate;
    function Month(ADate: TDate): Word;
  end;

var
  SIGDataFormDateEdit: TSFormDateEdit;

procedure Register;

implementation

{$J+}
{$R *.RES}
{$R *.DFM}

const
  EMPTYDATE = -693594;
  IMAGE_RES = 'SDDATEEDIT';

procedure Register;
begin
  RegisterComponents('Jc Components', [TJcDateEdit]);
end;

type
  TBtnDateEdit = class(TSpeedButton)
  private
    FCanvas: TControlCanvas;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

constructor TBtnDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
end;

destructor TBtnDateEdit.Destroy;
begin
  FCanvas.Free;
  inherited Destroy;
end;

procedure TBtnDateEdit.Paint;
var
  R: TRect;
begin
  inherited;
  if FState = bsUp then
    begin
      R := ClientRect;
      Frame3D(FCanvas, R, clBtnHighLight, clWindowFrame, 1);
      Frame3D(FCanvas, R, clBtnFace, clBtnShadow, 1);
    end;
end;


constructor TJcDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
  BorderStyle := esModern;
  TControlCanvas(FCanvas).Control := Self;
  Font.Name := 'Tahoma';
  Font.Size := 10;
  Width     := 100;
  Height    := 21;
  ControlStyle := ControlStyle - [csSetCaption];
  FAssumeDefault := True;
  FAutoHideCalendar := True;
  FBaseChar := '_';
  FCentury := True;
  FFocused := False;
  FOverCentury := 0;
  FShowButton := True;
  SetDateValue(Now);
  CreateButton;
end;

destructor TJcDateEdit.Destroy;
begin
  FGlyph.Free;
  FButton.Free;
  FWinBack.Free;
  FCanvas.Free;
  inherited Destroy;
end;

procedure TJcDateEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[Boolean, TAlignment] of DWORD =
  ((ES_LEFT, ES_RIGHT, ES_CENTER), (ES_RIGHT, ES_LEFT, ES_CENTER));
begin
  inherited CreateParams(Params);

  with Params do
  begin
    Style := Style or Alignments[UseRightToLeftAlignment, FAlignment];
  end;
end;

procedure TJcDateEdit.CreateWnd;
begin
  inherited CreateWnd;
  setEditRect;
end;

procedure TJcDateEdit.SetAlignment(Alig: TAlignment);
begin
  if Alig <> FAlignment then
    begin
      FAlignment := Alig;
      RecreateWnd;
      if Focused then
        SelectAll;
    end;
end;

procedure TJcDateEdit.SetBaseChar(C: Char);
begin
  if (C <> FBaseChar) and (C <> #0) then
  begin
    FBaseChar := C;
    if not (csDesigning in ComponentState) then
      SetMask;
    DateChange;
    Invalidate;
  end;
end;

procedure TJcDateEdit.SetCentury(Bool: Boolean);
begin
  if Bool <> FCentury then
  begin
    FCentury := Bool;
    if not (csDesigning in ComponentState) then
      SetMask;
    DateChange;
    Invalidate;
  end;
end;

procedure TJcDateEdit.SetDateText(S: string);
begin
  FDate := GetDateInStr(FormatStrDate(S));
  DateChange;
end;

procedure TJcDateEdit.SetDateValue(ADate: TDateTime);
begin
  FDate := ADate;
  DateChange;
end;

procedure TJcDateEdit.setEditRect;
var
  EditRec: TRect;
begin
  inherited setEditRect;
  if (not (csloading in ComponentState)) then
  begin
    SendMessage(Handle, EM_GETRECT, 0, LongInt(@EditRec));
    if BorderStyle <> esSingle then
    begin
      EditRec.Bottom := ClientHeight + 1;
      EditRec.Right := (ClientWidth - Height);
      EditRec.Top := 3;
      EditRec.Left := 4;
    end
    else
      EditRec.Right := (ClientWidth - Height) + 4;
    SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@EditRec));
  end;
end;

function TJcDateEdit.GetDateText: string;
begin
  Result := FormatDateTime(GetFormatMask, FDate)
end;

function TJcDateEdit.GetDateValue: TDateTime;
begin
  Result := FDate;
end;

procedure TJcDateEdit.SetGlyph(Value: TBitmap);
begin
  if Value = nil then
    FGlyph.Handle := LoadBitmap(HInstance, IMAGE_RES)
  else
    FGlyph.Assign(Value);
end;

procedure TJcDateEdit.ChangeGlyph(Sender: TObject);
var
  NG: Byte;
begin
  FButton.Glyph := FGlyph;
  NG := 1;
  if not FGlyph.Empty then
    if (FGlyph.Width mod FGlyph.Height) = 0 then
    begin
      NG := FGlyph.Width div FGlyph.Height;
      if NG > 4 then
        NG := 1;
    end;
  FButton.NumGlyphs := NG;
end;

function TJcDateEdit.GetEnabledBtn: Boolean;
begin
  Result := (FButton <> nil) and FButton.Enabled;
end;

procedure TJcDateEdit.SetEnabledBtn(Value: Boolean);
begin
  if FButton <> nil then
    FButton.Enabled := Value;
end;

procedure TJcDateEdit.SetHintBtn(Value: string);
begin
  if FHintBtn <> Value then
    begin
      FHintBtn := Value;
      FButton.Hint := Value;
    end;
end;

procedure TJcDateEdit.SetShowButton(const Value: Boolean);
begin
  //  FButton.Enabled := not ReadOnly;

  FShowButton := Value;
  if not FShowButton then
  begin
    FWinBack.SetBounds(0, 0, 0, 0);
    FButton.SetBounds(0, 0, 0, 0);
  end
  else
    SetButtonSize;
  Invalidate;
end;

procedure TJcDateEdit.Change;
begin
  FDate := GetDateInStr(FormatStrDate(Text));
  inherited;
end;

procedure TJcDateEdit.DateChange;
begin
  if FDate <> EMPTYDATE then
  begin
    if FFocused then
      Text := FormatDateTime(GetFormatMask, FDate)
    else
      EditText := FormatDateTime(GetFormatMask, FDate);
  end
  else
  begin
    EditMask := '';
    if csDesigning in ComponentState then
      EditText := Name
    else
      EditText := '';
  end;
  if Focused then
    SelectAll;
end;

procedure TJcDateEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;

end;

procedure TJcDateEdit.KeyPress(var Key: Char);
var
  Form: TCustomForm;
begin
  if Ord(Key) in [VK_ESCAPE, VK_RETURN] then
  begin
    Form := GetParentForm(Self);
    if Form <> nil then
      PostMessage(Form.Handle, CN_KEYDOWN, Ord(Key), 1);
    Key := #0;
  end
  else if (Key in ['c', 'C']) and FButton.Enabled then
  begin
    FButton.OnClick(FButton);
    Key := #0;
  end
  else if Key = '.' then
    Key := FormatSettings.DateSeparator;
  inherited KeyPress(Key);
end;

procedure TJcDateEdit.CMEnter(var Msg: TCMEnter);
begin
  if not FFocused then
    SetMask;
  inherited;
  SelectAll;
  FFocused := True;
  Invalidate;
end;

procedure TJcDateEdit.CMExit(var Msg: TCMExit);
var
  S: string;
begin
  S := FormatStrDate(Text);
  if (not IsValidDate(S)) and (not IsEmptyDate(S)) then
    begin
      if FAssumeDefault then
        Text := AssumeDefaultDate(S)
      else
        begin
          DateError;
          Exit;
        end;
    end
  else
    begin
      if not IsEmptyDate(S) then
        Text := AssumeDefaultDate(S);
      FFocused := False;
    end;
  FDate := GetDateInStr(Text);
  InvaliDate;
  inherited;
end;

procedure TJcDateEdit.WMMouse(var Msg: TWMMouse);
begin
  if not Focused then
    begin
      inherited;
      SelectAll;
    end
  else
    inherited;
end;

procedure TJcDateEdit.WMPaint(var Msg: TWMPaint);
begin
  inherited;
  TControlCanvas(FCanvas).UpdateTextFlags;
end;

procedure TJcDateEdit.WMSize(var Msg: TWMSize);
begin
  inherited;
  SetButtonSize;
end;

procedure TJcDateEdit.WMSetFocus(var Msg: TMessage);
begin
  inherited;
  SetShowCaret;
end;

procedure TJcDateEdit.SetShowCaret;
begin
  CreateCaret(Handle, 0, 1, GetCursorHeight);
  ShowCaret(Handle);
end;

function TJcDateEdit.GetCursorHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  try
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
  end;
  Result := Metrics.tmHeight;
end;

function TJcDateEdit.FormatStrDate(S: string): string;
var
  D, M, Y: Word;
  Day, Month, Year: string;
begin
  S := ExtractInvalidChar(S) + FormatSettings.DateSeparator + FormatSettings.DateSeparator;
  Day := '00' + GetMemberDate(S, 1);
  Day := Copy(Day, Length(Day) - 1, 2);
  Month := '00' + GetMemberDate(S, 2);
  Month := Copy(Month, Length(Month) - 1, 2);
  Year := GetMemberDate(S, 3);
  if Year = '' then
    Year := '0000';
  DecodeDate(Date, Y, M, D);
  if (FOverCentury > 0) and (StrToInt(Year) > FOverCentury) and
    (Length(Year) < 3) then
    Y := Y - 100;
  Year := Copy(IntToStr(Y), 1, 4 - Length(Year)) + Year;
  Result := Day + FormatSettings.DateSeparator + Month + FormatSettings.DateSeparator + Year;
end;

function TJcDateEdit.ExtractInvalidChar(S: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(S) do
    if S[I] in ['0'..'9', FormatSettings.DateSeparator] then
      Result := Result + S[I];
end;

function TJcDateEdit.GetMemberDate(S: string; Memb: Integer): string;
var
  I, F, M: Integer;
begin
  I := 1;
  F := 1;
  M := 0;
  while Memb > M do
    begin
      while (F <= Length(S)) and (S[F] <> FormatSettings.DateSeparator) do
        Inc(F);
      Inc(M);
      if Memb > M then
        begin
          Inc(F);
          I := F;
        end;
    end;
  Result := Copy(S, I, F - I);
end;

function TJcDateEdit.GetReadOnly: Boolean;
begin
 inherited;

  Result := FReadOnly;
end;

function TJcDateEdit.GetDateInStr(S: string): TDateTime;
var
  Day, Month, Year: Word;
begin
  if IsEmptyDate(S) then
    Result := EMPTYDATE
  else
    begin
      if not IsValidDate(S) then
        Result := EMPTYDATE
      else
        begin
          DecodeStrDate(S, Year, Month, Day);
          Result := EncodeDate(Year, Month, Day);
        end;
    end;
end;

function TJcDateEdit.IsValidDate(S: string): Boolean;
var
  Day, Month, Year: Word;
begin
  DecodeStrDate(S, Year, Month, Day);
  if (Day = 0) or (Month = 0) or (Month > 12)
    or (Day > DaysInMonth(Month, Year)) or (Year = 0) then
    Result := False
  else
    Result := True;
end;

procedure TJcDateEdit.SetMask;
var
  OldTime: TDateTime;
  S: string;
begin
  S := FormatStrDate(Text);
  OldTime := GetDateInStr(S);
  Text := '';
  EditMask := GetEditMask;
  if OldTime <> EMPTYDATE then
    Text := FormatDateTime(GetFormatMask, OldTime)
  else
    Text := '';
end;

function TJcDateEdit.GetFormatMask: string;
begin
  Result := 'dd'+ FormatSettings.DateSeparator + 'mm' + FormatSettings.DateSeparator + 'yy';
  if FCentury then
    Result := Result + 'yy';
end;

function TJcDateEdit.GetEditMask: string;
begin
  Result := '!99'+ FormatSettings.DateSeparator + '99' + FormatSettings.DateSeparator + '99';
  if FCentury then
    Result := Result + '99';
  Result := Result + ';1;' + FBaseChar;
end;

function TJcDateEdit.DaysInMonth(Month, Year: Integer): Integer;
const
  Days = '312831303130313130313031';
begin
  Result := Val(Copy(Days, (Month * 2) -1, 2));
  if (Month = 2) and IsLeapYear(Year) then
    Result := 29;
end;

function TJcDateEdit.IsLeapYear(Year: Word): Boolean;
begin
  Result := (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0));
end;

function TJcDateEdit.IsEmptyDate(S: string): Boolean;
var
  I: Integer;
  N: string;
begin
  N := '';
  for I := 1 to Length(S) do
    if S[I] in ['1'..'9'] then
      N := N + S[I];
  if N = '' then
    Result := True
  else
    Result := False;
end;

function TJcDateEdit.AssumeDefaultDate(ADate: string): string;
var
  AtDay, AtMonth, AtYear: Word;
  Day, Month, Year: Word;
begin
  DecodeDate(Date, AtYear, AtMonth, AtDay);
  DecodeStrDate(ADate, Year, Month, Day);
  if Year = 0 then
    Year := AtYear;
  if Month = 0 then
    Month := AtMonth
  else if Month > 12 then
    Month := 12;
  if Day = 0 then
    Day := AtDay
  else if Day > DaysInMonth(Month, Year) then
    Day := DaysInMonth(Month, Year);
  Result := FormatDateTime(GetFormatMask, EncodeDate(Year, Month, Day))
end;

procedure TJcDateEdit.DecodeStrDate(ADate: string; var Year, Month, Day: Word);
var
  D, M, Y: Word;
begin
  Day := Val(Copy(ADate, 1, 2));
  Month := Val(Copy(ADate, 4, 2));
  Year := Val(Copy(ADate, 7, 4));
  if Length(ADate) = 8 then
    begin
      DecodeDate(Date, Y, M, D);
      Year := Year + ((Y div 100) * 100);
    end;
end;

function TJcDateEdit.Val(S: string): Integer;
begin
  S := NoSpaces(S);
  if S = '' then
    Result := 0
  else
    Result := StrToInt(S);
end;

function TJcDateEdit.NoSpaces(S: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(S) do
    if S[I] <> ' ' then
      Result := Result + S[I];
end;

procedure TJcDateEdit.DateError;
begin
  if Assigned(FOnDateError) then
    FOnDateError(Self)
  else
    MessageBeep(0);
  SelectAll;
  SetFocus;
end;

procedure TJcDateEdit.CreateButton;
begin
  FWinBack := TWinControl.Create(Self);
  FWinBack.Parent := Self;
  TEdit(FWinBack).Color := clBtnFace;
  FButton := TSpeedButton.Create(Self);
  FButton.Align := alClient;
  FButton.Flat := True;
  FButton.Parent := FWinBack;
  FButton.Parent.Brush.Color := clWhite;
  FButton.OnClick := ButtonClick;
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := ChangeGlyph;
  FGlyph.Handle := LoadBitmap(HInstance, IMAGE_RES);
end;

procedure TJcDateEdit.SetButtonSize;
var
  ButtonHeight: Integer;
begin
  if FShowButton then
  begin
    if BorderStyle = esModern then
    begin
      ButtonHeight := Height - 3;
      FWinBack.SetBounds(((Width - ButtonHeight) - 1), 2, ButtonHeight,
        ButtonHeight)
    end
    else
    begin
      ButtonHeight := Height - 5;
      FWinBack.SetBounds(((Width - ButtonHeight) - 4), 0, ButtonHeight,
        ButtonHeight);
    end;
  end
  else
  begin
    FWinBack.SetBounds(0, 0, 0, 0);
    FButton.SetBounds(0, 0, 0, 0);
  end;
end;

procedure TJcDateEdit.ButtonClick(Sender: TObject);
begin
  if Assigned(FOnBtnClick) then
    FOnBtnClick(Self)
  else
    ShowCalendar;
end;

procedure TJcDateEdit.ShowCalendar;
var
  Pos: TPoint;
begin

  if SIGDataFormDateEdit = nil then
    Application.CreateForm(TSFormDateEdit, SIGDataFormDateEdit);

  Pos := Point(0, 0);
  Pos := Self.ClientToScreen(Pos);
  if (Pos.X + 179) > Screen.DesktopWidth then
    SIGDataFormDateEdit.Left := Pos.X - (SIGDataFormDateEdit.Width - Width) - 2
  else
    SIGDataFormDateEdit.Left := Pos.X - 2;
  if (Pos.Y + 131) > Screen.DesktopHeight then
    SIGDataFormDateEdit.Top := Pos.Y - SIGDataFormDateEdit.Height - 2
  else
    SIGDataFormDateEdit.Top := Pos.Y + Height - 3;
  SIGDataFormDateEdit.FOnwerEdt := Self;
  if GetDateValue = EMPTYDATE then
    SIGDataFormDateEdit.FActiveDate := Date
  else
    SIGDataFormDateEdit.FActiveDate := GetDateValue;
  SIGDataFormDateEdit.MonthChanged;
  SIGDataFormDateEdit.Show;
end;

procedure TJcDateEdit.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;

  if FButton <> nil then
    FButton.Enabled := not FReadOnly;

  inherited ReadOnly := Value;
end;

procedure TSFormDateEdit.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  FChangingCel := False;
  for I := 0 to 6 do
    StrGrid.Cells[I, 0] := FormatSettings.ShortDayNames[I + 1];
end;

procedure TSFormDateEdit.FormDeactivate(Sender: TObject);
begin

  LblTitle.Font.Color := clInactiveCaptionText;

  if FOnwerEdt.AutoHideCalendar then
    Close;
end;

procedure TSFormDateEdit.SetColors(TextColor, BackColor: TColor);
begin
  FTextColor := TextColor;
  FBackColor := BackColor;
end;

procedure TSFormDateEdit.StrGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  S: string;
  X, Y: Integer;
begin
  if gdFixed in State then
    SetColors(clActiveCaption, clWhite)
  else if (gdSelected in State) then
    SetColors(clCaptionText, clActiveCaption)
  else
    SetColors(clWindowText, clWindow);
  if not (gdFixed in State ) and
    (Month(Integer(StrGrid.Objects[ACol, ARow])) <> Month(FActiveDate)) then
    SetColors(clGrayText, FBackColor);
  with StrGrid do
    begin
      S := Cells[ACol, ARow];
      X := Rect.Left + ((DefaultColWidth - Canvas.TextWidth(S)) div 2);
      Y := Rect.Top + ((DefaultRowHeight - Canvas.TextHeight(S)) div 2);
      Canvas.Brush.Color := FBackColor;
      Canvas.Font.Color := FTextColor;
      Canvas.TextRect(Rect, X, Y, S);
    end;
end;

function TSFormDateEdit.BeginOfMonth(ADate: TDate): TDate;
var
  Y, M, D: Word;
begin
  DecodeDate(ADate, Y, M, D);
  Result := EncodeDate(Y, M, 1);
end;

procedure TSFormDateEdit.MonthChanged;
var
  I, J, K: Integer;
  X, Y: Byte;
  S: string;
begin
  I := DayOfWeek(BeginOfMonth(FActiveDate));
  J := Trunc(BeginOfMonth(FActiveDate)) - I + 1;
  for K := 0 to 41 do
    begin
      X := K mod 7;
      Y := (K div 7) + 1;
      StrGrid.Cells[X, Y] := FormatDateTime('d', J + K);
      StrGrid.Objects[X, Y] := TObject(J + K);
    end;
  S := FormatDateTime('mmmm/yyyy', FActiveDate);
  S[1] := Char(Ord(S[1]) - 32);
  LblMonth.Caption := S;
  LblMonth.Refresh;
  FChangingCel := True;
  K := Trunc(FActiveDate - J);
  StrGrid.Col := K mod 7;
  StrGrid.Row := (K div 7) + 1;
  FChangingCel := False;
end;

function TSFormDateEdit.Month(ADate: TDate): Word;
var
  Y, M, D: Word;
begin
  DecodeDate(ADate, Y, M, D);
  Result := M;
end;

procedure TSFormDateEdit.StrGridClick(Sender: TObject);
var
  I: Integer;
begin
  if not FChangingCel then
    begin
      I := Integer(StrGrid.Objects[StrGrid.Col, StrGrid.Row]);
      if Month(FActiveDate) <> Month(I) then
        begin
          FActiveDate := I;
          MonthChanged;
        end
      else
        FActiveDate := I;
    end;
end;

procedure TSFormDateEdit.PanMonthMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FLastX := X;
  FLastY := Y;
end;

procedure TSFormDateEdit.PanMonthMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
    begin
      Left := Left + (X - FLastX);
      Top := Top + (Y - FLastY);
    end;
end;

procedure TSFormDateEdit.StrGridDblClick(Sender: TObject);
begin
  FOnwerEdt.DateValue := FActiveDate;
  FOnwerEdt.SetFocus;
  FOnwerEdt.SelectAll;
  TSFormDateEdit(FOnwerEdt).Close;
end;

procedure TSFormDateEdit.StrGridKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(VK_ESCAPE) then
    Close
  else if Key = Chr(VK_RETURN) then
    StrGridDblClick(Self)
end;

procedure TSFormDateEdit.BtnOKClick(Sender: TObject);
begin
   StrGridDblClick(Sender);
end;

procedure TSFormDateEdit.BtnLastAnoClick(Sender: TObject);
var
  Y, M, D: Word;
const
  AInc: array[0..1] of Integer = (-1, 1);
begin
  DecodeDate(FActiveDate, Y, M, D);
  Y := Y + AInc[TComponent(Sender).Tag];
  D := Min(D, MonthDays[IsLeapYear(Y), M]);
  FActiveDate := EncodeDate(Y, M, D);
  MonthChanged;
end;

procedure TSFormDateEdit.BtnLastMesClick(Sender: TObject);
var
  Y, M, D: Word;
const
  AInc: array[0..1] of Integer = (-1, 1);
begin
  DecodeDate(FActiveDate, Y, M, D);
  M := M + AInc[TComponent(Sender).Tag];
  if M > 12 then
  begin
    M := 1;
    Inc(Y);
  end
  else if M < 1 then
  begin
    M := 12;
    Dec(Y);
  end;
  D := Min(D, MonthDays[IsLeapYear(Y), M]);
  FActiveDate := EncodeDate(Y, M, D);
  MonthChanged;
end;

procedure TSFormDateEdit.BtnNextMesClick(Sender: TObject);
var
  Y, M, D: Word;
const
  AInc: array[0..1] of Integer = (+1, 1);
begin
  DecodeDate(FActiveDate, Y, M, D);
  M := M + AInc[TComponent(Sender).Tag];
  if M > 12 then
  begin
    M := 1;
    Inc(Y);
  end
  else if M < 1 then
  begin
    M := 12;
    Dec(Y);
  end;
  D := Min(D, MonthDays[IsLeapYear(Y), M]);
  FActiveDate := EncodeDate(Y, M, D);
  MonthChanged;
end;

procedure TSFormDateEdit.BtnNextAnoClick(Sender: TObject);
var
  Y, M, D: Word;
const
  AInc: array[0..1] of Integer = (+1, 1);
begin
  DecodeDate(FActiveDate, Y, M, D);
  Y := Y + AInc[TComponent(Sender).Tag];
  D := Min(D, MonthDays[IsLeapYear(Y), M]);
  FActiveDate := EncodeDate(Y, M, D);
  MonthChanged;
end;

procedure TSFormDateEdit.FormActivate(Sender: TObject);
begin
  LblTitle.Font.Color := clWhite;
end;

procedure TSFormDateEdit.StrGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FLastX := X;
  FLastY := Y;
end;

procedure TSFormDateEdit.StrGridMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   if ssLeft in Shift then
  begin
    Left := Left + (X - FLastX);
    Top := Top + (Y - FLastY);
  end;
end;

end.
