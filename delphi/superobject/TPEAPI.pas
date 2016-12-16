//*******************************************************************************************************
//    哈尔滨新中新电子股份有限公司版权所有,2003.6
//
//    TPEAPI.H
//
//    第三方接口(TPE) 函数和数据结构定义
//
//    For( Delphi) 2003.11.04
//
//*******************************************************************************************************

unit tpeapi;

interface

type

            //紧缩结构编译
            {$A-}

//*******************************************************************************************************************
            //类型定义
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
            //白名单通知
            tagWhiteListCallBack = record
              AccountNo :  UINT		; //帐号
              CardNo    :  UINT		; //卡号
              Condition :  UINT   ; //状态
              Balance   :  LONG   ; //余额
              Depart    :  LINT		; //部门
              Identi    :  WORD		;	//身份
            end;
            PtagWhiteListCallBack = ^ tagWhiteListCallBack;

            //白名单
            tagWhiteListRec = record
              AccountNo :  UINT		; //帐号
              CardNo    :  UINT		;	//卡号
              Condition :  UINT		;	//状态
              Balance   :  LONG   ; //余额
              Depart    :  LINT		; //部门
              Identi    :  WORD		; //身份
              Sign      :  BYTE		; //签名
            end;
            PtagWhiteListRec = ^tagWhiteListRec;

            //流水通知结构
            tagNodeNotifyInfo = record
              CurrentCentralNo :UINT	;
            end;
            PtagNodeNotifyInfo = ^tagNodeNotifyInfo;

            //流水通知应答
            tagNodeNotifyInfoRes = record
              NotiyfWait : UINT	;
            end;
            PtagNodeNotifyInfoRes = ^ tagNodeNotifyInfoRes;


//**************************************************调帐*****************************************************************
            //基本帐户调帐申请
            tagTPE_GetAccountReq = record

                  //按帐号.卡号
                  AccountNo            : UINT;         
                  CardNo               : UINT;

                  //是否需要密码
                  reqflagPassword      : BYTE;
                  Password             : TArrayPassword ;

                  //返回标志
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
              //基本帐户调帐应答
              tagTPE_GetAccountRes = record

                  RetValue             : integer;            //返回值

                  AccountNo            : UINT  ;             //帐号
                  CardNo               : UINT  ;             //卡号
                  Condition            : UINT  ;             //状态
                  Balance              : LONG  ;             //余额
                  CreateTime           : TArrayTime;         //开户时间
                  ExpireDate           : TArrayTime;         //有效期
                  Name                 : TArrayName;         //姓名
                  PersonID             : TArrayPersonID;     //身份证号
                  Password             : TArrayPassword;     //密码
                  AccessControl        : TArrayAccessControl;//访问控制
                  Birthday             : TArrayTime;         //出生时间
                  Depart               : LINT;               //部分编号
                  Identi               : WORD  ;             //身份编号
                  Nation               : WORD  ;             //民族编号
                  CertType             : BYTE  ;             //证件类型
                  CertCode             : TArrayCertCode;     //证件号码
                  CreditCardNo         : TArrayCreditCardNo; //银行卡号
                  TransferLimit        : LONG  ;             //转帐限额
                  TransferMoney        : LONG  ;             //转帐金额
                  Tel                  : TArrayTel;          //电话
                  Email                : TArrayEmail;        //email
                  PostalCode           : TArrayPostalCode;   //邮政编码
                  PostalAddr           : TArrayPostalAddr;   //邮政通信地址
                  FileNamePicture      : TArrayFileName  ;   //照片文件名称
                  FileNameFinger       : TArrayFileName  ;   //指纹
                  FileNameAudio        : TArrayFileName  ;   //声音
                  Comment              : array[0..119] of char;//注释
                  ExtendLen            : integer;              //扩展信息长度
                  Extend               : Array[0..254] of byte;//扩展信息
                  UpdateTime           : TArrayTime;           //最后更新时刻
              end;
              PtagTPE_GetAccountRes = ^tagTPE_GetAccountRes; 

              //对应关系调帐申请
              tagTPE_GetRelationReq   = record

                  JoinNode             : UINT	;                //节点
                  JoinCardHolder       : Array[0..23] of char; //对应关系卡/帐号

                  reqflagJoinPassword  : BYTE;                 //密码标志
                  JoinPassword         : Array[0..7 ] of BYTE;  //对应关系密码

                  //返回标志
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

              //对应关系调帐应答
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

                  JoinIndex            : UINT ;                    //帐号
                  JoinNode             : UINT ;                    //节点号
                  JoinCardHolder       : Array[0..23]  of char;    //对应关系帐.卡号
                  JoinPassword         : TArrayPassword;           //对应关系密码
                  JoinCondition        : UINT;                     //对应关系帐户状态
                  JoinComment          : Array[0..119] of char;    //注释
                  JoinUpdateTime       : TArrayTime;               //最后更新时刻
              end;
              PtagTPE_GetRelationRes = ^tagTPE_GetRelationRes;



