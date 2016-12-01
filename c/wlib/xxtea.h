#ifndef XXTEA_H_INCLUDED
#define XXTEA_H_INCLUDED

#if defined(__cplusplus) || defined(c_plusplus)
#define WL_CPLUSPLUS_BEGIN extern "C" {
#define WL_CPLUSPLUS_END }
#else
#define WL_CPLUSPLUS_BEGIN
#define WL_CPLUSPLUS_END
#endif

/*
#if defined(_WIN32) || defined(WIN32)
#   define WL_API __declspec(dllexport)
#   define WL_INLINE __inline
#else
#   define WL_API 
#   define WL_INLINE inline   
#endif
*/

#include <stdio.h>
#include <stdlib.h>

WL_CPLUSPLUS_BEGIN
long btea(long* v, long length, long* key);/*XXTEA*/
void tea_encrypt(unsigned long* v, unsigned long* k);/*TEA*/
void tea_decrypt(unsigned long* v, unsigned long* k);/*TEA*/
WL_CPLUSPLUS_END


#endif
