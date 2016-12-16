//*******************************************************************************************************
//    �����������µ��ӹɷ����޹�˾��Ȩ����,2003.6
//
//    TPEAPI.H
//
//    �������ӿ�(TPE) ���������ݽṹ����
//
//    For( Delphi) 2003.11.04
//
//*******************************************************************************************************

unit tpeapi;

interface

type

            //�����ṹ����
            {$A-}

//*******************************************************************************************************************
            //���Ͷ���
            UINT                  = Cardinal	;
            LINT                  = int64;
            LONG                  = integer;
            TArrayTime            = Array[0..13] of char;
            TArrayName            = Array[0..15] of char;
            TArrayPersonID        = Array[0..17] of char;
            TArrayPassword        = Array[0..7 ] of BYTE;
            TArrayAccessControl   = Array[0..15] of BYTE;
            TArrayCertCode        = Array[0..17] of char;
            TArrayCreditCardNo    = Array[0..23] of char;
            TArrayTel             = Array[0..47] of char;
            TArrayEmail           = Array[0..47] of char;
            TArrayPostalCode      = Array[0..5 ] of char;
            TArrayPostalAddr      = Array[0..99] of char;
            TArrayFileName        = Array[0..15] of char;
//*******************************************************************************************************************
            //������֪ͨ
            tagWhiteListCallBack = record
              AccountNo :  UINT		; //�ʺ�
              CardNo    :  UINT		; //����
              Condition :  UINT   ; //״̬
              Balance   :  LONG   ; //���
              Depart    :  LINT		; //����
              Identi    :  WORD		;	//���
            end;
            PtagWhiteListCallBack = ^ tagWhiteListCallBack;

            //������
            tagWhiteListRec = record
              AccountNo :  UINT		; //�ʺ�
              CardNo    :  UINT		;	//����
              Condition :  UINT		;	//״̬
              Balance   :  LONG   ; //���
              Depart    :  LINT		; //����
              Identi    :  WORD		; //���
              Sign      :  BYTE		; //ǩ��
            end;
            PtagWhiteListRec = ^tagWhiteListRec;

            //��ˮ֪ͨ�ṹ
            tagNodeNotifyInfo = record
              CurrentCentralNo :UINT	;
            end;
            PtagNodeNotifyInfo = ^tagNodeNotifyInfo;

            //��ˮ֪ͨӦ��
            tagNodeNotifyInfoRes = record
              NotiyfWait : UINT	;
            end;
            PtagNodeNotifyInfoRes = ^ tagNodeNotifyInfoRes;


//**************************************************����*****************************************************************
            //�����ʻ���������
            tagTPE_GetAccountReq = record

                  //���ʺ�.����
                  AccountNo            : UINT;         
                  CardNo               : UINT;

                  //�Ƿ���Ҫ����
                  reqflagPassword      : BYTE;
                  Password             : TArrayPassword ;

                  //���ر�־
                  resflagAccountNo     : BYTE;
                  resflagCardNo        : BYTE;
                  resflagCondition     : BYTE;
                  resflagBalance       : BYTE;
                  resflagCreateTime    : BYTE;
                  resflagExpireDate    : BYTE;
                  resflagName          : BYTE;
                  resflagPersonID      : BYTE;
                  resflagPassword      : BYTE;
                  resflagAccessControl : BYTE;
                  resflagBirthday      : BYTE;
                  resflagDepart        : BYTE;
                  resflagIdenti        : BYTE;
                  resflagNation        : BYTE;
                  resflagCertType      : BYTE;
                  resflagCertCode      : BYTE;
                  resflagCreditCardNo  : BYTE;
                  resflagTransferLimit : BYTE;
                  resflagTransferMoney : BYTE;
                  resflagTel           : BYTE;
                  resflagEmail         : BYTE;
                  resflagPostalCode    : BYTE;
                  resflagPostalAddr    : BYTE;
                  resflagFile          : BYTE;
                  resflagComment       : BYTE;
                  resflagExtend        : BYTE;
                  resflagUpdateTime    : BYTE;
              END;
              PtagTPE_GetAccountReq = ^tagTPE_GetAccountReq;
              //�����ʻ�����Ӧ��
              tagTPE_GetAccountRes = record

                  RetValue             : integer;            //����ֵ

                  AccountNo            : UINT  ;             //�ʺ�
                  CardNo               : UINT  ;             //����
                  Condition            : UINT  ;             //״̬
                  Balance              : LONG  ;             //���
                  CreateTime           : TArrayTime;         //����ʱ��
                  ExpireDate           : TArrayTime;         //��Ч��
                  Name                 : TArrayName;         //����
                  PersonID             : TArrayPersonID;     //���֤��
                  Password             : TArrayPassword;     //����
                  AccessControl        : TArrayAccessControl;//���ʿ���
                  Birthday             : TArrayTime;         //����ʱ��
                  Depart               : LINT;               //���ֱ��
                  Identi               : WORD  ;             //��ݱ��
                  Nation               : WORD  ;             //������
                  CertType             : BYTE  ;             //֤������
                  CertCode             : TArrayCertCode;     //֤������
                  CreditCardNo         : TArrayCreditCardNo; //���п���
                  TransferLimit        : LONG  ;             //ת���޶�
                  TransferMoney        : LONG  ;             //ת�ʽ��
                  Tel                  : TArrayTel;          //�绰
                  Email                : TArrayEmail;        //email
                  PostalCode           : TArrayPostalCode;   //��������
                  PostalAddr           : TArrayPostalAddr;   //����ͨ�ŵ�ַ
                  FileNamePicture      : TArrayFileName  ;   //��Ƭ�ļ�����
                  FileNameFinger       : TArrayFileName  ;   //ָ��
                  FileNameAudio        : TArrayFileName  ;   //����
                  Comment              : array[0..119] of char;//ע��
                  ExtendLen            : integer;              //��չ��Ϣ����
                  Extend               : Array[0..254] of byte;//��չ��Ϣ
                  UpdateTime           : TArrayTime;           //������ʱ��
              end;
              PtagTPE_GetAccountRes = ^tagTPE_GetAccountRes; 

              //��Ӧ��ϵ��������
              tagTPE_GetRelationReq   = record

                  JoinNode             : UINT	;                //�ڵ�
                  JoinCardHolder       : Array[0..23] of char; //��Ӧ��ϵ��/�ʺ�

                  reqflagJoinPassword  : BYTE;                 //�����־
                  JoinPassword         : Array[0..7 ] of BYTE;  //��Ӧ��ϵ����

                  //���ر�־
                  resflagAccountNo     : BYTE;                  
                  resflagCardNo        : BYTE;
                  resflagCondition     : BYTE;
                  resflagBalance       : BYTE;
                  resflagCreateTime    : BYTE;
                  resflagExpireDate    : BYTE;
                  resflagName          : BYTE;
                  resflagPersonID      : BYTE;
                  resflagPassword      : BYTE;
                  resflagAccessControl : BYTE;
                  resflagBirthday      : BYTE;
                  resflagDepart        : BYTE;
                  resflagIdenti        : BYTE;
                  resflagNation        : BYTE;
                  resflagCertType      : BYTE;
                  resflagCertCode      : BYTE;
                  resflagCreditCardNo  : BYTE;
                  resflagTransferLimit : BYTE;
                  resflagTransferMoney : BYTE;
                  resflagTel           : BYTE;
                  resflagEmail         : BYTE;
                  resflagPostalCode    : BYTE;
                  resflagPostalAddr    : BYTE;
                  resflagFile          : BYTE;
                  resflagComment       : BYTE;
                  resflagExtend        : BYTE;
                  resflagUpdateTime    : BYTE;

                  resflagJoinIndex     : BYTE;
                  resflagJoinNode      : BYTE;
                  resflagJoinCardHolder: BYTE;
                  resflagJoinPassword  : BYTE;
                  resflagJoinCondition : BYTE;
                  resflagJoinComment   : BYTE;
                  resflagJoinUpdateTime: BYTE;
              end;
              PtagTPE_GetRelationReq   = ^tagTPE_GetRelationReq;

              //��Ӧ��ϵ����Ӧ��
              tagTPE_GetRelationRes = record

                  RetValue             : integer;

                  AccountNo            : UINT;
                  CardNo               : UINT;
                  Condition            : UINT;
                  Balance              : LONG;
                  CreateTime           : TArrayTime;
                  ExpireDate           : TArrayTime;
                  Name                 : TArrayName;
                  PersonID             : TArrayPersonID;
                  Password             : TArrayPassword;
                  AccessControl        : TArrayAccessControl;
                  Birthday             : TArrayTime;
                  Depart               : LINT ;
                  Identi               : WORD;
                  Nation               : WORD;
                  CertType             : BYTE; 
                  CertCode             : TArrayCertCode;
                  CreditCardNo         : TArrayCreditCardNo;
                  TransferLimit        : LONG;
                  TransferMoney        : LONG;
                  Tel                  : TArrayTel;
                  Email                : TArrayEmail;
                  PostalCode           : TArrayPostalCode;
                  PostalAddr           : TArrayPostalAddr;
                  FileNamePicture      : TArrayFileName;
                  FileNameFinger       : TArrayFileName;
                  FileNameAudio        : TArrayFileName;
                  Comment              : Array[0..119] of char;
                  ExtendLen            : integer;
                  Extend               : Array[0..254] of byte;
                  UpdateTime           : TArrayTime;

                  JoinIndex            : UINT ;                    //�ʺ�
                  JoinNode             : UINT ;                    //�ڵ��
                  JoinCardHolder       : Array[0..23]  of char;    //��Ӧ��ϵ��.����
                  JoinPassword         : TArrayPassword;           //��Ӧ��ϵ����
                  JoinCondition        : UINT;                     //��Ӧ��ϵ�ʻ�״̬
                  JoinComment          : Array[0..119] of char;    //ע��
                  JoinUpdateTime       : TArrayTime;               //������ʱ��
              end;
              PtagTPE_GetRelationRes = ^tagTPE_GetRelationRes;



