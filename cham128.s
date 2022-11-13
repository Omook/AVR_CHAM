
.global cham128_encrypt
.type cham128_encrypt, @function

#define RK0_0 R0
#define RK0_1 R9
#define RK0_2 R28
#define RK0_3 R4

#define RK1_0 R5
#define RK1_1 R6
#define RK1_2 R7
#define RK1_3 R8


#define KEY R29


#define X0_0 R10
#define X0_1 R11
#define X0_2 R12
#define X0_3 R13
#define X1_0 R14
#define X1_1 R15
#define X1_2 R16
#define X1_3 R17

#define X2_0 R18
#define X2_1 R19
#define X2_2 R20
#define X2_3 R21
#define X3_0 R22
#define X3_1 R23
#define X3_2 R24
#define X3_3 R25

#define TEMP_0 R26
#define TEMP_1 R27
#define TEMP_2 R2
#define TEMP_3 R3







cham128_encrypt:

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
   LD X0_2, X+
   LD X0_3, X+

   LD X1_0, X+
   LD X1_1, X+
   LD X1_2, X+
   LD X1_3, X+

   LD X2_0, X+
   LD X2_1, X+
   LD X2_2, X+
   LD X2_3, X+

   LD X3_0, X+
   LD X3_1, X+
   LD X3_2, X+
   LD X3_3, X+

   LD RK0_0, Z+
   LD RK0_1, Z+
   LD RK0_2, Z+
   LD RK0_3, Z+

   LD RK1_0, Z+
   LD RK1_1, Z+
   LD RK1_2, Z+
   LD RK1_3, Z+

   // 112 round 
  
   MOVW TEMP_0, X1_0	//round0,  temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0		    //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   
   EOR TEMP_0, RK0_0   // temp ^= RK 
   EOR TEMP_1, RK0_1
   EOR TEMP_2, RK0_2
   EOR TEMP_3, RK0_3


   ADD X0_0, TEMP_0    // X[0] += temp
   ADC X0_1, TEMP_1
   ADC X0_2, TEMP_2
   ADC X0_3, TEMP_3

				      // X[0] = X[0] <<< 8 (생략)   direct indexing
   

  
					  // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
      

     
   
  
   MOV TEMP_0, X2_3   //round 1,  temp = X[1] <<< 8
   MOV TEMP_1, X2_0
   MOV TEMP_2, X2_1
   MOV TEMP_3, X2_2

   EOR TEMP_0, RK1_0  // temp ^= RK
   EOR TEMP_1, RK1_1
   EOR TEMP_2, RK1_2
   EOR TEMP_3, RK1_3

   LDI KEY, 1         // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0   // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0           // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

   
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   


   MOVW TEMP_0, X3_0 //round2,  temp = X[1] 
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LD KEY, Z         // temp ^= RK
   EOR TEMP_0, KEY  
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+3
   EOR TEMP_3, KEY
   
   
   LDI KEY, 2        // X[0] ^= ROUND_CNT 
   EOR X2_0, KEY


   ADD X2_0, TEMP_0  // X[0] += temp 
   ADC X2_1, TEMP_1
   ADC X2_2, TEMP_2
   ADC X2_3, TEMP_3

					 // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   


   
   MOV TEMP_0, X0_2  //round 3,  temp = X[1] <<< 8
   MOV TEMP_1, X0_3
   MOV TEMP_2, X0_0
   MOV TEMP_3, X0_1

   LDD KEY, Z+4     // temp ^= RK
   EOR TEMP_0, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+7
   EOR TEMP_3, KEY

   LDI KEY, 3       // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0 // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0         // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   

   MOVW TEMP_0, X1_0 //round4 , temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+8      // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+11
   EOR TEMP_3, KEY
   
   LDI KEY, 4       // X[0] ^= ROUND_CNT 
   EOR X0_3, KEY


   ADD X0_3, TEMP_0 // X[0] += temp
   ADC X0_0, TEMP_1
   ADC X0_1, TEMP_2
   ADC X0_2, TEMP_3

					// X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   

   
   MOV TEMP_0, X2_2 //round 5,  temp = X[1] <<< 8
   MOV TEMP_1, X2_3
   MOV TEMP_2, X2_0
   MOV TEMP_3, X2_1

   LDD KEY, Z+12    // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+15
   EOR TEMP_3, KEY

   LDI KEY, 5       // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0 // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0         // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

                     
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   MOVW TEMP_0, X3_0 //round6, temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+16     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+19
   EOR TEMP_3, KEY
   
   LDI KEY, 6        // X[0] ^= ROUND_CNT 
   EOR X2_3, KEY


   ADD X2_3, TEMP_0  // X[0] += temp
   ADC X2_0, TEMP_1
   ADC X2_1, TEMP_2
   ADC X2_2, TEMP_3

				     // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOV TEMP_0, X0_1  //round 7  temp = X[1] <<< 8
   MOV TEMP_1, X0_2
   MOV TEMP_2, X0_3
   MOV TEMP_3, X0_0

   LDD KEY, Z+20     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+23
   EOR TEMP_3, KEY

   LDI KEY, 7        // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0  // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0          // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
				   	 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
    

  
   MOVW TEMP_0, X1_0 //round8,  temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   
   EOR TEMP_0, RK0_0 // temp ^= RK 
   EOR TEMP_1, RK0_1
   EOR TEMP_2, RK0_2
   EOR TEMP_3, RK0_3

   LDI KEY, 8        // X[0] ^= ROUND_CNT 
   EOR X0_2, KEY


   ADD X0_2, TEMP_0  // X[0] += temp
   ADC X0_3, TEMP_1
   ADC X0_0, TEMP_2
   ADC X0_1, TEMP_3

					 // X[0] = X[0] <<< 8 (생략)   direct indexing
   

  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   
   
  
   MOV TEMP_0, X2_1 //round 9,  temp = X[1] <<< 8
   MOV TEMP_1, X2_2
   MOV TEMP_2, X2_3
   MOV TEMP_3, X2_0

   EOR TEMP_0, RK1_0 // temp ^= RK
   EOR TEMP_1, RK1_1
   EOR TEMP_2, RK1_2
   EOR TEMP_3, RK1_3

   LDI KEY, 9        // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0  // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0          // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

   
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
  

   MOVW TEMP_0, X3_0 //round10,  temp = X[1] 
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LD KEY, Z         // temp ^= RK
   EOR TEMP_0, KEY  
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+3
   EOR TEMP_3, KEY
   
   
   LDI KEY, 10       // X[0] ^= ROUND_CNT 
   EOR X2_2, KEY


   ADD X2_2, TEMP_0  // X[0] += temp 
   ADC X2_3, TEMP_1
   ADC X2_0, TEMP_2
   ADC X2_1, TEMP_3

					 // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
				   	 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOVW TEMP_0, X0_0 //round 11,  temp = X[1] <<< 8   
   MOVW TEMP_2, X0_2
   

   LDD KEY, Z+4      // temp ^= RK
   EOR TEMP_0, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+7
   EOR TEMP_3, KEY

   LDI KEY, 11      // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0 // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0         // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0](생략)   direct indexing
   

   MOVW TEMP_0, X1_0 //round12 , temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0       //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+8     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+11
   EOR TEMP_3, KEY
   
   LDI KEY, 12      // X[0] ^= ROUND_CNT 
   EOR X0_1, KEY


   ADD X0_1, TEMP_0 // X[0] += temp
   ADC X0_2, TEMP_1
   ADC X0_3, TEMP_2
   ADC X0_0, TEMP_3

				    // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOVW TEMP_0, X2_0 //round 13,  temp = X[1] <<< 8   
   MOVW TEMP_2, X2_2
   

   LDD KEY, Z+12     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+15
   EOR TEMP_3, KEY

   LDI KEY, 13       // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0  // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0          // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

                     
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   MOVW TEMP_0, X3_0 //round14, temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+16     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+19
   EOR TEMP_3, KEY
   
   LDI KEY, 14       // X[0] ^= ROUND_CNT 
   EOR X2_1, KEY


   ADD X2_1, TEMP_0  // X[0] += temp
   ADC X2_2, TEMP_1
   ADC X2_3, TEMP_2
   ADC X2_0, TEMP_3

				     // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOV TEMP_0, X0_3  //round 15  temp = X[1] <<< 8
   MOV TEMP_1, X0_0
   MOV TEMP_2, X0_1
   MOV TEMP_3, X0_2

   LDD KEY, Z+20     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+23
   EOR TEMP_3, KEY

   LDI KEY, 15       // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0  // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0          // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   MOVW TEMP_0, X1_0	//round16,  temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0		    //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   
   EOR TEMP_0, RK0_0   // temp ^= RK 
   EOR TEMP_1, RK0_1
   EOR TEMP_2, RK0_2
   EOR TEMP_3, RK0_3

   LDI KEY, 16        // X[0] ^= ROUND_CNT 
   EOR X0_0, KEY


   ADD X0_0, TEMP_0    // X[0] += temp
   ADC X0_1, TEMP_1
   ADC X0_2, TEMP_2
   ADC X0_3, TEMP_3

				      // X[0] = X[0] <<< 8 (생략)   direct indexing
   

  
					  // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
      

     
   
  
   MOV TEMP_0, X2_3   //round 17,  temp = X[1] <<< 8
   MOV TEMP_1, X2_0
   MOV TEMP_2, X2_1
   MOV TEMP_3, X2_2

   EOR TEMP_0, RK1_0  // temp ^= RK
   EOR TEMP_1, RK1_1
   EOR TEMP_2, RK1_2
   EOR TEMP_3, RK1_3

   LDI KEY, 17         // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0   // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0           // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

   
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   


   MOVW TEMP_0, X3_0 //round18,  temp = X[1] 
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LD KEY, Z         // temp ^= RK
   EOR TEMP_0, KEY  
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+3
   EOR TEMP_3, KEY
   
   
   LDI KEY, 18        // X[0] ^= ROUND_CNT 
   EOR X2_0, KEY


   ADD X2_0, TEMP_0  // X[0] += temp 
   ADC X2_1, TEMP_1
   ADC X2_2, TEMP_2
   ADC X2_3, TEMP_3

					 // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   


   
   MOV TEMP_0, X0_2  //round 19,  temp = X[1] <<< 8
   MOV TEMP_1, X0_3
   MOV TEMP_2, X0_0
   MOV TEMP_3, X0_1

   LDD KEY, Z+4     // temp ^= RK
   EOR TEMP_0, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+7
   EOR TEMP_3, KEY

   LDI KEY, 19       // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0 // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0         // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   

   MOVW TEMP_0, X1_0 //round20 , temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+8      // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+11
   EOR TEMP_3, KEY
   
   LDI KEY, 20       // X[0] ^= ROUND_CNT 
   EOR X0_3, KEY


   ADD X0_3, TEMP_0 // X[0] += temp
   ADC X0_0, TEMP_1
   ADC X0_1, TEMP_2
   ADC X0_2, TEMP_3

					// X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   

   
   MOV TEMP_0, X2_2 //round 21,  temp = X[1] <<< 8
   MOV TEMP_1, X2_3
   MOV TEMP_2, X2_0
   MOV TEMP_3, X2_1

   LDD KEY, Z+12    // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+15
   EOR TEMP_3, KEY

   LDI KEY, 21       // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0 // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0         // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

                     
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   MOVW TEMP_0, X3_0 //round22, temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+16     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+19
   EOR TEMP_3, KEY
   
   LDI KEY, 22        // X[0] ^= ROUND_CNT 
   EOR X2_3, KEY


   ADD X2_3, TEMP_0  // X[0] += temp
   ADC X2_0, TEMP_1
   ADC X2_1, TEMP_2
   ADC X2_2, TEMP_3

				     // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOV TEMP_0, X0_1  //round 23  temp = X[1] <<< 8
   MOV TEMP_1, X0_2
   MOV TEMP_2, X0_3
   MOV TEMP_3, X0_0

   LDD KEY, Z+20     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+23
   EOR TEMP_3, KEY

   LDI KEY, 23        // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0  // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0          // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
				   	 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
    

  
   MOVW TEMP_0, X1_0 //round24,  temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   
   EOR TEMP_0, RK0_0 // temp ^= RK 
   EOR TEMP_1, RK0_1
   EOR TEMP_2, RK0_2
   EOR TEMP_3, RK0_3

   LDI KEY, 24        // X[0] ^= ROUND_CNT 
   EOR X0_2, KEY


   ADD X0_2, TEMP_0  // X[0] += temp
   ADC X0_3, TEMP_1
   ADC X0_0, TEMP_2
   ADC X0_1, TEMP_3

					 // X[0] = X[0] <<< 8 (생략)   direct indexing
   

  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   
   
  
   MOV TEMP_0, X2_1 //round 25,  temp = X[1] <<< 8
   MOV TEMP_1, X2_2
   MOV TEMP_2, X2_3
   MOV TEMP_3, X2_0

   EOR TEMP_0, RK1_0 // temp ^= RK
   EOR TEMP_1, RK1_1
   EOR TEMP_2, RK1_2
   EOR TEMP_3, RK1_3

   LDI KEY, 25        // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0  // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0          // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

   
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
  

   MOVW TEMP_0, X3_0 //round26,  temp = X[1] 
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LD KEY, Z         // temp ^= RK
   EOR TEMP_0, KEY  
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+3
   EOR TEMP_3, KEY
   
   
   LDI KEY, 26       // X[0] ^= ROUND_CNT 
   EOR X2_2, KEY


   ADD X2_2, TEMP_0  // X[0] += temp 
   ADC X2_3, TEMP_1
   ADC X2_0, TEMP_2
   ADC X2_1, TEMP_3

					 // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
				   	 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOVW TEMP_0, X0_0 //round 27,  temp = X[1] <<< 8   
   MOVW TEMP_2, X0_2
   

   LDD KEY, Z+4      // temp ^= RK
   EOR TEMP_0, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+7
   EOR TEMP_3, KEY

   LDI KEY, 27      // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0 // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0         // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0](생략)   direct indexing
   

   MOVW TEMP_0, X1_0 //round28 , temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0       //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+8     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+11
   EOR TEMP_3, KEY
   
   LDI KEY, 28      // X[0] ^= ROUND_CNT 
   EOR X0_1, KEY


   ADD X0_1, TEMP_0 // X[0] += temp
   ADC X0_2, TEMP_1
   ADC X0_3, TEMP_2
   ADC X0_0, TEMP_3

				    // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOVW TEMP_0, X2_0 //round 29,  temp = X[1] <<< 8   
   MOVW TEMP_2, X2_2
   

   LDD KEY, Z+12     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+15
   EOR TEMP_3, KEY

   LDI KEY, 29       // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0  // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0          // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

                     
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   MOVW TEMP_0, X3_0 //round30, temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+16     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+19
   EOR TEMP_3, KEY
   
   LDI KEY, 30       // X[0] ^= ROUND_CNT 
   EOR X2_1, KEY


   ADD X2_1, TEMP_0  // X[0] += temp
   ADC X2_2, TEMP_1
   ADC X2_3, TEMP_2
   ADC X2_0, TEMP_3

				     // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOV TEMP_0, X0_3  //round 31  temp = X[1] <<< 8
   MOV TEMP_1, X0_0
   MOV TEMP_2, X0_1
   MOV TEMP_3, X0_2

   LDD KEY, Z+20     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+23
   EOR TEMP_3, KEY

   LDI KEY, 31       // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0  // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0          // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   MOVW TEMP_0, X1_0	//round32,  temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0		    //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   
   EOR TEMP_0, RK0_0   // temp ^= RK 
   EOR TEMP_1, RK0_1
   EOR TEMP_2, RK0_2
   EOR TEMP_3, RK0_3

   LDI KEY, 32        // X[0] ^= ROUND_CNT 
   EOR X0_0, KEY


   ADD X0_0, TEMP_0    // X[0] += temp
   ADC X0_1, TEMP_1
   ADC X0_2, TEMP_2
   ADC X0_3, TEMP_3

				      // X[0] = X[0] <<< 8 (생략)   direct indexing
   

  
					  // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
      

     
   
  
   MOV TEMP_0, X2_3   //round 33,  temp = X[1] <<< 8
   MOV TEMP_1, X2_0
   MOV TEMP_2, X2_1
   MOV TEMP_3, X2_2

   EOR TEMP_0, RK1_0  // temp ^= RK
   EOR TEMP_1, RK1_1
   EOR TEMP_2, RK1_2
   EOR TEMP_3, RK1_3

   LDI KEY, 33         // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0   // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0           // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

   
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   


   MOVW TEMP_0, X3_0 //round34,  temp = X[1] 
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LD KEY, Z         // temp ^= RK
   EOR TEMP_0, KEY  
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+3
   EOR TEMP_3, KEY
   
   
   LDI KEY, 34        // X[0] ^= ROUND_CNT 
   EOR X2_0, KEY


   ADD X2_0, TEMP_0  // X[0] += temp 
   ADC X2_1, TEMP_1
   ADC X2_2, TEMP_2
   ADC X2_3, TEMP_3

					 // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   


   
   MOV TEMP_0, X0_2  //round 35,  temp = X[1] <<< 8
   MOV TEMP_1, X0_3
   MOV TEMP_2, X0_0
   MOV TEMP_3, X0_1

   LDD KEY, Z+4     // temp ^= RK
   EOR TEMP_0, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+7
   EOR TEMP_3, KEY

   LDI KEY, 35       // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0 // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0         // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   

   MOVW TEMP_0, X1_0 //round36 , temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+8      // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+11
   EOR TEMP_3, KEY
   
   LDI KEY, 36       // X[0] ^= ROUND_CNT 
   EOR X0_3, KEY


   ADD X0_3, TEMP_0 // X[0] += temp
   ADC X0_0, TEMP_1
   ADC X0_1, TEMP_2
   ADC X0_2, TEMP_3

					// X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   

   
   MOV TEMP_0, X2_2 //round 37,  temp = X[1] <<< 8
   MOV TEMP_1, X2_3
   MOV TEMP_2, X2_0
   MOV TEMP_3, X2_1

   LDD KEY, Z+12    // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+15
   EOR TEMP_3, KEY

   LDI KEY, 37       // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0 // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0         // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

                     
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   MOVW TEMP_0, X3_0 //round38, temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+16     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+19
   EOR TEMP_3, KEY
   
   LDI KEY, 38        // X[0] ^= ROUND_CNT 
   EOR X2_3, KEY


   ADD X2_3, TEMP_0  // X[0] += temp
   ADC X2_0, TEMP_1
   ADC X2_1, TEMP_2
   ADC X2_2, TEMP_3

				     // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOV TEMP_0, X0_1  //round 39  temp = X[1] <<< 8
   MOV TEMP_1, X0_2
   MOV TEMP_2, X0_3
   MOV TEMP_3, X0_0

   LDD KEY, Z+20     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+23
   EOR TEMP_3, KEY

   LDI KEY, 39        // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0  // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0          // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
				   	 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
    

  
   MOVW TEMP_0, X1_0 //round40,  temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   
   EOR TEMP_0, RK0_0 // temp ^= RK 
   EOR TEMP_1, RK0_1
   EOR TEMP_2, RK0_2
   EOR TEMP_3, RK0_3

   LDI KEY, 40        // X[0] ^= ROUND_CNT 
   EOR X0_2, KEY


   ADD X0_2, TEMP_0  // X[0] += temp
   ADC X0_3, TEMP_1
   ADC X0_0, TEMP_2
   ADC X0_1, TEMP_3

					 // X[0] = X[0] <<< 8 (생략)   direct indexing
   

  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   
   
  
   MOV TEMP_0, X2_1 //round 41,  temp = X[1] <<< 8
   MOV TEMP_1, X2_2
   MOV TEMP_2, X2_3
   MOV TEMP_3, X2_0

   EOR TEMP_0, RK1_0 // temp ^= RK
   EOR TEMP_1, RK1_1
   EOR TEMP_2, RK1_2
   EOR TEMP_3, RK1_3

   LDI KEY, 41        // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0  // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0          // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

   
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
  

   MOVW TEMP_0, X3_0 //round42,  temp = X[1] 
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LD KEY, Z         // temp ^= RK
   EOR TEMP_0, KEY  
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+3
   EOR TEMP_3, KEY
   
   
   LDI KEY, 42       // X[0] ^= ROUND_CNT 
   EOR X2_2, KEY


   ADD X2_2, TEMP_0  // X[0] += temp 
   ADC X2_3, TEMP_1
   ADC X2_0, TEMP_2
   ADC X2_1, TEMP_3

					 // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
				   	 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOVW TEMP_0, X0_0 //round 43,  temp = X[1] <<< 8   
   MOVW TEMP_2, X0_2
   

   LDD KEY, Z+4      // temp ^= RK
   EOR TEMP_0, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+7
   EOR TEMP_3, KEY

   LDI KEY, 43      // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0 // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0         // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0](생략)   direct indexing
   

   MOVW TEMP_0, X1_0 //round44 , temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0       //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+8     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+11
   EOR TEMP_3, KEY
   
   LDI KEY, 44      // X[0] ^= ROUND_CNT 
   EOR X0_1, KEY


   ADD X0_1, TEMP_0 // X[0] += temp
   ADC X0_2, TEMP_1
   ADC X0_3, TEMP_2
   ADC X0_0, TEMP_3

				    // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOVW TEMP_0, X2_0 //round 45,  temp = X[1] <<< 8   
   MOVW TEMP_2, X2_2
   

   LDD KEY, Z+12     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+15
   EOR TEMP_3, KEY

   LDI KEY, 45       // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0  // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0          // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

                     
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   MOVW TEMP_0, X3_0 //round46, temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+16     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+19
   EOR TEMP_3, KEY
   
   LDI KEY, 46       // X[0] ^= ROUND_CNT 
   EOR X2_1, KEY


   ADD X2_1, TEMP_0  // X[0] += temp
   ADC X2_2, TEMP_1
   ADC X2_3, TEMP_2
   ADC X2_0, TEMP_3

				     // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOV TEMP_0, X0_3  //round 47  temp = X[1] <<< 8
   MOV TEMP_1, X0_0
   MOV TEMP_2, X0_1
   MOV TEMP_3, X0_2

   LDD KEY, Z+20     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+23
   EOR TEMP_3, KEY

   LDI KEY, 47       // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0  // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0          // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing

   MOVW TEMP_0, X1_0	//round48,  temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0		    //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   
   EOR TEMP_0, RK0_0   // temp ^= RK 
   EOR TEMP_1, RK0_1
   EOR TEMP_2, RK0_2
   EOR TEMP_3, RK0_3

   LDI KEY, 48        // X[0] ^= ROUND_CNT 
   EOR X0_0, KEY


   ADD X0_0, TEMP_0    // X[0] += temp
   ADC X0_1, TEMP_1
   ADC X0_2, TEMP_2
   ADC X0_3, TEMP_3

				      // X[0] = X[0] <<< 8 (생략)   direct indexing
   

  
					  // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
      

     
   
  
   MOV TEMP_0, X2_3   //round 49,  temp = X[1] <<< 8
   MOV TEMP_1, X2_0
   MOV TEMP_2, X2_1
   MOV TEMP_3, X2_2

   EOR TEMP_0, RK1_0  // temp ^= RK
   EOR TEMP_1, RK1_1
   EOR TEMP_2, RK1_2
   EOR TEMP_3, RK1_3

   LDI KEY, 49         // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0   // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0           // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

   
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   


   MOVW TEMP_0, X3_0 //round50,  temp = X[1] 
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LD KEY, Z         // temp ^= RK
   EOR TEMP_0, KEY  
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+3
   EOR TEMP_3, KEY
   
   
   LDI KEY, 50        // X[0] ^= ROUND_CNT 
   EOR X2_0, KEY


   ADD X2_0, TEMP_0  // X[0] += temp 
   ADC X2_1, TEMP_1
   ADC X2_2, TEMP_2
   ADC X2_3, TEMP_3

					 // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   


   
   MOV TEMP_0, X0_2  //round 51,  temp = X[1] <<< 8
   MOV TEMP_1, X0_3
   MOV TEMP_2, X0_0
   MOV TEMP_3, X0_1

   LDD KEY, Z+4     // temp ^= RK
   EOR TEMP_0, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+7
   EOR TEMP_3, KEY

   LDI KEY, 51       // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0 // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0         // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   

   MOVW TEMP_0, X1_0 //round52 , temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+8      // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+11
   EOR TEMP_3, KEY
   
   LDI KEY, 52       // X[0] ^= ROUND_CNT 
   EOR X0_3, KEY


   ADD X0_3, TEMP_0 // X[0] += temp
   ADC X0_0, TEMP_1
   ADC X0_1, TEMP_2
   ADC X0_2, TEMP_3

					// X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   

   
   MOV TEMP_0, X2_2 //round 53,  temp = X[1] <<< 8
   MOV TEMP_1, X2_3
   MOV TEMP_2, X2_0
   MOV TEMP_3, X2_1

   LDD KEY, Z+12    // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+15
   EOR TEMP_3, KEY

   LDI KEY, 53       // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0 // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0         // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

                     
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   MOVW TEMP_0, X3_0 //round54, temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+16     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+19
   EOR TEMP_3, KEY
   
   LDI KEY, 54        // X[0] ^= ROUND_CNT 
   EOR X2_3, KEY


   ADD X2_3, TEMP_0  // X[0] += temp
   ADC X2_0, TEMP_1
   ADC X2_1, TEMP_2
   ADC X2_2, TEMP_3

				     // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOV TEMP_0, X0_1  //round 55  temp = X[1] <<< 8
   MOV TEMP_1, X0_2
   MOV TEMP_2, X0_3
   MOV TEMP_3, X0_0

   LDD KEY, Z+20     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+23
   EOR TEMP_3, KEY

   LDI KEY, 55        // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0  // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0          // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
				   	 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
    

  
   MOVW TEMP_0, X1_0 //round56,  temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   
   EOR TEMP_0, RK0_0 // temp ^= RK 
   EOR TEMP_1, RK0_1
   EOR TEMP_2, RK0_2
   EOR TEMP_3, RK0_3

   LDI KEY, 56        // X[0] ^= ROUND_CNT 
   EOR X0_2, KEY


   ADD X0_2, TEMP_0  // X[0] += temp
   ADC X0_3, TEMP_1
   ADC X0_0, TEMP_2
   ADC X0_1, TEMP_3

					 // X[0] = X[0] <<< 8 (생략)   direct indexing
   

  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   
   
  
   MOV TEMP_0, X2_1 //round 57,  temp = X[1] <<< 8
   MOV TEMP_1, X2_2
   MOV TEMP_2, X2_3
   MOV TEMP_3, X2_0

   EOR TEMP_0, RK1_0 // temp ^= RK
   EOR TEMP_1, RK1_1
   EOR TEMP_2, RK1_2
   EOR TEMP_3, RK1_3

   LDI KEY, 57        // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0  // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0          // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

   
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
  

   MOVW TEMP_0, X3_0 //round58,  temp = X[1] 
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LD KEY, Z         // temp ^= RK
   EOR TEMP_0, KEY  
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+3
   EOR TEMP_3, KEY
   
   
   LDI KEY, 58       // X[0] ^= ROUND_CNT 
   EOR X2_2, KEY


   ADD X2_2, TEMP_0  // X[0] += temp 
   ADC X2_3, TEMP_1
   ADC X2_0, TEMP_2
   ADC X2_1, TEMP_3

					 // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
				   	 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOVW TEMP_0, X0_0 //round 59,  temp = X[1] <<< 8   
   MOVW TEMP_2, X0_2
   

   LDD KEY, Z+4      // temp ^= RK
   EOR TEMP_0, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+7
   EOR TEMP_3, KEY

   LDI KEY, 59      // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0 // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0         // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0](생략)   direct indexing
   

   MOVW TEMP_0, X1_0 //round60 , temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0       //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+8     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+11
   EOR TEMP_3, KEY
   
   LDI KEY, 60      // X[0] ^= ROUND_CNT 
   EOR X0_1, KEY


   ADD X0_1, TEMP_0 // X[0] += temp
   ADC X0_2, TEMP_1
   ADC X0_3, TEMP_2
   ADC X0_0, TEMP_3

				    // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOVW TEMP_0, X2_0 //round 61,  temp = X[1] <<< 8   
   MOVW TEMP_2, X2_2
   

   LDD KEY, Z+12     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+15
   EOR TEMP_3, KEY

   LDI KEY, 61       // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0  // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0          // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

                     
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   MOVW TEMP_0, X3_0 //round62, temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+16     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+19
   EOR TEMP_3, KEY
   
   LDI KEY, 62       // X[0] ^= ROUND_CNT 
   EOR X2_1, KEY


   ADD X2_1, TEMP_0  // X[0] += temp
   ADC X2_2, TEMP_1
   ADC X2_3, TEMP_2
   ADC X2_0, TEMP_3

				     // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOV TEMP_0, X0_3  //round 63  temp = X[1] <<< 8
   MOV TEMP_1, X0_0
   MOV TEMP_2, X0_1
   MOV TEMP_3, X0_2

   LDD KEY, Z+20     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+23
   EOR TEMP_3, KEY

   LDI KEY, 63       // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0  // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0          // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   MOVW TEMP_0, X1_0	//round64,  temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0		    //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   
   EOR TEMP_0, RK0_0   // temp ^= RK 
   EOR TEMP_1, RK0_1
   EOR TEMP_2, RK0_2
   EOR TEMP_3, RK0_3

   LDI KEY, 64        // X[0] ^= ROUND_CNT 
   EOR X0_0, KEY


   ADD X0_0, TEMP_0    // X[0] += temp
   ADC X0_1, TEMP_1
   ADC X0_2, TEMP_2
   ADC X0_3, TEMP_3

				      // X[0] = X[0] <<< 8 (생략)   direct indexing
   

  
					  // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
      

     
   
  
   MOV TEMP_0, X2_3   //round 65,  temp = X[1] <<< 8
   MOV TEMP_1, X2_0
   MOV TEMP_2, X2_1
   MOV TEMP_3, X2_2

   EOR TEMP_0, RK1_0  // temp ^= RK
   EOR TEMP_1, RK1_1
   EOR TEMP_2, RK1_2
   EOR TEMP_3, RK1_3

   LDI KEY, 65         // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0   // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0           // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

   
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   


   MOVW TEMP_0, X3_0 //round66,  temp = X[1] 
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LD KEY, Z         // temp ^= RK
   EOR TEMP_0, KEY  
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+3
   EOR TEMP_3, KEY
   
   
   LDI KEY, 66        // X[0] ^= ROUND_CNT 
   EOR X2_0, KEY


   ADD X2_0, TEMP_0  // X[0] += temp 
   ADC X2_1, TEMP_1
   ADC X2_2, TEMP_2
   ADC X2_3, TEMP_3

					 // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   


   
   MOV TEMP_0, X0_2  //round 67,  temp = X[1] <<< 8
   MOV TEMP_1, X0_3
   MOV TEMP_2, X0_0
   MOV TEMP_3, X0_1

   LDD KEY, Z+4     // temp ^= RK
   EOR TEMP_0, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+7
   EOR TEMP_3, KEY

   LDI KEY, 67       // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0 // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0         // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   

   MOVW TEMP_0, X1_0 //round68 , temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+8      // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+11
   EOR TEMP_3, KEY
   
   LDI KEY, 68       // X[0] ^= ROUND_CNT 
   EOR X0_3, KEY


   ADD X0_3, TEMP_0 // X[0] += temp
   ADC X0_0, TEMP_1
   ADC X0_1, TEMP_2
   ADC X0_2, TEMP_3

					// X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   

   
   MOV TEMP_0, X2_2 //round 69,  temp = X[1] <<< 8
   MOV TEMP_1, X2_3
   MOV TEMP_2, X2_0
   MOV TEMP_3, X2_1

   LDD KEY, Z+12    // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+15
   EOR TEMP_3, KEY

   LDI KEY, 69       // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0 // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0         // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

                     
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   MOVW TEMP_0, X3_0 //round70, temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+16     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+19
   EOR TEMP_3, KEY
   
   LDI KEY, 70        // X[0] ^= ROUND_CNT 
   EOR X2_3, KEY


   ADD X2_3, TEMP_0  // X[0] += temp
   ADC X2_0, TEMP_1
   ADC X2_1, TEMP_2
   ADC X2_2, TEMP_3

				     // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOV TEMP_0, X0_1  //round 71  temp = X[1] <<< 8
   MOV TEMP_1, X0_2
   MOV TEMP_2, X0_3
   MOV TEMP_3, X0_0

   LDD KEY, Z+20     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+23
   EOR TEMP_3, KEY

   LDI KEY, 71        // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0  // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0          // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
				   	 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
    

  
   MOVW TEMP_0, X1_0 //round72,  temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   
   EOR TEMP_0, RK0_0 // temp ^= RK 
   EOR TEMP_1, RK0_1
   EOR TEMP_2, RK0_2
   EOR TEMP_3, RK0_3

   LDI KEY, 72        // X[0] ^= ROUND_CNT 
   EOR X0_2, KEY


   ADD X0_2, TEMP_0  // X[0] += temp
   ADC X0_3, TEMP_1
   ADC X0_0, TEMP_2
   ADC X0_1, TEMP_3

					 // X[0] = X[0] <<< 8 (생략)   direct indexing
   

  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   
   
  
   MOV TEMP_0, X2_1 //round 73,  temp = X[1] <<< 8
   MOV TEMP_1, X2_2
   MOV TEMP_2, X2_3
   MOV TEMP_3, X2_0

   EOR TEMP_0, RK1_0 // temp ^= RK
   EOR TEMP_1, RK1_1
   EOR TEMP_2, RK1_2
   EOR TEMP_3, RK1_3

   LDI KEY, 73        // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0  // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0          // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

   
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
  

   MOVW TEMP_0, X3_0 //round74,  temp = X[1] 
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LD KEY, Z         // temp ^= RK
   EOR TEMP_0, KEY  
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+3
   EOR TEMP_3, KEY
   
   
   LDI KEY, 74       // X[0] ^= ROUND_CNT 
   EOR X2_2, KEY


   ADD X2_2, TEMP_0  // X[0] += temp 
   ADC X2_3, TEMP_1
   ADC X2_0, TEMP_2
   ADC X2_1, TEMP_3

					 // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
				   	 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOVW TEMP_0, X0_0 //round 75,  temp = X[1] <<< 8   
   MOVW TEMP_2, X0_2
   

   LDD KEY, Z+4      // temp ^= RK
   EOR TEMP_0, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+7
   EOR TEMP_3, KEY

   LDI KEY, 75      // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0 // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0         // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0](생략)   direct indexing
   

   MOVW TEMP_0, X1_0 //round76 , temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0       //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+8     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+11
   EOR TEMP_3, KEY
   
   LDI KEY, 76      // X[0] ^= ROUND_CNT 
   EOR X0_1, KEY


   ADD X0_1, TEMP_0 // X[0] += temp
   ADC X0_2, TEMP_1
   ADC X0_3, TEMP_2
   ADC X0_0, TEMP_3

				    // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOVW TEMP_0, X2_0 //round 77,  temp = X[1] <<< 8   
   MOVW TEMP_2, X2_2
   

   LDD KEY, Z+12     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+15
   EOR TEMP_3, KEY

   LDI KEY, 77       // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0  // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0          // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

                     
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   MOVW TEMP_0, X3_0 //round78, temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+16     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+19
   EOR TEMP_3, KEY
   
   LDI KEY, 78       // X[0] ^= ROUND_CNT 
   EOR X2_1, KEY


   ADD X2_1, TEMP_0  // X[0] += temp
   ADC X2_2, TEMP_1
   ADC X2_3, TEMP_2
   ADC X2_0, TEMP_3

				     // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOV TEMP_0, X0_3  //round 79  temp = X[1] <<< 8
   MOV TEMP_1, X0_0
   MOV TEMP_2, X0_1
   MOV TEMP_3, X0_2

   LDD KEY, Z+20     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+23
   EOR TEMP_3, KEY

   LDI KEY, 79       // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0  // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0          // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   MOVW TEMP_0, X1_0	//round80,  temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0		    //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   
   EOR TEMP_0, RK0_0   // temp ^= RK 
   EOR TEMP_1, RK0_1
   EOR TEMP_2, RK0_2
   EOR TEMP_3, RK0_3

   LDI KEY, 80        // X[0] ^= ROUND_CNT 
   EOR X0_0, KEY


   ADD X0_0, TEMP_0    // X[0] += temp
   ADC X0_1, TEMP_1
   ADC X0_2, TEMP_2
   ADC X0_3, TEMP_3

				      // X[0] = X[0] <<< 8 (생략)   direct indexing
   

  
					  // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
      

     
   
  
   MOV TEMP_0, X2_3   //round 81,  temp = X[1] <<< 8
   MOV TEMP_1, X2_0
   MOV TEMP_2, X2_1
   MOV TEMP_3, X2_2

   EOR TEMP_0, RK1_0  // temp ^= RK
   EOR TEMP_1, RK1_1
   EOR TEMP_2, RK1_2
   EOR TEMP_3, RK1_3

   LDI KEY, 81         // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0   // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0           // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

   
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   


   MOVW TEMP_0, X3_0 //round82,  temp = X[1] 
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LD KEY, Z         // temp ^= RK
   EOR TEMP_0, KEY  
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+3
   EOR TEMP_3, KEY
   
   
   LDI KEY, 82        // X[0] ^= ROUND_CNT 
   EOR X2_0, KEY


   ADD X2_0, TEMP_0  // X[0] += temp 
   ADC X2_1, TEMP_1
   ADC X2_2, TEMP_2
   ADC X2_3, TEMP_3

					 // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   


   
   MOV TEMP_0, X0_2  //round 83,  temp = X[1] <<< 8
   MOV TEMP_1, X0_3
   MOV TEMP_2, X0_0
   MOV TEMP_3, X0_1

   LDD KEY, Z+4     // temp ^= RK
   EOR TEMP_0, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+7
   EOR TEMP_3, KEY

   LDI KEY, 83       // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0 // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0         // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   

   MOVW TEMP_0, X1_0 //round84 , temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+8      // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+11
   EOR TEMP_3, KEY
   
   LDI KEY, 84       // X[0] ^= ROUND_CNT 
   EOR X0_3, KEY


   ADD X0_3, TEMP_0 // X[0] += temp
   ADC X0_0, TEMP_1
   ADC X0_1, TEMP_2
   ADC X0_2, TEMP_3

					// X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   

   
   MOV TEMP_0, X2_2 //round 85,  temp = X[1] <<< 8
   MOV TEMP_1, X2_3
   MOV TEMP_2, X2_0
   MOV TEMP_3, X2_1

   LDD KEY, Z+12    // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+15
   EOR TEMP_3, KEY

   LDI KEY, 85       // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0 // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0         // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

                     
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   MOVW TEMP_0, X3_0 //round86, temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+16     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+19
   EOR TEMP_3, KEY
   
   LDI KEY, 86        // X[0] ^= ROUND_CNT 
   EOR X2_3, KEY


   ADD X2_3, TEMP_0  // X[0] += temp
   ADC X2_0, TEMP_1
   ADC X2_1, TEMP_2
   ADC X2_2, TEMP_3

				     // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOV TEMP_0, X0_1  //round 87  temp = X[1] <<< 8
   MOV TEMP_1, X0_2
   MOV TEMP_2, X0_3
   MOV TEMP_3, X0_0

   LDD KEY, Z+20     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+23
   EOR TEMP_3, KEY

   LDI KEY, 87        // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0  // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0          // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
				   	 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
    

  
   MOVW TEMP_0, X1_0 //round88,  temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   
   EOR TEMP_0, RK0_0 // temp ^= RK 
   EOR TEMP_1, RK0_1
   EOR TEMP_2, RK0_2
   EOR TEMP_3, RK0_3

   LDI KEY, 88        // X[0] ^= ROUND_CNT 
   EOR X0_2, KEY


   ADD X0_2, TEMP_0  // X[0] += temp
   ADC X0_3, TEMP_1
   ADC X0_0, TEMP_2
   ADC X0_1, TEMP_3

					 // X[0] = X[0] <<< 8 (생략)   direct indexing
   

  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   
   
  
   MOV TEMP_0, X2_1 //round 89,  temp = X[1] <<< 8
   MOV TEMP_1, X2_2
   MOV TEMP_2, X2_3
   MOV TEMP_3, X2_0

   EOR TEMP_0, RK1_0 // temp ^= RK
   EOR TEMP_1, RK1_1
   EOR TEMP_2, RK1_2
   EOR TEMP_3, RK1_3

   LDI KEY, 89        // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0  // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0          // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

   
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
  

   MOVW TEMP_0, X3_0 //round90,  temp = X[1] 
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LD KEY, Z         // temp ^= RK
   EOR TEMP_0, KEY  
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+3
   EOR TEMP_3, KEY
   
   
   LDI KEY, 90       // X[0] ^= ROUND_CNT 
   EOR X2_2, KEY


   ADD X2_2, TEMP_0  // X[0] += temp 
   ADC X2_3, TEMP_1
   ADC X2_0, TEMP_2
   ADC X2_1, TEMP_3

					 // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
				   	 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOVW TEMP_0, X0_0 //round 91,  temp = X[1] <<< 8   
   MOVW TEMP_2, X0_2
   

   LDD KEY, Z+4      // temp ^= RK
   EOR TEMP_0, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+7
   EOR TEMP_3, KEY

   LDI KEY, 91      // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0 // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0         // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0](생략)   direct indexing
   

   MOVW TEMP_0, X1_0 //round92 , temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0       //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+8     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+11
   EOR TEMP_3, KEY
   
   LDI KEY, 92      // X[0] ^= ROUND_CNT 
   EOR X0_1, KEY


   ADD X0_1, TEMP_0 // X[0] += temp
   ADC X0_2, TEMP_1
   ADC X0_3, TEMP_2
   ADC X0_0, TEMP_3

				    // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOVW TEMP_0, X2_0 //round 93,  temp = X[1] <<< 8   
   MOVW TEMP_2, X2_2
   

   LDD KEY, Z+12     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+15
   EOR TEMP_3, KEY

   LDI KEY, 93       // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0  // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0          // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

                     
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   MOVW TEMP_0, X3_0 //round94, temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+16     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+19
   EOR TEMP_3, KEY
   
   LDI KEY, 94       // X[0] ^= ROUND_CNT 
   EOR X2_1, KEY


   ADD X2_1, TEMP_0  // X[0] += temp
   ADC X2_2, TEMP_1
   ADC X2_3, TEMP_2
   ADC X2_0, TEMP_3

				     // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOV TEMP_0, X0_3  //round 95  temp = X[1] <<< 8
   MOV TEMP_1, X0_0
   MOV TEMP_2, X0_1
   MOV TEMP_3, X0_2

   LDD KEY, Z+20     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+23
   EOR TEMP_3, KEY

   LDI KEY, 95       // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0  // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0          // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   MOVW TEMP_0, X1_0	//round96,  temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0		    //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   
   EOR TEMP_0, RK0_0   // temp ^= RK 
   EOR TEMP_1, RK0_1
   EOR TEMP_2, RK0_2
   EOR TEMP_3, RK0_3

   LDI KEY, 96        // X[0] ^= ROUND_CNT 
   EOR X0_0, KEY


   ADD X0_0, TEMP_0    // X[0] += temp
   ADC X0_1, TEMP_1
   ADC X0_2, TEMP_2
   ADC X0_3, TEMP_3

				      // X[0] = X[0] <<< 8 (생략)   direct indexing
   

  
					  // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
      

     
   
  
   MOV TEMP_0, X2_3   //round 97,  temp = X[1] <<< 8
   MOV TEMP_1, X2_0
   MOV TEMP_2, X2_1
   MOV TEMP_3, X2_2

   EOR TEMP_0, RK1_0  // temp ^= RK
   EOR TEMP_1, RK1_1
   EOR TEMP_2, RK1_2
   EOR TEMP_3, RK1_3

   LDI KEY, 97         // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0   // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0           // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

   
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   


   MOVW TEMP_0, X3_0 //round98,  temp = X[1] 
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LD KEY, Z         // temp ^= RK
   EOR TEMP_0, KEY  
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+3
   EOR TEMP_3, KEY
   
   
   LDI KEY, 98        // X[0] ^= ROUND_CNT 
   EOR X2_0, KEY


   ADD X2_0, TEMP_0  // X[0] += temp 
   ADC X2_1, TEMP_1
   ADC X2_2, TEMP_2
   ADC X2_3, TEMP_3

					 // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   


   
   MOV TEMP_0, X0_2  //round 99,  temp = X[1] <<< 8
   MOV TEMP_1, X0_3
   MOV TEMP_2, X0_0
   MOV TEMP_3, X0_1

   LDD KEY, Z+4     // temp ^= RK
   EOR TEMP_0, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+7
   EOR TEMP_3, KEY

   LDI KEY, 99       // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0 // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0         // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   

   MOVW TEMP_0, X1_0 //round100 , temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+8      // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+11
   EOR TEMP_3, KEY
   
   LDI KEY, 100       // X[0] ^= ROUND_CNT 
   EOR X0_3, KEY


   ADD X0_3, TEMP_0 // X[0] += temp
   ADC X0_0, TEMP_1
   ADC X0_1, TEMP_2
   ADC X0_2, TEMP_3

					// X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   

   
   MOV TEMP_0, X2_2 //round 101,  temp = X[1] <<< 8
   MOV TEMP_1, X2_3
   MOV TEMP_2, X2_0
   MOV TEMP_3, X2_1

   LDD KEY, Z+12    // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+15
   EOR TEMP_3, KEY

   LDI KEY, 101       // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0 // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0         // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

                     
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   MOVW TEMP_0, X3_0 //round102, temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+16     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+19
   EOR TEMP_3, KEY
   
   LDI KEY, 102        // X[0] ^= ROUND_CNT 
   EOR X2_3, KEY


   ADD X2_3, TEMP_0  // X[0] += temp
   ADC X2_0, TEMP_1
   ADC X2_1, TEMP_2
   ADC X2_2, TEMP_3

				     // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOV TEMP_0, X0_1  //round 103  temp = X[1] <<< 8
   MOV TEMP_1, X0_2
   MOV TEMP_2, X0_3
   MOV TEMP_3, X0_0

   LDD KEY, Z+20     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+23
   EOR TEMP_3, KEY

   LDI KEY, 103        // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0  // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0          // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
				   	 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
    

  
   MOVW TEMP_0, X1_0 //round104,  temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   
   EOR TEMP_0, RK0_0 // temp ^= RK 
   EOR TEMP_1, RK0_1
   EOR TEMP_2, RK0_2
   EOR TEMP_3, RK0_3

   LDI KEY, 104        // X[0] ^= ROUND_CNT 
   EOR X0_2, KEY


   ADD X0_2, TEMP_0  // X[0] += temp
   ADC X0_3, TEMP_1
   ADC X0_0, TEMP_2
   ADC X0_1, TEMP_3

					 // X[0] = X[0] <<< 8 (생략)   direct indexing
   

  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   
   
  
   MOV TEMP_0, X2_1 //round 105,  temp = X[1] <<< 8
   MOV TEMP_1, X2_2
   MOV TEMP_2, X2_3
   MOV TEMP_3, X2_0

   EOR TEMP_0, RK1_0 // temp ^= RK
   EOR TEMP_1, RK1_1
   EOR TEMP_2, RK1_2
   EOR TEMP_3, RK1_3

   LDI KEY, 105        // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0  // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0          // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

   
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
  

   MOVW TEMP_0, X3_0 //round106,  temp = X[1] 
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LD KEY, Z         // temp ^= RK
   EOR TEMP_0, KEY  
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+3
   EOR TEMP_3, KEY
   
   
   LDI KEY, 106       // X[0] ^= ROUND_CNT 
   EOR X2_2, KEY


   ADD X2_2, TEMP_0  // X[0] += temp 
   ADC X2_3, TEMP_1
   ADC X2_0, TEMP_2
   ADC X2_1, TEMP_3

					 // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
				   	 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOVW TEMP_0, X0_0 //round 107,  temp = X[1] <<< 8   
   MOVW TEMP_2, X0_2
   

   LDD KEY, Z+4      // temp ^= RK
   EOR TEMP_0, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+7
   EOR TEMP_3, KEY

   LDI KEY, 107      // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0 // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0         // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0](생략)   direct indexing
   

   MOVW TEMP_0, X1_0 //round108 , temp = X[1] 
   MOVW TEMP_2, X1_2

   LSL TEMP_0       //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+8     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+11
   EOR TEMP_3, KEY
   
   LDI KEY, 108      // X[0] ^= ROUND_CNT 
   EOR X0_1, KEY


   ADD X0_1, TEMP_0 // X[0] += temp
   ADC X0_2, TEMP_1
   ADC X0_3, TEMP_2
   ADC X0_0, TEMP_3

				    // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOVW TEMP_0, X2_0 //round 109,  temp = X[1] <<< 8   
   MOVW TEMP_2, X2_2
   

   LDD KEY, Z+12     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+15
   EOR TEMP_3, KEY

   LDI KEY, 109       // X[0] ^= ROUND_CNT 
   EOR X1_0, KEY

   ADD X1_0, TEMP_0  // X[0] += temp
   ADC X1_1, TEMP_1
   ADC X1_2, TEMP_2
   ADC X1_3, TEMP_3

   LSL X1_0          // X[0] = X[0] <<< 1
   ROL X1_1
   ROL X1_2
   ROL X1_3
   ADC X1_0, R1

                     
					 // X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   MOVW TEMP_0, X3_0 //round110, temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
   
   LDD KEY, Z+16     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+19
   EOR TEMP_3, KEY
   
   LDI KEY, 110       // X[0] ^= ROUND_CNT 
   EOR X2_1, KEY


   ADD X2_1, TEMP_0  // X[0] += temp
   ADC X2_2, TEMP_1
   ADC X2_3, TEMP_2
   ADC X2_0, TEMP_3

				     // X[0] = X[0] <<< 8 (생략) direct indexing
   

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing
   

   
   MOV TEMP_0, X0_3  //round 111  temp = X[1] <<< 8
   MOV TEMP_1, X0_0
   MOV TEMP_2, X0_1
   MOV TEMP_3, X0_2

   LDD KEY, Z+20     // temp ^= RK
   EOR TEMP_0, KEY   
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+23
   EOR TEMP_3, KEY

   LDI KEY, 111       // X[0] ^= ROUND_CNT 
   EOR X3_0, KEY

   ADD X3_0, TEMP_0  // X[0] += temp
   ADC X3_1, TEMP_1
   ADC X3_2, TEMP_2
   ADC X3_3, TEMP_3

   LSL X3_0          // X[0] = X[0] <<< 1
   ROL X3_1
   ROL X3_2
   ROL X3_3
   ADC X3_0, R1

                  
					// X[0] = X[1], X[1] = X[2], X[2] = X[3], X[3] = X[0] (생략)   direct indexing


   

   POP R27
   POP R26

   ST X+, X0_0
   ST X+, X0_1
   ST X+, X0_2
   ST X+, X0_3

   ST X+, X1_0
   ST X+, X1_1
   ST X+, X1_2
   ST X+, X1_3

   ST X+, X2_0
   ST X+, X2_1
   ST X+, X2_2
   ST X+, X2_3

   ST X+, X3_0
   ST X+, X3_1
   ST X+, X3_2
   ST X+, X3_3

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

