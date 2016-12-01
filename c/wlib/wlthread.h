/*******************************************************************************
    文件名称 : wlthread.h 头文件
    作    者 : NO/Name
    创建时间 : 2010-9-13  12:40:58
    文件描述 : 
    版权声明 : Copyright (C) 2008-2010 华为技术有限公司(Huawei Tech.Co.,Ltd)
    修改历史 : xxxxxx/xxx 2010-9-13    1.00    初始版本
*******************************************************************************/
#ifndef WLTHREAD_H_INCLUDED
#define WLTHREAD_H_INCLUDED

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#if defined(_WIN32) || defined(WIN32)
#include <Windows.h>
#include <process.h>
#else
#include <unistd.h>
#include <pthread.h>
#include <sys/time.h>
#endif

#include "wlcomm.h"

WL_CPLUSPLUS_BEGIN

#if defined(_WIN32) || defined(WIN32)
    typedef HANDLE wl_thread_handle_t;
    typedef unsigned wl_threadfunc_t;
    typedef void * wl_threadparam_t;
#   define WL_STDPREFIX __stdcall
#define WL_THREAD_EXIT _endthreadex(0)
#else
    typedef pthread_t wl_thread_handle_t;
    typedef void * wl_threadfunc_t;
    typedef void * wl_threadparam_t;
#   define WL_STDPREFIX
#   define WL_THREAD_EXIT pthread_exit(NULL)
#endif


#if defined(_WIN32) || defined(WIN32)
    typedef CRITICAL_SECTION wl_mutex_t;
#   define WL_PROCESSID GetCurrentProcessId()
#   define WL_THREADID GetCurrentThreadId()
#else
    typedef pthread_mutex_t wl_mutex_t;
#   define WL_PROCESSID getpid()
#   define WL_THREADID pthread_self()
#endif


#define WL_INVALID_THREAD_HANDLE 0

typedef wl_threadfunc_t (WL_STDPREFIX *wl_pfthread_t)(wl_threadparam_t);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API wl_thread_handle_t wl_createthread(wl_pfthread_t pfthread, wl_threadparam_t param);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_closethread(wl_thread_handle_t hdl);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API void wl_sleep(unsigned long msec);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_init_mutex(wl_mutex_t *mutex);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_release_mutex(wl_mutex_t *mutex);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_lock(wl_mutex_t *mutex);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_unlock(wl_mutex_t *mutex);


WL_CPLUSPLUS_END

#endif /* WLTHREAD_H_INCLUDED*/

