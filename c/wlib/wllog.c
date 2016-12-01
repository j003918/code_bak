/*******************************************************************************
    文件名称 : wllog.cpp 实现文件
    作    者 : NO/Name
    创建时间 : 2010-9-13  13:05:55
    文件描述 : 
    版权声明 : Copyright (C) 2008-2010 华为技术有限公司(Huawei Tech.Co.,Ltd)
    修改历史 : xxxxxx/xxx 2010-9-13    1.00    初始版本
*******************************************************************************/
#include "wllog.h"

#pragma warning (disable:4100)

#define WL_LOG_FILE_OPEN_MODE "wb"
#define WL_LOG_DEFAULT_NAME "wlnet.log"

static FILE *g_logfd = NULL;
static wl_mutex_t g_mutex;

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_log_init( char *path, char *name )
{
    char szFilePath[WL_MAX_LOG_PATH_LEN+1]={0};
    unsigned long rst = 0;

    if ( NULL != g_logfd)
    {
        return 0;
    }

    if ( NULL == path)
    {
#if defined(WIN32) || defined(_WIN32)
        rst = GetModuleFileName(NULL, szFilePath, WL_MAX_LOG_PATH_LEN);
        while (rst-- > 0)
        {
            if (szFilePath[rst] == '\\' || szFilePath[rst] == '/' )
            {
                szFilePath[rst+1] = 0;
                break;
            }
        }
#endif
    }
    else
    {
        strcat(szFilePath,path);
    }

    if ( NULL == name )
    {
        strcat(szFilePath,WL_LOG_DEFAULT_NAME);
    }
    else
    {
        strcat(szFilePath,name);
    }
    

    g_logfd = fopen(szFilePath,WL_LOG_FILE_OPEN_MODE);
    if ( NULL == g_logfd)
    {
        return -1;
    }

    (void)setbuf(g_logfd,NULL);
    (void)wl_init_mutex(&g_mutex);

    return 0;
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API void wl_log_release( void )
{
    if ( NULL == g_logfd )
    {
        return ;
    }

    fclose(g_logfd);
    g_logfd = NULL;
    wl_release_mutex(&g_mutex);
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
/*
void wl_log_write(const int loglevel, const wlchar_t *format,...)
{
    va_list arglist;
    SYSTEMTIME logtime;
    if ( NULL == g_logfd )
    {
        return;
    }
#if !defined(_DEBUG)
    if ( WL_LOG_LEVEL_DEBUG == loglevel )
    {
        return;
    }
#endif
    (void)wl_lock(&g_mutex);
    GetLocalTime(&logtime);
    (void)wlfprintf(g_logfd,T("\r\n[%d-%02d-%02d %02d:%02d:%02d_%03d %u/%u]:\r\n"),
        logtime.wYear, logtime.wMonth, logtime.wDay, logtime.wHour, 
        logtime.wMinute, logtime.wSecond, logtime.wMilliseconds,
        WL_THREADID,WL_PROCESSID);            

    va_start(arglist, format);
    (void)wlfprintf(g_logfd, format, arglist);
    va_end(arglist);
    (void)wl_unlock(&g_mutex);
}
*/
/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API void wl_log_write_ansi( const int loglevel, const char *format,...)
{
    va_list arglist;
    SYSTEMTIME logtime;
    if ( NULL == g_logfd )
    {
        return;
    }
#if !defined(_DEBUG)
    if ( WL_LOG_LEVEL_DEBUG == loglevel )
    {
        return;
    }
#endif
    (void)wl_lock(&g_mutex);
    GetLocalTime(&logtime);
    (void)fprintf(g_logfd,"\r\n[%d-%02d-%02d %02d:%02d:%02d_%03d %u/%u]:\r\n",
        logtime.wYear, logtime.wMonth, logtime.wDay, logtime.wHour, 
        logtime.wMinute, logtime.wSecond, logtime.wMilliseconds,
        WL_THREADID,WL_PROCESSID);            

    va_start(arglist, format);
    (void)vfprintf(g_logfd, format, arglist);
    va_end(arglist);
    (void)wl_unlock(&g_mutex);
}


/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
/*
WL_API void wl_log_write_unicode(const int loglevel, const wchar_t *format,...)
{
    va_list arglist;
    SYSTEMTIME logtime;
    if ( NULL == g_logfd )
    {
        return;
    }
#if !defined(_DEBUG)
    if ( WL_LOG_LEVEL_DEBUG == loglevel )
    {
        return;
    }
#endif
    (void)wl_lock(&g_mutex);
    GetLocalTime(&logtime);

    (void)fwprintf(g_logfd, T("\r\n[%d-%02d-%02d %02d:%02d:%02d_%03d %u/%u]:\r\n"),
        logtime.wYear, logtime.wMonth, logtime.wDay, logtime.wHour, 
        logtime.wMinute, logtime.wSecond, logtime.wMilliseconds,
        WL_THREADID,WL_PROCESSID);        

    va_start(arglist, format);
    (void)vfwprintf(g_logfd, format, arglist);
    va_end(arglist);
    (void)wl_unlock(&g_mutex);
}
*/

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API void wl_log_write_bin( const int loglevel, const char *buf,const int len )
{
    SYSTEMTIME logtime;
    int i = 0;
    char tmpbuf[10];
#if defined(_DEBUG)
    if ( WL_LOG_LEVEL_DEBUG == loglevel )
    {
        return;
    }

    if ( NULL == g_logfd )
    {
        return;
    }

#endif
    memset(tmpbuf,0,10);
    (void)wl_lock(&g_mutex);
    GetLocalTime(&logtime);
    (void)fprintf(g_logfd, "\r\n[%d-%02d-%02d %02d:%02d:%02d_%03d %u/%u]:\r\n",
        logtime.wYear, logtime.wMonth, logtime.wDay, logtime.wHour, 
        logtime.wMinute, logtime.wSecond, logtime.wMilliseconds,
        WL_THREADID,WL_PROCESSID);            

    for(i=0;i<len;i++)
    {
        sprintf(tmpbuf,"0x%02X ",*buf++);
        fputs(tmpbuf,g_logfd);

        if ( 0 == (i+1)%16 )
        {
            fputs("\r\n",g_logfd);
            continue;
        }

        if( 0 == (i+1)%8 )
        {
            fputs(" ",g_logfd);
        }
    }

    (void)wl_unlock(&g_mutex);
}