//******************************************************��ѯ*************************************************************
              //��׼�ʻ���ѯ
              tagTPE_QueryStdAccountReq = record

                  reqflagAccountNoRange : byte;
                  reqflagCondition      : byte;
                  reqflagBalanceRange   : byte;
                  reqflagCreateTimeRange: byte;
                  reqflagExpireDateRange: byte;
                  reqflagName           : byte;
                  reqflagPersonID       : byte;
                  reqflagBirthdayRange  : byte;
                  reqflagDepart         : byte;
                  reqflagIdenti         : byte;
                  reqflagNation         : byte;
                  reqflagTel            : byte;
                  reqflagEmail          : byte;

                  AccountNoRange        : Array[0.. 1] of UINT;
                  Condition             : Array[0.. 1] of UINT;
                  BalanceRange          : Array[0.. 1] of LONG;
                  CreateTimeRange       : Array[0..27] of char;
                  ExpireDateRange       : Array[0..27] of char;
                  Name                  : TArrayName;
                  PersonID              : TArrayPersonID;
                  BirthdayRange         : Array[0..27] of char;
                  Depart                : LINT	;
                  Identi                : WORD	;
                  Nation                : WORD	;
                  Tel                   : TArrayTel;
                  Email                 : TArrayEmail;

                  //���ر�־
                  resflagCardNo         : BYTE;
                  resflagCondition      : BYTE;
                  resflagBalance        : BYTE;
                  resflagCreateTime     : BYTE;
                  resflagExpireDate     : BYTE;
                  resflagName           : BYTE;
                  resflagPersonID       : BYTE;
                  resflagPassword       : BYTE;
                  resflagAccessControl  : BYTE;
                  resflagBirthday       : BYTE;
                  resflagDepart         : BYTE;
                  resflagIdenti         : BYTE;
                  resflagNation         : BYTE;
                  resflagCertType       : BYTE;
                  resflagCertCode       : BYTE;
                  resflagCreditCardNo   : BYTE;
                  resflagTransferLimit  : BYTE;
                  resflagTransferMoney  : BYTE;
                  resflagTel            : BYTE;
                  resflagEmail          : BYTE;
                  resflagPostalCode     : BYTE;
                  resflagPostalAddr     : BYTE;
                  resflagFile           : BYTE;
                  resflagComment        : BYTE;
                  resflagExtend         : BYTE;
                  resflagUpdateTime     : BYTE;
              end;
              PtagTPE_QueryStdAccountReq = ^tagTPE_QueryStdAccountReq;


              //ͨ���ʻ���ѯӦ����ƽṹ��
              tagTPE_QueryResControl = record
                    ResRecCount : integer;
                    pRes        : pointer;
              end;
              PtagTPE_QueryResControl = ^tagTPE_QueryResControl;
	
              //ͨ���ʻ���ѯ���ؼ�¼
              tagTPE_QueryStdAccountRes = tagTPE_GetAccountRes; 

              //ͨ�ò�ѯ
              tagTPE_QueryGeneralAccountReq = record

                  SQL                 : Array[0..4095] of char;

                  //���ر�־
                  resflagCardNo       : BYTE;
                  resflagCondition    : BYTE;
                  resflagBalance      : BYTE;
                  resflagCreateTime   : BYTE;
                  resflagExpireDate   : BYTE;
                  resflagName         : BYTE;
                  resflagPersonID     : BYTE;
                  resflagBirthday     : BYTE;
                  resflagDepart       : BYTE;
                  resflagIdenti       : BYTE;
                  resflagNation       : BYTE;
                  resflagCertType     : BYTE;
                  resflagCertCode     : BYTE;
                  resflagCreditCardNo : BYTE;
                  resflagTransferLimit: BYTE;
                  resflagTransferMoney: BYTE;
                  resflagTel          : BYTE;
                  resflagEmail        : BYTE;
                  resflagPostalCode   : BYTE;
                  resflagPostalAddr   : BYTE;
                  resflagFile         : BYTE;
                  resflagComment      : BYTE;
                  resflagExtend       : BYTE;
                  resflagUpdateTime   : BYTE;
              end;
              PtagTPE_QueryGeneralAccountReq = ^tagTPE_QueryGeneralAccountReq;

              tagTPE_QueryGeneralAccountRes = tagTPE_QueryStdAccountRes;
              PtagTPE_QueryGeneralAccountRes= ^tagTPE_QueryGeneralAccountRes;

              //��ѯ��Ӧ��ϵ
              tagTPE_QueryRelationReq = record

                  reqflagRangeJoinIndex       : byte;
                  reqflagJoinNode             : byte;
                  reqflagRangeJoinCardHolder  : byte;
                  reqfalgRangeJoinCondition   : byte;

                  RangeJoinIndex              : Array[0..1] of UINT;
                  JoinNode                    : UINT;
                  RangeJoinCardHolder         : Array[0..1,0..23] of char;
                  RangeJoinCondition          : Array[0..1] of UINT;

                  //���ر�־
                  resflagJoinIndex            : byte;
                  resflagJoinNode             : byte;
                  resflagJoinCardHolder       : byte;
                  resflagJoinPassword         : byte;
                  resflagJoinCondition        : byte;
                  resflagJoinComment          : byte;
                  resflagJoinUpdateTime       : byte;
              end;
              PtagTPE_QueryRelationReq = ^tagTPE_QueryRelationReq;

              //��ѯ��Ӧ��ϵӦ��
              tagTPE_QueryRelationRes = record

                  RetValue        : integer;
                  JoinIndex       : UINT ;
                  JoinNode        : UINT ;
                  JoinCardHolder  : Array[0..23] of char;
                  JoinPassword    : TArrayPassword;
                  JoinCondition   : UINT;
                  JoinComment     : Array[0..119] of char;
                  JoinUpdateTime  : TArrayTime;
              end;
              PtagTPE_QueryRelationRes = ^tagTPE_QueryRelationRes;

