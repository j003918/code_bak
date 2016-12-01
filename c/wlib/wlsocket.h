/*******************************************************************************
    文件名称 : wlsocket.h 头文件
    作    者 : NO/Name
    创建时间 : 2010-9-13  12:42:01
    文件描述 : 
    版权声明 : Copyright (C) 2008-2010 华为技术有限公司(Huawei Tech.Co.,Ltd)
    修改历史 : xxxxxx/xxx 2010-9-13    1.00    初始版本
*******************************************************************************/
#ifndef WLSOCKET_H_INCLUDED
#define WLSOCKET_H_INCLUDED


#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <time.h>


#if defined(_WIN32) || defined(WIN32)
#include <winsock2.h>
#include <windows.h>
#else
#include <unistd.h>
#include <fcntl.h>
#include <netdb.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#endif

#include "wlcomm.h"

#include "wllog.h"

#if defined(_WIN32) || defined(WIN32)
typedef SOCKET wl_socket_t;
typedef unsigned long wl_ip_t;
typedef unsigned short wl_port_t;
#define wl_close closesocket
#define WL_SOCKET_ERROR SOCKET_ERROR
#define WL_NVALID_SOCKET INVALID_SOCKET
#else
typedef int wl_socket_t;
typedef unsigned long wl_ip_t;
typedef unsigned short wl_port_t;
#define wl_close close
#define WL_SOCKET_ERROR -1
#define WL_NVALID_SOCKET -1
#endif

#define WL_MAX_ETH_MTU 1460

WL_CPLUSPLUS_BEGIN


/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_net_init(void);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API void wl_net_free(void);


/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_get_sol_error(wl_socket_t fd);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_set_sol_broadcast(wl_socket_t fd, int opt);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_set_sol_reuseaddr(wl_socket_t fd, int opt);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_set_sol_keepalive(wl_socket_t fd, int val, long sec, int repeat);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_set_sol_sendtimeout(wl_socket_t fd, int opt);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_set_sol_recvtimeout(wl_socket_t fd, int opt);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_set_sol_sendbuf(wl_socket_t fd, int opt);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_set_sol_recvbuf(wl_socket_t fd, int opt);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_set_nonblocking(wl_socket_t fd, int opt);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API wl_ip_t wl_gethostbyname(const char *host);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API wl_socket_t wl_socket(int type);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_conn(wl_socket_t fd, wl_ip_t ip, wl_port_t port);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_conn_timeout(wl_socket_t fd, wl_ip_t ip, wl_port_t port, long timeout);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_send(wl_socket_t fd, char *buf, int len);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_sendto(wl_socket_t fd, wl_ip_t ip, wl_port_t port, char *buf, int len);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_recv(wl_socket_t fd, char *buf, int len);

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_recvfrom(wl_socket_t fd, char *Buf, int len,wl_ip_t *ip, wl_port_t *port);

#define WL_FD_STATUS_READABLE  0x01
#define WL_FD_STATUS_WRITEABLE 0x02
#define WL_FD_STATUS_EXCEPTION 0x04

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
WL_API int wl_peek_state(wl_socket_t fd, char check_read, char check_write, char check_exception, long sec, long usec);

WL_CPLUSPLUS_END

#endif /*WLSOCKET_H_INCLUDED*/


