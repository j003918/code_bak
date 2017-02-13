#ifndef SocialSecurityCarder_H_
#define SocialSecurityCarder_H_

//�����붨��
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
#define SB_ERR_DataStyleInvalid 304 //�淶�����ⶨ�� "��д�����봮��ʽ����", �����Ч�ڸ����Զ����"���ݸ�ʽ��Ч"
#define SB_ERR_DATAOUT 305          //�淶�����ⶨ��"��д������Ĳ�����Խ��",�����Ч��"SB_ERR_DataLenOutAllow"
#define SB_ERR_DataInvalid 306      //�淶�����ⶨ��"��д������Ĳ������Ƿ�",�����Ч�ڸ����Զ����"����������Ч"
//end of errcode
/*****************************************************************************************************************/
/****************************************************************************************************************/
#define ERR_OPENPORT	101		//�򿪶˿�ʧ��
#define ERR_DEVICE		102		//��д��δ����
#define ERR_PORTUSED	103		//�˿ڱ�ռ��
#define ERR_CLOSEPORT	104		//�˿ڹر�ʧ��
#define ERR_NOCPUCARD	201		//��д�����޿�
#define ERR_SAMRESET	202		//PSAM���ϵ�ʧ��
#define ERR_CPURESET	203		//CPU���ϵ�ʧ��
#define ERR_CARDTYPE	301		//�����Ͳ�ƥ��
#define ERR_CARDKEY		302		//����ԿУ��ʧ��
#define ERR_CARDPIN		303		//������У��ʧ��
#define ERR_DATASTYLE	304		//��д�����봮��ʽ����
#define ERR_DATAOVERLOW	305		//��д������Ĳ�����Խ��
#define ERR_DATAINVALID	306		//��д������Ĳ������Ƿ�
#define ERR_READCARD	307		//��ȡ������Ϣʧ��
#define ERR_WRITECARD	308		//��Ϣд�뿨��ʧ��
#define ERR_UNKNOWN		999		//��������
/******************************************************************/
#define ERR_KEYLOCK		401		//������
#define ERR_CARD_NR		402		//���巴
#define ERR_ENTERROOT	403		//PSAM1����������PSAM������PSAM2����������PSAM��
#define ERR_PINLOCK		404		//PIN������
#define	ERR_KBUNCONNECT	405		//�������δ����
/******************************************************************/

typedef struct Errmsg{
	int errcode;
	char errDescription[256];
}ErrInfo;

