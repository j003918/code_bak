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

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   // Self.ModalResult := mrCancel;
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
