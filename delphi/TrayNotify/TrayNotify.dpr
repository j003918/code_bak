program TrayNotify;

{$R *.dres}

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  Login in 'Login.pas' {frmLogin},
  Splash in 'Splash.pas' {frmSplash};

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.MainFormOnTaskbar := False;
   {
  frmSplash := TfrmSplash.Create(Application);
  frmSplash.Show;
  frmSplash.Update;

  frmSplash.StatusText := '׼������...';
  frmSplash.Update;
    }
  try
    Application.CreateForm(TfrmMain, frmMain);
  finally
    {
    frmSplash.StatusText := '�������...';
    frmSplash.Update;
    frmSplash.Close;
    }
  end;
  {
  if login.doLogin() then Application.Run;
  }
  Application.Run;
end.
