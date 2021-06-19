unit JcDBGrid;

interface

uses
  System.Classes, Vcl.Controls, Vcl.Grids, Vcl.DBGrids,
  System.UITypes, Vcl.Graphics, System.Types, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Comp.Client, Winapi.Messages, System.Generics.Collections;

type
  TjSortType = (stNone, stAscending, stDescending);
  THackDBGrid = class(TCustomDBGrid);

  TJcSortColumn = class
  private
    FSortCaption: string;
    FSortType: TjSortType;

    procedure SetSortCaption(Value: String);
    procedure SetSortType(Value: TjSortType);
  public
    constructor Create(ASortCaption: String = ''; ASortType: TjSortType = stNone);
    destructor Destroy; override;

    property SortCaption: string read FSortCaption write FSortCaption;
    property SortType: TjSortType read FSortType write FSortType;
  end;

  TJcDBGrid = class(TDBGrid)
  private
    FColorSelected: Tcolor;
    FColorFirst: Tcolor;
    FColorSecond: Tcolor;
    FRegistryKey: string;
    FColorFirstFont: Tcolor;
    FSortColumns: TList<TJcSortColumn>;
    FAdjustWidth: boolean;

    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure SortGrid(Column: TColumn);
    procedure DoAdjustWidth;
  protected
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure TitleClick(Column: TColumn); override;
    procedure DrawColumnCell(const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState); override;
    procedure DrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ClearSort;
    procedure FormatColumns;
  published
    Property ColorFirst: Tcolor read FColorFirst write FColorFirst default $00F4C18E;
    Property ColorFirstFont: Tcolor read FColorFirstFont Write FColorFirstFont default clHighlightText;
    Property ColorSecond: Tcolor read FColorSecond write FColorSecond default $00EFF7F8;
    Property ColorSelected: Tcolor read FColorSelected write FColorSelected default $00FFA054;
    property RegistryKey: string read FRegistryKey write FRegistryKey;
    property SortColumns: TList<TJcSortColumn> read FSortColumns write FSortColumns;
    property AdjustWidth: boolean read FAdjustWidth write FAdjustWidth default false;
  end;

procedure Register;

implementation

uses
  Vcl.Forms, Vcl.Dialogs, System.SysUtils, Winapi.Windows;

procedure Register;
begin
  RegisterComponents('Jc Components', [TJcDBGrid]);
end;

{ TJcDBGrid }

procedure TJcDBGrid.ClearSort;
var
  i: Integer;
begin
  for I := 0 to Pred(Columns.Count) do
    Columns[i].Title.Font.Style := [];
end;

constructor TJcDBGrid.Create(AOwner: TComponent);
begin
  inherited;
  FSortColumns := TList<TJcSortColumn>.create;
  FAdjustWidth := false;

  font.Name := 'Arial';
  font.Size := 9;
  font.Style := [fsBold];

  BorderStyle    := bsNone;
  DrawingStyle   := gdsGradient;
  Options        := [dgEditing,
                     dgTitles,
                     dgColumnResize,
                     dgAlwaysShowSelection,
                     dgRowSelect,
                     dgTabs,
                     dgTitleClick,
                     dgTitleHotTrack];

  Color           := clWhite;
  FColorFirst     := clWhite;

  FColorFirstFont := $00676767;
  FColorSecond    := $00F9F4EE;
  FColorSelected  := $00FFA054;

  DrawingStyle := gdsGradient;
  FixedColor   := $00FCD39C;

  GradientStartColor := $00F9F4EE;
  GradientEndColor   := $00F5EFE7;
end;

destructor TJcDBGrid.Destroy;
var
  i: integer;
begin
  for I := 0 to FSortColumns.Count -1 do
    FSortColumns[i].Free;
  FreeAndNil(FSortColumns);

  inherited;
end;

procedure TJcDBGrid.DoAdjustWidth;
begin

end;

procedure TJcDBGrid.SortGrid(Column: TColumn);
var
  sIndexName: string;
  oSort: TFDSortOption;
  sFind: string;
  I: smallint;
begin
  sFind   := ' ';

  for I := 0 to Self.Columns.Count - 1 do
    Self.Columns[I].Title.Font.Style := [];

  for I := 0 to FSortColumns.Count - 1 do
    SortColumns[I].SetSortType(stNone);

  if TFDQuery(Self.DataSource.DataSet).IndexName = Column.FieldName + '_ASC' then
  begin
    sIndexName := Column.FieldName + '_DESC';
    oSort := soDescending;
    SortColumns.Add(TJcSortColumn.Create(Column.Title.Caption, stDescending))
  end
  else
  begin
    sIndexName := Column.FieldName + '_ASC';
    oSort := soNoCase;
    SortColumns.Add(TJcSortColumn.Create(Column.Title.Caption, stAscending))
  end;

  if not Assigned(TFDQuery(Self.DataSource.DataSet).Indexes.FindIndex(sIndexName)) then
    TFDQuery(Self.DataSource.DataSet).AddIndex(sIndexName, Column.FieldName, EmptyStr, [oSort]);

  Column.Title.Font.Style := [fsBold];
  TFDQuery(Self.DataSource.DataSet).IndexName := sIndexName;
