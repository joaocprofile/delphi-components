unit JcDBComboBox;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, DBCtrls, JcCustomClass, Forms,
  Graphics, Windows, Messages, DB;

type
  TJcDBComboBox = class(TDBComboBox)
  private
    FBorders: TEditBorders;
    FBorderStyle: TEditBorderStyle;
    FCanvas: TCanvas;
    FButtonColor: TColor;
    FMouseInControl: Boolean;
    FNameCaption: String;
    FRequired: Boolean;
    FWarning: Boolean;
    procedure setButtonColor(const Value: TColor);
    procedure setBorders(const Value: TEditBorders);
    procedure setBorderStyle(const Value: TEditBorderStyle);
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMEnter); message CM_EXIT;
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
    property Canvas: TCanvas read FCanvas;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Borders: TEditBorders read FBorders write setBorders;
    property BorderStyle: TEditBorderStyle read FBorderStyle
      write setBorderStyle default esModern;
    property ButtonColor: TColor read FButtonColor write setButtonColor
      default TColor(clWhite);
    property  Warning : Boolean read FWarning write SetWarning;
    property  Required : Boolean read FRequired write SetRequired;
    property  NameCaption : String read FNameCaption write FNameCaption;
  end;

procedure Register;

implementation

{ TJcDBComboBox }

procedure Register;
begin
  RegisterComponents('Jc Components', [TJcDBComboBox]);
end;

procedure TJcDBComboBox.CMEnter(var Message: TCMEnter);
begin
  inherited;
  Invalidate;
end;

procedure TJcDBComboBox.CMExit(var Message: TCMEnter);
var
  DataLink: TDataLink;
begin
  DataLink := TDataLink(Perform(cm_GetDataLink, 0, 0));
  if DataLink <> nil then
  begin
    try
      if DataLink.Edit then
        DataLink.UpdateRecord;
    except
      raise;
    end;
    DoExit;
  end
  else
    inherited;
end;

procedure TJcDBComboBox.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FMouseInControl := True;
  Invalidate;
end;

procedure TJcDBComboBox.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  FMouseInControl := False;
  Invalidate;
end;

procedure TJcDBComboBox.CNCommand(var Message: TWMCommand);
begin
  inherited;
  if (Message.NotifyCode = CBN_CLOSEUP) then
    Invalidate;
end;

constructor TJcDBComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBorders := TEditBorders.Create(Self);
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  BorderStyle := esModern;
  BevelKind := bkFlat;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  FButtonColor := TColor(clWhite); // $00EEE5D6
  Font.Name := 'Tahoma';
end;

procedure TJcDBComboBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
end;

procedure TJcDBComboBox.CreateWnd;
begin
  inherited CreateWnd;
end;

destructor TJcDBComboBox.Destroy;
begin
  FCanvas.Free;
  FBorders.Free;
  inherited Destroy;
end;