//******************************************************查询*************************************************************
              //标准帐户查询
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

                  //返回标志
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


              //通用帐户查询应答控制结构体
              tagTPE_QueryResControl = record
                    ResRecCount : integer;
                    pRes        : pointer;
              end;
              PtagTPE_QueryResControl = ^tagTPE_QueryResControl;
	
              //通用帐户查询返回记录
              tagTPE_QueryStdAccountRes = tagTPE_GetAccountRes; 

              //通用查询
              tagTPE_QueryGeneralAccountReq = record

                  SQL                 : Array[0..4095] of char;

                  //返回标志
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

              //查询对应关系
              tagTPE_QueryRelationReq = record

                  reqflagRangeJoinIndex       : byte;
                  reqflagJoinNode             : byte;
                  reqflagRangeJoinCardHolder  : byte;
                  reqfalgRangeJoinCondition   : byte;

                  RangeJoinIndex              : Array[0..1] of UINT;
                  JoinNode                    : UINT;
                  RangeJoinCardHolder         : Array[0..1,0..23] of char;
                  RangeJoinCondition          : Array[0..1] of UINT;

                  //返回标志
                  resflagJoinIndex            : byte;
                  resflagJoinNode             : byte;
                  resflagJoinCardHolder       : byte;
                  resflagJoinPassword         : byte;
                  resflagJoinCondition        : byte;
                  resflagJoinComment          : byte;
                  resflagJoinUpdateTime       : byte;
              end;
              PtagTPE_QueryRelationReq = ^tagTPE_QueryRelationReq;

              //查询对应关系应答
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

//**********************************************************入帐*********************************************************

//              tagTPE_FlowNetLog = record         //检索一个人的优先级:帐号>卡号>对应关系,过渡条件:帐号=0-->卡号=0-->对应
              //入帐流水应答
              tagTPE_FlowRes = record
                RecordError : INTEGER  ;
                CenterNo    : UINT  ;
                OccurNode   : UINT  ;
                OccurIdNo   : UINT  ;
                OccurInfo   : UINT  ;
              end;
              PtagTPE_FlowRes = ^tagTPE_FlowRes;

              //建立对应关系
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

              //取消对应关系
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


             //挂失/解挂
              tagTPE_LostReq = record
                  OccurIdNo      : UINT     ;
                  OccurTime      : TArrayTime;
                  TranOper       : WORD     ;

                  ReqAccountNo   : UINT	 ;
                  ReqCardNo      : UINT	 ;
                  JoinNode       : UINT	 ;
                  JoinCardHolder : Array[0..23] of char;

                  Operation      : BYTE;       //1 挂失, 2 解挂
              end;
              PtagTPE_LostReq  = ^tagTPE_LostReq;
              tagTPE_LostRes   = tagTPE_FlowRes;
              PtagTPE_LostRes  = ^tagTPE_LostRes;

              //入帐----更新基本帐户申请
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
              
              //入帐----更新对应关系申请
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

              //入帐----余额变更申请
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

                  LinkOccurNode   : UINT	 ;	//只有FLOW_TYPE_BALANCEEXTRA时有效
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

//************************************对帐******************************************************************************
              tagTPE_CheckByTimeReq = record//对帐,按时间

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

	
              tagTPE_CheckBySnReq = record//对帐,按流水号
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
	
              tagTPE_CheckByDetailReq = record//对明细
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
//*******************************************在线报文*************************************************************************
              //申请当前最大流水号
              tagTPE_OnLineGetMaxSnRes = record
                RetValue : integer ;
                MaxSn    : UINT ;
              end;
              PtagTPE_OnLineGetMaxSnRes = ^tagTPE_OnLineGetMaxSnRes;
