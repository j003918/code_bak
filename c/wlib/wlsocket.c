/*******************************************************************************
    文件名称 : wlsocket.cpp 实现文件
    作    者 : NO/Name
    创建时间 : 2010-9-13  13:02:46
    文件描述 : 
    版权声明 : Copyright (C) 2008-2010 华为技术有限公司(Huawei Tech.Co.,Ltd)
    修改历史 : xxxxxx/xxx 2010-9-13    1.00    初始版本
*******************************************************************************/
#include<string.h>
#include "wlsocket.h"
#include "wlthread.h"

#pragma warning (disable:4127)
#pragma warning (disable:4100)


/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_get_sol_error(wl_socket_t fd)
{
    int val = 0;
    int len = sizeof(val);

    return (getsockopt(fd, SOL_SOCKET, SO_ERROR, (char *)&val, &len) == -1) ? -1:val;
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_set_sol_broadcast(wl_socket_t fd, int val)
{
    int optval = val;
	return setsockopt(fd, SOL_SOCKET, SO_BROADCAST, (char *)&optval, sizeof(optval));
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_set_sol_reuseaddr(wl_socket_t fd, int val)
{
    int optval = val;
	return setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, (char *)&optval, sizeof(optval));
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_set_sol_sendtimeout(wl_socket_t fd, int opt)
{
    struct timeval tm;
    tm.tv_sec = opt;
    tm.tv_usec = 0;

    return setsockopt(fd,SOL_SOCKET,SO_SNDTIMEO,(const char *)&tm,sizeof(tm));
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_set_sol_recvtimeout(wl_socket_t fd, int opt)
{
    struct timeval tm;
    tm.tv_sec = opt;
    tm.tv_usec = 0;

    return setsockopt(fd,SOL_SOCKET,SO_RCVTIMEO,(const char *)&tm,sizeof(tm));
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_set_sol_sendbuf(wl_socket_t fd, int val)
{
    int bufsize = val;
    return setsockopt(fd,SOL_SOCKET,SO_SNDBUF,(char *)&bufsize,sizeof(bufsize));
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_set_sol_recvbuf(wl_socket_t fd, int val)
{
    int bufsize = val;
    return setsockopt(fd,SOL_SOCKET,SO_RCVBUF,(char *)&bufsize,sizeof(bufsize));
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_set_nonblocking(wl_socket_t fd, int val)
{
#if defined(_WIN32) || defined(WIN32)
    unsigned long l = val;
    return ioctlsocket(fd, (long)FIONBIO, &l);
#else
    if (val)
    {
        return fcntl(fd, F_SETFL, O_NONBLOCK);
    }
    else
    {
        return fcntl(fd, F_SETFL, 0);
    }
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
wl_ip_t wl_gethostbyname(const char *host)
{
    wl_ip_t ip = 0;
    struct hostent *hostinfo;
    hostinfo = gethostbyname(host);
    if (NULL == hostinfo)
    {
        return 0;
    }
    ip = *((wl_ip_t *)hostinfo->h_addr_list[0]);

    return ip;
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
static int g_safeinit = 0;
int wl_net_init(void)
{
#if defined(_WIN32) || defined(WIN32)
    WSADATA wsadata;
#endif
    
    if ( g_safeinit )
    {
        return 0;
    }

    g_safeinit = 1;

#if defined(_WIN32) || defined(WIN32)
    if (WSAStartup(0x0201,&wsadata)) 
    {
        return -1;
    }
#endif 

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
void wl_net_free(void)
{
#if defined(_WIN32) || defined(WIN32)
    if ( !g_safeinit )
    {
        return ;
    }
    (void)WSACleanup();
    g_safeinit = 0;
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
wl_socket_t wl_socket(int type)
{
    return socket(AF_INET,type,0);
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_conn(wl_socket_t fd, wl_ip_t ip, wl_port_t port)
{
    struct sockaddr_in raddr;
    memset(&raddr,0,sizeof(struct sockaddr_in));
    raddr.sin_family        = AF_INET;
    raddr.sin_addr.s_addr   = ip;
    raddr.sin_port          = port;

    return connect(fd,(struct sockaddr *)&raddr,sizeof(raddr));
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_conn_timeout(wl_socket_t fd, wl_ip_t ip, wl_port_t port, long timeout)
{
    struct sockaddr_in raddr;
    struct timeval tm;
    int rst = 0;
    struct fd_set wfds;

    memset(&raddr,0,sizeof(struct sockaddr_in));
    raddr.sin_family        = AF_INET;
    raddr.sin_addr.s_addr   = ip;
    raddr.sin_port          = port;

    (void)wl_set_nonblocking(fd,1);
    if( connect(fd, (struct sockaddr *)&raddr, sizeof(struct sockaddr)) == -1)
    {
        tm.tv_sec = timeout;
        tm.tv_usec = 0;
        FD_ZERO(&wfds);
        FD_SET(fd, &wfds);
        if( select((int)fd+1, NULL, &wfds, NULL, &tm) > 0 && 0 == wl_get_sol_error(fd) )
        {
            rst = 0;
        }
        else
        {
            rst = -1;
        }
    }
    (void)wl_set_nonblocking(fd,0);

    return rst;
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_send(wl_socket_t fd, char *buf, int len)
{
    return send(fd,buf,len,0);
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_sendto(wl_socket_t fd, wl_ip_t ip,wl_port_t port,char *buf,int len)
{
    struct sockaddr_in  raddr;
    memset(&raddr,0,sizeof(struct sockaddr_in));
    raddr.sin_family        = AF_INET;
    raddr.sin_addr.s_addr   = ip;
    raddr.sin_port          = port;
    return sendto(fd,buf,len,0,(struct sockaddr *)&raddr,sizeof(raddr));
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_recv(wl_socket_t fd, char *buf, int len)
{
    return recv(fd,buf,len,0);
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_recvfrom(wl_socket_t fd, char *buf, int len, wl_ip_t *ip, wl_port_t *port)
{
    struct sockaddr_in fromaddr;
    int fromlen;
    int ret;

    memset(&fromaddr,0,sizeof(struct sockaddr_in));
    fromlen = sizeof(struct sockaddr_in);
    ret = recvfrom(fd,buf,len,0,(struct sockaddr *)&fromaddr,&fromlen);
    *ip = fromaddr.sin_addr.s_addr;
    *port = fromaddr.sin_port;
    return ret;
}

/*******************************************************************************
    函数名称  : xxx
    函数描述  : xxx
    输入参数  : N/A
    输出参数  : N/A
    返回值    : void
    备注      : N/A
*******************************************************************************/
int wl_peek_state(wl_socket_t fd, char check_read, char check_write, char check_exception, long sec, long usec)
{
    struct timeval tm;
    struct fd_set rfds;
    struct fd_set wfds;
    struct fd_set efds;
    int rst = 0;
    int retval = 0;

    FD_ZERO(&rfds);
    FD_ZERO(&wfds);
    FD_ZERO(&efds);

    if (check_read)
    {
        FD_SET(fd,&rfds);
    }

    if (check_write)
    {
        FD_SET(fd,&wfds);
    }

    if (check_exception)
    {
        FD_SET(fd,&efds);
    }

    tm.tv_sec = sec;
    tm.tv_usec = usec;

    rst = select((int)fd+1, &rfds, &wfds, &efds, &tm);
    if ( rst > 0)
    {
        if ( FD_ISSET(fd,&rfds) )
        {
            retval |= WL_FD_STATUS_READABLE;
        }

        if ( FD_ISSET(fd,&wfds) )
        {
            retval |= WL_FD_STATUS_WRITEABLE;
        }

        if ( FD_ISSET(fd,&efds) )
        {
            retval |= WL_FD_STATUS_EXCEPTION;
        }

        return retval;
    }

    return rst;
}

