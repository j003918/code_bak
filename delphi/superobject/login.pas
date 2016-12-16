unit login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB;

type
  TfrmLogin = class(TForm)
    GroupBox1: TGroupBox;
    txtUserName: TEdit;
    txtPassWord: TEdit;
    btnLogin: TButton;
    btnClose: TButton;
    Label1: TLabel;
    Label2: TLabel;
    ADOQuery1: TADOQuery;
    procedure btnCloseClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.btnCloseClick(Sender: TObject);
begin
  Close;
  application.Terminate;
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
var
  strConn : string;
begin
  strConn := 'Provider=SQLOLEDB.1;Password=sesan;Persist Security Info=True;User ID=sesan;Initial Catalog=ConCard;Data Source=130.1.10.243';
  adoquery1.ConnectionString := strConn;
  adoquery1.Close;
  adoquery1.SQL.Clear;
  ADOQuery1.ParamCheck:=True;
  ADOQuery1.Parameters.Clear;

  adoquery1.SQL.Add('select * from concard.sesan.user_info where user_name=:username and pass_word=:password');
  adoquery1.parameters.ParamByName('username').Value:= txtUserName.Text;// '179452405';
  adoquery1.parameters.ParamByName('password').Value:= txtPassWord.Text;// '179452405';

  try
    adoquery1.Open;
  except
    on E: Exception do
    begin
      MessageBox(frmlogin.Handle,PAnsiChar(E.Message),'提示',MB_ICONHAND+MB_Ok);
    end;
  end;

  if adoquery1.RecordCount=1 then
    Close
  else
    begin
      MessageBox(frmlogin.Handle,'用户名或密码错误','提示',MB_ICONHAND+MB_Ok);
      txtUserName.Text := '';
      txtPassWord.Text := '';
    end;

end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  txtUserName.Text := '';
  txtPassWord.Text := '';
end;

end.
