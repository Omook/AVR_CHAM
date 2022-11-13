
#ifndef CHAM_H_
#define CHAM_H_

#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>

void cham64_keygen(uint8_t* rks, const uint8_t* mk);
extern void cham64_encrypt(uint8_t* dst, const uint8_t* src, const uint8_t* rks);
extern void cham64_decrypt(uint8_t* dst, const uint8_t* src, const uint8_t* rks);
void cham64_ctr_encrypt(uint8_t* dst, const uint8_t* src, const uint16_t src_len, const uint8_t* iv, const uint8_t* rks);

void cham128_keygen(uint8_t* rks, const uint8_t* mk);
extern void cham128_encrypt(uint8_t* dst, const uint8_t* src, const uint8_t* rks);
extern void cham128_decrypt(uint8_t* dst, const uint8_t* src, const uint8_t* rks);
void cham128_ctr_encrypt(uint8_t* dst, const uint8_t* src, const uint16_t src_len, const uint8_t* iv, const uint8_t* rks);

void cham256_keygen(uint8_t* rks, const uint8_t* mk);
extern void cham256_encrypt(uint8_t* dst, const uint8_t* src, const uint8_t* rks);
extern void cham256_decrypt(uint8_t* dst, const uint8_t* src, const uint8_t* rks);
void cham256_ctr_encrypt(uint8_t* dst, const uint8_t* src, const uint16_t src_len, const uint8_t* iv, const uint8_t* rks);


#endif /* CHAM_H_ */