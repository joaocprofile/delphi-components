unit JcCustomClass;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, Graphics, Forms,
  Mask, Dialogs;

type
  TEditBorderStyle = (esNone, esSingle, esModern);

  TCustomEditBorder = class(TPersistent)
  private
    FColor: TColor;
    FWidth: Integer;
    FVisible: Boolean;
    FParent: TWinControl;
    procedure setParent(const Value: TWinControl);
    procedure setVisible(const Value: Boolean);
    procedure setWidth(const Value: Integer);
    procedure setColor(const Value: TColor);
  public
    constructor Create; virtual;
    destructor Destroy; override;
  protected
    property Parent: TWinControl read FParent write setParent;
    property Visible: Boolean read FVisible write setVisible;
  published
    property Color: TColor read FColor write setColor default TColor($00666666);
    property Width: Integer read FWidth write setWidth default 1;
  end;

  TBottomEditBorder = class(TCustomEditBorder)
  published
    property Visible default False;
  end;

  TLeftEditBorder = class(TCustomEditBorder)
  public
    constructor Create; override;
  published
    property Visible default True;
  end;

  TRightEditBorder = class(TCustomEditBorder)
  published
    property Visible default False;
  end;

  TTopEditBorder = class(TCustomEditBorder)
  public
    constructor Create; override;
  published
    property Visible default True;
  end;

  TEditBorders = class(TPersistent)
  private
    FBottom: TBottomEditBorder;
    FLeft: TLeftEditBorder;
    FRight: TRightEditBorder;
    FTop: TTopEditBorder;
    procedure setBottom(const Value: TBottomEditBorder);
    procedure setLeft(const Value: TLeftEditBorder);
    procedure setRight(const Value: TRightEditBorder);
    procedure setTop(const Value: TTopEditBorder);
  public
    constructor Create(AParent: TWinControl);
    destructor Destroy; override;
  published
    property Bottom: TBottomEditBorder read FBottom write setBottom stored True;
    property Left: TLeftEditBorder read FLeft write setLeft stored True;
    property Right: TRightEditBorder read FRight write setRight stored True;
    property Top: TTopEditBorder read FTop write setTop stored True;
  end;

  TJcCustomMaskEdit = class(TCustomMaskEdit)
  private
    FColorOnFocus    : TColor;
    FColorOnNotFocus : TColor;
    FBorders: TEditBorders;
    FBorderStyle: TEditBorderStyle;
    FCanvas: TCanvas;
    FNameCaption: String;
    FRequired: Boolean;
    FWarning: Boolean;
    procedure setBorders(const Value: TEditBorders);
    procedure setBorderStyle(const Value: TEditBorderStyle);
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure SetRequired(const Value: Boolean);
    procedure SetWarning(const Value: Boolean);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure Paint; virtual;
    procedure setEditRect; virtual;
    property Canvas: TCanvas read FCanvas;
    procedure DOEnter; override;
    procedure DOExit; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Borders: TEditBorders read FBorders write setBorders stored True;
    property BorderStyle: TEditBorderStyle read FBorderStyle
      write setBorderStyle default esModern;
    property  ColorOnFocus : TColor read FColorOnFocus write FColorOnFocus;
    property  ColorOnNotFocus : TColor read FColorOnNotFocus write FColorOnNotFocus;
    property  Warning : Boolean read FWarning write SetWarning;
    property  Required : Boolean read FRequired write SetRequired;
    property  NameCaption : String read FNameCaption write FNameCaption;
  end;

  TJcCustomEdit = class(TEdit)
  private
    FBorders: TEditBorders;
    FBorderStyle: TEditBorderStyle;
    FCanvas: TCanvas;

    FOnEnter     : TNotifyEvent;
    FOnExit      : TNotifyEvent;
    FValue       : Integer;
    FEditPrecision : Integer;
    FColorOnFocus    : TColor;
    FColorOnNotFocus : TColor;
    FNameCaption: String;
    FRequired: Boolean;
    FWarning: Boolean;
    procedure setBorders(const Value: TEditBorders);
    procedure setBorderStyle(const Value: TEditBorderStyle);
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure SetRequired(const Value: Boolean);
    procedure SetWarning(const Value: Boolean);
  protected
    procedure ColorBorder;
    procedure Change; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure Paint; virtual;
    procedure setEditRect; virtual;
    property Canvas: TCanvas read FCanvas;
    procedure KeyPress(var Key: Char); override;
    procedure DoEnter; override;
    procedure DoExit ; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property  Value : Integer read FValue write FValue;
    property  EditPrecision : Integer read FEditPrecision write FEditPrecision;
    property  Warning : Boolean read FWarning write SetWarning;
    property  Required : Boolean read FRequired write SetRequired;
    property  NameCaption : String read FNameCaption write FNameCaption;
    property  ColorOnFocus : TColor read FColorOnFocus write FColorOnFocus;
    property  ColorOnNotFocus : TColor read FColorOnNotFocus write FColorOnNotFocus;

    property Align;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property Borders: TEditBorders read FBorders write setBorders;
    property BorderStyle: TEditBorderStyle read FBorderStyle
      write setBorderStyle default esModern;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnKeyDown;
    property OnEnter: TNotifyEvent read FOnEnter write FOnEnter;
    property OnExit : TNotifyEvent read FOnExit  write FOnExit;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses Types;