static const ErrInfo g_error_info_table[] = {
	{SB_ERR_OK,"�ɹ�"},
	{SB_ERR_UNKNOWN,"δ֪����"},
	{SB_ERR_PORTPARAMETER, "�˿ڲ�����Ч"},
	{SB_ERR_CONNECT,"�豸�����쳣"},
	{SB_ERR_DEVICEUNINIT,"�豸δ��ʼ�����ѹر�"},
	{SB_ERR_GETDEVICEVER,"�豸�汾��Ϣ��ȡ�쳣"},
	{SB_ERR_SETSLOTID,"���ÿ����쳣"},
	{SB_ERR_UNSLOTID,"����������Ч"},
	{SB_ERR_RESET_CPU,"�û�����λ�쳣[���忨������Ч]"},
	{SB_ERR_RESET_SAM,"SAM����λ�쳣[���忨������Ч]"},
	{SB_ERR_ApduErr,"APDU��Ч"},
	{SB_ERR_CARDMISS,"�޿�"},
	{SB_ERR_NORESPONSE_CPU,"�û�������Ӧ[������]"},
	{SB_ERR_NORESPONSE_SAM,"SAM������Ӧ[������]"},
	{SB_ERR_PTClock,"9303Ӧ����������"},
	{SB_ERR_StateErr,"6982�����㰲ȫ״̬"},
	{SB_ERR_KeyBlock,"6983��֤��Կ������"},
	{SB_ERR_FunctionNotSupported,"6A81���ܲ�֧��[������]"},
	{SB_ERR_UnfindRecord,"6A83δ�ҵ���¼"},
	{SB_ERR_SamKeyUnExist,"6A88,SAM����Կ������,�޸ò���Ȩ��[BFDE]"},
	{SB_ERR_OffsetOut,"6B00��ʼ��ַ����,ƫ�Ƴ���"},
	{SB_ERR_RpErr,"��Ƭ����Ӧ,������!"},
	{SB_ERR_ENTERROOT,"ѡ��Ӧ�û����쳣"},
	{SB_ERR_INTERNAL,"�ڲ���֤ʧ��[��֤���ݲ�ƥ��]"},
	{SB_ERR_PINLEN,"PIN������Ч[��Ч����4~12���ַ�]"},
	{SB_ERR_PIN,"PIN����"},
	{SB_ERR_UNKEYNAME,"����֤��Կ��������Ч"},
	{SB_ERR_FileUnExist,"ָ���ļ�������[����DF/EF��Ч]"},
	{SB_ERR_RecordUnExist,"ָ����¼������[����P1/P2��Ч]"},
	{SB_ERR_BYCOS,"�ü�¼��COSά��,���������"},
	{SB_ERR_InvalidFiletype,"�ļ�������Ч[�ڲ�����,����g_card_record_info]"},
	{SB_ERR_GetFileReocrdCounts,"��ȡ��¼�ļ���С�쳣[�ڲ�����,����g_card_record_info]"},
	{SB_ERR_KBCONNECT,"�������ͨѶ�쳣"},
	{SB_ERR_InputPassOutTime,"����������볬ʱ"},
	{SB_ERR_GetPassCancel,"�û�ȡ������"},
	{SB_ERR_KBTimeOut,"�������볬ʱ"},
	{SB_ERR_CNStyleErr,"��������CN��ʽУ��δͨ��"},
	{SB_ERR_InvalidAPP,"Ӧ��������Ч"},
	{SB_ERR_APPLKLOSS,"Ӧ��LKȱʧ[�ڲ�����,����g_KeyRelation]"},
	{SB_ERR_APPSTKLOSS,"Ӧ��STKȱʧ[�ڲ�����,����g_KeyRelation]"},
	{SB_ERR_BKLOSS,"��������BKȱʧ[�ڲ�����,����g_KeyRelation]"},
	{SB_ERR_CHECKCARDFLAG,"ʶ�������쳣"},
	{SB_ERR_CARDVERUNKNOW,"�����Ͳ�ƥ��[δ����]"},
	{SB_ERR_UNSUPPORTED,"���ܲ�֧��"},
	{SB_ERR_PARAMETER,"��������"},
	{SB_ERR_RCertInfos,"��ȡ���֤������Ϣʧ��"},
	{SB_ERR_CreatePhotoFile,"�������֤�ֿ�����Ƭ�ļ�ʧ��"},
	{SB_ERR_GetHolderPhotor,"��ȡ���֤��Ƭ��Ϣʧ��"},
	{SB_ERR_InvalidCylFile,"ѭ����¼δ�ҵ�[�ڲ�����,����g_cycle_file_info]"},
	{SB_ERR_InvalidCylFile,"btlv��¼δ�ҵ�[�ڲ�����,����g_btlv_record_info]"},
	{SB_ERR_MoneyStyleErr,"�������������ʽУ��δͨ��"},
	{SB_ERR_HASBEENOPENED,"�˿��Ѵ�,���ȹر�!"},
	{SB_ERR_InvalidCylFiletype,"�ļ�������Ч[�ڲ�����,����g_cycle_file_info]"},
	{SB_ERR_InvalidBtlvFiletype,"�ļ�������Ч[�ڲ�����,����g_btlv_record_info]"},
	{SB_ERR_InvalidRecordtype,"��¼������Ч[�ڲ�����,����g_card_record_info]"},
	{SB_ERR_InvalidMoneyRecordSize,"����Ӷγ�����Ч[�ڲ�����,����g_cycle_file_info]"},
	{SB_ERR_FILEADDR,"���ļ���ʶ����ʽ����"},
	{SB_ERR_NoL1Spliter,"��θ�ʽ��Ч[ȱ��$�ָ��]"},
	{SB_ERR_DFEFStyleInvalid,"��θ�ʽ��Ч[Ӧ�ú��ļ�����Ч]"},
	{SB_ERR_LoseSpliter,"��θ�ʽ��Ч[ȱ�ٷָ���]"},
	{SB_ERR_InvalidDFEF,"����δ�ҵ���ӦDFEF��¼[�������]"},
	{SB_ERR_TagNoErr,"�����Ч[��¼�Ż�Tag��ʶ��ʽ����]"},
	{SB_ERR_ExternAuthErr,"�ⲿ��֤δͨ��[0082ʧ��]"},
	{SB_ERR_GetChildCounts,"������Ϣ��ȡʧ��![�ڲ�����,�������ݱ�]"},
	{SB_ERR_ChildItemsErr,"�����������ļ����岻ƥ��[������Ŀ��ƥ��]"},
	{SB_ERR_DataLenOutAllow,"�������ݳ��ȳ����������󳤶�"},
	{SB_ERR_MoneyItemSizeErr,"�������,������Ч![�ڲ�����,�������ݱ�]"},
	{SB_ERR_BSNItemSizeErr,"�������,������Ч![�ڲ�����,�������ݱ�,B_SN��¼]"},
	{SB_ERR_HEXStyleErr,"��������HEX��ʽУ��δͨ��"},
	{SB_ERR_NumStyleErr,"�����������ָ�ʽУ��δͨ��"},
	{SB_ERR_PINLENSHORT,"����PIN����Ч,���Ȳ���6λ"},
	{SB_ERR_PINLENOUT,"����PIN����Ч,���ȳ���6λ"},
	{SB_ERR_PINLCSRBYZ,"��������PIN�벻һ��"},
	{SB_ERR_DEVICESNR,"�豸���кŶ�ȡ��У���쳣"},
	{SB_ERR_PlayVoice,"P3���������쳣"},
	/********************************************************/
	{ERR_OPENPORT,"�򿪶˿�ʧ��"},
	{ERR_DEVICE,"��д��δ����"},
	{ERR_PORTUSED,"�˿ڱ�ռ��"},
	{ERR_CLOSEPORT,"�˿ڹر�ʧ��"},
	{ERR_NOCPUCARD,"��д�����޿�"},
	{ERR_SAMRESET,"PSAM���ϵ�ʧ��"},
	{ERR_CPURESET,"CPU���ϵ�ʧ��"},
	{ERR_CARDTYPE,"�����Ͳ�ƥ��"},
	{ERR_CARDKEY,"����ԿУ��ʧ��"},
	{ERR_CARDPIN,"������У��ʧ��"},
	{ERR_DATASTYLE,"��д�����봮��ʽ����"},
	{ERR_DATAOVERLOW,"��д������Ĳ�����Խ��"},
	{ERR_DATAINVALID,"��д������Ĳ������Ƿ�"},
	{ERR_READCARD,"��ȡ������Ϣʧ��"},
	{ERR_WRITECARD,"��Ϣд�뿨��ʧ��"},
	{ERR_UNKNOWN,"��������"},
	/*********************************************************/
	{ERR_KEYLOCK,"������"},
	{ERR_CARD_NR,"���巴"},
	{ERR_ENTERROOT,"PSAM1����������PSAM������PSAM2����������PSAM��"},
	{ERR_PINLOCK,"PIN������"},
	{ERR_KBUNCONNECT,"�������δ����"},
	/*********************************************************/
};
//end of g_error_info_table

