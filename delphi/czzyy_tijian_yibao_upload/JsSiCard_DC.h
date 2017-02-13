#ifndef SocialSecurityCarder_H_
#define SocialSecurityCarder_H_

//返回码定义
#define SB_ERR_OK 0
#define SB_ERR_UNKNOWN -1
#define SB_ERR_PORTPARAMETER -2
#define SB_ERR_CONNECT -3
#define SB_ERR_DEVICEUNINIT -4
#define SB_ERR_GETDEVICEVER -5
#define SB_ERR_SETSLOTID -6
#define SB_ERR_UNSLOTID -7
#define SB_ERR_RESET_CPU -8
#define SB_ERR_RESET_SAM -9
#define SB_ERR_ApduErr -10
#define SB_ERR_CARDMISS -11
#define SB_ERR_NORESPONSE_CPU -12
#define SB_ERR_NORESPONSE_SAM -13
#define SB_ERR_PTClock -14
#define SB_ERR_StateErr -15
#define SB_ERR_KeyBlock -16
#define SB_ERR_FunctionNotSupported -17
#define SB_ERR_UnfindRecord -18
#define SB_ERR_SamKeyUnExist -19
#define SB_ERR_OffsetOut -20
#define SB_ERR_RpErr -21
#define SB_ERR_ENTERROOT -22
#define SB_ERR_INTERNAL -23
#define SB_ERR_PINLEN -24
#define SB_ERR_PIN -25
#define SB_ERR_UNKEYNAME -26
#define SB_ERR_FileUnExist -27
#define SB_ERR_RecordUnExist -28
#define SB_ERR_BYCOS -29
#define SB_ERR_InvalidFiletype -30
#define SB_ERR_GetFileReocrdCounts -31
#define SB_ERR_KBCONNECT -32
#define SB_ERR_InputPassOutTime -33
#define SB_ERR_GetPassCancel -34
#define SB_ERR_KBTimeOut -35
#define SB_ERR_CNStyleErr -36
#define SB_ERR_InvalidAPP -37
#define SB_ERR_APPLKLOSS -38
#define SB_ERR_APPSTKLOSS -39
#define SB_ERR_BKLOSS -40
#define SB_ERR_CHECKCARDFLAG -41
#define SB_ERR_CARDVERUNKNOW -42
#define SB_ERR_UNSUPPORTED -43
#define SB_ERR_PARAMETER -44
#define SB_ERR_RCertInfos -45
#define SB_ERR_CreatePhotoFile -46
#define SB_ERR_GetHolderPhotor -47
#define SB_ERR_InvalidCylFile -48
#define SB_ERR_InvalidBtlvFile -49
#define SB_ERR_MoneyStyleErr -50
#define SB_ERR_HASBEENOPENED -51
#define SB_ERR_InvalidCylFiletype -52
#define SB_ERR_InvalidBtlvFiletype -53
#define SB_ERR_InvalidRecordtype -54
#define SB_ERR_InvalidMoneyRecordSize -55
#define SB_ERR_FILEADDR -56
#define SB_ERR_NoL1Spliter -57
#define SB_ERR_DFEFStyleInvalid -58
#define SB_ERR_LoseSpliter -59
#define SB_ERR_InvalidDFEF -60
#define SB_ERR_TagNoErr -61
#define SB_ERR_ExternAuthErr -62
#define SB_ERR_GetChildCounts -63
#define SB_ERR_ChildItemsErr -64
#define SB_ERR_DataLenOutAllow -65
#define SB_ERR_MoneyItemSizeErr -66
#define SB_ERR_BSNItemSizeErr -67
#define SB_ERR_HEXStyleErr -68
#define SB_ERR_NumStyleErr -69
#define SB_ERR_PINLENSHORT -70
#define SB_ERR_PINLENOUT -71
#define SB_ERR_PINLCSRBYZ -72
#define SB_ERR_DEVICESNR -73
#define SB_ERR_PlayVoice -74
/*********************************************Special definition*************************************************/
#define SB_ERR_DataStyleInvalid 304 //规范中特殊定义 "读写卡输入串格式错误", 这里等效于各种自定义的"数据格式无效"
#define SB_ERR_DATAOUT 305          //规范中特殊定义"读写卡输入的操作数越界",这里等效于"SB_ERR_DataLenOutAllow"
#define SB_ERR_DataInvalid 306      //规范中特殊定义"读写卡输入的操作数非法",这里等效于各种自定义的"数据类型无效"
//end of errcode
/*****************************************************************************************************************/
/****************************************************************************************************************/
#define ERR_OPENPORT	101		//打开端口失败
#define ERR_DEVICE		102		//读写器未连接
#define ERR_PORTUSED	103		//端口被占用
#define ERR_CLOSEPORT	104		//端口关闭失败
#define ERR_NOCPUCARD	201		//读写器内无卡
#define ERR_SAMRESET	202		//PSAM卡上电失败
#define ERR_CPURESET	203		//CPU卡上电失败
#define ERR_CARDTYPE	301		//卡类型不匹配
#define ERR_CARDKEY		302		//卡密钥校验失败
#define ERR_CARDPIN		303		//卡密码校验失败
#define ERR_DATASTYLE	304		//读写卡输入串格式错误
#define ERR_DATAOVERLOW	305		//读写卡输入的操作数越界
#define ERR_DATAINVALID	306		//读写卡输入的操作数非法
#define ERR_READCARD	307		//读取卡上信息失败
#define ERR_WRITECARD	308		//信息写入卡上失败
#define ERR_UNKNOWN		999		//其他错误
/******************************************************************/
#define ERR_KEYLOCK		401		//卡被锁
#define ERR_CARD_NR		402		//卡插反
#define ERR_ENTERROOT	403		//PSAM1卡座插了老PSAM卡或是PSAM2卡座插了新PSAM卡
#define ERR_PINLOCK		404		//PIN码锁定
#define	ERR_KBUNCONNECT	405		//密码键盘未连接
/******************************************************************/

