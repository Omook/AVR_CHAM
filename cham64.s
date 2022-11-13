

.global cham64_encrypt
.type cham64_encrypt, @function

#define RK0_0 R0
#define RK0_1 R2
#define RK1_0 R3
#define RK1_1 R4
#define RK2_0 R5
#define RK2_1 R6
#define RK3_0 R7
#define RK3_1 R8
#define RK4_0 R9
#define RK4_1 R10
#define RK5_0 R11
#define RK5_1 R12
#define RK6_0 R13
#define RK6_1 R14
#define RK7_0 R15
#define RK7_1 R16


#define CNT R17


#define TEMP_0 R26
#define TEMP_1 R27

#define KEY R29

#define X0_0 R18
#define X0_1 R19
#define X1_0 R20
#define X1_1 R21
#define X2_0 R22
#define X2_1 R23
#define X3_0 R24
#define X3_1 R25

cham64_encrypt:

	PUSH R0
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9
	PUSH R10
	PUSH R11
	PUSH R12
	PUSH R13
	PUSH R14
	PUSH R15
	PUSH R16
	PUSH R17
	PUSH R28
	PUSH R29

	PUSH R24
	PUSH R25

	MOVW R26, R22
	MOVW R30, R20

	LD X0_0, X+
	LD X0_1, X+
	LD X1_0, X+
	LD X1_1, X+
	LD X2_0, X+
	LD X2_1, X+
	LD X3_0, X+
	LD X3_1, X+

	LD RK0_0, Z+
	LD RK0_1, Z+
	LD RK1_0, Z+
	LD RK1_1, Z+
	LD RK2_0, Z+
	LD RK2_1, Z+
	LD RK3_0, Z+
	LD RK3_1, Z+
	LD RK4_0, Z+
	LD RK4_1, Z+
	LD RK5_0, Z+
	LD RK5_1, Z+
	LD RK6_0, Z+
	LD RK6_1, Z+
	LD RK7_0, Z+
	LD RK7_1, Z+
	
								
    CLR CNT

						//round0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3	
	MOVW TEMP_0, X1_0	// TEMP = X[1]

	LSL TEMP_0			// TEMP = TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK0_0	//TEMP ^ RK[0]
	EOR TEMP_1, RK0_1

	
	EOR X0_0, CNT		// X[0] ^ i

	ADD X0_0, TEMP_0	// X[0]  + TEMP
	ADC X0_1, TEMP_1

	INC CNT
							
							//round 1	,X0 = X3 << 8 ,X1 = X0, X2 = X1, X3 = X2	
	MOV TEMP_0, X2_1		// TEMP = X[1] << 8
	MOV TEMP_1, X2_0

	EOR TEMP_0, RK1_0		//TEMP ^ RK[1]
	EOR TEMP_1, RK1_1

	EOR X1_0, CNT			// X[0] ^ i

	ADD X1_0, TEMP_0		// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0				// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

					//round2	,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1	
	MOVW TEMP_0, X3_0			//TEMP = X[1]

	LSL TEMP_0			// TEMP = TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK2_0	//TEMP ^ RK[2]
	EOR TEMP_1, RK2_1
	
	EOR X2_0, CNT	// X[0] ^ i

	ADD X2_0, TEMP_0		// X[0]  + TEMP
	ADC X2_1, TEMP_1

	INC CNT

	MOV TEMP_0, X0_0		//round 3	,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	MOV TEMP_1, X0_1		// TEMP = X[1] << 8

	EOR TEMP_0, RK3_0	//TEMP ^ RK[3]
	EOR TEMP_1, RK3_1

	EOR X3_0, CNT	// X[0] ^ i

	ADD X3_0, TEMP_0	// X[0] + TEMP
	ADC X3_1, TEMP_1

	LSL X3_0	// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT


		MOVW TEMP_0, X1_0	//round4	,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
							//TEMP = X[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK4_0		//TEMP ^ RK[4]
	EOR TEMP_1, RK4_1

	
	EOR X0_1, CNT		// X[0] ^ i

	ADD X0_1, TEMP_0	// X[0]  + TEMP
	ADC X0_0, TEMP_1

	INC CNT

	MOV TEMP_0, X2_0		//round 5	,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	MOV TEMP_1, X2_1		// TEMP = X[1] << 8

	EOR TEMP_0, RK5_0		//TEMP ^ RK[5]
	EOR TEMP_1, RK5_1

	EOR X1_0, CNT			// X[0] ^ i

	ADD X1_0, TEMP_0		// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0			// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

	MOVW TEMP_0, X3_0	//round6	,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
						//TEMP = X[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK6_0			//TEMP ^ RK[6]
	EOR TEMP_1, RK6_1
	
	EOR X2_1, CNT			// X[0] ^ i

	ADD X2_1, TEMP_0		// X[0]  + TEMP
	ADC X2_0, TEMP_1




	INC CNT
	MOV TEMP_0, X0_1		//round 7	,X0 = X1 ,X1 = X2, X2 = X3 , X3 = X0
	MOV TEMP_1, X0_0		// TEMP = X[1] << 8

	EOR TEMP_0, RK7_0		//TEMP ^ RK[7]
	EOR TEMP_1, RK7_1

	EOR X3_0, CNT			// X[0] ^ i

	ADD X3_0, TEMP_0		// X[0] + TEMP
	ADC X3_1, TEMP_1
		
	LSL X3_0				// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT

	MOVW TEMP_0, X1_0	//round0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3
						//TEMP = x[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LD KEY, Z				//TEMP ^ RK[0]
	EOR TEMP_0, KEY
	LDD KEY, Z+1
	EOR TEMP_1, KEY
	
	EOR X0_0, CNT			// X[0] ^ i

	ADD X0_0, TEMP_0		// X[0]  + TEMP
	ADC X0_1, TEMP_1

	

	

	INC CNT
	MOV TEMP_0, X2_1		//round 1	,X0 = X3 << 8 ,X1 = X0, X2 = X1, X3 = X2
	MOV TEMP_1, X2_0		// TEMP = X[1] << 8 
								
	LDD KEY, Z+2			//TEMP ^ RK[1]
	EOR TEMP_0, KEY
	LDD KEY, Z+3
	EOR TEMP_1, KEY

	EOR X1_0, CNT			// X[0] ^ i

	ADD X1_0, TEMP_0		// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0				// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

	MOVW TEMP_0, X3_0	//round2	,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1
						 //TEMP = x[1]

	LSL TEMP_0			// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LDD KEY, Z+4			//TEMP ^ RK[2]
	EOR TEMP_0, KEY
	LDD KEY, Z+5
	EOR TEMP_1, KEY
	
	EOR X2_0, CNT			// X[0] ^ i

	ADD X2_0, TEMP_0		// X[0]  + TEMP
	ADC X2_1, TEMP_1

	


	INC CNT
	MOV TEMP_0, X0_0		//round 3	,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	MOV TEMP_1, X0_1		// TEMP = X[1] << 8 

	LDD KEY, Z+6			//TEMP ^ RK[3]
	EOR TEMP_0, KEY
	LDD KEY, Z+7
	EOR TEMP_1, KEY

	EOR X3_0, CNT			// X[0] ^ i

	ADD X3_0, TEMP_0		// X[0] + TEMP
	ADC X3_1, TEMP_1

	LSL X3_0				// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT


		MOVW TEMP_0, X1_0	//round4	,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
							 //TEMP = x[1]

	LSL TEMP_0			// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LDD KEY, Z+8		//TEMP ^ RK[4]
	EOR TEMP_0, KEY
	LDD KEY, Z+9
	EOR TEMP_1, KEY

	
	EOR X0_1, CNT		// X[0] ^ i

	ADD X0_1, TEMP_0	// X[0]  + TEMP
	ADC X0_0, TEMP_1




	

	INC CNT
	MOV TEMP_0, X2_0		//round 5	,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	MOV TEMP_1, X2_1		// TEMP = X[1] << 8 

	LDD KEY, Z+10		//TEMP ^ RK[5]
	EOR TEMP_0, KEY
	LDD KEY, Z+11
	EOR TEMP_1, KEY

	EOR X1_0, CNT	// X[0] ^ i

	ADD X1_0, TEMP_0	// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0			// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

	MOVW TEMP_0, X3_0	//round6	,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
						//TEMP = x[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LDD KEY, Z+12			//TEMP ^ RK[6]
	EOR TEMP_0, KEY
	LDD KEY, Z+13
	EOR TEMP_1, KEY
	
	EOR X2_1, CNT			// X[0] ^ i

	ADD X2_1, TEMP_0		// X[0]  + TEMP
	ADC X2_0, TEMP_1




	INC CNT
	MOV TEMP_0, X0_1		//round 7	,X0 = X1 ,X1 = X2, X2 = X3 , X3 = X0
	MOV TEMP_1, X0_0		// TEMP = X[1] << 8 

	LDD KEY, Z+14			//TEMP ^ RK[7]
	EOR TEMP_0, KEY
	LDD KEY, Z+15
	EOR TEMP_1, KEY

	EOR X3_0, CNT		// X[0] ^ i

	ADD X3_0, TEMP_0		// X[0] + TEMP
	ADC X3_1, TEMP_1

	LSL X3_0			// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT

						//round0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3	
	MOVW TEMP_0, X1_0	// TEMP = X[1]

	LSL TEMP_0			// TEMP = TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK0_0	//TEMP ^ RK[0]
	EOR TEMP_1, RK0_1

	
	EOR X0_0, CNT		// X[0] ^ i

	ADD X0_0, TEMP_0	// X[0]  + TEMP
	ADC X0_1, TEMP_1

	INC CNT
							
							//round 1	,X0 = X3 << 8 ,X1 = X0, X2 = X1, X3 = X2	
	MOV TEMP_0, X2_1		// TEMP = X[1] << 8
	MOV TEMP_1, X2_0

	EOR TEMP_0, RK1_0		//TEMP ^ RK[1]
	EOR TEMP_1, RK1_1

	EOR X1_0, CNT			// X[0] ^ i

	ADD X1_0, TEMP_0		// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0				// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

					//round2	,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1	
	MOVW TEMP_0, X3_0			//TEMP = X[1]

	LSL TEMP_0			// TEMP = TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK2_0	//TEMP ^ RK[2]
	EOR TEMP_1, RK2_1
	
	EOR X2_0, CNT	// X[0] ^ i

	ADD X2_0, TEMP_0		// X[0]  + TEMP
	ADC X2_1, TEMP_1

	INC CNT

	MOV TEMP_0, X0_0		//round 3	,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	MOV TEMP_1, X0_1		// TEMP = X[1] << 8

	EOR TEMP_0, RK3_0	//TEMP ^ RK[3]
	EOR TEMP_1, RK3_1

	EOR X3_0, CNT	// X[0] ^ i

	ADD X3_0, TEMP_0	// X[0] + TEMP
	ADC X3_1, TEMP_1

	LSL X3_0	// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT


		MOVW TEMP_0, X1_0	//round4	,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
							//TEMP = X[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK4_0		//TEMP ^ RK[4]
	EOR TEMP_1, RK4_1

	
	EOR X0_1, CNT		// X[0] ^ i

	ADD X0_1, TEMP_0	// X[0]  + TEMP
	ADC X0_0, TEMP_1

	INC CNT

	MOV TEMP_0, X2_0		//round 5	,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	MOV TEMP_1, X2_1		// TEMP = X[1] << 8

	EOR TEMP_0, RK5_0		//TEMP ^ RK[5]
	EOR TEMP_1, RK5_1

	EOR X1_0, CNT			// X[0] ^ i

	ADD X1_0, TEMP_0		// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0			// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

	MOVW TEMP_0, X3_0	//round6	,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
						//TEMP = X[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK6_0			//TEMP ^ RK[6]
	EOR TEMP_1, RK6_1
	
	EOR X2_1, CNT			// X[0] ^ i

	ADD X2_1, TEMP_0		// X[0]  + TEMP
	ADC X2_0, TEMP_1




	INC CNT
	MOV TEMP_0, X0_1		//round 7	,X0 = X1 ,X1 = X2, X2 = X3 , X3 = X0
	MOV TEMP_1, X0_0		// TEMP = X[1] << 8

	EOR TEMP_0, RK7_0		//TEMP ^ RK[7]
	EOR TEMP_1, RK7_1

	EOR X3_0, CNT			// X[0] ^ i

	ADD X3_0, TEMP_0		// X[0] + TEMP
	ADC X3_1, TEMP_1
		
	LSL X3_0				// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT

	MOVW TEMP_0, X1_0	//round0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3
						//TEMP = x[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LD KEY, Z				//TEMP ^ RK[0]
	EOR TEMP_0, KEY
	LDD KEY, Z+1
	EOR TEMP_1, KEY
	
	EOR X0_0, CNT			// X[0] ^ i

	ADD X0_0, TEMP_0		// X[0]  + TEMP
	ADC X0_1, TEMP_1

	

	

	INC CNT
	MOV TEMP_0, X2_1		//round 1	,X0 = X3 << 8 ,X1 = X0, X2 = X1, X3 = X2
	MOV TEMP_1, X2_0		// TEMP = X[1] << 8 
								
	LDD KEY, Z+2			//TEMP ^ RK[1]
	EOR TEMP_0, KEY
	LDD KEY, Z+3
	EOR TEMP_1, KEY

	EOR X1_0, CNT			// X[0] ^ i

	ADD X1_0, TEMP_0		// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0				// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

	MOVW TEMP_0, X3_0	//round2	,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1
						 //TEMP = x[1]

	LSL TEMP_0			// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LDD KEY, Z+4			//TEMP ^ RK[2]
	EOR TEMP_0, KEY
	LDD KEY, Z+5
	EOR TEMP_1, KEY
	
	EOR X2_0, CNT			// X[0] ^ i

	ADD X2_0, TEMP_0		// X[0]  + TEMP
	ADC X2_1, TEMP_1

	


	INC CNT
	MOV TEMP_0, X0_0		//round 3	,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	MOV TEMP_1, X0_1		// TEMP = X[1] << 8 

	LDD KEY, Z+6			//TEMP ^ RK[3]
	EOR TEMP_0, KEY
	LDD KEY, Z+7
	EOR TEMP_1, KEY

	EOR X3_0, CNT			// X[0] ^ i

	ADD X3_0, TEMP_0		// X[0] + TEMP
	ADC X3_1, TEMP_1

	LSL X3_0				// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT


		MOVW TEMP_0, X1_0	//round4	,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
							 //TEMP = x[1]

	LSL TEMP_0			// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LDD KEY, Z+8		//TEMP ^ RK[4]
	EOR TEMP_0, KEY
	LDD KEY, Z+9
	EOR TEMP_1, KEY

	
	EOR X0_1, CNT		// X[0] ^ i

	ADD X0_1, TEMP_0	// X[0]  + TEMP
	ADC X0_0, TEMP_1




	

	INC CNT
	MOV TEMP_0, X2_0		//round 5	,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	MOV TEMP_1, X2_1		// TEMP = X[1] << 8 

	LDD KEY, Z+10		//TEMP ^ RK[5]
	EOR TEMP_0, KEY
	LDD KEY, Z+11
	EOR TEMP_1, KEY

	EOR X1_0, CNT	// X[0] ^ i

	ADD X1_0, TEMP_0	// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0			// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

	MOVW TEMP_0, X3_0	//round6	,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
						//TEMP = x[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LDD KEY, Z+12			//TEMP ^ RK[6]
	EOR TEMP_0, KEY
	LDD KEY, Z+13
	EOR TEMP_1, KEY
	
	EOR X2_1, CNT			// X[0] ^ i

	ADD X2_1, TEMP_0		// X[0]  + TEMP
	ADC X2_0, TEMP_1




	INC CNT
	MOV TEMP_0, X0_1		//round 7	,X0 = X1 ,X1 = X2, X2 = X3 , X3 = X0
	MOV TEMP_1, X0_0		// TEMP = X[1] << 8 

	LDD KEY, Z+14			//TEMP ^ RK[7]
	EOR TEMP_0, KEY
	LDD KEY, Z+15
	EOR TEMP_1, KEY

	EOR X3_0, CNT		// X[0] ^ i

	ADD X3_0, TEMP_0		// X[0] + TEMP
	ADC X3_1, TEMP_1

	LSL X3_0			// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT

						//round0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3	
	MOVW TEMP_0, X1_0	// TEMP = X[1]

	LSL TEMP_0			// TEMP = TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK0_0	//TEMP ^ RK[0]
	EOR TEMP_1, RK0_1

	
	EOR X0_0, CNT		// X[0] ^ i

	ADD X0_0, TEMP_0	// X[0]  + TEMP
	ADC X0_1, TEMP_1

	INC CNT
							
							//round 1	,X0 = X3 << 8 ,X1 = X0, X2 = X1, X3 = X2	
	MOV TEMP_0, X2_1		// TEMP = X[1] << 8
	MOV TEMP_1, X2_0

	EOR TEMP_0, RK1_0		//TEMP ^ RK[1]
	EOR TEMP_1, RK1_1

	EOR X1_0, CNT			// X[0] ^ i

	ADD X1_0, TEMP_0		// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0				// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

					//round2	,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1	
	MOVW TEMP_0, X3_0			//TEMP = X[1]

	LSL TEMP_0			// TEMP = TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK2_0	//TEMP ^ RK[2]
	EOR TEMP_1, RK2_1
	
	EOR X2_0, CNT	// X[0] ^ i

	ADD X2_0, TEMP_0		// X[0]  + TEMP
	ADC X2_1, TEMP_1

	INC CNT

	MOV TEMP_0, X0_0		//round 3	,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	MOV TEMP_1, X0_1		// TEMP = X[1] << 8

	EOR TEMP_0, RK3_0	//TEMP ^ RK[3]
	EOR TEMP_1, RK3_1

	EOR X3_0, CNT	// X[0] ^ i

	ADD X3_0, TEMP_0	// X[0] + TEMP
	ADC X3_1, TEMP_1

	LSL X3_0	// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT


		MOVW TEMP_0, X1_0	//round4	,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
							//TEMP = X[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK4_0		//TEMP ^ RK[4]
	EOR TEMP_1, RK4_1

	
	EOR X0_1, CNT		// X[0] ^ i

	ADD X0_1, TEMP_0	// X[0]  + TEMP
	ADC X0_0, TEMP_1

	INC CNT

	MOV TEMP_0, X2_0		//round 5	,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	MOV TEMP_1, X2_1		// TEMP = X[1] << 8

	EOR TEMP_0, RK5_0		//TEMP ^ RK[5]
	EOR TEMP_1, RK5_1

	EOR X1_0, CNT			// X[0] ^ i

	ADD X1_0, TEMP_0		// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0			// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

	MOVW TEMP_0, X3_0	//round6	,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
						//TEMP = X[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK6_0			//TEMP ^ RK[6]
	EOR TEMP_1, RK6_1
	
	EOR X2_1, CNT			// X[0] ^ i

	ADD X2_1, TEMP_0		// X[0]  + TEMP
	ADC X2_0, TEMP_1




	INC CNT
	MOV TEMP_0, X0_1		//round 7	,X0 = X1 ,X1 = X2, X2 = X3 , X3 = X0
	MOV TEMP_1, X0_0		// TEMP = X[1] << 8

	EOR TEMP_0, RK7_0		//TEMP ^ RK[7]
	EOR TEMP_1, RK7_1

	EOR X3_0, CNT			// X[0] ^ i

	ADD X3_0, TEMP_0		// X[0] + TEMP
	ADC X3_1, TEMP_1
		
	LSL X3_0				// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT

	MOVW TEMP_0, X1_0	//round0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3
						//TEMP = x[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LD KEY, Z				//TEMP ^ RK[0]
	EOR TEMP_0, KEY
	LDD KEY, Z+1
	EOR TEMP_1, KEY
	
	EOR X0_0, CNT			// X[0] ^ i

	ADD X0_0, TEMP_0		// X[0]  + TEMP
	ADC X0_1, TEMP_1

	

	

	INC CNT
	MOV TEMP_0, X2_1		//round 1	,X0 = X3 << 8 ,X1 = X0, X2 = X1, X3 = X2
	MOV TEMP_1, X2_0		// TEMP = X[1] << 8 
								
	LDD KEY, Z+2			//TEMP ^ RK[1]
	EOR TEMP_0, KEY
	LDD KEY, Z+3
	EOR TEMP_1, KEY

	EOR X1_0, CNT			// X[0] ^ i

	ADD X1_0, TEMP_0		// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0				// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

	MOVW TEMP_0, X3_0	//round2	,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1
						 //TEMP = x[1]

	LSL TEMP_0			// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LDD KEY, Z+4			//TEMP ^ RK[2]
	EOR TEMP_0, KEY
	LDD KEY, Z+5
	EOR TEMP_1, KEY
	
	EOR X2_0, CNT			// X[0] ^ i

	ADD X2_0, TEMP_0		// X[0]  + TEMP
	ADC X2_1, TEMP_1

	


	INC CNT
	MOV TEMP_0, X0_0		//round 3	,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	MOV TEMP_1, X0_1		// TEMP = X[1] << 8 

	LDD KEY, Z+6			//TEMP ^ RK[3]
	EOR TEMP_0, KEY
	LDD KEY, Z+7
	EOR TEMP_1, KEY

	EOR X3_0, CNT			// X[0] ^ i

	ADD X3_0, TEMP_0		// X[0] + TEMP
	ADC X3_1, TEMP_1

	LSL X3_0				// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT


		MOVW TEMP_0, X1_0	//round4	,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
							 //TEMP = x[1]

	LSL TEMP_0			// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LDD KEY, Z+8		//TEMP ^ RK[4]
	EOR TEMP_0, KEY
	LDD KEY, Z+9
	EOR TEMP_1, KEY

	
	EOR X0_1, CNT		// X[0] ^ i

	ADD X0_1, TEMP_0	// X[0]  + TEMP
	ADC X0_0, TEMP_1




	

	INC CNT
	MOV TEMP_0, X2_0		//round 5	,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	MOV TEMP_1, X2_1		// TEMP = X[1] << 8 

	LDD KEY, Z+10		//TEMP ^ RK[5]
	EOR TEMP_0, KEY
	LDD KEY, Z+11
	EOR TEMP_1, KEY

	EOR X1_0, CNT	// X[0] ^ i

	ADD X1_0, TEMP_0	// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0			// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

	MOVW TEMP_0, X3_0	//round6	,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
						//TEMP = x[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LDD KEY, Z+12			//TEMP ^ RK[6]
	EOR TEMP_0, KEY
	LDD KEY, Z+13
	EOR TEMP_1, KEY
	
	EOR X2_1, CNT			// X[0] ^ i

	ADD X2_1, TEMP_0		// X[0]  + TEMP
	ADC X2_0, TEMP_1




	INC CNT
	MOV TEMP_0, X0_1		//round 7	,X0 = X1 ,X1 = X2, X2 = X3 , X3 = X0
	MOV TEMP_1, X0_0		// TEMP = X[1] << 8 

	LDD KEY, Z+14			//TEMP ^ RK[7]
	EOR TEMP_0, KEY
	LDD KEY, Z+15
	EOR TEMP_1, KEY

	EOR X3_0, CNT		// X[0] ^ i

	ADD X3_0, TEMP_0		// X[0] + TEMP
	ADC X3_1, TEMP_1

	LSL X3_0			// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT

						//round0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3	
	MOVW TEMP_0, X1_0	// TEMP = X[1]

	LSL TEMP_0			// TEMP = TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK0_0	//TEMP ^ RK[0]
	EOR TEMP_1, RK0_1

	
	EOR X0_0, CNT		// X[0] ^ i

	ADD X0_0, TEMP_0	// X[0]  + TEMP
	ADC X0_1, TEMP_1

	INC CNT
							
							//round 1	,X0 = X3 << 8 ,X1 = X0, X2 = X1, X3 = X2	
	MOV TEMP_0, X2_1		// TEMP = X[1] << 8
	MOV TEMP_1, X2_0

	EOR TEMP_0, RK1_0		//TEMP ^ RK[1]
	EOR TEMP_1, RK1_1

	EOR X1_0, CNT			// X[0] ^ i

	ADD X1_0, TEMP_0		// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0				// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

					//round2	,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1	
	MOVW TEMP_0, X3_0			//TEMP = X[1]

	LSL TEMP_0			// TEMP = TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK2_0	//TEMP ^ RK[2]
	EOR TEMP_1, RK2_1
	
	EOR X2_0, CNT	// X[0] ^ i

	ADD X2_0, TEMP_0		// X[0]  + TEMP
	ADC X2_1, TEMP_1

	INC CNT

	MOV TEMP_0, X0_0		//round 3	,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	MOV TEMP_1, X0_1		// TEMP = X[1] << 8

	EOR TEMP_0, RK3_0	//TEMP ^ RK[3]
	EOR TEMP_1, RK3_1

	EOR X3_0, CNT	// X[0] ^ i

	ADD X3_0, TEMP_0	// X[0] + TEMP
	ADC X3_1, TEMP_1

	LSL X3_0	// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT


		MOVW TEMP_0, X1_0	//round4	,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
							//TEMP = X[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK4_0		//TEMP ^ RK[4]
	EOR TEMP_1, RK4_1

	
	EOR X0_1, CNT		// X[0] ^ i

	ADD X0_1, TEMP_0	// X[0]  + TEMP
	ADC X0_0, TEMP_1

	INC CNT

	MOV TEMP_0, X2_0		//round 5	,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	MOV TEMP_1, X2_1		// TEMP = X[1] << 8

	EOR TEMP_0, RK5_0		//TEMP ^ RK[5]
	EOR TEMP_1, RK5_1

	EOR X1_0, CNT			// X[0] ^ i

	ADD X1_0, TEMP_0		// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0			// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

	MOVW TEMP_0, X3_0	//round6	,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
						//TEMP = X[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK6_0			//TEMP ^ RK[6]
	EOR TEMP_1, RK6_1
	
	EOR X2_1, CNT			// X[0] ^ i

	ADD X2_1, TEMP_0		// X[0]  + TEMP
	ADC X2_0, TEMP_1




	INC CNT
	MOV TEMP_0, X0_1		//round 7	,X0 = X1 ,X1 = X2, X2 = X3 , X3 = X0
	MOV TEMP_1, X0_0		// TEMP = X[1] << 8

	EOR TEMP_0, RK7_0		//TEMP ^ RK[7]
	EOR TEMP_1, RK7_1

	EOR X3_0, CNT			// X[0] ^ i

	ADD X3_0, TEMP_0		// X[0] + TEMP
	ADC X3_1, TEMP_1
		
	LSL X3_0				// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT

	MOVW TEMP_0, X1_0	//round0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3
						//TEMP = x[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LD KEY, Z				//TEMP ^ RK[0]
	EOR TEMP_0, KEY
	LDD KEY, Z+1
	EOR TEMP_1, KEY
	
	EOR X0_0, CNT			// X[0] ^ i

	ADD X0_0, TEMP_0		// X[0]  + TEMP
	ADC X0_1, TEMP_1

	

	

	INC CNT
	MOV TEMP_0, X2_1		//round 1	,X0 = X3 << 8 ,X1 = X0, X2 = X1, X3 = X2
	MOV TEMP_1, X2_0		// TEMP = X[1] << 8 
								
	LDD KEY, Z+2			//TEMP ^ RK[1]
	EOR TEMP_0, KEY
	LDD KEY, Z+3
	EOR TEMP_1, KEY

	EOR X1_0, CNT			// X[0] ^ i

	ADD X1_0, TEMP_0		// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0				// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

	MOVW TEMP_0, X3_0	//round2	,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1
						 //TEMP = x[1]

	LSL TEMP_0			// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LDD KEY, Z+4			//TEMP ^ RK[2]
	EOR TEMP_0, KEY
	LDD KEY, Z+5
	EOR TEMP_1, KEY
	
	EOR X2_0, CNT			// X[0] ^ i

	ADD X2_0, TEMP_0		// X[0]  + TEMP
	ADC X2_1, TEMP_1

	


	INC CNT
	MOV TEMP_0, X0_0		//round 3	,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	MOV TEMP_1, X0_1		// TEMP = X[1] << 8 

	LDD KEY, Z+6			//TEMP ^ RK[3]
	EOR TEMP_0, KEY
	LDD KEY, Z+7
	EOR TEMP_1, KEY

	EOR X3_0, CNT			// X[0] ^ i

	ADD X3_0, TEMP_0		// X[0] + TEMP
	ADC X3_1, TEMP_1

	LSL X3_0				// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT


		MOVW TEMP_0, X1_0	//round4	,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
							 //TEMP = x[1]

	LSL TEMP_0			// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LDD KEY, Z+8		//TEMP ^ RK[4]
	EOR TEMP_0, KEY
	LDD KEY, Z+9
	EOR TEMP_1, KEY

	
	EOR X0_1, CNT		// X[0] ^ i

	ADD X0_1, TEMP_0	// X[0]  + TEMP
	ADC X0_0, TEMP_1




	

	INC CNT
	MOV TEMP_0, X2_0		//round 5	,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	MOV TEMP_1, X2_1		// TEMP = X[1] << 8 

	LDD KEY, Z+10		//TEMP ^ RK[5]
	EOR TEMP_0, KEY
	LDD KEY, Z+11
	EOR TEMP_1, KEY

	EOR X1_0, CNT	// X[0] ^ i

	ADD X1_0, TEMP_0	// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0			// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

	MOVW TEMP_0, X3_0	//round6	,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
						//TEMP = x[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LDD KEY, Z+12			//TEMP ^ RK[6]
	EOR TEMP_0, KEY
	LDD KEY, Z+13
	EOR TEMP_1, KEY
	
	EOR X2_1, CNT			// X[0] ^ i

	ADD X2_1, TEMP_0		// X[0]  + TEMP
	ADC X2_0, TEMP_1




	INC CNT
	MOV TEMP_0, X0_1		//round 7	,X0 = X1 ,X1 = X2, X2 = X3 , X3 = X0
	MOV TEMP_1, X0_0		// TEMP = X[1] << 8 

	LDD KEY, Z+14			//TEMP ^ RK[7]
	EOR TEMP_0, KEY
	LDD KEY, Z+15
	EOR TEMP_1, KEY

	EOR X3_0, CNT		// X[0] ^ i

	ADD X3_0, TEMP_0		// X[0] + TEMP
	ADC X3_1, TEMP_1

	LSL X3_0			// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT

						//round0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3	
	MOVW TEMP_0, X1_0	// TEMP = X[1]

	LSL TEMP_0			// TEMP = TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK0_0	//TEMP ^ RK[0]
	EOR TEMP_1, RK0_1

	
	EOR X0_0, CNT		// X[0] ^ i

	ADD X0_0, TEMP_0	// X[0]  + TEMP
	ADC X0_1, TEMP_1

	INC CNT
							
							//round 1	,X0 = X3 << 8 ,X1 = X0, X2 = X1, X3 = X2	
	MOV TEMP_0, X2_1		// TEMP = X[1] << 8
	MOV TEMP_1, X2_0

	EOR TEMP_0, RK1_0		//TEMP ^ RK[1]
	EOR TEMP_1, RK1_1

	EOR X1_0, CNT			// X[0] ^ i

	ADD X1_0, TEMP_0		// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0				// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

					//round2	,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1	
	MOVW TEMP_0, X3_0			//TEMP = X[1]

	LSL TEMP_0			// TEMP = TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK2_0	//TEMP ^ RK[2]
	EOR TEMP_1, RK2_1
	
	EOR X2_0, CNT	// X[0] ^ i

	ADD X2_0, TEMP_0		// X[0]  + TEMP
	ADC X2_1, TEMP_1

	INC CNT

	MOV TEMP_0, X0_0		//round 3	,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	MOV TEMP_1, X0_1		// TEMP = X[1] << 8

	EOR TEMP_0, RK3_0	//TEMP ^ RK[3]
	EOR TEMP_1, RK3_1

	EOR X3_0, CNT	// X[0] ^ i

	ADD X3_0, TEMP_0	// X[0] + TEMP
	ADC X3_1, TEMP_1

	LSL X3_0	// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT


		MOVW TEMP_0, X1_0	//round4	,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
							//TEMP = X[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK4_0		//TEMP ^ RK[4]
	EOR TEMP_1, RK4_1

	
	EOR X0_1, CNT		// X[0] ^ i

	ADD X0_1, TEMP_0	// X[0]  + TEMP
	ADC X0_0, TEMP_1

	INC CNT

	MOV TEMP_0, X2_0		//round 5	,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	MOV TEMP_1, X2_1		// TEMP = X[1] << 8

	EOR TEMP_0, RK5_0		//TEMP ^ RK[5]
	EOR TEMP_1, RK5_1

	EOR X1_0, CNT			// X[0] ^ i

	ADD X1_0, TEMP_0		// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0			// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

	MOVW TEMP_0, X3_0	//round6	,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
						//TEMP = X[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK6_0			//TEMP ^ RK[6]
	EOR TEMP_1, RK6_1
	
	EOR X2_1, CNT			// X[0] ^ i

	ADD X2_1, TEMP_0		// X[0]  + TEMP
	ADC X2_0, TEMP_1




	INC CNT
	MOV TEMP_0, X0_1		//round 7	,X0 = X1 ,X1 = X2, X2 = X3 , X3 = X0
	MOV TEMP_1, X0_0		// TEMP = X[1] << 8

	EOR TEMP_0, RK7_0		//TEMP ^ RK[7]
	EOR TEMP_1, RK7_1

	EOR X3_0, CNT			// X[0] ^ i

	ADD X3_0, TEMP_0		// X[0] + TEMP
	ADC X3_1, TEMP_1
		
	LSL X3_0				// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT

	MOVW TEMP_0, X1_0	//round0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3
						//TEMP = x[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LD KEY, Z				//TEMP ^ RK[0]
	EOR TEMP_0, KEY
	LDD KEY, Z+1
	EOR TEMP_1, KEY
	
	EOR X0_0, CNT			// X[0] ^ i

	ADD X0_0, TEMP_0		// X[0]  + TEMP
	ADC X0_1, TEMP_1

	

	

	INC CNT
	MOV TEMP_0, X2_1		//round 1	,X0 = X3 << 8 ,X1 = X0, X2 = X1, X3 = X2
	MOV TEMP_1, X2_0		// TEMP = X[1] << 8 
								
	LDD KEY, Z+2			//TEMP ^ RK[1]
	EOR TEMP_0, KEY
	LDD KEY, Z+3
	EOR TEMP_1, KEY

	EOR X1_0, CNT			// X[0] ^ i

	ADD X1_0, TEMP_0		// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0				// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

	MOVW TEMP_0, X3_0	//round2	,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1
						 //TEMP = x[1]

	LSL TEMP_0			// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LDD KEY, Z+4			//TEMP ^ RK[2]
	EOR TEMP_0, KEY
	LDD KEY, Z+5
	EOR TEMP_1, KEY
	
	EOR X2_0, CNT			// X[0] ^ i

	ADD X2_0, TEMP_0		// X[0]  + TEMP
	ADC X2_1, TEMP_1

	


	INC CNT
	MOV TEMP_0, X0_0		//round 3	,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	MOV TEMP_1, X0_1		// TEMP = X[1] << 8 

	LDD KEY, Z+6			//TEMP ^ RK[3]
	EOR TEMP_0, KEY
	LDD KEY, Z+7
	EOR TEMP_1, KEY

	EOR X3_0, CNT			// X[0] ^ i

	ADD X3_0, TEMP_0		// X[0] + TEMP
	ADC X3_1, TEMP_1

	LSL X3_0				// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT


		MOVW TEMP_0, X1_0	//round4	,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
							 //TEMP = x[1]

	LSL TEMP_0			// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LDD KEY, Z+8		//TEMP ^ RK[4]
	EOR TEMP_0, KEY
	LDD KEY, Z+9
	EOR TEMP_1, KEY

	
	EOR X0_1, CNT		// X[0] ^ i

	ADD X0_1, TEMP_0	// X[0]  + TEMP
	ADC X0_0, TEMP_1




	

	INC CNT
	MOV TEMP_0, X2_0		//round 5	,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	MOV TEMP_1, X2_1		// TEMP = X[1] << 8 

	LDD KEY, Z+10		//TEMP ^ RK[5]
	EOR TEMP_0, KEY
	LDD KEY, Z+11
	EOR TEMP_1, KEY

	EOR X1_0, CNT	// X[0] ^ i

	ADD X1_0, TEMP_0	// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0			// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

	MOVW TEMP_0, X3_0	//round6	,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
						//TEMP = x[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	LDD KEY, Z+12			//TEMP ^ RK[6]
	EOR TEMP_0, KEY
	LDD KEY, Z+13
	EOR TEMP_1, KEY
	
	EOR X2_1, CNT			// X[0] ^ i

	ADD X2_1, TEMP_0		// X[0]  + TEMP
	ADC X2_0, TEMP_1




	INC CNT
	MOV TEMP_0, X0_1		//round 7	,X0 = X1 ,X1 = X2, X2 = X3 , X3 = X0
	MOV TEMP_1, X0_0		// TEMP = X[1] << 8 

	LDD KEY, Z+14			//TEMP ^ RK[7]
	EOR TEMP_0, KEY
	LDD KEY, Z+15
	EOR TEMP_1, KEY

	EOR X3_0, CNT		// X[0] ^ i

	ADD X3_0, TEMP_0		// X[0] + TEMP
	ADC X3_1, TEMP_1

	LSL X3_0			// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT

						//round0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3	
	MOVW TEMP_0, X1_0	// TEMP = X[1]

	LSL TEMP_0			// TEMP = TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK0_0	//TEMP ^ RK[0]
	EOR TEMP_1, RK0_1

	
	EOR X0_0, CNT		// X[0] ^ i

	ADD X0_0, TEMP_0	// X[0]  + TEMP
	ADC X0_1, TEMP_1

	INC CNT
							
							//round 1	,X0 = X3 << 8 ,X1 = X0, X2 = X1, X3 = X2	
	MOV TEMP_0, X2_1		// TEMP = X[1] << 8
	MOV TEMP_1, X2_0

	EOR TEMP_0, RK1_0		//TEMP ^ RK[1]
	EOR TEMP_1, RK1_1

	EOR X1_0, CNT			// X[0] ^ i

	ADD X1_0, TEMP_0		// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0				// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

					//round2	,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1	
	MOVW TEMP_0, X3_0			//TEMP = X[1]

	LSL TEMP_0			// TEMP = TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK2_0	//TEMP ^ RK[2]
	EOR TEMP_1, RK2_1
	
	EOR X2_0, CNT	// X[0] ^ i

	ADD X2_0, TEMP_0		// X[0]  + TEMP
	ADC X2_1, TEMP_1

	INC CNT

	MOV TEMP_0, X0_0		//round 3	,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	MOV TEMP_1, X0_1		// TEMP = X[1] << 8

	EOR TEMP_0, RK3_0	//TEMP ^ RK[3]
	EOR TEMP_1, RK3_1

	EOR X3_0, CNT	// X[0] ^ i

	ADD X3_0, TEMP_0	// X[0] + TEMP
	ADC X3_1, TEMP_1

	LSL X3_0	// X[0] << 1
	ROL X3_1
	ADC X3_0, R1


	INC CNT


		MOVW TEMP_0, X1_0	//round4	,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
							//TEMP = X[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK4_0		//TEMP ^ RK[4]
	EOR TEMP_1, RK4_1

	
	EOR X0_1, CNT		// X[0] ^ i

	ADD X0_1, TEMP_0	// X[0]  + TEMP
	ADC X0_0, TEMP_1

	INC CNT

	MOV TEMP_0, X2_0		//round 5	,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	MOV TEMP_1, X2_1		// TEMP = X[1] << 8

	EOR TEMP_0, RK5_0		//TEMP ^ RK[5]
	EOR TEMP_1, RK5_1

	EOR X1_0, CNT			// X[0] ^ i

	ADD X1_0, TEMP_0		// X[0] + TEMP
	ADC X1_1, TEMP_1

	LSL X1_0			// X[0] << 1
	ROL X1_1
	ADC X1_0, R1

	
	INC CNT

	MOVW TEMP_0, X3_0	//round6	,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
						//TEMP = X[1]

	LSL TEMP_0				// TEMP << 1
	ROL TEMP_1
	ADC TEMP_0, R1
	
	EOR TEMP_0, RK6_0			//TEMP ^ RK[6]
	EOR TEMP_1, RK6_1
	
	EOR X2_1, CNT			// X[0] ^ i

	ADD X2_1, TEMP_0		// X[0]  + TEMP
	ADC X2_0, TEMP_1




	INC CNT
	MOV TEMP_0, X0_1		//round 7	,X0 = X1 ,X1 = X2, X2 = X3 , X3 = X0
	MOV TEMP_1, X0_0		// TEMP = X[1] << 8

	EOR TEMP_0, RK7_0		//TEMP ^ RK[7]
	EOR TEMP_1, RK7_1

	EOR X3_0, CNT			// X[0] ^ i

	ADD X3_0, TEMP_0		// X[0] + TEMP
	ADC X3_1, TEMP_1
		
	LSL X3_0				// X[0] << 1
	ROL X3_1
	ADC X3_0, R1




	





	POP R27
	POP R26

	ST X+, X0_0
	ST X+, X0_1
	ST X+, X1_0
	ST X+, X1_1
	ST X+, X2_0
	ST X+, X2_1
	ST X+, X3_0
	ST X+, X3_1

	POP R29
	POP R28
	POP R17
	POP R16
	POP R15
	POP R14
	POP R13
	POP R12
	POP R11
	POP R10
	POP R9
	POP R8
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2	
	POP R0
	

