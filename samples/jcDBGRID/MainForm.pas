{ Exemplo baixado no site www.AndreCelestino.com }

unit MainForm;

interface

uses
  Winapi.Windows, vcl.forms, Winapi.Messages, System.SysUtils, Data.DB, Datasnap.DBClient,
  System.Classes, Vcl.Controls, Vcl.Grids, Vcl.DBGrids, JcDBGrid;

type
  TfDicasDBGrid = class(TForm)
    ClientDataSet: TClientDataSet;
    ClientDataSetCodigo: TIntegerField;
    ClientDataSetNome: TStringField;
    ClientDataSetAtivo: TStringField;
    DataSource: TDataSource;
    ClientDataSetCidade: TStringField;
    JcDBGrid1: TJcDBGrid;
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
  ClientDataSet.LoadFromFile(ExtractFilePath(Application.ExeName) + 'data.xml');
  ClientDataSet.First;
end;

end.
