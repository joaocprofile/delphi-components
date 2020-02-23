{******************************************************************************}
{ Jc Components                                                                }
{ Library created inherited from TDBEdit VCL                                    }
{                                                                              }
{ Copyright(c) 2006 - João Carvalho -                                          }
{ GitHub: https://github.com/joaokvalho                                        }
{                                                                              }
{******************************************************************************
|* Historic
|*
|* 12/06/2006:  João Carvalho
|* - First Version: Creation and Distribution of the First Version
******************************************************************************}

unit JcDBEdit;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Mask, DBCtrls, Graphics,
  Forms, Windows, Messages, DB, JcCustomClass;

type
  TJcDBEdit = class(TDBEdit)
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
    procedure setEditRect;
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
    property Canvas: TCanvas read FCanvas;
    procedure DoEnter; override;
    procedure DoExit ; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Borders: TEditBorders read FBorders write setBorders;
    property BorderStyle: TEditBorderStyle read FBorderStyle
      write setBorderStyle default esModern;
    property  ColorOnFocus : TColor read FColorOnFocus write FColorOnFocus;
    property  ColorOnNotFocus : TColor read FColorOnNotFocus write FColorOnNotFocus;
    property  Warning : Boolean read FWarning write SetWarning;
    property  Required : Boolean read FRequired write SetRequired;
    property  NameCaption : String read FNameCaption write FNameCaption;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Jc Components', [TJcDBEdit]);
end;

procedure TJcDBEdit.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TJcDBEdit.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TJcDBEdit.CNCommand(var Message: TWMCommand);
begin
  inherited;
  if (Message.NotifyCode = CBN_CLOSEUP) then
    Invalidate;
end;

constructor TJcDBEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBorders := TEditBorders.Create(Self);
  FCanvas := TControlCanvas.Create;
  FColorOnFocus := $00F8EBE4;
  FColorOnNotFocus := clWindow;
  BevelInner := bvNone;
  BorderStyle := esModern;
  TControlCanvas(FCanvas).Control := Self;
  Font.Size := 10;
  Height    := 21;
  Font.Name := 'Tahoma';
  ControlStyle := ControlStyle - [csSetCaption];
end;

procedure TJcDBEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_AUTOHSCROLL or ES_MULTILINE or
    WS_CLIPCHILDREN;
end;

procedure TJcDBEdit.CreateWnd;
begin
  inherited CreateWnd;
  setEditRect;
end;

destructor TJcDBEdit.Destroy;
begin
  FCanvas.Free;
  FBorders.Free;
  inherited Destroy;
end;

procedure TJcDBEdit.DoEnter;
begin
  inherited;
  if Tag >= 0 then
    Color := ColorOnFocus;
end;

procedure TJcDBEdit.DoExit;
begin
  inherited;
  if Tag >= 0 then
    Color := ColorOnNotFocus;
end;

procedure TJcDBEdit.Paint;

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

procedure TJcDBEdit.setBorders(const Value: TEditBorders);
begin
  FBorders.Assign(Value);
end;

procedure TJcDBEdit.setBorderStyle(const Value: TEditBorderStyle);
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

procedure TJcDBEdit.setEditRect;
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

procedure TJcDBEdit.SetRequired(const Value: Boolean);
begin
  FRequired := Value;
  if FRequired then
    FWarning := False;
end;

procedure TJcDBEdit.SetWarning(const Value: Boolean);
begin
  FWarning := Value;
  if FWarning then
    FRequired := False;
end;

procedure TJcDBEdit.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  Invalidate;
end;

procedure TJcDBEdit.WMLButtonUp(var Message: TWMLButtonUp);
begin
  inherited;
  Invalidate;
end;

procedure TJcDBEdit.WMPaint(var Message: TWMPaint);
begin
  inherited;
  Paint;
  TControlCanvas(FCanvas).UpdateTextFlags;
  Message.Result := 0;
end;

procedure TJcDBEdit.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  Invalidate;
  SelectAll;
end;

procedure TJcDBEdit.WMSize(var Message: TWMSize);
begin
  inherited;
  Invalidate;
end;

end.

