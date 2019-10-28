program Project;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {fDicasDBGrid};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfDicasDBGrid, fDicasDBGrid);
  Application.Run;
end.
