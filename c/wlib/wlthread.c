/*******************************************************************************
    �ļ����� : wlthread.cpp ʵ���ļ�
    ��    �� : NO/Name
    ����ʱ�� : 2010-9-13  12:58:38
    �ļ����� : 
    ��Ȩ���� : Copyright (C) 2008-2010 ��Ϊ�������޹�˾(Huawei Tech.Co.,Ltd)
    �޸���ʷ : xxxxxx/xxx 2010-9-13    1.00    ��ʼ�汾
*******************************************************************************/
#include "wlthread.h"
#include <process.h>

/*******************************************************************************
    ��������  : xxx
    ��������  : xxx
    �������  : N/A
    �������  : N/A
    ����ֵ    : void
    ��ע      : N/A
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
    ��������  : xxx
    ��������  : xxx
    �������  : N/A
    �������  : N/A
    ����ֵ    : void
    ��ע      : N/A
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
    ��������  : xxx
    ��������  : xxx
    �������  : N/A
    �������  : N/A
    ����ֵ    : void
    ��ע      : N/A
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
    ��������  : xxx
    ��������  : xxx
    �������  : N/A
    �������  : N/A
    ����ֵ    : void
    ��ע      : N/A
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
    ��������  : xxx
    ��������  : xxx
    �������  : N/A
    �������  : N/A
    ����ֵ    : void
    ��ע      : N/A
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
    ��������  : xxx
    ��������  : xxx
    �������  : N/A
    �������  : N/A
    ����ֵ    : void
    ��ע      : N/A
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
    ��������  : xxx
    ��������  : xxx
    �������  : N/A
    �������  : N/A
    ����ֵ    : void
    ��ע      : N/A
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