RET

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡdecryptionㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ



//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡdecryptionㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ




//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

.global cham64_decrypt
.type cham64_decrypt, @function

#define RK0_0 R0
#define RK0_1 R2
#define RK1_0 R3
#define RK1_1 R4
#define RK2_0 R5
#define RK2_1 R6
#define RK3_0 R7
#define RK3_1 R8
#define RK4_0 R9
#define RK4_1 R10
#define RK5_0 R11
#define RK5_1 R12
#define RK6_0 R13
#define RK6_1 R14
#define RK7_0 R15
#define RK7_1 R16


#define CNT R17
#define RC R28

#define TEMP_0 R26
#define TEMP_1 R27

#define KEY R29

#define X0_0 R18
#define X0_1 R19
#define X1_0 R20
#define X1_1 R21
#define X2_0 R22
#define X2_1 R23
#define X3_0 R24
#define X3_1 R25


cham64_decrypt:

	PUSH R0
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9
	PUSH R10
	PUSH R11
	PUSH R12
	PUSH R13
	PUSH R14
	PUSH R15
	PUSH R16
	PUSH R17
	PUSH R28
	PUSH R29
//cham64_decrypt(pt2, ct, rk);
	PUSH R24
	PUSH R25

	MOVW R26, R22
	MOVW R30, R20

	LD X0_0, X+
	LD X0_1, X+
	LD X1_0, X+
	LD X1_1, X+
	LD X2_0, X+
	LD X2_1, X+
	LD X3_0, X+
	LD X3_1, X+

	LD RK0_0, Z+
	LD RK0_1, Z+
	LD RK1_0, Z+
	LD RK1_1, Z+
	LD RK2_0, Z+
	LD RK2_1, Z+
	LD RK3_0, Z+
	LD RK3_1, Z+
	LD RK4_0, Z+
	LD RK4_1, Z+
	LD RK5_0, Z+
	LD RK5_1, Z+
	LD RK6_0, Z+
	LD RK6_1, Z+
	LD RK7_0, Z+
	LD RK7_1, Z+
	

	LDI CNT, 87


					//round 7	 ,X0 = X1 ,X1 = X2, X2 = X3, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_0

			// TEMP = TEMP ^ KEY
	EOR TEMP_0, RK7_0	
	EOR TEMP_1, RK7_1

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 6 ,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
	

	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK6_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK6_1

	SUB X2_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_0, TEMP_1

	EOR X2_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 5 ,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_1

	EOR TEMP_0, RK5_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK5_1

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 4 ,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
	

	

	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK4_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK4_1

	SUB X0_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_0, TEMP_1

	EOR X0_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 3 ,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_1

	EOR TEMP_0, RK3_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK3_1

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 2 ,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1


	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK2_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK2_1

	SUB X2_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_1, TEMP_1

	EOR X2_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 1 ,X0 = X3 << 8,X1 = X0, X2 = X1, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_0

	EOR TEMP_0, RK1_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK1_1

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3
	



	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK0_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK0_1

	SUB X0_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_1, TEMP_1

	EOR X0_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--


				//round 7	 ,X0 = X1 ,X1 = X2, X2 = X3, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_0

	LDD KEY, Z+14		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+15
	EOR TEMP_1, KEY

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 6 ,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
	

	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LDD KEY, Z+12		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+13
	EOR TEMP_1, KEY

	SUB X2_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_0, TEMP_1

	EOR X2_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 5 ,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_1

	LDD KEY, Z+10		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+11
	EOR TEMP_1, KEY

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 4 ,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
	

	

	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LDD KEY, Z+8		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+9
	EOR TEMP_1, KEY

	SUB X0_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_0, TEMP_1

	EOR X0_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 3 ,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_1

	LDD KEY, Z+6		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+7
	EOR TEMP_1, KEY

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 2 ,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1


	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LDD KEY, Z+4		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+5
	EOR TEMP_1, KEY

	SUB X2_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_1, TEMP_1

	EOR X2_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 1 ,X0 = X3 << 8,X1 = X0, X2 = X1, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_0

	LDD KEY, Z+2		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+3
	EOR TEMP_1, KEY

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3
	



	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LD KEY, Z		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+1
	EOR TEMP_1, KEY

	SUB X0_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_1, TEMP_1

	EOR X0_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

					//round 7	 ,X0 = X1 ,X1 = X2, X2 = X3, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_0

			// TEMP = TEMP ^ KEY
	EOR TEMP_0, RK7_0	
	EOR TEMP_1, RK7_1

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 6 ,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
	

	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK6_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK6_1

	SUB X2_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_0, TEMP_1

	EOR X2_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 5 ,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_1

	EOR TEMP_0, RK5_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK5_1

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 4 ,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
	

	

	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK4_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK4_1

	SUB X0_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_0, TEMP_1

	EOR X0_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 3 ,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_1

	EOR TEMP_0, RK3_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK3_1

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 2 ,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1


	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK2_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK2_1

	SUB X2_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_1, TEMP_1

	EOR X2_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 1 ,X0 = X3 << 8,X1 = X0, X2 = X1, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_0

	EOR TEMP_0, RK1_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK1_1

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3
	



	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK0_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK0_1

	SUB X0_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_1, TEMP_1

	EOR X0_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--


				//round 7	 ,X0 = X1 ,X1 = X2, X2 = X3, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_0

	LDD KEY, Z+14		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+15
	EOR TEMP_1, KEY

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 6 ,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
	

	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LDD KEY, Z+12		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+13
	EOR TEMP_1, KEY

	SUB X2_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_0, TEMP_1

	EOR X2_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 5 ,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_1

	LDD KEY, Z+10		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+11
	EOR TEMP_1, KEY

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 4 ,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
	

	

	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LDD KEY, Z+8		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+9
	EOR TEMP_1, KEY

	SUB X0_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_0, TEMP_1

	EOR X0_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 3 ,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_1

	LDD KEY, Z+6		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+7
	EOR TEMP_1, KEY

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 2 ,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1


	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LDD KEY, Z+4		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+5
	EOR TEMP_1, KEY

	SUB X2_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_1, TEMP_1

	EOR X2_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 1 ,X0 = X3 << 8,X1 = X0, X2 = X1, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_0

	LDD KEY, Z+2		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+3
	EOR TEMP_1, KEY

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3
	



	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LD KEY, Z		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+1
	EOR TEMP_1, KEY

	SUB X0_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_1, TEMP_1

	EOR X0_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

					//round 7	 ,X0 = X1 ,X1 = X2, X2 = X3, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_0

			// TEMP = TEMP ^ KEY
	EOR TEMP_0, RK7_0	
	EOR TEMP_1, RK7_1

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 6 ,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
	

	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK6_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK6_1

	SUB X2_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_0, TEMP_1

	EOR X2_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 5 ,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_1

	EOR TEMP_0, RK5_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK5_1

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 4 ,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
	

	

	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK4_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK4_1

	SUB X0_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_0, TEMP_1

	EOR X0_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 3 ,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_1

	EOR TEMP_0, RK3_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK3_1

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 2 ,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1


	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK2_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK2_1

	SUB X2_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_1, TEMP_1

	EOR X2_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 1 ,X0 = X3 << 8,X1 = X0, X2 = X1, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_0

	EOR TEMP_0, RK1_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK1_1

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3
	



	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK0_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK0_1

	SUB X0_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_1, TEMP_1

	EOR X0_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--


				//round 7	 ,X0 = X1 ,X1 = X2, X2 = X3, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_0

	LDD KEY, Z+14		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+15
	EOR TEMP_1, KEY

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 6 ,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
	

	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LDD KEY, Z+12		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+13
	EOR TEMP_1, KEY

	SUB X2_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_0, TEMP_1

	EOR X2_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 5 ,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_1

	LDD KEY, Z+10		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+11
	EOR TEMP_1, KEY

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 4 ,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
	

	

	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LDD KEY, Z+8		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+9
	EOR TEMP_1, KEY

	SUB X0_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_0, TEMP_1

	EOR X0_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 3 ,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_1

	LDD KEY, Z+6		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+7
	EOR TEMP_1, KEY

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 2 ,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1


	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LDD KEY, Z+4		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+5
	EOR TEMP_1, KEY

	SUB X2_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_1, TEMP_1

	EOR X2_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 1 ,X0 = X3 << 8,X1 = X0, X2 = X1, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_0

	LDD KEY, Z+2		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+3
	EOR TEMP_1, KEY

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3
	



	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LD KEY, Z		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+1
	EOR TEMP_1, KEY

	SUB X0_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_1, TEMP_1

	EOR X0_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

					//round 7	 ,X0 = X1 ,X1 = X2, X2 = X3, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_0

			// TEMP = TEMP ^ KEY
	EOR TEMP_0, RK7_0	
	EOR TEMP_1, RK7_1

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 6 ,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
	

	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK6_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK6_1

	SUB X2_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_0, TEMP_1

	EOR X2_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 5 ,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_1

	EOR TEMP_0, RK5_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK5_1

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 4 ,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
	

	

	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK4_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK4_1

	SUB X0_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_0, TEMP_1

	EOR X0_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 3 ,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_1

	EOR TEMP_0, RK3_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK3_1

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 2 ,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1


	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK2_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK2_1

	SUB X2_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_1, TEMP_1

	EOR X2_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 1 ,X0 = X3 << 8,X1 = X0, X2 = X1, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_0

	EOR TEMP_0, RK1_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK1_1

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3
	



	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK0_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK0_1

	SUB X0_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_1, TEMP_1

	EOR X0_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--


				//round 7	 ,X0 = X1 ,X1 = X2, X2 = X3, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_0

	LDD KEY, Z+14		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+15
	EOR TEMP_1, KEY

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 6 ,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
	

	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LDD KEY, Z+12		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+13
	EOR TEMP_1, KEY

	SUB X2_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_0, TEMP_1

	EOR X2_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 5 ,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_1

	LDD KEY, Z+10		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+11
	EOR TEMP_1, KEY

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 4 ,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
	

	

	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LDD KEY, Z+8		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+9
	EOR TEMP_1, KEY

	SUB X0_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_0, TEMP_1

	EOR X0_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 3 ,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_1

	LDD KEY, Z+6		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+7
	EOR TEMP_1, KEY

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 2 ,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1


	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LDD KEY, Z+4		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+5
	EOR TEMP_1, KEY

	SUB X2_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_1, TEMP_1

	EOR X2_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 1 ,X0 = X3 << 8,X1 = X0, X2 = X1, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_0

	LDD KEY, Z+2		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+3
	EOR TEMP_1, KEY

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3
	



	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LD KEY, Z		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+1
	EOR TEMP_1, KEY

	SUB X0_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_1, TEMP_1

	EOR X0_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

					//round 7	 ,X0 = X1 ,X1 = X2, X2 = X3, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_0

			// TEMP = TEMP ^ KEY
	EOR TEMP_0, RK7_0	
	EOR TEMP_1, RK7_1

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 6 ,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
	

	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK6_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK6_1

	SUB X2_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_0, TEMP_1

	EOR X2_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 5 ,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_1

	EOR TEMP_0, RK5_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK5_1

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 4 ,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
	

	

	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK4_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK4_1

	SUB X0_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_0, TEMP_1

	EOR X0_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 3 ,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_1

	EOR TEMP_0, RK3_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK3_1

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 2 ,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1


	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK2_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK2_1

	SUB X2_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_1, TEMP_1

	EOR X2_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 1 ,X0 = X3 << 8,X1 = X0, X2 = X1, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_0

	EOR TEMP_0, RK1_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK1_1

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3
	



	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK0_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK0_1

	SUB X0_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_1, TEMP_1

	EOR X0_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--


				//round 7	 ,X0 = X1 ,X1 = X2, X2 = X3, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_0

	LDD KEY, Z+14		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+15
	EOR TEMP_1, KEY

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 6 ,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
	

	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LDD KEY, Z+12		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+13
	EOR TEMP_1, KEY

	SUB X2_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_0, TEMP_1

	EOR X2_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 5 ,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_1

	LDD KEY, Z+10		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+11
	EOR TEMP_1, KEY

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 4 ,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
	

	

	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LDD KEY, Z+8		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+9
	EOR TEMP_1, KEY

	SUB X0_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_0, TEMP_1

	EOR X0_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 3 ,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_1

	LDD KEY, Z+6		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+7
	EOR TEMP_1, KEY

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 2 ,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1


	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LDD KEY, Z+4		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+5
	EOR TEMP_1, KEY

	SUB X2_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_1, TEMP_1

	EOR X2_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 1 ,X0 = X3 << 8,X1 = X0, X2 = X1, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_0

	LDD KEY, Z+2		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+3
	EOR TEMP_1, KEY

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3
	



	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	LD KEY, Z		// TEMP = TEMP ^ KEY
	EOR TEMP_0, KEY
	LDD KEY, Z+1
	EOR TEMP_1, KEY

	SUB X0_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_1, TEMP_1

	EOR X0_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

					//round 7	 ,X0 = X1 ,X1 = X2, X2 = X3, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_0

			// TEMP = TEMP ^ KEY
	EOR TEMP_0, RK7_0	
	EOR TEMP_1, RK7_1

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 6 ,X0 = X2 ,X1 = X3, X2 = X0 << 8, X3 = X1
	

	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK6_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK6_1

	SUB X2_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_0, TEMP_1

	EOR X2_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 5 ,X0 = X3 ,X1 = X0, X2 = X1 << 8, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_1

	EOR TEMP_0, RK5_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK5_1

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 4 ,X0 = X0 << 8 ,X1 = X1, X2 = X2 << 8, X3 = X3
	

	

	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK4_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK4_1

	SUB X0_1, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_0, TEMP_1

	EOR X0_1, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 3 ,X0 = X1 << 8 ,X1 = X2, X2 = X3 << 8, X3 = X0
	

	LSR X3_1			// x[0] = X[0] >> 1
	BST X3_0, 0
	ROR X3_0
	BLD X3_1, 7
	

	MOV TEMP_0, X0_0	// TEMP = X[1] >> 8
	MOV TEMP_1, X0_1

	EOR TEMP_0, RK3_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK3_1

	SUB X3_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X3_1, TEMP_1

	EOR X3_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 2 ,X0 = X2 << 8 ,X1 = X3, X2 = X0, X3 = X1


	

	MOVW TEMP_0, X3_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK2_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK2_1

	SUB X2_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X2_1, TEMP_1

	EOR X2_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 1 ,X0 = X3 << 8,X1 = X0, X2 = X1, X3 = X2
	

	LSR X1_1			// x[0] = X[0] >> 1
	BST X1_0, 0
	ROR X1_0
	BLD X1_1, 7
	

	MOV TEMP_0, X2_1	// TEMP = X[1] >> 8
	MOV TEMP_1, X2_0

	EOR TEMP_0, RK1_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK1_1

	SUB X1_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X1_1, TEMP_1

	EOR X1_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--

			//round 0 ,X0 = X0 ,X1 = X1, X2 = X2, X3 = X3
	



	MOVW TEMP_0, X1_0

	LSL TEMP_0			//TEMP = X[1] << 1
	ROL TEMP_1
	ADC TEMP_0, R1

	EOR TEMP_0, RK0_0		// TEMP = TEMP ^ KEY
	EOR TEMP_1, RK0_1

	SUB X0_0, TEMP_0	//X[0] = X[0] - TEMP
	SBC X0_1, TEMP_1

	EOR X0_0, CNT	//x[0] ^= CNT
		
	SUBI CNT, 1		// CNT--





	POP R27
	POP R26

	ST X+, X0_0
	ST X+, X0_1
	ST X+, X1_0
	ST X+, X1_1
	ST X+, X2_0
	ST X+, X2_1
	ST X+, X3_0
	ST X+, X3_1

	POP R29
	POP R28
	POP R17
	POP R16
	POP R15
	POP R14
	POP R13
	POP R12
	POP R11
	POP R10
	POP R9
	POP R8
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2	
	POP R0
	

RET