.global cham128_decrypt
.type cham128_decrypt, @function

#define RK0_0 R0
#define RK0_1 R9
#define RK0_2 R28
#define RK0_3 R4

#define RK1_0 R5
#define RK1_1 R6
#define RK1_2 R7
#define RK1_3 R8


#define KEY R29


#define X0_0 R10
#define X0_1 R11
#define X0_2 R12
#define X0_3 R13
#define X1_0 R14
#define X1_1 R15
#define X1_2 R16
#define X1_3 R17

#define X2_0 R18
#define X2_1 R19
#define X2_2 R20
#define X2_3 R21
#define X3_0 R22
#define X3_1 R23
#define X3_2 R24
#define X3_3 R25

#define TEMP_0 R26
#define TEMP_1 R27
#define TEMP_2 R2
#define TEMP_3 R3




cham128_decrypt:

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
   LD X0_2, X+
   LD X0_3, X+

   LD X1_0, X+
   LD X1_1, X+
   LD X1_2, X+
   LD X1_3, X+

   LD X2_0, X+
   LD X2_1, X+
   LD X2_2, X+
   LD X2_3, X+

   LD X3_0, X+
   LD X3_1, X+
   LD X3_2, X+
   LD X3_3, X+

   LD RK0_0, Z+
   LD RK0_1, Z+
   LD RK0_2, Z+
   LD RK0_3, Z+

   LD RK1_0, Z+
   LD RK1_1, Z+
   LD RK1_2, Z+
   LD RK1_3, Z+

 
   
					   //round 111
					   // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
   

   LSR X3_3            // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_3    // temp = X[1] <<< 8 
   MOV TEMP_1, X0_0
   MOV TEMP_2, X0_1
   MOV TEMP_3, X0_2
                     
   LDD KEY, Z+23      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+20
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0    //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 111        //x[0] ^= CNT 
   EOR X3_0, KEY          
  
					  //round 110 
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0  // temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
               
   LDD KEY, Z+19      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+16
   EOR TEMP_0, KEY

   SUB X2_1, TEMP_0   //X[0] -= temp
   SBC X2_2, TEMP_1
   SBC X2_3, TEMP_2
   SBC X2_0, TEMP_3

   LDI KEY, 110       //x[0] ^= CNT
   EOR X2_1, KEY   
  
					  //round 109 
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3           // X[0] = X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7
   

   MOV TEMP_0, X2_0   // temp = X[1]  <<< 8 
   MOV TEMP_1, X2_1
   MOV TEMP_2, X2_2
   MOV TEMP_3, X2_3
                  
   LDD KEY, Z+15      // temp ^=  RK
   EOR TEMP_3, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+12
   EOR TEMP_0, KEY      

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 109       //x[0] ^= CNT
   EOR X1_0, KEY   
   
					  //round 108
				      // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing   

   MOVW TEMP_0, X1_0  //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+11      //temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+8
   EOR TEMP_0, KEY

   SUB X0_1, TEMP_0   //X[0] -= temp
   SBC X0_2, TEMP_1
   SBC X0_3, TEMP_2
   SBC X0_0, TEMP_3

   LDI KEY, 108       //x[0] ^= CNT
   EOR X0_1, KEY   
   
					 //round 107 
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
   

   LSR X3_3          // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_0  // temp = X[1] <<< 8  
   MOV TEMP_1, X0_1
   MOV TEMP_2, X0_2
   MOV TEMP_3, X0_3
                  
   LDD KEY, Z+7      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+4
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0  //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 107      // X[0] ^= CNT
   EOR X3_0, KEY   
   
					 //round 106
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					 // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0 //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+3      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LD KEY, Z
   EOR TEMP_0, KEY

   SUB X2_2, TEMP_0   //X[0] -= temp
   SBC X2_3, TEMP_1
   SBC X2_0, TEMP_2
   SBC X2_1, TEMP_3

   LDI KEY, 106       //x[0] ^= CNT
   EOR X2_2, KEY   

   
					 //round 105 
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3          // X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_1   // temp = X[1] <<< 8  
   MOV TEMP_1, X2_2
   MOV TEMP_2, X2_3
   MOV TEMP_3, X2_0
   
   EOR TEMP_3, RK1_3  // temp ^= RK
   EOR TEMP_2, RK1_2
   EOR TEMP_1, RK1_1
   EOR TEMP_0, RK1_0   

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 105       //X[0] ^= CNT
   EOR X1_0, KEY   

					  //round 104
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X1_0  //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = X[1] <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   EOR TEMP_3, RK0_3  // temp ^= RK
   EOR TEMP_2, RK0_2
   EOR TEMP_1, RK0_1
   EOR TEMP_0, RK0_0

   SUB X0_2, TEMP_0   //X[0] -= temp
   SBC X0_3, TEMP_1
   SBC X0_0, TEMP_2
   SBC X0_1, TEMP_3

   LDI KEY, 104       //X[0] ^= CNT
   EOR X0_2, KEY   
  
					 //round 103
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X3_3          // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_1   // temp = X[1] <<< 8 
   MOV TEMP_1, X0_2
   MOV TEMP_2, X0_3
   MOV TEMP_3, X0_0
                  
   LDD KEY, Z+23	 // temp = temp ^ RK
   EOR TEMP_3, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+20
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0   //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 103		  //x[0] ^= CNT 
   EOR X3_0, KEY     
   

   
					  //round 102					  
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0]=  X[0] >>> 8(생략) direct indexing   

   MOVW TEMP_0, X3_0   //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+19	  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+16
   EOR TEMP_0, KEY

   SUB X2_3, TEMP_0   //X[0] -= temp
   SBC X2_0, TEMP_1
   SBC X2_1, TEMP_2
   SBC X2_2, TEMP_3

   LDI KEY, 102		  //X[0] ^= CNT
   EOR X2_3, KEY   
   
					  //round 101 
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2]  (생략) direct indexing

   LSR X1_3           // X[0] = X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_2   // temp = X[1] <<< 8  
   MOV TEMP_1, X2_3
   MOV TEMP_2, X2_0
   MOV TEMP_3, X2_1
                  
   LDD KEY, Z+15	   // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+12
   EOR TEMP_0, KEY      

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 101		  //X[0] ^= CNT
   EOR X1_0, KEY   
   
					  //round 100       
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing   

   MOVW TEMP_0, X1_0   //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 (ROL 1)
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                     
   LDD KEY, Z+11	  // TEMP ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+8
   EOR TEMP_0, KEY

   SUB X0_3, TEMP_0   //X[0] -= temp
   SBC X0_0, TEMP_1
   SBC X0_1, TEMP_2
   SBC X0_2, TEMP_3

   LDI KEY, 100		  //x[0] ^= CNT
   EOR X0_3, KEY   
   
					  //round 99   
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X3_3         // X[0] = X[0] <<< 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_2   // temp = X[1] <<< 8 
   MOV TEMP_1, X0_3
   MOV TEMP_2, X0_0
   MOV TEMP_3, X0_1
                  
   LDD KEY, Z+7		  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+4
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0   //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 99		  //X[0] ^= CNT
   EOR X3_0, KEY   
   
					  //round 98        
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0   //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+3		  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LD KEY, Z
   EOR TEMP_0, KEY

   SUB X2_0, TEMP_0   //X[0] -= temp   
   SBC X2_1, TEMP_1
   SBC X2_2, TEMP_2
   SBC X2_3, TEMP_3

   LDI KEY, 98		  //X[0] ^= CNT
   EOR X2_0, KEY   
   
					  //round 97  
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3           // X[0] = X[0] <<< 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_3   // temp = X[1]  <<< 8 
   MOV TEMP_1, X2_0
   MOV TEMP_2, X2_1
   MOV TEMP_3, X2_2
                  
   EOR TEMP_3, RK1_3  // TEMP ^= RK   
   EOR TEMP_2, RK1_2
   EOR TEMP_1, RK1_1
   EOR TEMP_0, RK1_0   

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 97		  //X[0] ^= CNT
   EOR X1_0, KEY   

   
					  //round 96         
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X1_0   //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   EOR TEMP_3, RK0_3  // TEMP ^= RK
   EOR TEMP_2, RK0_2
   EOR TEMP_1, RK0_1
   EOR TEMP_0, RK0_0

   SUB X0_0, TEMP_0   //X[0] -= temp
   SBC X0_1, TEMP_1
   SBC X0_2, TEMP_2
   SBC X0_3, TEMP_3

   LDI KEY, 96		  //X[0] ^= CNT
   EOR X0_0, KEY   

   					   //round 95
					   // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
   

   LSR X3_3            // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_3    // temp = X[1] <<< 8 
   MOV TEMP_1, X0_0
   MOV TEMP_2, X0_1
   MOV TEMP_3, X0_2
                     
   LDD KEY, Z+23      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+20
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0    //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 95        //x[0] ^= CNT 
   EOR X3_0, KEY          
  
					  //round 94
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0  // temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
               
   LDD KEY, Z+19      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+16
   EOR TEMP_0, KEY

   SUB X2_1, TEMP_0   //X[0] -= temp
   SBC X2_2, TEMP_1
   SBC X2_3, TEMP_2
   SBC X2_0, TEMP_3

   LDI KEY, 94       //x[0] ^= CNT
   EOR X2_1, KEY   
  
					  //round 93
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3           // X[0] = X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7
   

   MOV TEMP_0, X2_0   // temp = X[1]  <<< 8 
   MOV TEMP_1, X2_1
   MOV TEMP_2, X2_2
   MOV TEMP_3, X2_3
                  
   LDD KEY, Z+15      // temp ^=  RK
   EOR TEMP_3, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+12
   EOR TEMP_0, KEY      

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 93       //x[0] ^= CNT
   EOR X1_0, KEY   
   
					  //round 92
				      // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing   

   MOVW TEMP_0, X1_0  //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+11      //temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+8
   EOR TEMP_0, KEY

   SUB X0_1, TEMP_0   //X[0] -= temp
   SBC X0_2, TEMP_1
   SBC X0_3, TEMP_2
   SBC X0_0, TEMP_3

   LDI KEY, 92       //x[0] ^= CNT
   EOR X0_1, KEY   
   
					 //round 91 
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
   

   LSR X3_3          // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_0  // temp = X[1] <<< 8  
   MOV TEMP_1, X0_1
   MOV TEMP_2, X0_2
   MOV TEMP_3, X0_3
                  
   LDD KEY, Z+7      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+4
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0  //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 91      // X[0] ^= CNT
   EOR X3_0, KEY   
   
					 //round 90
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					 // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0 //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+3      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LD KEY, Z
   EOR TEMP_0, KEY

   SUB X2_2, TEMP_0   //X[0] -= temp
   SBC X2_3, TEMP_1
   SBC X2_0, TEMP_2
   SBC X2_1, TEMP_3

   LDI KEY, 90       //x[0] ^= CNT
   EOR X2_2, KEY   

   
					 //round 89
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3          // X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_1   // temp = X[1] <<< 8  
   MOV TEMP_1, X2_2
   MOV TEMP_2, X2_3
   MOV TEMP_3, X2_0
   
   EOR TEMP_3, RK1_3  // temp ^= RK
   EOR TEMP_2, RK1_2
   EOR TEMP_1, RK1_1
   EOR TEMP_0, RK1_0   

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 89       //X[0] ^= CNT
   EOR X1_0, KEY   

					  //round 88
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X1_0  //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = X[1] <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   EOR TEMP_3, RK0_3  // temp ^= RK
   EOR TEMP_2, RK0_2
   EOR TEMP_1, RK0_1
   EOR TEMP_0, RK0_0

   SUB X0_2, TEMP_0   //X[0] -= temp
   SBC X0_3, TEMP_1
   SBC X0_0, TEMP_2
   SBC X0_1, TEMP_3

   LDI KEY, 88       //X[0] ^= CNT
   EOR X0_2, KEY   
  
					 //round 87
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X3_3          // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_1   // temp = X[1] <<< 8 
   MOV TEMP_1, X0_2
   MOV TEMP_2, X0_3
   MOV TEMP_3, X0_0
                  
   LDD KEY, Z+23	 // temp = temp ^ RK
   EOR TEMP_3, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+20
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0   //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 87		  //x[0] ^= CNT 
   EOR X3_0, KEY     
   

   
					  //round 86					  
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0]=  X[0] >>> 8(생략) direct indexing   

   MOVW TEMP_0, X3_0   //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+19	  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+16
   EOR TEMP_0, KEY

   SUB X2_3, TEMP_0   //X[0] -= temp
   SBC X2_0, TEMP_1
   SBC X2_1, TEMP_2
   SBC X2_2, TEMP_3

   LDI KEY, 86		  //X[0] ^= CNT
   EOR X2_3, KEY   
   
					  //round 85 
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2]  (생략) direct indexing

   LSR X1_3           // X[0] = X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_2   // temp = X[1] <<< 8  
   MOV TEMP_1, X2_3
   MOV TEMP_2, X2_0
   MOV TEMP_3, X2_1
                  
   LDD KEY, Z+15	   // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+12
   EOR TEMP_0, KEY      

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 85		  //X[0] ^= CNT
   EOR X1_0, KEY   
   
					  //round 84       
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing   

   MOVW TEMP_0, X1_0   //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 (ROL 1)
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                     
   LDD KEY, Z+11	  // TEMP ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+8
   EOR TEMP_0, KEY

   SUB X0_3, TEMP_0   //X[0] -= temp
   SBC X0_0, TEMP_1
   SBC X0_1, TEMP_2
   SBC X0_2, TEMP_3

   LDI KEY, 84		  //x[0] ^= CNT
   EOR X0_3, KEY   
   
					  //round 83 
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X3_3         // X[0] = X[0] <<< 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_2   // temp = X[1] <<< 8 
   MOV TEMP_1, X0_3
   MOV TEMP_2, X0_0
   MOV TEMP_3, X0_1
                  
   LDD KEY, Z+7		  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+4
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0   //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 83		  //X[0] ^= CNT
   EOR X3_0, KEY   
   
					  //round 82        
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0   //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+3		  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LD KEY, Z
   EOR TEMP_0, KEY

   SUB X2_0, TEMP_0   //X[0] -= temp   
   SBC X2_1, TEMP_1
   SBC X2_2, TEMP_2
   SBC X2_3, TEMP_3

   LDI KEY, 82		  //X[0] ^= CNT
   EOR X2_0, KEY   
   
					  //round 81 
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3           // X[0] = X[0] <<< 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_3   // temp = X[1]  <<< 8 
   MOV TEMP_1, X2_0
   MOV TEMP_2, X2_1
   MOV TEMP_3, X2_2
                  
   EOR TEMP_3, RK1_3  // TEMP ^= RK   
   EOR TEMP_2, RK1_2
   EOR TEMP_1, RK1_1
   EOR TEMP_0, RK1_0   

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 81		  //X[0] ^= CNT
   EOR X1_0, KEY   

   
					  //round 80        
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X1_0   //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   EOR TEMP_3, RK0_3  // TEMP ^= RK
   EOR TEMP_2, RK0_2
   EOR TEMP_1, RK0_1
   EOR TEMP_0, RK0_0

   SUB X0_0, TEMP_0   //X[0] -= temp
   SBC X0_1, TEMP_1
   SBC X0_2, TEMP_2
   SBC X0_3, TEMP_3

   LDI KEY, 80		  //X[0] ^= CNT
   EOR X0_0, KEY   

   					   //round 79
					   // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
   

   LSR X3_3            // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_3    // temp = X[1] <<< 8 
   MOV TEMP_1, X0_0
   MOV TEMP_2, X0_1
   MOV TEMP_3, X0_2
                     
   LDD KEY, Z+23      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+20
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0    //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 79        //x[0] ^= CNT 
   EOR X3_0, KEY          
  
					  //round 78
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0  // temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
               
   LDD KEY, Z+19      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+16
   EOR TEMP_0, KEY

   SUB X2_1, TEMP_0   //X[0] -= temp
   SBC X2_2, TEMP_1
   SBC X2_3, TEMP_2
   SBC X2_0, TEMP_3

   LDI KEY, 78       //x[0] ^= CNT
   EOR X2_1, KEY   
  
					  //round 77
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3           // X[0] = X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7
   

   MOV TEMP_0, X2_0   // temp = X[1]  <<< 8 
   MOV TEMP_1, X2_1
   MOV TEMP_2, X2_2
   MOV TEMP_3, X2_3
                  
   LDD KEY, Z+15      // temp ^=  RK
   EOR TEMP_3, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+12
   EOR TEMP_0, KEY      

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 77       //x[0] ^= CNT
   EOR X1_0, KEY   
   
					  //round 76
				      // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing   

   MOVW TEMP_0, X1_0  //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+11      //temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+8
   EOR TEMP_0, KEY

   SUB X0_1, TEMP_0   //X[0] -= temp
   SBC X0_2, TEMP_1
   SBC X0_3, TEMP_2
   SBC X0_0, TEMP_3

   LDI KEY, 76       //x[0] ^= CNT
   EOR X0_1, KEY   
   
					 //round 75 
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
   

   LSR X3_3          // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_0  // temp = X[1] <<< 8  
   MOV TEMP_1, X0_1
   MOV TEMP_2, X0_2
   MOV TEMP_3, X0_3
                  
   LDD KEY, Z+7      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+4
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0  //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 75      // X[0] ^= CNT
   EOR X3_0, KEY   
   
					 //round 74
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					 // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0 //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+3      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LD KEY, Z
   EOR TEMP_0, KEY

   SUB X2_2, TEMP_0   //X[0] -= temp
   SBC X2_3, TEMP_1
   SBC X2_0, TEMP_2
   SBC X2_1, TEMP_3

   LDI KEY, 74       //x[0] ^= CNT
   EOR X2_2, KEY   

   
					 //round 73 
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3          // X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_1   // temp = X[1] <<< 8  
   MOV TEMP_1, X2_2
   MOV TEMP_2, X2_3
   MOV TEMP_3, X2_0
   
   EOR TEMP_3, RK1_3  // temp ^= RK
   EOR TEMP_2, RK1_2
   EOR TEMP_1, RK1_1
   EOR TEMP_0, RK1_0   

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 73       //X[0] ^= CNT
   EOR X1_0, KEY   

					  //round 72
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X1_0  //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = X[1] <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   EOR TEMP_3, RK0_3  // temp ^= RK
   EOR TEMP_2, RK0_2
   EOR TEMP_1, RK0_1
   EOR TEMP_0, RK0_0

   SUB X0_2, TEMP_0   //X[0] -= temp
   SBC X0_3, TEMP_1
   SBC X0_0, TEMP_2
   SBC X0_1, TEMP_3

   LDI KEY, 72       //X[0] ^= CNT
   EOR X0_2, KEY   
  
					 //round 71
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X3_3          // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_1   // temp = X[1] <<< 8 
   MOV TEMP_1, X0_2
   MOV TEMP_2, X0_3
   MOV TEMP_3, X0_0
                  
   LDD KEY, Z+23	 // temp = temp ^ RK
   EOR TEMP_3, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+20
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0   //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 71		  //x[0] ^= CNT 
   EOR X3_0, KEY     
   

   
					  //round 70					  
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0]=  X[0] >>> 8(생략) direct indexing   

   MOVW TEMP_0, X3_0   //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+19	  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+16
   EOR TEMP_0, KEY

   SUB X2_3, TEMP_0   //X[0] -= temp
   SBC X2_0, TEMP_1
   SBC X2_1, TEMP_2
   SBC X2_2, TEMP_3

   LDI KEY, 70		  //X[0] ^= CNT
   EOR X2_3, KEY   
   
					  //round 69 
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2]  (생략) direct indexing

   LSR X1_3           // X[0] = X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_2   // temp = X[1] <<< 8  
   MOV TEMP_1, X2_3
   MOV TEMP_2, X2_0
   MOV TEMP_3, X2_1
                  
   LDD KEY, Z+15	   // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+12
   EOR TEMP_0, KEY      

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 69		  //X[0] ^= CNT
   EOR X1_0, KEY   
   
					  //round 68       
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing   

   MOVW TEMP_0, X1_0   //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 (ROL 1)
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                     
   LDD KEY, Z+11	  // TEMP ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+8
   EOR TEMP_0, KEY

   SUB X0_3, TEMP_0   //X[0] -= temp
   SBC X0_0, TEMP_1
   SBC X0_1, TEMP_2
   SBC X0_2, TEMP_3

   LDI KEY, 68		  //x[0] ^= CNT
   EOR X0_3, KEY   
   
					  //round 67   
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X3_3         // X[0] = X[0] <<< 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_2   // temp = X[1] <<< 8 
   MOV TEMP_1, X0_3
   MOV TEMP_2, X0_0
   MOV TEMP_3, X0_1
                  
   LDD KEY, Z+7		  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+4
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0   //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 67		  //X[0] ^= CNT
   EOR X3_0, KEY   
   
					  //round 66        
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0   //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+3		  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LD KEY, Z
   EOR TEMP_0, KEY

   SUB X2_0, TEMP_0   //X[0] -= temp   
   SBC X2_1, TEMP_1
   SBC X2_2, TEMP_2
   SBC X2_3, TEMP_3

   LDI KEY, 66		  //X[0] ^= CNT
   EOR X2_0, KEY   
   
					  //round 65  
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3           // X[0] = X[0] <<< 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_3   // temp = X[1]  <<< 8 
   MOV TEMP_1, X2_0
   MOV TEMP_2, X2_1
   MOV TEMP_3, X2_2
                  
   EOR TEMP_3, RK1_3  // TEMP ^= RK   
   EOR TEMP_2, RK1_2
   EOR TEMP_1, RK1_1
   EOR TEMP_0, RK1_0   

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 65		  //X[0] ^= CNT
   EOR X1_0, KEY   

   
					  //round 64         
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X1_0   //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   EOR TEMP_3, RK0_3  // TEMP ^= RK
   EOR TEMP_2, RK0_2
   EOR TEMP_1, RK0_1
   EOR TEMP_0, RK0_0

   SUB X0_0, TEMP_0   //X[0] -= temp
   SBC X0_1, TEMP_1
   SBC X0_2, TEMP_2
   SBC X0_3, TEMP_3

   LDI KEY, 64		  //X[0] ^= CNT
   EOR X0_0, KEY   

      				  //round 63
					   // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
   

   LSR X3_3            // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_3    // temp = X[1] <<< 8 
   MOV TEMP_1, X0_0
   MOV TEMP_2, X0_1
   MOV TEMP_3, X0_2
                     
   LDD KEY, Z+23      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+20
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0    //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 63        //x[0] ^= CNT 
   EOR X3_0, KEY          
  
					  //round 62
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0  // temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
               
   LDD KEY, Z+19      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+16
   EOR TEMP_0, KEY

   SUB X2_1, TEMP_0   //X[0] -= temp
   SBC X2_2, TEMP_1
   SBC X2_3, TEMP_2
   SBC X2_0, TEMP_3

   LDI KEY, 62       //x[0] ^= CNT
   EOR X2_1, KEY   
  
					  //round 61
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3           // X[0] = X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7
   

   MOV TEMP_0, X2_0   // temp = X[1]  <<< 8 
   MOV TEMP_1, X2_1
   MOV TEMP_2, X2_2
   MOV TEMP_3, X2_3
                  
   LDD KEY, Z+15      // temp ^=  RK
   EOR TEMP_3, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+12
   EOR TEMP_0, KEY      

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 61       //x[0] ^= CNT
   EOR X1_0, KEY   
   
					  //round 60
				      // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing   

   MOVW TEMP_0, X1_0  //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+11      //temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+8
   EOR TEMP_0, KEY

   SUB X0_1, TEMP_0   //X[0] -= temp
   SBC X0_2, TEMP_1
   SBC X0_3, TEMP_2
   SBC X0_0, TEMP_3

   LDI KEY, 60       //x[0] ^= CNT
   EOR X0_1, KEY   
   
					 //round 59 
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
   

   LSR X3_3          // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_0  // temp = X[1] <<< 8  
   MOV TEMP_1, X0_1
   MOV TEMP_2, X0_2
   MOV TEMP_3, X0_3
                  
   LDD KEY, Z+7      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+4
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0  //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 59      // X[0] ^= CNT
   EOR X3_0, KEY   
   
					 //round 58
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					 // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0 //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+3      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LD KEY, Z
   EOR TEMP_0, KEY

   SUB X2_2, TEMP_0   //X[0] -= temp
   SBC X2_3, TEMP_1
   SBC X2_0, TEMP_2
   SBC X2_1, TEMP_3

   LDI KEY, 58       //x[0] ^= CNT
   EOR X2_2, KEY   

   
					 //round 57 
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3          // X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_1   // temp = X[1] <<< 8  
   MOV TEMP_1, X2_2
   MOV TEMP_2, X2_3
   MOV TEMP_3, X2_0
   
   EOR TEMP_3, RK1_3  // temp ^= RK
   EOR TEMP_2, RK1_2
   EOR TEMP_1, RK1_1
   EOR TEMP_0, RK1_0   

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 57       //X[0] ^= CNT
   EOR X1_0, KEY   

					  //round 56
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X1_0  //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = X[1] <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   EOR TEMP_3, RK0_3  // temp ^= RK
   EOR TEMP_2, RK0_2
   EOR TEMP_1, RK0_1
   EOR TEMP_0, RK0_0

   SUB X0_2, TEMP_0   //X[0] -= temp
   SBC X0_3, TEMP_1
   SBC X0_0, TEMP_2
   SBC X0_1, TEMP_3

   LDI KEY, 56       //X[0] ^= CNT
   EOR X0_2, KEY   
  
					 //round 55
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X3_3          // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_1   // temp = X[1] <<< 8 
   MOV TEMP_1, X0_2
   MOV TEMP_2, X0_3
   MOV TEMP_3, X0_0
                  
   LDD KEY, Z+23	 // temp = temp ^ RK
   EOR TEMP_3, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+20
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0   //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 55		  //x[0] ^= CNT 
   EOR X3_0, KEY     
   

   
					  //round 54					  
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0]=  X[0] >>> 8(생략) direct indexing   

   MOVW TEMP_0, X3_0   //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+19	  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+16
   EOR TEMP_0, KEY

   SUB X2_3, TEMP_0   //X[0] -= temp
   SBC X2_0, TEMP_1
   SBC X2_1, TEMP_2
   SBC X2_2, TEMP_3

   LDI KEY, 54		  //X[0] ^= CNT
   EOR X2_3, KEY   
   
					  //round 53 
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2]  (생략) direct indexing

   LSR X1_3           // X[0] = X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_2   // temp = X[1] <<< 8  
   MOV TEMP_1, X2_3
   MOV TEMP_2, X2_0
   MOV TEMP_3, X2_1
                  
   LDD KEY, Z+15	   // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+12
   EOR TEMP_0, KEY      

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 53		  //X[0] ^= CNT
   EOR X1_0, KEY   
   
					  //round 52       
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing   

   MOVW TEMP_0, X1_0   //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 (ROL 1)
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                     
   LDD KEY, Z+11	  // TEMP ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+8
   EOR TEMP_0, KEY

   SUB X0_3, TEMP_0   //X[0] -= temp
   SBC X0_0, TEMP_1
   SBC X0_1, TEMP_2
   SBC X0_2, TEMP_3

   LDI KEY, 52		  //x[0] ^= CNT
   EOR X0_3, KEY   
   
					  //round 51   
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X3_3         // X[0] = X[0] <<< 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_2   // temp = X[1] <<< 8 
   MOV TEMP_1, X0_3
   MOV TEMP_2, X0_0
   MOV TEMP_3, X0_1
                  
   LDD KEY, Z+7		  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+4
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0   //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 51		  //X[0] ^= CNT
   EOR X3_0, KEY   
   
					  //round 50        
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0   //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+3		  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LD KEY, Z
   EOR TEMP_0, KEY

   SUB X2_0, TEMP_0   //X[0] -= temp   
   SBC X2_1, TEMP_1
   SBC X2_2, TEMP_2
   SBC X2_3, TEMP_3

   LDI KEY, 50		  //X[0] ^= CNT
   EOR X2_0, KEY   
   
					  //round 49  
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3           // X[0] = X[0] <<< 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_3   // temp = X[1]  <<< 8 
   MOV TEMP_1, X2_0
   MOV TEMP_2, X2_1
   MOV TEMP_3, X2_2
                  
   EOR TEMP_3, RK1_3  // TEMP ^= RK   
   EOR TEMP_2, RK1_2
   EOR TEMP_1, RK1_1
   EOR TEMP_0, RK1_0   

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 49		  //X[0] ^= CNT
   EOR X1_0, KEY   

   
					  //round 48         
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X1_0   //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   EOR TEMP_3, RK0_3  // TEMP ^= RK
   EOR TEMP_2, RK0_2
   EOR TEMP_1, RK0_1
   EOR TEMP_0, RK0_0

   SUB X0_0, TEMP_0   //X[0] -= temp
   SBC X0_1, TEMP_1
   SBC X0_2, TEMP_2
   SBC X0_3, TEMP_3

   LDI KEY, 48		  //X[0] ^= CNT
   EOR X0_0, KEY 

      					   //round 47
					   // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
   

   LSR X3_3            // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_3    // temp = X[1] <<< 8 
   MOV TEMP_1, X0_0
   MOV TEMP_2, X0_1
   MOV TEMP_3, X0_2
                     
   LDD KEY, Z+23      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+20
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0    //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 47        //x[0] ^= CNT 
   EOR X3_0, KEY          
  
					  //round 46
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0  // temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
               
   LDD KEY, Z+19      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+16
   EOR TEMP_0, KEY

   SUB X2_1, TEMP_0   //X[0] -= temp
   SBC X2_2, TEMP_1
   SBC X2_3, TEMP_2
   SBC X2_0, TEMP_3

   LDI KEY, 46       //x[0] ^= CNT
   EOR X2_1, KEY   
  
					  //round 45
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3           // X[0] = X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7
   

   MOV TEMP_0, X2_0   // temp = X[1]  <<< 8 
   MOV TEMP_1, X2_1
   MOV TEMP_2, X2_2
   MOV TEMP_3, X2_3
                  
   LDD KEY, Z+15      // temp ^=  RK
   EOR TEMP_3, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+12
   EOR TEMP_0, KEY      

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 45       //x[0] ^= CNT
   EOR X1_0, KEY   
   
					  //round 44
				      // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing   

   MOVW TEMP_0, X1_0  //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+11      //temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+8
   EOR TEMP_0, KEY

   SUB X0_1, TEMP_0   //X[0] -= temp
   SBC X0_2, TEMP_1
   SBC X0_3, TEMP_2
   SBC X0_0, TEMP_3

   LDI KEY, 44       //x[0] ^= CNT
   EOR X0_1, KEY   
   
					 //round 43
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
   

   LSR X3_3          // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_0  // temp = X[1] <<< 8  
   MOV TEMP_1, X0_1
   MOV TEMP_2, X0_2
   MOV TEMP_3, X0_3
                  
   LDD KEY, Z+7      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+4
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0  //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 43      // X[0] ^= CNT
   EOR X3_0, KEY   
   
					 //round 42
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					 // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0 //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+3      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LD KEY, Z
   EOR TEMP_0, KEY

   SUB X2_2, TEMP_0   //X[0] -= temp
   SBC X2_3, TEMP_1
   SBC X2_0, TEMP_2
   SBC X2_1, TEMP_3

   LDI KEY, 42       //x[0] ^= CNT
   EOR X2_2, KEY   

   
					 //round 41 
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3          // X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_1   // temp = X[1] <<< 8  
   MOV TEMP_1, X2_2
   MOV TEMP_2, X2_3
   MOV TEMP_3, X2_0
   
   EOR TEMP_3, RK1_3  // temp ^= RK
   EOR TEMP_2, RK1_2
   EOR TEMP_1, RK1_1
   EOR TEMP_0, RK1_0   

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 41       //X[0] ^= CNT
   EOR X1_0, KEY   

					  //round 40
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X1_0  //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = X[1] <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   EOR TEMP_3, RK0_3  // temp ^= RK
   EOR TEMP_2, RK0_2
   EOR TEMP_1, RK0_1
   EOR TEMP_0, RK0_0

   SUB X0_2, TEMP_0   //X[0] -= temp
   SBC X0_3, TEMP_1
   SBC X0_0, TEMP_2
   SBC X0_1, TEMP_3

   LDI KEY, 40       //X[0] ^= CNT
   EOR X0_2, KEY   
  
					 //round 39
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X3_3          // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_1   // temp = X[1] <<< 8 
   MOV TEMP_1, X0_2
   MOV TEMP_2, X0_3
   MOV TEMP_3, X0_0
                  
   LDD KEY, Z+23	 // temp = temp ^ RK
   EOR TEMP_3, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+20
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0   //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 39		  //x[0] ^= CNT 
   EOR X3_0, KEY     
   

   
					  //round 38					  
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0]=  X[0] >>> 8(생략) direct indexing   

   MOVW TEMP_0, X3_0   //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+19	  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+16
   EOR TEMP_0, KEY

   SUB X2_3, TEMP_0   //X[0] -= temp
   SBC X2_0, TEMP_1
   SBC X2_1, TEMP_2
   SBC X2_2, TEMP_3

   LDI KEY, 38		  //X[0] ^= CNT
   EOR X2_3, KEY   
   
					  //round 37 
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2]  (생략) direct indexing

   LSR X1_3           // X[0] = X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_2   // temp = X[1] <<< 8  
   MOV TEMP_1, X2_3
   MOV TEMP_2, X2_0
   MOV TEMP_3, X2_1
                  
   LDD KEY, Z+15	   // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+12
   EOR TEMP_0, KEY      

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 37		  //X[0] ^= CNT
   EOR X1_0, KEY   
   
					  //round 36       
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing   

   MOVW TEMP_0, X1_0   //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 (ROL 1)
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                     
   LDD KEY, Z+11	  // TEMP ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+8
   EOR TEMP_0, KEY

   SUB X0_3, TEMP_0   //X[0] -= temp
   SBC X0_0, TEMP_1
   SBC X0_1, TEMP_2
   SBC X0_2, TEMP_3

   LDI KEY, 36		  //x[0] ^= CNT
   EOR X0_3, KEY   
   
					  //round 35   
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X3_3         // X[0] = X[0] <<< 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_2   // temp = X[1] <<< 8 
   MOV TEMP_1, X0_3
   MOV TEMP_2, X0_0
   MOV TEMP_3, X0_1
                  
   LDD KEY, Z+7		  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+4
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0   //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 35		  //X[0] ^= CNT
   EOR X3_0, KEY   
   
					  //round 34        
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0   //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+3		  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LD KEY, Z
   EOR TEMP_0, KEY

   SUB X2_0, TEMP_0   //X[0] -= temp   
   SBC X2_1, TEMP_1
   SBC X2_2, TEMP_2
   SBC X2_3, TEMP_3

   LDI KEY, 34		  //X[0] ^= CNT
   EOR X2_0, KEY   
   
					  //round 33  
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3           // X[0] = X[0] <<< 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_3   // temp = X[1]  <<< 8 
   MOV TEMP_1, X2_0
   MOV TEMP_2, X2_1
   MOV TEMP_3, X2_2
                  
   EOR TEMP_3, RK1_3  // TEMP ^= RK   
   EOR TEMP_2, RK1_2
   EOR TEMP_1, RK1_1
   EOR TEMP_0, RK1_0   

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 33		  //X[0] ^= CNT
   EOR X1_0, KEY   

   
					  //round 32         
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X1_0   //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   EOR TEMP_3, RK0_3  // TEMP ^= RK
   EOR TEMP_2, RK0_2
   EOR TEMP_1, RK0_1
   EOR TEMP_0, RK0_0

   SUB X0_0, TEMP_0   //X[0] -= temp
   SBC X0_1, TEMP_1
   SBC X0_2, TEMP_2
   SBC X0_3, TEMP_3

   LDI KEY, 32		  //X[0] ^= CNT
   EOR X0_0, KEY 

      					   //round 31
					   // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
   

   LSR X3_3            // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_3    // temp = X[1] <<< 8 
   MOV TEMP_1, X0_0
   MOV TEMP_2, X0_1
   MOV TEMP_3, X0_2
                     
   LDD KEY, Z+23      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+20
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0    //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 31        //x[0] ^= CNT 
   EOR X3_0, KEY          
  
					  //round 30
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0  // temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
               
   LDD KEY, Z+19      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+16
   EOR TEMP_0, KEY

   SUB X2_1, TEMP_0   //X[0] -= temp
   SBC X2_2, TEMP_1
   SBC X2_3, TEMP_2
   SBC X2_0, TEMP_3

   LDI KEY, 30       //x[0] ^= CNT
   EOR X2_1, KEY   
  
					  //round 29
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3           // X[0] = X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7
   

   MOV TEMP_0, X2_0   // temp = X[1]  <<< 8 
   MOV TEMP_1, X2_1
   MOV TEMP_2, X2_2
   MOV TEMP_3, X2_3
                  
   LDD KEY, Z+15      // temp ^=  RK
   EOR TEMP_3, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+12
   EOR TEMP_0, KEY      

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 29       //x[0] ^= CNT
   EOR X1_0, KEY   
   
					  //round 28
				      // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing   

   MOVW TEMP_0, X1_0  //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+11      //temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+8
   EOR TEMP_0, KEY

   SUB X0_1, TEMP_0   //X[0] -= temp
   SBC X0_2, TEMP_1
   SBC X0_3, TEMP_2
   SBC X0_0, TEMP_3

   LDI KEY, 28       //x[0] ^= CNT
   EOR X0_1, KEY   
   
					 //round 27 
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
   

   LSR X3_3          // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_0  // temp = X[1] <<< 8  
   MOV TEMP_1, X0_1
   MOV TEMP_2, X0_2
   MOV TEMP_3, X0_3
                  
   LDD KEY, Z+7      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+4
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0  //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 27      // X[0] ^= CNT
   EOR X3_0, KEY   
   
					 //round 26
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					 // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0 //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+3      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LD KEY, Z
   EOR TEMP_0, KEY

   SUB X2_2, TEMP_0   //X[0] -= temp
   SBC X2_3, TEMP_1
   SBC X2_0, TEMP_2
   SBC X2_1, TEMP_3

   LDI KEY, 26       //x[0] ^= CNT
   EOR X2_2, KEY   

   
					 //round 25 
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3          // X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_1   // temp = X[1] <<< 8  
   MOV TEMP_1, X2_2
   MOV TEMP_2, X2_3
   MOV TEMP_3, X2_0
   
   EOR TEMP_3, RK1_3  // temp ^= RK
   EOR TEMP_2, RK1_2
   EOR TEMP_1, RK1_1
   EOR TEMP_0, RK1_0   

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 25       //X[0] ^= CNT
   EOR X1_0, KEY   

					  //round 24
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X1_0  //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = X[1] <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   EOR TEMP_3, RK0_3  // temp ^= RK
   EOR TEMP_2, RK0_2
   EOR TEMP_1, RK0_1
   EOR TEMP_0, RK0_0

   SUB X0_2, TEMP_0   //X[0] -= temp
   SBC X0_3, TEMP_1
   SBC X0_0, TEMP_2
   SBC X0_1, TEMP_3

   LDI KEY, 24       //X[0] ^= CNT
   EOR X0_2, KEY   
  
					 //round 23
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X3_3          // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_1   // temp = X[1] <<< 8 
   MOV TEMP_1, X0_2
   MOV TEMP_2, X0_3
   MOV TEMP_3, X0_0
                  
   LDD KEY, Z+23	 // temp = temp ^ RK
   EOR TEMP_3, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+20
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0   //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 23		  //x[0] ^= CNT 
   EOR X3_0, KEY     
   

   
					  //round 22					  
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0]=  X[0] >>> 8(생략) direct indexing   

   MOVW TEMP_0, X3_0   //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+19	  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+16
   EOR TEMP_0, KEY

   SUB X2_3, TEMP_0   //X[0] -= temp
   SBC X2_0, TEMP_1
   SBC X2_1, TEMP_2
   SBC X2_2, TEMP_3

   LDI KEY, 22		  //X[0] ^= CNT
   EOR X2_3, KEY   
   
					  //round 21 
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2]  (생략) direct indexing

   LSR X1_3           // X[0] = X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_2   // temp = X[1] <<< 8  
   MOV TEMP_1, X2_3
   MOV TEMP_2, X2_0
   MOV TEMP_3, X2_1
                  
   LDD KEY, Z+15	   // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+12
   EOR TEMP_0, KEY      

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 21		  //X[0] ^= CNT
   EOR X1_0, KEY   
   
					  //round 20      
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing   

   MOVW TEMP_0, X1_0   //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 (ROL 1)
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                     
   LDD KEY, Z+11	  // TEMP ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+8
   EOR TEMP_0, KEY

   SUB X0_3, TEMP_0   //X[0] -= temp
   SBC X0_0, TEMP_1
   SBC X0_1, TEMP_2
   SBC X0_2, TEMP_3

   LDI KEY, 20		  //x[0] ^= CNT
   EOR X0_3, KEY   
   
					  //round 19   
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X3_3         // X[0] = X[0] <<< 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_2   // temp = X[1] <<< 8 
   MOV TEMP_1, X0_3
   MOV TEMP_2, X0_0
   MOV TEMP_3, X0_1
                  
   LDD KEY, Z+7		  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+4
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0   //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 19		  //X[0] ^= CNT
   EOR X3_0, KEY   
   
					  //round 18        
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0   //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+3		  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LD KEY, Z
   EOR TEMP_0, KEY

   SUB X2_0, TEMP_0   //X[0] -= temp   
   SBC X2_1, TEMP_1
   SBC X2_2, TEMP_2
   SBC X2_3, TEMP_3

   LDI KEY, 18		  //X[0] ^= CNT
   EOR X2_0, KEY   
   
					  //round 17  
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3           // X[0] = X[0] <<< 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_3   // temp = X[1]  <<< 8 
   MOV TEMP_1, X2_0
   MOV TEMP_2, X2_1
   MOV TEMP_3, X2_2
                  
   EOR TEMP_3, RK1_3  // TEMP ^= RK   
   EOR TEMP_2, RK1_2
   EOR TEMP_1, RK1_1
   EOR TEMP_0, RK1_0   

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 17		  //X[0] ^= CNT
   EOR X1_0, KEY   

   
					  //round 16         
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X1_0   //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   EOR TEMP_3, RK0_3  // TEMP ^= RK
   EOR TEMP_2, RK0_2
   EOR TEMP_1, RK0_1
   EOR TEMP_0, RK0_0

   SUB X0_0, TEMP_0   //X[0] -= temp
   SBC X0_1, TEMP_1
   SBC X0_2, TEMP_2
   SBC X0_3, TEMP_3

   LDI KEY, 16		  //X[0] ^= CNT
   EOR X0_0, KEY 

      					   //round 15
					   // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
   

   LSR X3_3            // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_3    // temp = X[1] <<< 8 
   MOV TEMP_1, X0_0
   MOV TEMP_2, X0_1
   MOV TEMP_3, X0_2
                     
   LDD KEY, Z+23      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+20
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0    //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 15        //x[0] ^= CNT 
   EOR X3_0, KEY          
  
					  //round 14
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0  // temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
               
   LDD KEY, Z+19      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+16
   EOR TEMP_0, KEY

   SUB X2_1, TEMP_0   //X[0] -= temp
   SBC X2_2, TEMP_1
   SBC X2_3, TEMP_2
   SBC X2_0, TEMP_3

   LDI KEY, 14       //x[0] ^= CNT
   EOR X2_1, KEY   
  
					  //round 13
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3           // X[0] = X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7
   

   MOV TEMP_0, X2_0   // temp = X[1]  <<< 8 
   MOV TEMP_1, X2_1
   MOV TEMP_2, X2_2
   MOV TEMP_3, X2_3
                  
   LDD KEY, Z+15      // temp ^=  RK
   EOR TEMP_3, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+12
   EOR TEMP_0, KEY      

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 13       //x[0] ^= CNT
   EOR X1_0, KEY   
   
					  //round 12
				      // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing   

   MOVW TEMP_0, X1_0  //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+11      //temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+8
   EOR TEMP_0, KEY

   SUB X0_1, TEMP_0   //X[0] -= temp
   SBC X0_2, TEMP_1
   SBC X0_3, TEMP_2
   SBC X0_0, TEMP_3

   LDI KEY, 12       //x[0] ^= CNT
   EOR X0_1, KEY   
   
					 //round 11 
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
   

   LSR X3_3          // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_0  // temp = X[1] <<< 8  
   MOV TEMP_1, X0_1
   MOV TEMP_2, X0_2
   MOV TEMP_3, X0_3
                  
   LDD KEY, Z+7      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+4
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0  //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 11      // X[0] ^= CNT
   EOR X3_0, KEY   
   
					 //round 10
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					 // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0 //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0        //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+3      // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LD KEY, Z
   EOR TEMP_0, KEY

   SUB X2_2, TEMP_0   //X[0] -= temp
   SBC X2_3, TEMP_1
   SBC X2_0, TEMP_2
   SBC X2_1, TEMP_3

   LDI KEY, 10       //x[0] ^= CNT
   EOR X2_2, KEY   

   
					 //round 9 
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3          // X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_1   // temp = X[1] <<< 8  
   MOV TEMP_1, X2_2
   MOV TEMP_2, X2_3
   MOV TEMP_3, X2_0
   
   EOR TEMP_3, RK1_3  // temp ^= RK
   EOR TEMP_2, RK1_2
   EOR TEMP_1, RK1_1
   EOR TEMP_0, RK1_0   

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 9       //X[0] ^= CNT
   EOR X1_0, KEY   

					  //round 8
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X1_0  //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = X[1] <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   EOR TEMP_3, RK0_3  // temp ^= RK
   EOR TEMP_2, RK0_2
   EOR TEMP_1, RK0_1
   EOR TEMP_0, RK0_0

   SUB X0_2, TEMP_0   //X[0] -= temp
   SBC X0_3, TEMP_1
   SBC X0_0, TEMP_2
   SBC X0_1, TEMP_3

   LDI KEY, 8       //X[0] ^= CNT
   EOR X0_2, KEY   
  
					 //round 7
					 // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X3_3          // X[0] = X[0] >>> 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_1   // temp = X[1] <<< 8 
   MOV TEMP_1, X0_2
   MOV TEMP_2, X0_3
   MOV TEMP_3, X0_0
                  
   LDD KEY, Z+23	 // temp = temp ^ RK
   EOR TEMP_3, KEY
   LDD KEY, Z+22
   EOR TEMP_2, KEY
   LDD KEY, Z+21
   EOR TEMP_1, KEY
   LDD KEY, Z+20
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0   //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 7		  //x[0] ^= CNT 
   EOR X3_0, KEY     
   

   
					  //round 6					  
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0]=  X[0] >>> 8(생략) direct indexing   

   MOVW TEMP_0, X3_0   //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+19	  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+18
   EOR TEMP_2, KEY
   LDD KEY, Z+17
   EOR TEMP_1, KEY
   LDD KEY, Z+16
   EOR TEMP_0, KEY

   SUB X2_3, TEMP_0   //X[0] -= temp
   SBC X2_0, TEMP_1
   SBC X2_1, TEMP_2
   SBC X2_2, TEMP_3

   LDI KEY, 6		  //X[0] ^= CNT
   EOR X2_3, KEY   
   
					  //round 5 
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2]  (생략) direct indexing

   LSR X1_3           // X[0] = X[0] >>> 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_2   // temp = X[1] <<< 8  
   MOV TEMP_1, X2_3
   MOV TEMP_2, X2_0
   MOV TEMP_3, X2_1
                  
   LDD KEY, Z+15	   // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+14
   EOR TEMP_2, KEY
   LDD KEY, Z+13
   EOR TEMP_1, KEY
   LDD KEY, Z+12
   EOR TEMP_0, KEY      

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 5		  //X[0] ^= CNT
   EOR X1_0, KEY   
   
					  //round 4       
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing   

   MOVW TEMP_0, X1_0   //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 (ROL 1)
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                     
   LDD KEY, Z+11	  // TEMP ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+10
   EOR TEMP_2, KEY
   LDD KEY, Z+9
   EOR TEMP_1, KEY
   LDD KEY, Z+8
   EOR TEMP_0, KEY

   SUB X0_3, TEMP_0   //X[0] -= temp
   SBC X0_0, TEMP_1
   SBC X0_1, TEMP_2
   SBC X0_2, TEMP_3

   LDI KEY, 4		  //x[0] ^= CNT
   EOR X0_3, KEY   
   
					  //round 3   
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X3_3         // X[0] = X[0] <<< 1
   ROR X3_2
   ROR X3_1
   BST X3_0, 0
   ROR X3_0   
   BLD X3_3, 7   

   MOV TEMP_0, X0_2   // temp = X[1] <<< 8 
   MOV TEMP_1, X0_3
   MOV TEMP_2, X0_0
   MOV TEMP_3, X0_1
                  
   LDD KEY, Z+7		  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+6
   EOR TEMP_2, KEY
   LDD KEY, Z+5
   EOR TEMP_1, KEY
   LDD KEY, Z+4
   EOR TEMP_0, KEY      

   SUB X3_0, TEMP_0   //X[0] -= temp
   SBC X3_1, TEMP_1
   SBC X3_2, TEMP_2
   SBC X3_3, TEMP_3

   LDI KEY, 3		  //X[0] ^= CNT
   EOR X3_0, KEY   
   
					  //round 2        
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X3_0   //temp = X[1]
   MOVW TEMP_2, X3_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   LDD KEY, Z+3		  // temp ^= RK
   EOR TEMP_3, KEY
   LDD KEY, Z+2
   EOR TEMP_2, KEY
   LDD KEY, Z+1
   EOR TEMP_1, KEY
   LD KEY, Z
   EOR TEMP_0, KEY

   SUB X2_0, TEMP_0   //X[0] -= temp   
   SBC X2_1, TEMP_1
   SBC X2_2, TEMP_2
   SBC X2_3, TEMP_3

   LDI KEY, 2		  //X[0] ^= CNT
   EOR X2_0, KEY   
   
					  //round 1 
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing

   LSR X1_3           // X[0] = X[0] <<< 1
   ROR X1_2
   ROR X1_1
   BST X1_0, 0
   ROR X1_0   
   BLD X1_3, 7   

   MOV TEMP_0, X2_3   // temp = X[1]  <<< 8 
   MOV TEMP_1, X2_0
   MOV TEMP_2, X2_1
   MOV TEMP_3, X2_2
                  
   EOR TEMP_3, RK1_3  // TEMP ^= RK   
   EOR TEMP_2, RK1_2
   EOR TEMP_1, RK1_1
   EOR TEMP_0, RK1_0   

   SUB X1_0, TEMP_0   //X[0] -= temp
   SBC X1_1, TEMP_1
   SBC X1_2, TEMP_2
   SBC X1_3, TEMP_3

   LDI KEY, 1		  //X[0] ^= CNT
   EOR X1_0, KEY   

   
					  //round 0         
					  // X[0] = X[3], X[1] = X[0], X[2] = X[1], X[3] = X[2] (생략) direct indexing
					  // X[0] = X[0] >>> 8 (생략) direct indexing

   MOVW TEMP_0, X1_0   //temp = X[1]
   MOVW TEMP_2, X1_2

   LSL TEMP_0         //temp = temp <<< 1 
   ROL TEMP_1
   ROL TEMP_2
   ROL TEMP_3
   ADC TEMP_0, R1
                  
   EOR TEMP_3, RK0_3  // TEMP ^= RK
   EOR TEMP_2, RK0_2
   EOR TEMP_1, RK0_1
   EOR TEMP_0, RK0_0

   SUB X0_0, TEMP_0   //X[0] -= temp
   SBC X0_1, TEMP_1
   SBC X0_2, TEMP_2
   SBC X0_3, TEMP_3

   

   POP R27
   POP R26

   ST X+, X0_0
   ST X+, X0_1
   ST X+, X0_2
   ST X+, X0_3

   ST X+, X1_0
   ST X+, X1_1
   ST X+, X1_2
   ST X+, X1_3

   ST X+, X2_0
   ST X+, X2_1
   ST X+, X2_2
   ST X+, X2_3

   ST X+, X3_0
   ST X+, X3_1
   ST X+, X3_2
   ST X+, X3_3

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