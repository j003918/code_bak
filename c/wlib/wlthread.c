/*******************************************************************************
    文件名称 : wlthread.cpp 实现文件
    作    者 : NO/Name
    创建时间 : 2010-9-13  12:58:38
    文件描述 : 
    版权声明 : Copyright (C) 2008-2010 华为技术有限公司(Huawei Tech.Co.,Ltd)
    修改历史 : xxxxxx/xxx 2010-9-13    1.00    初始版本
*******************************************************************************/
#include "wlthread.h"
#include <process.h>

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
wl_thread_handle_t wl_createthread(wl_pfthread_t pfthread, wl_threadparam_t param)
{
    wl_thread_handle_t hdl = (wl_thread_handle_t)WL_INVALID_THREAD_HANDLE;
#if defined(_WIN32) || defined(WIN32)
    unsigned thdid;
    if(NULL == (wl_thread_handle_t)_beginthreadex(NULL, 0, pfthread, param, 0, &thdid))
    {
        return (wl_thread_handle_t)WL_INVALID_THREAD_HANDLE;
    }
#else
    pthread_attr_t attr;
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr,PTHREAD_CREATE_DETACHED);
    if (pthread_create(&hdl,&attr,pfthread,param) == WL_INVALID_THREAD_HANDLE)
    {
        pthread_attr_destroy(&attr);
        return (wl_thread_handle_t)WL_INVALID_THREAD_HANDLE;
    }
    pthread_attr_destroy(&attr);
#endif
    return hdl;
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_closethread(wl_thread_handle_t hdl)
{
#if defined(_WIN32) || defined(WIN32)
    unsigned long rst = 0;
    rst = WaitForSingleObject(hdl,0xFFFFFFFF);
    (void)CloseHandle(hdl);
#else
    int rst;
    void *thread_result;
    rst = pthread_join(hdl, &thread_result); 
#endif
    return (int)rst;
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
void wl_sleep(unsigned long msec)
{
#if defined(_WIN32) || defined(WIN32)
    Sleep(msec);
#else
    struct timeval tm;
    tm.tv_sec = 0;
    tm.tv_usec = msec*1000;
    select(0,NULL,NULL,NULL,&tm);
#endif
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_init_mutex(wl_mutex_t *mutex)
{
#if defined(_WIN32) || defined(WIN32)
    InitializeCriticalSection(mutex);
    return 0;
#else
    return pthread_mutex_init(mutex,NULL);
#endif
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_release_mutex( wl_mutex_t *mutex )
{
#if defined(_WIN32) || defined(WIN32)
    DeleteCriticalSection(mutex);
    return 0;
#else
    return pthread_mutex_destroy(mutex);
#endif
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_lock( wl_mutex_t *mutex )
{
#if defined(_WIN32) || defined(WIN32)
    EnterCriticalSection(mutex);
    return 0;
#else
    return pthread_mutex_lock(mutex);
#endif
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_unlock( wl_mutex_t *mutex )
{
#ifdef _WIN32
    LeaveCriticalSection(mutex);
    return 0;
#else
    return pthread_mutex_unlock(mutex);
#endif
}