//**********************************************************����*********************************************************

//              tagTPE_FlowNetLog = record         //����һ���˵����ȼ�:�ʺ�>����>��Ӧ��ϵ,��������:�ʺ�=0-->����=0-->��Ӧ
              //������ˮӦ��
              tagTPE_FlowRes = record
                RecordError : INTEGER  ;
                CenterNo    : UINT  ;
                OccurNode   : UINT  ;
                OccurIdNo   : UINT  ;
                OccurInfo   : UINT  ;
              end;
              PtagTPE_FlowRes = ^tagTPE_FlowRes;

              //������Ӧ��ϵ
              tagTPE_FlowBuildRelationReq = record

                  OccurIdNo           : UINT;
                  OccurTime           : TArrayTime;
                  TranOper            : WORD ;

                  AccountNo           : UINT	;
                  CardNo              : UINT	;
			
                  reqflagJoinPassword : byte;
                  reqflagJoinCondition: byte;
                  reqflagJoinComment	: byte;

                  JoinNode            : UINT	;
                  JoinCardHolder      : Array[0..23] of char;


                  JoinPassword        : TArrayPassword;
                  JoinCondition       : UINT	 ;
                  JoinComment         : Array[0..119] of char;
              end;
              PtagTPE_FlowBuildRelationReq = ^tagTPE_FlowBuildRelationReq;

              tagTPE_FlowBuildRelationRes  = tagTPE_FlowRes;
              PtagTPE_FlowBuildRelationRes = ^tagTPE_FlowBuildRelationRes; 

              //ȡ����Ӧ��ϵ
              tagTPE_FlowCancelRelationReq = record
              
                  OccurIdNo        : UINT  ;
                  OccurTime        : TArrayTime;
                  TranOper         : WORD     ;

                  JoinNode         : UINT	 ;
                  JoinCardHolder   : Array[0..23] of char;
              end;
              PtagTPE_FlowCancelRelationReq = ^tagTPE_FlowCancelRelationReq;
              tagTPE_FlowCancelRelationRes = tagTPE_FlowRes;
              PtagTPE_FlowCancelRelationRes = ^ tagTPE_FlowCancelRelationRes;  


             //��ʧ/���
              tagTPE_LostReq = record
                  OccurIdNo      : UINT     ;
                  OccurTime      : TArrayTime;
                  TranOper       : WORD     ;

                  ReqAccountNo   : UINT	 ;
                  ReqCardNo      : UINT	 ;
                  JoinNode       : UINT	 ;
                  JoinCardHolder : Array[0..23] of char;

                  Operation      : BYTE;       //1 ��ʧ, 2 ���
              end;
              PtagTPE_LostReq  = ^tagTPE_LostReq;
              tagTPE_LostRes   = tagTPE_FlowRes;
              PtagTPE_LostRes  = ^tagTPE_LostRes;

              //����----���»����ʻ�����
              tagTPE_FlowUpdateAccountReq = record

                  OccurIdNo             : UINT     ;
                  OccurTime             : TArrayTime;
                  TranOper              : WORD     ;

                  ReqAccountNo          : UINT	 ;
                  ReqCardNo             : UINT	 ;
                  JoinNode              : UINT	 ;
                  JoinCardHolder        : Array [0..23] of char;

                  reqflagCardNo         : BYTE;
                  reqflagCondition      : BYTE;
                  reqflagExpireDate     : BYTE;
                  reqflagName           : BYTE;
                  reqflagPersonID       : BYTE;
                  reqflagPassword       : BYTE;
                  reqflagAccessControl  : BYTE;
                  reqflagBirthday       : BYTE;
                  reqflagDepart         : BYTE;
                  reqflagIdenti         : BYTE;
                  reqflagNation         : BYTE;
                  reqflagCertType       : BYTE;
                  reqflagCertCode       : BYTE;
                  reqflagCreditCardNo   : BYTE;
                  reqflagTransferLimit  : BYTE;
                  reqflagTransferMoney  : BYTE;
                  reqflagTel            : BYTE;
                  reqflagEmail          : BYTE;
                  reqflagPostalCode     : BYTE;
                  reqflagPostalAddr     : BYTE;
                  reqflagComment        : BYTE;
                  reqflagExtend         : BYTE;
			
                  CardNo                : UINT  ;
                  Condition             : Array[0..1] of UINT  ;
                  ExpireDate            : TArrayTime;
                  Name                  : TArrayName;
                  PersonID              : TArrayPersonID;
                  Password              : TArrayPassword;
                  AccessControl         : TArrayAccessControl;
                  Birthday              : TArrayTime;
                  Depart                : LINT;
                  Identi                : WORD  ;
                  Nation                : WORD  ;
                  CertType              : BYTE  ;
                  CertCode              : TArrayCertCode;
                  CreditCardNo          : TArrayCreditCardNo;
                  TransferLimit         : LONG ;
                  TransferMoney         : LONG  ;
                  Tel                   : TArrayTel;
                  Email                 : TArrayEmail;
                  PostalCode            : TArrayPostalCode;
                  PostalAddr            : TArrayPostalAddr;
                  Comment               : Array[0..119] of char;
                  ExtendLen             : integer;
                  Extend                : Array[0..254] of char;
              end;
              PtagTPE_FlowUpdateAccountReq = ^tagTPE_FlowUpdateAccountReq;

              tagTPE_FlowUpdateAccountRes = tagTPE_FlowRes ;
              PtagTPE_FlowUpdateAccountRes = ^tagTPE_FlowUpdateAccountRes;
              
              //����----���¶�Ӧ��ϵ����
              tagTPE_FlowUpdateRelationReq = record

                  OccurIdNo             : UINT     ;
                  OccurTime             : TArrayTime;
                  TranOper              : WORD ;

                  JoinNode              : UINT ;
                  JoinCardHolder        : Array[0..23] of char;

                  reqflagJoinPassword	  : byte;
                  reqflagJoinCondition	: byte;
                  reqflagJoinComment		: byte;

                  JoinPassword          : TArrayPassword;
                  JoinCondition         : Array[0..1] of UINT;
                  JoinComment           : Array[0..119] of char;
            end;
            PtagTPE_FlowUpdateRelationReq = ^tagTPE_FlowUpdateRelationReq;

              tagTPE_FlowUpdateRelationRes = tagTPE_FlowRes;
              PtagTPE_FlowUpdateRelationRes = tagTPE_FlowUpdateRelationRes; 

              //����----���������
              tagTPE_FlowCostReq = record
                  OccurIdNo       : UINT     ;
                  OccurTime       : TArrayTime;
                  TranOper        : WORD     ;

                  CostType        : WORD     ;

                  AccountNo       : UINT	 ;
                  CardNo          : UINT	 ;
                  JoinNode        : UINT	 ;
                  JoinCardHolder  : Array[0..23]of char;

                  TransMoney      : LONG	 ;

                  LinkOccurNode   : UINT	 ;	//ֻ��FLOW_TYPE_BALANCEEXTRAʱ��Ч
                  LinkOccurIdNo   : UINT	 ;

                  ExtraInfoLen    : integer;
                  ExtraInfo       : Array[0..1199] of byte;
              end;
              PtagTPE_FlowCostReq = ^tagTPE_FlowCostReq;
              tagTPE_FlowCostBaseReq = record

                  OccurIdNo       : UINT     ;
                  OccurTime       : TArrayTime;
                  TranOper        : WORD     ;

                  CostType        : WORD     ;

                  AccountNo       : UINT	 ;
                  CardNo          : UINT	 ;
                  JoinNode        : UINT	 ;
                  JoinCardHolder  : Array[0..23] of char;

                  TransMoney      : LONG	 ;

                  LinkOccurNode   : UINT	 ;
                  LinkOccurIdNo   : UINT	 ;

                  ExtraInfoLen    : integer;
              end;

              tagTPE_FlowCostRes  = tagTPE_FlowRes;
              PtagTPE_FlowCostRes = ^tagTPE_FlowCostRes; 