end;

procedure TJcDBGrid.FormatColumns;
begin
  if THackDBGrid(self).Columns.Count = 0 then
    exit;

  THackDBGrid(self).DefaultRowHeight := 30;
  THackDBGrid(self).ClientHeight := (30 * Self.RowCount) + 30;
end;

procedure TJcDBGrid.DrawCell(ACol, ARow: Longint; ARect: TRect;
  AState: TGridDrawState);
var
  TitleText: string;
  i, idxSort, BCol: LongInt;
  DrawFlag: Integer;
const
  intSortImageWidth: Integer = 7;
begin
  inherited;

  if (dgIndicator in Options) then
    BCol := ACol - 1
  else
    BCol := ACol;

  if (gdFixed in AState) and (ARow = 0) and (dgTitles in Options) then
  begin
    TitleText := Columns[BCol].Title.Caption;
    idxSort := -1;

    if (ARect.Right - ARect.Left > intSortImageWidth) then
    begin
      for i := 0 to SortColumns.Count - 1 do
        if (SortColumns[i].SortCaption = Columns[BCol].Title.Caption) and
          (SortColumns[i].SortType <> stNone) then
        begin
          idxSort := i;
          break
        end;
      if idxSort > -1 then
        ARect.Right := ARect.Right - intSortImageWidth;
    end;

    if DefaultDrawing and (TitleText <> '') then
    begin
      Canvas.Brush.Style := bsClear;
      Canvas.Font := Columns[BCol].Title.Font;
      Canvas.Brush.Color := Columns[BCol].Title.Color;

      if idxSort > -1 then
      begin
        ARect.Right := ARect.Right + intSortImageWidth;
        i := (ARect.Bottom - ARect.Top - intSortImageWidth) div 2;

        if (SortColumns[idxSort].SortType = stAscending) then
        begin
          Canvas.Pen.Color := clBtnShadow;
          Canvas.MoveTo(ARect.Right - 10, ARect.Top + i);
          Canvas.LineTo(ARect.Right - 10 - intSortImageWidth, ARect.Top + i);
          Canvas.LineTo(ARect.Right - 10 - (intSortImageWidth div 2), ARect.Bottom -
            i);
          Canvas.Pen.Color := clBtnHighlight;
          Canvas.LineTo(ARect.Right - 10, ARect.Top + i);
        end
        else
        begin
          Canvas.Pen.Color := clBtnHighlight;
          Canvas.MoveTo(ARect.Right - 10 - (intSortImageWidth div 2), ARect.Top + i);
          Canvas.LineTo(ARect.Right - 10, ARect.Bottom - i);
          Canvas.LineTo(ARect.Right - 10 - intSortImageWidth, ARect.Bottom - i);
          Canvas.Pen.Color := clBtnShadow;
          Canvas.LineTo(ARect.Right - 10 - (intSortImageWidth div 2), ARect.Top + i);
        end;
      end;
    end;
  end
end;

procedure TJcDBGrid.DrawColumnCell(const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if Odd(self.DataSource.DataSet.RecNo) then
  begin
    self.Canvas.Brush.Color := ColorFirst;
    self.Canvas.Font.Color := $00676767;
  end
  else
  begin
    self.Canvas.Brush.Color := ColorSecond;
    self.Canvas.Font.Color := $00676767;
  end;

  if (gdSelected in State) then
  begin
    self.Canvas.Brush.Color := ColorSelected;
    self.Canvas.Font.Color := clBlack;
    self.Canvas.Font.style := [fsBold];
  end;

  self.Canvas.FillRect(rect);
  self.DefaultDrawColumnCell( Rect, DataCol, Column, State);

  self.Canvas.TextRect(Rect, Rect.Left + 8, Rect.Top + 8, Column.Field.DisplayText);
end;

procedure TJcDBGrid.DrawDataCell(Sender: TObject; const Rect: TRect;
  Field: TField; State: TGridDrawState);
begin
  FormatColumns()
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
   if Message.ScrollCode = SB_THUMBTRACK then
      Message.ScrollCode := SB_THUMBPOSITION;

  inherited;
end;

{ TJcSortColumn }

constructor TJcSortColumn.Create(ASortCaption: String; ASortType: TjSortType);
begin
  SetSortCaption(ASortCaption);
  SetSortType(ASortType);
end;

destructor TJcSortColumn.Destroy;
begin
  
  inherited;
end;

procedure TJcSortColumn.SetSortCaption(Value: String);
begin
  if FSortCaption <> Value then
    FSortCaption := Value;
end;

procedure TJcSortColumn.SetSortType(Value: TjSortType);
begin
  if FSortType <> Value then
    FSortType := Value;
end;

end.