{ TJcCustomEdit }

procedure TJcCustomEdit.Change;
begin
  if not (csLoading in ComponentState) then
    inherited Change;
end;

procedure TJcCustomEdit.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TJcCustomEdit.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TJcCustomEdit.CNCommand(var Message: TWMCommand);
begin
  inherited;
  if (Message.NotifyCode = CBN_CLOSEUP) then
    Invalidate;
end;

procedure TJcCustomEdit.ColorBorder;
var
  BorderRect: TRect;
begin
    BorderRect := ClientRect;
    FCanvas.Brush.Style := bsSolid;

    with FCanvas do
    begin
      with BorderRect do
      begin
        with FBorders.Bottom do
        begin
          if Visible then
          begin
            Pen.Width := Borders.Bottom.Width;
            Pen.Color := Borders.Bottom.Color;
            PolyLine([Point(Left, Bottom - 1), Point(Right, Bottom - 1)]);
          end;
        end;

        with FBorders.Left do
        begin
          if Visible then
          begin
            Pen.Width := Borders.Left.Width;
            Pen.Color := Borders.Left.Color;
            PolyLine([Point(Left, Bottom - 1), Point(Left, Top)]);
          end;
        end;

        with FBorders.Right do
        begin
          if Visible then
          begin
            Pen.Width := Borders.Right.Width;
            Pen.Color := Borders.Right.Color;
            PolyLine([Point(Right - 1, Bottom), Point(Right, Top -
              Self.Height)]);
          end;
        end;

        with FBorders.Top do
        begin
          if Visible then
          begin
            Pen.Width := Borders.Top.Width;
            Pen.Color := Borders.Top.Color;
            PolyLine([Point(Left, Top), Point(Right, Top)]);
          end;
        end;
        Inc(Left, 2);
        Inc(Top, 2);
      end;
    end;  
end;

constructor TJcCustomEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBorders := TEditBorders.Create(Self);
  FCanvas := TControlCanvas.Create;
  FColorOnFocus := $00FCF7F3;
  FColorOnNotFocus := clWindow;
  TControlCanvas(FCanvas).Control := Self;
  BorderStyle := esModern;
  Font.Name := 'Tahoma';
  Font.Size       := 9;
  Height          := 21;
  ControlStyle    := ControlStyle - [csSetCaption];
  Alignment       := taLeftJustify;
  CharCase        := ecUpperCase;
  Color           := clWhite;
  Ctl3D           := False;
  Text            := '';
  FValue          := 0;
  FEditPrecision  := 0;
  NameCaption     := '';
end;

