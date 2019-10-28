{******************************************************************************}
{ Jc Components                                                                }
{ Library created inherited from TCustomControl VCL                                    }
{                                                                              }
{ Copyright(c) 2019 - João Carvalho -                                          }
{ GitHub: https://github.com/joaokvalho                                        }
{                                                                              }
{******************************************************************************
|* Historic
|*
|* 15/10/2019:  João Carvalho
|* - First Version: Creation and Distribution of the First Version
******************************************************************************}

unit JcDBGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Datasnap.DBClient, Menus, Vcl.DBGrids, DB, StdCtrls, Vcl.Grids,
  System.UITypes;

type
  TjSortType = (stNone, stAscending, stDescending);
  THackDBGrid = class(TCustomDBGrid);

  TJcDBGrid = class(Vcl.DBGrids.TDBGrid)
  private
    FColorFirst: Tcolor;
    FColorSecond: Tcolor;
    FColorFirstFont: Tcolor;
    FRegistryKey: string;
    FSortType: TjSortType;
    FSortColumn: String;

    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure SetSortType(const Value: TjSortType);
    procedure SetSortColumn(const Value: String);
  protected
    procedure TitleClick(Column: TColumn); override;

    procedure DrawColumnCell(const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ClearSort;

    property SortColumn: String read FSortColumn write SetSortColumn;
    property SortType: TjSortType read FSortType write SetSortType;
  published
    Property ColorFirst: Tcolor read FColorFirst write FColorFirst default clHighlight;
    Property ColorFirstFont: Tcolor read FColorFirstFont Write FColorFirstFont default clHighlightText;
    Property ColorSecond: Tcolor read FColorSecond write FColorSecond default $00EFF7F8;
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

procedure SortGrid(Column: TColumn);
var
 sIndexName: string;
 iOrder: TIndexOptions;
begin
  if TClientDataSet(Column.Field.DataSet).IndexName = Column.FieldName + '_ASC' then
  begin
    sIndexName := Column.FieldName + '_DESC';
    iOrder := [ixDescending];
  end
  else
  begin
    sIndexName := Column.FieldName + '_ASC';
    iOrder := [];
  end;

  if TClientDataSet(Column.Field.DataSet).IndexDefs.IndexOf(sIndexName) < 0 then
    TClientDataSet(Column.Field.DataSet).AddIndex(sIndexName, Column.FieldName, iOrder);

  Column.Title.Font.Style := [fsBold];
  TClientDataSet(Column.Field.DataSet).IndexName := sIndexName;
  Column.Field.DataSet.First;
end;

constructor TJcDBGrid.Create(AOwner: TComponent);
begin
  inherited;
  DrawingStyle := gdsThemed;
  FixedColor := $00EFF7F8;
  GradientEndColor := $00D6D6D6;
  GradientStartColor := clWhite;
end;

destructor TJcDBGrid.Destroy;
begin

  inherited Destroy;
end;

procedure TJcDBGrid.DrawColumnCell(const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
var
  nLin: integer;
begin
  inherited;

  nLin := DataSource.DataSet.RecNo;
  if Odd(nLin) then
  begin
    Canvas.Brush.Color := FColorFirst;
    Canvas.Font.Style  := [fsBold];
    Canvas.Font.Color  := FColorFirstFont;
  end
  else
  begin
    Canvas.Brush.Color := FColorSecond;
    Canvas.Font.Style  := [];
    Canvas.Font.Color  := self.Font.Color;
  end;

  Self.DefaultDrawColumnCell(Rect, DataCol, Column, State);
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

  ClearSort;
  SortGrid(Column);
end;

procedure TJcDBGrid.WMVScroll(var Message: TWMVScroll);
begin
  // Dica retirada do blog https://www.andrecelestino.com

  if Message.ScrollCode = SB_THUMBTRACK then
    Message.ScrollCode := SB_THUMBPOSITION;

  inherited;
end;

procedure TJcDBGrid.ClearSort;
var
  i: Integer;
begin
  for I := 0 to Pred(Columns.Count) do
    Columns[i].Title.Font.Style := [];
end;

end.
