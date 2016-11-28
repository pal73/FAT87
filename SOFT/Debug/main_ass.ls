   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  15                     	bsct
  16  0000               _bVENT_BLOCK:
  17  0000 00            	dc.b	0
2175                     	bsct
2176  0001               _t0_cnt0:
2177  0001 0000          	dc.w	0
2178  0003               _t0_cnt1:
2179  0003 00            	dc.b	0
2180  0004               _t0_cnt2:
2181  0004 00            	dc.b	0
2182  0005               _t0_cnt3:
2183  0005 00            	dc.b	0
2184  0006               _t0_cnt4:
2185  0006 00            	dc.b	0
2186  0007               _led_ind:
2187  0007 05            	dc.b	5
2188  0008               _adr_drv_stat:
2189  0008 00            	dc.b	0
2190  0009               _flags:
2191  0009 00            	dc.b	0
2192  000a               _pwm_u:
2193  000a 00c8          	dc.w	200
2194  000c               _pwm_i:
2195  000c 0032          	dc.w	50
2196                     .bit:	section	.data,bit
2197  0000               _bBL_IPS:
2198  0000 00            	dc.b	0
2199                     	bsct
2200  000e               _bRES:
2201  000e 00            	dc.b	0
2202  000f               _bRES_:
2203  000f 00            	dc.b	0
2204  0010               _led_red:
2205  0010 00000000      	dc.l	0
2206  0014               _led_green:
2207  0014 03030303      	dc.l	50529027
2208  0018               _led_drv_cnt:
2209  0018 1e            	dc.b	30
2210  0019               _rotor_int:
2211  0019 007b          	dc.w	123
2212  001b               _volum_u_main_:
2213  001b 02bc          	dc.w	700
2272                     ; 156 void gran(signed short *adr, signed short min, signed short max)
2272                     ; 157 {
2274                     	switch	.text
2275  0000               _gran:
2277  0000 89            	pushw	x
2278       00000000      OFST:	set	0
2281                     ; 158 if (*adr<min) *adr=min;
2283  0001 9c            	rvf
2284  0002 9093          	ldw	y,x
2285  0004 51            	exgw	x,y
2286  0005 fe            	ldw	x,(x)
2287  0006 1305          	cpw	x,(OFST+5,sp)
2288  0008 51            	exgw	x,y
2289  0009 2e03          	jrsge	L7541
2292  000b 1605          	ldw	y,(OFST+5,sp)
2293  000d ff            	ldw	(x),y
2294  000e               L7541:
2295                     ; 159 if (*adr>max) *adr=max; 
2297  000e 9c            	rvf
2298  000f 1e01          	ldw	x,(OFST+1,sp)
2299  0011 9093          	ldw	y,x
2300  0013 51            	exgw	x,y
2301  0014 fe            	ldw	x,(x)
2302  0015 1307          	cpw	x,(OFST+7,sp)
2303  0017 51            	exgw	x,y
2304  0018 2d05          	jrsle	L1641
2307  001a 1e01          	ldw	x,(OFST+1,sp)
2308  001c 1607          	ldw	y,(OFST+7,sp)
2309  001e ff            	ldw	(x),y
2310  001f               L1641:
2311                     ; 160 } 
2314  001f 85            	popw	x
2315  0020 81            	ret
2368                     ; 163 void granee(@eeprom signed short *adr, signed short min, signed short max)
2368                     ; 164 {
2369                     	switch	.text
2370  0021               _granee:
2372  0021 89            	pushw	x
2373       00000000      OFST:	set	0
2376                     ; 165 if (*adr<min) *adr=min;
2378  0022 9c            	rvf
2379  0023 9093          	ldw	y,x
2380  0025 51            	exgw	x,y
2381  0026 fe            	ldw	x,(x)
2382  0027 1305          	cpw	x,(OFST+5,sp)
2383  0029 51            	exgw	x,y
2384  002a 2e09          	jrsge	L1151
2387  002c 1e05          	ldw	x,(OFST+5,sp)
2388  002e 89            	pushw	x
2389  002f 1e03          	ldw	x,(OFST+3,sp)
2390  0031 cd0000        	call	c_eewrw
2392  0034 85            	popw	x
2393  0035               L1151:
2394                     ; 166 if (*adr>max) *adr=max; 
2396  0035 9c            	rvf
2397  0036 1e01          	ldw	x,(OFST+1,sp)
2398  0038 9093          	ldw	y,x
2399  003a 51            	exgw	x,y
2400  003b fe            	ldw	x,(x)
2401  003c 1307          	cpw	x,(OFST+7,sp)
2402  003e 51            	exgw	x,y
2403  003f 2d09          	jrsle	L3151
2406  0041 1e07          	ldw	x,(OFST+7,sp)
2407  0043 89            	pushw	x
2408  0044 1e03          	ldw	x,(OFST+3,sp)
2409  0046 cd0000        	call	c_eewrw
2411  0049 85            	popw	x
2412  004a               L3151:
2413                     ; 167 }
2416  004a 85            	popw	x
2417  004b 81            	ret
2478                     ; 170 long delay_ms(short in)
2478                     ; 171 {
2479                     	switch	.text
2480  004c               _delay_ms:
2482  004c 520c          	subw	sp,#12
2483       0000000c      OFST:	set	12
2486                     ; 174 i=((long)in)*100UL;
2488  004e 90ae0064      	ldw	y,#100
2489  0052 cd0000        	call	c_vmul
2491  0055 96            	ldw	x,sp
2492  0056 1c0005        	addw	x,#OFST-7
2493  0059 cd0000        	call	c_rtol
2495                     ; 176 for(ii=0;ii<i;ii++)
2497  005c ae0000        	ldw	x,#0
2498  005f 1f0b          	ldw	(OFST-1,sp),x
2499  0061 ae0000        	ldw	x,#0
2500  0064 1f09          	ldw	(OFST-3,sp),x
2502  0066 2012          	jra	L3551
2503  0068               L7451:
2504                     ; 178 		iii++;
2506  0068 96            	ldw	x,sp
2507  0069 1c0001        	addw	x,#OFST-11
2508  006c a601          	ld	a,#1
2509  006e cd0000        	call	c_lgadc
2511                     ; 176 for(ii=0;ii<i;ii++)
2513  0071 96            	ldw	x,sp
2514  0072 1c0009        	addw	x,#OFST-3
2515  0075 a601          	ld	a,#1
2516  0077 cd0000        	call	c_lgadc
2518  007a               L3551:
2521  007a 9c            	rvf
2522  007b 96            	ldw	x,sp
2523  007c 1c0009        	addw	x,#OFST-3
2524  007f cd0000        	call	c_ltor
2526  0082 96            	ldw	x,sp
2527  0083 1c0005        	addw	x,#OFST-7
2528  0086 cd0000        	call	c_lcmp
2530  0089 2fdd          	jrslt	L7451
2531                     ; 181 }
2534  008b 5b0c          	addw	sp,#12
2535  008d 81            	ret
2558                     ; 184 void t4_init(void){
2559                     	switch	.text
2560  008e               _t4_init:
2564                     ; 185 	TIM4->PSCR = 4;
2566  008e 35045345      	mov	21317,#4
2567                     ; 186 	TIM4->ARR= 77;
2569  0092 354d5346      	mov	21318,#77
2570                     ; 187 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
2572  0096 72105341      	bset	21313,#0
2573                     ; 189 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
2575  009a 35855340      	mov	21312,#133
2576                     ; 191 }
2579  009e 81            	ret
2602                     ; 195 void led_drv(void)
2602                     ; 196 {
2603                     	switch	.text
2604  009f               _led_drv:
2608                     ; 197 } 
2611  009f 81            	ret
2638                     ; 205 void pwr_drv(void)
2638                     ; 206 {
2639                     	switch	.text
2640  00a0               _pwr_drv:
2644                     ; 217 pwm_u=1050-adc_buff_[0];
2646  00a0 ae041a        	ldw	x,#1050
2647  00a3 72b00005      	subw	x,_adc_buff_
2648  00a7 bf0a          	ldw	_pwm_u,x
2649                     ; 219 if(pwm_u>1020)pwm_u=1020;
2651  00a9 9c            	rvf
2652  00aa be0a          	ldw	x,_pwm_u
2653  00ac a303fd        	cpw	x,#1021
2654  00af 2f05          	jrslt	L7061
2657  00b1 ae03fc        	ldw	x,#1020
2658  00b4 bf0a          	ldw	_pwm_u,x
2659  00b6               L7061:
2660                     ; 220 pwm_i=adc_buff_[0];
2662  00b6 ce0005        	ldw	x,_adc_buff_
2663  00b9 bf0c          	ldw	_pwm_i,x
2664                     ; 224 TIM1->CCR2H= (char)(pwm_u/256);	
2666  00bb be0a          	ldw	x,_pwm_u
2667  00bd 90ae0100      	ldw	y,#256
2668  00c1 cd0000        	call	c_idiv
2670  00c4 9f            	ld	a,xl
2671  00c5 c75267        	ld	21095,a
2672                     ; 225 TIM1->CCR2L= (char)pwm_u;
2674  00c8 55000b5268    	mov	21096,_pwm_u+1
2675                     ; 227 TIM1->CCR1H= (char)(pwm_i/256);	
2677  00cd be0c          	ldw	x,_pwm_i
2678  00cf 90ae0100      	ldw	y,#256
2679  00d3 cd0000        	call	c_idiv
2681  00d6 9f            	ld	a,xl
2682  00d7 c75265        	ld	21093,a
2683                     ; 228 TIM1->CCR1L= (char)pwm_i;
2685  00da 55000d5266    	mov	21094,_pwm_i+1
2686                     ; 230 TIM1->CCR3H= (char)(vent_pwm/256);	
2688  00df be01          	ldw	x,_vent_pwm
2689  00e1 90ae0100      	ldw	y,#256
2690  00e5 cd0000        	call	c_idiv
2692  00e8 9f            	ld	a,xl
2693  00e9 c75269        	ld	21097,a
2694                     ; 231 TIM1->CCR3L= (char)vent_pwm;
2696  00ec 550002526a    	mov	21098,_vent_pwm+1
2697                     ; 232 }
2700  00f1 81            	ret
2723                     ; 237 void pwr_hndl(void)				
2723                     ; 238 {
2724                     	switch	.text
2725  00f2               _pwr_hndl:
2729                     ; 240 }
2732  00f2 81            	ret
2755                     ; 243 void matemat(void)
2755                     ; 244 {
2756                     	switch	.text
2757  00f3               _matemat:
2761                     ; 247 }
2764  00f3 81            	ret
2799                     ; 385 void adr_drv_v4(char in)
2799                     ; 386 {
2800                     	switch	.text
2801  00f4               _adr_drv_v4:
2805                     ; 387 if(adress!=in)adress=in;
2807  00f4 c10001        	cp	a,_adress
2808  00f7 2703          	jreq	L7461
2811  00f9 c70001        	ld	_adress,a
2812  00fc               L7461:
2813                     ; 388 }
2816  00fc 81            	ret
2845                     ; 391 void adr_drv_v3(void)
2845                     ; 392 {
2846                     	switch	.text
2847  00fd               _adr_drv_v3:
2849  00fd 88            	push	a
2850       00000001      OFST:	set	1
2853                     ; 398 GPIOB->DDR&=~(1<<0);
2855  00fe 72115007      	bres	20487,#0
2856                     ; 399 GPIOB->CR1&=~(1<<0);
2858  0102 72115008      	bres	20488,#0
2859                     ; 400 GPIOB->CR2&=~(1<<0);
2861  0106 72115009      	bres	20489,#0
2862                     ; 401 ADC2->CR2=0x08;
2864  010a 35085402      	mov	21506,#8
2865                     ; 402 ADC2->CR1=0x40;
2867  010e 35405401      	mov	21505,#64
2868                     ; 403 ADC2->CSR=0x20+0;
2870  0112 35205400      	mov	21504,#32
2871                     ; 404 ADC2->CR1|=1;
2873  0116 72105401      	bset	21505,#0
2874                     ; 405 ADC2->CR1|=1;
2876  011a 72105401      	bset	21505,#0
2877                     ; 406 adr_drv_stat=1;
2879  011e 35010008      	mov	_adr_drv_stat,#1
2880  0122               L1661:
2881                     ; 407 while(adr_drv_stat==1);
2884  0122 b608          	ld	a,_adr_drv_stat
2885  0124 a101          	cp	a,#1
2886  0126 27fa          	jreq	L1661
2887                     ; 409 GPIOB->DDR&=~(1<<1);
2889  0128 72135007      	bres	20487,#1
2890                     ; 410 GPIOB->CR1&=~(1<<1);
2892  012c 72135008      	bres	20488,#1
2893                     ; 411 GPIOB->CR2&=~(1<<1);
2895  0130 72135009      	bres	20489,#1
2896                     ; 412 ADC2->CR2=0x08;
2898  0134 35085402      	mov	21506,#8
2899                     ; 413 ADC2->CR1=0x40;
2901  0138 35405401      	mov	21505,#64
2902                     ; 414 ADC2->CSR=0x20+1;
2904  013c 35215400      	mov	21504,#33
2905                     ; 415 ADC2->CR1|=1;
2907  0140 72105401      	bset	21505,#0
2908                     ; 416 ADC2->CR1|=1;
2910  0144 72105401      	bset	21505,#0
2911                     ; 417 adr_drv_stat=3;
2913  0148 35030008      	mov	_adr_drv_stat,#3
2914  014c               L7661:
2915                     ; 418 while(adr_drv_stat==3);
2918  014c b608          	ld	a,_adr_drv_stat
2919  014e a103          	cp	a,#3
2920  0150 27fa          	jreq	L7661
2921                     ; 420 GPIOE->DDR&=~(1<<6);
2923  0152 721d5016      	bres	20502,#6
2924                     ; 421 GPIOE->CR1&=~(1<<6);
2926  0156 721d5017      	bres	20503,#6
2927                     ; 422 GPIOE->CR2&=~(1<<6);
2929  015a 721d5018      	bres	20504,#6
2930                     ; 423 ADC2->CR2=0x08;
2932  015e 35085402      	mov	21506,#8
2933                     ; 424 ADC2->CR1=0x40;
2935  0162 35405401      	mov	21505,#64
2936                     ; 425 ADC2->CSR=0x20+9;
2938  0166 35295400      	mov	21504,#41
2939                     ; 426 ADC2->CR1|=1;
2941  016a 72105401      	bset	21505,#0
2942                     ; 427 ADC2->CR1|=1;
2944  016e 72105401      	bset	21505,#0
2945                     ; 428 adr_drv_stat=5;
2947  0172 35050008      	mov	_adr_drv_stat,#5
2948  0176               L5761:
2949                     ; 429 while(adr_drv_stat==5);
2952  0176 b608          	ld	a,_adr_drv_stat
2953  0178 a105          	cp	a,#5
2954  017a 27fa          	jreq	L5761
2955                     ; 433 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
2957  017c 9c            	rvf
2958  017d ce0005        	ldw	x,_adc_buff_
2959  0180 a3022a        	cpw	x,#554
2960  0183 2f0f          	jrslt	L3071
2962  0185 9c            	rvf
2963  0186 ce0005        	ldw	x,_adc_buff_
2964  0189 a30253        	cpw	x,#595
2965  018c 2e06          	jrsge	L3071
2968  018e 725f0002      	clr	_adr
2970  0192 204c          	jra	L5071
2971  0194               L3071:
2972                     ; 434 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
2974  0194 9c            	rvf
2975  0195 ce0005        	ldw	x,_adc_buff_
2976  0198 a3036d        	cpw	x,#877
2977  019b 2f0f          	jrslt	L7071
2979  019d 9c            	rvf
2980  019e ce0005        	ldw	x,_adc_buff_
2981  01a1 a30396        	cpw	x,#918
2982  01a4 2e06          	jrsge	L7071
2985  01a6 35010002      	mov	_adr,#1
2987  01aa 2034          	jra	L5071
2988  01ac               L7071:
2989                     ; 435 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
2991  01ac 9c            	rvf
2992  01ad ce0005        	ldw	x,_adc_buff_
2993  01b0 a302a3        	cpw	x,#675
2994  01b3 2f0f          	jrslt	L3171
2996  01b5 9c            	rvf
2997  01b6 ce0005        	ldw	x,_adc_buff_
2998  01b9 a302cc        	cpw	x,#716
2999  01bc 2e06          	jrsge	L3171
3002  01be 35020002      	mov	_adr,#2
3004  01c2 201c          	jra	L5071
3005  01c4               L3171:
3006                     ; 436 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
3008  01c4 9c            	rvf
3009  01c5 ce0005        	ldw	x,_adc_buff_
3010  01c8 a303e3        	cpw	x,#995
3011  01cb 2f0f          	jrslt	L7171
3013  01cd 9c            	rvf
3014  01ce ce0005        	ldw	x,_adc_buff_
3015  01d1 a3040c        	cpw	x,#1036
3016  01d4 2e06          	jrsge	L7171
3019  01d6 35030002      	mov	_adr,#3
3021  01da 2004          	jra	L5071
3022  01dc               L7171:
3023                     ; 437 else adr[0]=5;
3025  01dc 35050002      	mov	_adr,#5
3026  01e0               L5071:
3027                     ; 439 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
3029  01e0 9c            	rvf
3030  01e1 ce0007        	ldw	x,_adc_buff_+2
3031  01e4 a3022a        	cpw	x,#554
3032  01e7 2f0f          	jrslt	L3271
3034  01e9 9c            	rvf
3035  01ea ce0007        	ldw	x,_adc_buff_+2
3036  01ed a30253        	cpw	x,#595
3037  01f0 2e06          	jrsge	L3271
3040  01f2 725f0003      	clr	_adr+1
3042  01f6 204c          	jra	L5271
3043  01f8               L3271:
3044                     ; 440 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
3046  01f8 9c            	rvf
3047  01f9 ce0007        	ldw	x,_adc_buff_+2
3048  01fc a3036d        	cpw	x,#877
3049  01ff 2f0f          	jrslt	L7271
3051  0201 9c            	rvf
3052  0202 ce0007        	ldw	x,_adc_buff_+2
3053  0205 a30396        	cpw	x,#918
3054  0208 2e06          	jrsge	L7271
3057  020a 35010003      	mov	_adr+1,#1
3059  020e 2034          	jra	L5271
3060  0210               L7271:
3061                     ; 441 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
3063  0210 9c            	rvf
3064  0211 ce0007        	ldw	x,_adc_buff_+2
3065  0214 a302a3        	cpw	x,#675
3066  0217 2f0f          	jrslt	L3371
3068  0219 9c            	rvf
3069  021a ce0007        	ldw	x,_adc_buff_+2
3070  021d a302cc        	cpw	x,#716
3071  0220 2e06          	jrsge	L3371
3074  0222 35020003      	mov	_adr+1,#2
3076  0226 201c          	jra	L5271
3077  0228               L3371:
3078                     ; 442 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
3080  0228 9c            	rvf
3081  0229 ce0007        	ldw	x,_adc_buff_+2
3082  022c a303e3        	cpw	x,#995
3083  022f 2f0f          	jrslt	L7371
3085  0231 9c            	rvf
3086  0232 ce0007        	ldw	x,_adc_buff_+2
3087  0235 a3040c        	cpw	x,#1036
3088  0238 2e06          	jrsge	L7371
3091  023a 35030003      	mov	_adr+1,#3
3093  023e 2004          	jra	L5271
3094  0240               L7371:
3095                     ; 443 else adr[1]=5;
3097  0240 35050003      	mov	_adr+1,#5
3098  0244               L5271:
3099                     ; 445 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
3101  0244 9c            	rvf
3102  0245 ce0017        	ldw	x,_adc_buff_+18
3103  0248 a3022a        	cpw	x,#554
3104  024b 2f0f          	jrslt	L3471
3106  024d 9c            	rvf
3107  024e ce0017        	ldw	x,_adc_buff_+18
3108  0251 a30253        	cpw	x,#595
3109  0254 2e06          	jrsge	L3471
3112  0256 725f0004      	clr	_adr+2
3114  025a 204c          	jra	L5471
3115  025c               L3471:
3116                     ; 446 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
3118  025c 9c            	rvf
3119  025d ce0017        	ldw	x,_adc_buff_+18
3120  0260 a3036d        	cpw	x,#877
3121  0263 2f0f          	jrslt	L7471
3123  0265 9c            	rvf
3124  0266 ce0017        	ldw	x,_adc_buff_+18
3125  0269 a30396        	cpw	x,#918
3126  026c 2e06          	jrsge	L7471
3129  026e 35010004      	mov	_adr+2,#1
3131  0272 2034          	jra	L5471
3132  0274               L7471:
3133                     ; 447 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
3135  0274 9c            	rvf
3136  0275 ce0017        	ldw	x,_adc_buff_+18
3137  0278 a302a3        	cpw	x,#675
3138  027b 2f0f          	jrslt	L3571
3140  027d 9c            	rvf
3141  027e ce0017        	ldw	x,_adc_buff_+18
3142  0281 a302cc        	cpw	x,#716
3143  0284 2e06          	jrsge	L3571
3146  0286 35020004      	mov	_adr+2,#2
3148  028a 201c          	jra	L5471
3149  028c               L3571:
3150                     ; 448 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
3152  028c 9c            	rvf
3153  028d ce0017        	ldw	x,_adc_buff_+18
3154  0290 a303e3        	cpw	x,#995
3155  0293 2f0f          	jrslt	L7571
3157  0295 9c            	rvf
3158  0296 ce0017        	ldw	x,_adc_buff_+18
3159  0299 a3040c        	cpw	x,#1036
3160  029c 2e06          	jrsge	L7571
3163  029e 35030004      	mov	_adr+2,#3
3165  02a2 2004          	jra	L5471
3166  02a4               L7571:
3167                     ; 449 else adr[2]=5;
3169  02a4 35050004      	mov	_adr+2,#5
3170  02a8               L5471:
3171                     ; 453 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
3173  02a8 c60002        	ld	a,_adr
3174  02ab a105          	cp	a,#5
3175  02ad 270e          	jreq	L5671
3177  02af c60003        	ld	a,_adr+1
3178  02b2 a105          	cp	a,#5
3179  02b4 2707          	jreq	L5671
3181  02b6 c60004        	ld	a,_adr+2
3182  02b9 a105          	cp	a,#5
3183  02bb 2606          	jrne	L3671
3184  02bd               L5671:
3185                     ; 456 	adress_error=1;
3187  02bd 35010000      	mov	_adress_error,#1
3189  02c1               L1771:
3190                     ; 467 }
3193  02c1 84            	pop	a
3194  02c2 81            	ret
3195  02c3               L3671:
3196                     ; 460 	if(adr[2]&0x02) bps_class=bpsIPS;
3198  02c3 c60004        	ld	a,_adr+2
3199  02c6 a502          	bcp	a,#2
3200  02c8 2706          	jreq	L3771
3203  02ca 35010000      	mov	_bps_class,#1
3205  02ce 2002          	jra	L5771
3206  02d0               L3771:
3207                     ; 461 	else bps_class=bpsIBEP;
3209  02d0 3f00          	clr	_bps_class
3210  02d2               L5771:
3211                     ; 463 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
3213  02d2 c60004        	ld	a,_adr+2
3214  02d5 a401          	and	a,#1
3215  02d7 97            	ld	xl,a
3216  02d8 a610          	ld	a,#16
3217  02da 42            	mul	x,a
3218  02db 9f            	ld	a,xl
3219  02dc 6b01          	ld	(OFST+0,sp),a
3220  02de c60003        	ld	a,_adr+1
3221  02e1 48            	sll	a
3222  02e2 48            	sll	a
3223  02e3 cb0002        	add	a,_adr
3224  02e6 1b01          	add	a,(OFST+0,sp)
3225  02e8 c70001        	ld	_adress,a
3226  02eb 20d4          	jra	L1771
3250                     ; 473 void exti_init(void){
3251                     	switch	.text
3252  02ed               _exti_init:
3256                     ; 474 EXTI_CR1=0x00;	
3258  02ed 725f50a0      	clr	_EXTI_CR1
3259                     ; 475 GPIOD->DDR&=~(1<<4);
3261  02f1 72195011      	bres	20497,#4
3262                     ; 476 GPIOD->CR1&=~(1<<4);
3264  02f5 72195012      	bres	20498,#4
3265                     ; 477 GPIOD->CR2|=(1<<4);	
3267  02f9 72185013      	bset	20499,#4
3268                     ; 481 }
3271  02fd 81            	ret
3294                     ; 484 void t1_init(void)
3294                     ; 485 {
3295                     	switch	.text
3296  02fe               _t1_init:
3300                     ; 486 TIM1->ARRH= 0xa9;
3302  02fe 35a95262      	mov	21090,#169
3303                     ; 487 TIM1->ARRL= 0xf6;
3305  0302 35f65263      	mov	21091,#246
3306                     ; 488 TIM1->CCR1H= 0x00;	
3308  0306 725f5265      	clr	21093
3309                     ; 489 TIM1->CCR1L= 0xff;
3311  030a 35ff5266      	mov	21094,#255
3312                     ; 490 TIM1->CCR2H= 0x04;	
3314  030e 35045267      	mov	21095,#4
3315                     ; 491 TIM1->CCR2L= 0xfb;
3317  0312 35fb5268      	mov	21096,#251
3318                     ; 492 TIM1->CCR3H= 0x00;	
3320  0316 725f5269      	clr	21097
3321                     ; 493 TIM1->CCR3L= 0x64;
3323  031a 3564526a      	mov	21098,#100
3324                     ; 495 TIM1->PSCRH= 0x00;	
3326  031e 725f5260      	clr	21088
3327                     ; 496 TIM1->PSCRL= 0x01;
3329  0322 35015261      	mov	21089,#1
3330                     ; 498 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
3332  0326 35685258      	mov	21080,#104
3333                     ; 499 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
3335  032a 35685259      	mov	21081,#104
3336                     ; 500 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
3338  032e 3568525a      	mov	21082,#104
3339                     ; 501 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
3341  0332 3511525c      	mov	21084,#17
3342                     ; 502 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
3344  0336 3501525d      	mov	21085,#1
3345                     ; 503 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
3347  033a 35815250      	mov	21072,#129
3348                     ; 504 TIM1->BKR|= TIM1_BKR_AOE;
3350  033e 721c526d      	bset	21101,#6
3351                     ; 505 }
3354  0342 81            	ret
3377                     ; 509 void t2_init(void)
3377                     ; 510 {
3378                     	switch	.text
3379  0343               _t2_init:
3383                     ; 521 TIM2->PSCR= 0x01;
3385  0343 3501530c      	mov	21260,#1
3386                     ; 528 TIM2->CR1=(TIM2_CR1_CEN | TIM2_CR1_ARPE);
3388  0347 35815300      	mov	21248,#129
3389                     ; 530 }
3392  034b 81            	ret
3416                     ; 533 void adc2_init(void)
3416                     ; 534 {
3417                     	switch	.text
3418  034c               _adc2_init:
3422                     ; 535 adc_plazma[0]++;
3424  034c be6d          	ldw	x,_adc_plazma
3425  034e 1c0001        	addw	x,#1
3426  0351 bf6d          	ldw	_adc_plazma,x
3427                     ; 538 GPIOB->DDR&=~(1<<0);
3429  0353 72115007      	bres	20487,#0
3430                     ; 539 GPIOB->CR1&=~(1<<0);
3432  0357 72115008      	bres	20488,#0
3433                     ; 540 GPIOB->CR2&=~(1<<0);
3435  035b 72115009      	bres	20489,#0
3436                     ; 542 GPIOB->DDR&=~(1<<1);
3438  035f 72135007      	bres	20487,#1
3439                     ; 543 GPIOB->CR1&=~(1<<1);
3441  0363 72135008      	bres	20488,#1
3442                     ; 544 GPIOB->CR2&=~(1<<1);
3444  0367 72135009      	bres	20489,#1
3445                     ; 546 GPIOE->DDR&=~(1<<6);
3447  036b 721d5016      	bres	20502,#6
3448                     ; 547 GPIOE->CR1&=~(1<<6);
3450  036f 721d5017      	bres	20503,#6
3451                     ; 548 GPIOE->CR2&=~(1<<6);
3453  0373 721d5018      	bres	20504,#6
3454                     ; 550 GPIOB->DDR&=~(1<<4);
3456  0377 72195007      	bres	20487,#4
3457                     ; 551 GPIOB->CR1&=~(1<<4);
3459  037b 72195008      	bres	20488,#4
3460                     ; 552 GPIOB->CR2&=~(1<<4);
3462  037f 72195009      	bres	20489,#4
3463                     ; 554 GPIOB->DDR&=~(1<<5);
3465  0383 721b5007      	bres	20487,#5
3466                     ; 555 GPIOB->CR1&=~(1<<5);
3468  0387 721b5008      	bres	20488,#5
3469                     ; 556 GPIOB->CR2&=~(1<<5);
3471  038b 721b5009      	bres	20489,#5
3472                     ; 558 GPIOB->DDR&=~(1<<6);
3474  038f 721d5007      	bres	20487,#6
3475                     ; 559 GPIOB->CR1&=~(1<<6);
3477  0393 721d5008      	bres	20488,#6
3478                     ; 560 GPIOB->CR2&=~(1<<6);
3480  0397 721d5009      	bres	20489,#6
3481                     ; 562 GPIOB->DDR&=~(1<<7);
3483  039b 721f5007      	bres	20487,#7
3484                     ; 563 GPIOB->CR1&=~(1<<7);
3486  039f 721f5008      	bres	20488,#7
3487                     ; 564 GPIOB->CR2&=~(1<<7);
3489  03a3 721f5009      	bres	20489,#7
3490                     ; 566 ADC2->TDRL=0xff;
3492  03a7 35ff5407      	mov	21511,#255
3493                     ; 568 ADC2->CR2=0x08;
3495  03ab 35085402      	mov	21506,#8
3496                     ; 569 ADC2->CR1=0x40;
3498  03af 35405401      	mov	21505,#64
3499                     ; 572 	ADC2->CSR=0x20;
3501  03b3 35205400      	mov	21504,#32
3502                     ; 574 	ADC2->CR1|=1;
3504  03b7 72105401      	bset	21505,#0
3505                     ; 575 	ADC2->CR1|=1;
3507  03bb 72105401      	bset	21505,#0
3508                     ; 577 }
3511  03bf 81            	ret
3545                     ; 586 @far @interrupt void TIM4_UPD_Interrupt (void) 
3545                     ; 587 {
3547                     	switch	.text
3548  03c0               f_TIM4_UPD_Interrupt:
3552                     ; 588 TIM4->SR1&=~TIM4_SR1_UIF;
3554  03c0 72115342      	bres	21314,#0
3555                     ; 590 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
3557  03c4 3c04          	inc	_pwm_vent_cnt
3558  03c6 b604          	ld	a,_pwm_vent_cnt
3559  03c8 a10a          	cp	a,#10
3560  03ca 2502          	jrult	L7402
3563  03cc 3f04          	clr	_pwm_vent_cnt
3564  03ce               L7402:
3565                     ; 591 GPIOB->ODR|=(1<<3);
3567  03ce 72165005      	bset	20485,#3
3568                     ; 592 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
3570  03d2 b604          	ld	a,_pwm_vent_cnt
3571  03d4 a105          	cp	a,#5
3572  03d6 2504          	jrult	L1502
3575  03d8 72175005      	bres	20485,#3
3576  03dc               L1502:
3577                     ; 597 if(++t0_cnt0>=100)
3579  03dc 9c            	rvf
3580  03dd be01          	ldw	x,_t0_cnt0
3581  03df 1c0001        	addw	x,#1
3582  03e2 bf01          	ldw	_t0_cnt0,x
3583  03e4 a30064        	cpw	x,#100
3584  03e7 2f3f          	jrslt	L3502
3585                     ; 599 	t0_cnt0=0;
3587  03e9 5f            	clrw	x
3588  03ea bf01          	ldw	_t0_cnt0,x
3589                     ; 600 	b100Hz=1;
3591  03ec 72100008      	bset	_b100Hz
3592                     ; 602 	if(++t0_cnt1>=10)
3594  03f0 3c03          	inc	_t0_cnt1
3595  03f2 b603          	ld	a,_t0_cnt1
3596  03f4 a10a          	cp	a,#10
3597  03f6 2506          	jrult	L5502
3598                     ; 604 		t0_cnt1=0;
3600  03f8 3f03          	clr	_t0_cnt1
3601                     ; 605 		b10Hz=1;
3603  03fa 72100007      	bset	_b10Hz
3604  03fe               L5502:
3605                     ; 608 	if(++t0_cnt2>=20)
3607  03fe 3c04          	inc	_t0_cnt2
3608  0400 b604          	ld	a,_t0_cnt2
3609  0402 a114          	cp	a,#20
3610  0404 2506          	jrult	L7502
3611                     ; 610 		t0_cnt2=0;
3613  0406 3f04          	clr	_t0_cnt2
3614                     ; 611 		b5Hz=1;
3616  0408 72100006      	bset	_b5Hz
3617  040c               L7502:
3618                     ; 615 	if(++t0_cnt4>=50)
3620  040c 3c06          	inc	_t0_cnt4
3621  040e b606          	ld	a,_t0_cnt4
3622  0410 a132          	cp	a,#50
3623  0412 2506          	jrult	L1602
3624                     ; 617 		t0_cnt4=0;
3626  0414 3f06          	clr	_t0_cnt4
3627                     ; 618 		b2Hz=1;
3629  0416 72100005      	bset	_b2Hz
3630  041a               L1602:
3631                     ; 621 	if(++t0_cnt3>=100)
3633  041a 3c05          	inc	_t0_cnt3
3634  041c b605          	ld	a,_t0_cnt3
3635  041e a164          	cp	a,#100
3636  0420 2506          	jrult	L3502
3637                     ; 623 		t0_cnt3=0;
3639  0422 3f05          	clr	_t0_cnt3
3640                     ; 624 		b1Hz=1;
3642  0424 72100004      	bset	_b1Hz
3643  0428               L3502:
3644                     ; 630 }
3647  0428 80            	iret
3702                     .const:	section	.text
3703  0000               L44:
3704  0000 0000000a      	dc.l	10
3705                     ; 634 @far @interrupt void ADC2_EOC_Interrupt (void) {
3706                     	switch	.text
3707  0429               f_ADC2_EOC_Interrupt:
3709       00000009      OFST:	set	9
3710  0429 be00          	ldw	x,c_x
3711  042b 89            	pushw	x
3712  042c be00          	ldw	x,c_y
3713  042e 89            	pushw	x
3714  042f be02          	ldw	x,c_lreg+2
3715  0431 89            	pushw	x
3716  0432 be00          	ldw	x,c_lreg
3717  0434 89            	pushw	x
3718  0435 5209          	subw	sp,#9
3721                     ; 639 ADC2->CSR&=~(1<<7);
3723  0437 721f5400      	bres	21504,#7
3724                     ; 641 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
3726  043b c65405        	ld	a,21509
3727  043e b703          	ld	c_lreg+3,a
3728  0440 3f02          	clr	c_lreg+2
3729  0442 3f01          	clr	c_lreg+1
3730  0444 3f00          	clr	c_lreg
3731  0446 96            	ldw	x,sp
3732  0447 1c0001        	addw	x,#OFST-8
3733  044a cd0000        	call	c_rtol
3735  044d c65404        	ld	a,21508
3736  0450 5f            	clrw	x
3737  0451 97            	ld	xl,a
3738  0452 90ae0100      	ldw	y,#256
3739  0456 cd0000        	call	c_umul
3741  0459 96            	ldw	x,sp
3742  045a 1c0001        	addw	x,#OFST-8
3743  045d cd0000        	call	c_ladd
3745  0460 96            	ldw	x,sp
3746  0461 1c0006        	addw	x,#OFST-3
3747  0464 cd0000        	call	c_rtol
3749                     ; 643 adc_buff[adc_ch][adc_cnt]=temp_adc;
3751  0467 b679          	ld	a,_adc_cnt
3752  0469 5f            	clrw	x
3753  046a 97            	ld	xl,a
3754  046b 58            	sllw	x
3755  046c 1f03          	ldw	(OFST-6,sp),x
3756  046e b67a          	ld	a,_adc_ch
3757  0470 97            	ld	xl,a
3758  0471 a620          	ld	a,#32
3759  0473 42            	mul	x,a
3760  0474 72fb03        	addw	x,(OFST-6,sp)
3761  0477 1608          	ldw	y,(OFST-1,sp)
3762  0479 df0019        	ldw	(_adc_buff,x),y
3763                     ; 645 adc_ch=0;
3765  047c 3f7a          	clr	_adc_ch
3766                     ; 646 adc_cnt++;
3768  047e 3c79          	inc	_adc_cnt
3769                     ; 647 if(adc_cnt>=16)
3771  0480 b679          	ld	a,_adc_cnt
3772  0482 a110          	cp	a,#16
3773  0484 2502          	jrult	L3112
3774                     ; 649 	adc_cnt=0;
3776  0486 3f79          	clr	_adc_cnt
3777  0488               L3112:
3778                     ; 652 if((adc_cnt&0x03)==0)
3780  0488 b679          	ld	a,_adc_cnt
3781  048a a503          	bcp	a,#3
3782  048c 2638          	jrne	L5112
3783                     ; 656 	tempSS=0;
3785  048e ae0000        	ldw	x,#0
3786  0491 1f08          	ldw	(OFST-1,sp),x
3787  0493 ae0000        	ldw	x,#0
3788  0496 1f06          	ldw	(OFST-3,sp),x
3789                     ; 657 	for(i=0;i<16;i++)
3791  0498 0f05          	clr	(OFST-4,sp)
3792  049a               L7112:
3793                     ; 659 		tempSS+=(signed long)adc_buff[0][i];
3795  049a 7b05          	ld	a,(OFST-4,sp)
3796  049c 5f            	clrw	x
3797  049d 97            	ld	xl,a
3798  049e 58            	sllw	x
3799  049f de0019        	ldw	x,(_adc_buff,x)
3800  04a2 cd0000        	call	c_itolx
3802  04a5 96            	ldw	x,sp
3803  04a6 1c0006        	addw	x,#OFST-3
3804  04a9 cd0000        	call	c_lgadd
3806                     ; 657 	for(i=0;i<16;i++)
3808  04ac 0c05          	inc	(OFST-4,sp)
3811  04ae 7b05          	ld	a,(OFST-4,sp)
3812  04b0 a110          	cp	a,#16
3813  04b2 25e6          	jrult	L7112
3814                     ; 661 	adc_buff_[0]=(signed short)(tempSS/10);
3816  04b4 96            	ldw	x,sp
3817  04b5 1c0006        	addw	x,#OFST-3
3818  04b8 cd0000        	call	c_ltor
3820  04bb ae0000        	ldw	x,#L44
3821  04be cd0000        	call	c_ldiv
3823  04c1 be02          	ldw	x,c_lreg+2
3824  04c3 cf0005        	ldw	_adc_buff_,x
3825  04c6               L5112:
3826                     ; 665 }
3829  04c6 5b09          	addw	sp,#9
3830  04c8 85            	popw	x
3831  04c9 bf00          	ldw	c_lreg,x
3832  04cb 85            	popw	x
3833  04cc bf02          	ldw	c_lreg+2,x
3834  04ce 85            	popw	x
3835  04cf bf00          	ldw	c_y,x
3836  04d1 85            	popw	x
3837  04d2 bf00          	ldw	c_x,x
3838  04d4 80            	iret
3861                     ; 668 @far @interrupt void PortD_Ext_Interrupt (void) {
3862                     	switch	.text
3863  04d5               f_PortD_Ext_Interrupt:
3867                     ; 670 GPIOC->ODR^=(1<<2);
3869  04d5 c6500a        	ld	a,20490
3870  04d8 a804          	xor	a,	#4
3871  04da c7500a        	ld	20490,a
3872                     ; 672 }
3875  04dd 80            	iret
3909                     ; 679 main()
3909                     ; 680 {
3911                     	switch	.text
3912  04de               _main:
3916                     ; 682 CLK->ECKR|=1;
3918  04de 721050c1      	bset	20673,#0
3920  04e2               L7412:
3921                     ; 683 while((CLK->ECKR & 2) == 0);
3923  04e2 c650c1        	ld	a,20673
3924  04e5 a502          	bcp	a,#2
3925  04e7 27f9          	jreq	L7412
3926                     ; 684 CLK->SWCR|=2;
3928  04e9 721250c5      	bset	20677,#1
3929                     ; 685 CLK->SWR=0xB4;
3931  04ed 35b450c4      	mov	20676,#180
3932                     ; 687 delay_ms(200);
3934  04f1 ae00c8        	ldw	x,#200
3935  04f4 cd004c        	call	_delay_ms
3937                     ; 688 FLASH_DUKR=0xae;
3939  04f7 35ae5064      	mov	_FLASH_DUKR,#174
3940                     ; 689 FLASH_DUKR=0x56;
3942  04fb 35565064      	mov	_FLASH_DUKR,#86
3943                     ; 690 enableInterrupts();
3946  04ff 9a            rim
3948                     ; 697 t4_init();
3951  0500 cd008e        	call	_t4_init
3953                     ; 699 		GPIOG->DDR|=(1<<0);
3955  0503 72105020      	bset	20512,#0
3956                     ; 700 		GPIOG->CR1|=(1<<0);
3958  0507 72105021      	bset	20513,#0
3959                     ; 701 		GPIOG->CR2&=~(1<<0);	
3961  050b 72115022      	bres	20514,#0
3962                     ; 704 		GPIOG->DDR&=~(1<<1);
3964  050f 72135020      	bres	20512,#1
3965                     ; 705 		GPIOG->CR1|=(1<<1);
3967  0513 72125021      	bset	20513,#1
3968                     ; 706 		GPIOG->CR2&=~(1<<1);
3970  0517 72135022      	bres	20514,#1
3971                     ; 712 GPIOC->DDR|=(1<<1);
3973  051b 7212500c      	bset	20492,#1
3974                     ; 713 GPIOC->CR1|=(1<<1);
3976  051f 7212500d      	bset	20493,#1
3977                     ; 714 GPIOC->CR2|=(1<<1);
3979  0523 7212500e      	bset	20494,#1
3980                     ; 716 GPIOC->DDR|=(1<<2);
3982  0527 7214500c      	bset	20492,#2
3983                     ; 717 GPIOC->CR1|=(1<<2);
3985  052b 7214500d      	bset	20493,#2
3986                     ; 718 GPIOC->CR2|=(1<<2);
3988  052f 7214500e      	bset	20494,#2
3989                     ; 726 t2_init();
3991  0533 cd0343        	call	_t2_init
3993                     ; 727 GPIOA->DDR|=(1<<5);
3995  0536 721a5002      	bset	20482,#5
3996                     ; 728 GPIOA->CR1|=(1<<5);
3998  053a 721a5003      	bset	20483,#5
3999                     ; 729 GPIOA->CR2&=~(1<<5);
4001  053e 721b5004      	bres	20484,#5
4002                     ; 735 GPIOB->DDR&=~(1<<3);
4004  0542 72175007      	bres	20487,#3
4005                     ; 736 GPIOB->CR1&=~(1<<3);
4007  0546 72175008      	bres	20488,#3
4008                     ; 737 GPIOB->CR2&=~(1<<3);
4010  054a 72175009      	bres	20489,#3
4011                     ; 739 GPIOC->DDR|=(1<<3);
4013  054e 7216500c      	bset	20492,#3
4014                     ; 740 GPIOC->CR1|=(1<<3);
4016  0552 7216500d      	bset	20493,#3
4017                     ; 741 GPIOC->CR2|=(1<<3);
4019  0556 7216500e      	bset	20494,#3
4020                     ; 744 exti_init();
4022  055a cd02ed        	call	_exti_init
4024  055d               L3512:
4025                     ; 751 if(b100Hz)
4027                     	btst	_b100Hz
4028  0562 2404          	jruge	L7512
4029                     ; 753 		b100Hz=0;
4031  0564 72110008      	bres	_b100Hz
4032  0568               L7512:
4033                     ; 758 	if(b10Hz)
4035                     	btst	_b10Hz
4036  056d 2404          	jruge	L1612
4037                     ; 760 		b10Hz=0;
4039  056f 72110007      	bres	_b10Hz
4040  0573               L1612:
4041                     ; 768 	if(b5Hz)
4043                     	btst	_b5Hz
4044  0578 2404          	jruge	L3612
4045                     ; 770 		b5Hz=0;
4047  057a 72110006      	bres	_b5Hz
4048  057e               L3612:
4049                     ; 775 	if(b2Hz)
4051                     	btst	_b2Hz
4052  0583 2404          	jruge	L5612
4053                     ; 777 		b2Hz=0;
4055  0585 72110005      	bres	_b2Hz
4056  0589               L5612:
4057                     ; 781 	if(b1Hz)
4059                     	btst	_b1Hz
4060  058e 24cd          	jruge	L3512
4061                     ; 783 		b1Hz=0;
4063  0590 72110004      	bres	_b1Hz
4064                     ; 785 		if(main_cnt<1000)main_cnt++;
4066  0594 9c            	rvf
4067  0595 be4d          	ldw	x,_main_cnt
4068  0597 a303e8        	cpw	x,#1000
4069  059a 2ec1          	jrsge	L3512
4072  059c be4d          	ldw	x,_main_cnt
4073  059e 1c0001        	addw	x,#1
4074  05a1 bf4d          	ldw	_main_cnt,x
4075  05a3 20b8          	jra	L3512
5033                     	xdef	_main
5034                     	xdef	f_PortD_Ext_Interrupt
5035                     	xdef	f_ADC2_EOC_Interrupt
5036                     	xdef	f_TIM4_UPD_Interrupt
5037                     	xdef	_adc2_init
5038                     	xdef	_t2_init
5039                     	xdef	_t1_init
5040                     	xdef	_exti_init
5041                     	xdef	_adr_drv_v3
5042                     	xdef	_adr_drv_v4
5043                     	xdef	_matemat
5044                     	xdef	_pwr_hndl
5045                     	xdef	_pwr_drv
5046                     	xdef	_led_drv
5047                     	xdef	_t4_init
5048                     	xdef	_delay_ms
5049                     	xdef	_granee
5050                     	xdef	_gran
5051                     .eeprom:	section	.data
5052  0000               _ee_IMAXVENT:
5053  0000 0000          	ds.b	2
5054                     	xdef	_ee_IMAXVENT
5055                     	switch	.ubsct
5056  0000               _bps_class:
5057  0000 00            	ds.b	1
5058                     	xdef	_bps_class
5059  0001               _vent_pwm:
5060  0001 0000          	ds.b	2
5061                     	xdef	_vent_pwm
5062  0003               _pwm_stat:
5063  0003 00            	ds.b	1
5064                     	xdef	_pwm_stat
5065  0004               _pwm_vent_cnt:
5066  0004 00            	ds.b	1
5067                     	xdef	_pwm_vent_cnt
5068                     	switch	.eeprom
5069  0002               _ee_DEVICE:
5070  0002 0000          	ds.b	2
5071                     	xdef	_ee_DEVICE
5072  0004               _ee_AVT_MODE:
5073  0004 0000          	ds.b	2
5074                     	xdef	_ee_AVT_MODE
5075                     	switch	.ubsct
5076  0005               _i_main_bps_cnt:
5077  0005 000000000000  	ds.b	6
5078                     	xdef	_i_main_bps_cnt
5079  000b               _i_main_sigma:
5080  000b 0000          	ds.b	2
5081                     	xdef	_i_main_sigma
5082  000d               _i_main_num_of_bps:
5083  000d 00            	ds.b	1
5084                     	xdef	_i_main_num_of_bps
5085  000e               _i_main_avg:
5086  000e 0000          	ds.b	2
5087                     	xdef	_i_main_avg
5088  0010               _i_main_flag:
5089  0010 000000000000  	ds.b	6
5090                     	xdef	_i_main_flag
5091  0016               _i_main:
5092  0016 000000000000  	ds.b	12
5093                     	xdef	_i_main
5094  0022               _x:
5095  0022 000000000000  	ds.b	12
5096                     	xdef	_x
5097                     	xdef	_volum_u_main_
5098                     	switch	.eeprom
5099  0006               _UU_AVT:
5100  0006 0000          	ds.b	2
5101                     	xdef	_UU_AVT
5102                     	switch	.ubsct
5103  002e               _cnt_net_drv:
5104  002e 00            	ds.b	1
5105                     	xdef	_cnt_net_drv
5106                     	switch	.bit
5107  0001               _bMAIN:
5108  0001 00            	ds.b	1
5109                     	xdef	_bMAIN
5110                     	switch	.ubsct
5111  002f               _plazma_int:
5112  002f 000000000000  	ds.b	6
5113                     	xdef	_plazma_int
5114                     	xdef	_rotor_int
5115  0035               _led_green_buff:
5116  0035 00000000      	ds.b	4
5117                     	xdef	_led_green_buff
5118  0039               _led_red_buff:
5119  0039 00000000      	ds.b	4
5120                     	xdef	_led_red_buff
5121                     	xdef	_led_drv_cnt
5122                     	xdef	_led_green
5123                     	xdef	_led_red
5124  003d               _res_fl_cnt:
5125  003d 00            	ds.b	1
5126                     	xdef	_res_fl_cnt
5127                     	xdef	_bRES_
5128                     	xdef	_bRES
5129                     	switch	.eeprom
5130  0008               _res_fl_:
5131  0008 00            	ds.b	1
5132                     	xdef	_res_fl_
5133  0009               _res_fl:
5134  0009 00            	ds.b	1
5135                     	xdef	_res_fl
5136                     	switch	.ubsct
5137  003e               _cnt_apv_off:
5138  003e 00            	ds.b	1
5139                     	xdef	_cnt_apv_off
5140                     	switch	.bit
5141  0002               _bAPV:
5142  0002 00            	ds.b	1
5143                     	xdef	_bAPV
5144                     	switch	.ubsct
5145  003f               _apv_cnt_:
5146  003f 0000          	ds.b	2
5147                     	xdef	_apv_cnt_
5148  0041               _apv_cnt:
5149  0041 000000        	ds.b	3
5150                     	xdef	_apv_cnt
5151                     	xdef	_bBL_IPS
5152                     	switch	.bit
5153  0003               _bBL:
5154  0003 00            	ds.b	1
5155                     	xdef	_bBL
5156                     	switch	.ubsct
5157  0044               _cnt_JP1:
5158  0044 00            	ds.b	1
5159                     	xdef	_cnt_JP1
5160  0045               _cnt_JP0:
5161  0045 00            	ds.b	1
5162                     	xdef	_cnt_JP0
5163  0046               _jp_mode:
5164  0046 00            	ds.b	1
5165                     	xdef	_jp_mode
5166                     	xdef	_pwm_i
5167                     	xdef	_pwm_u
5168  0047               _tmax_cnt:
5169  0047 0000          	ds.b	2
5170                     	xdef	_tmax_cnt
5171  0049               _tsign_cnt:
5172  0049 0000          	ds.b	2
5173                     	xdef	_tsign_cnt
5174                     	switch	.eeprom
5175  000a               _ee_U_AVT:
5176  000a 0000          	ds.b	2
5177                     	xdef	_ee_U_AVT
5178  000c               _ee_tsign:
5179  000c 0000          	ds.b	2
5180                     	xdef	_ee_tsign
5181  000e               _ee_tmax:
5182  000e 0000          	ds.b	2
5183                     	xdef	_ee_tmax
5184  0010               _ee_dU:
5185  0010 0000          	ds.b	2
5186                     	xdef	_ee_dU
5187  0012               _ee_Umax:
5188  0012 0000          	ds.b	2
5189                     	xdef	_ee_Umax
5190  0014               _ee_TZAS:
5191  0014 0000          	ds.b	2
5192                     	xdef	_ee_TZAS
5193                     	switch	.ubsct
5194  004b               _main_cnt1:
5195  004b 0000          	ds.b	2
5196                     	xdef	_main_cnt1
5197  004d               _main_cnt:
5198  004d 0000          	ds.b	2
5199                     	xdef	_main_cnt
5200  004f               _off_bp_cnt:
5201  004f 00            	ds.b	1
5202                     	xdef	_off_bp_cnt
5203  0050               _flags_tu_cnt_off:
5204  0050 00            	ds.b	1
5205                     	xdef	_flags_tu_cnt_off
5206  0051               _flags_tu_cnt_on:
5207  0051 00            	ds.b	1
5208                     	xdef	_flags_tu_cnt_on
5209  0052               _vol_i_temp:
5210  0052 0000          	ds.b	2
5211                     	xdef	_vol_i_temp
5212  0054               _vol_u_temp:
5213  0054 0000          	ds.b	2
5214                     	xdef	_vol_u_temp
5215                     	switch	.eeprom
5216  0016               __x_ee_:
5217  0016 0000          	ds.b	2
5218                     	xdef	__x_ee_
5219                     	switch	.ubsct
5220  0056               __x_cnt:
5221  0056 0000          	ds.b	2
5222                     	xdef	__x_cnt
5223  0058               __x__:
5224  0058 0000          	ds.b	2
5225                     	xdef	__x__
5226  005a               __x_:
5227  005a 0000          	ds.b	2
5228                     	xdef	__x_
5229  005c               _flags_tu:
5230  005c 00            	ds.b	1
5231                     	xdef	_flags_tu
5232                     	xdef	_flags
5233  005d               _link_cnt:
5234  005d 00            	ds.b	1
5235                     	xdef	_link_cnt
5236  005e               _link:
5237  005e 00            	ds.b	1
5238                     	xdef	_link
5239  005f               _umin_cnt:
5240  005f 0000          	ds.b	2
5241                     	xdef	_umin_cnt
5242  0061               _umax_cnt:
5243  0061 0000          	ds.b	2
5244                     	xdef	_umax_cnt
5245                     	switch	.eeprom
5246  0018               _ee_K:
5247  0018 000000000000  	ds.b	16
5248                     	xdef	_ee_K
5249                     	switch	.ubsct
5250  0063               _T:
5251  0063 00            	ds.b	1
5252                     	xdef	_T
5253  0064               _Udb:
5254  0064 0000          	ds.b	2
5255                     	xdef	_Udb
5256  0066               _Ui:
5257  0066 0000          	ds.b	2
5258                     	xdef	_Ui
5259  0068               _Un:
5260  0068 0000          	ds.b	2
5261                     	xdef	_Un
5262  006a               _I:
5263  006a 0000          	ds.b	2
5264                     	xdef	_I
5265                     	switch	.bss
5266  0000               _adress_error:
5267  0000 00            	ds.b	1
5268                     	xdef	_adress_error
5269  0001               _adress:
5270  0001 00            	ds.b	1
5271                     	xdef	_adress
5272  0002               _adr:
5273  0002 000000        	ds.b	3
5274                     	xdef	_adr
5275                     	xdef	_adr_drv_stat
5276                     	xdef	_led_ind
5277                     	switch	.ubsct
5278  006c               _led_ind_cnt:
5279  006c 00            	ds.b	1
5280                     	xdef	_led_ind_cnt
5281  006d               _adc_plazma:
5282  006d 000000000000  	ds.b	10
5283                     	xdef	_adc_plazma
5284  0077               _adc_plazma_short:
5285  0077 0000          	ds.b	2
5286                     	xdef	_adc_plazma_short
5287  0079               _adc_cnt:
5288  0079 00            	ds.b	1
5289                     	xdef	_adc_cnt
5290  007a               _adc_ch:
5291  007a 00            	ds.b	1
5292                     	xdef	_adc_ch
5293                     	switch	.bss
5294  0005               _adc_buff_:
5295  0005 000000000000  	ds.b	20
5296                     	xdef	_adc_buff_
5297  0019               _adc_buff:
5298  0019 000000000000  	ds.b	320
5299                     	xdef	_adc_buff
5300                     	switch	.ubsct
5301  007b               _mess:
5302  007b 000000000000  	ds.b	14
5303                     	xdef	_mess
5304                     	switch	.bit
5305  0004               _b1Hz:
5306  0004 00            	ds.b	1
5307                     	xdef	_b1Hz
5308  0005               _b2Hz:
5309  0005 00            	ds.b	1
5310                     	xdef	_b2Hz
5311  0006               _b5Hz:
5312  0006 00            	ds.b	1
5313                     	xdef	_b5Hz
5314  0007               _b10Hz:
5315  0007 00            	ds.b	1
5316                     	xdef	_b10Hz
5317  0008               _b100Hz:
5318  0008 00            	ds.b	1
5319                     	xdef	_b100Hz
5320                     	xdef	_t0_cnt4
5321                     	xdef	_t0_cnt3
5322                     	xdef	_t0_cnt2
5323                     	xdef	_t0_cnt1
5324                     	xdef	_t0_cnt0
5325                     	xdef	_bVENT_BLOCK
5326                     	xref.b	c_lreg
5327                     	xref.b	c_x
5328                     	xref.b	c_y
5348                     	xref	c_ldiv
5349                     	xref	c_lgadd
5350                     	xref	c_itolx
5351                     	xref	c_ladd
5352                     	xref	c_umul
5353                     	xref	c_idiv
5354                     	xref	c_lcmp
5355                     	xref	c_ltor
5356                     	xref	c_lgadc
5357                     	xref	c_rtol
5358                     	xref	c_vmul
5359                     	xref	c_eewrw
5360                     	end
