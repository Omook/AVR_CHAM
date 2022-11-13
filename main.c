#include <avr/io.h>
/*
 * CHAM_optimization
 *
 * Created: 2022-08-31
 * Author : kookmin university - DongHyun Shin
 */ 

/*
cham64 testvector
pt : 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77
rk : 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 
     0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
ct : 0x79, 0x65, 0x04, 0x12, 0x3f, 0x12, 0xa9, 0xe5 
*/

/*
cham128 testvector
pt : 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 
     0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff
rk : 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 
     0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f	 
ct : 0xee, 0x19, 0x54, 0xd0, 0x4c, 0x8f, 0x11, 0x9f, 
     0x69, 0x64, 0xe3, 0x99, 0xc1, 0x5e, 0x88, 0x1c
*/

/*
cham 256 testvector
pt : 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 
     0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff
rk : 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 
     0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
     0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xF5, 0xf6, 0xf7, 
	 0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff	 
ct : 0xdc, 0x77, 0x73, 0x02, 0x51, 0x56, 0x0b, 0x12, 
     0x95, 0x9b, 0x83, 0x8f, 0x75, 0xc0, 0x5e, 0x5e
};*/





/*ctr_mode block_len*/
#define CTR_len		2

void test_cham64(){
	uint8_t pt[8] ={0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77};
	uint8_t pt2[8] ={0x00,};
	uint8_t ct[8] ={0x00,};
	uint8_t mk[16] ={
		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 
		0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f};
	//uint8_t rk[32] ={
		//0x01, 0x03, 0x05, 0x07, 0x09, 0x0b, 0x0d, 0x0f, 
		//0x11, 0x13, 0x15, 0x17, 0x19, 0x1b, 0x1d, 0x1f, 
		//0x1e, 0x15, 0x08, 0x03, 0x32, 0x39, 0x24, 0x2f, 
		//0x46, 0x4d, 0x50, 0x5b, 0x6a, 0x61,0x7c, 0x77};
	uint8_t rk[32] ={0x00,};
	
	/* key schedule */
	
	cham64_keygen(rk,mk); 
	
	/* 1-block encrypt/decrypt */	
	
	cham64_encrypt(ct,pt,rk);
	cham64_decrypt(pt2,ct,rk);
	
	/* CTR encrypt/decrypt */
	
	uint8_t *pt_ctr =(uint8_t*)calloc( CTR_len*8, sizeof(uint8_t));
	uint8_t *pt_ctr2 =(uint8_t*)calloc( CTR_len*8, sizeof(uint8_t));
	//ctr mode test pt
	pt_ctr[0] = 1;
	pt_ctr[8] = 2;
	uint8_t *ct_ctr =(uint8_t*)calloc(CTR_len*8, sizeof(uint8_t));
	uint8_t iv[6]= {0x00,};	// 2-byte를 counter로 사용한다. 8-> iv : 6, counter : 2
	cham64_ctr_encrypt(ct_ctr, pt_ctr, CTR_len, iv, rk);
	cham64_ctr_encrypt(pt_ctr2, ct_ctr, CTR_len, iv, rk);
}
void test_cham128(){
	uint8_t pt[16] ={
	0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff};
	uint8_t pt2[16] ={0x00,};
	uint8_t ct[16] ={0x00,};
	uint8_t mk[16] ={
		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 
		0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f};
	//uint8_t rk[32] ={
		//0x03, 0x03, 0x07, 0x07, 0x0b, 0x0b, 0x0f, 0x0f, 
		//0x13, 0x13, 0x17, 0x17, 0x1b, 0x1b, 0x1f, 0x1f, 
		//0x34, 0x2f, 0x22, 0x39, 0x18, 0x03, 0x0e, 0x15, 
		//0x6c, 0x77, 0x7a, 0x61, 0x40, 0x5b, 0x56, 0x4d};
	uint8_t rk[32] ={0x00,};
		
	/* key schedule */
	
	cham128_keygen(rk,mk); 
	
	/* 1-block encrypt/decrypt */
	
	cham128_encrypt(ct,pt,rk);
	cham128_decrypt(pt2,ct,rk);
	
	/* CTR encrypt/decrypt */
	uint8_t *pt_ctr =(uint8_t*)calloc( CTR_len*16, sizeof(uint8_t));
	uint8_t *pt_ctr2 =(uint8_t*)calloc( CTR_len*16, sizeof(uint8_t));
	//ctr mode test pt
	pt_ctr[0] = 1;
	pt_ctr[16] = 2;
	uint8_t *ct_ctr =(uint8_t*)calloc(CTR_len*16, sizeof(uint8_t));
	uint8_t iv[14]= {0x00,};	// 2-byte를 counter로 사용한다. 16-> iv : 14, counter : 2
		
	cham128_ctr_encrypt(ct_ctr, pt_ctr, CTR_len, iv, rk);
	cham128_ctr_encrypt(pt_ctr2, ct_ctr, CTR_len, iv, rk);
}
void test_cham256(){
		uint8_t pt[16] ={
			0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
		    0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff};
		uint8_t pt2[16] ={0x00,};
		uint8_t ct[16] ={0x00,};
		uint8_t mk[32] ={
			0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 
			0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
			0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xF5, 0xf6, 0xf7, 
			0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff};
		//uint8_t rk[64] ={
			//0x03, 0x03, 0x07, 0x07, 0x0b, 0x0b, 0x0f, 0x0f,
			//0x13, 0x13, 0x17, 0x17, 0x1b, 0x1b, 0x1f, 0x1f,
			//0xe2, 0xe2, 0xe6, 0xe6, 0xea, 0xea, 0xee, 0xee,
			//0xf2, 0xf2, 0xf6, 0xf6, 0xfa, 0xfa, 0xfe, 0xfe,
			//0x34, 0x2f, 0x22, 0x39, 0x18, 0x03, 0x0e, 0x15,
			//0x6c, 0x77, 0x7a, 0x61, 0x40, 0x5b, 0x56, 0x4d,
			//0xa2, 0xb9, 0xb4, 0xaf, 0x8e, 0x95, 0x98, 0x83,
		    //0xfa, 0xe1, 0xec, 0xf7, 0xd6, 0xcd, 0xc0, 0xdb};
		uint8_t rk[64] ={0x00,};
		
	/* key schedule */
	
	cham256_keygen(rk,mk); 
	
	/* 1-block encrypt/decrypt */
	
	cham256_encrypt(ct,pt,rk);
	cham256_decrypt(pt2,ct,rk);
	
	/* CTR encrypt/decrypt */
	
	uint8_t *pt_ctr =(uint8_t*)calloc( CTR_len*16, sizeof(uint8_t));
	uint8_t *pt_ctr2 =(uint8_t*)calloc( CTR_len*16, sizeof(uint8_t));
	//ctr mode test pt
	pt_ctr[0] = 1;
	pt_ctr[16] = 2;
	uint8_t *ct_ctr =(uint8_t*)calloc(CTR_len*16, sizeof(uint8_t));
	uint8_t iv[14]= {0x00,};	// 2-byte를 counter로 사용한다. 16-> iv : 14, counter : 2
		
	cham256_ctr_encrypt(ct_ctr, pt_ctr, CTR_len, iv, rk);
	cham256_ctr_encrypt(pt_ctr2, ct_ctr, CTR_len, iv, rk);
	
}
int main(void)
{
	
	test_cham64();
	test_cham128();
	test_cham256();
	
}

