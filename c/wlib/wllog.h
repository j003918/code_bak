/*******************************************************************************
    文件名称 : wllog.h 头文件
    作    者 : NO/Name
    创建时间 : 2010-9-13  12:50:55
    文件描述 : 
    版权声明 : Copyright (C) 2008-2010 华为技术有限公司(Huawei Tech.Co.,Ltd)
    修改历史 : xxxxxx/xxx 2010-9-13    1.00    初始版本
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
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_log_init(char *path, char *name);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API void wl_log_release(void);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
/*WL_API void wl_log_write(const int loglevel, const wlchar_t *format,...);*/

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API void wl_log_write_ansi(const int loglevel, const char *format,...);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
/*WL_API void wl_log_write_unicode(const int loglevel, const wchar_t *format,...);*/

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API void wl_log_write_bin(const int loglevel, const char *buf,const int len);

/*#define WL_LOG_STR_TEACE wl_log_write*/
#define WL_LOG_ANSI_TEACE wl_log_write_ansi
/*#define WL_LOG_UNICODE_TEACE wl_log_write_ansi*/
#define WL_LOG_BIN_TEACE wl_log_write_bin


WL_CPLUSPLUS_END

#endif
