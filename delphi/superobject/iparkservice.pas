// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://130.1.10.243:8001/iparkservice.asmx?wsdl
// Encoding : utf-8
// Version  : 1.0
// (2016/2/19 9:40:51 - 1.33.2.5)
// ************************************************************************ //

unit iparkservice;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // binding   : IParkServiceSoap
  // service   : IParkService
  // port      : IParkServiceSoap
  // URL       : http://130.1.10.243:8001/iparkservice.asmx
  // ************************************************************************ //
  IParkServiceSoap = interface(IInvokable)
  ['{B777B29C-E8E1-B2F6-DB85-A38DE8AF6B4A}']
    function  TPE_GetAccount(const NodeNo: WideString; const AccountNo: WideString; const CardNo: WideString; const MAC: WideString): WideString; stdcall;
    function  TPE_QueryStdAccount(const NodeNo: WideString; const BeginNo: WideString; const EndNo: WideString; const MAC: WideString): WideString; stdcall;
    function  TPE_QueryFlowByCenter(const NodeNo: WideString; const FromCentralNo: WideString; const ToCentralNo: WideString; const MAC: WideString): WideString; stdcall;
    function  TPE_ConfigEnumDept(const NodeNo: WideString; const MAC: WideString): WideString; stdcall;
    function  TPE_ConfigEnumIdenti(const NodeNo: WideString; const MAC: WideString): WideString; stdcall;
    function  TPE_Lost(const NodeNo: WideString; const AccountNo: WideString; const PassWord: WideString; const Operation: WideString; const MAC: WideString): WideString; stdcall;
    function  TPE_GetAccountEx(const NodeNo: WideString; const AccountNo: WideString; const MAC: WideString): WideString; stdcall;
    function  TPE_CheckPassword(const NodeNo: WideString; const AccountNo: WideString; const CardNo: WideString; const PassWord: WideString; const MAC: WideString): WideString; stdcall;
    function  TPE_ChangeAccountPassword(const NodeNo: WideString; const AccountNo: WideString; const CardNo: WideString; const OldPassWord: WideString; const NewPassWord: WideString; const MAC: WideString): WideString; stdcall;
    function  TPE_FlowUpdateAccount(const NodeNo: WideString; const AccountNo: WideString; const CardNo: WideString; const Tel: WideString; const Email: WideString; const Comment: WideString; const MAC: WideString): WideString; stdcall;
    function  TPE_FlowCost(const NodeNo: WideString; const AccountNo: WideString; const CardNo: WideString; const TransMoney: WideString; const MAC: WideString): WideString; stdcall;
    function  TPE_FlowCostByCertCode(const NodeNo: WideString; const CertCode: WideString; const TransMoney: WideString; const MAC: WideString): WideString; stdcall;
    function  TPE_FlowCostByIDNO(const NodeNo: WideString; const IDNO: WideString; const TransMoney: WideString; const MAC: WideString): WideString; stdcall;
    function  TPE_QueryFlowByNode(const NodeNo: WideString; const FromOccurNo: WideString; const ToOccurNo: WideString; const MAC: WideString): WideString; stdcall;
  end;

function GetIParkServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IParkServiceSoap;


implementation

function GetIParkServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IParkServiceSoap;
const
  defWSDL = 'http://130.1.10.243:8001/iparkservice.asmx?wsdl';
  defURL  = 'http://130.1.10.243:8001/iparkservice.asmx';
  defSvc  = 'IParkService';
  defPrt  = 'IParkServiceSoap';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as IParkServiceSoap);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  InvRegistry.RegisterInterface(TypeInfo(IParkServiceSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterInvokeOptions(TypeInfo(IParkServiceSoap),ioDocument);//此处必须手动添加，delphi无法自动生成
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IParkServiceSoap), 'http://tempuri.org/%operationName%');

end. 