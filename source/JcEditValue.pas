{******************************************************************************}
{ Jc Components                                                                }
{ Library created inherited from TEdit VCL                                    }
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

unit JcEditValue;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs,  StdCtrls, JcCustomClass;

type
  TJcEditValue = class(TJcCustomEdit)
  private
    FValueFormat: Boolean;
  protected
    procedure Change; override;
  public
    constructor Create(AOwner : TComponent); override;
  published
    property  ValueFormat : Boolean read FValueFormat write FValueFormat default false;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Jc Components', [TJcEditValue]);
end;

procedure TJcEditValue.Change;
var
   s : string;
   v : double;
   I : integer;
begin
  inherited;
   if ValueFormat then
   begin
     Alignment := taRightJustify;
     If (Text = emptystr) then
        Text := '0,00';
     s := '';
     for I := 1 to length(Text) do
     if (text[I] in ['0'..'9']) then
        s := s + text[I];
     v := strtofloat(s);
     v := (v /100);
     text := FormatFloat('###,##0.00',v);
     SelStart := Length(text);   //
   end;
end;

constructor TJcEditValue.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FValueFormat := False;
  Alignment := taLeftJustify;
end;

end.
