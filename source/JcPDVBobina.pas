{******************************************************************************}
{ Jc Components                                                                }
{ Library created inherited from TWebBrowser VCL                               }
{                                                                              }
{ Copyright(c) 2006 - João Carvalho -                                          }
{ GitHub: https://github.com/joaokvalho                                        }
{                                                                              }
{******************************************************************************
{* Historic                                                                    }
{*                                                                             }
{* 27/11/2019:  João Carvalho                                                  }
{* - First Version: Creation and Distribution of the First Version             }
{                                                                              }
{* - Componente criado baseado nos exemplos do projeto                         }
{*   ACbr - www.projetoacbr.com.br                                             }
{******************************************************************************}

unit JcPDVBobina;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, SHDocVw;

type
  IItem = interface
  ['{28D3A67C-C27D-478D-AC78-7A877D975618}']
  end;

  TJcPDVBobina = class(TComponent)
  private
    FHeaderEndereco: String;
    FHeaderFantasia: String;
    FHeaderCidade: String;
    FHeaderEstado: String;
    FHeaderCNPJ: String;
    FHeaderCep: String;
    FHeaderIE: String;
    FWebBrowser: TWebBrowser;
    FTemplate: TStringBuilder;
    procedure WB_ScrollToBottom(WebBrowser1: TWebBrowser);
    procedure WB_ScrollToTop(WebBrowser1: TWebBrowser);
  protected
    function TemplateHeader(): String;
    function TemplateEnd(): String;
    function GetCupomHeader(): String;
    procedure renderHTML(AHTMLCode: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function ShowMesage(AText: String): String;
    function ShowImage(AURL: String; ATitleAlt: String = ''; AWidth: Integer = 0; Aheight: Integer = 0): String;

    function IniciaVenda: String;
  published
    property WebBrowser: TWebBrowser read FWebBrowser write FWebBrowser;
    property HeaderFantasia: String read FHeaderFantasia write FHeaderFantasia;
    property HeaderEndereco: String read FHeaderEndereco write FHeaderEndereco;
    property HeaderCidade: String read FHeaderCidade write FHeaderCidade;
    property HeaderEstado: String read FHeaderEstado write FHeaderEstado;
    property HeaderCep: String read FHeaderCep write FHeaderCep;
    property HeaderCNPJ: String read FHeaderCNPJ write FHeaderCNPJ;
    property HeaderIE: String read FHeaderIE write FHeaderIE;

    property Template: TStringBuilder read FTemplate write FTemplate;
  end;

procedure Register;

implementation

uses
  Winapi.Windows, Vcl.Forms, Winapi.Messages, MSHTML, Winapi.ActiveX;

{ TJcPDVBobina }

procedure Register;
begin
  RegisterComponents('Jc Components', [TJcPDVBobina]);
end;

constructor TJcPDVBobina.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTemplate := TStringBuilder.Create;
end;

destructor TJcPDVBobina.Destroy;
begin
  FTemplate.Free;

  inherited Destroy;
end;

procedure TJcPDVBobina.WB_ScrollToBottom(WebBrowser1: TWebBrowser);
var
  scrollpos: Integer;
  pw: IHTMLWindow2;
  Doc: IHTMLDocument2;
begin
  Doc := WebBrowser1.Document as IHTMLDocument2;
  pw := IHTMLWindow2(Doc.parentWindow);
  scrollpos := pw.screen.height;
  pw.scrollBy(0, scrollpos);
end;

procedure TJcPDVBobina.WB_ScrollToTop(WebBrowser1: TWebBrowser);
var
  scrollpos: Integer;
  pw: IHTMLWindow2;
  Doc: IHTMLDocument2;
begin
  Doc := WebBrowser1.Document as IHTMLDocument2;
  pw := IHTMLWindow2(Doc.parentWindow);
  scrollpos := pw.screen.height;
  pw.scrollBy(0, -scrollpos);
end;

function TJcPDVBobina.ShowImage(AURL: String; ATitleAlt: String = ''; AWidth: Integer = 0; Aheight: Integer = 0): String;
var
  sBuilder: TStringBuilder;
  sWidth, sHeight: String;
begin
  sBuilder := TStringBuilder.Create;
  try
    if AWidth > 0 then
      sWidth := 'width="'+AWidth.ToString+'" ';

    if Aheight > 0 then
      sHeight := 'height="'+Aheight.ToString+'" ';

    sBuilder
      .AppendLine( TemplateHeader )
      .AppendLine('<div class="item-imagem">')
      .AppendLine('  <img src="' + AURL + '" alt="'+ATitleAlt+'" ' +sWidth + ' '+ sHeight + '  >')
      .AppendLine('</div>')
      .AppendLine( TemplateEnd );

    renderHTML(sBuilder.ToString);
  finally
    sBuilder.Free;
  end;
end;

function TJcPDVBobina.ShowMesage(AText: String): String;
var
  sBuilder: TStringBuilder;
begin
  sBuilder := TStringBuilder.Create;
  try
    sBuilder
      .AppendLine( TemplateHeader )
      .AppendLine('<hr>')
      .AppendLine('<br>')
      .AppendLine('<div class="body-msg">')
      .AppendLine('  <h1>'+ AText +'</h1>')
      .AppendLine('</div>')
      .AppendLine('<br>')
      .AppendLine('<hr>')
      .AppendLine( TemplateEnd );

    renderHTML(sBuilder.ToString);
  finally
    sBuilder.Free;
  end;
end;

function TJcPDVBobina.IniciaVenda: String;
var
  sBuilder: TStringBuilder;
begin
  sBuilder := TStringBuilder.Create;
  try
    sBuilder
      .AppendLine( TemplateHeader )
      .AppendLine( GetCupomHeader )
      .AppendLine( TemplateEnd );

    renderHTML(sBuilder.ToString);
  finally
    sBuilder.Free;
  end;
end;

function TJcPDVBobina.GetCupomHeader: String;
var
  sBuilder: TStringBuilder;
begin
  sBuilder := TStringBuilder.Create;
  try
    sBuilder
      .AppendLine('<div class="header-cupom">')
      .AppendLine('  <center><b>' + FHeaderFantasia + '</b></center>')
      .AppendLine('  <center>' + FHeaderEndereco + '</center>')
      .AppendLine('  <center>' +FHeaderCidade+ ' - '+FHeaderEstado+' - '+FHeaderCep+'</center>')
      .AppendLine('  <center>CNPJ: '+FHeaderCNPJ+' IE: '+FHeaderIE+'</center>')
      .AppendLine('</div>')

      .AppendLine('<table width=100%>')
      .AppendLine('  <tr>')
      .AppendLine('      <td align=left>')
      .AppendLine('          <code><b>28/11/2019</b></code>')
      .AppendLine('          <code><b>11:00:00</b></code>')
      .AppendLine('      </td>')
      .AppendLine('      <td align=right>')
      .AppendLine('          <code>COO: <b>012451</b></code>')
      .AppendLine('      </td>')
      .AppendLine('  </tr>')
      .AppendLine('</table>')

      .AppendLine('<hr>')
      .AppendLine('<table width=100%>')
      .AppendLine('  <tr class="header-cupom">')
      .AppendLine('      <td align=left>')
      .AppendLine('          ITEM DESCRICAO')
      .AppendLine('      </td>')
      .AppendLine('      <td align=right>')
      .AppendLine('          QTD x UNITARIO VALOR (R$)')
      .AppendLine('      </td>')
      .AppendLine('  </tr>')
      .AppendLine('</table>')
      .AppendLine('<hr>');

    result := sBuilder.ToString;
  finally
    sBuilder.Free;
  end;
end;

procedure TJcPDVBobina.renderHTML(AHTMLCode: String);
var
  sl: TStringList;
  ms: TMemoryStream;
begin
  if not Assigned(WebBrowser) then
    exit;

  WebBrowser.Navigate('about:blank');
  while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

  if Assigned(WebBrowser.Document) then
  begin
    sl := TStringList.Create;
    try
      ms := TMemoryStream.Create;
      try
        sl.Text := AHTMLCode;
        sl.SaveToStream(ms);
        ms.Seek(0, 0);
        (WebBrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(ms));
      finally
        ms.Free;
      end;
    finally
      sl.Free;
    end;
    WB_ScrollToBottom(WebBrowser);
  end;
end;

function TJcPDVBobina.TemplateHeader: String;
var
  sBuilder: TStringBuilder;
begin
  sBuilder := TStringBuilder.Create;
  try
    sBuilder
      .AppendLine('<!DOCTYPE html>')
      .AppendLine('<html lang="pt-BR">')
      .AppendLine('<head>')
      .AppendLine('  <meta charset="utf-8">')
      .AppendLine('  <style>')
      .AppendLine('      body {')
      .AppendLine('          font-family: Lucida Console, Arial, Helvetica, sans-serif;')
      .AppendLine('          font-size: 12px;')
      .AppendLine('      }')

      .AppendLine('      .header-cupom {')
      .AppendLine('          font-size: 14px;')
      .AppendLine('          color: gray;')
      .AppendLine('      }')

      .AppendLine('      .title-cupom {')
      .AppendLine('          font-size: 14px;')
      .AppendLine('          color: gray;')
      .AppendLine('      }')

      .AppendLine('      .body-msg {')
      .AppendLine('          color: black;')
      .AppendLine('          text-align: center;')
      .AppendLine('      }')

      .AppendLine('      .item {')
      .AppendLine('          padding: 8px 0;')
      .AppendLine('      }')

      .AppendLine('      .item-imagem {')
      .AppendLine('          text-align: center;')
      .AppendLine('      }')
      .AppendLine('  </style>')
      .AppendLine('</head>')
      .AppendLine('<body>');

    result := sBuilder.ToString;
  finally
    sBuilder.Free;
  end;
end;

function TJcPDVBobina.TemplateEnd: String;
var
  sBuilder: TStringBuilder;
begin
  sBuilder := TStringBuilder.Create;
  try
    sBuilder
      .AppendLine('</body>')
      .AppendLine('</html>');

    result := sBuilder.ToString;
  finally
    sBuilder.Free;
  end;
end;

end.
