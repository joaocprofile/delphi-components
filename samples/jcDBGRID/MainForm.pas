{ Exemplo baixado no site www.AndreCelestino.com }

unit MainForm;

interface

uses
  Winapi.Windows, vcl.forms, Winapi.Messages, System.SysUtils, Data.DB, Datasnap.DBClient,
  System.Classes, Vcl.Controls, Vcl.Grids, Vcl.DBGrids, JcDBGrid,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageXML;

type
  TfDicasDBGrid = class(TForm)
    DataSource: TDataSource;
    FDMemTable: TFDMemTable;
    FDStanStorageXMLLink1: TFDStanStorageXMLLink;
    procedure FormCreate(Sender: TObject);
  end;

var
  fDicasDBGrid: TfDicasDBGrid;

implementation

{$R *.dfm}

procedure TfDicasDBGrid.FormCreate(Sender: TObject);
var
  nIndiceColunaCidade: smallint;
begin
  FDMemTable.LoadFromFile(ExtractFilePath(Application.ExeName) + 'data.xml');
  FDMemTable.First;
end;

end.