#ifdef __cplusplus
extern "C" {
#endif  //end of __cplusplus

/*����ƽ̨*/

/*����ƽ̨*/

/*���ƽ̨*/

/*��˹ƽ̨LApp_Les_*/
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

/*������*/
int __stdcall LPub_Reader_Open(int port,long baud,int *connectedport,char *errInfo);
int __stdcall LPub_Reader_Close(int handle,char *errInfo);
int __stdcall LPub_Reader_GetVer(int handle,unsigned char *Ver,char *errInfo);
int __stdcall LPub_Reader_SetSlotNo(int handle,int slotNo,char *errInfo);
int __stdcall LPub_Reader_CardReset(int handle,int slotNo,int *atrLen,char *ATR,char *errInfo);
int __stdcall LPub_Reader_APDU(int handle,int iSlen,unsigned char *sCmd,int *iRlen,unsigned char *rBuffer,int slotNo,char *errInfo);
int __stdcall LPub_Reader_Down(int handle,char *errInfo);
int __stdcall LPub_Reader_CheckCardFlag(int handle,char *nCardFlag ,char* errInfo);


/*��Ƭ*/
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
/*�����������*/
int __stdcall LPub_SD_GetPIN(int handle,unsigned char Voicemode,unsigned char ctime,
							 unsigned char *rlen,char *cpass, char * errInfo);
int __stdcall iReadPsamX(char *pPsam,char *pErrMsg);

int __stdcall LPub_SD_GetPassword(int handle,int voice,unsigned char ctime,int passlen,char *cpass, char * errInfo);
int __stdcall LPub_SD_GetPassword_One(int handle,unsigned char ctime,int passlen,char *cpass, char * errInfo);
int __stdcall LPub_SD_GetPassword_Two(int handle,unsigned char ctime,int passlen,char *cpass, char * errInfo);

/*���ݽӿ�*/
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