procedure TJcCustomEdit.CreateParams(var Params: TCreateParams);
const
  Passwords: array[Boolean] of DWORD = (0, ES_PASSWORD);
  ReadOnlys: array[Boolean] of DWORD = (0, ES_READONLY);
  CharCases: array[TEditCharCase] of DWORD = (0, ES_UPPERCASE, ES_LOWERCASE);
  HideSelections: array[Boolean] of DWORD = (ES_NOHIDESEL, 0);
  OEMConverts: array[Boolean] of DWORD = (0, ES_OEMCONVERT);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'EDIT');
  with Params do
  begin
    Style := Style or (ES_AUTOHSCROLL or ES_AUTOVSCROLL)or
      Passwords[PasswordChar <> #0] or
      ReadOnlys[ReadOnly] or CharCases[CharCase] or
      HideSelections[HideSelection] or OEMConverts[OEMConvert];

    if PasswordChar = #0 then
      Style := Style or ES_MULTILINE
    else
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
  end;

end;

procedure TJcCustomEdit.CreateWnd;
begin
  inherited CreateWnd;
  setEditRect;
end;

destructor TJcCustomEdit.Destroy;
begin
  FCanvas.Free;
  FBorders.Free;
 // FFocus.Free;
  inherited Destroy;
end;

procedure TJcCustomEdit.DOEnter;
begin
  inherited;
  if Tag >= 0 then
    Color := ColorOnFocus;

  if Assigned(FOnEnter) then
     FOnEnter(Self);

  if BorderStyle = esModern then
    ColorBorder;
end;

procedure TJcCustomEdit.DOExit;
begin
  inherited;
  if BorderStyle = esModern then
    ColorBorder;

  if Tag >= 0 then
    Color := ColorOnNotFocus;

  if Assigned(FOnExit) then
    FOnExit(Self);
end;

procedure TJcCustomEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
end;

procedure TJcCustomEdit.Paint;

  procedure DrawBorders;
  var
    BorderRect: TRect;
  begin
    BorderRect := ClientRect;
    FCanvas.Brush.Style := bsSolid;

    with FCanvas do
    begin
      with BorderRect do
      begin
        with FBorders.Bottom do
        begin
          if Visible then
          begin
            Pen.Width := Width;
            Pen.Color := Color;
            PolyLine([Point(Left, Bottom - 1), Point(Right, Bottom - 1)]);
          end;
        end;

        with FBorders.Left do
        begin
          if Visible then
          begin
            Pen.Width := Width;
            Pen.Color := Color;
            PolyLine([Point(Left, Bottom - 1), Point(Left, Top)]);
          end;
        end;

        with FBorders.Right do
        begin
          if Visible then
          begin
            Pen.Width := Width;
            Pen.Color := Color;
            PolyLine([Point(Right - 1, Bottom), Point(Right, Top -
              Self.Height)]);
          end;
        end;

        with FBorders.Top do
        begin
          if Visible then
          begin
            Pen.Width := Width;
            Pen.Color := Color;
            PolyLine([Point(Left, Top), Point(Right, Top)]);
          end;
        end;
        Inc(Left, 2);
        Inc(Top, 2);
      end;
    end;
  end;

begin
  if BorderStyle = esModern then
    DrawBorders;
end;

procedure TJcCustomEdit.setBorders(const Value: TEditBorders);
begin
  FBorders.Assign(Value);
end;

procedure TJcCustomEdit.setBorderStyle(const Value: TEditBorderStyle);
begin
  if Value <> FBorderStyle then
  begin
    FBorderStyle := Value;
    if FBorderStyle = esSingle then
      TEdit(Self).BorderStyle := bsSingle
    else
      TEdit(Self).BorderStyle := bsNone;
    Perform(CM_BORDERCHANGED, 0, 0);
  end;
end;

procedure TJcCustomEdit.setEditRect;
var
  EditRec: TRect;
begin
  if (not (csloading in ComponentState)) and (PasswordChar = #0) then
  begin
    SendMessage(Handle, EM_GETRECT, 0, LongInt(@EditRec));

    if FBorderStyle <> esSingle then
    begin
      EditRec.Bottom := ClientHeight + 1;
      EditRec.Right := ClientWidth;
      EditRec.Top := 3;
      EditRec.Left := 4;
    end;

    SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@EditRec));
  end;
end;

procedure TJcCustomEdit.SetRequired(const Value: Boolean);
begin
  FRequired := Value;
  if FRequired then
    FWarning := False;
end;

procedure TJcCustomEdit.SetWarning(const Value: Boolean);
begin
  FWarning := Value;
  if FWarning then
    FRequired := False;
