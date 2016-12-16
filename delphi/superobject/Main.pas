unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,SOAPHTTPClient, iparkservice,superobject,TPEAPI;

type
  TfrmMain = class(TForm)
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edit_account: TEdit;
    btnWSQuery: TButton;
    btnWSCost: TButton;
    edit_money: TEdit;
    btnTPEQuery: TButton;
    btnTPECost: TButton;
    edit_cardno: TEdit;
    edit_name: TEdit;
    edit_Condition: TEdit;
    edit_balance: TEdit;
    procedure btnWSQueryClick(Sender: TObject);
    procedure btnWSCostClick(Sender: TObject);
    procedure btnTPEQueryClick(Sender: TObject);
    procedure btnTPECostClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
//    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

  HasGetSn : bool ;
  LocalSn : integer  ;
  TotalUpdate :integer;
  LastAcc :Integer;
  cs : TRTLCriticalSection;
  m_List :TList  ;
const

cNetState :array [0..2,0..29] of char = (
                                  '未连接',
                                    '同步中',
                                    '连接正常');


procedure ShowMsg(  ff: string; const Args: array of const);
function ArrayToString( p :PCHAR ; Len : integer ):AnsiString;
procedure FillDateTime(  p : pchar);
function GetSn():integer;

function WLCallBack ( pRec: PtagWhiteListCallBack  ):integer;stdcall;

implementation

{$R *.dfm}



procedure ShowMsg(  ff: string; const Args: array of const);
var
   s : String;
begin
  s := Format( ff , Args );
  Application.MessageBox( pAnsiChar( s ), '' , MB_OK );

end;



function ArrayToString( p :PCHAR ; Len : integer ):AnsiString;
var
	s :AnsiString ;
  i : integer;
