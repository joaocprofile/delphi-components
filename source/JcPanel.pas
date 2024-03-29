{******************************************************************************}
{ Jc Components                                                                }
{ Library created inherited from TPanel VCL                                    }
{                                                                              }
{ Copyright(c) 2006 - Jo�o Carvalho -                                          }
{ GitHub: https://github.com/joaokvalho                                        }
{                                                                              }
{******************************************************************************
|* Historic
|*
|* 09/06/2006:  Jo�o Carvalho
|* - First Version: Creation and Distribution of the First Version
******************************************************************************}

unit JcPanel;

{$WARN UNSAFE_TYPE OFF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, System.Types;

type
  TJcPanel = class;

  TJcGradientDirection = (dgHorizontal, dgVertical, dgRadial, dgButtonized);

  TJcGradientParams = class(TPersistent)
  private
    FEnabled: Boolean;
    FFadeColor: TColor;
    FDirection: TJcGradientDirection;
    FOwner: TJcPanel;
    procedure SetDirection(const Value: TJcGradientDirection);
    procedure SetEnabled(const Value: Boolean);
    procedure SetFadeColor(const Value: TColor);
  public
    constructor Create(AOwner: TJcPanel);
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property FadeColor: TColor read FFadeColor write SetFadeColor default clWindow;
    property Direction: TJcGradientDirection read FDirection write SetDirection default dgRadial;
  end;

  TJcPanel = class(TCustomPanel)
  private
    FBevelColor: TColor;
    FBevelWidth: Integer;
    FGradient: TJcGradientParams;
    FBorderWidth: Integer;
    procedure DrawGradient(ACanvas: TCanvas; R: TRect; Direction: TJcGradientDirection;
      BeginColor, EndColor: TColor);
    procedure DrawPanel(ACanvas: TCanvas);
    procedure SetBevelColor(const Value: TColor);
    procedure SetBevelWidth(const Value: Integer);
    procedure SetBorderWidth(const Value: Integer);
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
  protected
    procedure Paint; override;
  public
    property DockManager;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelColor: TColor read FBevelColor write SetBevelColor default $00C39D75;
    property BevelWidth: Integer read FBevelWidth write SetBevelWidth default 1;
    property BorderWidth: Integer read FBorderWidth write SetBorderWidth default 1;
    property Caption;
    property Color;
    property Constraints;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Gradient: TJcGradientParams read FGradient write FGradient;
    property Locked;
    property ParentBackground;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

procedure Register;

implementation

{$J+}

procedure Register;
begin
  RegisterComponents('Jc Components', [TJcPanel]);
end;

{ TJcGradientParams }

constructor TJcGradientParams.Create(AOwner: TJcPanel);
begin
  FOwner := AOwner;
  FFadeColor := $00FDE1BB;
  FEnabled   := true;
  FDirection := dgRadial;
end;

procedure TJcGradientParams.SetDirection(const Value: TJcGradientDirection);
begin
  if FDirection <> Value then
    begin
      FDirection := Value;
      FOwner.Invalidate;
    end;
end;

procedure TJcGradientParams.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
    begin
      FEnabled := Value;
      FOwner.Invalidate;
    end;
end;

procedure TJcGradientParams.SetFadeColor(const Value: TColor);
begin
  if FFadeColor <> Value then
    begin
      FFadeColor := Value;
      FOwner.Invalidate;
    end;
end;

{ TJcPanel }

constructor TJcPanel.Create(AOwner: TComponent);
begin
  inherited;
  BevelOuter := bvNone;
  SetBorderWidth(1);
  FBevelWidth := 1;
  FBevelColor := $00FCD39C;
  Color := $00FCD39C;
  FullRepaint := False;
  FGradient := TJcGradientParams.Create(Self);
end;

destructor TJcPanel.Destroy;
begin
  FGradient.Free;

  inherited;
end;

procedure TJcPanel.SetBevelColor(const Value: TColor);
begin
  if FBevelColor <> Value then
    begin
      FBevelColor := Value;
      Invalidate;
    end;
end;

procedure TJcPanel.SetBevelWidth(const Value: Integer);
begin
  if FBevelWidth <> Value then
    begin
      FBevelWidth := Value;
      Invalidate;
    end;
end;

procedure TJcPanel.SetBorderWidth(const Value: Integer);
begin
  inherited BorderWidth := Value;
  FBorderWidth := Value;
  Invalidate;
end;

procedure TJcPanel.Paint;
begin
  DrawPanel(Canvas);
end;

procedure TJcPanel.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  {if csDesigning in ComponentState then
    Invalidate
  else}
    Message.Result := 1;
end;

procedure TJcPanel.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  Invalidate;
  inherited;
end;

procedure TJcPanel.DrawPanel(ACanvas: TCanvas);
var
  R: TRect;
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
begin
  R := GetClientRect;

  // draw border
  Frame3D(ACanvas, R, FBevelColor, FBevelColor, FBevelWidth);

  // draws the panel background
  if FGradient.Enabled then
    DrawGradient(ACanvas, R, FGradient.Direction, ColorToRGB(FGradient.FFadeColor), ColorToRGB(Self.Color))
  else
    begin
      ACanvas.Brush.Color := Color;
      ACanvas.FillRect(R);
    end;

  // draws the text
  InflateRect(R, -BorderWidth, -FBevelWidth);
  ACanvas.Brush.Style := bsClear;
  ACanvas.Font := Self.Font;
  DrawText(ACanvas.Handle, PChar(Caption), -1, R, DT_EXPANDTABS or DT_VCENTER
    or DT_END_ELLIPSIS or DT_SINGLELINE or Alignments[Alignment]);
end;



{
  Adapted Internet code
  I can not remember the source to give the due credits
}
procedure TJcPanel.DrawGradient(ACanvas: TCanvas; R: TRect; Direction: TJcGradientDirection;
  BeginColor, EndColor: TColor);
var
  Rt: TRect;
  I, W, H: Integer;
  Red, Green, Blue: Integer;
  DifR, DifG, DifB: Integer;
  Pts: array[0..3] of TPoint;
  Rgn: HRGN;
  Bmp: TBitmap;
  C: TColor;
begin
  // decodes colors
  Red := (BeginColor and $FF);
  Green := ((BeginColor shr 8) and $FF);
  Blue := ((BeginColor shr 16) and $FF);
  DifR := ((EndColor and $FF) - Red) ;
  DifG := (((EndColor shr 8) and $FF) - Green) ;
  DifB := (((EndColor shr 16) and $FF) - Blue) ;

  H := R.Bottom - R.Top;
  W := R.Right - R.Left;

  // draws vertical gradient
  if Direction = dgVertical then
    begin
      Rt.Left := R.Left;
      Rt.Right := R.Right;
      for I := 0 to 254 do
        begin
          Rt.Top := R.Top + I*H div 255;
          Rt.Bottom := R.Top + (I+1)*H div 255;
          ACanvas.Brush.Color := RGB(Red + I*DifR div 255,
            Green + I*DifG div 255, Blue + I*DifB div 255);
          ACanvas.FillRect(Rt);
        end;
    end

  // draws horizontal gradient
  else if Direction = dgHorizontal then
    begin
      Rt.Top := R.Top;
      Rt.Bottom := R.Bottom;
      for I := 0 to 254 do
        begin
          Rt.Left := R.Left + I*W div 255;
          Rt.Right := R.Left + (I+1)*W div 255;
          ACanvas.Brush.Color := RGB(Red + I*DifR div 255,
            Green + I*DifG div 255, Blue + I*DifB div 255);
          ACanvas.FillRect(Rt);
        end;
    end

  // draws radial gradient
  else if Direction = dgRadial then
    begin
      Bmp := TBitmap.Create;
      Bmp.Width := W;
      Bmp.Height := H;
      for I := 0 to 255 do
        begin
          Bmp.Canvas.Brush.Color := RGB(Red + I*DifR div 255,
            Green + I*DifG div 255, Blue + I*DifB div 255);
          if I < 128 then
            begin
              Pts[0] := Point(0, I*H div 128);
              Pts[1] := Point(0, (I+1)*H div 128);
              Pts[2] := Point((I+1)*W div 128, 0);
              Pts[3] := Point(I*W div 128, 0);
            end
          else
            begin
              Pts[0] := Point((I-128)*W div 128, H);
              Pts[1] := Point((I+1-128)*W div 128, H);
              Pts[2] := Point(W, (I+1-128)*H div 128);
              Pts[3] := Point(W, (I-128)*H div 128);
            end;
          Rgn := CreatePolygonRgn(Pts, 4, ALTERNATE);
          PaintRgn(Bmp.Canvas.Handle, Rgn);
          DeleteObject(Rgn);
        end;
      ACanvas.Draw(R.Left, R.Top, Bmp);
      Bmp.Free;
    end

  // draws buttonised gradient
  else if Direction = dgButtonized then
    begin
      // top
      C := RGB(Red + Trunc(DifR * 0.45), Green + Trunc(DifG * 0.45), Blue + Trunc(DifB * 0.45));
      Rt := Rect(R.Left, R.Top, R.Right, R.Bottom - ((R.Bottom - R.Top) div 2));
      DrawGradient(ACanvas, Rt, dgVertical, BeginColor, C);
      // lower part
      C := RGB(Red + Trunc(DifR * 0.15), Green + Trunc(DifG * 0.15), Blue + Trunc(DifB * 0.15));
      Rt := Rect(R.Left, Rt.Bottom, R.Right, R.Bottom);
      DrawGradient(ACanvas, Rt, dgVertical, EndColor, C);
    end;
end;

end.