//************************************����******************************************************************************
              tagTPE_CheckByTimeReq = record//����,��ʱ��

                GathNode : Array[0..127] of BYTE;
                GathType : Array[0..31 ] of BYTE;
                FmTime   : TArrayTime;
                ToTime   : TArrayTime;
              end;
              PtagTPE_CheckByTimeReq = ^tagTPE_CheckByTimeReq;

              tagTPE_CheckByTimeRes = record

                GathNode   : Array [0..127] of UINT	;
                GathType   : Array [0..31 ] of BYTE;
                FmTime     : TArrayTime;
                ToTime     : TArrayTime;
                OccurTimes : UINT	;
                Balance    : LINT	;
              end;
              PtagTPE_CheckByTimeRes = ^tagTPE_CheckByTimeRes;

	
              tagTPE_CheckBySnReq = record//����,����ˮ��
                GathNode : UINT	;
                GathType : Array [0..31] of BYTE ;
                FmSn     : UINT	;
                ToSn     : UINT	;
              end;
              PtagTPE_CheckBySnReq = ^tagTPE_CheckBySnReq;

              tagTPE_CheckBySnRes = record

                GathNode  : UINT	;
                GathType  : Array[0..31]of byte;
                FmSn      : UINT	;
                ToSn      : UINT	;
                OccurTimes:UINT	;
                Balance   : LINT	;
              end;
              PtagTPE_CheckBySnRes = ^tagTPE_CheckBySnRes;
	
              tagTPE_CheckByDetailReq = record//����ϸ
                GathNode : UINT	;
                GathType : Array[0..31] of BYTE	;
                FmSn     : UINT	;
                ToSn     : UINT	;
              end;
              PtagTPE_CheckByDetailReq = ^tagTPE_CheckByDetailReq;

              tagTPE_CheckByDetailRes = record
                GathNode : UINT	;
                GathType : Array[0..31] of BYTE;
                FmSn     : UINT	;
                ToSn     : UINT	;
                MapLen   : UINT	;
                Map      : Array[0..4095]of BYTE ;
              end;
              PtagTPE_CheckByDetailRes = ^tagTPE_CheckByDetailRes;
//*******************************************���߱���*************************************************************************
              //���뵱ǰ�����ˮ��
              tagTPE_OnLineGetMaxSnRes = record
                RetValue : integer ;
                MaxSn    : UINT ;
              end;
              PtagTPE_OnLineGetMaxSnRes = ^tagTPE_OnLineGetMaxSnRes;
