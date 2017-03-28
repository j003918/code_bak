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
  //��̬������¼����
  with TfrmLogin.Create(nil) do
  begin
    //ֻ�з���OK��ʱ����Ϊ��¼�ɹ�
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
    StatusText := ('��ʼ��ʼ���ڴ�...');
    FCacheHash := TStringHashMap.Create(CaseInsensitiveTraits, 255);
    FCurrentClients := TList.Create;
    //VST.NodeDataSize := SizeOf(TTagCustomListItem);
    //VST.RootNodeCount := 2;
    VST.NodeDataSize := SizeOf(TMyTreeNodeDate);
    StatusText :=('��ʼ���ڴ����');

    StatusText :=('��ʼ���ؿͻ����б�...');
    BuildGroupTree;
    StatusText :=('���ؿͻ����б����');

    StatusText :=('��ʼ���ط�����Ϣ...');
    AddELVDefaultGroup;
    StatusText :=('��ʼ��ʼ���ڴ�');

    StatusText :=('��ʼ��ʼ������...');
    G_DefNetImpl := TDefNetImpl.Create();
    G_DefNetImpl.RegisterObserver(Self);
    StatusText :=('ȫ�����ݼ�����ϣ����򼴽�����...');
    }
end;

end.
