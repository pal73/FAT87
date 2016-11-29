   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  16                     	bsct
  17  0000               _bVENT_BLOCK:
  18  0000 00            	dc.b	0
2043                     	bsct
2044  0001               _t0_cnt0:
2045  0001 0000          	dc.w	0
2046  0003               _t0_cnt1:
2047  0003 00            	dc.b	0
2048  0004               _t0_cnt2:
2049  0004 00            	dc.b	0
2050  0005               _t0_cnt3:
2051  0005 00            	dc.b	0
2052  0006               _t0_cnt4:
2053  0006 00            	dc.b	0
2054  0007               _tx_buffer1:
2055  0007 00            	dc.b	0
2056  0008 000000000000  	ds.b	49
2057  0039               _tx_wd_cnt:
2058  0039 64            	dc.b	100
2059  003a               _rotor_int:
2060  003a 007b          	dc.w	123
2061  003c               _freqMultipler:
2062  003c 00000064      	dc.l	100
2121                     ; 63 void gran(signed short *adr, signed short min, signed short max)
2121                     ; 64 {
2123                     	switch	.text
2124  0000               _gran:
2126  0000 89            	pushw	x
2127       00000000      OFST:	set	0
2130                     ; 65 if (*adr<min) *adr=min;
2132  0001 9c            	rvf
2133  0002 9093          	ldw	y,x
2134  0004 51            	exgw	x,y
2135  0005 fe            	ldw	x,(x)
2136  0006 1305          	cpw	x,(OFST+5,sp)
2137  0008 51            	exgw	x,y
2138  0009 2e03          	jrsge	L7731
2141  000b 1605          	ldw	y,(OFST+5,sp)
2142  000d ff            	ldw	(x),y
2143  000e               L7731:
2144                     ; 66 if (*adr>max) *adr=max; 
2146  000e 9c            	rvf
2147  000f 1e01          	ldw	x,(OFST+1,sp)
2148  0011 9093          	ldw	y,x
2149  0013 51            	exgw	x,y
2150  0014 fe            	ldw	x,(x)
2151  0015 1307          	cpw	x,(OFST+7,sp)
2152  0017 51            	exgw	x,y
2153  0018 2d05          	jrsle	L1041
2156  001a 1e01          	ldw	x,(OFST+1,sp)
2157  001c 1607          	ldw	y,(OFST+7,sp)
2158  001e ff            	ldw	(x),y
2159  001f               L1041:
2160                     ; 67 } 
2163  001f 85            	popw	x
2164  0020 81            	ret
2217                     ; 70 void granee(@eeprom signed short *adr, signed short min, signed short max)
2217                     ; 71 {
2218                     	switch	.text
2219  0021               _granee:
2221  0021 89            	pushw	x
2222       00000000      OFST:	set	0
2225                     ; 72 if (*adr<min) *adr=min;
2227  0022 9c            	rvf
2228  0023 9093          	ldw	y,x
2229  0025 51            	exgw	x,y
2230  0026 fe            	ldw	x,(x)
2231  0027 1305          	cpw	x,(OFST+5,sp)
2232  0029 51            	exgw	x,y
2233  002a 2e09          	jrsge	L1341
2236  002c 1e05          	ldw	x,(OFST+5,sp)
2237  002e 89            	pushw	x
2238  002f 1e03          	ldw	x,(OFST+3,sp)
2239  0031 cd0000        	call	c_eewrw
2241  0034 85            	popw	x
2242  0035               L1341:
2243                     ; 73 if (*adr>max) *adr=max; 
2245  0035 9c            	rvf
2246  0036 1e01          	ldw	x,(OFST+1,sp)
2247  0038 9093          	ldw	y,x
2248  003a 51            	exgw	x,y
2249  003b fe            	ldw	x,(x)
2250  003c 1307          	cpw	x,(OFST+7,sp)
2251  003e 51            	exgw	x,y
2252  003f 2d09          	jrsle	L3341
2255  0041 1e07          	ldw	x,(OFST+7,sp)
2256  0043 89            	pushw	x
2257  0044 1e03          	ldw	x,(OFST+3,sp)
2258  0046 cd0000        	call	c_eewrw
2260  0049 85            	popw	x
2261  004a               L3341:
2262                     ; 74 }
2265  004a 85            	popw	x
2266  004b 81            	ret
2327                     ; 77 long delay_ms(short in)
2327                     ; 78 {
2328                     	switch	.text
2329  004c               _delay_ms:
2331  004c 520c          	subw	sp,#12
2332       0000000c      OFST:	set	12
2335                     ; 81 i=((long)in)*100UL;
2337  004e 90ae0064      	ldw	y,#100
2338  0052 cd0000        	call	c_vmul
2340  0055 96            	ldw	x,sp
2341  0056 1c0005        	addw	x,#OFST-7
2342  0059 cd0000        	call	c_rtol
2344                     ; 83 for(ii=0;ii<i;ii++)
2346  005c ae0000        	ldw	x,#0
2347  005f 1f0b          	ldw	(OFST-1,sp),x
2348  0061 ae0000        	ldw	x,#0
2349  0064 1f09          	ldw	(OFST-3,sp),x
2351  0066 2012          	jra	L3741
2352  0068               L7641:
2353                     ; 85 		iii++;
2355  0068 96            	ldw	x,sp
2356  0069 1c0001        	addw	x,#OFST-11
2357  006c a601          	ld	a,#1
2358  006e cd0000        	call	c_lgadc
2360                     ; 83 for(ii=0;ii<i;ii++)
2362  0071 96            	ldw	x,sp
2363  0072 1c0009        	addw	x,#OFST-3
2364  0075 a601          	ld	a,#1
2365  0077 cd0000        	call	c_lgadc
2367  007a               L3741:
2370  007a 9c            	rvf
2371  007b 96            	ldw	x,sp
2372  007c 1c0009        	addw	x,#OFST-3
2373  007f cd0000        	call	c_ltor
2375  0082 96            	ldw	x,sp
2376  0083 1c0005        	addw	x,#OFST-7
2377  0086 cd0000        	call	c_lcmp
2379  0089 2fdd          	jrslt	L7641
2380                     ; 88 }
2383  008b 5b0c          	addw	sp,#12
2384  008d 81            	ret
2407                     ; 91 void uart1_init (void)
2407                     ; 92 {
2408                     	switch	.text
2409  008e               _uart1_init:
2413                     ; 94 GPIOA->DDR&=~(1<<4);
2415  008e 72195002      	bres	20482,#4
2416                     ; 95 GPIOA->CR1|=(1<<4);
2418  0092 72185003      	bset	20483,#4
2419                     ; 96 GPIOA->CR2&=~(1<<4);
2421  0096 72195004      	bres	20484,#4
2422                     ; 99 GPIOA->DDR|=(1<<5);
2424  009a 721a5002      	bset	20482,#5
2425                     ; 100 GPIOA->CR1|=(1<<5);
2427  009e 721a5003      	bset	20483,#5
2428                     ; 101 GPIOA->CR2&=~(1<<5);	
2430  00a2 721b5004      	bres	20484,#5
2431                     ; 104 UART1->CR1&=~UART1_CR1_M;					
2433  00a6 72195234      	bres	21044,#4
2434                     ; 105 UART1->CR3|= (0<<4) & UART1_CR3_STOP;  	
2436  00aa c65236        	ld	a,21046
2437                     ; 106 UART1->BRR2= 0x09;
2439  00ad 35095233      	mov	21043,#9
2440                     ; 107 UART1->BRR1= 0x20;
2442  00b1 35205232      	mov	21042,#32
2443                     ; 108 UART1->CR2|= UART1_CR2_TEN | UART1_CR2_REN | UART1_CR2_RIEN/*| UART2_CR2_TIEN*/ ;	
2445  00b5 c65235        	ld	a,21045
2446  00b8 aa2c          	or	a,#44
2447  00ba c75235        	ld	21045,a
2448                     ; 109 }
2451  00bd 81            	ret
2474                     ; 113 void t4_init(void){
2475                     	switch	.text
2476  00be               _t4_init:
2480                     ; 114 	TIM4->PSCR = 4;
2482  00be 35045345      	mov	21317,#4
2483                     ; 115 	TIM4->ARR= 77;
2485  00c2 354d5346      	mov	21318,#77
2486                     ; 116 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
2488  00c6 72105341      	bset	21313,#0
2489                     ; 118 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
2491  00ca 35855340      	mov	21312,#133
2492                     ; 120 }
2495  00ce 81            	ret
2518                     ; 124 void led_drv(void)
2518                     ; 125 {
2519                     	switch	.text
2520  00cf               _led_drv:
2524                     ; 126 } 
2527  00cf 81            	ret
2550                     ; 134 void pwr_drv(void)
2550                     ; 135 {
2551                     	switch	.text
2552  00d0               _pwr_drv:
2556                     ; 161 }
2559  00d0 81            	ret
2582                     ; 166 void pwr_hndl(void)				
2582                     ; 167 {
2583                     	switch	.text
2584  00d1               _pwr_hndl:
2588                     ; 169 }
2591  00d1 81            	ret
2614                     ; 172 void matemat(void)
2614                     ; 173 {
2615                     	switch	.text
2616  00d2               _matemat:
2620                     ; 176 }
2623  00d2 81            	ret
2660                     ; 179 char putchar(char c)
2660                     ; 180 {
2661                     	switch	.text
2662  00d3               _putchar:
2664  00d3 88            	push	a
2665       00000000      OFST:	set	0
2668  00d4               L7751:
2669                     ; 181 while (tx_counter1 == TX_BUFFER_SIZE1);
2671  00d4 b64f          	ld	a,_tx_counter1
2672  00d6 a132          	cp	a,#50
2673  00d8 27fa          	jreq	L7751
2674                     ; 183 if (tx_counter1 || ((UART1->SR & UART1_SR_TXE)==0))
2676  00da 3d4f          	tnz	_tx_counter1
2677  00dc 2607          	jrne	L5061
2679  00de c65230        	ld	a,21040
2680  00e1 a580          	bcp	a,#128
2681  00e3 2621          	jrne	L3061
2682  00e5               L5061:
2683                     ; 185    tx_buffer1[tx_wr_index1]=c;
2685  00e5 5f            	clrw	x
2686  00e6 b64e          	ld	a,_tx_wr_index1
2687  00e8 2a01          	jrpl	L03
2688  00ea 53            	cplw	x
2689  00eb               L03:
2690  00eb 97            	ld	xl,a
2691  00ec 7b01          	ld	a,(OFST+1,sp)
2692  00ee e707          	ld	(_tx_buffer1,x),a
2693                     ; 186    if (++tx_wr_index1 == TX_BUFFER_SIZE1) tx_wr_index1=0;
2695  00f0 3c4e          	inc	_tx_wr_index1
2696  00f2 b64e          	ld	a,_tx_wr_index1
2697  00f4 a132          	cp	a,#50
2698  00f6 2602          	jrne	L7061
2701  00f8 3f4e          	clr	_tx_wr_index1
2702  00fa               L7061:
2703                     ; 187    ++tx_counter1;
2705  00fa 3c4f          	inc	_tx_counter1
2707  00fc               L1161:
2708                     ; 191 UART1->CR2|= UART1_CR2_TIEN | UART1_CR2_TCIEN;
2710  00fc c65235        	ld	a,21045
2711  00ff aac0          	or	a,#192
2712  0101 c75235        	ld	21045,a
2713                     ; 192 }
2716  0104 84            	pop	a
2717  0105 81            	ret
2718  0106               L3061:
2719                     ; 189 else UART1->DR=c;
2721  0106 7b01          	ld	a,(OFST+1,sp)
2722  0108 c75231        	ld	21041,a
2723  010b 20ef          	jra	L1161
2746                     ; 196 void adr_drv_v3(void)
2746                     ; 197 {
2747                     	switch	.text
2748  010d               _adr_drv_v3:
2752                     ; 203 GPIOB->DDR&=~(1<<0);
2754  010d 72115007      	bres	20487,#0
2755                     ; 204 GPIOB->CR1&=~(1<<0);
2757  0111 72115008      	bres	20488,#0
2758                     ; 205 GPIOB->CR2&=~(1<<0);
2760  0115 72115009      	bres	20489,#0
2761                     ; 206 ADC2->CR2=0x08;
2763  0119 35085402      	mov	21506,#8
2764                     ; 207 ADC2->CR1=0x40;
2766  011d 35405401      	mov	21505,#64
2767                     ; 208 ADC2->CSR=0x20+0;
2769  0121 35205400      	mov	21504,#32
2770                     ; 209 ADC2->CR1|=1;
2772  0125 72105401      	bset	21505,#0
2773                     ; 210 ADC2->CR1|=1;
2775  0129 72105401      	bset	21505,#0
2776                     ; 214 GPIOB->DDR&=~(1<<1);
2778  012d 72135007      	bres	20487,#1
2779                     ; 215 GPIOB->CR1&=~(1<<1);
2781  0131 72135008      	bres	20488,#1
2782                     ; 216 GPIOB->CR2&=~(1<<1);
2784  0135 72135009      	bres	20489,#1
2785                     ; 217 ADC2->CR2=0x08;
2787  0139 35085402      	mov	21506,#8
2788                     ; 218 ADC2->CR1=0x40;
2790  013d 35405401      	mov	21505,#64
2791                     ; 219 ADC2->CSR=0x20+1;
2793  0141 35215400      	mov	21504,#33
2794                     ; 220 ADC2->CR1|=1;
2796  0145 72105401      	bset	21505,#0
2797                     ; 221 ADC2->CR1|=1;
2799  0149 72105401      	bset	21505,#0
2800                     ; 225 GPIOE->DDR&=~(1<<6);
2802  014d 721d5016      	bres	20502,#6
2803                     ; 226 GPIOE->CR1&=~(1<<6);
2805  0151 721d5017      	bres	20503,#6
2806                     ; 227 GPIOE->CR2&=~(1<<6);
2808  0155 721d5018      	bres	20504,#6
2809                     ; 228 ADC2->CR2=0x08;
2811  0159 35085402      	mov	21506,#8
2812                     ; 229 ADC2->CR1=0x40;
2814  015d 35405401      	mov	21505,#64
2815                     ; 230 ADC2->CSR=0x20+9;
2817  0161 35295400      	mov	21504,#41
2818                     ; 231 ADC2->CR1|=1;
2820  0165 72105401      	bset	21505,#0
2821                     ; 232 ADC2->CR1|=1;
2823  0169 72105401      	bset	21505,#0
2824                     ; 236 }
2827  016d 81            	ret
2850                     ; 242 void exti_init(void){
2851                     	switch	.text
2852  016e               _exti_init:
2856                     ; 243 EXTI->CR1=0x40;	
2858  016e 354050a0      	mov	20640,#64
2859                     ; 244 GPIOD->DDR&=~(1<<4);
2861  0172 72195011      	bres	20497,#4
2862                     ; 245 GPIOD->CR1&=~(1<<4);
2864  0176 72195012      	bres	20498,#4
2865                     ; 246 GPIOD->CR2|=(1<<4);	
2867  017a 72185013      	bset	20499,#4
2868                     ; 248 }
2871  017e 81            	ret
2894                     ; 251 void t1_init(void)
2894                     ; 252 {
2895                     	switch	.text
2896  017f               _t1_init:
2900                     ; 253 TIM1->ARRH= 0;
2902  017f 725f5262      	clr	21090
2903                     ; 254 TIM1->ARRL= 100;
2905  0183 35645263      	mov	21091,#100
2906                     ; 255 TIM1->CCR1H= 0x00;	
2908  0187 725f5265      	clr	21093
2909                     ; 256 TIM1->CCR1L= 0xff;
2911  018b 35ff5266      	mov	21094,#255
2912                     ; 257 TIM1->CCR2H= 0;	
2914  018f 725f5267      	clr	21095
2915                     ; 258 TIM1->CCR2L= 25;
2917  0193 35195268      	mov	21096,#25
2918                     ; 259 TIM1->CCR3H= 0x00;	
2920  0197 725f5269      	clr	21097
2921                     ; 260 TIM1->CCR3L= 0x64;
2923  019b 3564526a      	mov	21098,#100
2924                     ; 262 TIM1->PSCRH= 0;	
2926  019f 725f5260      	clr	21088
2927                     ; 263 TIM1->PSCRL= 63;
2929  01a3 353f5261      	mov	21089,#63
2930                     ; 265 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
2932  01a7 35685258      	mov	21080,#104
2933                     ; 266 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
2935  01ab 35685259      	mov	21081,#104
2936                     ; 267 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
2938  01af 3568525a      	mov	21082,#104
2939                     ; 268 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
2941  01b3 3511525c      	mov	21084,#17
2942                     ; 269 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
2944  01b7 3501525d      	mov	21085,#1
2945                     ; 270 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
2947  01bb 35815250      	mov	21072,#129
2948                     ; 271 TIM1->BKR|= TIM1_BKR_AOE;
2950  01bf 721c526d      	bset	21101,#6
2951                     ; 272 }
2954  01c3 81            	ret
2977                     ; 277 void t2_init_(void){
2978                     	switch	.text
2979  01c4               _t2_init_:
2983                     ; 278 	TIM2->PSCR = 4;
2985  01c4 3504530c      	mov	21260,#4
2986                     ; 279 	TIM2->ARRH= 20;
2988  01c8 3514530d      	mov	21261,#20
2989                     ; 280 	TIM2->ARRL= 0;
2991  01cc 725f530e      	clr	21262
2992                     ; 281 	TIM2->CCR1H= 10;	
2994  01d0 350a530f      	mov	21263,#10
2995                     ; 282 	TIM2->CCR1L= 0;
2997  01d4 725f5310      	clr	21264
2998                     ; 284 	TIM2->CCER1= TIM2_CCER1_CC1E; //OC1, OC2 output pins enabled
3000  01d8 35015308      	mov	21256,#1
3001                     ; 285 	TIM2->CCMR1= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
3003  01dc 35685305      	mov	21253,#104
3004                     ; 291 	TIM2->CR1=(TIM2_CR1_CEN /*| TIM2_CR1_ARPE*/);	
3006  01e0 35015300      	mov	21248,#1
3007                     ; 293 }
3010  01e4 81            	ret
3033                     ; 297 void t3_init_(void){
3034                     	switch	.text
3035  01e5               _t3_init_:
3039                     ; 298 	TIM3->PSCR = 16;
3041  01e5 3510532a      	mov	21290,#16
3042                     ; 299 	TIM3->ARRH= 120;
3044  01e9 3578532b      	mov	21291,#120
3045                     ; 300 	TIM3->ARRL= 0;
3047  01ed 725f532c      	clr	21292
3048                     ; 301 	TIM3->CCR1H= 10;	
3050  01f1 350a532d      	mov	21293,#10
3051                     ; 302 	TIM3->CCR1L= 0;
3053  01f5 725f532e      	clr	21294
3054                     ; 306 	TIM3->CR1=(TIM3_CR1_CEN | TIM3_CR1_ARPE);	
3056  01f9 35815320      	mov	21280,#129
3057                     ; 308 }
3060  01fd 81            	ret
3083                     ; 314 void t2_init(void)
3083                     ; 315 {
3084                     	switch	.text
3085  01fe               _t2_init:
3089                     ; 316 TIM2->PSCR = 0x06;
3091  01fe 3506530c      	mov	21260,#6
3092                     ; 317 TIM2->CCMR1 = TIM2_CCER1_CC1E;
3094  0202 35015305      	mov	21253,#1
3095                     ; 318 TIM2->CCER1 = TIM2_CCER1_CC1E;
3097  0206 35015308      	mov	21256,#1
3098                     ; 319 TIM2->IER = TIM2_IER_CC1IE;
3100  020a 35025301      	mov	21249,#2
3101                     ; 320 TIM2->CR1 = TIM2_CR1_CEN;
3103  020e 35015300      	mov	21248,#1
3104                     ; 321 }
3107  0212 81            	ret
3131                     ; 324 void adc2_init(void)
3131                     ; 325 {
3132                     	switch	.text
3133  0213               _adc2_init:
3137                     ; 326 adc_plazma[0]++;
3139  0213 be3d          	ldw	x,_adc_plazma
3140  0215 1c0001        	addw	x,#1
3141  0218 bf3d          	ldw	_adc_plazma,x
3142                     ; 329 GPIOB->DDR&=~(1<<2);
3144  021a 72155007      	bres	20487,#2
3145                     ; 330 GPIOB->CR1&=~(1<<2);
3147  021e 72155008      	bres	20488,#2
3148                     ; 331 GPIOB->CR2&=~(1<<2);
3150  0222 72155009      	bres	20489,#2
3151                     ; 334 ADC2->TDRL=0xff;
3153  0226 35ff5407      	mov	21511,#255
3154                     ; 336 ADC2->CR2=0x08;
3156  022a 35085402      	mov	21506,#8
3157                     ; 337 ADC2->CR1=0x40;
3159  022e 35405401      	mov	21505,#64
3160                     ; 340 	ADC2->CSR=0x22;
3162  0232 35225400      	mov	21504,#34
3163                     ; 342 	ADC2->CR1|=1;
3165  0236 72105401      	bset	21505,#0
3166                     ; 343 	ADC2->CR1|=1;
3168  023a 72105401      	bset	21505,#0
3169                     ; 345 }
3172  023e 81            	ret
3205                     ; 354 @far @interrupt void TIM4_UPD_Interrupt (void) 
3205                     ; 355 {
3207                     	switch	.text
3208  023f               f_TIM4_UPD_Interrupt:
3212                     ; 356 TIM4->SR1&=~TIM4_SR1_UIF;
3214  023f 72115342      	bres	21314,#0
3215                     ; 358 if(++t0_cnt0>=100)
3217  0243 9c            	rvf
3218  0244 be01          	ldw	x,_t0_cnt0
3219  0246 1c0001        	addw	x,#1
3220  0249 bf01          	ldw	_t0_cnt0,x
3221  024b a30064        	cpw	x,#100
3222  024e 2f3f          	jrslt	L3171
3223                     ; 360 	t0_cnt0=0;
3225  0250 5f            	clrw	x
3226  0251 bf01          	ldw	_t0_cnt0,x
3227                     ; 361 	b100Hz=1;
3229  0253 72100005      	bset	_b100Hz
3230                     ; 363 	if(++t0_cnt1>=10)
3232  0257 3c03          	inc	_t0_cnt1
3233  0259 b603          	ld	a,_t0_cnt1
3234  025b a10a          	cp	a,#10
3235  025d 2506          	jrult	L5171
3236                     ; 365 		t0_cnt1=0;
3238  025f 3f03          	clr	_t0_cnt1
3239                     ; 366 		b10Hz=1;
3241  0261 72100004      	bset	_b10Hz
3242  0265               L5171:
3243                     ; 369 	if(++t0_cnt2>=20)
3245  0265 3c04          	inc	_t0_cnt2
3246  0267 b604          	ld	a,_t0_cnt2
3247  0269 a114          	cp	a,#20
3248  026b 2506          	jrult	L7171
3249                     ; 371 		t0_cnt2=0;
3251  026d 3f04          	clr	_t0_cnt2
3252                     ; 372 		b5Hz=1;
3254  026f 72100003      	bset	_b5Hz
3255  0273               L7171:
3256                     ; 376 	if(++t0_cnt4>=50)
3258  0273 3c06          	inc	_t0_cnt4
3259  0275 b606          	ld	a,_t0_cnt4
3260  0277 a132          	cp	a,#50
3261  0279 2506          	jrult	L1271
3262                     ; 378 		t0_cnt4=0;
3264  027b 3f06          	clr	_t0_cnt4
3265                     ; 379 		b2Hz=1;
3267  027d 72100002      	bset	_b2Hz
3268  0281               L1271:
3269                     ; 382 	if(++t0_cnt3>=100)
3271  0281 3c05          	inc	_t0_cnt3
3272  0283 b605          	ld	a,_t0_cnt3
3273  0285 a164          	cp	a,#100
3274  0287 2506          	jrult	L3171
3275                     ; 384 		t0_cnt3=0;
3277  0289 3f05          	clr	_t0_cnt3
3278                     ; 385 		b1Hz=1;
3280  028b 72100001      	bset	_b1Hz
3281  028f               L3171:
3282                     ; 391 }
3285  028f 80            	iret
3340                     .const:	section	.text
3341  0000               L45:
3342  0000 00000010      	dc.l	16
3343                     ; 395 @far @interrupt void ADC2_EOC_Interrupt (void) {
3344                     	switch	.text
3345  0290               f_ADC2_EOC_Interrupt:
3347       00000009      OFST:	set	9
3348  0290 be00          	ldw	x,c_x
3349  0292 89            	pushw	x
3350  0293 be00          	ldw	x,c_y
3351  0295 89            	pushw	x
3352  0296 be02          	ldw	x,c_lreg+2
3353  0298 89            	pushw	x
3354  0299 be00          	ldw	x,c_lreg
3355  029b 89            	pushw	x
3356  029c 5209          	subw	sp,#9
3359                     ; 400 ADC2->CSR&=~(1<<7);
3361  029e 721f5400      	bres	21504,#7
3362                     ; 402 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
3364  02a2 c65405        	ld	a,21509
3365  02a5 b703          	ld	c_lreg+3,a
3366  02a7 3f02          	clr	c_lreg+2
3367  02a9 3f01          	clr	c_lreg+1
3368  02ab 3f00          	clr	c_lreg
3369  02ad 96            	ldw	x,sp
3370  02ae 1c0001        	addw	x,#OFST-8
3371  02b1 cd0000        	call	c_rtol
3373  02b4 c65404        	ld	a,21508
3374  02b7 5f            	clrw	x
3375  02b8 97            	ld	xl,a
3376  02b9 90ae0100      	ldw	y,#256
3377  02bd cd0000        	call	c_umul
3379  02c0 96            	ldw	x,sp
3380  02c1 1c0001        	addw	x,#OFST-8
3381  02c4 cd0000        	call	c_ladd
3383  02c7 96            	ldw	x,sp
3384  02c8 1c0006        	addw	x,#OFST-3
3385  02cb cd0000        	call	c_rtol
3387                     ; 406 adc_buff[adc_cnt]=temp_adc;
3389  02ce b649          	ld	a,_adc_cnt
3390  02d0 5f            	clrw	x
3391  02d1 97            	ld	xl,a
3392  02d2 58            	sllw	x
3393  02d3 1608          	ldw	y,(OFST-1,sp)
3394  02d5 ef02          	ldw	(_adc_buff,x),y
3395                     ; 408 adc_cnt++;
3397  02d7 3c49          	inc	_adc_cnt
3398                     ; 409 if(adc_cnt>=16)
3400  02d9 b649          	ld	a,_adc_cnt
3401  02db a110          	cp	a,#16
3402  02dd 2502          	jrult	L3571
3403                     ; 411 	adc_cnt=0;
3405  02df 3f49          	clr	_adc_cnt
3406  02e1               L3571:
3407                     ; 414 if((adc_cnt&0x03)==0)
3409  02e1 b649          	ld	a,_adc_cnt
3410  02e3 a503          	bcp	a,#3
3411  02e5 2636          	jrne	L5571
3412                     ; 418 	tempSS=0;
3414  02e7 ae0000        	ldw	x,#0
3415  02ea 1f08          	ldw	(OFST-1,sp),x
3416  02ec ae0000        	ldw	x,#0
3417  02ef 1f06          	ldw	(OFST-3,sp),x
3418                     ; 419 	for(i=0;i<16;i++)
3420  02f1 0f05          	clr	(OFST-4,sp)
3421  02f3               L7571:
3422                     ; 421 		tempSS+=(signed long)adc_buff[i];
3424  02f3 7b05          	ld	a,(OFST-4,sp)
3425  02f5 5f            	clrw	x
3426  02f6 97            	ld	xl,a
3427  02f7 58            	sllw	x
3428  02f8 ee02          	ldw	x,(_adc_buff,x)
3429  02fa cd0000        	call	c_uitolx
3431  02fd 96            	ldw	x,sp
3432  02fe 1c0006        	addw	x,#OFST-3
3433  0301 cd0000        	call	c_lgadd
3435                     ; 419 	for(i=0;i<16;i++)
3437  0304 0c05          	inc	(OFST-4,sp)
3440  0306 7b05          	ld	a,(OFST-4,sp)
3441  0308 a110          	cp	a,#16
3442  030a 25e7          	jrult	L7571
3443                     ; 423 	adc_buff_=(u16)(tempSS/16);
3445  030c 96            	ldw	x,sp
3446  030d 1c0006        	addw	x,#OFST-3
3447  0310 cd0000        	call	c_ltor
3449  0313 ae0000        	ldw	x,#L45
3450  0316 cd0000        	call	c_ldiv
3452  0319 be02          	ldw	x,c_lreg+2
3453  031b bf00          	ldw	_adc_buff_,x
3454  031d               L5571:
3455                     ; 426 inAdcResult=(u16)adc_buff_;
3457  031d be00          	ldw	x,_adc_buff_
3458  031f bf28          	ldw	_inAdcResult,x
3459                     ; 427 }
3462  0321 5b09          	addw	sp,#9
3463  0323 85            	popw	x
3464  0324 bf00          	ldw	c_lreg,x
3465  0326 85            	popw	x
3466  0327 bf02          	ldw	c_lreg+2,x
3467  0329 85            	popw	x
3468  032a bf00          	ldw	c_y,x
3469  032c 85            	popw	x
3470  032d bf00          	ldw	c_x,x
3471  032f 80            	iret
3496                     ; 430 @far @interrupt void PortD_Ext_Interrupt (void) {
3497                     	switch	.text
3498  0330               f_PortD_Ext_Interrupt:
3502                     ; 433 GPIOA->ODR^=(1<<5);
3504  0330 c65000        	ld	a,20480
3505  0333 a820          	xor	a,	#32
3506  0335 c75000        	ld	20480,a
3507                     ; 436 buffer_for_timer1_H=TIM2->CNTRH;
3509  0338 55530a002d    	mov	_buffer_for_timer1_H,21258
3510                     ; 437 buffer_for_timer1_L=TIM2->CNTRL;
3512  033d 55530b002c    	mov	_buffer_for_timer1_L,21259
3513                     ; 439 TIM2->CNTRH=0;
3515  0342 725f530a      	clr	21258
3516                     ; 440 TIM2->CNTRL=0;
3518  0346 725f530b      	clr	21259
3519                     ; 442 }
3522  034a 80            	iret
3560                     ; 445 @far @interrupt void UART1TxInterrupt (void) 
3560                     ; 446 {
3561                     	switch	.text
3562  034b               f_UART1TxInterrupt:
3564       00000001      OFST:	set	1
3565  034b 88            	push	a
3568                     ; 449 tx_status=UART1->SR;
3570  034c c65230        	ld	a,21040
3571  034f 6b01          	ld	(OFST+0,sp),a
3572                     ; 451 if (tx_status & (UART1_SR_TXE))
3574  0351 7b01          	ld	a,(OFST+0,sp)
3575  0353 a580          	bcp	a,#128
3576  0355 272a          	jreq	L3102
3577                     ; 453 	if (tx_counter1)
3579  0357 3d4f          	tnz	_tx_counter1
3580  0359 271a          	jreq	L5102
3581                     ; 455 		--tx_counter1;
3583  035b 3a4f          	dec	_tx_counter1
3584                     ; 456 		UART1->DR=tx_buffer1[tx_rd_index1];
3586  035d 5f            	clrw	x
3587  035e b64d          	ld	a,_tx_rd_index1
3588  0360 2a01          	jrpl	L26
3589  0362 53            	cplw	x
3590  0363               L26:
3591  0363 97            	ld	xl,a
3592  0364 e607          	ld	a,(_tx_buffer1,x)
3593  0366 c75231        	ld	21041,a
3594                     ; 457 		if (++tx_rd_index1 == TX_BUFFER_SIZE1) tx_rd_index1=0;
3596  0369 3c4d          	inc	_tx_rd_index1
3597  036b b64d          	ld	a,_tx_rd_index1
3598  036d a132          	cp	a,#50
3599  036f 2610          	jrne	L3102
3602  0371 3f4d          	clr	_tx_rd_index1
3603  0373 200c          	jra	L3102
3604  0375               L5102:
3605                     ; 461 		tx_stat_cnt=3;
3607  0375 3503004c      	mov	_tx_stat_cnt,#3
3608                     ; 462 			bOUT_FREE=1;
3610  0379 3501004b      	mov	_bOUT_FREE,#1
3611                     ; 463 			UART1->CR2&= ~UART1_CR2_TIEN;
3613  037d 721f5235      	bres	21045,#7
3614  0381               L3102:
3615                     ; 467 if (tx_status & (UART1_SR_TC))
3617  0381 7b01          	ld	a,(OFST+0,sp)
3618  0383 a540          	bcp	a,#64
3619  0385 2704          	jreq	L3202
3620                     ; 469 	UART1->SR&=~UART1_SR_TC;
3622  0387 721d5230      	bres	21040,#6
3623  038b               L3202:
3624                     ; 471 }
3627  038b 84            	pop	a
3628  038c 80            	iret
3670                     ; 474 @far @interrupt void UART1RxInterrupt (void) 
3670                     ; 475 {
3671                     	switch	.text
3672  038d               f_UART1RxInterrupt:
3674       00000002      OFST:	set	2
3675  038d 89            	pushw	x
3678                     ; 478 rx_status=UART1->SR;
3680  038e c65230        	ld	a,21040
3681                     ; 479 rx_data=UART1->DR;
3683  0391 c65231        	ld	a,21041
3684                     ; 481 }
3687  0394 5b02          	addw	sp,#2
3688  0396 80            	iret
3731                     ; 484 @far @interrupt void TIM2_CC_Interrupt (void)
3731                     ; 485 {
3732                     	switch	.text
3733  0397               f_TIM2_CC_Interrupt:
3735       00000002      OFST:	set	2
3736  0397 89            	pushw	x
3739                     ; 488 h = TIM2->CCR1H;
3741  0398 c6530f        	ld	a,21263
3742  039b 6b01          	ld	(OFST-1,sp),a
3743                     ; 489 l = TIM2->CCR1L;
3745  039d c65310        	ld	a,21264
3746  03a0 6b02          	ld	(OFST+0,sp),a
3747                     ; 490 inPulseCount = ((u16)h << 8) | l;
3749  03a2 7b01          	ld	a,(OFST-1,sp)
3750  03a4 5f            	clrw	x
3751  03a5 97            	ld	xl,a
3752  03a6 7b02          	ld	a,(OFST+0,sp)
3753  03a8 02            	rlwa	x,a
3754  03a9 bf2a          	ldw	_inPulseCount,x
3755                     ; 491 TIM2->SR1 = TIM2_SR1_RESET_VALUE;
3757  03ab 725f5302      	clr	21250
3758                     ; 492 TIM2->SR2 = TIM2_SR2_RESET_VALUE;
3760  03af 725f5303      	clr	21251
3761                     ; 493 }
3764  03b3 5b02          	addw	sp,#2
3765  03b5 80            	iret
3820                     	switch	.const
3821  0004               L27:
3822  0004 00000064      	dc.l	100
3823                     ; 500 main()
3823                     ; 501 {
3824                     	scross	off
3825                     	switch	.text
3826  03b6               _main:
3828  03b6 5204          	subw	sp,#4
3829       00000004      OFST:	set	4
3832                     ; 503 CLK->ECKR|=1;
3834  03b8 721050c1      	bset	20673,#0
3836  03bc               L1112:
3837                     ; 504 while((CLK->ECKR & 2) == 0);
3839  03bc c650c1        	ld	a,20673
3840  03bf a502          	bcp	a,#2
3841  03c1 27f9          	jreq	L1112
3842                     ; 505 CLK->SWCR|=2;
3844  03c3 721250c5      	bset	20677,#1
3845                     ; 506 CLK->SWR=0xB4;
3847  03c7 35b450c4      	mov	20676,#180
3848                     ; 509 FLASH->DUKR=0xae;
3850  03cb 35ae5064      	mov	20580,#174
3851                     ; 510 FLASH->DUKR=0x56;
3853  03cf 35565064      	mov	20580,#86
3854                     ; 512 exti_init();
3856  03d3 cd016e        	call	_exti_init
3858                     ; 514 enableInterrupts();
3861  03d6 9a            rim
3863                     ; 521 t4_init();
3866  03d7 cd00be        	call	_t4_init
3868                     ; 523 		GPIOG->DDR|=(1<<0);
3870  03da 72105020      	bset	20512,#0
3871                     ; 524 		GPIOG->CR1|=(1<<0);
3873  03de 72105021      	bset	20513,#0
3874                     ; 525 		GPIOG->CR2&=~(1<<0);	
3876  03e2 72115022      	bres	20514,#0
3877                     ; 528 		GPIOG->DDR&=~(1<<1);
3879  03e6 72135020      	bres	20512,#1
3880                     ; 529 		GPIOG->CR1|=(1<<1);
3882  03ea 72125021      	bset	20513,#1
3883                     ; 530 		GPIOG->CR2&=~(1<<1);
3885  03ee 72135022      	bres	20514,#1
3886                     ; 536 GPIOC->DDR|=(1<<1);
3888  03f2 7212500c      	bset	20492,#1
3889                     ; 537 GPIOC->CR1|=(1<<1);
3891  03f6 7212500d      	bset	20493,#1
3892                     ; 538 GPIOC->CR2|=(1<<1);
3894  03fa 7212500e      	bset	20494,#1
3895                     ; 540 GPIOC->DDR|=(1<<2);
3897  03fe 7214500c      	bset	20492,#2
3898                     ; 541 GPIOC->CR1|=(1<<2);
3900  0402 7214500d      	bset	20493,#2
3901                     ; 542 GPIOC->CR2|=(1<<2);
3903  0406 7214500e      	bset	20494,#2
3904                     ; 549 t1_init();
3906  040a cd017f        	call	_t1_init
3908                     ; 550 t2_init();
3910  040d cd01fe        	call	_t2_init
3912                     ; 552 uart1_init();
3914  0410 cd008e        	call	_uart1_init
3916                     ; 554 GPIOA->DDR|=(1<<5);
3918  0413 721a5002      	bset	20482,#5
3919                     ; 555 GPIOA->CR1|=(1<<5);
3921  0417 721a5003      	bset	20483,#5
3922                     ; 556 GPIOA->CR2&=~(1<<5);
3924  041b 721b5004      	bres	20484,#5
3925                     ; 558 GPIOA->DDR|=(1<<6);
3927  041f 721c5002      	bset	20482,#6
3928                     ; 559 GPIOA->CR1|=(1<<6);
3930  0423 721c5003      	bset	20483,#6
3931                     ; 560 GPIOA->CR2&=~(1<<6);
3933  0427 721d5004      	bres	20484,#6
3934                     ; 566 GPIOB->DDR&=~(1<<3);
3936  042b 72175007      	bres	20487,#3
3937                     ; 567 GPIOB->CR1&=~(1<<3);
3939  042f 72175008      	bres	20488,#3
3940                     ; 568 GPIOB->CR2&=~(1<<3);
3942  0433 72175009      	bres	20489,#3
3943                     ; 570 GPIOC->DDR|=(1<<3);
3945  0437 7216500c      	bset	20492,#3
3946                     ; 571 GPIOC->CR1|=(1<<3);
3948  043b 7216500d      	bset	20493,#3
3949                     ; 572 GPIOC->CR2|=(1<<3);
3951  043f 7216500e      	bset	20494,#3
3952  0443               L5112:
3953                     ; 582 if(b100Hz)
3955                     	btst	_b100Hz
3956  0448 2407          	jruge	L1212
3957                     ; 584 		b100Hz=0;
3959  044a 72110005      	bres	_b100Hz
3960                     ; 585 		adc2_init();
3962  044e cd0213        	call	_adc2_init
3964  0451               L1212:
3965                     ; 590 	if(b10Hz)
3967                     	btst	_b10Hz
3968  0456 246f          	jruge	L3212
3969                     ; 593 		b10Hz=0;
3971  0458 72110004      	bres	_b10Hz
3972                     ; 599 		freqMultipler=(u32)30+(((u32)inAdcResult)/((u32)4));
3974  045c be28          	ldw	x,_inAdcResult
3975  045e 54            	srlw	x
3976  045f 54            	srlw	x
3977  0460 cd0000        	call	c_uitolx
3979  0463 a61e          	ld	a,#30
3980  0465 cd0000        	call	c_ladc
3982  0468 ae003c        	ldw	x,#_freqMultipler
3983  046b cd0000        	call	c_rtol
3985                     ; 601 		temp_u32=(u32)inPulseCount;
3987  046e be2a          	ldw	x,_inPulseCount
3988  0470 cd0000        	call	c_uitolx
3990  0473 96            	ldw	x,sp
3991  0474 1c0001        	addw	x,#OFST-3
3992  0477 cd0000        	call	c_rtol
3994                     ; 602 		temp_u32*=freqMultipler;
3996  047a ae003c        	ldw	x,#_freqMultipler
3997  047d cd0000        	call	c_ltor
3999  0480 96            	ldw	x,sp
4000  0481 1c0001        	addw	x,#OFST-3
4001  0484 cd0000        	call	c_lgmul
4003                     ; 603 		temp_u32/=(u32)100;
4005  0487 96            	ldw	x,sp
4006  0488 1c0001        	addw	x,#OFST-3
4007  048b cd0000        	call	c_ltor
4009  048e ae0004        	ldw	x,#L27
4010  0491 cd0000        	call	c_ludv
4012  0494 96            	ldw	x,sp
4013  0495 1c0001        	addw	x,#OFST-3
4014  0498 cd0000        	call	c_rtol
4016                     ; 605 		outPulseCount=(u16)temp_u32;
4018  049b 1e03          	ldw	x,(OFST-1,sp)
4019  049d bf26          	ldw	_outPulseCount,x
4020                     ; 607 		H=(u8)(outPulseCount>>8);
4022  049f 452625        	mov	_H,_outPulseCount
4023                     ; 608 		L=(u8)outPulseCount;
4025  04a2 452724        	mov	_L,_outPulseCount+1
4026                     ; 609 		h=(u8)(outPulseCount>>9);
4028  04a5 be26          	ldw	x,_outPulseCount
4029  04a7 4f            	clr	a
4030  04a8 01            	rrwa	x,a
4031  04a9 54            	srlw	x
4032  04aa 9f            	ld	a,xl
4033  04ab b723          	ld	_h,a
4034                     ; 610 		l=(u8)(outPulseCount>>1);
4036  04ad be26          	ldw	x,_outPulseCount
4037  04af 54            	srlw	x
4038  04b0 9f            	ld	a,xl
4039  04b1 b722          	ld	_l,a
4040                     ; 611 		TIM1->ARRH=H;
4042  04b3 5500255262    	mov	21090,_H
4043                     ; 612 		TIM1->ARRL=L;
4045  04b8 5500245263    	mov	21091,_L
4046                     ; 613 		TIM1->CCR2H=h;	
4048  04bd 5500235267    	mov	21095,_h
4049                     ; 614 		TIM1->CCR2L=l;
4051  04c2 5500225268    	mov	21096,_l
4052  04c7               L3212:
4053                     ; 619 	if(b5Hz)
4055                     	btst	_b5Hz
4056  04cc 2412          	jruge	L5212
4057                     ; 621 		b5Hz=0;
4059  04ce 72110003      	bres	_b5Hz
4060                     ; 624 		if((TIM2->CNTRL))GPIOA->ODR^=(1<<6);
4062  04d2 725d530b      	tnz	21259
4063  04d6 2708          	jreq	L5212
4066  04d8 c65000        	ld	a,20480
4067  04db a840          	xor	a,	#64
4068  04dd c75000        	ld	20480,a
4069  04e0               L5212:
4070                     ; 627 	if(b2Hz)
4072                     	btst	_b2Hz
4073  04e5 2404          	jruge	L1312
4074                     ; 629 		b2Hz=0;
4076  04e7 72110002      	bres	_b2Hz
4077  04eb               L1312:
4078                     ; 633 	if(b1Hz)
4080                     	btst	_b1Hz
4081  04f0 2503          	jrult	L47
4082  04f2 cc0443        	jp	L5112
4083  04f5               L47:
4084                     ; 635 		b1Hz=0;
4086  04f5 72110001      	bres	_b1Hz
4087                     ; 637 		if(main_cnt<1000)main_cnt++;
4089  04f9 9c            	rvf
4090  04fa be3a          	ldw	x,_main_cnt
4091  04fc a303e8        	cpw	x,#1000
4092  04ff 2e07          	jrsge	L5312
4095  0501 be3a          	ldw	x,_main_cnt
4096  0503 1c0001        	addw	x,#1
4097  0506 bf3a          	ldw	_main_cnt,x
4098  0508               L5312:
4099                     ; 641 		printf(" adc   %d   ",inAdcResult);
4101  0508 be28          	ldw	x,_inAdcResult
4102  050a 89            	pushw	x
4103  050b ae0032        	ldw	x,#L7312
4104  050e cd0000        	call	_printf
4106  0511 85            	popw	x
4107                     ; 642 		printf(" mult  %d   \n",(u16)freqMultipler);
4109  0512 be3e          	ldw	x,_freqMultipler+2
4110  0514 89            	pushw	x
4111  0515 ae0024        	ldw	x,#L1412
4112  0518 cd0000        	call	_printf
4114  051b 85            	popw	x
4115                     ; 643 		printf(" inpF  %d   \n",inPulseCount);
4117  051c be2a          	ldw	x,_inPulseCount
4118  051e 89            	pushw	x
4119  051f ae0016        	ldw	x,#L3412
4120  0522 cd0000        	call	_printf
4122  0525 85            	popw	x
4123                     ; 644 		printf(" outF  %d   \n",outPulseCount);
4125  0526 be26          	ldw	x,_outPulseCount
4126  0528 89            	pushw	x
4127  0529 ae0008        	ldw	x,#L5412
4128  052c cd0000        	call	_printf
4130  052f 85            	popw	x
4131  0530 ac430443      	jpf	L5112
4545                     	xdef	_main
4546                     	xdef	f_TIM2_CC_Interrupt
4547                     	xdef	f_UART1RxInterrupt
4548                     	xdef	f_UART1TxInterrupt
4549                     	xdef	f_PortD_Ext_Interrupt
4550                     	xdef	f_ADC2_EOC_Interrupt
4551                     	xdef	f_TIM4_UPD_Interrupt
4552                     	xdef	_adc2_init
4553                     	xdef	_t2_init
4554                     	xdef	_t3_init_
4555                     	xdef	_t2_init_
4556                     	xdef	_t1_init
4557                     	xdef	_exti_init
4558                     	xdef	_adr_drv_v3
4559                     	xdef	_matemat
4560                     	xdef	_pwr_hndl
4561                     	xdef	_pwr_drv
4562                     	xdef	_led_drv
4563                     	xdef	_t4_init
4564                     	xdef	_uart1_init
4565                     	xdef	_delay_ms
4566                     	xdef	_granee
4567                     	xdef	_gran
4568                     	xdef	_freqMultipler
4569                     	switch	.ubsct
4570  0000               _adc_buff_:
4571  0000 0000          	ds.b	2
4572                     	xdef	_adc_buff_
4573  0002               _adc_buff:
4574  0002 000000000000  	ds.b	32
4575                     	xdef	_adc_buff
4576  0022               _l:
4577  0022 00            	ds.b	1
4578                     	xdef	_l
4579  0023               _h:
4580  0023 00            	ds.b	1
4581                     	xdef	_h
4582  0024               _L:
4583  0024 00            	ds.b	1
4584                     	xdef	_L
4585  0025               _H:
4586  0025 00            	ds.b	1
4587                     	xdef	_H
4588  0026               _outPulseCount:
4589  0026 0000          	ds.b	2
4590                     	xdef	_outPulseCount
4591  0028               _inAdcResult:
4592  0028 0000          	ds.b	2
4593                     	xdef	_inAdcResult
4594  002a               _inPulseCount:
4595  002a 0000          	ds.b	2
4596                     	xdef	_inPulseCount
4597  002c               _buffer_for_timer1_L:
4598  002c 00            	ds.b	1
4599                     	xdef	_buffer_for_timer1_L
4600  002d               _buffer_for_timer1_H:
4601  002d 00            	ds.b	1
4602                     	xdef	_buffer_for_timer1_H
4603  002e               _i_main_sigma:
4604  002e 0000          	ds.b	2
4605                     	xdef	_i_main_sigma
4606  0030               _i_main_num_of_bps:
4607  0030 00            	ds.b	1
4608                     	xdef	_i_main_num_of_bps
4609  0031               _cnt_net_drv:
4610  0031 00            	ds.b	1
4611                     	xdef	_cnt_net_drv
4612                     .bit:	section	.data,bit
4613  0000               _bMAIN:
4614  0000 00            	ds.b	1
4615                     	xdef	_bMAIN
4616                     	switch	.ubsct
4617  0032               _plazma_int:
4618  0032 000000000000  	ds.b	6
4619                     	xdef	_plazma_int
4620                     	xdef	_rotor_int
4621  0038               _main_cnt1:
4622  0038 0000          	ds.b	2
4623                     	xdef	_main_cnt1
4624  003a               _main_cnt:
4625  003a 0000          	ds.b	2
4626                     	xdef	_main_cnt
4627  003c               _off_bp_cnt:
4628  003c 00            	ds.b	1
4629                     	xdef	_off_bp_cnt
4630  003d               _adc_plazma:
4631  003d 000000000000  	ds.b	10
4632                     	xdef	_adc_plazma
4633  0047               _adc_plazma_short:
4634  0047 0000          	ds.b	2
4635                     	xdef	_adc_plazma_short
4636  0049               _adc_cnt:
4637  0049 00            	ds.b	1
4638                     	xdef	_adc_cnt
4639  004a               _adc_ch:
4640  004a 00            	ds.b	1
4641                     	xdef	_adc_ch
4642  004b               _bOUT_FREE:
4643  004b 00            	ds.b	1
4644                     	xdef	_bOUT_FREE
4645                     	xdef	_tx_wd_cnt
4646  004c               _tx_stat_cnt:
4647  004c 00            	ds.b	1
4648                     	xdef	_tx_stat_cnt
4649  004d               _tx_rd_index1:
4650  004d 00            	ds.b	1
4651                     	xdef	_tx_rd_index1
4652  004e               _tx_wr_index1:
4653  004e 00            	ds.b	1
4654                     	xdef	_tx_wr_index1
4655  004f               _tx_counter1:
4656  004f 00            	ds.b	1
4657                     	xdef	_tx_counter1
4658                     	xdef	_tx_buffer1
4659                     	switch	.bit
4660  0001               _b1Hz:
4661  0001 00            	ds.b	1
4662                     	xdef	_b1Hz
4663  0002               _b2Hz:
4664  0002 00            	ds.b	1
4665                     	xdef	_b2Hz
4666  0003               _b5Hz:
4667  0003 00            	ds.b	1
4668                     	xdef	_b5Hz
4669  0004               _b10Hz:
4670  0004 00            	ds.b	1
4671                     	xdef	_b10Hz
4672  0005               _b100Hz:
4673  0005 00            	ds.b	1
4674                     	xdef	_b100Hz
4675                     	xdef	_t0_cnt4
4676                     	xdef	_t0_cnt3
4677                     	xdef	_t0_cnt2
4678                     	xdef	_t0_cnt1
4679                     	xdef	_t0_cnt0
4680                     	xdef	_putchar
4681                     	xref	_printf
4682                     	xdef	_bVENT_BLOCK
4683                     	switch	.const
4684  0008               L5412:
4685  0008 206f75744620  	dc.b	" outF  %d   ",10,0
4686  0016               L3412:
4687  0016 20696e704620  	dc.b	" inpF  %d   ",10,0
4688  0024               L1412:
4689  0024 206d756c7420  	dc.b	" mult  %d   ",10,0
4690  0032               L7312:
4691  0032 206164632020  	dc.b	" adc   %d   ",0
4692                     	xref.b	c_lreg
4693                     	xref.b	c_x
4694                     	xref.b	c_y
4714                     	xref	c_ludv
4715                     	xref	c_lgmul
4716                     	xref	c_ladc
4717                     	xref	c_ldiv
4718                     	xref	c_lgadd
4719                     	xref	c_uitolx
4720                     	xref	c_ladd
4721                     	xref	c_umul
4722                     	xref	c_lcmp
4723                     	xref	c_ltor
4724                     	xref	c_lgadc
4725                     	xref	c_rtol
4726                     	xref	c_vmul
4727                     	xref	c_eewrw
4728                     	end