//*******************************************���ñ���*************************************************************************              
              //������־
              tagTPE_ConfigEnumLogReq = record
                  RangeConfOrder : Array[0..1] of UINT ;
                  RangeConfigTime: Array[0..1]of TArrayTime;
                  ConfType       : Array[0..31]of BYTE;
              end;
              PtagTPE_ConfigEnumLogReq = ^tagTPE_ConfigEnumLogReq;

              tagTPE_DeptLog = record
                  DeptNo         : Array[0..1] of LINT;
                  Code           : Array[0..1,0..15] of char;
                  Name           : Array[0..1,0..63] of char;
              end;
              tagTPE_IdentiLog = record
                  IdentiNo       : Array[0..1] of WORD ;
                  Code           : Array[0..1,0..15] of char ;
                  Name           : Array[0..1,0..63] of char ;
                  OverDraft      : integer;     //͸֧�޶�
                  Deposit        : integer;     //Ѻ��
                  ManageCoef     : integer;     //�����ϵ��
                  FeeCreate      : integer;     //����������
                  FeeDelete      : integer;     //����������
                  FeeChange      : integer;     //����������
                  FeeLost        : integer  ;   //��ʧ������
                  FeeTransfer    : integer;     //ת��������
                  Blank          : Array[0..31] of byte;
			            Link           : Array[0..95] of byte;
              end;
              tagTPE_NationLog = record
                  NationNo       : Array[0..1] of WORD ;
                  Code           : Array[0..1,0..15] of char ;
                  Name           : Array[0..1,0..63] of char;
              end;
              tagTPE_CertLog = record
                 CertNo          : Array[0..1] of BYTE;
                 Name            : Array[0..1,0..63] of char;
              end;
              tagTPE_ConfigLogRec = record
                 case integer of
                 1:  ( DeptLog   : tagTPE_DeptLog     );
                 2:  ( IdentiLog : tagTPE_IdentiLog   );
                 3:  ( NationLog : tagTPE_NationLog   );
                 4:  ( CertLog   : tagTPE_CertLog     );
                 5:  ( Blank     : Array[0..483] of char;);
              end;

              PtagTPE_ConfigLogRec = ^ tagTPE_ConfigLogRec;

              tagTPE_ConfigLog = record
                ConfOrder   : UINT	;
                ConfType    : UINT	;
                ConfTime    : TArrayTime;
                ConfControl : UINT	;
                ConfOper    : WORD	;
                ConfInfo    : tagTPE_ConfigLogRec ;
              end;
              PtagTPE_ConfigLog = ^ tagTPE_ConfigLog;

              //ö�ٲ���
              tagTPE_ConfigEnumDeptReq = record
                  RangeDept    : Array[0..1] of LINT;
                  Depth        : BYTE	;
              end;
              PtagTPE_ConfigEnumDeptReq = ^tagTPE_ConfigEnumDeptReq;
              tagTPE_ConfigDeptRec = record
                  DeptNo : LINT    ;
                  Code   : Array[0..15] of char;
                  Name   : Array[0..63] of char;
              end;
              PtagTPE_ConfigDeptRec = ^tagTPE_ConfigDeptRec;
              //ö�����
              tagTPE_ConfigEnumIdentiReq = record

                  RangeIdenti : Array[0..1] of WORD	;
              end;
              PtagTPE_ConfigEnumIdentiReq = ^tagTPE_ConfigEnumIdentiReq;
              tagTPE_ConfigIdentiRec = record

                  IdentiNo : WORD    ;
                  Code     : Array[0..15] of char;
                  Name     : Array[0..63] of char;
                  OverDraft: integer;
              end;
              PtagTPE_ConfigIdentiRec = ^tagTPE_ConfigIdentiRec;
              tagTPE_ConfigIdentiRecEx = record

                  IdentiNo : WORD    ;
                  Code     : Array[0..15] of char;
                  Name     : Array[0..63] of char;
                  OverDraft: integer;   //͸֧�޶�
                  Deposit: integer;     //Ѻ��
                  ManageCoef: integer;  //�����ϵ��
                  FeeCreate: integer;   //����������
                  FeeDelete: integer;   //����������
                  FeeChange: integer;   //����������
                  FeeLost: integer  ;   //��ʧ������
                  FeeTransfer: integer; //ת��������
                  Blank : Array[0..31] of byte;
			            Link  : Array[0..95] of byte;
              end;
              PtagTPE_ConfigIdentiRecEx = ^tagTPE_ConfigIdentiRecEx;


              //ö������
              tagTPE_ConfigEnumNationReq = record

                  RangeNationNo : Array[0..1] of WORD;
              end;
              PtagTPE_ConfigEnumNationReq = ^tagTPE_ConfigEnumNationReq;
              tagTPE_ConfigNationRec = record

                  NationNo : WORD    ;
                  Code     : Array[0..15] of char;
                  Name     : Array[0..63] of char;
              end;
              PtagTPE_ConfigNationRec = ^tagTPE_ConfigNationRec;
              //ö��֤��
              tagTPE_ConfigEnumCertReq = record

                  RangeCertNo : Array[0..1] of BYTE	;
              end;
              PtagTPE_ConfigEnumCertReq = ^tagTPE_ConfigEnumCertReq;

              tagTPE_ConfigCertRec = record

                  CertNo : BYTE	;
                  Name   : Array[0..47] of char;
              end;
              PtagTPE_ConfigCertRec = ^tagTPE_ConfigCertRec;

            	//ö�ٿ�Ƭ����
            	tagTPE_ConfigEnumCardReq = record
            		RangeCardTypeNo : Array[0..1] of BYTE;
            	end;
              PtagTPE_ConfigEnumCardReq = ^tagTPE_ConfigEnumCardReq;
            	//ö�ٿ�Ƭ�����¼
            	tagTPE_ConfigCardRec = record
            			CardTypeNo : BYTE;
            			Name       : Array[0..31] of char;
            			Price      : LONG ;
            			Extend     : Array[0..63] of BYTE	;
            	end;
              PtagTPE_ConfigCardRec = ^tagTPE_ConfigCardRec;


              ////////////////////////////������////////////////////////////////////////////////////////////////////////////
              //ǩ��
              tagTPE_ManageOperLoginReq = record
                OperNo      : WORD	;
                OperType    : WORD	;
                OperName    : Array[0..15] of char;
                Password    : Array[0..7]  of BYTE	;
                OperCardNo  : UINT	;
              end;
              PtagTPE_ManageOperLoginReq = ^ tagTPE_ManageOperLoginReq;

              tagTPE_ManageOperLoginRes = record

                Retvalue : integer ;
              end;
              PtagTPE_ManageOperLoginRes = ^ tagTPE_ManageOperLoginRes;
	
              //ǩ��
              tagTPE_ManageOperLogoutReq = record
                OperNo : WORD	;
              end;
              PtagTPE_ManageOperLogoutReq = ^ tagTPE_ManageOperLogoutReq;

              tagTPE_ManageOperLogoutRes = record

                Retvalue : integer;
              end;
              PtagTPE_ManageOperLogoutRes = ^tagTPE_ManageOperLogoutRes;
              ////////////////////////////////////////////////////////////////////////////////////////////////////////
              ////��ˮ��ѯ
              tagTPE_QueryFlowByCenterReq = record//���������
                  ReqFlag : BYTE;  //=1ȫ���� ==0 �������������ļ�¼
                  FromCentralNo         : UINT	;
                  ToCentralNo           : UINT	;

                  reqflagAccountNo      : BYTE;
                  reqflagCardNo         : BYTE;
                  reqflagJoin           : BYTE;
                  reqflagOccurNode      : BYTE;
                  reqflagTransType      : BYTE;
                  reqflagRangeOccurTime : BYTE;

                  AccountNo             : UINT	;
                  CardNo                : UINT	;
                  JoinNode              : UINT	;
                  JoinCardHolder        : Array[0..23] of char;
                  OccurNode             : Array[0..127]of BYTE	;
                  TransType             : Array[0..31] of UINT	;
                  RangeOccurTime        : Array[0..1] of TArrayTime;
              end;
              PtagTPE_QueryFlowByCenterReq = ^tagTPE_QueryFlowByCenterReq;
              PtagTPE_QueryFlowRes_Open = ^ tagTPE_QueryFlowRes_Open;

              tagTPE_QueryFlowByNodeReq = record//���ڵ����

                  ReqFlag : BYTE;  //=1ȫ���� ==0 �������������ļ�¼

                  OccurNode             : UINT	;
                  FromOccurNo           : UINT	;
                  ToOccurNo             : UINT	;

                  reqflagAccountNo      : BYTE;
                  reqflagCardNo         : BYTE;
                  reqflagJoin           : BYTE;
                  reqflagRangeOccurTime : BYTE;
                  reqflagTransType      : BYTE;
			
                  AccountNo             : UINT	;
                  CardNo                : UINT	;
                  JoinNode              : UINT	;
                  JoinCardHolder        : Array[0..23] of char;
                  RangeOccurTime        : Array[0..1] of TArrayTime;
                  TransType             : Array[0..31]of BYTE;
              end;
              PtagTPE_QueryFlowByNodeReq = ^tagTPE_QueryFlowByNodeReq;

              tagTPE_QueryFlowBySQLReq = record//ͨ��
                  SQL : Array[0..4095] of char;
              end;
              PtagTPE_QueryFlowBySQLReq = ^tagTPE_QueryFlowBySQLReq;


              tagTPE_QueryFlowRes_Open = record//������ˮ

                  CenterNo            : UINT	;
                  OccurNode           : UINT	;
                  OccurIdNo           : UINT    ;
                  OccurTime           : TArrayTime;
                  TranOper            : WORD    ;

                  resflagCondition    : BYTE;
                  resflagBalance      : BYTE;
                  resflagCreateTime   : BYTE;
                  resflagExpireDate   : BYTE;
                  resflagName         : BYTE;
                  resflagPersonID     : BYTE;
                  resflagPassword     : BYTE;
                  resflagAccessControl: BYTE;
                  resflagBirthday     : BYTE;
                  resflagDepart       : BYTE;
                  resflagIdenti       : BYTE;
                  resflagNation       : BYTE;
                  resflagCertType     : BYTE;
                  resflagCertCode     : BYTE;
                  resflagCreditCardNo : BYTE;
                  resflagTransferLimit: BYTE;
                  resflagTransferMoney: BYTE;
                  resflagTel          : BYTE;
                  resflagEmail        : BYTE;
                  resflagPostalCode   : BYTE;
                  resflagPostalAddr   : BYTE;
                  resflagComment      : BYTE;
                  resflagExtend       : BYTE;
                  resflagUpdateTime   : BYTE;

                  AccountNo           : UINT  ;
                  CardNo              : UINT  ;

                  Condition           : UINT  ;
                  Balance             : LONG  ;
                  CreateTime          : TArrayTime;
                  ExpireDate          : TArrayTime;
                  Name                : TArrayName;
                  PersonID            : TArrayPersonID;
                  Password            : TArrayPassword;
                  AccessControl       : TArrayAccessControl;
                  Birthday            : TArrayTime;
                  Depart              : LINT  ;
                  Identi              : WORD  ;
                  Nation              : WORD  ;
                  CertType            : BYTE  ;
                  CertCode            : TArrayCertCode;
                  CreditCardNo        : TArrayCreditCardNo;
                  TransferLimit       : LONG  ;
                  TransferMoney       : LONG  ;
                  Tel                 : TArrayTel;
                  Email               : TArrayEmail;
                  PostalCode          : Array[0..5 ] of char;
                  PostalAddr          : Array[0..99] of char;
                  Comment             : Array[0..119]of char;
                  ExtendLen           : integer   ;
                  Extend              : Array[0..254]of BYTE  ;
                  UpdateTime          : TArrayTime;
              end;
              //PtagTPE_QueryFlowRes_Open = ^tagTPE_QueryFlowRes_Open;
	
              tagTPE_QueryFlowRes_Close  = tagTPE_QueryFlowRes_Open;
	
              tagTPE_QueryFlowRes_UpdateAccount = record//�����ʻ�

                  CenterNo            : UINT	;
                  OccurNode           : UINT	;
                  OccurIdNo           : UINT    ;
                  OccurTime           : TArrayTime;
                  TranOper            : WORD ;

                  resflagCondition    : BYTE;
                  resflagCreateTime   : BYTE;
                  resflagExpireDate   : BYTE;
                  resflagName         : BYTE;
                  resflagPersonID     : BYTE;
                  resflagPassword     : BYTE;
                  resflagAccessControl: BYTE;
                  resflagBirthday     : BYTE;
                  resflagDepart       : BYTE;
                  resflagIdenti       : BYTE;
                  resflagNation       : BYTE;
                  resflagCertType     : BYTE;
                  resflagCertCode     : BYTE;
                  resflagCreditCardNo : BYTE;
                  resflagTransferLimit: BYTE;
                  resflagTransferMoney: BYTE;
                  resflagTel          : BYTE;
                  resflagEmail        : BYTE;
                  resflagPostalCode   : BYTE;
                  resflagPostalAddr   : BYTE;
                  resflagComment      : BYTE;
                  resflagExtend       : BYTE;
                  resflagUpdateTime   : BYTE;

                  AccountNo           : UINT  ;
                  CardNo              : UINT  ;

                  Condition           : Array[0..1] of UINT  ;
                  CreateTime          : TArrayTime;
                  ExpireDate          : TArrayTime;
                  Name                : TArrayName;
                  PersonID            : TArrayPersonID;
                  Password            : TArrayPassword;
                  AccessControl       : TArrayAccessControl;
                  Birthday            : TArrayTime;
                  Depart              : LINT  ;
                  Identi              : WORD  ;
                  Nation              : WORD  ;
                  CertType            : BYTE  ;
                  CertCode            : TArrayCertCode;
                  CreditCardNo        : TArrayCreditCardNo;
                  TransferLimit       : LONG  ;
                  TransferMoney       : LONG  ;
                  Tel                 : TArrayTel;
                  Email               : TArrayEmail;
                  PostalCode          : Array[0..5]  of char;
                  PostalAddr          : Array[0..99] of char;
                  Comment             : Array[0..119]of char;
                  ExtendLen           : integer   ;
                  Extend              : Array[0..254]of BYTE  ;
                  UpdateTime          : TArrayTime;

              end;
              PtagTPE_QueryFlowRes_UpdateAccount = ^ tagTPE_QueryFlowRes_UpdateAccount;

              tagTPE_QueryFlowRes_BuildRelation = record

                  CenterNo              : UINT	;
                  OccurNode             : UINT	;
                  OccurIdNo             : UINT    ;
                  OccurTime             : TArrayTime;
                  TranOper              : WORD ;


                  AccountNo             : UINT;		//���ʺŽ���
                  CardNo                : UINT;         //�����Ž���
                  JoinNode              : UINT ;
                  JoinCardHolder        : Array[0..23] of char ;

                  resflagJoinPassword   : BYTE;
                  resflagJoinCondition  : BYTE;
                  resflagJoinComment    : BYTE;

                  JoinPassword    : TArrayPassword;
                  JoinCondition   : UINT	;
                  JoinComment     : Array[0..119] of char;
              end;

              tagTPE_QueryFlowRes_UpdateRelation = record

                  CenterNo              : UINT	;
                  OccurNode             : UINT	;
                  OccurIdNo             : UINT    ;
                  OccurTime             : TArrayTime;
                  TranOper              : WORD ;


                  AccountNo             : UINT;		//���ʺŽ���
                  CardNo                : UINT;         //�����Ž���
                  JoinNode              : UINT ;
                  JoinCardHolder        : Array[0..23] of char ;

                  resflagJoinPassword   : BYTE;
                  resflagJoinCondition  : BYTE;
                  resflagJoinComment    : BYTE;

                  JoinPassword    : TArrayPassword;
                  JoinCondition   : Array[0..1] of UINT	;
                  JoinComment     : Array[0..119] of char;
              end;
	
              tagTPE_QueryFlowRes_CancelRelation = tagTPE_QueryFlowRes_BuildRelation;
	

              tagTPE_QueryFlowRes_Cost = record

                  CenterNo              : UINT	;
                  OccurNode             : UINT	;
                  OccurIdNo             : UINT    ;
                  OccurTime             : TArrayTime;
                  TranOper              : WORD ;

                  AccountNo             : UINT;		//���ʺŽ���
                  CardNo                : UINT;         //�����Ž���
                  JoinNode              : UINT ;
                  JoinCardHolder        : Array[0..23] of char ;

                  CostType              : WORD   ;
                  TransMoney            : LONG	 ;
                  Balance               : LONG	 ;

                  LinkOccurNode         : UINT	 ;
                  LinkOccurIdNo         : UINT	 ;

                  ExtendLen             : integer;
              end;
            /////////////////////////////////////////////////////////////////////////////////////
            //��֤����
              tagTPE_CheckPassword = record

                PlainPassword   : TArrayPassword;
                CypherPassword  : TArrayPassword;
              end;
              PtagTPE_CheckPassword = ^tagTPE_CheckPassword;
            /////////////////////////////////////////////////////////////////////////////////////
              tagTPE_TransferFileReq = record
                Action    : BYTE;		//1 ����,2�ϴ�
                FileFlag  : BYTE;   //0 �����ڴ�,1:�����ļ�
                FileName  : Array[0..254] of char;
              end;
              PtagTPE_TransferFileReq = ^ tagTPE_TransferFileReq;
              tagTPE_TransferFileRes = record
                RetValue : integer;
                Len      : integer;
                pFileData: pointer;
              end;
              PtagTPE_TransferFileRes = ^ tagTPE_TransferFileRes;



