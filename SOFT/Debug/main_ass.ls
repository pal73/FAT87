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
2119                     ; 55 void gran(signed short *adr, signed short min, signed short max)
2119                     ; 56 {
2121                     	switch	.text
2122  0000               _gran:
2124  0000 89            	pushw	x
2125       00000000      OFST:	set	0
2128                     ; 57 if (*adr<min) *adr=min;
2130  0001 9c            	rvf
2131  0002 9093          	ldw	y,x
2132  0004 51            	exgw	x,y
2133  0005 fe            	ldw	x,(x)
2134  0006 1305          	cpw	x,(OFST+5,sp)
2135  0008 51            	exgw	x,y
2136  0009 2e03          	jrsge	L7731
2139  000b 1605          	ldw	y,(OFST+5,sp)
2140  000d ff            	ldw	(x),y
2141  000e               L7731:
2142                     ; 58 if (*adr>max) *adr=max; 
2144  000e 9c            	rvf
2145  000f 1e01          	ldw	x,(OFST+1,sp)
2146  0011 9093          	ldw	y,x
2147  0013 51            	exgw	x,y
2148  0014 fe            	ldw	x,(x)
2149  0015 1307          	cpw	x,(OFST+7,sp)
2150  0017 51            	exgw	x,y
2151  0018 2d05          	jrsle	L1041
2154  001a 1e01          	ldw	x,(OFST+1,sp)
2155  001c 1607          	ldw	y,(OFST+7,sp)
2156  001e ff            	ldw	(x),y
2157  001f               L1041:
2158                     ; 59 } 
2161  001f 85            	popw	x
2162  0020 81            	ret
2215                     ; 62 void granee(@eeprom signed short *adr, signed short min, signed short max)
2215                     ; 63 {
2216                     	switch	.text
2217  0021               _granee:
2219  0021 89            	pushw	x
2220       00000000      OFST:	set	0
2223                     ; 64 if (*adr<min) *adr=min;
2225  0022 9c            	rvf
2226  0023 9093          	ldw	y,x
2227  0025 51            	exgw	x,y
2228  0026 fe            	ldw	x,(x)
2229  0027 1305          	cpw	x,(OFST+5,sp)
2230  0029 51            	exgw	x,y
2231  002a 2e09          	jrsge	L1341
2234  002c 1e05          	ldw	x,(OFST+5,sp)
2235  002e 89            	pushw	x
2236  002f 1e03          	ldw	x,(OFST+3,sp)
2237  0031 cd0000        	call	c_eewrw
2239  0034 85            	popw	x
2240  0035               L1341:
2241                     ; 65 if (*adr>max) *adr=max; 
2243  0035 9c            	rvf
2244  0036 1e01          	ldw	x,(OFST+1,sp)
2245  0038 9093          	ldw	y,x
2246  003a 51            	exgw	x,y
2247  003b fe            	ldw	x,(x)
2248  003c 1307          	cpw	x,(OFST+7,sp)
2249  003e 51            	exgw	x,y
2250  003f 2d09          	jrsle	L3341
2253  0041 1e07          	ldw	x,(OFST+7,sp)
2254  0043 89            	pushw	x
2255  0044 1e03          	ldw	x,(OFST+3,sp)
2256  0046 cd0000        	call	c_eewrw
2258  0049 85            	popw	x
2259  004a               L3341:
2260                     ; 66 }
2263  004a 85            	popw	x
2264  004b 81            	ret
2325                     ; 69 long delay_ms(short in)
2325                     ; 70 {
2326                     	switch	.text
2327  004c               _delay_ms:
2329  004c 520c          	subw	sp,#12
2330       0000000c      OFST:	set	12
2333                     ; 73 i=((long)in)*100UL;
2335  004e 90ae0064      	ldw	y,#100
2336  0052 cd0000        	call	c_vmul
2338  0055 96            	ldw	x,sp
2339  0056 1c0005        	addw	x,#OFST-7
2340  0059 cd0000        	call	c_rtol
2342                     ; 75 for(ii=0;ii<i;ii++)
2344  005c ae0000        	ldw	x,#0
2345  005f 1f0b          	ldw	(OFST-1,sp),x
2346  0061 ae0000        	ldw	x,#0
2347  0064 1f09          	ldw	(OFST-3,sp),x
2349  0066 2012          	jra	L3741
2350  0068               L7641:
2351                     ; 77 		iii++;
2353  0068 96            	ldw	x,sp
2354  0069 1c0001        	addw	x,#OFST-11
2355  006c a601          	ld	a,#1
2356  006e cd0000        	call	c_lgadc
2358                     ; 75 for(ii=0;ii<i;ii++)
2360  0071 96            	ldw	x,sp
2361  0072 1c0009        	addw	x,#OFST-3
2362  0075 a601          	ld	a,#1
2363  0077 cd0000        	call	c_lgadc
2365  007a               L3741:
2368  007a 9c            	rvf
2369  007b 96            	ldw	x,sp
2370  007c 1c0009        	addw	x,#OFST-3
2371  007f cd0000        	call	c_ltor
2373  0082 96            	ldw	x,sp
2374  0083 1c0005        	addw	x,#OFST-7
2375  0086 cd0000        	call	c_lcmp
2377  0089 2fdd          	jrslt	L7641
2378                     ; 80 }
2381  008b 5b0c          	addw	sp,#12
2382  008d 81            	ret
2405                     ; 83 void uart1_init (void)
2405                     ; 84 {
2406                     	switch	.text
2407  008e               _uart1_init:
2411                     ; 86 GPIOA->DDR&=~(1<<4);
2413  008e 72195002      	bres	20482,#4
2414                     ; 87 GPIOA->CR1|=(1<<4);
2416  0092 72185003      	bset	20483,#4
2417                     ; 88 GPIOA->CR2&=~(1<<4);
2419  0096 72195004      	bres	20484,#4
2420                     ; 91 GPIOA->DDR|=(1<<5);
2422  009a 721a5002      	bset	20482,#5
2423                     ; 92 GPIOA->CR1|=(1<<5);
2425  009e 721a5003      	bset	20483,#5
2426                     ; 93 GPIOA->CR2&=~(1<<5);	
2428  00a2 721b5004      	bres	20484,#5
2429                     ; 96 UART1->CR1&=~UART1_CR1_M;					
2431  00a6 72195234      	bres	21044,#4
2432                     ; 97 UART1->CR3|= (0<<4) & UART1_CR3_STOP;  	
2434  00aa c65236        	ld	a,21046
2435                     ; 98 UART1->BRR2= 0x09;
2437  00ad 35095233      	mov	21043,#9
2438                     ; 99 UART1->BRR1= 0x20;
2440  00b1 35205232      	mov	21042,#32
2441                     ; 100 UART1->CR2|= UART1_CR2_TEN | UART1_CR2_REN | UART1_CR2_RIEN/*| UART2_CR2_TIEN*/ ;	
2443  00b5 c65235        	ld	a,21045
2444  00b8 aa2c          	or	a,#44
2445  00ba c75235        	ld	21045,a
2446                     ; 101 }
2449  00bd 81            	ret
2472                     ; 105 void t4_init(void){
2473                     	switch	.text
2474  00be               _t4_init:
2478                     ; 106 	TIM4->PSCR = 4;
2480  00be 35045345      	mov	21317,#4
2481                     ; 107 	TIM4->ARR= 77;
2483  00c2 354d5346      	mov	21318,#77
2484                     ; 108 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
2486  00c6 72105341      	bset	21313,#0
2487                     ; 110 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
2489  00ca 35855340      	mov	21312,#133
2490                     ; 112 }
2493  00ce 81            	ret
2516                     ; 116 void led_drv(void)
2516                     ; 117 {
2517                     	switch	.text
2518  00cf               _led_drv:
2522                     ; 118 } 
2525  00cf 81            	ret
2548                     ; 126 void pwr_drv(void)
2548                     ; 127 {
2549                     	switch	.text
2550  00d0               _pwr_drv:
2554                     ; 153 }
2557  00d0 81            	ret
2580                     ; 158 void pwr_hndl(void)				
2580                     ; 159 {
2581                     	switch	.text
2582  00d1               _pwr_hndl:
2586                     ; 161 }
2589  00d1 81            	ret
2612                     ; 164 void matemat(void)
2612                     ; 165 {
2613                     	switch	.text
2614  00d2               _matemat:
2618                     ; 168 }
2621  00d2 81            	ret
2658                     ; 171 char putchar(char c)
2658                     ; 172 {
2659                     	switch	.text
2660  00d3               _putchar:
2662  00d3 88            	push	a
2663       00000000      OFST:	set	0
2666  00d4               L7751:
2667                     ; 173 while (tx_counter1 == TX_BUFFER_SIZE1);
2669  00d4 b625          	ld	a,_tx_counter1
2670  00d6 a132          	cp	a,#50
2671  00d8 27fa          	jreq	L7751
2672                     ; 175 if (tx_counter1 || ((UART1->SR & UART1_SR_TXE)==0))
2674  00da 3d25          	tnz	_tx_counter1
2675  00dc 2607          	jrne	L5061
2677  00de c65230        	ld	a,21040
2678  00e1 a580          	bcp	a,#128
2679  00e3 2621          	jrne	L3061
2680  00e5               L5061:
2681                     ; 177    tx_buffer1[tx_wr_index1]=c;
2683  00e5 5f            	clrw	x
2684  00e6 b624          	ld	a,_tx_wr_index1
2685  00e8 2a01          	jrpl	L03
2686  00ea 53            	cplw	x
2687  00eb               L03:
2688  00eb 97            	ld	xl,a
2689  00ec 7b01          	ld	a,(OFST+1,sp)
2690  00ee e707          	ld	(_tx_buffer1,x),a
2691                     ; 178    if (++tx_wr_index1 == TX_BUFFER_SIZE1) tx_wr_index1=0;
2693  00f0 3c24          	inc	_tx_wr_index1
2694  00f2 b624          	ld	a,_tx_wr_index1
2695  00f4 a132          	cp	a,#50
2696  00f6 2602          	jrne	L7061
2699  00f8 3f24          	clr	_tx_wr_index1
2700  00fa               L7061:
2701                     ; 179    ++tx_counter1;
2703  00fa 3c25          	inc	_tx_counter1
2705  00fc               L1161:
2706                     ; 183 UART1->CR2|= UART1_CR2_TIEN | UART1_CR2_TCIEN;
2708  00fc c65235        	ld	a,21045
2709  00ff aac0          	or	a,#192
2710  0101 c75235        	ld	21045,a
2711                     ; 184 }
2714  0104 84            	pop	a
2715  0105 81            	ret
2716  0106               L3061:
2717                     ; 181 else UART1->DR=c;
2719  0106 7b01          	ld	a,(OFST+1,sp)
2720  0108 c75231        	ld	21041,a
2721  010b 20ef          	jra	L1161
2744                     ; 188 void adr_drv_v3(void)
2744                     ; 189 {
2745                     	switch	.text
2746  010d               _adr_drv_v3:
2750                     ; 195 GPIOB->DDR&=~(1<<0);
2752  010d 72115007      	bres	20487,#0
2753                     ; 196 GPIOB->CR1&=~(1<<0);
2755  0111 72115008      	bres	20488,#0
2756                     ; 197 GPIOB->CR2&=~(1<<0);
2758  0115 72115009      	bres	20489,#0
2759                     ; 198 ADC2->CR2=0x08;
2761  0119 35085402      	mov	21506,#8
2762                     ; 199 ADC2->CR1=0x40;
2764  011d 35405401      	mov	21505,#64
2765                     ; 200 ADC2->CSR=0x20+0;
2767  0121 35205400      	mov	21504,#32
2768                     ; 201 ADC2->CR1|=1;
2770  0125 72105401      	bset	21505,#0
2771                     ; 202 ADC2->CR1|=1;
2773  0129 72105401      	bset	21505,#0
2774                     ; 206 GPIOB->DDR&=~(1<<1);
2776  012d 72135007      	bres	20487,#1
2777                     ; 207 GPIOB->CR1&=~(1<<1);
2779  0131 72135008      	bres	20488,#1
2780                     ; 208 GPIOB->CR2&=~(1<<1);
2782  0135 72135009      	bres	20489,#1
2783                     ; 209 ADC2->CR2=0x08;
2785  0139 35085402      	mov	21506,#8
2786                     ; 210 ADC2->CR1=0x40;
2788  013d 35405401      	mov	21505,#64
2789                     ; 211 ADC2->CSR=0x20+1;
2791  0141 35215400      	mov	21504,#33
2792                     ; 212 ADC2->CR1|=1;
2794  0145 72105401      	bset	21505,#0
2795                     ; 213 ADC2->CR1|=1;
2797  0149 72105401      	bset	21505,#0
2798                     ; 217 GPIOE->DDR&=~(1<<6);
2800  014d 721d5016      	bres	20502,#6
2801                     ; 218 GPIOE->CR1&=~(1<<6);
2803  0151 721d5017      	bres	20503,#6
2804                     ; 219 GPIOE->CR2&=~(1<<6);
2806  0155 721d5018      	bres	20504,#6
2807                     ; 220 ADC2->CR2=0x08;
2809  0159 35085402      	mov	21506,#8
2810                     ; 221 ADC2->CR1=0x40;
2812  015d 35405401      	mov	21505,#64
2813                     ; 222 ADC2->CSR=0x20+9;
2815  0161 35295400      	mov	21504,#41
2816                     ; 223 ADC2->CR1|=1;
2818  0165 72105401      	bset	21505,#0
2819                     ; 224 ADC2->CR1|=1;
2821  0169 72105401      	bset	21505,#0
2822                     ; 228 }
2825  016d 81            	ret
2848                     ; 234 void exti_init(void){
2849                     	switch	.text
2850  016e               _exti_init:
2854                     ; 235 EXTI->CR1=0x40;	
2856  016e 354050a0      	mov	20640,#64
2857                     ; 236 GPIOD->DDR&=~(1<<4);
2859  0172 72195011      	bres	20497,#4
2860                     ; 237 GPIOD->CR1&=~(1<<4);
2862  0176 72195012      	bres	20498,#4
2863                     ; 238 GPIOD->CR2|=(1<<4);	
2865  017a 72185013      	bset	20499,#4
2866                     ; 240 }
2869  017e 81            	ret
2892                     ; 243 void t1_init(void)
2892                     ; 244 {
2893                     	switch	.text
2894  017f               _t1_init:
2898                     ; 245 TIM1->ARRH= 0;
2900  017f 725f5262      	clr	21090
2901                     ; 246 TIM1->ARRL= 100;
2903  0183 35645263      	mov	21091,#100
2904                     ; 247 TIM1->CCR1H= 0x00;	
2906  0187 725f5265      	clr	21093
2907                     ; 248 TIM1->CCR1L= 0xff;
2909  018b 35ff5266      	mov	21094,#255
2910                     ; 249 TIM1->CCR2H= 0;	
2912  018f 725f5267      	clr	21095
2913                     ; 250 TIM1->CCR2L= 25;
2915  0193 35195268      	mov	21096,#25
2916                     ; 251 TIM1->CCR3H= 0x00;	
2918  0197 725f5269      	clr	21097
2919                     ; 252 TIM1->CCR3L= 0x64;
2921  019b 3564526a      	mov	21098,#100
2922                     ; 254 TIM1->PSCRH= 0;	
2924  019f 725f5260      	clr	21088
2925                     ; 255 TIM1->PSCRL= 15;
2927  01a3 350f5261      	mov	21089,#15
2928                     ; 257 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
2930  01a7 35685258      	mov	21080,#104
2931                     ; 258 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
2933  01ab 35685259      	mov	21081,#104
2934                     ; 259 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
2936  01af 3568525a      	mov	21082,#104
2937                     ; 260 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
2939  01b3 3511525c      	mov	21084,#17
2940                     ; 261 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
2942  01b7 3501525d      	mov	21085,#1
2943                     ; 262 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
2945  01bb 35815250      	mov	21072,#129
2946                     ; 263 TIM1->BKR|= TIM1_BKR_AOE;
2948  01bf 721c526d      	bset	21101,#6
2949                     ; 264 }
2952  01c3 81            	ret
2975                     ; 269 void t2_init_(void){
2976                     	switch	.text
2977  01c4               _t2_init_:
2981                     ; 270 	TIM2->PSCR = 4;
2983  01c4 3504530c      	mov	21260,#4
2984                     ; 271 	TIM2->ARRH= 20;
2986  01c8 3514530d      	mov	21261,#20
2987                     ; 272 	TIM2->ARRL= 0;
2989  01cc 725f530e      	clr	21262
2990                     ; 273 	TIM2->CCR1H= 10;	
2992  01d0 350a530f      	mov	21263,#10
2993                     ; 274 	TIM2->CCR1L= 0;
2995  01d4 725f5310      	clr	21264
2996                     ; 276 	TIM2->CCER1= TIM2_CCER1_CC1E; //OC1, OC2 output pins enabled
2998  01d8 35015308      	mov	21256,#1
2999                     ; 277 	TIM2->CCMR1= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
3001  01dc 35685305      	mov	21253,#104
3002                     ; 283 	TIM2->CR1=(TIM2_CR1_CEN /*| TIM2_CR1_ARPE*/);	
3004  01e0 35015300      	mov	21248,#1
3005                     ; 285 }
3008  01e4 81            	ret
3031                     ; 289 void t3_init_(void){
3032                     	switch	.text
3033  01e5               _t3_init_:
3037                     ; 290 	TIM3->PSCR = 16;
3039  01e5 3510532a      	mov	21290,#16
3040                     ; 291 	TIM3->ARRH= 120;
3042  01e9 3578532b      	mov	21291,#120
3043                     ; 292 	TIM3->ARRL= 0;
3045  01ed 725f532c      	clr	21292
3046                     ; 293 	TIM3->CCR1H= 10;	
3048  01f1 350a532d      	mov	21293,#10
3049                     ; 294 	TIM3->CCR1L= 0;
3051  01f5 725f532e      	clr	21294
3052                     ; 298 	TIM3->CR1=(TIM3_CR1_CEN | TIM3_CR1_ARPE);	
3054  01f9 35815320      	mov	21280,#129
3055                     ; 300 }
3058  01fd 81            	ret
3081                     ; 306 void t2_init(void)
3081                     ; 307 {
3082                     	switch	.text
3083  01fe               _t2_init:
3087                     ; 308 TIM2->PSCR = 0x04;
3089  01fe 3504530c      	mov	21260,#4
3090                     ; 309 TIM2->CCMR1 = TIM2_CCER1_CC1E;
3092  0202 35015305      	mov	21253,#1
3093                     ; 310 TIM2->CCER1 = TIM2_CCER1_CC1E;
3095  0206 35015308      	mov	21256,#1
3096                     ; 311 TIM2->IER = TIM2_IER_CC1IE;
3098  020a 35025301      	mov	21249,#2
3099                     ; 312 TIM2->CR1 = TIM2_CR1_CEN;
3101  020e 35015300      	mov	21248,#1
3102                     ; 313 }
3105  0212 81            	ret
3129                     ; 316 void adc2_init(void)
3129                     ; 317 {
3130                     	switch	.text
3131  0213               _adc2_init:
3135                     ; 318 adc_plazma[0]++;
3137  0213 be13          	ldw	x,_adc_plazma
3138  0215 1c0001        	addw	x,#1
3139  0218 bf13          	ldw	_adc_plazma,x
3140                     ; 321 GPIOB->DDR&=~(1<<0);
3142  021a 72115007      	bres	20487,#0
3143                     ; 322 GPIOB->CR1&=~(1<<0);
3145  021e 72115008      	bres	20488,#0
3146                     ; 323 GPIOB->CR2&=~(1<<0);
3148  0222 72115009      	bres	20489,#0
3149                     ; 325 GPIOB->DDR&=~(1<<1);
3151  0226 72135007      	bres	20487,#1
3152                     ; 326 GPIOB->CR1&=~(1<<1);
3154  022a 72135008      	bres	20488,#1
3155                     ; 327 GPIOB->CR2&=~(1<<1);
3157  022e 72135009      	bres	20489,#1
3158                     ; 329 GPIOE->DDR&=~(1<<6);
3160  0232 721d5016      	bres	20502,#6
3161                     ; 330 GPIOE->CR1&=~(1<<6);
3163  0236 721d5017      	bres	20503,#6
3164                     ; 331 GPIOE->CR2&=~(1<<6);
3166  023a 721d5018      	bres	20504,#6
3167                     ; 333 GPIOB->DDR&=~(1<<4);
3169  023e 72195007      	bres	20487,#4
3170                     ; 334 GPIOB->CR1&=~(1<<4);
3172  0242 72195008      	bres	20488,#4
3173                     ; 335 GPIOB->CR2&=~(1<<4);
3175  0246 72195009      	bres	20489,#4
3176                     ; 337 GPIOB->DDR&=~(1<<5);
3178  024a 721b5007      	bres	20487,#5
3179                     ; 338 GPIOB->CR1&=~(1<<5);
3181  024e 721b5008      	bres	20488,#5
3182                     ; 339 GPIOB->CR2&=~(1<<5);
3184  0252 721b5009      	bres	20489,#5
3185                     ; 341 GPIOB->DDR&=~(1<<6);
3187  0256 721d5007      	bres	20487,#6
3188                     ; 342 GPIOB->CR1&=~(1<<6);
3190  025a 721d5008      	bres	20488,#6
3191                     ; 343 GPIOB->CR2&=~(1<<6);
3193  025e 721d5009      	bres	20489,#6
3194                     ; 345 GPIOB->DDR&=~(1<<7);
3196  0262 721f5007      	bres	20487,#7
3197                     ; 346 GPIOB->CR1&=~(1<<7);
3199  0266 721f5008      	bres	20488,#7
3200                     ; 347 GPIOB->CR2&=~(1<<7);
3202  026a 721f5009      	bres	20489,#7
3203                     ; 349 ADC2->TDRL=0xff;
3205  026e 35ff5407      	mov	21511,#255
3206                     ; 351 ADC2->CR2=0x08;
3208  0272 35085402      	mov	21506,#8
3209                     ; 352 ADC2->CR1=0x40;
3211  0276 35405401      	mov	21505,#64
3212                     ; 355 	ADC2->CSR=0x20;
3214  027a 35205400      	mov	21504,#32
3215                     ; 357 	ADC2->CR1|=1;
3217  027e 72105401      	bset	21505,#0
3218                     ; 358 	ADC2->CR1|=1;
3220  0282 72105401      	bset	21505,#0
3221                     ; 360 }
3224  0286 81            	ret
3257                     ; 369 @far @interrupt void TIM4_UPD_Interrupt (void) 
3257                     ; 370 {
3259                     	switch	.text
3260  0287               f_TIM4_UPD_Interrupt:
3264                     ; 371 TIM4->SR1&=~TIM4_SR1_UIF;
3266  0287 72115342      	bres	21314,#0
3267                     ; 373 if(++t0_cnt0>=100)
3269  028b 9c            	rvf
3270  028c be01          	ldw	x,_t0_cnt0
3271  028e 1c0001        	addw	x,#1
3272  0291 bf01          	ldw	_t0_cnt0,x
3273  0293 a30064        	cpw	x,#100
3274  0296 2f3f          	jrslt	L3171
3275                     ; 375 	t0_cnt0=0;
3277  0298 5f            	clrw	x
3278  0299 bf01          	ldw	_t0_cnt0,x
3279                     ; 376 	b100Hz=1;
3281  029b 72100005      	bset	_b100Hz
3282                     ; 378 	if(++t0_cnt1>=10)
3284  029f 3c03          	inc	_t0_cnt1
3285  02a1 b603          	ld	a,_t0_cnt1
3286  02a3 a10a          	cp	a,#10
3287  02a5 2506          	jrult	L5171
3288                     ; 380 		t0_cnt1=0;
3290  02a7 3f03          	clr	_t0_cnt1
3291                     ; 381 		b10Hz=1;
3293  02a9 72100004      	bset	_b10Hz
3294  02ad               L5171:
3295                     ; 384 	if(++t0_cnt2>=20)
3297  02ad 3c04          	inc	_t0_cnt2
3298  02af b604          	ld	a,_t0_cnt2
3299  02b1 a114          	cp	a,#20
3300  02b3 2506          	jrult	L7171
3301                     ; 386 		t0_cnt2=0;
3303  02b5 3f04          	clr	_t0_cnt2
3304                     ; 387 		b5Hz=1;
3306  02b7 72100003      	bset	_b5Hz
3307  02bb               L7171:
3308                     ; 391 	if(++t0_cnt4>=50)
3310  02bb 3c06          	inc	_t0_cnt4
3311  02bd b606          	ld	a,_t0_cnt4
3312  02bf a132          	cp	a,#50
3313  02c1 2506          	jrult	L1271
3314                     ; 393 		t0_cnt4=0;
3316  02c3 3f06          	clr	_t0_cnt4
3317                     ; 394 		b2Hz=1;
3319  02c5 72100002      	bset	_b2Hz
3320  02c9               L1271:
3321                     ; 397 	if(++t0_cnt3>=100)
3323  02c9 3c05          	inc	_t0_cnt3
3324  02cb b605          	ld	a,_t0_cnt3
3325  02cd a164          	cp	a,#100
3326  02cf 2506          	jrult	L3171
3327                     ; 399 		t0_cnt3=0;
3329  02d1 3f05          	clr	_t0_cnt3
3330                     ; 400 		b1Hz=1;
3332  02d3 72100001      	bset	_b1Hz
3333  02d7               L3171:
3334                     ; 406 }
3337  02d7 80            	iret
3390                     ; 410 @far @interrupt void ADC2_EOC_Interrupt (void) {
3391                     	switch	.text
3392  02d8               f_ADC2_EOC_Interrupt:
3394       0000000d      OFST:	set	13
3395  02d8 be00          	ldw	x,c_x
3396  02da 89            	pushw	x
3397  02db be00          	ldw	x,c_y
3398  02dd 89            	pushw	x
3399  02de be02          	ldw	x,c_lreg+2
3400  02e0 89            	pushw	x
3401  02e1 be00          	ldw	x,c_lreg
3402  02e3 89            	pushw	x
3403  02e4 520d          	subw	sp,#13
3406                     ; 415 ADC2->CSR&=~(1<<7);
3408  02e6 721f5400      	bres	21504,#7
3409                     ; 417 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
3411  02ea c65405        	ld	a,21509
3412  02ed b703          	ld	c_lreg+3,a
3413  02ef 3f02          	clr	c_lreg+2
3414  02f1 3f01          	clr	c_lreg+1
3415  02f3 3f00          	clr	c_lreg
3416  02f5 96            	ldw	x,sp
3417  02f6 1c0001        	addw	x,#OFST-12
3418  02f9 cd0000        	call	c_rtol
3420  02fc c65404        	ld	a,21508
3421  02ff 5f            	clrw	x
3422  0300 97            	ld	xl,a
3423  0301 90ae0100      	ldw	y,#256
3424  0305 cd0000        	call	c_umul
3426  0308 96            	ldw	x,sp
3427  0309 1c0001        	addw	x,#OFST-12
3428  030c cd0000        	call	c_ladd
3430                     ; 420 adc_ch=0;
3432  030f 3f20          	clr	_adc_ch
3433                     ; 421 adc_cnt++;
3435  0311 3c1f          	inc	_adc_cnt
3436                     ; 422 if(adc_cnt>=16)
3438  0313 b61f          	ld	a,_adc_cnt
3439  0315 a110          	cp	a,#16
3440  0317 2502          	jrult	L3571
3441                     ; 424 	adc_cnt=0;
3443  0319 3f1f          	clr	_adc_cnt
3444  031b               L3571:
3445                     ; 427 if((adc_cnt&0x03)==0)
3447  031b b61f          	ld	a,_adc_cnt
3448  031d a503          	bcp	a,#3
3449  031f 260a          	jrne	L5571
3450                     ; 431 	tempSS=0;
3452                     ; 432 	for(i=0;i<16;i++)
3454  0321 0f09          	clr	(OFST-4,sp)
3455  0323               L7571:
3458  0323 0c09          	inc	(OFST-4,sp)
3461  0325 7b09          	ld	a,(OFST-4,sp)
3462  0327 a110          	cp	a,#16
3463  0329 25f8          	jrult	L7571
3464  032b               L5571:
3465                     ; 439 }
3468  032b 5b0d          	addw	sp,#13
3469  032d 85            	popw	x
3470  032e bf00          	ldw	c_lreg,x
3471  0330 85            	popw	x
3472  0331 bf02          	ldw	c_lreg+2,x
3473  0333 85            	popw	x
3474  0334 bf00          	ldw	c_y,x
3475  0336 85            	popw	x
3476  0337 bf00          	ldw	c_x,x
3477  0339 80            	iret
3502                     ; 442 @far @interrupt void PortD_Ext_Interrupt (void) {
3503                     	switch	.text
3504  033a               f_PortD_Ext_Interrupt:
3508                     ; 445 GPIOA->ODR^=(1<<5);
3510  033a c65000        	ld	a,20480
3511  033d a820          	xor	a,	#32
3512  033f c75000        	ld	20480,a
3513                     ; 448 buffer_for_timer1_H=TIM2->CNTRH;
3515  0342 55530a0003    	mov	_buffer_for_timer1_H,21258
3516                     ; 449 buffer_for_timer1_L=TIM2->CNTRL;
3518  0347 55530b0002    	mov	_buffer_for_timer1_L,21259
3519                     ; 451 TIM2->CNTRH=0;
3521  034c 725f530a      	clr	21258
3522                     ; 452 TIM2->CNTRL=0;
3524  0350 725f530b      	clr	21259
3525                     ; 454 }
3528  0354 80            	iret
3566                     ; 457 @far @interrupt void UART1TxInterrupt (void) 
3566                     ; 458 {
3567                     	switch	.text
3568  0355               f_UART1TxInterrupt:
3570       00000001      OFST:	set	1
3571  0355 88            	push	a
3574                     ; 461 tx_status=UART1->SR;
3576  0356 c65230        	ld	a,21040
3577  0359 6b01          	ld	(OFST+0,sp),a
3578                     ; 463 if (tx_status & (UART1_SR_TXE))
3580  035b 7b01          	ld	a,(OFST+0,sp)
3581  035d a580          	bcp	a,#128
3582  035f 272a          	jreq	L3102
3583                     ; 465 	if (tx_counter1)
3585  0361 3d25          	tnz	_tx_counter1
3586  0363 271a          	jreq	L5102
3587                     ; 467 		--tx_counter1;
3589  0365 3a25          	dec	_tx_counter1
3590                     ; 468 		UART1->DR=tx_buffer1[tx_rd_index1];
3592  0367 5f            	clrw	x
3593  0368 b623          	ld	a,_tx_rd_index1
3594  036a 2a01          	jrpl	L06
3595  036c 53            	cplw	x
3596  036d               L06:
3597  036d 97            	ld	xl,a
3598  036e e607          	ld	a,(_tx_buffer1,x)
3599  0370 c75231        	ld	21041,a
3600                     ; 469 		if (++tx_rd_index1 == TX_BUFFER_SIZE1) tx_rd_index1=0;
3602  0373 3c23          	inc	_tx_rd_index1
3603  0375 b623          	ld	a,_tx_rd_index1
3604  0377 a132          	cp	a,#50
3605  0379 2610          	jrne	L3102
3608  037b 3f23          	clr	_tx_rd_index1
3609  037d 200c          	jra	L3102
3610  037f               L5102:
3611                     ; 473 		tx_stat_cnt=3;
3613  037f 35030022      	mov	_tx_stat_cnt,#3
3614                     ; 474 			bOUT_FREE=1;
3616  0383 35010021      	mov	_bOUT_FREE,#1
3617                     ; 475 			UART1->CR2&= ~UART1_CR2_TIEN;
3619  0387 721f5235      	bres	21045,#7
3620  038b               L3102:
3621                     ; 479 if (tx_status & (UART1_SR_TC))
3623  038b 7b01          	ld	a,(OFST+0,sp)
3624  038d a540          	bcp	a,#64
3625  038f 2704          	jreq	L3202
3626                     ; 481 	UART1->SR&=~UART1_SR_TC;
3628  0391 721d5230      	bres	21040,#6
3629  0395               L3202:
3630                     ; 483 }
3633  0395 84            	pop	a
3634  0396 80            	iret
3676                     ; 486 @far @interrupt void UART1RxInterrupt (void) 
3676                     ; 487 {
3677                     	switch	.text
3678  0397               f_UART1RxInterrupt:
3680       00000002      OFST:	set	2
3681  0397 89            	pushw	x
3684                     ; 490 rx_status=UART1->SR;
3686  0398 c65230        	ld	a,21040
3687                     ; 491 rx_data=UART1->DR;
3689  039b c65231        	ld	a,21041
3690                     ; 493 }
3693  039e 5b02          	addw	sp,#2
3694  03a0 80            	iret
3737                     ; 496 @far @interrupt void TIM2_CC_Interrupt (void)
3737                     ; 497 {
3738                     	switch	.text
3739  03a1               f_TIM2_CC_Interrupt:
3741       00000002      OFST:	set	2
3742  03a1 89            	pushw	x
3745                     ; 500 h = TIM2->CCR1H;
3747  03a2 c6530f        	ld	a,21263
3748  03a5 6b01          	ld	(OFST-1,sp),a
3749                     ; 501 l = TIM2->CCR1L;
3751  03a7 c65310        	ld	a,21264
3752  03aa 6b02          	ld	(OFST+0,sp),a
3753                     ; 502 inPulseCount = ((u16)h << 8) | l;
3755  03ac 7b01          	ld	a,(OFST-1,sp)
3756  03ae 5f            	clrw	x
3757  03af 97            	ld	xl,a
3758  03b0 7b02          	ld	a,(OFST+0,sp)
3759  03b2 02            	rlwa	x,a
3760  03b3 bf00          	ldw	_inPulseCount,x
3761                     ; 503 TIM2->SR1 = TIM2_SR1_RESET_VALUE;
3763  03b5 725f5302      	clr	21250
3764                     ; 504 TIM2->SR2 = TIM2_SR2_RESET_VALUE;
3766  03b9 725f5303      	clr	21251
3767                     ; 505 }
3770  03bd 5b02          	addw	sp,#2
3771  03bf 80            	iret
3807                     ; 512 main()
3807                     ; 513 {
3809                     	switch	.text
3810  03c0               _main:
3814                     ; 515 CLK->ECKR|=1;
3816  03c0 721050c1      	bset	20673,#0
3818  03c4               L3012:
3819                     ; 516 while((CLK->ECKR & 2) == 0);
3821  03c4 c650c1        	ld	a,20673
3822  03c7 a502          	bcp	a,#2
3823  03c9 27f9          	jreq	L3012
3824                     ; 517 CLK->SWCR|=2;
3826  03cb 721250c5      	bset	20677,#1
3827                     ; 518 CLK->SWR=0xB4;
3829  03cf 35b450c4      	mov	20676,#180
3830                     ; 521 FLASH->DUKR=0xae;
3832  03d3 35ae5064      	mov	20580,#174
3833                     ; 522 FLASH->DUKR=0x56;
3835  03d7 35565064      	mov	20580,#86
3836                     ; 524 exti_init();
3838  03db cd016e        	call	_exti_init
3840                     ; 526 enableInterrupts();
3843  03de 9a            rim
3845                     ; 533 t4_init();
3848  03df cd00be        	call	_t4_init
3850                     ; 535 		GPIOG->DDR|=(1<<0);
3852  03e2 72105020      	bset	20512,#0
3853                     ; 536 		GPIOG->CR1|=(1<<0);
3855  03e6 72105021      	bset	20513,#0
3856                     ; 537 		GPIOG->CR2&=~(1<<0);	
3858  03ea 72115022      	bres	20514,#0
3859                     ; 540 		GPIOG->DDR&=~(1<<1);
3861  03ee 72135020      	bres	20512,#1
3862                     ; 541 		GPIOG->CR1|=(1<<1);
3864  03f2 72125021      	bset	20513,#1
3865                     ; 542 		GPIOG->CR2&=~(1<<1);
3867  03f6 72135022      	bres	20514,#1
3868                     ; 548 GPIOC->DDR|=(1<<1);
3870  03fa 7212500c      	bset	20492,#1
3871                     ; 549 GPIOC->CR1|=(1<<1);
3873  03fe 7212500d      	bset	20493,#1
3874                     ; 550 GPIOC->CR2|=(1<<1);
3876  0402 7212500e      	bset	20494,#1
3877                     ; 552 GPIOC->DDR|=(1<<2);
3879  0406 7214500c      	bset	20492,#2
3880                     ; 553 GPIOC->CR1|=(1<<2);
3882  040a 7214500d      	bset	20493,#2
3883                     ; 554 GPIOC->CR2|=(1<<2);
3885  040e 7214500e      	bset	20494,#2
3886                     ; 561 t1_init();
3888  0412 cd017f        	call	_t1_init
3890                     ; 562 t2_init();
3892  0415 cd01fe        	call	_t2_init
3894                     ; 564 uart1_init();
3896  0418 cd008e        	call	_uart1_init
3898                     ; 566 GPIOA->DDR|=(1<<5);
3900  041b 721a5002      	bset	20482,#5
3901                     ; 567 GPIOA->CR1|=(1<<5);
3903  041f 721a5003      	bset	20483,#5
3904                     ; 568 GPIOA->CR2&=~(1<<5);
3906  0423 721b5004      	bres	20484,#5
3907                     ; 570 GPIOA->DDR|=(1<<6);
3909  0427 721c5002      	bset	20482,#6
3910                     ; 571 GPIOA->CR1|=(1<<6);
3912  042b 721c5003      	bset	20483,#6
3913                     ; 572 GPIOA->CR2&=~(1<<6);
3915  042f 721d5004      	bres	20484,#6
3916                     ; 578 GPIOB->DDR&=~(1<<3);
3918  0433 72175007      	bres	20487,#3
3919                     ; 579 GPIOB->CR1&=~(1<<3);
3921  0437 72175008      	bres	20488,#3
3922                     ; 580 GPIOB->CR2&=~(1<<3);
3924  043b 72175009      	bres	20489,#3
3925                     ; 582 GPIOC->DDR|=(1<<3);
3927  043f 7216500c      	bset	20492,#3
3928                     ; 583 GPIOC->CR1|=(1<<3);
3930  0443 7216500d      	bset	20493,#3
3931                     ; 584 GPIOC->CR2|=(1<<3);
3933  0447 7216500e      	bset	20494,#3
3934  044b               L7012:
3935                     ; 594 if(b100Hz)
3937                     	btst	_b100Hz
3938  0450 2404          	jruge	L3112
3939                     ; 596 		b100Hz=0;
3941  0452 72110005      	bres	_b100Hz
3942  0456               L3112:
3943                     ; 602 	if(b10Hz)
3945                     	btst	_b10Hz
3946  045b 241b          	jruge	L5112
3947                     ; 604 		b10Hz=0;
3949  045d 72110004      	bres	_b10Hz
3950                     ; 610 		TIM1->ARRH=(u8)(inPulseCount>>8);//buffer_for_timer1_H;
3952  0461 5500005262    	mov	21090,_inPulseCount
3953                     ; 611 		TIM1->ARRL=(u8)inPulseCount;//buffer_for_timer1_L;
3955  0466 5500015263    	mov	21091,_inPulseCount+1
3956                     ; 612 		TIM1->CCR2H=(u8)(inPulseCount>>9);//buffer_for_timer1_H>>1;	
3958  046b be00          	ldw	x,_inPulseCount
3959  046d 4f            	clr	a
3960  046e 01            	rrwa	x,a
3961  046f 54            	srlw	x
3962  0470 9f            	ld	a,xl
3963  0471 c75267        	ld	21095,a
3964                     ; 613 		TIM1->CCR2L=0;
3966  0474 725f5268      	clr	21096
3967  0478               L5112:
3968                     ; 616 	if(b5Hz)
3970                     	btst	_b5Hz
3971  047d 2412          	jruge	L7112
3972                     ; 618 		b5Hz=0;
3974  047f 72110003      	bres	_b5Hz
3975                     ; 621 		if((TIM2->CNTRL))GPIOA->ODR^=(1<<6);
3977  0483 725d530b      	tnz	21259
3978  0487 2708          	jreq	L7112
3981  0489 c65000        	ld	a,20480
3982  048c a840          	xor	a,	#64
3983  048e c75000        	ld	20480,a
3984  0491               L7112:
3985                     ; 624 	if(b2Hz)
3987                     	btst	_b2Hz
3988  0496 2404          	jruge	L3212
3989                     ; 626 		b2Hz=0;
3991  0498 72110002      	bres	_b2Hz
3992  049c               L3212:
3993                     ; 630 	if(b1Hz)
3995                     	btst	_b1Hz
3996  04a1 24a8          	jruge	L7012
3997                     ; 632 		b1Hz=0;
3999  04a3 72110001      	bres	_b1Hz
4000                     ; 634 		if(main_cnt<1000)main_cnt++;
4002  04a7 9c            	rvf
4003  04a8 be10          	ldw	x,_main_cnt
4004  04aa a303e8        	cpw	x,#1000
4005  04ad 2e07          	jrsge	L7212
4008  04af be10          	ldw	x,_main_cnt
4009  04b1 1c0001        	addw	x,#1
4010  04b4 bf10          	ldw	_main_cnt,x
4011  04b6               L7212:
4012                     ; 637 		printf("%i",inPulseCount);
4014  04b6 be00          	ldw	x,_inPulseCount
4015  04b8 89            	pushw	x
4016  04b9 ae0000        	ldw	x,#L1312
4017  04bc cd0000        	call	_printf
4019  04bf 85            	popw	x
4020  04c0 2089          	jra	L7012
4352                     	xdef	_main
4353                     	xdef	f_TIM2_CC_Interrupt
4354                     	xdef	f_UART1RxInterrupt
4355                     	xdef	f_UART1TxInterrupt
4356                     	xdef	f_PortD_Ext_Interrupt
4357                     	xdef	f_ADC2_EOC_Interrupt
4358                     	xdef	f_TIM4_UPD_Interrupt
4359                     	xdef	_adc2_init
4360                     	xdef	_t2_init
4361                     	xdef	_t3_init_
4362                     	xdef	_t2_init_
4363                     	xdef	_t1_init
4364                     	xdef	_exti_init
4365                     	xdef	_adr_drv_v3
4366                     	xdef	_matemat
4367                     	xdef	_pwr_hndl
4368                     	xdef	_pwr_drv
4369                     	xdef	_led_drv
4370                     	xdef	_t4_init
4371                     	xdef	_uart1_init
4372                     	xdef	_delay_ms
4373                     	xdef	_granee
4374                     	xdef	_gran
4375                     	switch	.ubsct
4376  0000               _inPulseCount:
4377  0000 0000          	ds.b	2
4378                     	xdef	_inPulseCount
4379  0002               _buffer_for_timer1_L:
4380  0002 00            	ds.b	1
4381                     	xdef	_buffer_for_timer1_L
4382  0003               _buffer_for_timer1_H:
4383  0003 00            	ds.b	1
4384                     	xdef	_buffer_for_timer1_H
4385  0004               _i_main_sigma:
4386  0004 0000          	ds.b	2
4387                     	xdef	_i_main_sigma
4388  0006               _i_main_num_of_bps:
4389  0006 00            	ds.b	1
4390                     	xdef	_i_main_num_of_bps
4391  0007               _cnt_net_drv:
4392  0007 00            	ds.b	1
4393                     	xdef	_cnt_net_drv
4394                     .bit:	section	.data,bit
4395  0000               _bMAIN:
4396  0000 00            	ds.b	1
4397                     	xdef	_bMAIN
4398                     	switch	.ubsct
4399  0008               _plazma_int:
4400  0008 000000000000  	ds.b	6
4401                     	xdef	_plazma_int
4402                     	xdef	_rotor_int
4403  000e               _main_cnt1:
4404  000e 0000          	ds.b	2
4405                     	xdef	_main_cnt1
4406  0010               _main_cnt:
4407  0010 0000          	ds.b	2
4408                     	xdef	_main_cnt
4409  0012               _off_bp_cnt:
4410  0012 00            	ds.b	1
4411                     	xdef	_off_bp_cnt
4412  0013               _adc_plazma:
4413  0013 000000000000  	ds.b	10
4414                     	xdef	_adc_plazma
4415  001d               _adc_plazma_short:
4416  001d 0000          	ds.b	2
4417                     	xdef	_adc_plazma_short
4418  001f               _adc_cnt:
4419  001f 00            	ds.b	1
4420                     	xdef	_adc_cnt
4421  0020               _adc_ch:
4422  0020 00            	ds.b	1
4423                     	xdef	_adc_ch
4424  0021               _bOUT_FREE:
4425  0021 00            	ds.b	1
4426                     	xdef	_bOUT_FREE
4427                     	xdef	_tx_wd_cnt
4428  0022               _tx_stat_cnt:
4429  0022 00            	ds.b	1
4430                     	xdef	_tx_stat_cnt
4431  0023               _tx_rd_index1:
4432  0023 00            	ds.b	1
4433                     	xdef	_tx_rd_index1
4434  0024               _tx_wr_index1:
4435  0024 00            	ds.b	1
4436                     	xdef	_tx_wr_index1
4437  0025               _tx_counter1:
4438  0025 00            	ds.b	1
4439                     	xdef	_tx_counter1
4440                     	xdef	_tx_buffer1
4441                     	switch	.bit
4442  0001               _b1Hz:
4443  0001 00            	ds.b	1
4444                     	xdef	_b1Hz
4445  0002               _b2Hz:
4446  0002 00            	ds.b	1
4447                     	xdef	_b2Hz
4448  0003               _b5Hz:
4449  0003 00            	ds.b	1
4450                     	xdef	_b5Hz
4451  0004               _b10Hz:
4452  0004 00            	ds.b	1
4453                     	xdef	_b10Hz
4454  0005               _b100Hz:
4455  0005 00            	ds.b	1
4456                     	xdef	_b100Hz
4457                     	xdef	_t0_cnt4
4458                     	xdef	_t0_cnt3
4459                     	xdef	_t0_cnt2
4460                     	xdef	_t0_cnt1
4461                     	xdef	_t0_cnt0
4462                     	xdef	_putchar
4463                     	xref	_printf
4464                     	xdef	_bVENT_BLOCK
4465                     .const:	section	.text
4466  0000               L1312:
4467  0000 256900        	dc.b	"%i",0
4468                     	xref.b	c_lreg
4469                     	xref.b	c_x
4470                     	xref.b	c_y
4490                     	xref	c_ladd
4491                     	xref	c_umul
4492                     	xref	c_lcmp
4493                     	xref	c_ltor
4494                     	xref	c_lgadc
4495                     	xref	c_rtol
4496                     	xref	c_vmul
4497                     	xref	c_eewrw
4498                     	end
