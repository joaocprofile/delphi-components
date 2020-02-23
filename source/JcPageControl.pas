{******************************************************************************}
{ Jc Components                                                                }
{ Library created inherited from TPageControl VCL                                    }
{                                                                              }
{ Copyright(c) 2006 - João Carvalho -                                          }
{ GitHub: https://github.com/joaokvalho                                        }
{                                                                              }
{******************************************************************************
|* Historic
|*
|* 05/10/2007:  João Carvalho
|* - First Version: Creation and Distribution of the First Version
******************************************************************************}

unit JcPageControl;

interface

uses
  Windows, Messages, Classes, CommCtrl, ComCtrls, Controls, Graphics, Dialogs,
  SysUtils;

type
  TJcPageControl = class(TPageControl)
  private
    FBorderActive: Boolean;
    FOnDrawTab: TDrawTabEvent;
    FColorPageAba: TColor;
    procedure SetBorderActive(const Value: Boolean);
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DrawTabSheet(TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property BorderActive: Boolean read FBorderActive write SetBorderActive
      default true;
    property OnDrawTab: TDrawTabEvent read FOnDrawTab write FOnDrawTab;
    Property ColorPageAba: TColor read FColorPageAba write FColorPageAba;
  end;

procedure Register;

implementation

{ TJcPageControl }


procedure Register;
begin
  RegisterComponents('Jc Components', [TJcPageControl]);
end;

constructor TJcPageControl.Create(AOwner: TComponent);
begin
  inherited;
  FBorderActive := True;
  ParentBackground := False;
  Font.Name := 'Tahoma';
  FColorPageAba := $00EFF7F8;
end;

procedure TJcPageControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or TCS_OWNERDRAWFIXED;
end;

destructor TJcPageControl.Destroy;
begin
  inherited Destroy;
end;

procedure TJcPageControl.DrawTabSheet(TabIndex: Integer; const Rect: TRect;
  Active: Boolean);
var
  Caption: string;
  TabRect: TRect;
begin
  Caption := Tabs[TabIndex];
  TabRect := Rect;
  with Canvas do
  begin
    if Pages[TabIndex].Highlighted then
    begin
      Brush.Color := clHighlight;
      Font.Color := clWhite;
    end
    else
    begin
      Brush.Color := TColor(FColorPageAba);
      Font.Color := clBlack;
    end;
    FillRect(Rect);
    OffsetRect(TabRect, 0, 1);
    if not OwnerDraw then
    begin
      DrawText(Handle, PChar(Caption), Length(Caption), TabRect, DT_CENTER or
        DT_SINGLELINE or DT_VCENTER);
    end;
  end;
end;

procedure TJcPageControl.SetBorderActive(const Value: Boolean);
begin
  if FBorderActive <> Value then
  begin
    FBorderActive := Value;
    RecreateWnd;
  end;
end;

procedure TJcPageControl.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE);
  ;
end;

procedure TJcPageControl.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
  if not FBorderActive and (Message.Msg = TCM_ADJUSTRECT) then
  begin
    with PRect(Message.LParam)^ do
    begin
      Left := 0;
      Right := ClientWidth;
      Top := Top - 8;
      Bottom := ClientHeight;
    end;
  end;

  if (Message.Msg = CN_DRAWITEM) then
  begin
    with PDrawItemStruct(Message.LParam)^ do
    begin
      DrawTabSheet(itemID, rcItem, itemState and ODS_SELECTED <> 0);
    end;
  end;

end;

end.

