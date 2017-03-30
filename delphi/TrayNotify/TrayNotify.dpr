program TrayNotify;



uses
  Forms,
  Login in 'Login.pas' {frmLogin},
  Splash in 'Splash.pas' {frmSplash},
  Main in 'Main.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.MainFormOnTaskbar := False;
  {
  frmSplash := TfrmSplash.Create(Application);
  frmSplash.Show;
  frmSplash.Update;

  frmSplash.StatusText := '准备启动...';
  frmSplash.Update;
  }
  try
    Application.CreateForm(TfrmMain, frmMain);
  finally
  {
    frmSplash.StatusText := '完成启动...';
    frmSplash.Update;
    frmSplash.Close;
   }
  end;

  if login.doLogin() then Application.Run;

end.
