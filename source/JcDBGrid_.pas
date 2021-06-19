{******************************************************************************}
{ Jc Components                                                                }
{ Library created inherited from TCustomControl VCL                                    }
{                                                                              }
{ Copyright(c) 2019 - Jo�o Carvalho -                                          }
{ GitHub: https://github.com/joaokvalho                                        }
{                                                                              }
{******************************************************************************
|* Historic
|*
|* 15/10/2019:  Jo�o Carvalho
|* - First Version: Creation and Distribution of the First Version
******************************************************************************}

unit JcDBGrid_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Datasnap.DBClient, Menus, Vcl.DBGrids, DB, StdCtrls, Vcl.Grids,
  System.UITypes,

  // TODO: remover este acoplamento do FIREDAC
  // usado somente para ordenar as colunas ao clicar
  FireDAC.Stan.Intf, FireDAC.Comp.Client;

type
  TjSortType = (stNone, stAscending, stDescending);
//  THackDBGrid = class(TCustomDBGrid);

  TJcDBGrid = class(Vcl.DBGrids.TDBGrid)
  private
    FColorFirst: Tcolor;
    FColorSecond: Tcolor;
    FColorFirstFont: Tcolor;
    FRegistryKey: string;
    FSortType: TjSortType;
    FSortColumn: String;
    FColorSelected: Tcolor;

    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure SetSortType(const Value: TjSortType);
    procedure SetSortColumn(const Value: String);
    procedure SortGrid(Column: TColumn);
  protected
    procedure TitleClick(Column: TColumn); override;

    procedure DrawColumnCell(const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ClearSort;
    procedure PaintColum;

    property SortColumn: String read FSortColumn write SetSortColumn;
    property SortType: TjSortType read FSortType write SetSortType;
  published
    Property ColorFirst: Tcolor read FColorFirst write FColorFirst default clHighlight;

    Property ColorFirstFont: Tcolor read FColorFirstFont Write FColorFirstFont default clHighlightText;
    Property ColorSecond: Tcolor read FColorSecond write FColorSecond default $00EFF7F8;
    Property ColorSelected: Tcolor read FColorSelected write FColorSelected default $00F2880F;
    property RegistryKey: string read FRegistryKey write FRegistryKey;
  end;


procedure SaveGridToRegistry(grid: TCustomDBGrid; const RegistryKey, RegistrySection: string);
procedure LoadGridFromRegistry(grid: TCustomDBGrid; const RegistryKey, RegistrySection: string);

procedure Register;

implementation

uses Registry, IniFiles;

procedure Register;
begin
  RegisterComponents('Jc Components', [TJcDBGrid]);
end;

procedure SaveGridToRegistry(grid: TCustomDBGrid; const RegistryKey, RegistrySection: string);
begin
   // TODO
end;

procedure LoadGridFromRegistry(grid: TCustomDBGrid; const RegistryKey, RegistrySection: string);
begin
   // TODO
end;

procedure TJcDBGrid.SortGrid(Column: TColumn);
var
  sIndexName: string;
  oSort: TFDSortOption;
  I: smallint;
begin
//  for I := 0 to Self.Columns.Count - 1 do
//    Self.Columns[I].Title.Font.Style := [];
//
//  if TFDQuery(Self.DataSource.DataSet).IndexName = Column.FieldName + '_ASC' then
//  begin
//    sIndexName := Column.FieldName + '_DESC';
//    oSort := soDescending;
//  end
//  else
//  begin
//    sIndexName := Column.FieldName + '_ASC';
//    oSort := soNoCase;
//  end;
//
//  if not Assigned(TFDQuery(Self.DataSource.DataSet).Indexes.FindIndex(sIndexName)) then
//    TFDQuery(Self.DataSource.DataSet).AddIndex(sIndexName, Column.FieldName, EmptyStr, [oSort]);
//
//  Column.Title.Font.Style := [fsBold];
//  TFDQuery(Self.DataSource.DataSet).IndexName := sIndexName;
//  TFDQuery(Self.DataSource.DataSet).First;
//
//  PaintColum;
end;

constructor TJcDBGrid.Create(AOwner: TComponent);
begin
//  Color          := clWhite;
//  ColorFirst     := $00FCEDE0;
//  ColorFirstFont := clBlack;
//  ColorSecond    := clWhite;
//  ColorSelected  := $00F2880F;
//
//  DrawingStyle := gdsGradient;
//  FixedColor   := $00FCD39C;
//  GradientStartColor := $00FCEDE0;
//  GradientEndColor   := $00FDE1BB;

//  PaintColum;
end;

destructor TJcDBGrid.Destroy;
begin

  inherited Destroy;
end;

procedure TJcDBGrid.DrawColumnCell(const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  inherited;

//  if Odd(self.DataSource.DataSet.RecNo) then
//    self.Canvas.Brush.Color := ColorFirst
//  else
//    self.Canvas.Brush.Color := ColorSecond;
//
//  if (gdSelected in State) then
//  begin
//    self.Canvas.Brush.Color := ColorSelected;
//    self.Canvas.Font.Color := clwhite;
//    self.Canvas.Font.style := [fsBold];
//  end;
//
//  self.Canvas.FillRect(rect);
//  self.DefaultDrawColumnCell( Rect, DataCol, Column, State);
//
//  self.Canvas.TextRect(Rect, Rect.Left + 8, Rect.Top + 8, Column.Field.DisplayText);
end;

procedure TJcDBGrid.PaintColum;
begin
//  if THackDBGrid(self).Columns.Count = 0 then
//    exit;
//
//  THackDBGrid(self).DefaultRowHeight := 30;
//  THackDBGrid(self).ClientHeight := (30 * Self.RowCount) + 30;
end;

procedure TJcDBGrid.SetSortColumn(const Value: String);
begin
  FSortColumn := Value;
end;

procedure TJcDBGrid.SetSortType(const Value: TjSortType);
begin
  FSortType := Value;
end;

procedure TJcDBGrid.TitleClick(Column: TColumn);
begin
  inherited;
  if Column.Field = nil then
    exit;

  ClearSort;
  SortGrid(Column);
end;

procedure TJcDBGrid.WMVScroll(var Message: TWMVScroll);
begin
  // Dica retirada do blog https://www.andrecelestino.com

//  if Message.ScrollCode = SB_THUMBTRACK then
//    Message.ScrollCode := SB_THUMBPOSITION;

  inherited;
end;

procedure TJcDBGrid.ClearSort;
var
  i: Integer;
begin
//  for I := 0 to Pred(Columns.Count) do
//    Columns[i].Title.Font.Style := [];
end;

end.