end;

procedure TJcCustomEdit.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  Invalidate;
end;

procedure TJcCustomEdit.WMLButtonUp(var Message: TWMLButtonUp);
begin
  inherited;
  Invalidate;
end;

procedure TJcCustomEdit.WMPaint(var Message: TWMPaint);
begin
  inherited;
  Paint;
  TControlCanvas(FCanvas).UpdateTextFlags;
  Message.Result := 0;
end;

procedure TJcCustomEdit.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  Invalidate;
  SelectAll;
end;

procedure TJcCustomEdit.WMSize(var Message: TWMSize);
begin
  inherited;
  Invalidate;
end;

{ TEditBorder }

constructor TCustomEditBorder.Create;
begin
  FColor := TColor($00C3894B);
  FWidth := 1;
end;

destructor TCustomEditBorder.Destroy;
begin

  inherited;
end;

procedure TCustomEditBorder.setColor(const Value: TColor);
begin
  FColor := Value;
  Parent.Perform(CM_COLORCHANGED, 0, 0);
end;

procedure TCustomEditBorder.setParent(const Value: TWinControl);
begin
  FParent := Value;
end;

procedure TCustomEditBorder.setVisible(const Value: Boolean);
begin
  if Value <> FVisible then
  begin
    FVisible := Value;
    Parent.Perform(CM_BORDERCHANGED, 0, 0);
  end;
end;

procedure TCustomEditBorder.setWidth(const Value: Integer);
begin
  FWidth := Value;
  Parent.Perform(CM_BORDERCHANGED, 0, 0);
end;

{ TEditBorders }

constructor TEditBorders.Create(AParent: TWinControl);
begin
  FBottom := TBottomEditBorder.Create;
  FBottom.Parent := AParent;

  FLeft := TLeftEditBorder.Create;
  FLeft.Parent := AParent;

  FRight := TRightEditBorder.Create;
  FRight.Parent := AParent;

  FTop := TTopEditBorder.Create;
  FTop.Parent := AParent;
end;

destructor TEditBorders.Destroy;
begin
  if Assigned(FBottom) then
    FBottom.Free;

  if Assigned(FLeft) then
    FLeft.Free;

  if Assigned(FRight) then
    FRight.Free;

  if Assigned(FTop) then
    FTop.Free;

  inherited Destroy;
end;

procedure TEditBorders.setBottom(const Value: TBottomEditBorder);
begin
  FBottom.Assign(Value);
end;

procedure TEditBorders.setLeft(const Value: TLeftEditBorder);
begin
  FLeft.Assign(Value);
end;

procedure TEditBorders.setRight(const Value: TRightEditBorder);
begin
  FRight.Assign(Value);
end;

procedure TEditBorders.setTop(const Value: TTopEditBorder);
begin
  FTop.Assign(Value);
end;

{ TJcCustomMaskEdit }

procedure TJcCustomMaskEdit.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TJcCustomMaskEdit.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TJcCustomMaskEdit.CNCommand(var Message: TWMCommand);
begin
  inherited;
  if (Message.NotifyCode = CBN_CLOSEUP) then
    Invalidate;
end;

constructor TJcCustomMaskEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBorders := TEditBorders.Create(Self);
  FCanvas := TControlCanvas.Create;
  FColorOnFocus := $00FCF7F3;
  FColorOnNotFocus := clWindow;
  BorderStyle := esModern;
  TControlCanvas(FCanvas).Control := Self;
  Font.Name := 'Tahoma';
  Font.Size := 10;
  Width     := 100;
  Height    := 21;
  ControlStyle := ControlStyle - [csSetCaption];
end;

procedure TJcCustomMaskEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_AUTOHSCROLL or ES_MULTILINE or
    WS_CLIPCHILDREN;
end;

procedure TJcCustomMaskEdit.CreateWnd;
begin
  inherited CreateWnd;

  if PasswordChar <> #0 then
    SendMessage(Handle, EM_SETPASSWORDCHAR, Ord(PasswordChar), 0);

  setEditRect;
end;

destructor TJcCustomMaskEdit.Destroy;
begin
  FCanvas.Free;
  FBorders.Free;
  inherited Destroy;
