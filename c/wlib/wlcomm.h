/*******************************************************************************
    文件名称 : wlcomm.h 头文件
    作    者 : NO/Name
    创建时间 : 2010-9-13  12:58:26
    文件描述 : 
    版权声明 : Copyright (C) 2008-2010 华为技术有限公司(Huawei Tech.Co.,Ltd)
    修改历史 : xxxxxx/xxx 2010-9-13    1.00    初始版本
*******************************************************************************/
#ifndef WLCOMM_H_INCLUDED
#define WLCOMM_H_INCLUDED


#include <stdio.h>
#include <stdlib.h>
#include <wchar.h>
#include <string.h>
#include <memory.h>

/************************************************************************/
/* cpp                                                                  */
/************************************************************************/
#if defined(__cplusplus) || defined(c_plusplus)
#define WL_CPLUSPLUS_BEGIN extern "C" {
#define WL_CPLUSPLUS_END }
#else
#define WL_CPLUSPLUS_BEGIN
#define WL_CPLUSPLUS_END
#endif

/************************************************************************/
/* dll export                                                           */
/************************************************************************/
#if !defined(WL_WITHSSL)
#   define WL_WITHSSL
#endif

#if defined(_WIN32) || defined(WIN32)
#   define WL_API __declspec(dllexport)
#   define WL_INLINE __inline
#else
#   define WL_API 
#   define WL_INLINE inline   
#endif

/*
#if defined(_WIN32) || defined(WIN32)
#define vsnprinf _vsnprintf
#endif

#if defined(UNICODE) || defined(_UNICODE)
#   define wlfprintf fwprintf
#   define wlvfprintf vfwprintf
#else
#   define wlfprintf fprintf
#   define wlvfprintf vfprintf
#endif


#if defined(_UNICODE) || defined(UNICODE)
typedef wchar_t  wlchar_t;
#   define T(str)    L##str
#   define wlfopen _wfopen
#   define wlsprintf wsprintf
#   define wlstrcat  wcscat
#   define wlmemset  wmemset
#else
typedef char  wlchar_t;
#   define T(str)    str  
#   define wlfopen fopen 
#   define wlsprintf sprintf
#   define wlstrcat  strcat
#   define wlmemset  memset
#endif
*/
/************************************************************************/
/* bit op                                                               */
/************************************************************************/
#define WL_BIT_POS(index)       ((index)>>3)
#define WL_BIT_OFF(index)       ((index)&0x07)
#define WL_BIT_VAL(ptr,index)   (*((unsigned char *)(ptr) + WL_BIT_POS(index)))
#define WL_GETBIT(ptr,index)    ((WL_BIT_VAL(ptr,index) >> WL_BIT_OFF(index))&(0x01))
#define WL_SETBIT(ptr,index)    (WL_BIT_VAL(ptr,index)  |= 0x01<<WL_BIT_OFF(index))
#define WL_CLRBIT(ptr,index)    (WL_BIT_VAL(ptr,index)  &= ~(0x01<<WL_BIT_OFF(index)))

/************************************************************************/
/* HEX INT                                                              */
/************************************************************************/
#define WL_INT2HEX(n)           (( (n) >= 0  && (n) <= 9  ) ? ((char)( (n)+0x30 )): \
                                ( (n) >= 10 && (n) <= 15 ) ? ((char)( (n)+'A'-10 )): ((char)(n)))  

#define WL_HEX2INT(c)           (( (c) >= '0' && (c)<= '9' )?((int)( (c)-0x30 )):   \
                                ( (c) >= 'A' && (c)<= 'F' )?((int)( (c)-'A'+10 )): \
                                ( (c) == 'a' && (c)<= 'f' )?((int)( (c)-'a'+10 )): ((int)(c)))

/************************************************************************/
/* char case                                                            */
/************************************************************************/
#define WL_TOUPPER(c)           (( (c) >= 'a' && (c) <= 'z' )? ((c)-0x20) : (c))
#define WL_TOLOWER(c)           (( (c) >= 'A' && (c) <= 'Z' )? ((c)+0x20) : (c))

#define WL_SWAP(x,y)            ((x)=(x)^(y);(y)=(x)^(y);(x)=(x)^(y));
#define WL_MAX(x,y)             ((x) > (y) ? (x) : (y))
#define WL_MIN(x,y)             ((x) < (y) ? (x) : (y))

#define WL_FREE(P) if (NULL!=P){free(P);P=NULL;}

#endif /*WLCOMM_H_INCLUDED*/
