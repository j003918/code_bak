/*******************************************************************************
    �ļ����� : wllog.h ͷ�ļ�
    ��    �� : NO/Name
    ����ʱ�� : 2010-9-13  12:50:55
    �ļ����� : 
    ��Ȩ���� : Copyright (C) 2008-2010 ��Ϊ�������޹�˾(Huawei Tech.Co.,Ltd)
    �޸���ʷ : xxxxxx/xxx 2010-9-13    1.00    ��ʼ�汾
*******************************************************************************/
#ifndef WLLOG_H_INCLUDED
#define WLLOG_H_INCLUDED

#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include "wlthread.h"

WL_CPLUSPLUS_BEGIN

#define  WL_MAX_LOG_PATH_LEN 1024

enum wl_en_loglevel
{
    WL_LOG_LEVEL_FATAL = 0x00,
    WL_LOG_LEVEL_ERROR,
    WL_LOG_LEVEL_WARNING,
    WL_LOG_LEVEL_INFO,
    WL_LOG_LEVEL_DEBUG
};


/*******************************************************************************
    ��������  : xxx
    ��������  : xxx
    �������  : N/A
    �������  : N/A
    ����ֵ    : void
    ��ע      : N/A
*******************************************************************************/
WL_API int wl_log_init(char *path, char *name);

/*******************************************************************************
    ��������  : xxx
    ��������  : xxx
    �������  : N/A
    �������  : N/A
    ����ֵ    : void
    ��ע      : N/A
*******************************************************************************/
WL_API void wl_log_release(void);

/*******************************************************************************
    ��������  : xxx
    ��������  : xxx
    �������  : N/A
    �������  : N/A
    ����ֵ    : void
    ��ע      : N/A
*******************************************************************************/
/*WL_API void wl_log_write(const int loglevel, const wlchar_t *format,...);*/

/*******************************************************************************
    ��������  : xxx
    ��������  : xxx
    �������  : N/A
    �������  : N/A
    ����ֵ    : void
    ��ע      : N/A
*******************************************************************************/
WL_API void wl_log_write_ansi(const int loglevel, const char *format,...);

/*******************************************************************************
    ��������  : xxx
    ��������  : xxx
    �������  : N/A
    �������  : N/A
    ����ֵ    : void
    ��ע      : N/A
*******************************************************************************/
/*WL_API void wl_log_write_unicode(const int loglevel, const wchar_t *format,...);*/

/*******************************************************************************
    ��������  : xxx
    ��������  : xxx
    �������  : N/A
    �������  : N/A
    ����ֵ    : void
    ��ע      : N/A
*******************************************************************************/
WL_API void wl_log_write_bin(const int loglevel, const char *buf,const int len);

/*#define WL_LOG_STR_TEACE wl_log_write*/
#define WL_LOG_ANSI_TEACE wl_log_write_ansi
/*#define WL_LOG_UNICODE_TEACE wl_log_write_ansi*/
#define WL_LOG_BIN_TEACE wl_log_write_bin


WL_CPLUSPLUS_END

#endif
