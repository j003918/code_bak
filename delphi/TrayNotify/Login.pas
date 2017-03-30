unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmLogin = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    Button4: TButton;
    procedure btn_loginClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   // Self.ModalResult := mrCancel;
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