begin
    for i:=1 to Len do
    begin
      if( p[i-1] = #0 ) then break;
      s := s + p[i-1];
    end;

    Result := s ;
end;

procedure FillDateTime(  p : pchar);
var
  st : TSystemTime ;
  buf : string[20];
  i : integer;
begin
        GetLocalTime( st );
        buf := Format( '%04d%02d%02d%02d%02d%02d' ,[st.wYear , st.wMonth , st.wDay , st.wHour , st.wMinute  , st.wSecond ]);

        for i:=0 to 13 do
            p[i] := buf[i+1];
end;



function GetSn():integer;
var
  Res : tagTPE_OnLineGetMaxSnRes ;
begin
	//获得流水号
	if not HasGetSn then
	begin
		if (TPE_OnLineGetMaxSn( 1 , @Res , 1 ) <> 0)  and (Res.RetValue <> 0)   then
		begin
			result := 1;
      exit;
		end;
		HasGetSn := true ;
		LocalSn  := Res.MaxSn ;
    Result := 0;
		Exit;
	end
	else
  begin
    Result := 0;
		Exit;
  end;
end;


function WLCallBack ( pRec: PtagWhiteListCallBack  ):integer;stdcall;
var
  P : ptagWhiteListCallBack     ;
begin
	EnterCriticalSection( cs );
   p := PtagWhiteListCallBack   ( AllocMem( sizeof(tagWhiteListCallBack)));
   p^ := pRec^;
   m_List.Add( p );

	LeaveCriticalSection( cs );
	Result := 0;
end;


procedure TfrmMain.btnWSQueryClick(Sender: TObject);
var
  Server:IParkServiceSoap;
  str_MAC : WideString;
  str_RST : WideString;
  jo: ISuperObject;
begin
  str_MAC := 'Synj0nes$'+edit_account.text+'$senOjnyS';
  Server  := GetIParkServiceSoap(true,'',nil);

  edit_money.Text := '0';
  edit_balance.Text := '';
  edit_cardno.Text  := '';
  edit_Condition.Text := '';
  edit_name.Text := '';

  str_RST := server.TPE_GetAccount('12',edit_account.text,'',str_MAC);
  //memo1.Text := str_RST;


  jo := TSuperObject.ParseString(pwidechar(str_RST),true);
  if jo['Result'].AsString = 'ok' then
  begin
    edit_balance.Text := floattostr(jo['Data']['Balance'].AsInteger/10000.0);
    edit_cardno.Text  := jo['Data']['CardNo'].AsString;
    //edit_Condition.Text := jo['Data']['Condition'].AsString;
    edit_Condition.Text := IntToHex( jo['Data']['Condition'].AsInteger , 8 ) ;
    edit_name.Text := jo['Data']['Name'].AsString;
  end
  else
    edit_balance.Text := str_RST
end;

procedure TfrmMain.btnWSCostClick(Sender: TObject);
var
  Server:IParkServiceSoap;
  str_MAC : WideString;
  str_RST : WideString;
  jo: ISuperObject;
begin
  str_MAC := 'Synj0nes$'+edit_account.text+'$'+intToStr(Trunc(strToFloat(edit_money.Text)*-10000))+'$senOjnyS';
  Server  := GetIParkServiceSoap(true,'',nil);
  str_RST := server.TPE_FlowCost('12',edit_account.text,'',intToStr(Trunc(strToFloat(edit_money.Text)*-10000)),str_MAC);
  jo := TSuperObject.ParseString(pwidechar(str_RST),true);

  if jo['Result'].AsString = 'ok' then
    showMessage('消费成功')
  else
    showMessage('消费失败');

end;

procedure TfrmMain.btnTPEQueryClick(Sender: TObject);
var
  nRet : integer;
	Req : tagTPE_GetAccountReq ;
	Res : tagTPE_GetAccountRes ;
begin

      FillChar( Req , sizeof(Req) , 0 );
      FillChar( Res , sizeof(Res) , 0 );

      Req.AccountNo   := StrToInt( Edit_Account.Text );
      Req.resflagName := 1;
      req.resflagCondition := 1;
      req.resflagCardNo := 1;
      req.resflagBalance := 1;

      nRet := TPE_GetAccount( 1 , @Req , @Res , 1 ) ;
      ShowMsg( 'TPE_GetAccount Return:%d , Res.RetValue:%d' , [nRet , Res.RetValue ]);

      if (nRet = 0) and  ( Res.RetValue = 0 ) then
      begin
        edit_Condition.Text := IntToHex( Res.Condition , 8 ) ;
        edit_name.Text :=  ArrayToString( pchar(@Res.Name[0]) , sizeof(Res.Name) );
        edit_cardno.Text := IntToStr(res.CardNo);
        edit_balance.Text  := FloatToStr(res.Balance/10000.0);
      end;
end;

procedure TfrmMain.btnTPECostClick(Sender: TObject);
var
   Req :  tagTPE_FlowCostReq ;
   Res :  tagTPE_FlowCostRes ;
   nRet : integer;
begin
	//获得流水号
	if( GetSn() <> 0 ) then
	begin
			ShowMsg( '无法获得流水号' , []);
			exit;
	end;

        FillChar( Req  , sizeof(Req) ,0  );
        FillChar( Res  , sizeof(Res), 0 );


        FillDateTime( Req.OccurTime );
        Req.TranOper := 0;

        Req.CostType := 11;
        Req.AccountNo:= 0;
        req.CardNo := StrToInt( edit_cardno.Text );

        Req.TransMoney := Trunc(strToFloat(edit_money.Text)*-10000);

        Inc(LocalSn);
        Req.OccurIdNo :=  LocalSn ;

		    nRet := TPE_FlowCost( 1 , @Req , 1 , @Res , 1 );

		    ShowMsg( 'TPE_FlowCost ret :%d , %d' ,[ nRet , Res.RecordError]);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
	InitializeCriticalSection( cs );

	TPE_SetCallBack_WhiteList( WLCallBack );
  TPE_StartTPE();

	TPE_StartWLNotify();
  m_List := TList.Create;
end;

end.
