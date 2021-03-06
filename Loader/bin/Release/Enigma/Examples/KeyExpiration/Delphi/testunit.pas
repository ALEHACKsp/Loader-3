unit testunit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmMain = class(TForm)
    lbUserName: TLabel;
    eUserName: TEdit;
    lbKey: TLabel;
    mKey: TMemo;
    Bevel1: TBevel;
    Bevel2: TBevel;
    lbKeyExpiration: TLabel;
    eKeyExpiration: TEdit;
    btnClose: TButton;
    btnRegister: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure OnRegistration(Name, Key : AnsiString);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses enigma_ide;

{$R *.dfm}

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.OnRegistration(Name, Key : AnsiString);
var
  wYear, wMonth, wDay : dword;
begin
  if EP_RegCheckAndSaveKey(PAnsiChar(Name), PAnsiChar(Key)) then
  begin
    if EP_RegKeyExpirationDate(wYear, wMonth, wDay) then
    begin
      eKeyExpiration.Color := clLime;
      eKeyExpiration.Text := format('%.2d/%.2d/%.2d', [wMonth, wDay, wYear]);
    end else
    begin
      eKeyExpiration.Color := clAqua;
      eKeyExpiration.Text := 'KEY IS NOT TIME LIMITED';
    end;
  end;
end;

procedure TfrmMain.btnRegisterClick(Sender: TObject);
begin
  OnRegistration(AnsiString(eUserName.Text), AnsiString(mKey.Text));
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  name, key : AnsiString;
begin
  if EP_RegistrationLoadKeyA(name, key) then
  begin
    OnRegistration(name, key);
  end;
end;

end.
