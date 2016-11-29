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
2054  0007               _rotor_int:
2055  0007 007b          	dc.w	123
2114                     ; 43 void gran(signed short *adr, signed short min, signed short max)
2114                     ; 44 {
2116                     	switch	.text
2117  0000               _gran:
2119  0000 89            	pushw	x
2120       00000000      OFST:	set	0
2123                     ; 45 if (*adr<min) *adr=min;
2125  0001 9c            	rvf
2126  0002 9093          	ldw	y,x
2127  0004 51            	exgw	x,y
2128  0005 fe            	ldw	x,(x)
2129  0006 1305          	cpw	x,(OFST+5,sp)
2130  0008 51            	exgw	x,y
2131  0009 2e03          	jrsge	L7731
2134  000b 1605          	ldw	y,(OFST+5,sp)
2135  000d ff            	ldw	(x),y
2136  000e               L7731:
2137                     ; 46 if (*adr>max) *adr=max; 
2139  000e 9c            	rvf
2140  000f 1e01          	ldw	x,(OFST+1,sp)
2141  0011 9093          	ldw	y,x
2142  0013 51            	exgw	x,y
2143  0014 fe            	ldw	x,(x)
2144  0015 1307          	cpw	x,(OFST+7,sp)
2145  0017 51            	exgw	x,y
2146  0018 2d05          	jrsle	L1041
2149  001a 1e01          	ldw	x,(OFST+1,sp)
2150  001c 1607          	ldw	y,(OFST+7,sp)
2151  001e ff            	ldw	(x),y
2152  001f               L1041:
2153                     ; 47 } 
2156  001f 85            	popw	x
2157  0020 81            	ret
2210                     ; 50 void granee(@eeprom signed short *adr, signed short min, signed short max)
2210                     ; 51 {
2211                     	switch	.text
2212  0021               _granee:
2214  0021 89            	pushw	x
2215       00000000      OFST:	set	0
2218                     ; 52 if (*adr<min) *adr=min;
2220  0022 9c            	rvf
2221  0023 9093          	ldw	y,x
2222  0025 51            	exgw	x,y
2223  0026 fe            	ldw	x,(x)
2224  0027 1305          	cpw	x,(OFST+5,sp)
2225  0029 51            	exgw	x,y
2226  002a 2e09          	jrsge	L1341
2229  002c 1e05          	ldw	x,(OFST+5,sp)
2230  002e 89            	pushw	x
2231  002f 1e03          	ldw	x,(OFST+3,sp)
2232  0031 cd0000        	call	c_eewrw
2234  0034 85            	popw	x
2235  0035               L1341:
2236                     ; 53 if (*adr>max) *adr=max; 
2238  0035 9c            	rvf
2239  0036 1e01          	ldw	x,(OFST+1,sp)
2240  0038 9093          	ldw	y,x
2241  003a 51            	exgw	x,y
2242  003b fe            	ldw	x,(x)
2243  003c 1307          	cpw	x,(OFST+7,sp)
2244  003e 51            	exgw	x,y
2245  003f 2d09          	jrsle	L3341
2248  0041 1e07          	ldw	x,(OFST+7,sp)
2249  0043 89            	pushw	x
2250  0044 1e03          	ldw	x,(OFST+3,sp)
2251  0046 cd0000        	call	c_eewrw
2253  0049 85            	popw	x
2254  004a               L3341:
2255                     ; 54 }
2258  004a 85            	popw	x
2259  004b 81            	ret
2320                     ; 57 long delay_ms(short in)
2320                     ; 58 {
2321                     	switch	.text
2322  004c               _delay_ms:
2324  004c 520c          	subw	sp,#12
2325       0000000c      OFST:	set	12
2328                     ; 61 i=((long)in)*100UL;
2330  004e 90ae0064      	ldw	y,#100
2331  0052 cd0000        	call	c_vmul
2333  0055 96            	ldw	x,sp
2334  0056 1c0005        	addw	x,#OFST-7
2335  0059 cd0000        	call	c_rtol
2337                     ; 63 for(ii=0;ii<i;ii++)
2339  005c ae0000        	ldw	x,#0
2340  005f 1f0b          	ldw	(OFST-1,sp),x
2341  0061 ae0000        	ldw	x,#0
2342  0064 1f09          	ldw	(OFST-3,sp),x
2344  0066 2012          	jra	L3741
2345  0068               L7641:
2346                     ; 65 		iii++;
2348  0068 96            	ldw	x,sp
2349  0069 1c0001        	addw	x,#OFST-11
2350  006c a601          	ld	a,#1
2351  006e cd0000        	call	c_lgadc
2353                     ; 63 for(ii=0;ii<i;ii++)
2355  0071 96            	ldw	x,sp
2356  0072 1c0009        	addw	x,#OFST-3
2357  0075 a601          	ld	a,#1
2358  0077 cd0000        	call	c_lgadc
2360  007a               L3741:
2363  007a 9c            	rvf
2364  007b 96            	ldw	x,sp
2365  007c 1c0009        	addw	x,#OFST-3
2366  007f cd0000        	call	c_ltor
2368  0082 96            	ldw	x,sp
2369  0083 1c0005        	addw	x,#OFST-7
2370  0086 cd0000        	call	c_lcmp
2372  0089 2fdd          	jrslt	L7641
2373                     ; 68 }
2376  008b 5b0c          	addw	sp,#12
2377  008d 81            	ret
2400                     ; 71 void t4_init(void){
2401                     	switch	.text
2402  008e               _t4_init:
2406                     ; 72 	TIM4->PSCR = 4;
2408  008e 35045345      	mov	21317,#4
2409                     ; 73 	TIM4->ARR= 77;
2411  0092 354d5346      	mov	21318,#77
2412                     ; 74 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
2414  0096 72105341      	bset	21313,#0
2415                     ; 76 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
2417  009a 35855340      	mov	21312,#133
2418                     ; 78 }
2421  009e 81            	ret
2444                     ; 82 void led_drv(void)
2444                     ; 83 {
2445                     	switch	.text
2446  009f               _led_drv:
2450                     ; 84 } 
2453  009f 81            	ret
2476                     ; 92 void pwr_drv(void)
2476                     ; 93 {
2477                     	switch	.text
2478  00a0               _pwr_drv:
2482                     ; 119 }
2485  00a0 81            	ret
2508                     ; 124 void pwr_hndl(void)				
2508                     ; 125 {
2509                     	switch	.text
2510  00a1               _pwr_hndl:
2514                     ; 127 }
2517  00a1 81            	ret
2540                     ; 130 void matemat(void)
2540                     ; 131 {
2541                     	switch	.text
2542  00a2               _matemat:
2546                     ; 134 }
2549  00a2 81            	ret
2572                     ; 140 void adr_drv_v3(void)
2572                     ; 141 {
2573                     	switch	.text
2574  00a3               _adr_drv_v3:
2578                     ; 147 GPIOB->DDR&=~(1<<0);
2580  00a3 72115007      	bres	20487,#0
2581                     ; 148 GPIOB->CR1&=~(1<<0);
2583  00a7 72115008      	bres	20488,#0
2584                     ; 149 GPIOB->CR2&=~(1<<0);
2586  00ab 72115009      	bres	20489,#0
2587                     ; 150 ADC2->CR2=0x08;
2589  00af 35085402      	mov	21506,#8
2590                     ; 151 ADC2->CR1=0x40;
2592  00b3 35405401      	mov	21505,#64
2593                     ; 152 ADC2->CSR=0x20+0;
2595  00b7 35205400      	mov	21504,#32
2596                     ; 153 ADC2->CR1|=1;
2598  00bb 72105401      	bset	21505,#0
2599                     ; 154 ADC2->CR1|=1;
2601  00bf 72105401      	bset	21505,#0
2602                     ; 158 GPIOB->DDR&=~(1<<1);
2604  00c3 72135007      	bres	20487,#1
2605                     ; 159 GPIOB->CR1&=~(1<<1);
2607  00c7 72135008      	bres	20488,#1
2608                     ; 160 GPIOB->CR2&=~(1<<1);
2610  00cb 72135009      	bres	20489,#1
2611                     ; 161 ADC2->CR2=0x08;
2613  00cf 35085402      	mov	21506,#8
2614                     ; 162 ADC2->CR1=0x40;
2616  00d3 35405401      	mov	21505,#64
2617                     ; 163 ADC2->CSR=0x20+1;
2619  00d7 35215400      	mov	21504,#33
2620                     ; 164 ADC2->CR1|=1;
2622  00db 72105401      	bset	21505,#0
2623                     ; 165 ADC2->CR1|=1;
2625  00df 72105401      	bset	21505,#0
2626                     ; 169 GPIOE->DDR&=~(1<<6);
2628  00e3 721d5016      	bres	20502,#6
2629                     ; 170 GPIOE->CR1&=~(1<<6);
2631  00e7 721d5017      	bres	20503,#6
2632                     ; 171 GPIOE->CR2&=~(1<<6);
2634  00eb 721d5018      	bres	20504,#6
2635                     ; 172 ADC2->CR2=0x08;
2637  00ef 35085402      	mov	21506,#8
2638                     ; 173 ADC2->CR1=0x40;
2640  00f3 35405401      	mov	21505,#64
2641                     ; 174 ADC2->CSR=0x20+9;
2643  00f7 35295400      	mov	21504,#41
2644                     ; 175 ADC2->CR1|=1;
2646  00fb 72105401      	bset	21505,#0
2647                     ; 176 ADC2->CR1|=1;
2649  00ff 72105401      	bset	21505,#0
2650                     ; 180 }
2653  0103 81            	ret
2676                     ; 186 void exti_init(void){
2677                     	switch	.text
2678  0104               _exti_init:
2682                     ; 187 EXTI->CR1=0x40;	
2684  0104 354050a0      	mov	20640,#64
2685                     ; 188 GPIOD->DDR&=~(1<<4);
2687  0108 72195011      	bres	20497,#4
2688                     ; 189 GPIOD->CR1&=~(1<<4);
2690  010c 72195012      	bres	20498,#4
2691                     ; 190 GPIOD->CR2|=(1<<4);	
2693  0110 72185013      	bset	20499,#4
2694                     ; 192 }
2697  0114 81            	ret
2720                     ; 195 void t1_init(void)
2720                     ; 196 {
2721                     	switch	.text
2722  0115               _t1_init:
2726                     ; 197 TIM1->ARRH= 0;
2728  0115 725f5262      	clr	21090
2729                     ; 198 TIM1->ARRL= 100;
2731  0119 35645263      	mov	21091,#100
2732                     ; 199 TIM1->CCR1H= 0x00;	
2734  011d 725f5265      	clr	21093
2735                     ; 200 TIM1->CCR1L= 0xff;
2737  0121 35ff5266      	mov	21094,#255
2738                     ; 201 TIM1->CCR2H= 0;	
2740  0125 725f5267      	clr	21095
2741                     ; 202 TIM1->CCR2L= 25;
2743  0129 35195268      	mov	21096,#25
2744                     ; 203 TIM1->CCR3H= 0x00;	
2746  012d 725f5269      	clr	21097
2747                     ; 204 TIM1->CCR3L= 0x64;
2749  0131 3564526a      	mov	21098,#100
2750                     ; 206 TIM1->PSCRH= 0;	
2752  0135 725f5260      	clr	21088
2753                     ; 207 TIM1->PSCRL= 15;
2755  0139 350f5261      	mov	21089,#15
2756                     ; 209 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
2758  013d 35685258      	mov	21080,#104
2759                     ; 210 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
2761  0141 35685259      	mov	21081,#104
2762                     ; 211 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
2764  0145 3568525a      	mov	21082,#104
2765                     ; 212 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
2767  0149 3511525c      	mov	21084,#17
2768                     ; 213 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
2770  014d 3501525d      	mov	21085,#1
2771                     ; 214 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
2773  0151 35815250      	mov	21072,#129
2774                     ; 215 TIM1->BKR|= TIM1_BKR_AOE;
2776  0155 721c526d      	bset	21101,#6
2777                     ; 216 }
2780  0159 81            	ret
2803                     ; 221 void t2_init_(void){
2804                     	switch	.text
2805  015a               _t2_init_:
2809                     ; 222 	TIM2->PSCR = 4;
2811  015a 3504530c      	mov	21260,#4
2812                     ; 223 	TIM2->ARRH= 20;
2814  015e 3514530d      	mov	21261,#20
2815                     ; 224 	TIM2->ARRL= 0;
2817  0162 725f530e      	clr	21262
2818                     ; 225 	TIM2->CCR1H= 10;	
2820  0166 350a530f      	mov	21263,#10
2821                     ; 226 	TIM2->CCR1L= 0;
2823  016a 725f5310      	clr	21264
2824                     ; 235 	TIM2->CR1=(TIM2_CR1_CEN /*| TIM2_CR1_ARPE*/);	
2826  016e 35015300      	mov	21248,#1
2827                     ; 237 }
2830  0172 81            	ret
2853                     ; 241 void t3_init_(void){
2854                     	switch	.text
2855  0173               _t3_init_:
2859                     ; 242 	TIM3->PSCR = 16;
2861  0173 3510532a      	mov	21290,#16
2862                     ; 243 	TIM3->ARRH= 120;
2864  0177 3578532b      	mov	21291,#120
2865                     ; 244 	TIM3->ARRL= 0;
2867  017b 725f532c      	clr	21292
2868                     ; 245 	TIM3->CCR1H= 10;	
2870  017f 350a532d      	mov	21293,#10
2871                     ; 246 	TIM3->CCR1L= 0;
2873  0183 725f532e      	clr	21294
2874                     ; 250 	TIM3->CR1=(TIM3_CR1_CEN | TIM3_CR1_ARPE);	
2876  0187 35815320      	mov	21280,#129
2877                     ; 252 }
2880  018b 81            	ret
2903                     ; 258 void t2_init(void)
2903                     ; 259 {
2904                     	switch	.text
2905  018c               _t2_init:
2909                     ; 270 TIM2->PSCR= 0x01;
2911  018c 3501530c      	mov	21260,#1
2912                     ; 277 TIM2->CR1=(TIM2_CR1_CEN | TIM2_CR1_ARPE);
2914  0190 35815300      	mov	21248,#129
2915                     ; 279 }
2918  0194 81            	ret
2942                     ; 282 void adc2_init(void)
2942                     ; 283 {
2943                     	switch	.text
2944  0195               _adc2_init:
2948                     ; 284 adc_plazma[0]++;
2950  0195 be11          	ldw	x,_adc_plazma
2951  0197 1c0001        	addw	x,#1
2952  019a bf11          	ldw	_adc_plazma,x
2953                     ; 287 GPIOB->DDR&=~(1<<0);
2955  019c 72115007      	bres	20487,#0
2956                     ; 288 GPIOB->CR1&=~(1<<0);
2958  01a0 72115008      	bres	20488,#0
2959                     ; 289 GPIOB->CR2&=~(1<<0);
2961  01a4 72115009      	bres	20489,#0
2962                     ; 291 GPIOB->DDR&=~(1<<1);
2964  01a8 72135007      	bres	20487,#1
2965                     ; 292 GPIOB->CR1&=~(1<<1);
2967  01ac 72135008      	bres	20488,#1
2968                     ; 293 GPIOB->CR2&=~(1<<1);
2970  01b0 72135009      	bres	20489,#1
2971                     ; 295 GPIOE->DDR&=~(1<<6);
2973  01b4 721d5016      	bres	20502,#6
2974                     ; 296 GPIOE->CR1&=~(1<<6);
2976  01b8 721d5017      	bres	20503,#6
2977                     ; 297 GPIOE->CR2&=~(1<<6);
2979  01bc 721d5018      	bres	20504,#6
2980                     ; 299 GPIOB->DDR&=~(1<<4);
2982  01c0 72195007      	bres	20487,#4
2983                     ; 300 GPIOB->CR1&=~(1<<4);
2985  01c4 72195008      	bres	20488,#4
2986                     ; 301 GPIOB->CR2&=~(1<<4);
2988  01c8 72195009      	bres	20489,#4
2989                     ; 303 GPIOB->DDR&=~(1<<5);
2991  01cc 721b5007      	bres	20487,#5
2992                     ; 304 GPIOB->CR1&=~(1<<5);
2994  01d0 721b5008      	bres	20488,#5
2995                     ; 305 GPIOB->CR2&=~(1<<5);
2997  01d4 721b5009      	bres	20489,#5
2998                     ; 307 GPIOB->DDR&=~(1<<6);
3000  01d8 721d5007      	bres	20487,#6
3001                     ; 308 GPIOB->CR1&=~(1<<6);
3003  01dc 721d5008      	bres	20488,#6
3004                     ; 309 GPIOB->CR2&=~(1<<6);
3006  01e0 721d5009      	bres	20489,#6
3007                     ; 311 GPIOB->DDR&=~(1<<7);
3009  01e4 721f5007      	bres	20487,#7
3010                     ; 312 GPIOB->CR1&=~(1<<7);
3012  01e8 721f5008      	bres	20488,#7
3013                     ; 313 GPIOB->CR2&=~(1<<7);
3015  01ec 721f5009      	bres	20489,#7
3016                     ; 315 ADC2->TDRL=0xff;
3018  01f0 35ff5407      	mov	21511,#255
3019                     ; 317 ADC2->CR2=0x08;
3021  01f4 35085402      	mov	21506,#8
3022                     ; 318 ADC2->CR1=0x40;
3024  01f8 35405401      	mov	21505,#64
3025                     ; 321 	ADC2->CSR=0x20;
3027  01fc 35205400      	mov	21504,#32
3028                     ; 323 	ADC2->CR1|=1;
3030  0200 72105401      	bset	21505,#0
3031                     ; 324 	ADC2->CR1|=1;
3033  0204 72105401      	bset	21505,#0
3034                     ; 326 }
3037  0208 81            	ret
3070                     ; 335 @far @interrupt void TIM4_UPD_Interrupt (void) 
3070                     ; 336 {
3072                     	switch	.text
3073  0209               f_TIM4_UPD_Interrupt:
3077                     ; 337 TIM4->SR1&=~TIM4_SR1_UIF;
3079  0209 72115342      	bres	21314,#0
3080                     ; 339 if(++t0_cnt0>=100)
3082  020d 9c            	rvf
3083  020e be01          	ldw	x,_t0_cnt0
3084  0210 1c0001        	addw	x,#1
3085  0213 bf01          	ldw	_t0_cnt0,x
3086  0215 a30064        	cpw	x,#100
3087  0218 2f3f          	jrslt	L7461
3088                     ; 341 	t0_cnt0=0;
3090  021a 5f            	clrw	x
3091  021b bf01          	ldw	_t0_cnt0,x
3092                     ; 342 	b100Hz=1;
3094  021d 72100005      	bset	_b100Hz
3095                     ; 344 	if(++t0_cnt1>=10)
3097  0221 3c03          	inc	_t0_cnt1
3098  0223 b603          	ld	a,_t0_cnt1
3099  0225 a10a          	cp	a,#10
3100  0227 2506          	jrult	L1561
3101                     ; 346 		t0_cnt1=0;
3103  0229 3f03          	clr	_t0_cnt1
3104                     ; 347 		b10Hz=1;
3106  022b 72100004      	bset	_b10Hz
3107  022f               L1561:
3108                     ; 350 	if(++t0_cnt2>=20)
3110  022f 3c04          	inc	_t0_cnt2
3111  0231 b604          	ld	a,_t0_cnt2
3112  0233 a114          	cp	a,#20
3113  0235 2506          	jrult	L3561
3114                     ; 352 		t0_cnt2=0;
3116  0237 3f04          	clr	_t0_cnt2
3117                     ; 353 		b5Hz=1;
3119  0239 72100003      	bset	_b5Hz
3120  023d               L3561:
3121                     ; 357 	if(++t0_cnt4>=50)
3123  023d 3c06          	inc	_t0_cnt4
3124  023f b606          	ld	a,_t0_cnt4
3125  0241 a132          	cp	a,#50
3126  0243 2506          	jrult	L5561
3127                     ; 359 		t0_cnt4=0;
3129  0245 3f06          	clr	_t0_cnt4
3130                     ; 360 		b2Hz=1;
3132  0247 72100002      	bset	_b2Hz
3133  024b               L5561:
3134                     ; 363 	if(++t0_cnt3>=100)
3136  024b 3c05          	inc	_t0_cnt3
3137  024d b605          	ld	a,_t0_cnt3
3138  024f a164          	cp	a,#100
3139  0251 2506          	jrult	L7461
3140                     ; 365 		t0_cnt3=0;
3142  0253 3f05          	clr	_t0_cnt3
3143                     ; 366 		b1Hz=1;
3145  0255 72100001      	bset	_b1Hz
3146  0259               L7461:
3147                     ; 372 }
3150  0259 80            	iret
3203                     ; 376 @far @interrupt void ADC2_EOC_Interrupt (void) {
3204                     	switch	.text
3205  025a               f_ADC2_EOC_Interrupt:
3207       0000000d      OFST:	set	13
3208  025a be00          	ldw	x,c_x
3209  025c 89            	pushw	x
3210  025d be00          	ldw	x,c_y
3211  025f 89            	pushw	x
3212  0260 be02          	ldw	x,c_lreg+2
3213  0262 89            	pushw	x
3214  0263 be00          	ldw	x,c_lreg
3215  0265 89            	pushw	x
3216  0266 520d          	subw	sp,#13
3219                     ; 381 ADC2->CSR&=~(1<<7);
3221  0268 721f5400      	bres	21504,#7
3222                     ; 383 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
3224  026c c65405        	ld	a,21509
3225  026f b703          	ld	c_lreg+3,a
3226  0271 3f02          	clr	c_lreg+2
3227  0273 3f01          	clr	c_lreg+1
3228  0275 3f00          	clr	c_lreg
3229  0277 96            	ldw	x,sp
3230  0278 1c0001        	addw	x,#OFST-12
3231  027b cd0000        	call	c_rtol
3233  027e c65404        	ld	a,21508
3234  0281 5f            	clrw	x
3235  0282 97            	ld	xl,a
3236  0283 90ae0100      	ldw	y,#256
3237  0287 cd0000        	call	c_umul
3239  028a 96            	ldw	x,sp
3240  028b 1c0001        	addw	x,#OFST-12
3241  028e cd0000        	call	c_ladd
3243                     ; 386 adc_ch=0;
3245  0291 3f1e          	clr	_adc_ch
3246                     ; 387 adc_cnt++;
3248  0293 3c1d          	inc	_adc_cnt
3249                     ; 388 if(adc_cnt>=16)
3251  0295 b61d          	ld	a,_adc_cnt
3252  0297 a110          	cp	a,#16
3253  0299 2502          	jrult	L7071
3254                     ; 390 	adc_cnt=0;
3256  029b 3f1d          	clr	_adc_cnt
3257  029d               L7071:
3258                     ; 393 if((adc_cnt&0x03)==0)
3260  029d b61d          	ld	a,_adc_cnt
3261  029f a503          	bcp	a,#3
3262  02a1 260a          	jrne	L1171
3263                     ; 397 	tempSS=0;
3265                     ; 398 	for(i=0;i<16;i++)
3267  02a3 0f09          	clr	(OFST-4,sp)
3268  02a5               L3171:
3271  02a5 0c09          	inc	(OFST-4,sp)
3274  02a7 7b09          	ld	a,(OFST-4,sp)
3275  02a9 a110          	cp	a,#16
3276  02ab 25f8          	jrult	L3171
3277  02ad               L1171:
3278                     ; 405 }
3281  02ad 5b0d          	addw	sp,#13
3282  02af 85            	popw	x
3283  02b0 bf00          	ldw	c_lreg,x
3284  02b2 85            	popw	x
3285  02b3 bf02          	ldw	c_lreg+2,x
3286  02b5 85            	popw	x
3287  02b6 bf00          	ldw	c_y,x
3288  02b8 85            	popw	x
3289  02b9 bf00          	ldw	c_x,x
3290  02bb 80            	iret
3315                     ; 408 @far @interrupt void PortD_Ext_Interrupt (void) {
3316                     	switch	.text
3317  02bc               f_PortD_Ext_Interrupt:
3321                     ; 411 GPIOA->ODR^=(1<<5);
3323  02bc c65000        	ld	a,20480
3324  02bf a820          	xor	a,	#32
3325  02c1 c75000        	ld	20480,a
3326                     ; 414 buffer_for_timer1_H=TIM2->CNTRH;
3328  02c4 55530a0001    	mov	_buffer_for_timer1_H,21258
3329                     ; 415 buffer_for_timer1_L=TIM2->CNTRL;
3331  02c9 55530b0000    	mov	_buffer_for_timer1_L,21259
3332                     ; 417 TIM2->CNTRH=0;
3334  02ce 725f530a      	clr	21258
3335                     ; 418 TIM2->CNTRL=0;
3337  02d2 725f530b      	clr	21259
3338                     ; 420 }
3341  02d6 80            	iret
3374                     ; 427 main()
3374                     ; 428 {
3376                     	switch	.text
3377  02d7               _main:
3381                     ; 430 CLK->ECKR|=1;
3383  02d7 721050c1      	bset	20673,#0
3385  02db               L3471:
3386                     ; 431 while((CLK->ECKR & 2) == 0);
3388  02db c650c1        	ld	a,20673
3389  02de a502          	bcp	a,#2
3390  02e0 27f9          	jreq	L3471
3391                     ; 432 CLK->SWCR|=2;
3393  02e2 721250c5      	bset	20677,#1
3394                     ; 433 CLK->SWR=0xB4;
3396  02e6 35b450c4      	mov	20676,#180
3397                     ; 436 FLASH->DUKR=0xae;
3399  02ea 35ae5064      	mov	20580,#174
3400                     ; 437 FLASH->DUKR=0x56;
3402  02ee 35565064      	mov	20580,#86
3403                     ; 439 exti_init();
3405  02f2 cd0104        	call	_exti_init
3407                     ; 441 enableInterrupts();
3410  02f5 9a            rim
3412                     ; 448 t4_init();
3415  02f6 cd008e        	call	_t4_init
3417                     ; 450 		GPIOG->DDR|=(1<<0);
3419  02f9 72105020      	bset	20512,#0
3420                     ; 451 		GPIOG->CR1|=(1<<0);
3422  02fd 72105021      	bset	20513,#0
3423                     ; 452 		GPIOG->CR2&=~(1<<0);	
3425  0301 72115022      	bres	20514,#0
3426                     ; 455 		GPIOG->DDR&=~(1<<1);
3428  0305 72135020      	bres	20512,#1
3429                     ; 456 		GPIOG->CR1|=(1<<1);
3431  0309 72125021      	bset	20513,#1
3432                     ; 457 		GPIOG->CR2&=~(1<<1);
3434  030d 72135022      	bres	20514,#1
3435                     ; 463 GPIOC->DDR|=(1<<1);
3437  0311 7212500c      	bset	20492,#1
3438                     ; 464 GPIOC->CR1|=(1<<1);
3440  0315 7212500d      	bset	20493,#1
3441                     ; 465 GPIOC->CR2|=(1<<1);
3443  0319 7212500e      	bset	20494,#1
3444                     ; 467 GPIOC->DDR|=(1<<2);
3446  031d 7214500c      	bset	20492,#2
3447                     ; 468 GPIOC->CR1|=(1<<2);
3449  0321 7214500d      	bset	20493,#2
3450                     ; 469 GPIOC->CR2|=(1<<2);
3452  0325 7214500e      	bset	20494,#2
3453                     ; 476 t1_init();
3455  0329 cd0115        	call	_t1_init
3457                     ; 477 t2_init_();
3459  032c cd015a        	call	_t2_init_
3461                     ; 479 GPIOA->DDR|=(1<<5);
3463  032f 721a5002      	bset	20482,#5
3464                     ; 480 GPIOA->CR1|=(1<<5);
3466  0333 721a5003      	bset	20483,#5
3467                     ; 481 GPIOA->CR2&=~(1<<5);
3469  0337 721b5004      	bres	20484,#5
3470                     ; 483 GPIOA->DDR|=(1<<6);
3472  033b 721c5002      	bset	20482,#6
3473                     ; 484 GPIOA->CR1|=(1<<6);
3475  033f 721c5003      	bset	20483,#6
3476                     ; 485 GPIOA->CR2&=~(1<<6);
3478  0343 721d5004      	bres	20484,#6
3479                     ; 491 GPIOB->DDR&=~(1<<3);
3481  0347 72175007      	bres	20487,#3
3482                     ; 492 GPIOB->CR1&=~(1<<3);
3484  034b 72175008      	bres	20488,#3
3485                     ; 493 GPIOB->CR2&=~(1<<3);
3487  034f 72175009      	bres	20489,#3
3488                     ; 495 GPIOC->DDR|=(1<<3);
3490  0353 7216500c      	bset	20492,#3
3491                     ; 496 GPIOC->CR1|=(1<<3);
3493  0357 7216500d      	bset	20493,#3
3494                     ; 497 GPIOC->CR2|=(1<<3);
3496  035b 7216500e      	bset	20494,#3
3497  035f               L7471:
3498                     ; 507 if(b100Hz)
3500                     	btst	_b100Hz
3501  0364 2404          	jruge	L3571
3502                     ; 509 		b100Hz=0;
3504  0366 72110005      	bres	_b100Hz
3505  036a               L3571:
3506                     ; 515 	if(b10Hz)
3508                     	btst	_b10Hz
3509  036f 2414          	jruge	L5571
3510                     ; 517 		b10Hz=0;
3512  0371 72110004      	bres	_b10Hz
3513                     ; 523 		TIM1->ARRH=0x68;//buffer_for_timer1_H;
3515  0375 35685262      	mov	21090,#104
3516                     ; 524 		TIM1->ARRL=0x2a;//buffer_for_timer1_L;
3518  0379 352a5263      	mov	21091,#42
3519                     ; 525 		TIM1->CCR2H=0x34;//buffer_for_timer1_H>>1;	
3521  037d 35345267      	mov	21095,#52
3522                     ; 526 		TIM1->CCR2L=0;
3524  0381 725f5268      	clr	21096
3525  0385               L5571:
3526                     ; 529 	if(b5Hz)
3528                     	btst	_b5Hz
3529  038a 2412          	jruge	L7571
3530                     ; 531 		b5Hz=0;
3532  038c 72110003      	bres	_b5Hz
3533                     ; 534 		if((TIM2->CNTRL))GPIOA->ODR^=(1<<6);
3535  0390 725d530b      	tnz	21259
3536  0394 2708          	jreq	L7571
3539  0396 c65000        	ld	a,20480
3540  0399 a840          	xor	a,	#64
3541  039b c75000        	ld	20480,a
3542  039e               L7571:
3543                     ; 537 	if(b2Hz)
3545                     	btst	_b2Hz
3546  03a3 2404          	jruge	L3671
3547                     ; 539 		b2Hz=0;
3549  03a5 72110002      	bres	_b2Hz
3550  03a9               L3671:
3551                     ; 543 	if(b1Hz)
3553                     	btst	_b1Hz
3554  03ae 24af          	jruge	L7471
3555                     ; 545 		b1Hz=0;
3557  03b0 72110001      	bres	_b1Hz
3558                     ; 547 		if(main_cnt<1000)main_cnt++;
3560  03b4 9c            	rvf
3561  03b5 be0e          	ldw	x,_main_cnt
3562  03b7 a303e8        	cpw	x,#1000
3563  03ba 2ea3          	jrsge	L7471
3566  03bc be0e          	ldw	x,_main_cnt
3567  03be 1c0001        	addw	x,#1
3568  03c1 bf0e          	ldw	_main_cnt,x
3569  03c3 209a          	jra	L7471
3828                     	xdef	_main
3829                     	xdef	f_PortD_Ext_Interrupt
3830                     	xdef	f_ADC2_EOC_Interrupt
3831                     	xdef	f_TIM4_UPD_Interrupt
3832                     	xdef	_adc2_init
3833                     	xdef	_t2_init
3834                     	xdef	_t3_init_
3835                     	xdef	_t2_init_
3836                     	xdef	_t1_init
3837                     	xdef	_exti_init
3838                     	xdef	_adr_drv_v3
3839                     	xdef	_matemat
3840                     	xdef	_pwr_hndl
3841                     	xdef	_pwr_drv
3842                     	xdef	_led_drv
3843                     	xdef	_t4_init
3844                     	xdef	_delay_ms
3845                     	xdef	_granee
3846                     	xdef	_gran
3847                     	switch	.ubsct
3848  0000               _buffer_for_timer1_L:
3849  0000 00            	ds.b	1
3850                     	xdef	_buffer_for_timer1_L
3851  0001               _buffer_for_timer1_H:
3852  0001 00            	ds.b	1
3853                     	xdef	_buffer_for_timer1_H
3854  0002               _i_main_sigma:
3855  0002 0000          	ds.b	2
3856                     	xdef	_i_main_sigma
3857  0004               _i_main_num_of_bps:
3858  0004 00            	ds.b	1
3859                     	xdef	_i_main_num_of_bps
3860  0005               _cnt_net_drv:
3861  0005 00            	ds.b	1
3862                     	xdef	_cnt_net_drv
3863                     .bit:	section	.data,bit
3864  0000               _bMAIN:
3865  0000 00            	ds.b	1
3866                     	xdef	_bMAIN
3867                     	switch	.ubsct
3868  0006               _plazma_int:
3869  0006 000000000000  	ds.b	6
3870                     	xdef	_plazma_int
3871                     	xdef	_rotor_int
3872  000c               _main_cnt1:
3873  000c 0000          	ds.b	2
3874                     	xdef	_main_cnt1
3875  000e               _main_cnt:
3876  000e 0000          	ds.b	2
3877                     	xdef	_main_cnt
3878  0010               _off_bp_cnt:
3879  0010 00            	ds.b	1
3880                     	xdef	_off_bp_cnt
3881  0011               _adc_plazma:
3882  0011 000000000000  	ds.b	10
3883                     	xdef	_adc_plazma
3884  001b               _adc_plazma_short:
3885  001b 0000          	ds.b	2
3886                     	xdef	_adc_plazma_short
3887  001d               _adc_cnt:
3888  001d 00            	ds.b	1
3889                     	xdef	_adc_cnt
3890  001e               _adc_ch:
3891  001e 00            	ds.b	1
3892                     	xdef	_adc_ch
3893                     	switch	.bit
3894  0001               _b1Hz:
3895  0001 00            	ds.b	1
3896                     	xdef	_b1Hz
3897  0002               _b2Hz:
3898  0002 00            	ds.b	1
3899                     	xdef	_b2Hz
3900  0003               _b5Hz:
3901  0003 00            	ds.b	1
3902                     	xdef	_b5Hz
3903  0004               _b10Hz:
3904  0004 00            	ds.b	1
3905                     	xdef	_b10Hz
3906  0005               _b100Hz:
3907  0005 00            	ds.b	1
3908                     	xdef	_b100Hz
3909                     	xdef	_t0_cnt4
3910                     	xdef	_t0_cnt3
3911                     	xdef	_t0_cnt2
3912                     	xdef	_t0_cnt1
3913                     	xdef	_t0_cnt0
3914                     	xdef	_bVENT_BLOCK
3915                     	xref.b	c_lreg
3916                     	xref.b	c_x
3917                     	xref.b	c_y
3937                     	xref	c_ladd
3938                     	xref	c_umul
3939                     	xref	c_lcmp
3940                     	xref	c_ltor
3941                     	xref	c_lgadc
3942                     	xref	c_rtol
3943                     	xref	c_vmul
3944                     	xref	c_eewrw
3945                     	end