typedef struct Errmsg{
	int errcode;
	char errDescription[256];
}ErrInfo;

static const ErrInfo g_error_info_table[] = {
	{SB_ERR_OK,"成功"},
	{SB_ERR_UNKNOWN,"未知错误"},
	{SB_ERR_PORTPARAMETER, "端口参数无效"},
	{SB_ERR_CONNECT,"设备连接异常"},
	{SB_ERR_DEVICEUNINIT,"设备未初始化或已关闭"},
	{SB_ERR_GETDEVICEVER,"设备版本信息读取异常"},
	{SB_ERR_SETSLOTID,"设置卡座异常"},
	{SB_ERR_UNSLOTID,"卡座参数无效"},
	{SB_ERR_RESET_CPU,"用户卡复位异常[卡插卡或卡型无效]"},
	{SB_ERR_RESET_SAM,"SAM卡复位异常[卡插卡或卡型无效]"},
	{SB_ERR_ApduErr,"APDU无效"},
	{SB_ERR_CARDMISS,"无卡"},
	{SB_ERR_NORESPONSE_CPU,"用户卡无响应[请重试]"},
	{SB_ERR_NORESPONSE_SAM,"SAM卡无响应[请重试]"},
	{SB_ERR_PTClock,"9303应用永久锁定"},
	{SB_ERR_StateErr,"6982不满足安全状态"},
	{SB_ERR_KeyBlock,"6983认证密钥已锁定"},
	{SB_ERR_FunctionNotSupported,"6A81功能不支持[已锁定]"},
	{SB_ERR_UnfindRecord,"6A83未找到记录"},
	{SB_ERR_SamKeyUnExist,"6A88,SAM卡密钥不存在,无该操作权限[BFDE]"},
	{SB_ERR_OffsetOut,"6B00起始地址错误,偏移超出"},
	{SB_ERR_RpErr,"卡片无响应,请重试!"},
	{SB_ERR_ENTERROOT,"选择应用环境异常"},
	{SB_ERR_INTERNAL,"内部认证失败[认证数据不匹配]"},
	{SB_ERR_PINLEN,"PIN长度无效[有效长度4~12个字符]"},
	{SB_ERR_PIN,"PIN错误"},
	{SB_ERR_UNKEYNAME,"所认证密钥的名称无效"},
	{SB_ERR_FileUnExist,"指定文件不存在[参数DF/EF无效]"},
	{SB_ERR_RecordUnExist,"指定记录不存在[参数P1/P2无效]"},
	{SB_ERR_BYCOS,"该记录由COS维护,不允许操作"},
	{SB_ERR_InvalidFiletype,"文件类型无效[内部错误,请检查g_card_record_info]"},
	{SB_ERR_GetFileReocrdCounts,"获取记录文件大小异常[内部错误,请检查g_card_record_info]"},
	{SB_ERR_KBCONNECT,"密码键盘通讯异常"},
	{SB_ERR_InputPassOutTime,"密码键盘输入超时"},
	{SB_ERR_GetPassCancel,"用户取消输入"},
	{SB_ERR_KBTimeOut,"密码输入超时"},
	{SB_ERR_CNStyleErr,"传入数据CN格式校验未通过"},
	{SB_ERR_InvalidAPP,"应用名称无效"},
	{SB_ERR_APPLKLOSS,"应用LK缺失[内部错误,请检查g_KeyRelation]"},
	{SB_ERR_APPSTKLOSS,"应用STK缺失[内部错误,请检查g_KeyRelation]"},
	{SB_ERR_BKLOSS,"锁卡控制BK缺失[内部错误,请检查g_KeyRelation]"},
	{SB_ERR_CHECKCARDFLAG,"识别卡类型异常"},
	{SB_ERR_CARDVERUNKNOW,"卡类型不匹配[未定义]"},
	{SB_ERR_UNSUPPORTED,"功能不支持"},
	{SB_ERR_PARAMETER,"参数错误"},
	{SB_ERR_RCertInfos,"读取身份证基础信息失败"},
	{SB_ERR_CreatePhotoFile,"生成身份证持卡人照片文件失败"},
	{SB_ERR_GetHolderPhotor,"提取身份证照片信息失败"},
	{SB_ERR_InvalidCylFile,"循环记录未找到[内部错误,请检查g_cycle_file_info]"},
	{SB_ERR_InvalidCylFile,"btlv记录未找到[内部错误,请检查g_btlv_record_info]"},
	{SB_ERR_MoneyStyleErr,"传入金额数据项格式校验未通过"},
	{SB_ERR_HASBEENOPENED,"端口已打开,请先关闭!"},
	{SB_ERR_InvalidCylFiletype,"文件类型无效[内部错误,请检查g_cycle_file_info]"},
	{SB_ERR_InvalidBtlvFiletype,"文件类型无效[内部错误,请检查g_btlv_record_info]"},
	{SB_ERR_InvalidRecordtype,"记录类型无效[内部错误,请检查g_card_record_info]"},
	{SB_ERR_InvalidMoneyRecordSize,"金额子段长度无效[内部错误,请检查g_cycle_file_info]"},
	{SB_ERR_FILEADDR,"卡文件标识符格式错误"},
	{SB_ERR_NoL1Spliter,"入参格式无效[缺少$分割符]"},
	{SB_ERR_DFEFStyleInvalid,"入参格式无效[应用和文件段无效]"},
	{SB_ERR_LoseSpliter,"入参格式无效[缺少分隔符]"},
	{SB_ERR_InvalidDFEF,"表中未找到相应DFEF记录[请检查入参]"},
	{SB_ERR_TagNoErr,"入参无效[记录号或Tag标识格式不对]"},
	{SB_ERR_ExternAuthErr,"外部认证未通过[0082失败]"},
	{SB_ERR_GetChildCounts,"子项信息获取失败![内部错误,请检查数据表]"},
	{SB_ERR_ChildItemsErr,"传入数据与文件定义不匹配[子项条目不匹配]"},
	{SB_ERR_DataLenOutAllow,"传入数据长度超出定义的最大长度"},
	{SB_ERR_MoneyItemSizeErr,"金额数据,长度无效![内部错误,请检查数据表]"},
	{SB_ERR_BSNItemSizeErr,"金额数据,长度无效![内部错误,请检查数据表,B_SN记录]"},
	{SB_ERR_HEXStyleErr,"传入数据HEX格式校验未通过"},
	{SB_ERR_NumStyleErr,"传入数据数字格式校验未通过"},
	{SB_ERR_PINLENSHORT,"输入PIN码无效,长度不足6位"},
	{SB_ERR_PINLENOUT,"输入PIN码无效,长度超过6位"},
	{SB_ERR_PINLCSRBYZ,"两次输入PIN码不一致"},
	{SB_ERR_DEVICESNR,"设备序列号读取或校验异常"},
	{SB_ERR_PlayVoice,"P3语音播放异常"},
	/********************************************************/
	{ERR_OPENPORT,"打开端口失败"},
	{ERR_DEVICE,"读写器未连接"},
	{ERR_PORTUSED,"端口被占用"},
	{ERR_CLOSEPORT,"端口关闭失败"},
	{ERR_NOCPUCARD,"读写器内无卡"},
	{ERR_SAMRESET,"PSAM卡上电失败"},
	{ERR_CPURESET,"CPU卡上电失败"},
	{ERR_CARDTYPE,"卡类型不匹配"},
	{ERR_CARDKEY,"卡密钥校验失败"},
	{ERR_CARDPIN,"卡密码校验失败"},
	{ERR_DATASTYLE,"读写卡输入串格式错误"},
	{ERR_DATAOVERLOW,"读写卡输入的操作数越界"},
	{ERR_DATAINVALID,"读写卡输入的操作数非法"},
	{ERR_READCARD,"读取卡上信息失败"},
	{ERR_WRITECARD,"信息写入卡上失败"},
	{ERR_UNKNOWN,"其他错误"},
	/*********************************************************/
	{ERR_KEYLOCK,"卡被锁"},
	{ERR_CARD_NR,"卡插反"},
	{ERR_ENTERROOT,"PSAM1卡座插了老PSAM卡或是PSAM2卡座插了新PSAM卡"},
	{ERR_PINLOCK,"PIN码锁定"},
	{ERR_KBUNCONNECT,"密码键盘未连接"},
	/*********************************************************/
};
//end of g_error_info_table

