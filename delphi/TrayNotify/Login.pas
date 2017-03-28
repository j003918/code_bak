unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmLogin = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    btn_login: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure btn_loginClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  function doLogin :Boolean;
  //function aa() : Boolean;

var
  frmLogin: TfrmLogin;
   //function login:string;

implementation

{$R *.dfm}


function doLogin: Boolean;
begin
  //动态创建登录窗口
  with TfrmLogin.Create(nil) do
  begin
    //只有返回OK的时候认为登录成功
    Result := ShowModal() = mrOk;
    Free;
  end;
end;

procedure TfrmLogin.btn_loginClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

procedure TfrmLogin.Button2Click(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
  Exit;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin    {
with SplashForm do
  try
    StatusText := ('开始初始化内存...');
    FCacheHash := TStringHashMap.Create(CaseInsensitiveTraits, 255);
    FCurrentClients := TList.Create;
    //VST.NodeDataSize := SizeOf(TTagCustomListItem);
    //VST.RootNodeCount := 2;
    VST.NodeDataSize := SizeOf(TMyTreeNodeDate);
    StatusText :=('初始化内存完成');

    StatusText :=('开始加载客户端列表...');
    BuildGroupTree;
    StatusText :=('加载客户端列表完成');

    StatusText :=('开始加载分组信息...');
    AddELVDefaultGroup;
    StatusText :=('开始初始化内存');

    StatusText :=('开始初始化数据...');
    G_DefNetImpl := TDefNetImpl.Create();
    G_DefNetImpl.RegisterObserver(Self);
    StatusText :=('全部数据加载完毕，程序即将启动...');
    }
end;

end.
