#include "cham.h"

static inline uint16_t rol16(uint16_t value, size_t rot)
{
	return (value << rot) | (value >> (16 - rot));
}

static inline uint16_t ror16(uint16_t value, size_t rot)
{
	return (value >> rot) | (value << (16 - rot));
}

static inline uint32_t rol32(uint32_t value, size_t rot)
{
	return (value << rot) | (value >> (32 - rot));
}

static inline uint32_t ror32(uint32_t value, size_t rot)
{
	return (value >> rot) | (value << (32 - rot));
}

/**
 * CHAM 64-bit block, 128-bit key
 */ 

void cham64_keygen(uint8_t* rks, const uint8_t* mk)
{
	const uint16_t* key = (uint16_t*) mk;
	uint16_t* rk = (uint16_t*) rks;

	for (size_t i = 0; i < 8; ++i) {
		rk[i] = key[i] ^ rol16(key[i], 1);
		rk[(i+8)^(0x1)] = rk[i] ^ rol16(key[i], 11);
		rk[i] ^= rol16(key[i], 8);
	}
}


void cham64_ctr_encrypt(uint8_t* dst, const uint8_t* src, const uint16_t src_len, const uint8_t* iv, const uint8_t* rks)
{	
	uint8_t iv_counter[8] = {0x00,};
	
	for(int i=2;i<8;i++){
		iv_counter[i] = iv[i-2];
	}
	
	for(int i=0; i<src_len;i++){
		cham64_encrypt((dst+8*i),iv_counter,rks);
		
		for(int j=0; j<8; j++){
			dst[i*8+j] ^= src[i*8+j];
		}
		iv_counter[0]++;
		if(iv_counter[0] == 0){
			iv_counter[1]++;
		}
	}
}

/**
 * CHAM 128-bit block, 128-bit key
 */ 

void cham128_keygen(uint8_t* rks, const uint8_t* mk)
{
	const uint32_t* key = (uint32_t*) mk;
	uint32_t* rk = (uint32_t*) rks;

	for (size_t i = 0; i < 4; ++i) {
		rk[i] = key[i] ^ rol32(key[i], 1);
		rk[(i+4)^(0x1)] = rk[i] ^ rol32(key[i], 11);
		rk[i] ^= rol32(key[i], 8);
	}
}
								//pt ct 2 iv rk 복
								//ct pt 2 iv rk 암
void cham128_ctr_encrypt(uint8_t* dst, const uint8_t* src, const uint16_t src_len, const uint8_t* iv, const uint8_t* rks)
{	
	uint8_t iv_counter[16] = {0x00,};
	
	for(int i=2;i<16;i++){
		iv_counter[i] = iv[i-2];
	}
	
	for(int i=0; i<src_len;i++){
		cham128_encrypt((dst+16*i),iv_counter,rks);
		
		for(int j=0; j<16; j++){
			dst[i*16+j] ^= src[i*16+j];
		}		
		iv_counter[0]++;
		if(iv_counter[0] == 0){
			iv_counter[1]++;
		}
	}
}

/**
 * CHAM 128-bit block, 256-bit key
 */ 
void cham256_keygen(uint8_t* rks, const uint8_t* mk)
{
	const uint32_t* key = (uint32_t*) mk;
	uint32_t* rk = (uint32_t*) rks;

	for (size_t i = 0; i < 8; ++i) {
		rk[i] = key[i] ^ rol32(key[i], 1);
		rk[(i+8)^(0x1)] = rk[i] ^ rol32(key[i], 11);
		rk[i] ^= rol32(key[i], 8);
	}
}

void cham256_ctr_encrypt(uint8_t* dst, const uint8_t* src, const uint16_t src_len, const uint8_t* iv, const uint8_t* rks)
{
	uint8_t iv_counter[16] = {0x00,};
	
	for(int i=2;i<16;i++){
		iv_counter[i] = iv[i-2];
	}
	
	for(int i=0; i<src_len;i++){
		cham256_encrypt((dst+16*i),iv_counter,rks);
		
		for(int j=0; j<16; j++){
			dst[i*16+j] ^= src[i*16+j];
		}
		iv_counter[0]++;
		if(iv_counter[0] == 0){
			iv_counter[1]++;
		}
	}
	
}


