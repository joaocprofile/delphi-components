unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw,
  JcPDVBobina;

type
  TForm1 = class(TForm)
    JcPDVBobina1: TJcPDVBobina;
    WebBrowser1: TWebBrowser;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  JcPDVBobina1.IniciaVenda;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  JcPDVBobina1.ShowMesage('PRODUTO')
end;

end.