//*********************************���廥����������************************************************************

    CallBackFunction_WHITELIST  = function ( pRec: PtagWhiteListCallBack  ):integer;stdcall;
    CallBackFunction_NODENOTIFY = function ( pRec: tagNodeNotifyInfo      ; pRes  : PtagNodeNotifyInfoRes ):integer;stdcall;

//*********************************�ӿں�������***************************************************************    

    function  TPE_StartTPE(): Integer; stdcall; external 'TPE.DLL' name 'TPE_StartTPE';	 //����TPE����
    function  TPE_StopTPE() : Integer; stdcall; external 'TPE.DLL' name 'TPE_StopTPE';	 //ֹͣTPE����

    function  TPE_SetCallBack_WhiteList ( pFun : CallBackFunction_WHITELIST) : Integer; stdcall; external 'TPE.DLL' name 'TPE_SetCallBack_WhiteList' ; //�趨������ͬ���ص�����
    function  TPE_SetCallBack_NodeNotify( pFun : CallBackFunction_NODENOTIFY): Integer; stdcall; external 'TPE.DLL' name 'TPE_SetCallBack_NodeNotify'; //�趨��ˮͬ��֪ͨ�ص�����

    //function  TPE_StartNotify (  ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_StartNotify' ; //��ʼ֪ͨ
    //function  TPE_StopNotify  (  ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_StopNotify'  ; //ֹ֪ͣͨ

    function  TPE_StartWLNotify(): Integer; stdcall; external 'TPE.DLL' name 'TPE_StartWLNotify' ; //��ʼ������֪ͨ�ص�
    function  TPE_StopWLNotify() : Integer; stdcall; external 'TPE.DLL' name 'TPE_StopWLNotify'  ; //ֹͣ������֪ͨ�ص�

    function  TPE_WaitForData ( milliseconds : integer ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_WaitForData';//�ȴ�����
    //ȡ����
    function  TPE_GetData     (       pMessageCode : PCardinal;
                                      pCustomSn    : PCardinal;
                                      pTPERet      : PInteger ;
                                      pBuf         : Pointer  ;
                                      BufLen       : integer  ;
                                      pRetLen      : Pinteger
                              ): Integer; stdcall; external 'TPE.DLL' name 'TPE_GetData';

    //�����Ż��ʺŵ���
    function TPE_GetAccount	(         CustomSn     : Cardinal ;
                                      pReq         : PtagTPE_GetAccountReq;
                                      pRes	       : PtagTPE_GetAccountRes;
                                      bSync        : integer
                             ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_GetAccount';
    //����Ƭ���кŵ���
    function TPE_GetAccountByCardSerial	(         CustomSn     : Cardinal ;
                                      pReq         : PtagTPE_GetAccountReq;
                                      pRes	       : PtagTPE_GetAccountRes;
                                      bSync        : integer
                             ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_GetAccountByCardSerial';

    //����Ӧ��ϵ����
    function TPE_GetAccountByRelation( CustomSn    : Cardinal ;
                                       pReq        : PtagTPE_GetRelationReq	;
                                       pRes        : PtagTPE_GetRelationRes	;
                                       bSync       : integer
                                     ): Integer; stdcall; external 'TPE.DLL' name 'TPE_GetAccountByRelation';

    //��ѯ�ʻ�,��׼
    function TPE_QueryStdAccount	 (  CustomSn     : Cardinal ;
                                      pReq         : PtagTPE_QueryStdAccountReq	;
                                      pResControl  : PtagTPE_QueryResControl    ;
                                      bSync        : integer
                                   ): Integer; stdcall; external 'TPE.DLL' name 'TPE_QueryStdAccount';

    //��ѯ�ʻ�,ͨ��
    function TPE_QueryGeneralAccount  ( CustomSn   : Cardinal ;
                                        pReq       : PtagTPE_QueryGeneralAccountReq ;
                                        pResControl: PtagTPE_QueryResControl;
                                        bSync      : integer
                                      ): Integer; stdcall; external 'TPE.DLL' name 'TPE_QueryGeneralAccount';

    function TPE_QueryRelation		 (   CustomSn   : Cardinal ;
                                       pReq       : tagTPE_QueryRelationReq   ;
                                       pResControl: tagTPE_QueryResControl    ;
                                       bSync      : integer
                                   ): Integer; stdcall; external 'TPE.DLL' name 'TTPE_QueryRelation';

    //��ѯ��ˮ
    //��ѯ��ˮ���ؽṹpResData �ṹ:(��ˮ����+��ˮ����)*N
    //��������ˮ���
    function TPE_QueryFlowByCenter (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_QueryFlowByCenterReq	 ;
                                      pResControl   : PtagTPE_QueryResControl;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_QueryFlowByCenter';
    //���ڵ���ˮ���
    function TPE_QueryFlowByNode	 (
                                      CustomSn      :  Cardinal ;
                                      pReq          : PtagTPE_QueryFlowByNodeReq;
                                      pResControl   : PtagTPE_QueryResControl		;
                                      bSync         :  integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_QueryFlowByNode';

    //��SQL�Զ���
    function TPE_QueryFlowBySQL		 (
                                      CustomSn      :  Cardinal ;
                                      pReq          : PtagTPE_QueryFlowBySQLReq		;
                                      pResControl   : PtagTPE_QueryResControl			;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_QueryFlowBySQL';


    //������ˮ
    //������Ӧ��ϵ
    function TPE_FlowBuildRelation (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_FlowBuildRelationReq;
                                      pRes          : PtagTPE_FlowBuildRelationRes ;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_FlowBuildRelation';
    //ȡ����Ӧ��ϵ
    function TPE_FlowCancelRelation	 (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_FlowCancelRelationReq	;
                                      pRes          : PtagTPE_FlowCancelRelationRes ;
                                      bSync         : integer
                                     ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_FlowCancelRelation';
    //�����ʻ���Ϣ
    function TPE_FlowUpdateAccount	 (
                                      CustomSn      :  Cardinal ;
                                      pReq          : PtagTPE_FlowUpdateAccountReq	;
                                      pRes          : PtagTPE_FlowUpdateAccountRes  ;
                                      bSync         : integer
                                     ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_FlowUpdateAccount';
   //���¶�Ӧ��ϵ
    function TPE_FlowUpdateRelation  (
                                      CustomSn      :  Cardinal ;
                                      pReq          : PtagTPE_FlowUpdateRelationReq  ;
                                      pRes          : PtagTPE_FlowUpdateRelationRes  ;
                                      bSync         : integer
                                     ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_FlowUpdateRelation';
    //����,�����
    function TPE_FlowCost			       (
                                      CustomSn      :  Cardinal ;
                                      pReq          : PtagTPE_FlowCostReq		    ;
                                      FlowCount     : integer               ;
                                      pRes          : PtagTPE_FlowCostRes			  ;
                                      bSync         : integer
                                     ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_FlowCost';

    //��ʧ���
    function TPE_Lost			          (
                                      CustomSn      :  Cardinal ;
                                      pReq          : PtagTPE_LostReq		  ;
                                      pRes          : PtagTPE_LostRes		  ;
                                      bSync         : integer
                                     ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_Lost';
    //����
    function TPE_CheckBySn		       (
                                      CustomSn      :  Cardinal ;
                                      pReq          : PtagTPE_CheckBySnReq      ;
                                      pRes          : PtagTPE_CheckBySnRes		  ;
                                      bSync         : integer
                                     ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_CheckBySn';
    //����
    function TPE_CheckByTime	       (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_CheckByTimeReq			;
                                      pRes          : PtagTPE_CheckByTimeRes		  ;
                                      bSync         : integer
                                     ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_CheckByTime';
    //����
    function TPE_CheckByDetail	     (
                                      CustomSn      : Cardinal ;
                                      pReq  : PtagTPE_CheckByDetailReq		;
                                      pRes  : PtagTPE_CheckByDetailRes	  ;
                                      bSync         : integer
                                     ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_CheckByDetail';

    //ȡ��ˮ��
    function TPE_OnLineGetMaxSn		 (
                                      CustomSn      : Cardinal ;
                                      pRes          : PtagTPE_OnLineGetMaxSnRes		;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_OnLineGetMaxSn';
    //ö��������־
    function TPE_ConfigEnumLog		 (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_ConfigEnumLogReq	;
                                      pResControl	  : PtagTPE_QueryResControl;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_ConfigEnumLog';
    //ö�ٲ���
    function TPE_ConfigEnumDept		 (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_ConfigEnumDeptReq	;
                                      pResControl		: PtagTPE_QueryResControl		;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_ConfigEnumDept';
    //ö�����
    function TPE_ConfigEnumIdenti	 (
                                      CustomSn      : Cardinal ;
                                      pReq          : ptagTPE_ConfigEnumIdentiReq ;
                                      pResControl		: PtagTPE_QueryResControl			;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_ConfigEnumIdenti';
    //ö�������չ
    function TPE_ConfigEnumIdentiEx(
                                      CustomSn      : Cardinal ;
                                      pReq          : ptagTPE_ConfigEnumIdentiReq ;
                                      pResControl		: PtagTPE_QueryResControl			;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_ConfigEnumIdentiEx';

    //ö������
    function TPE_ConfigEnumNation	 (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_ConfigEnumNationReq;
                                      pResControl		: PtagTPE_QueryResControl			;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_ConfigEnumNation';
    //ö��֤������
    function TPE_ConfigEnumCert		 (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_ConfigEnumCertReq  ;
                                      pResControl		: PtagTPE_QueryResControl		 ;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_ConfigEnumCert';

    //����Ա��¼
    function TPE_ManageOperLogin	 (
                                      CustomSn      : Cardinal ;
                                      pReq : PtagTPE_ManageOperLoginReq  ;
                                      pRes : PtagTPE_ManageOperLoginRes  ;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_ManageOperLogin';

    //ö��ǩ��
    function TPE_ManageOperLogout	 (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_ManageOperLogoutReq ;
                                      pRes          : PtagTPE_ManageOperLogoutRes ;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_ManageOperLogout';
    //�ڴ��ͷ�
    function TPE_Free              ( pData : pointer): Integer; stdcall; external 'TPE.DLL' name 'TPE_Free';


    //��ñ����ڵ�
    function TPE_GetLocalNode()                     : Integer; stdcall; external 'TPE.DLL' name 'TPE_GetLocalNode';

    //�������״̬
    function TPE_GetNetState ()                     : Integer; stdcall; external 'TPE.DLL' name 'TPE_GetNetState';

    //ȡ������
    function TPE_GetWL( pRec : PtagWhiteListRec  )  : Integer; stdcall; external 'TPE.DLL' name 'TPE_GetWL';

    //ȡ�ڵ���
    function TPE_GetLocalNodeSn ( pSn : pCardinal ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_GetLocalNodeSn';

    //����ȫ��������
    function TPE_DownloadAllWL( )                   : Integer; stdcall; external 'TPE.DLL' name 'TPE_DownloadAllWL';

    //У������
    function TPE_CheckPassword(    pPwd : PtagTPE_CheckPassword ): Integer; stdcall; external 'TPE.DLL' name 'TPE_CheckPassword';

    //�����ļ�
    function TPE_TransferFile       (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_TransferFileReq  ;
                                      pRes          : PtagTPE_TransferFileRes  ;
                                      bSync         : integer
                                    ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_TransferFile';
const
    //����TPE����ֵ
    TPE_ERROR_UNPACK             = -5  ; //�������
    TPE_ERROR_PARAMETER          = -4  ; //��ڲ�������
    TPE_ERROR_INTERNAL           = -3  ; //�ڲ�����,
    TPE_ERROR_NETFAIL            = -2  ; //�������,�����Ѿ�����(socket�����)
    TPE_ERROR_UNREACHABLE        = -1  ; //��̨���ɴ�
                                 // 0    //�ɹ�
    TPE_ERROR_TIMEOUT            =  1  ; //��ʱ
    TPE_ERROR_NODATA             =  2  ; //û������
    TPE_ERROR_LESSBUFFERLEN      =  3  ; //������̫С


    //CONDITION�ֶ�һЩ��־λ����
    CONDITION_MASK_CLOSE		    = $00000002    ;
    CONDITION_MASK_FREEZE		    = $00000004    ;
    CONDITION_MASK_LOST			    = $00000008    ;
    CONDITION_MASK_AUTOTRANS    = $00000010    ;
    CONDITION_MASK_SELFTRANS    = $00000020    ;

implementation

end.