#ifdef __cplusplus
extern "C" {
#endif  //end of __cplusplus

/*东软平台*/

/*创智平台*/

/*万达平台*/

/*莱斯平台LApp_Les_*/
int __stdcall iOpenPort(int pReaderPort,int *pReaderHandle,char *pErrMsg);
int __stdcall iClosePort(int pReaderHandle ,char* pErrMsg);
int __stdcall iReadCardFlag(int pReaderHandle,char *nCardFlag ,char* pErrMsg);
int __stdcall iReadCardFlagX(char *nCardFlag ,char* pErrMsg);
int __stdcall iReadCard(int pReaderHandle,const char* pInputPin,const char *pFileAddr,char *pOutDataBuff,char *pErrMsg);
int __stdcall iReadCardX(const char* pInputPin,const char *pFileAddr,char *pOutDataBuff,char *pErrMsg);
int __stdcall iWriteCard(int pReaderHandle,const char* pInputPin, const char* pFileAddr, char* pWriteDataBuff,char* pErrMsg);
int __stdcall iWriteCardX(const char* pInputPin, const char* pFileAddr, char* pWriteDataBuff,char* pErrMsg);
int __stdcall iCardControl(int pReaderHandle,const char * pCtrlType, const char * pCtrlInfo,char*  pErrMsg);
int __stdcall iCardControlX(const char * pCtrlType, const char * pCtrlInfo,char*  pErrMsg);
int __stdcall iCardReadAtr(int pReaderHandle,char* pCardAtr,char* pErrMsg);
int __stdcall iCardReadAtrX(char* pCardAtr,char* pErrMsg);
int __stdcall iReadCardNo(int pReaderHandle,const char* pInputPin,  char* pCardNo, char* pErrMsg);
int __stdcall iReadCardNoX(const char* pInputPin,  char* pCardNo, char* pErrMsg);
int __stdcall iReadPin(int pReaderHandle,const char * pCtrlType,char *pInputPin, char* pErrMsg);
int __stdcall iReadPinX(const char * pCtrlType,char *pInputPin, char* pErrMsg);
int __stdcall iReadVer(char *pVerInfo, char* pErrMsg);
int __stdcall iReadCardEX(const char* pInputPin, const char* pFileAddr, char* pOutDataBuff, char* pErrMsg);
int __stdcall iWriteCardEX(const char* pInputPin, const char* pFileAddr, char* pWriteDataBuff, char* pErrMsg);
int __stdcall iReadIDMsg(int pReaderPort,const char *pBmpFile,char *Pname, 
						 char *pSex,char *pNation,char *pBirth,char *pAddress,
						 char *pCertNo,char *pDepartment,char *pExpire,char *pErrMsg);

int __stdcall CardPowerOn(int card_no, int outtime,unsigned char*atr);
int __stdcall CardApdu (int card_no , int outtime , unsigned char*c_apdu, unsigned char*r_apdu);
int __stdcall CardPowerOff(int card_no,int outtime);

/*读卡器*/
int __stdcall LPub_Reader_Open(int port,long baud,int *connectedport,char *errInfo);
int __stdcall LPub_Reader_Close(int handle,char *errInfo);
int __stdcall LPub_Reader_GetVer(int handle,unsigned char *Ver,char *errInfo);
int __stdcall LPub_Reader_SetSlotNo(int handle,int slotNo,char *errInfo);
int __stdcall LPub_Reader_CardReset(int handle,int slotNo,int *atrLen,char *ATR,char *errInfo);
int __stdcall LPub_Reader_APDU(int handle,int iSlen,unsigned char *sCmd,int *iRlen,unsigned char *rBuffer,int slotNo,char *errInfo);
int __stdcall LPub_Reader_Down(int handle,char *errInfo);
int __stdcall LPub_Reader_CheckCardFlag(int handle,char *nCardFlag ,char* errInfo);


/*卡片*/
int __stdcall LPub_IC_InternalAuth(int handle,char *errmsg);
int __stdcall LPub_IC_ExternalAuth(int handle,char *keyName,char *errInfo);
int __stdcall LPub_IC_VerifyPIN(int handle,char *PIN,int *reTrys,char *errInfo);
int __stdcall LPub_IC_ChangePIN(int handle,char *oldPIN,char *newPIN,int *reTrys,char *errInfo);
int __stdcall LPub_IC_ReloadPIN(int handle, char *newPIN, char *errInfo);
int __stdcall LPub_IC_UnlockPIN(int handle,char *errInfo);
int __stdcall LPub_IC_ReadRecord(int handle,char *PIN,char *DF,char *EF,int P1,int P2,int NeedExterAuth,int TransType,char *RecordBuff,char *errInfo);
int __stdcall LPub_IC_ReadFile(int handle,char *PIN,char *DF,char *EF,int TransType,char *RecordBuff,char *errInfo);
int __stdcall LPub_IC_WriteRecord (int handle,char *PIN,char *DF,char *EF, int P1,int P2,int NeedExterAuth,unsigned char *RecordBuff,char * errInfo);
int __stdcall LPub_IC_AppBlock(int handle,char *AppName,char * errInfo);
int __stdcall LPub_IC_CardBlock(int handle, char * errInfo);
int __stdcall LPub_IC_CertCardInfos(int pReaderPort,const char *pBmpFile,char *Pname,char *pSex,char *pNation,
									char *pBirth,char *pAddress,char *pCertNo,char *pDepartment,char *pExpire,char *pErrMsg);

int __stdcall JS_CheckPin(int handle,char *ErrInfo);
/*外设密码键盘*/
int __stdcall LPub_SD_GetPIN(int handle,unsigned char Voicemode,unsigned char ctime,
							 unsigned char *rlen,char *cpass, char * errInfo);
int __stdcall iReadPsamX(char *pPsam,char *pErrMsg);

int __stdcall LPub_SD_GetPassword(int handle,int voice,unsigned char ctime,int passlen,char *cpass, char * errInfo);
int __stdcall LPub_SD_GetPassword_One(int handle,unsigned char ctime,int passlen,char *cpass, char * errInfo);
int __stdcall LPub_SD_GetPassword_Two(int handle,unsigned char ctime,int passlen,char *cpass, char * errInfo);

/*常州接口*/
int __stdcall Reader_Open(int port,long baud,char *errInfo);
int __stdcall Reader_Close(int handle,char *errInfo);
int __stdcall Reader_GetVer(int handle,unsigned char *Ver,char *errInfo);
int __stdcall Reader_SetSlotNo(int handle,int slotNo,char *errInfo);
int __stdcall Reader_CardReset(int handle,int slotNo,int *atrLen,char *ATR,char *errInfo);
int __stdcall Reader_APDU(int handle,int iSlen,unsigned char *sCmd,int *iRlen,unsigned char *rBuffer,int slotNo,char *errInfo);
int __stdcall Reader_Down(int handle,char *errInfo);
int __stdcall Reader_CheckCardFlag(int handle,char *nCardFlag ,char* errInfo);
#ifdef __cplusplus
}
#endif  //end of __cplusplus

#endif //end of SocialSecurityCarder_H_