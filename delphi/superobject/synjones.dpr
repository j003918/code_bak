program synjones;

uses
  Forms,
  login in 'login.pas' {frmLogin},
  Main in 'Main.pas' {frmMain},
  iparkservice in 'iparkservice.pas',
  superobject in 'superobject.pas',
  tpeapi in 'TPEAPI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmLogin, frmLogin);
  frmLogin.ShowModal;
  frmLogin.Free;
  Application.Run;
end.