end;

procedure TJcCustomMaskEdit.DOEnter;
begin
  inherited;
  if Tag >= 0 then
    Color := ColorOnFocus;
end;

procedure TJcCustomMaskEdit.DOExit;
begin
  inherited ;
  if Tag >= 0 then
    Color := ColorOnNotFocus ;
end;

procedure TJcCustomMaskEdit.Paint;

  procedure DrawBorders;
  var
    BorderRect: TRect;
  begin
    BorderRect := ClientRect;
    FCanvas.Brush.Style := bsSolid;

    with FCanvas do
    begin
      with BorderRect do
      begin
        with FBorders.Bottom do
        begin
          if Visible then
          begin
            Pen.Width := Width;
            Pen.Color := Color;
            PolyLine([Point(Left, Bottom - 1), Point(Right, Bottom - 1)]);
          end;
        end;

        with FBorders.Left do
        begin
          if Visible then
          begin
            Pen.Width := Width;
            Pen.Color := Color;
            PolyLine([Point(Left, Bottom - 1), Point(Left, Top)]);
          end;
        end;

        with FBorders.Right do
        begin
          if Visible then
          begin
            Pen.Width := Width;
            Pen.Color := Color;
            PolyLine([Point(Right - 1, Bottom), Point(Right, Top -
              Self.Height)]);
          end;
        end;

        with FBorders.Top do
        begin
          if Visible then
          begin
            Pen.Width := Width;
            Pen.Color := Color;
            PolyLine([Point(Left, Top), Point(Right, Top)]);
          end;
        end;
        Inc(Left, 2);
        Inc(Top, 2);
      end;
    end;
  end;

begin
  if BorderStyle = esModern then
    DrawBorders;
end;

procedure TJcCustomMaskEdit.setBorders(const Value: TEditBorders);
begin
  FBorders.Assign(Value);
end;

procedure TJcCustomMaskEdit.setBorderStyle(const Value: TEditBorderStyle);
begin
  if Value <> FBorderStyle then
  begin
    FBorderStyle := Value;
    if FBorderStyle = esSingle then
      TEdit(Self).BorderStyle := bsSingle
    else
      TEdit(Self).BorderStyle := bsNone;
    Perform(CM_BORDERCHANGED, 0, 0);
  end;
end;

procedure TJcCustomMaskEdit.setEditRect;
var
  EditRec: TRect;
begin
  if (not (csloading in ComponentState)) and (passwordChar = #0) then
  begin
    SendMessage(Handle, EM_GETRECT, 0, LongInt(@EditRec));
    if FBorderStyle <> esSingle then
    begin
      EditRec.Bottom := ClientHeight + 1;
      EditRec.Right := ClientWidth;
      EditRec.Top := 3;
      EditRec.Left := 4;
    end;
    SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@EditRec));
  end;
end;

procedure TJcCustomMaskEdit.SetRequired(const Value: Boolean);
begin
  FRequired := Value;
  if FRequired then
    FWarning := False;
end;

procedure TJcCustomMaskEdit.SetWarning(const Value: Boolean);
begin
  FWarning := Value;
  if FWarning then
    FRequired := False;
end;

procedure TJcCustomMaskEdit.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  Invalidate;
end;

procedure TJcCustomMaskEdit.WMLButtonUp(var Message: TWMLButtonUp);
begin
  inherited;
  Invalidate;
end;

procedure TJcCustomMaskEdit.WMPaint(var Message: TWMPaint);
begin
  inherited;
  Paint;
  TControlCanvas(FCanvas).UpdateTextFlags;
  Message.Result := 0;
end;

procedure TJcCustomMaskEdit.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  Invalidate;
  if EditText <> EmptyStr then
    SelectAll;
end;

procedure TJcCustomMaskEdit.WMSize(var Message: TWMSize);
begin
  inherited;
  Invalidate;
end;

{ TLeftEditBorder }

constructor TLeftEditBorder.Create;
begin
  inherited Create;
  inherited Visible := True;
end;

{ TTopEditBorder }

constructor TTopEditBorder.Create;
begin
  inherited Create;
  inherited Visible := True;
end;


end.