//*******************************************配置报文*************************************************************************              
              //配置日志
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
                  OverDraft      : integer;     //透支限额
                  Deposit        : integer;     //押金
                  ManageCoef     : integer;     //管理费系数
                  FeeCreate      : integer;     //开户手续费
                  FeeDelete      : integer;     //撤户手续费
                  FeeChange      : integer;     //换卡手续费
                  FeeLost        : integer  ;   //挂失手续费
                  FeeTransfer    : integer;     //转帐手续费
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

              //枚举部门
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
              //枚举身份
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
                  OverDraft: integer;   //透支限额
                  Deposit: integer;     //押金
                  ManageCoef: integer;  //管理费系数
                  FeeCreate: integer;   //开户手续费
                  FeeDelete: integer;   //撤户手续费
                  FeeChange: integer;   //换卡手续费
                  FeeLost: integer  ;   //挂失手续费
                  FeeTransfer: integer; //转帐手续费
                  Blank : Array[0..31] of byte;
			            Link  : Array[0..95] of byte;
              end;
              PtagTPE_ConfigIdentiRecEx = ^tagTPE_ConfigIdentiRecEx;


              //枚举民族
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
              //枚举证件
              tagTPE_ConfigEnumCertReq = record

                  RangeCertNo : Array[0..1] of BYTE	;
              end;
              PtagTPE_ConfigEnumCertReq = ^tagTPE_ConfigEnumCertReq;

              tagTPE_ConfigCertRec = record

                  CertNo : BYTE	;
                  Name   : Array[0..47] of char;
              end;
              PtagTPE_ConfigCertRec = ^tagTPE_ConfigCertRec;

            	//枚举卡片申请
            	tagTPE_ConfigEnumCardReq = record
            		RangeCardTypeNo : Array[0..1] of BYTE;
            	end;
              PtagTPE_ConfigEnumCardReq = ^tagTPE_ConfigEnumCardReq;
            	//枚举卡片结果记录
            	tagTPE_ConfigCardRec = record
            			CardTypeNo : BYTE;
            			Name       : Array[0..31] of char;
            			Price      : LONG ;
            			Extend     : Array[0..63] of BYTE	;
            	end;
              PtagTPE_ConfigCardRec = ^tagTPE_ConfigCardRec;


              ////////////////////////////管理报文////////////////////////////////////////////////////////////////////////////
              //签到
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
	
              //签退
              tagTPE_ManageOperLogoutReq = record
                OperNo : WORD	;
              end;
              PtagTPE_ManageOperLogoutReq = ^ tagTPE_ManageOperLogoutReq;

              tagTPE_ManageOperLogoutRes = record

                Retvalue : integer;
              end;
              PtagTPE_ManageOperLogoutRes = ^tagTPE_ManageOperLogoutRes;
              ////////////////////////////////////////////////////////////////////////////////////////////////////////
              ////流水查询
              tagTPE_QueryFlowByCenterReq = record//按中心序号
                  ReqFlag : BYTE;  //=1全部， ==0 部分满足条件的记录
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

              tagTPE_QueryFlowByNodeReq = record//按节点序号

                  ReqFlag : BYTE;  //=1全部， ==0 部分满足条件的记录

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

              tagTPE_QueryFlowBySQLReq = record//通用
                  SQL : Array[0..4095] of char;
              end;
              PtagTPE_QueryFlowBySQLReq = ^tagTPE_QueryFlowBySQLReq;


              tagTPE_QueryFlowRes_Open = record//开户流水

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
	
              tagTPE_QueryFlowRes_UpdateAccount = record//更新帐户

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


                  AccountNo             : UINT;		//按帐号建立
                  CardNo                : UINT;         //按卡号建立
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


                  AccountNo             : UINT;		//按帐号建立
                  CardNo                : UINT;         //按卡号建立
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

                  AccountNo             : UINT;		//按帐号建立
                  CardNo                : UINT;         //按卡号建立
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
            //验证密码
              tagTPE_CheckPassword = record

                PlainPassword   : TArrayPassword;
                CypherPassword  : TArrayPassword;
              end;
              PtagTPE_CheckPassword = ^tagTPE_CheckPassword;
            /////////////////////////////////////////////////////////////////////////////////////
              tagTPE_TransferFileReq = record
                Action    : BYTE;		//1 下载,2上传
                FileFlag  : BYTE;   //0 载入内存,1:生成文件
                FileName  : Array[0..254] of char;
              end;
              PtagTPE_TransferFileReq = ^ tagTPE_TransferFileReq;
              tagTPE_TransferFileRes = record
                RetValue : integer;
                Len      : integer;
                pFileData: pointer;
              end;
              PtagTPE_TransferFileRes = ^ tagTPE_TransferFileRes;



