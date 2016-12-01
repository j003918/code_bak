#include "xxtea.h"

#define MX  ( (((z>>5)^(y<<2))+((y>>3)^(z<<4)))^((sum^y)+(key[(p&3)^e]^z)) )
long btea(long* v, long length, long* key)
{
    unsigned long z /* = v[length-1] */, y=v[0], sum=0, e, DELTA=0x9e3779b9;
    long p, q ;
    if(length > 1)							/* Coding Part */
    {          
    		z=v[length-1];           /* Moved z=v[length-1] to here, else segmentation fault in decode when length < 0 */
      	q = 6 + 52/length;
      	while (q-- > 0)
      	{
        		sum += DELTA;
        		e = (sum >> 2) & 3;
        		for (p=0; p<length-1; p++) y = v[p+1], z = v[p] += MX;
        		y = v[0];
        		z = v[length-1] += MX;
      	}
      	return 0 ; 
    }
    else if (length < -1)				/* Decoding Part */
    {  
      	length = -length;
      	q = 6 + 52/length;
      	sum = q*DELTA ;
      	while (sum != 0)
      	{
        		e = (sum >> 2) & 3;
        		for (p=length-1; p>0; p--) z = v[p-1], y = v[p] -= MX;
        		z = v[length-1];
        		y = v[0] -= MX;
        		sum -= DELTA;
      	}
      	return 0;
    }
    return 1;
}

//0×9e3779b9总要与我们形影不离，即使到了这里，它还要出现！！！
//瞧，它又来了,那个0×9e3779b9就是总在我们生活中出现的黄金分割！！！

//Tiny Encryption Algorithm
//标准32轮TEA，它是存在攻击的。建议使用TEA的升级版本XXTEA
//注意，v是64bit,k是128bit，切勿用错。
void tea_encrypt(unsigned long* v, unsigned long* k)
{
		unsigned long v0=v[0],v1=v[1],sum=0,i;
		unsigned long delta=0x9e3779b9;
    unsigned long k0=k[0], k1=k[1], k2=k[2], k3=k[3];
		for (i=0; i < 32; i++)
    {
    		sum += delta;
				v0 += ((v1<<4) + k0) ^ (v1 + sum) ^ ((v1>>5) + k1);
				v1 += ((v0<<4) + k2) ^ (v0 + sum) ^ ((v0>>5) + k3);
		}
		v[0]=v0; v[1]=v1;
}
 
void tea_decrypt(unsigned long* v, unsigned long* k)
{
		unsigned long v0=v[0], v1=v[1], sum=0xC6EF3720, i;
		unsigned long delta=0x9e3779b9;
		unsigned long k0=k[0], k1=k[1], k2=k[2], k3=k[3];
		for(i=0; i<32; i++) 
		{
				v1 -= ((v0<<4) + k2) ^ (v0 + sum) ^ ((v0>>5) + k3);
				v0 -= ((v1<<4) + k0) ^ (v1 + sum) ^ ((v1>>5) + k1);
				sum -= delta;
		}
		v[0]=v0; v[1]=v1;
}
