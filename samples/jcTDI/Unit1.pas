unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, JcTDIForm, Vcl.ComCtrls,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    JcTDIForm: TJcTDIForm;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    function AppAntesSair: Boolean;
    function ShowForm(AForm: TForm; Coupled: Boolean): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Unit2, Unit3;

function TForm1.AppAntesSair: Boolean;
begin
  Result := True;

  if JcTDIForm.getFormNum > 0 then
  begin
    ShowMessage('There are open windows, please close all windows before closing the application !');
    Result := False;
    abort;
  end;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if Form2 = nil then
    Form2 := TForm2.Create(nil);
  ShowForm(Form2, true);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if Form3 = nil then
    Form3 := TForm3.Create(nil);
  ShowForm(Form3, true);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if AppAntesSair then
    Application.Terminate;
end;

function TForm1.ShowForm(AForm: TForm; Coupled: Boolean): Boolean;
begin
  if Coupled then
  begin
    if not JcTDIForm.getFormName(AForm) then
      JcTDIForm.addForm(AForm);
  end
  else
    AForm.ShowModal;
end;

end.