procedure TJcDBComboBox.Paint;

  function GetButtonRect: TRect;
  begin
    GetWindowRect(Handle, Result);
    OffsetRect(Result, -Result.Left, -Result.Top);
    Inc(Result.Left, ClientWidth - GetSystemMetrics(SM_CXVSCROLL) - 2);
  end;

  function BlendColors(const Color1, Color2: TColor; Amount: Extended): TColor;
  var
    R, R2, G, G2, B, B2: Integer;
    win1, win2: Integer;
  begin
    win1 := ColorToRGB(Color1);
    win2 := ColorToRGB(Color2);

    R := GetRValue(win1);
    G := GetGValue(win1);
    B := GetBValue(win1);

    R2 := GetRValue(win2);
    G2 := GetGValue(win2);
    B2 := GetBValue(win2);

    b2 := round((1 - amount) * b + amount * b2);
    g2 := round((1 - amount) * g + amount * g2);
    r2 := round((1 - amount) * r + amount * r2);

    if R2 < 0 then
      R2 := 0;
    if G2 < 0 then
      G2 := 0;
    if B2 < 0 then
      B2 := 0;

    if R2 > 255 then
      R2 := r;
    if G2 > 255 then
      G2 := g;
    if B2 > 255 then
      B2 := b;

    Result := TColor(RGB(R2, G2, B2));
  end;

  procedure DrawButton;
  var
    ButtonRect: TRect;
    ArrowColor: TColor;
    X, Y: Integer;
  begin
    with FCanvas do
    begin
      ButtonRect := GetButtonRect;

      if FBorders.Top.Visible then
        Inc(ButtonRect.Top);
      if FBorders.Bottom.Visible then
        Dec(ButtonRect.Bottom);
      if FBorders.Right.Visible then
        Dec(ButtonRect.Right);

      Brush.Color := clWhite;
      Pen.Style := psSolid;
      Pen.Color := clWhite;
      Rectangle(ButtonRect);

      with ButtonRect do
      begin
        if not Enabled then
        begin
          InflateRect(ButtonRect, 0, 0);
          Pen.Style := psClear;
          Brush.Color := BlendColors(clBtnShadow, clWindow, 0.231);
          ArrowColor := clBtnShadow;
        end
        else if DroppedDown then
        begin
          Pen.Style := psSolid;
          Pen.Color := clHighlight;
          Brush.Color := BlendColors(clHighlight, clWindow, 0.60);
          ArrowColor := clHighlightText;
        end
        else if (FMouseInControl) and (not (csDesigning in ComponentState)) then
        begin
          Pen.Style := psSolid;
          Pen.Color := clHighlight;
          Brush.Color := BlendColors(clHighlight, clWindow, 0.60);
          ArrowColor := clMenuText;
        end
        else
        begin
          Pen.Style := psSolid;
          Pen.Color := clWhite;
          Brush.Color := FButtonColor;
          ArrowColor := clMenuText;
        end;
        RoundRect(ButtonRect.TopLeft.X,
          ButtonRect.TopLeft.Y,
          ButtonRect.BottomRight.X,
          ButtonRect.BottomRight.Y,
          4,
          4);

        X := (Right - Left) div 2 - 6 + Left;
        Y := (Bottom - Top) div 2 - 1 + Top;
        Brush.Color := ArrowColor;
        Pen.Color := ArrowColor;
        Pen.Style := psSolid;
        Polygon([Point(X + 4, Y), Point(X + 8, Y), Point(X + 6, Y + 2)]);
      end;
    end;
  end;

  procedure DrawBorders;
  var
    BorderRect: TRect;
  begin
    BorderRect := ClientRect;
    FCanvas.Brush.Color := Color;
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
      end;
    end;
  end;

begin
  if (BorderStyle = esModern) then
  begin
    DrawBorders;
    if Style <> csSimple then
      DrawButton;
  end;
end;

procedure TJcDBComboBox.setBorders(const Value: TEditBorders);
begin
  FBorders.Assign(Value);
end;

procedure TJcDBComboBox.setBorderStyle(const Value: TEditBorderStyle);
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

procedure TJcDBComboBox.setButtonColor(const Value: TColor);
begin
  FButtonColor := Value;
  Perform(CM_COLORCHANGED, 0, 0);
end;

procedure TJcDBComboBox.SetRequired(const Value: Boolean);
begin
  FRequired := Value;
  if FRequired then
    FWarning := False;
end;

procedure TJcDBComboBox.SetWarning(const Value: Boolean);
begin
  FWarning := Value;
  if FWarning then
    FRequired := False;
end;

procedure TJcDBComboBox.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  Invalidate;
end;

procedure TJcDBComboBox.WMLButtonUp(var Message: TWMLButtonUp);
begin
  inherited;
  Invalidate;
end;

procedure TJcDBComboBox.WMPaint(var Message: TWMPaint);
begin
  inherited;
  Paint;
  //  TControlCanvas(FCanvas).UpdateTextFlags;
  Message.Result := 0;
end;

procedure TJcDBComboBox.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  Invalidate;
  SelectAll;
end;

procedure TJcDBComboBox.WMSize(var Message: TWMSize);
begin
  inherited;
  Invalidate;
end;

end.

