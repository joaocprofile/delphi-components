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

unit JcDBDateEdit;

interface

uses
  Windows, SysUtils, Messages, Classes, Controls, Forms, Graphics, Menus,
  StdCtrls, Mask, DB, DBCtrls, Dialogs, ComCtrls, Grids, ExtCtrls,
  Buttons, Math, JcCustomClass;

const
  scF2 = vk_F2;

type
  TRangeCentury = 0..99;
  TJcDBDateEdit = class(TJcCustomMaskEdit)
  private
    FClickKey: TShortCut;
    FAlignment: TAlignment;
    FAssumeDefault: Boolean;
    FAutoHideCalendar: Boolean;
    FBaseChar: Char;
    FButton: TSpeedButton;
    FCanvas: TControlCanvas;
    FCentury: Boolean;
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    FGlyph: TBitmap;
    FHintBtn: string;
    FShowButton: Boolean;
    FWinBack: TWinControl;
    FOverCentury: TRangeCentury;
    FOnBtnClick: TNotifyEvent;
    FOnDateError: TNotifyEvent;
    procedure ButtonClick(Sender: TObject);
    procedure ChangeGlyph(Sender: TObject);
    procedure CreateButton;
    procedure DataChange(Sender: TObject);
    procedure DateError;
    procedure DecodeStrDate(Date: string; var Year, Month, Day: Word);
    procedure EditingChange(Sender: TObject);
    procedure SetBaseChar(C: Char);
    procedure SetButtonSize;
    procedure SetCentury(Bool: Boolean);
    //procedure SetClientRect;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetEnabledBtn(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure SetGlyph(Value: TBitmap);
    procedure SetHintBtn(Value: string);
    procedure SetReadOnly(Value: Boolean);
    procedure SetShowCaret;
    procedure SetShowButton(const Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure CMEnter(var Msg: TCMEnter); message CM_ENTER;
    procedure CMExit(var Msg: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Msg: TMessage); message CM_GETDATALINK;
    procedure WMCut(var Msg: TMessage); message WM_CUT;
    procedure WMMouse(var Msg: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMPaste(var Msg: TMessage); message WM_PASTE;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMSetFocus(var Msg: TMessage); message WM_SETFOCUS;
    function AssumeDefaultDate(ADate: string): string;
    function DaysInMonth(Month, Year: Integer): Integer;
    function ExtractInvalidChar(S: string): string;
    function FormatStrDate(S: string): string;
    function GetCursorHeight: Integer;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetDateInStr(S: string): TDateTime;
    function GetDateValue: TDateTime;
    function GetEditMask: string;
    function GetEnabledBtn: Boolean;
    function GetField: TField;
    function GetMemberDate(S: string; Memb: Integer): string;
    function GetReadOnly: Boolean;
    function IsEmptyDate(S: string): Boolean;
    function IsLeapYear(Year: Word): Boolean;
    function IsValidDate(S: string): Boolean;
    function NoSpaces(S: string): string;
    function Val(S: string): Integer;
  protected
    procedure Change; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure Reset; override;
    function EditCanModify: Boolean; override;
    procedure setEditRect; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetFormatMask: string;
    procedure ShowCalendar;
    property DateValue: TDateTime read GetDateValue;
    property Field: TField read GetField;
  published
    property Anchors;
    property AssumeDefault: Boolean read FAssumeDefault write FAssumeDefault
      default True;
    property AutoHideCalendar: Boolean read FAutoHideCalendar write
      FAutoHideCalendar default True;
    property AutoSelect;
    property AutoSize;
    property BaseChar: Char read FBaseChar write SetBaseChar default '_';
    property BorderStyle;
    property Century: Boolean read FCentury write SetCentury default True;
    property ClickKey: TShortCut read FClickKey write FClickKey
      default scF2;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
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
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
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

  TSFormDBDateEdit = class(TForm)
    PanBack: TPanel;
    StrGrid: TStringGrid;
    P_Middle: TPanel;
    LblMonth: TLabel;
    BtnLastAno: TSpeedButton;
    BtnNextAno: TSpeedButton;
    BtnNextMes: TSpeedButton;
    BtnLastMes: TSpeedButton;
    LblTitle: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnLastAnoClick(Sender: TObject);
    procedure BtnLastMesClick(Sender: TObject);
    procedure BtnNextMesClick(Sender: TObject);
    procedure BtnNextAnoClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StrGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StrGridClick(Sender: TObject);
    procedure StrGridDblClick(Sender: TObject);
    procedure StrGridKeyPress(Sender: TObject; var Key: Char);
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
    FOnwerEdt: TJcDBDateEdit;
    FTextColor: TColor;
    procedure MonthChanged;
    procedure SetColors(TextColor, BackColor: TColor);
    function BeginOfMonth(ADate: TDate): TDate;
    function Month(ADate: TDate): Word;
  end;

var
  SFormDBDateEdit: TSFormDBDateEdit;

procedure Register;

implementation

{$J+}
{$R *.RES}
{$R *.DFM}

const
  EMPTYDATE = -693594;
  IMAGE_RES = 'SDDBDATEEDIT';

procedure Register;
begin
  RegisterComponents('Jc Components', [TJcDBDateEdit]);
end;

type
  TBtnDBDateEdit = class(TSpeedButton)
  private
    FCanvas: TControlCanvas;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

constructor TBtnDBDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
end;

destructor TBtnDBDateEdit.Destroy;
begin
  FCanvas.Free;
  inherited Destroy;
end;

procedure TBtnDBDateEdit.Paint;
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

constructor TJcDBDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  ControlStyle := ControlStyle + [csReplicatable];
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FAssumeDefault := True;
  FAutoHideCalendar := True;
  FBaseChar := '_';
  FCentury := True;
  FFocused := False;
  FOverCentury := 0;
  FShowButton := True;
  FClickKey := scF2;
  Width        := 95;
  Height       := 21;
  Font.Size    := 9;
  Font.Name := 'Tahoma';
  CreateButton;
end;

destructor TJcDBDateEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FGlyph.Free;
  FButton.Free;
  FWinBack.Free;
  FCanvas.Free;
  inherited Destroy;
end;

procedure TJcDBDateEdit.CreateParams(var Params: TCreateParams);
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

procedure TJcDBDateEdit.CreateWnd;
begin
  inherited CreateWnd;
  setEditRect;
end;

procedure TJcDBDateEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then
    DataSource := nil;
end;

procedure TJcDBDateEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
  if not fDataLink.ReadOnly and fDataLink.Edit then
  begin
    inherited KeyDown(Key, Shift);
    if (FClickKey = ShortCut(Key, Shift)) then begin
      ButtonClick(Self);
      Key := 0;
    end;
  end;
end;

procedure TJcDBDateEdit.KeyPress(var Key: Char);
var
  Form: TCustomForm;
begin
  if Ord(Key) in [VK_ESCAPE, VK_RETURN]  then
    begin
      Form := GetParentForm(Self);
      if Form <> nil then
        PostMessage(Form.Handle, CN_KEYDOWN, Ord(Key), 1);
    end
  else if (Key in ['c', 'C']) and FButton.Enabled then
    begin
      FButton.OnClick(FButton);
      Key := #0;
    end
  else if Key = '.' then
    Key := FormatSettings.DateSeparator;
  inherited KeyPress(Key);
  if Key in [^H, ^V, ^X, '0'..'9', FormatSettings.DateSeparator] then
    FDataLink.Edit
  else if Key = #27 then
    begin
      FDataLink.Reset;
      SelectAll;
      Key := #0;
    end;
    
  inherited KeyPress(Key);  
end;

function TJcDBDateEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TJcDBDateEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TJcDBDateEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
    begin
      FFocused := Value;
      if (FAlignment <> taLeftJustify) and (not IsMasked) then
        Invalidate;
      FDataLink.Reset;
    end;
end;

procedure TJcDBDateEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

function TJcDBDateEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TJcDBDateEdit.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
end;

procedure TJcDBDateEdit.setEditRect;
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

function TJcDBDateEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TJcDBDateEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TJcDBDateEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TJcDBDateEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TJcDBDateEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TJcDBDateEdit.SetGlyph(Value: TBitmap);
begin
  if Value = nil then
    FGlyph.Handle := LoadBitmap(HInstance, IMAGE_RES)
  else
    FGlyph.Assign(Value);
end;

procedure TJcDBDateEdit.ChangeGlyph(Sender: TObject);
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

function TJcDBDateEdit.GetEnabledBtn: Boolean;
begin
  Result := (FButton <> nil) and FButton.Enabled;
end;

procedure TJcDBDateEdit.SetEnabledBtn(Value: Boolean);
begin
  if FButton <> nil then
    FButton.Enabled := Value;
end;

procedure TJcDBDateEdit.SetHintBtn(Value: string);
begin
  if FHintBtn <> Value then
    begin
      FHintBtn := Value;
      FButton.Hint := Value;
    end;
end;

procedure TJcDBDateEdit.SetShowButton(const Value: Boolean);
begin
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

procedure TJcDBDateEdit.DataChange(Sender: TObject);
var
  S: string;
  _AfterInsert : TDataSetNotifyEvent;
  _AfterPost   : TDataSetNotifyEvent;
  _AfterCancel : TDataSetNotifyEvent;
  _BeforePost  : TDataSetNotifyEvent;
  _BeforeEdit  : TDataSetNotifyEvent;
  _BeforeDelete: TDataSetNotifyEvent;
begin
  if FDataLink.Field <> nil then
    begin
      if FAlignment <> FDataLink.Field.Alignment then
        begin
          EditText := '';
          FAlignment := FDataLink.Field.Alignment;
          RecreateWnd;
          if Focused then
            PostMessage(Handle, WM_SETFOCUS, 0, 0);
        end;
      _AfterInsert := DataSource.DataSet.AfterInsert;
      _AfterPost   := DataSource.DataSet.AfterPost;
      _AfterCancel := DataSource.DataSet.AfterCancel;
      _BeforePost  := DataSource.DataSet.BeforePost;
      _BeforeEdit  := DataSource.DataSet.BeforeEdit;
      _BeforeDelete:= DataSource.DataSet.BeforeDelete;

      DataSource.DataSet.AfterInsert  := Nil;
      DataSource.DataSet.AfterPost    := Nil;
      DataSource.DataSet.AfterCancel  := Nil;
      DataSource.DataSet.BeforePost   := Nil;
      DataSource.DataSet.BeforeEdit   := Nil;
      DataSource.DataSet.BeforeDelete := Nil;

      EditMask := GetEditMask;

      if FDataLink.Field.Text <> '' then
        S := FormatDateTime(GetFormatMask, FDataLink.Field.AsDateTime)
      else
        S := '';
      if FFocused and FDataLink.CanModify then
        Text := S
      else
        EditText := S;

      DataSource.DataSet.AfterInsert  := _AfterInsert;
      DataSource.DataSet.AfterPost    := _AfterPost;
      DataSource.DataSet.AfterCancel  := _AfterCancel;
      DataSource.DataSet.BeforePost   := _BeforePost;
      DataSource.DataSet.BeforeEdit   := _BeforeEdit;
      DataSource.DataSet.BeforeDelete := _BeforeDelete;
    end
  else
    begin
      EditMask := '';
      if csDesigning in ComponentState then
        begin
          EditText := Name;
          if FAlignment <> taLeftJustify then
            begin
              FAlignment := taLeftJustify;
              RecreateWnd;
            end
        end
      else
        EditText := '';
    end;
  if Focused and not FDataLink.Editing then
    SelectAll;
end;

procedure TJcDBDateEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := (not FDataLink.Editing);
end;

procedure TJcDBDateEdit.UpdateData(Sender: TObject);
var
  S: string;
begin
  ValidateEdit;
  S := FormatStrDate(Text);
  if IsEmptyDate(S) then
    FDataLink.Field.Text := ''
  else if (IsValidDate(S) or FAssumeDefault) then
    FDataLink.Field.Text := AssumeDefaultDate(S)
  else
    begin
      DateError;
      Abort;           
    end;
end;

procedure TJcDBDateEdit.WMPaste(var Msg: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TJcDBDateEdit.WMCut(var Msg: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TJcDBDateEdit.CMEnter(var Msg: TCMEnter);
begin
  SetFocused(True);
  inherited;
  SelectAll;
  Invalidate;
end;

procedure TJcDBDateEdit.CMExit(var Msg: TCMExit);
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
    end;

  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  SetFocused(False);
  CheckCursor;
  DoExit;
end;

procedure TJcDBDateEdit.WMMouse(var Msg: TWMMouse);
begin
  if not Focused then
    begin
      inherited;
      SelectAll;
    end
  else
    inherited;
end;

procedure TJcDBDateEdit.WMPaint(var Msg: TWMPaint);
begin
  inherited;
  TControlCanvas(FCanvas).UpdateTextFlags;
end;

procedure TJcDBDateEdit.WMSize(var Msg: TWMSize);
begin
  inherited;
  SetButtonSize;
end;

procedure TJcDBDateEdit.CMGetDataLink(var Msg: TMessage);
begin
  Msg.Result := Integer(FDataLink);
end;

procedure TJcDBDateEdit.WMSetFocus(var Msg: TMessage);
begin
  inherited;
  SetShowCaret;
end;

procedure TJcDBDateEdit.SetShowCaret;
begin
  CreateCaret(Handle, 0, 1, GetCursorHeight);
  ShowCaret(Handle);
end;

function TJcDBDateEdit.GetCursorHeight: Integer;
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

procedure TJcDBDateEdit.SetCentury(Bool: Boolean);
begin
  FCentury := Bool;
  DataChange(Self);
end;

procedure TJcDBDateEdit.SetBaseChar(C: Char);
begin
  if (C <> #0) then
    begin
      FBaseChar := C;
      DataChange(Self);
    end;
end;

function TJcDBDateEdit.FormatStrDate(S: string): string;
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

function TJcDBDateEdit.ExtractInvalidChar(S: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(S) do
    if S[I] in ['0'..'9', FormatSettings.DateSeparator] then
      Result := Result + S[I];
end;

function TJcDBDateEdit.GetMemberDate(S: string; Memb: Integer): string;
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

function TJcDBDateEdit.GetEditMask: string;
begin
  Result := '!99'+ FormatSettings.DateSeparator + '99' + FormatSettings.DateSeparator + '99';
  if FCentury then
    Result := Result + '99';
  Result := Result + ';1;' + FBaseChar;
end;

function TJcDBDateEdit.GetFormatMask: string;
begin
  Result := 'dd'+ FormatSettings.DateSeparator + 'mm' + FormatSettings.DateSeparator + 'yy';
  if FCentury then
    Result := Result + 'yy';
end;

function TJcDBDateEdit.GetDateInStr(S: string): TDateTime;
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

function TJcDBDateEdit.IsValidDate(S: string): Boolean;
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

function TJcDBDateEdit.DaysInMonth(Month, Year: Integer): Integer;
const
  Days = '312831303130313130313031';
begin
  Result := Val(Copy(Days, (Month * 2) -1, 2));
  if (Month = 2) and IsLeapYear(Year) then
    Result := 29;
end;

function TJcDBDateEdit.IsLeapYear(Year: Word): Boolean;
begin
  Result := (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0));
end;

function TJcDBDateEdit.IsEmptyDate(S: string): Boolean;
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

function TJcDBDateEdit.AssumeDefaultDate(ADate: string): string;
var
  AtDay, AtMonth, AtYear: Word;
  Day, Month, Year: Word;
begin
  DecodeStrDate(ADate, Year, Month, Day);
  DecodeDate(Date, AtYear, AtMonth, AtDay);
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

procedure TJcDBDateEdit.DecodeStrDate(Date: string; var Year, Month, Day: Word);
begin
  Day := Val(Copy(Date, 1, 2));
  Month := Val(Copy(Date, 4, 2));
  Year := Val(Copy(Date, 7, 4));
end;

function TJcDBDateEdit.Val(S: string): Integer;
begin
  S := NoSpaces(S);
  if S = '' then
    Result := 0
  else
    Result := StrToInt(S);
end;

function TJcDBDateEdit.NoSpaces(S: string): string;
var
  I: Integer;
  N: string;
begin
  N := '';
  for I := 1 to Length(S) do
    if S[I] <> ' ' then
      N := N + S[I];
  Result := N;
end;

function TJcDBDateEdit.GetDateValue: TDateTime;
var
  S: string;
begin
  S := FormatStrDate(Text);

  if (not IsValidDate(S)) or IsEmptyDate(S) then
    Result := EMPTYDATE
  else
    Result := GetDateInStr(S);
end;

procedure TJcDBDateEdit.DateError;
begin
  if Assigned(FOnDateError) then
    FOnDateError(Self)
  else
    MessageBeep(0);
  SelectAll;
  SetFocus;
end;

procedure TJcDBDateEdit.CreateButton;
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

procedure TJcDBDateEdit.SetButtonSize;
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

procedure TJcDBDateEdit.ButtonClick(Sender: TObject);
begin
  if not fDataLink.ReadOnly and fDataLink.Edit then
  begin
    if Assigned(FOnBtnClick) then
      FOnBtnClick(Self)
    else
      ShowCalendar;
  end;
end;

procedure TJcDBDateEdit.ShowCalendar;
var
  Pos: TPoint;
begin
  if not FDataLink.DataSource.AutoEdit and not
    (FDataLink.DataSource.State in [dsEdit, dsInsert]) then
    Exit;
  if SFormDBDateEdit = nil then
    Application.CreateForm(TSFormDBDateEdit, SFormDBDateEdit);
  Pos := Point(0, 0);
  Pos := Self.ClientToScreen(Pos);
  if (Pos.X + 179) > Screen.DesktopWidth then
    SFormDBDateEdit.Left := Pos.X - (SFormDBDateEdit.Width - Width) - 2
  else
    SFormDBDateEdit.Left := Pos.X - 2;
  if (Pos.Y + 131) > Screen.DesktopHeight then
    SFormDBDateEdit.Top := Pos.Y - SFormDBDateEdit.Height - 2
  else
    SFormDBDateEdit.Top := Pos.Y + Height - 3;
  SFormDBDateEdit.FOnwerEdt := Self;
  if GetDateValue = EMPTYDATE then
    SFormDBDateEdit.FActiveDate := Date
  else
    SFormDBDateEdit.FActiveDate := GetDateValue;
  SFormDBDateEdit.MonthChanged;
  SFormDBDateEdit.Show;
end;


procedure TSFormDBDateEdit.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  FChangingCel := False;
  for I := 0 to 6 do
    StrGrid.Cells[I, 0] := FormatSettings.ShortDayNames[I + 1];
end;

procedure TSFormDBDateEdit.FormDeactivate(Sender: TObject);
begin

  LblTitle.Font.Color := clInactiveCaptionText;
  if FOnwerEdt.AutoHideCalendar then
    Close;
end;

procedure TSFormDBDateEdit.SetColors(TextColor, BackColor: TColor);
begin
  FTextColor := TextColor;
  FBackColor := BackColor;
end;

procedure TSFormDBDateEdit.StrGridDrawCell(Sender: TObject; ACol,
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

function TSFormDBDateEdit.BeginOfMonth(ADate: TDate): TDate;
var
  Y, M, D: Word;
begin
  DecodeDate(ADate, Y, M, D);
  Result := EncodeDate(Y, M, 1);
end;

procedure TSFormDBDateEdit.MonthChanged;
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

function TSFormDBDateEdit.Month(ADate: TDate): Word;
var
  Y, M, D: Word;
begin
  DecodeDate(ADate, Y, M, D);
  Result := M;
end;

procedure TSFormDBDateEdit.StrGridClick(Sender: TObject);
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

procedure TSFormDBDateEdit.PanMonthMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FLastX := X;
  FLastY := Y;
end;

procedure TSFormDBDateEdit.PanMonthMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
    begin
      Left := Left + (X - FLastX);
      Top := Top + (Y - FLastY);
    end;
end;

procedure TSFormDBDateEdit.StrGridDblClick(Sender: TObject);
begin
  FOnwerEdt.FDataLink.Edit;
  FOnwerEdt.SetFocus;
  FOnwerEdt.Text := FormatDateTime(FOnwerEdt.GetFormatMask, FActiveDate);
  FOnwerEdt.SelectAll;
  Close;
end;

procedure TSFormDBDateEdit.StrGridKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(VK_ESCAPE) then
    BtnCloseClick(Sender)
  else if Key = Chr(VK_RETURN) then
    StrGridDblClick(Self)
end;

procedure TSFormDBDateEdit.BtnOKClick(Sender: TObject);
begin
   StrGridDblClick(Sender);
end;

procedure TSFormDBDateEdit.BtnNextAnoClick(Sender: TObject);
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

procedure TSFormDBDateEdit.BtnNextMesClick(Sender: TObject);
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

procedure TSFormDBDateEdit.BtnLastMesClick(Sender: TObject);
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

procedure TSFormDBDateEdit.BtnLastAnoClick(Sender: TObject);
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

procedure TSFormDBDateEdit.BtnCloseClick(Sender: TObject);
begin
  FOnwerEdt.SetFocus;
  FOnwerEdt.SelectAll;
  Close;
end;

procedure TSFormDBDateEdit.FormActivate(Sender: TObject);
begin
  LblTitle.Font.Color := clWhite;
end;

end.