//*********************************定义互调函数类型************************************************************

    CallBackFunction_WHITELIST  = function ( pRec: PtagWhiteListCallBack  ):integer;stdcall;
    CallBackFunction_NODENOTIFY = function ( pRec: tagNodeNotifyInfo      ; pRes  : PtagNodeNotifyInfoRes ):integer;stdcall;

//*********************************接口函数定义***************************************************************    

    function  TPE_StartTPE(): Integer; stdcall; external 'TPE.DLL' name 'TPE_StartTPE';	 //启动TPE服务
    function  TPE_StopTPE() : Integer; stdcall; external 'TPE.DLL' name 'TPE_StopTPE';	 //停止TPE服务

    function  TPE_SetCallBack_WhiteList ( pFun : CallBackFunction_WHITELIST) : Integer; stdcall; external 'TPE.DLL' name 'TPE_SetCallBack_WhiteList' ; //设定白名单同步回调函数
    function  TPE_SetCallBack_NodeNotify( pFun : CallBackFunction_NODENOTIFY): Integer; stdcall; external 'TPE.DLL' name 'TPE_SetCallBack_NodeNotify'; //设定流水同步通知回调函数

    //function  TPE_StartNotify (  ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_StartNotify' ; //开始通知
    //function  TPE_StopNotify  (  ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_StopNotify'  ; //停止通知

    function  TPE_StartWLNotify(): Integer; stdcall; external 'TPE.DLL' name 'TPE_StartWLNotify' ; //开始白名单通知回调
    function  TPE_StopWLNotify() : Integer; stdcall; external 'TPE.DLL' name 'TPE_StopWLNotify'  ; //停止白名单通知回调

    function  TPE_WaitForData ( milliseconds : integer ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_WaitForData';//等待数据
    //取数据
    function  TPE_GetData     (       pMessageCode : PCardinal;
                                      pCustomSn    : PCardinal;
                                      pTPERet      : PInteger ;
                                      pBuf         : Pointer  ;
                                      BufLen       : integer  ;
                                      pRetLen      : Pinteger
                              ): Integer; stdcall; external 'TPE.DLL' name 'TPE_GetData';

    //按卡号或帐号调帐
    function TPE_GetAccount	(         CustomSn     : Cardinal ;
                                      pReq         : PtagTPE_GetAccountReq;
                                      pRes	       : PtagTPE_GetAccountRes;
                                      bSync        : integer
                             ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_GetAccount';
    //按卡片序列号调帐
    function TPE_GetAccountByCardSerial	(         CustomSn     : Cardinal ;
                                      pReq         : PtagTPE_GetAccountReq;
                                      pRes	       : PtagTPE_GetAccountRes;
                                      bSync        : integer
                             ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_GetAccountByCardSerial';

    //按对应关系调帐
    function TPE_GetAccountByRelation( CustomSn    : Cardinal ;
                                       pReq        : PtagTPE_GetRelationReq	;
                                       pRes        : PtagTPE_GetRelationRes	;
                                       bSync       : integer
                                     ): Integer; stdcall; external 'TPE.DLL' name 'TPE_GetAccountByRelation';

    //查询帐户,标准
    function TPE_QueryStdAccount	 (  CustomSn     : Cardinal ;
                                      pReq         : PtagTPE_QueryStdAccountReq	;
                                      pResControl  : PtagTPE_QueryResControl    ;
                                      bSync        : integer
                                   ): Integer; stdcall; external 'TPE.DLL' name 'TPE_QueryStdAccount';

    //查询帐户,通用
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

    //查询流水
    //查询流水返回结构pResData 结构:(流水类型+流水数据)*N
    //按中心流水序号
    function TPE_QueryFlowByCenter (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_QueryFlowByCenterReq	 ;
                                      pResControl   : PtagTPE_QueryResControl;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_QueryFlowByCenter';
    //按节点流水序号
    function TPE_QueryFlowByNode	 (
                                      CustomSn      :  Cardinal ;
                                      pReq          : PtagTPE_QueryFlowByNodeReq;
                                      pResControl   : PtagTPE_QueryResControl		;
                                      bSync         :  integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_QueryFlowByNode';

    //按SQL自定义
    function TPE_QueryFlowBySQL		 (
                                      CustomSn      :  Cardinal ;
                                      pReq          : PtagTPE_QueryFlowBySQLReq		;
                                      pResControl   : PtagTPE_QueryResControl			;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_QueryFlowBySQL';


    //入帐流水
    //建立对应关系
    function TPE_FlowBuildRelation (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_FlowBuildRelationReq;
                                      pRes          : PtagTPE_FlowBuildRelationRes ;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_FlowBuildRelation';
    //取消对应关系
    function TPE_FlowCancelRelation	 (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_FlowCancelRelationReq	;
                                      pRes          : PtagTPE_FlowCancelRelationRes ;
                                      bSync         : integer
                                     ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_FlowCancelRelation';
    //更新帐户信息
    function TPE_FlowUpdateAccount	 (
                                      CustomSn      :  Cardinal ;
                                      pReq          : PtagTPE_FlowUpdateAccountReq	;
                                      pRes          : PtagTPE_FlowUpdateAccountRes  ;
                                      bSync         : integer
                                     ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_FlowUpdateAccount';
   //更新对应关系
    function TPE_FlowUpdateRelation  (
                                      CustomSn      :  Cardinal ;
                                      pReq          : PtagTPE_FlowUpdateRelationReq  ;
                                      pRes          : PtagTPE_FlowUpdateRelationRes  ;
                                      bSync         : integer
                                     ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_FlowUpdateRelation';
    //消费,余额变更
    function TPE_FlowCost			       (
                                      CustomSn      :  Cardinal ;
                                      pReq          : PtagTPE_FlowCostReq		    ;
                                      FlowCount     : integer               ;
                                      pRes          : PtagTPE_FlowCostRes			  ;
                                      bSync         : integer
                                     ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_FlowCost';

    //挂失解挂
    function TPE_Lost			          (
                                      CustomSn      :  Cardinal ;
                                      pReq          : PtagTPE_LostReq		  ;
                                      pRes          : PtagTPE_LostRes		  ;
                                      bSync         : integer
                                     ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_Lost';
    //对帐
    function TPE_CheckBySn		       (
                                      CustomSn      :  Cardinal ;
                                      pReq          : PtagTPE_CheckBySnReq      ;
                                      pRes          : PtagTPE_CheckBySnRes		  ;
                                      bSync         : integer
                                     ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_CheckBySn';
    //对帐
    function TPE_CheckByTime	       (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_CheckByTimeReq			;
                                      pRes          : PtagTPE_CheckByTimeRes		  ;
                                      bSync         : integer
                                     ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_CheckByTime';
    //对帐
    function TPE_CheckByDetail	     (
                                      CustomSn      : Cardinal ;
                                      pReq  : PtagTPE_CheckByDetailReq		;
                                      pRes  : PtagTPE_CheckByDetailRes	  ;
                                      bSync         : integer
                                     ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_CheckByDetail';

    //取流水号
    function TPE_OnLineGetMaxSn		 (
                                      CustomSn      : Cardinal ;
                                      pRes          : PtagTPE_OnLineGetMaxSnRes		;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_OnLineGetMaxSn';
    //枚举配置日志
    function TPE_ConfigEnumLog		 (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_ConfigEnumLogReq	;
                                      pResControl	  : PtagTPE_QueryResControl;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_ConfigEnumLog';
    //枚举部门
    function TPE_ConfigEnumDept		 (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_ConfigEnumDeptReq	;
                                      pResControl		: PtagTPE_QueryResControl		;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_ConfigEnumDept';
    //枚举身份
    function TPE_ConfigEnumIdenti	 (
                                      CustomSn      : Cardinal ;
                                      pReq          : ptagTPE_ConfigEnumIdentiReq ;
                                      pResControl		: PtagTPE_QueryResControl			;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_ConfigEnumIdenti';
    //枚举身份扩展
    function TPE_ConfigEnumIdentiEx(
                                      CustomSn      : Cardinal ;
                                      pReq          : ptagTPE_ConfigEnumIdentiReq ;
                                      pResControl		: PtagTPE_QueryResControl			;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_ConfigEnumIdentiEx';

    //枚举民族
    function TPE_ConfigEnumNation	 (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_ConfigEnumNationReq;
                                      pResControl		: PtagTPE_QueryResControl			;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_ConfigEnumNation';
    //枚举证件类型
    function TPE_ConfigEnumCert		 (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_ConfigEnumCertReq  ;
                                      pResControl		: PtagTPE_QueryResControl		 ;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_ConfigEnumCert';

    //操作员登录
    function TPE_ManageOperLogin	 (
                                      CustomSn      : Cardinal ;
                                      pReq : PtagTPE_ManageOperLoginReq  ;
                                      pRes : PtagTPE_ManageOperLoginRes  ;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_ManageOperLogin';

    //枚举签退
    function TPE_ManageOperLogout	 (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_ManageOperLogoutReq ;
                                      pRes          : PtagTPE_ManageOperLogoutRes ;
                                      bSync         : integer
                                   ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_ManageOperLogout';
    //内存释放
    function TPE_Free              ( pData : pointer): Integer; stdcall; external 'TPE.DLL' name 'TPE_Free';


    //获得本机节点
    function TPE_GetLocalNode()                     : Integer; stdcall; external 'TPE.DLL' name 'TPE_GetLocalNode';

    //获得网络状态
    function TPE_GetNetState ()                     : Integer; stdcall; external 'TPE.DLL' name 'TPE_GetNetState';

    //取白名单
    function TPE_GetWL( pRec : PtagWhiteListRec  )  : Integer; stdcall; external 'TPE.DLL' name 'TPE_GetWL';

    //取节点编号
    function TPE_GetLocalNodeSn ( pSn : pCardinal ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_GetLocalNodeSn';

    //下载全部白名单
    function TPE_DownloadAllWL( )                   : Integer; stdcall; external 'TPE.DLL' name 'TPE_DownloadAllWL';

    //校验密码
    function TPE_CheckPassword(    pPwd : PtagTPE_CheckPassword ): Integer; stdcall; external 'TPE.DLL' name 'TPE_CheckPassword';

    //传输文件
    function TPE_TransferFile       (
                                      CustomSn      : Cardinal ;
                                      pReq          : PtagTPE_TransferFileReq  ;
                                      pRes          : PtagTPE_TransferFileRes  ;
                                      bSync         : integer
                                    ) : Integer; stdcall; external 'TPE.DLL' name 'TPE_TransferFile';
const
    //定义TPE返回值
    TPE_ERROR_UNPACK             = -5  ; //解包错误
    TPE_ERROR_PARAMETER          = -4  ; //入口参数错误
    TPE_ERROR_INTERNAL           = -3  ; //内部错误,
    TPE_ERROR_NETFAIL            = -2  ; //网络故障,可能已经断网(socket错误等)
    TPE_ERROR_UNREACHABLE        = -1  ; //后台不可达
                                 // 0    //成功
    TPE_ERROR_TIMEOUT            =  1  ; //超时
    TPE_ERROR_NODATA             =  2  ; //没有数据
    TPE_ERROR_LESSBUFFERLEN      =  3  ; //缓冲区太小


    //CONDITION字段一些标志位定义
    CONDITION_MASK_CLOSE		    = $00000002    ;
    CONDITION_MASK_FREEZE		    = $00000004    ;
    CONDITION_MASK_LOST			    = $00000008    ;
    CONDITION_MASK_AUTOTRANS    = $00000010    ;
    CONDITION_MASK_SELFTRANS    = $00000020    ;

implementation

end.


