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
2558                     ; 186 void led_drv(void)
2558                     ; 187 {
2559                     	switch	.text
2560  008e               _led_drv:
2564                     ; 188 } 
2567  008e 81            	ret
2594                     ; 196 void pwr_drv(void)
2594                     ; 197 {
2595                     	switch	.text
2596  008f               _pwr_drv:
2600                     ; 208 pwm_u=1050-adc_buff_[0];
2602  008f ae041a        	ldw	x,#1050
2603  0092 72b00005      	subw	x,_adc_buff_
2604  0096 bf0a          	ldw	_pwm_u,x
2605                     ; 210 if(pwm_u>1020)pwm_u=1020;
2607  0098 9c            	rvf
2608  0099 be0a          	ldw	x,_pwm_u
2609  009b a303fd        	cpw	x,#1021
2610  009e 2f05          	jrslt	L7751
2613  00a0 ae03fc        	ldw	x,#1020
2614  00a3 bf0a          	ldw	_pwm_u,x
2615  00a5               L7751:
2616                     ; 211 pwm_i=adc_buff_[0];
2618  00a5 ce0005        	ldw	x,_adc_buff_
2619  00a8 bf0c          	ldw	_pwm_i,x
2620                     ; 215 TIM1->CCR2H= (char)(pwm_u/256);	
2622  00aa be0a          	ldw	x,_pwm_u
2623  00ac 90ae0100      	ldw	y,#256
2624  00b0 cd0000        	call	c_idiv
2626  00b3 9f            	ld	a,xl
2627  00b4 c75267        	ld	21095,a
2628                     ; 216 TIM1->CCR2L= (char)pwm_u;
2630  00b7 55000b5268    	mov	21096,_pwm_u+1
2631                     ; 218 TIM1->CCR1H= (char)(pwm_i/256);	
2633  00bc be0c          	ldw	x,_pwm_i
2634  00be 90ae0100      	ldw	y,#256
2635  00c2 cd0000        	call	c_idiv
2637  00c5 9f            	ld	a,xl
2638  00c6 c75265        	ld	21093,a
2639                     ; 219 TIM1->CCR1L= (char)pwm_i;
2641  00c9 55000d5266    	mov	21094,_pwm_i+1
2642                     ; 221 TIM1->CCR3H= (char)(vent_pwm/256);	
2644  00ce be01          	ldw	x,_vent_pwm
2645  00d0 90ae0100      	ldw	y,#256
2646  00d4 cd0000        	call	c_idiv
2648  00d7 9f            	ld	a,xl
2649  00d8 c75269        	ld	21097,a
2650                     ; 222 TIM1->CCR3L= (char)vent_pwm;
2652  00db 550002526a    	mov	21098,_vent_pwm+1
2653                     ; 223 }
2656  00e0 81            	ret
2679                     ; 228 void pwr_hndl(void)				
2679                     ; 229 {
2680                     	switch	.text
2681  00e1               _pwr_hndl:
2685                     ; 231 }
2688  00e1 81            	ret
2711                     ; 234 void matemat(void)
2711                     ; 235 {
2712                     	switch	.text
2713  00e2               _matemat:
2717                     ; 238 }
2720  00e2 81            	ret
2755                     ; 376 void adr_drv_v4(char in)
2755                     ; 377 {
2756                     	switch	.text
2757  00e3               _adr_drv_v4:
2761                     ; 378 if(adress!=in)adress=in;
2763  00e3 c10001        	cp	a,_adress
2764  00e6 2703          	jreq	L7361
2767  00e8 c70001        	ld	_adress,a
2768  00eb               L7361:
2769                     ; 379 }
2772  00eb 81            	ret
2801                     ; 382 void adr_drv_v3(void)
2801                     ; 383 {
2802                     	switch	.text
2803  00ec               _adr_drv_v3:
2805  00ec 88            	push	a
2806       00000001      OFST:	set	1
2809                     ; 389 GPIOB->DDR&=~(1<<0);
2811  00ed 72115007      	bres	20487,#0
2812                     ; 390 GPIOB->CR1&=~(1<<0);
2814  00f1 72115008      	bres	20488,#0
2815                     ; 391 GPIOB->CR2&=~(1<<0);
2817  00f5 72115009      	bres	20489,#0
2818                     ; 392 ADC2->CR2=0x08;
2820  00f9 35085402      	mov	21506,#8
2821                     ; 393 ADC2->CR1=0x40;
2823  00fd 35405401      	mov	21505,#64
2824                     ; 394 ADC2->CSR=0x20+0;
2826  0101 35205400      	mov	21504,#32
2827                     ; 395 ADC2->CR1|=1;
2829  0105 72105401      	bset	21505,#0
2830                     ; 396 ADC2->CR1|=1;
2832  0109 72105401      	bset	21505,#0
2833                     ; 397 adr_drv_stat=1;
2835  010d 35010008      	mov	_adr_drv_stat,#1
2836  0111               L1561:
2837                     ; 398 while(adr_drv_stat==1);
2840  0111 b608          	ld	a,_adr_drv_stat
2841  0113 a101          	cp	a,#1
2842  0115 27fa          	jreq	L1561
2843                     ; 400 GPIOB->DDR&=~(1<<1);
2845  0117 72135007      	bres	20487,#1
2846                     ; 401 GPIOB->CR1&=~(1<<1);
2848  011b 72135008      	bres	20488,#1
2849                     ; 402 GPIOB->CR2&=~(1<<1);
2851  011f 72135009      	bres	20489,#1
2852                     ; 403 ADC2->CR2=0x08;
2854  0123 35085402      	mov	21506,#8
2855                     ; 404 ADC2->CR1=0x40;
2857  0127 35405401      	mov	21505,#64
2858                     ; 405 ADC2->CSR=0x20+1;
2860  012b 35215400      	mov	21504,#33
2861                     ; 406 ADC2->CR1|=1;
2863  012f 72105401      	bset	21505,#0
2864                     ; 407 ADC2->CR1|=1;
2866  0133 72105401      	bset	21505,#0
2867                     ; 408 adr_drv_stat=3;
2869  0137 35030008      	mov	_adr_drv_stat,#3
2870  013b               L7561:
2871                     ; 409 while(adr_drv_stat==3);
2874  013b b608          	ld	a,_adr_drv_stat
2875  013d a103          	cp	a,#3
2876  013f 27fa          	jreq	L7561
2877                     ; 411 GPIOE->DDR&=~(1<<6);
2879  0141 721d5016      	bres	20502,#6
2880                     ; 412 GPIOE->CR1&=~(1<<6);
2882  0145 721d5017      	bres	20503,#6
2883                     ; 413 GPIOE->CR2&=~(1<<6);
2885  0149 721d5018      	bres	20504,#6
2886                     ; 414 ADC2->CR2=0x08;
2888  014d 35085402      	mov	21506,#8
2889                     ; 415 ADC2->CR1=0x40;
2891  0151 35405401      	mov	21505,#64
2892                     ; 416 ADC2->CSR=0x20+9;
2894  0155 35295400      	mov	21504,#41
2895                     ; 417 ADC2->CR1|=1;
2897  0159 72105401      	bset	21505,#0
2898                     ; 418 ADC2->CR1|=1;
2900  015d 72105401      	bset	21505,#0
2901                     ; 419 adr_drv_stat=5;
2903  0161 35050008      	mov	_adr_drv_stat,#5
2904  0165               L5661:
2905                     ; 420 while(adr_drv_stat==5);
2908  0165 b608          	ld	a,_adr_drv_stat
2909  0167 a105          	cp	a,#5
2910  0169 27fa          	jreq	L5661
2911                     ; 424 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
2913  016b 9c            	rvf
2914  016c ce0005        	ldw	x,_adc_buff_
2915  016f a3022a        	cpw	x,#554
2916  0172 2f0f          	jrslt	L3761
2918  0174 9c            	rvf
2919  0175 ce0005        	ldw	x,_adc_buff_
2920  0178 a30253        	cpw	x,#595
2921  017b 2e06          	jrsge	L3761
2924  017d 725f0002      	clr	_adr
2926  0181 204c          	jra	L5761
2927  0183               L3761:
2928                     ; 425 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
2930  0183 9c            	rvf
2931  0184 ce0005        	ldw	x,_adc_buff_
2932  0187 a3036d        	cpw	x,#877
2933  018a 2f0f          	jrslt	L7761
2935  018c 9c            	rvf
2936  018d ce0005        	ldw	x,_adc_buff_
2937  0190 a30396        	cpw	x,#918
2938  0193 2e06          	jrsge	L7761
2941  0195 35010002      	mov	_adr,#1
2943  0199 2034          	jra	L5761
2944  019b               L7761:
2945                     ; 426 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
2947  019b 9c            	rvf
2948  019c ce0005        	ldw	x,_adc_buff_
2949  019f a302a3        	cpw	x,#675
2950  01a2 2f0f          	jrslt	L3071
2952  01a4 9c            	rvf
2953  01a5 ce0005        	ldw	x,_adc_buff_
2954  01a8 a302cc        	cpw	x,#716
2955  01ab 2e06          	jrsge	L3071
2958  01ad 35020002      	mov	_adr,#2
2960  01b1 201c          	jra	L5761
2961  01b3               L3071:
2962                     ; 427 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
2964  01b3 9c            	rvf
2965  01b4 ce0005        	ldw	x,_adc_buff_
2966  01b7 a303e3        	cpw	x,#995
2967  01ba 2f0f          	jrslt	L7071
2969  01bc 9c            	rvf
2970  01bd ce0005        	ldw	x,_adc_buff_
2971  01c0 a3040c        	cpw	x,#1036
2972  01c3 2e06          	jrsge	L7071
2975  01c5 35030002      	mov	_adr,#3
2977  01c9 2004          	jra	L5761
2978  01cb               L7071:
2979                     ; 428 else adr[0]=5;
2981  01cb 35050002      	mov	_adr,#5
2982  01cf               L5761:
2983                     ; 430 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
2985  01cf 9c            	rvf
2986  01d0 ce0007        	ldw	x,_adc_buff_+2
2987  01d3 a3022a        	cpw	x,#554
2988  01d6 2f0f          	jrslt	L3171
2990  01d8 9c            	rvf
2991  01d9 ce0007        	ldw	x,_adc_buff_+2
2992  01dc a30253        	cpw	x,#595
2993  01df 2e06          	jrsge	L3171
2996  01e1 725f0003      	clr	_adr+1
2998  01e5 204c          	jra	L5171
2999  01e7               L3171:
3000                     ; 431 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
3002  01e7 9c            	rvf
3003  01e8 ce0007        	ldw	x,_adc_buff_+2
3004  01eb a3036d        	cpw	x,#877
3005  01ee 2f0f          	jrslt	L7171
3007  01f0 9c            	rvf
3008  01f1 ce0007        	ldw	x,_adc_buff_+2
3009  01f4 a30396        	cpw	x,#918
3010  01f7 2e06          	jrsge	L7171
3013  01f9 35010003      	mov	_adr+1,#1
3015  01fd 2034          	jra	L5171
3016  01ff               L7171:
3017                     ; 432 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
3019  01ff 9c            	rvf
3020  0200 ce0007        	ldw	x,_adc_buff_+2
3021  0203 a302a3        	cpw	x,#675
3022  0206 2f0f          	jrslt	L3271
3024  0208 9c            	rvf
3025  0209 ce0007        	ldw	x,_adc_buff_+2
3026  020c a302cc        	cpw	x,#716
3027  020f 2e06          	jrsge	L3271
3030  0211 35020003      	mov	_adr+1,#2
3032  0215 201c          	jra	L5171
3033  0217               L3271:
3034                     ; 433 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
3036  0217 9c            	rvf
3037  0218 ce0007        	ldw	x,_adc_buff_+2
3038  021b a303e3        	cpw	x,#995
3039  021e 2f0f          	jrslt	L7271
3041  0220 9c            	rvf
3042  0221 ce0007        	ldw	x,_adc_buff_+2
3043  0224 a3040c        	cpw	x,#1036
3044  0227 2e06          	jrsge	L7271
3047  0229 35030003      	mov	_adr+1,#3
3049  022d 2004          	jra	L5171
3050  022f               L7271:
3051                     ; 434 else adr[1]=5;
3053  022f 35050003      	mov	_adr+1,#5
3054  0233               L5171:
3055                     ; 436 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
3057  0233 9c            	rvf
3058  0234 ce0017        	ldw	x,_adc_buff_+18
3059  0237 a3022a        	cpw	x,#554
3060  023a 2f0f          	jrslt	L3371
3062  023c 9c            	rvf
3063  023d ce0017        	ldw	x,_adc_buff_+18
3064  0240 a30253        	cpw	x,#595
3065  0243 2e06          	jrsge	L3371
3068  0245 725f0004      	clr	_adr+2
3070  0249 204c          	jra	L5371
3071  024b               L3371:
3072                     ; 437 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
3074  024b 9c            	rvf
3075  024c ce0017        	ldw	x,_adc_buff_+18
3076  024f a3036d        	cpw	x,#877
3077  0252 2f0f          	jrslt	L7371
3079  0254 9c            	rvf
3080  0255 ce0017        	ldw	x,_adc_buff_+18
3081  0258 a30396        	cpw	x,#918
3082  025b 2e06          	jrsge	L7371
3085  025d 35010004      	mov	_adr+2,#1
3087  0261 2034          	jra	L5371
3088  0263               L7371:
3089                     ; 438 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
3091  0263 9c            	rvf
3092  0264 ce0017        	ldw	x,_adc_buff_+18
3093  0267 a302a3        	cpw	x,#675
3094  026a 2f0f          	jrslt	L3471
3096  026c 9c            	rvf
3097  026d ce0017        	ldw	x,_adc_buff_+18
3098  0270 a302cc        	cpw	x,#716
3099  0273 2e06          	jrsge	L3471
3102  0275 35020004      	mov	_adr+2,#2
3104  0279 201c          	jra	L5371
3105  027b               L3471:
3106                     ; 439 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
3108  027b 9c            	rvf
3109  027c ce0017        	ldw	x,_adc_buff_+18
3110  027f a303e3        	cpw	x,#995
3111  0282 2f0f          	jrslt	L7471
3113  0284 9c            	rvf
3114  0285 ce0017        	ldw	x,_adc_buff_+18
3115  0288 a3040c        	cpw	x,#1036
3116  028b 2e06          	jrsge	L7471
3119  028d 35030004      	mov	_adr+2,#3
3121  0291 2004          	jra	L5371
3122  0293               L7471:
3123                     ; 440 else adr[2]=5;
3125  0293 35050004      	mov	_adr+2,#5
3126  0297               L5371:
3127                     ; 444 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
3129  0297 c60002        	ld	a,_adr
3130  029a a105          	cp	a,#5
3131  029c 270e          	jreq	L5571
3133  029e c60003        	ld	a,_adr+1
3134  02a1 a105          	cp	a,#5
3135  02a3 2707          	jreq	L5571
3137  02a5 c60004        	ld	a,_adr+2
3138  02a8 a105          	cp	a,#5
3139  02aa 2606          	jrne	L3571
3140  02ac               L5571:
3141                     ; 447 	adress_error=1;
3143  02ac 35010000      	mov	_adress_error,#1
3145  02b0               L1671:
3146                     ; 458 }
3149  02b0 84            	pop	a
3150  02b1 81            	ret
3151  02b2               L3571:
3152                     ; 451 	if(adr[2]&0x02) bps_class=bpsIPS;
3154  02b2 c60004        	ld	a,_adr+2
3155  02b5 a502          	bcp	a,#2
3156  02b7 2706          	jreq	L3671
3159  02b9 35010000      	mov	_bps_class,#1
3161  02bd 2002          	jra	L5671
3162  02bf               L3671:
3163                     ; 452 	else bps_class=bpsIBEP;
3165  02bf 3f00          	clr	_bps_class
3166  02c1               L5671:
3167                     ; 454 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
3169  02c1 c60004        	ld	a,_adr+2
3170  02c4 a401          	and	a,#1
3171  02c6 97            	ld	xl,a
3172  02c7 a610          	ld	a,#16
3173  02c9 42            	mul	x,a
3174  02ca 9f            	ld	a,xl
3175  02cb 6b01          	ld	(OFST+0,sp),a
3176  02cd c60003        	ld	a,_adr+1
3177  02d0 48            	sll	a
3178  02d1 48            	sll	a
3179  02d2 cb0002        	add	a,_adr
3180  02d5 1b01          	add	a,(OFST+0,sp)
3181  02d7 c70001        	ld	_adress,a
3182  02da 20d4          	jra	L1671
3205                     ; 464 void t4_init(void){
3206                     	switch	.text
3207  02dc               _t4_init:
3211                     ; 465 	TIM4->PSCR = 4;
3213  02dc 35045345      	mov	21317,#4
3214                     ; 466 	TIM4->ARR= 77;
3216  02e0 354d5346      	mov	21318,#77
3217                     ; 467 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
3219  02e4 72105341      	bset	21313,#0
3220                     ; 469 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
3222  02e8 35855340      	mov	21312,#133
3223                     ; 471 }
3226  02ec 81            	ret
3249                     ; 474 void t1_init(void)
3249                     ; 475 {
3250                     	switch	.text
3251  02ed               _t1_init:
3255                     ; 476 TIM1->ARRH= 0x03;
3257  02ed 35035262      	mov	21090,#3
3258                     ; 477 TIM1->ARRL= 0xff;
3260  02f1 35ff5263      	mov	21091,#255
3261                     ; 478 TIM1->CCR1H= 0x00;	
3263  02f5 725f5265      	clr	21093
3264                     ; 479 TIM1->CCR1L= 0xff;
3266  02f9 35ff5266      	mov	21094,#255
3267                     ; 480 TIM1->CCR2H= 0x00;	
3269  02fd 725f5267      	clr	21095
3270                     ; 481 TIM1->CCR2L= 0x00;
3272  0301 725f5268      	clr	21096
3273                     ; 482 TIM1->CCR3H= 0x00;	
3275  0305 725f5269      	clr	21097
3276                     ; 483 TIM1->CCR3L= 0x64;
3278  0309 3564526a      	mov	21098,#100
3279                     ; 485 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
3281  030d 35685258      	mov	21080,#104
3282                     ; 486 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
3284  0311 35685259      	mov	21081,#104
3285                     ; 487 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
3287  0315 3568525a      	mov	21082,#104
3288                     ; 488 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
3290  0319 3511525c      	mov	21084,#17
3291                     ; 489 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
3293  031d 3501525d      	mov	21085,#1
3294                     ; 490 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
3296  0321 35815250      	mov	21072,#129
3297                     ; 491 TIM1->BKR|= TIM1_BKR_AOE;
3299  0325 721c526d      	bset	21101,#6
3300                     ; 492 }
3303  0329 81            	ret
3327                     ; 496 void adc2_init(void)
3327                     ; 497 {
3328                     	switch	.text
3329  032a               _adc2_init:
3333                     ; 498 adc_plazma[0]++;
3335  032a be6d          	ldw	x,_adc_plazma
3336  032c 1c0001        	addw	x,#1
3337  032f bf6d          	ldw	_adc_plazma,x
3338                     ; 501 GPIOB->DDR&=~(1<<0);
3340  0331 72115007      	bres	20487,#0
3341                     ; 502 GPIOB->CR1&=~(1<<0);
3343  0335 72115008      	bres	20488,#0
3344                     ; 503 GPIOB->CR2&=~(1<<0);
3346  0339 72115009      	bres	20489,#0
3347                     ; 505 GPIOB->DDR&=~(1<<1);
3349  033d 72135007      	bres	20487,#1
3350                     ; 506 GPIOB->CR1&=~(1<<1);
3352  0341 72135008      	bres	20488,#1
3353                     ; 507 GPIOB->CR2&=~(1<<1);
3355  0345 72135009      	bres	20489,#1
3356                     ; 509 GPIOE->DDR&=~(1<<6);
3358  0349 721d5016      	bres	20502,#6
3359                     ; 510 GPIOE->CR1&=~(1<<6);
3361  034d 721d5017      	bres	20503,#6
3362                     ; 511 GPIOE->CR2&=~(1<<6);
3364  0351 721d5018      	bres	20504,#6
3365                     ; 513 GPIOB->DDR&=~(1<<4);
3367  0355 72195007      	bres	20487,#4
3368                     ; 514 GPIOB->CR1&=~(1<<4);
3370  0359 72195008      	bres	20488,#4
3371                     ; 515 GPIOB->CR2&=~(1<<4);
3373  035d 72195009      	bres	20489,#4
3374                     ; 517 GPIOB->DDR&=~(1<<5);
3376  0361 721b5007      	bres	20487,#5
3377                     ; 518 GPIOB->CR1&=~(1<<5);
3379  0365 721b5008      	bres	20488,#5
3380                     ; 519 GPIOB->CR2&=~(1<<5);
3382  0369 721b5009      	bres	20489,#5
3383                     ; 521 GPIOB->DDR&=~(1<<6);
3385  036d 721d5007      	bres	20487,#6
3386                     ; 522 GPIOB->CR1&=~(1<<6);
3388  0371 721d5008      	bres	20488,#6
3389                     ; 523 GPIOB->CR2&=~(1<<6);
3391  0375 721d5009      	bres	20489,#6
3392                     ; 525 GPIOB->DDR&=~(1<<7);
3394  0379 721f5007      	bres	20487,#7
3395                     ; 526 GPIOB->CR1&=~(1<<7);
3397  037d 721f5008      	bres	20488,#7
3398                     ; 527 GPIOB->CR2&=~(1<<7);
3400  0381 721f5009      	bres	20489,#7
3401                     ; 529 ADC2->TDRL=0xff;
3403  0385 35ff5407      	mov	21511,#255
3404                     ; 531 ADC2->CR2=0x08;
3406  0389 35085402      	mov	21506,#8
3407                     ; 532 ADC2->CR1=0x40;
3409  038d 35405401      	mov	21505,#64
3410                     ; 535 	ADC2->CSR=0x20;
3412  0391 35205400      	mov	21504,#32
3413                     ; 537 	ADC2->CR1|=1;
3415  0395 72105401      	bset	21505,#0
3416                     ; 538 	ADC2->CR1|=1;
3418  0399 72105401      	bset	21505,#0
3419                     ; 540 }
3422  039d 81            	ret
3456                     ; 549 @far @interrupt void TIM4_UPD_Interrupt (void) 
3456                     ; 550 {
3458                     	switch	.text
3459  039e               f_TIM4_UPD_Interrupt:
3463                     ; 551 TIM4->SR1&=~TIM4_SR1_UIF;
3465  039e 72115342      	bres	21314,#0
3466                     ; 553 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
3468  03a2 3c04          	inc	_pwm_vent_cnt
3469  03a4 b604          	ld	a,_pwm_vent_cnt
3470  03a6 a10a          	cp	a,#10
3471  03a8 2502          	jrult	L7202
3474  03aa 3f04          	clr	_pwm_vent_cnt
3475  03ac               L7202:
3476                     ; 554 GPIOB->ODR|=(1<<3);
3478  03ac 72165005      	bset	20485,#3
3479                     ; 555 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
3481  03b0 b604          	ld	a,_pwm_vent_cnt
3482  03b2 a105          	cp	a,#5
3483  03b4 2504          	jrult	L1302
3486  03b6 72175005      	bres	20485,#3
3487  03ba               L1302:
3488                     ; 560 if(++t0_cnt0>=100)
3490  03ba 9c            	rvf
3491  03bb be01          	ldw	x,_t0_cnt0
3492  03bd 1c0001        	addw	x,#1
3493  03c0 bf01          	ldw	_t0_cnt0,x
3494  03c2 a30064        	cpw	x,#100
3495  03c5 2f3f          	jrslt	L3302
3496                     ; 562 	t0_cnt0=0;
3498  03c7 5f            	clrw	x
3499  03c8 bf01          	ldw	_t0_cnt0,x
3500                     ; 563 	b100Hz=1;
3502  03ca 72100008      	bset	_b100Hz
3503                     ; 565 	if(++t0_cnt1>=10)
3505  03ce 3c03          	inc	_t0_cnt1
3506  03d0 b603          	ld	a,_t0_cnt1
3507  03d2 a10a          	cp	a,#10
3508  03d4 2506          	jrult	L5302
3509                     ; 567 		t0_cnt1=0;
3511  03d6 3f03          	clr	_t0_cnt1
3512                     ; 568 		b10Hz=1;
3514  03d8 72100007      	bset	_b10Hz
3515  03dc               L5302:
3516                     ; 571 	if(++t0_cnt2>=20)
3518  03dc 3c04          	inc	_t0_cnt2
3519  03de b604          	ld	a,_t0_cnt2
3520  03e0 a114          	cp	a,#20
3521  03e2 2506          	jrult	L7302
3522                     ; 573 		t0_cnt2=0;
3524  03e4 3f04          	clr	_t0_cnt2
3525                     ; 574 		b5Hz=1;
3527  03e6 72100006      	bset	_b5Hz
3528  03ea               L7302:
3529                     ; 578 	if(++t0_cnt4>=50)
3531  03ea 3c06          	inc	_t0_cnt4
3532  03ec b606          	ld	a,_t0_cnt4
3533  03ee a132          	cp	a,#50
3534  03f0 2506          	jrult	L1402
3535                     ; 580 		t0_cnt4=0;
3537  03f2 3f06          	clr	_t0_cnt4
3538                     ; 581 		b2Hz=1;
3540  03f4 72100005      	bset	_b2Hz
3541  03f8               L1402:
3542                     ; 584 	if(++t0_cnt3>=100)
3544  03f8 3c05          	inc	_t0_cnt3
3545  03fa b605          	ld	a,_t0_cnt3
3546  03fc a164          	cp	a,#100
3547  03fe 2506          	jrult	L3302
3548                     ; 586 		t0_cnt3=0;
3550  0400 3f05          	clr	_t0_cnt3
3551                     ; 587 		b1Hz=1;
3553  0402 72100004      	bset	_b1Hz
3554  0406               L3302:
3555                     ; 593 }
3558  0406 80            	iret
3613                     .const:	section	.text
3614  0000               L04:
3615  0000 0000000a      	dc.l	10
3616                     ; 597 @far @interrupt void ADC2_EOC_Interrupt (void) {
3617                     	switch	.text
3618  0407               f_ADC2_EOC_Interrupt:
3620       00000009      OFST:	set	9
3621  0407 be00          	ldw	x,c_x
3622  0409 89            	pushw	x
3623  040a be00          	ldw	x,c_y
3624  040c 89            	pushw	x
3625  040d be02          	ldw	x,c_lreg+2
3626  040f 89            	pushw	x
3627  0410 be00          	ldw	x,c_lreg
3628  0412 89            	pushw	x
3629  0413 5209          	subw	sp,#9
3632                     ; 602 ADC2->CSR&=~(1<<7);
3634  0415 721f5400      	bres	21504,#7
3635                     ; 604 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
3637  0419 c65405        	ld	a,21509
3638  041c b703          	ld	c_lreg+3,a
3639  041e 3f02          	clr	c_lreg+2
3640  0420 3f01          	clr	c_lreg+1
3641  0422 3f00          	clr	c_lreg
3642  0424 96            	ldw	x,sp
3643  0425 1c0001        	addw	x,#OFST-8
3644  0428 cd0000        	call	c_rtol
3646  042b c65404        	ld	a,21508
3647  042e 5f            	clrw	x
3648  042f 97            	ld	xl,a
3649  0430 90ae0100      	ldw	y,#256
3650  0434 cd0000        	call	c_umul
3652  0437 96            	ldw	x,sp
3653  0438 1c0001        	addw	x,#OFST-8
3654  043b cd0000        	call	c_ladd
3656  043e 96            	ldw	x,sp
3657  043f 1c0006        	addw	x,#OFST-3
3658  0442 cd0000        	call	c_rtol
3660                     ; 606 adc_buff[adc_ch][adc_cnt]=temp_adc;
3662  0445 b679          	ld	a,_adc_cnt
3663  0447 5f            	clrw	x
3664  0448 97            	ld	xl,a
3665  0449 58            	sllw	x
3666  044a 1f03          	ldw	(OFST-6,sp),x
3667  044c b67a          	ld	a,_adc_ch
3668  044e 97            	ld	xl,a
3669  044f a620          	ld	a,#32
3670  0451 42            	mul	x,a
3671  0452 72fb03        	addw	x,(OFST-6,sp)
3672  0455 1608          	ldw	y,(OFST-1,sp)
3673  0457 df0019        	ldw	(_adc_buff,x),y
3674                     ; 608 adc_ch=0;
3676  045a 3f7a          	clr	_adc_ch
3677                     ; 609 adc_cnt++;
3679  045c 3c79          	inc	_adc_cnt
3680                     ; 610 if(adc_cnt>=16)
3682  045e b679          	ld	a,_adc_cnt
3683  0460 a110          	cp	a,#16
3684  0462 2502          	jrult	L3702
3685                     ; 612 	adc_cnt=0;
3687  0464 3f79          	clr	_adc_cnt
3688  0466               L3702:
3689                     ; 615 if((adc_cnt&0x03)==0)
3691  0466 b679          	ld	a,_adc_cnt
3692  0468 a503          	bcp	a,#3
3693  046a 2638          	jrne	L5702
3694                     ; 619 	tempSS=0;
3696  046c ae0000        	ldw	x,#0
3697  046f 1f08          	ldw	(OFST-1,sp),x
3698  0471 ae0000        	ldw	x,#0
3699  0474 1f06          	ldw	(OFST-3,sp),x
3700                     ; 620 	for(i=0;i<16;i++)
3702  0476 0f05          	clr	(OFST-4,sp)
3703  0478               L7702:
3704                     ; 622 		tempSS+=(signed long)adc_buff[0][i];
3706  0478 7b05          	ld	a,(OFST-4,sp)
3707  047a 5f            	clrw	x
3708  047b 97            	ld	xl,a
3709  047c 58            	sllw	x
3710  047d de0019        	ldw	x,(_adc_buff,x)
3711  0480 cd0000        	call	c_itolx
3713  0483 96            	ldw	x,sp
3714  0484 1c0006        	addw	x,#OFST-3
3715  0487 cd0000        	call	c_lgadd
3717                     ; 620 	for(i=0;i<16;i++)
3719  048a 0c05          	inc	(OFST-4,sp)
3722  048c 7b05          	ld	a,(OFST-4,sp)
3723  048e a110          	cp	a,#16
3724  0490 25e6          	jrult	L7702
3725                     ; 624 	adc_buff_[0]=(signed short)(tempSS/10);
3727  0492 96            	ldw	x,sp
3728  0493 1c0006        	addw	x,#OFST-3
3729  0496 cd0000        	call	c_ltor
3731  0499 ae0000        	ldw	x,#L04
3732  049c cd0000        	call	c_ldiv
3734  049f be02          	ldw	x,c_lreg+2
3735  04a1 cf0005        	ldw	_adc_buff_,x
3736  04a4               L5702:
3737                     ; 628 }
3740  04a4 5b09          	addw	sp,#9
3741  04a6 85            	popw	x
3742  04a7 bf00          	ldw	c_lreg,x
3743  04a9 85            	popw	x
3744  04aa bf02          	ldw	c_lreg+2,x
3745  04ac 85            	popw	x
3746  04ad bf00          	ldw	c_y,x
3747  04af 85            	popw	x
3748  04b0 bf00          	ldw	c_x,x
3749  04b2 80            	iret
3791                     ; 636 main()
3791                     ; 637 {
3793                     	switch	.text
3794  04b3               _main:
3798                     ; 639 CLK->ECKR|=1;
3800  04b3 721050c1      	bset	20673,#0
3802  04b7               L7112:
3803                     ; 640 while((CLK->ECKR & 2) == 0);
3805  04b7 c650c1        	ld	a,20673
3806  04ba a502          	bcp	a,#2
3807  04bc 27f9          	jreq	L7112
3808                     ; 641 CLK->SWCR|=2;
3810  04be 721250c5      	bset	20677,#1
3811                     ; 642 CLK->SWR=0xB4;
3813  04c2 35b450c4      	mov	20676,#180
3814                     ; 644 delay_ms(200);
3816  04c6 ae00c8        	ldw	x,#200
3817  04c9 cd004c        	call	_delay_ms
3819                     ; 645 FLASH_DUKR=0xae;
3821  04cc 35ae5064      	mov	_FLASH_DUKR,#174
3822                     ; 646 FLASH_DUKR=0x56;
3824  04d0 35565064      	mov	_FLASH_DUKR,#86
3825                     ; 647 enableInterrupts();
3828  04d4 9a            rim
3830                     ; 654 t4_init();
3833  04d5 cd02dc        	call	_t4_init
3835                     ; 656 		GPIOG->DDR|=(1<<0);
3837  04d8 72105020      	bset	20512,#0
3838                     ; 657 		GPIOG->CR1|=(1<<0);
3840  04dc 72105021      	bset	20513,#0
3841                     ; 658 		GPIOG->CR2&=~(1<<0);	
3843  04e0 72115022      	bres	20514,#0
3844                     ; 661 		GPIOG->DDR&=~(1<<1);
3846  04e4 72135020      	bres	20512,#1
3847                     ; 662 		GPIOG->CR1|=(1<<1);
3849  04e8 72125021      	bset	20513,#1
3850                     ; 663 		GPIOG->CR2&=~(1<<1);
3852  04ec 72135022      	bres	20514,#1
3853                     ; 669 GPIOC->DDR|=(1<<1);
3855  04f0 7212500c      	bset	20492,#1
3856                     ; 670 GPIOC->CR1|=(1<<1);
3858  04f4 7212500d      	bset	20493,#1
3859                     ; 671 GPIOC->CR2|=(1<<1);
3861  04f8 7212500e      	bset	20494,#1
3862                     ; 673 GPIOC->DDR|=(1<<2);
3864  04fc 7214500c      	bset	20492,#2
3865                     ; 674 GPIOC->CR1|=(1<<2);
3867  0500 7214500d      	bset	20493,#2
3868                     ; 675 GPIOC->CR2|=(1<<2);
3870  0504 7214500e      	bset	20494,#2
3871                     ; 682 t1_init();
3873  0508 cd02ed        	call	_t1_init
3875                     ; 684 GPIOA->DDR|=(1<<5);
3877  050b 721a5002      	bset	20482,#5
3878                     ; 685 GPIOA->CR1|=(1<<5);
3880  050f 721a5003      	bset	20483,#5
3881                     ; 686 GPIOA->CR2&=~(1<<5);
3883  0513 721b5004      	bres	20484,#5
3884                     ; 692 GPIOB->DDR&=~(1<<3);
3886  0517 72175007      	bres	20487,#3
3887                     ; 693 GPIOB->CR1&=~(1<<3);
3889  051b 72175008      	bres	20488,#3
3890                     ; 694 GPIOB->CR2&=~(1<<3);
3892  051f 72175009      	bres	20489,#3
3893                     ; 696 GPIOC->DDR|=(1<<3);
3895  0523 7216500c      	bset	20492,#3
3896                     ; 697 GPIOC->CR1|=(1<<3);
3898  0527 7216500d      	bset	20493,#3
3899                     ; 698 GPIOC->CR2|=(1<<3);
3901  052b 7216500e      	bset	20494,#3
3902                     ; 701 if(bps_class==bpsIPS) 
3904  052f b600          	ld	a,_bps_class
3905  0531 a101          	cp	a,#1
3906  0533 260a          	jrne	L5212
3907                     ; 703 	pwm_u=ee_U_AVT;
3909  0535 ce000a        	ldw	x,_ee_U_AVT
3910  0538 bf0a          	ldw	_pwm_u,x
3911                     ; 704 	volum_u_main_=ee_U_AVT;
3913  053a ce000a        	ldw	x,_ee_U_AVT
3914  053d bf1b          	ldw	_volum_u_main_,x
3915  053f               L5212:
3916                     ; 711 if(b100Hz)
3918                     	btst	_b100Hz
3919  0544 2407          	jruge	L1312
3920                     ; 713 		b100Hz=0;
3922  0546 72110008      	bres	_b100Hz
3923                     ; 715 		adc2_init();
3925  054a cd032a        	call	_adc2_init
3927  054d               L1312:
3928                     ; 718 	if(b10Hz)
3930                     	btst	_b10Hz
3931  0552 240d          	jruge	L3312
3932                     ; 720 		b10Hz=0;
3934  0554 72110007      	bres	_b10Hz
3935                     ; 722         matemat();
3937  0558 cd00e2        	call	_matemat
3939                     ; 723 	    led_drv(); 
3941  055b cd008e        	call	_led_drv
3943                     ; 724 		pwr_hndl();		//вычисление воздействий на силу
3945  055e cd00e1        	call	_pwr_hndl
3947  0561               L3312:
3948                     ; 727 	if(b5Hz)
3950                     	btst	_b5Hz
3951  0566 2407          	jruge	L5312
3952                     ; 729 		b5Hz=0;
3954  0568 72110006      	bres	_b5Hz
3955                     ; 731 		pwr_drv();		//воздействие на силу
3957  056c cd008f        	call	_pwr_drv
3959  056f               L5312:
3960                     ; 734 	if(b2Hz)
3962                     	btst	_b2Hz
3963  0574 2404          	jruge	L7312
3964                     ; 736 		b2Hz=0;
3966  0576 72110005      	bres	_b2Hz
3967  057a               L7312:
3968                     ; 740 	if(b1Hz)
3970                     	btst	_b1Hz
3971  057f 24be          	jruge	L5212
3972                     ; 742 		b1Hz=0;
3974  0581 72110004      	bres	_b1Hz
3975                     ; 744 		if(main_cnt<1000)main_cnt++;
3977  0585 9c            	rvf
3978  0586 be4d          	ldw	x,_main_cnt
3979  0588 a303e8        	cpw	x,#1000
3980  058b 2eb2          	jrsge	L5212
3983  058d be4d          	ldw	x,_main_cnt
3984  058f 1c0001        	addw	x,#1
3985  0592 bf4d          	ldw	_main_cnt,x
3986  0594 20a9          	jra	L5212
4944                     	xdef	_main
4945                     	xdef	f_ADC2_EOC_Interrupt
4946                     	xdef	f_TIM4_UPD_Interrupt
4947                     	xdef	_adc2_init
4948                     	xdef	_t1_init
4949                     	xdef	_t4_init
4950                     	xdef	_adr_drv_v3
4951                     	xdef	_adr_drv_v4
4952                     	xdef	_matemat
4953                     	xdef	_pwr_hndl
4954                     	xdef	_pwr_drv
4955                     	xdef	_led_drv
4956                     	xdef	_delay_ms
4957                     	xdef	_granee
4958                     	xdef	_gran
4959                     .eeprom:	section	.data
4960  0000               _ee_IMAXVENT:
4961  0000 0000          	ds.b	2
4962                     	xdef	_ee_IMAXVENT
4963                     	switch	.ubsct
4964  0000               _bps_class:
4965  0000 00            	ds.b	1
4966                     	xdef	_bps_class
4967  0001               _vent_pwm:
4968  0001 0000          	ds.b	2
4969                     	xdef	_vent_pwm
4970  0003               _pwm_stat:
4971  0003 00            	ds.b	1
4972                     	xdef	_pwm_stat
4973  0004               _pwm_vent_cnt:
4974  0004 00            	ds.b	1
4975                     	xdef	_pwm_vent_cnt
4976                     	switch	.eeprom
4977  0002               _ee_DEVICE:
4978  0002 0000          	ds.b	2
4979                     	xdef	_ee_DEVICE
4980  0004               _ee_AVT_MODE:
4981  0004 0000          	ds.b	2
4982                     	xdef	_ee_AVT_MODE
4983                     	switch	.ubsct
4984  0005               _i_main_bps_cnt:
4985  0005 000000000000  	ds.b	6
4986                     	xdef	_i_main_bps_cnt
4987  000b               _i_main_sigma:
4988  000b 0000          	ds.b	2
4989                     	xdef	_i_main_sigma
4990  000d               _i_main_num_of_bps:
4991  000d 00            	ds.b	1
4992                     	xdef	_i_main_num_of_bps
4993  000e               _i_main_avg:
4994  000e 0000          	ds.b	2
4995                     	xdef	_i_main_avg
4996  0010               _i_main_flag:
4997  0010 000000000000  	ds.b	6
4998                     	xdef	_i_main_flag
4999  0016               _i_main:
5000  0016 000000000000  	ds.b	12
5001                     	xdef	_i_main
5002  0022               _x:
5003  0022 000000000000  	ds.b	12
5004                     	xdef	_x
5005                     	xdef	_volum_u_main_
5006                     	switch	.eeprom
5007  0006               _UU_AVT:
5008  0006 0000          	ds.b	2
5009                     	xdef	_UU_AVT
5010                     	switch	.ubsct
5011  002e               _cnt_net_drv:
5012  002e 00            	ds.b	1
5013                     	xdef	_cnt_net_drv
5014                     	switch	.bit
5015  0001               _bMAIN:
5016  0001 00            	ds.b	1
5017                     	xdef	_bMAIN
5018                     	switch	.ubsct
5019  002f               _plazma_int:
5020  002f 000000000000  	ds.b	6
5021                     	xdef	_plazma_int
5022                     	xdef	_rotor_int
5023  0035               _led_green_buff:
5024  0035 00000000      	ds.b	4
5025                     	xdef	_led_green_buff
5026  0039               _led_red_buff:
5027  0039 00000000      	ds.b	4
5028                     	xdef	_led_red_buff
5029                     	xdef	_led_drv_cnt
5030                     	xdef	_led_green
5031                     	xdef	_led_red
5032  003d               _res_fl_cnt:
5033  003d 00            	ds.b	1
5034                     	xdef	_res_fl_cnt
5035                     	xdef	_bRES_
5036                     	xdef	_bRES
5037                     	switch	.eeprom
5038  0008               _res_fl_:
5039  0008 00            	ds.b	1
5040                     	xdef	_res_fl_
5041  0009               _res_fl:
5042  0009 00            	ds.b	1
5043                     	xdef	_res_fl
5044                     	switch	.ubsct
5045  003e               _cnt_apv_off:
5046  003e 00            	ds.b	1
5047                     	xdef	_cnt_apv_off
5048                     	switch	.bit
5049  0002               _bAPV:
5050  0002 00            	ds.b	1
5051                     	xdef	_bAPV
5052                     	switch	.ubsct
5053  003f               _apv_cnt_:
5054  003f 0000          	ds.b	2
5055                     	xdef	_apv_cnt_
5056  0041               _apv_cnt:
5057  0041 000000        	ds.b	3
5058                     	xdef	_apv_cnt
5059                     	xdef	_bBL_IPS
5060                     	switch	.bit
5061  0003               _bBL:
5062  0003 00            	ds.b	1
5063                     	xdef	_bBL
5064                     	switch	.ubsct
5065  0044               _cnt_JP1:
5066  0044 00            	ds.b	1
5067                     	xdef	_cnt_JP1
5068  0045               _cnt_JP0:
5069  0045 00            	ds.b	1
5070                     	xdef	_cnt_JP0
5071  0046               _jp_mode:
5072  0046 00            	ds.b	1
5073                     	xdef	_jp_mode
5074                     	xdef	_pwm_i
5075                     	xdef	_pwm_u
5076  0047               _tmax_cnt:
5077  0047 0000          	ds.b	2
5078                     	xdef	_tmax_cnt
5079  0049               _tsign_cnt:
5080  0049 0000          	ds.b	2
5081                     	xdef	_tsign_cnt
5082                     	switch	.eeprom
5083  000a               _ee_U_AVT:
5084  000a 0000          	ds.b	2
5085                     	xdef	_ee_U_AVT
5086  000c               _ee_tsign:
5087  000c 0000          	ds.b	2
5088                     	xdef	_ee_tsign
5089  000e               _ee_tmax:
5090  000e 0000          	ds.b	2
5091                     	xdef	_ee_tmax
5092  0010               _ee_dU:
5093  0010 0000          	ds.b	2
5094                     	xdef	_ee_dU
5095  0012               _ee_Umax:
5096  0012 0000          	ds.b	2
5097                     	xdef	_ee_Umax
5098  0014               _ee_TZAS:
5099  0014 0000          	ds.b	2
5100                     	xdef	_ee_TZAS
5101                     	switch	.ubsct
5102  004b               _main_cnt1:
5103  004b 0000          	ds.b	2
5104                     	xdef	_main_cnt1
5105  004d               _main_cnt:
5106  004d 0000          	ds.b	2
5107                     	xdef	_main_cnt
5108  004f               _off_bp_cnt:
5109  004f 00            	ds.b	1
5110                     	xdef	_off_bp_cnt
5111  0050               _flags_tu_cnt_off:
5112  0050 00            	ds.b	1
5113                     	xdef	_flags_tu_cnt_off
5114  0051               _flags_tu_cnt_on:
5115  0051 00            	ds.b	1
5116                     	xdef	_flags_tu_cnt_on
5117  0052               _vol_i_temp:
5118  0052 0000          	ds.b	2
5119                     	xdef	_vol_i_temp
5120  0054               _vol_u_temp:
5121  0054 0000          	ds.b	2
5122                     	xdef	_vol_u_temp
5123                     	switch	.eeprom
5124  0016               __x_ee_:
5125  0016 0000          	ds.b	2
5126                     	xdef	__x_ee_
5127                     	switch	.ubsct
5128  0056               __x_cnt:
5129  0056 0000          	ds.b	2
5130                     	xdef	__x_cnt
5131  0058               __x__:
5132  0058 0000          	ds.b	2
5133                     	xdef	__x__
5134  005a               __x_:
5135  005a 0000          	ds.b	2
5136                     	xdef	__x_
5137  005c               _flags_tu:
5138  005c 00            	ds.b	1
5139                     	xdef	_flags_tu
5140                     	xdef	_flags
5141  005d               _link_cnt:
5142  005d 00            	ds.b	1
5143                     	xdef	_link_cnt
5144  005e               _link:
5145  005e 00            	ds.b	1
5146                     	xdef	_link
5147  005f               _umin_cnt:
5148  005f 0000          	ds.b	2
5149                     	xdef	_umin_cnt
5150  0061               _umax_cnt:
5151  0061 0000          	ds.b	2
5152                     	xdef	_umax_cnt
5153                     	switch	.eeprom
5154  0018               _ee_K:
5155  0018 000000000000  	ds.b	16
5156                     	xdef	_ee_K
5157                     	switch	.ubsct
5158  0063               _T:
5159  0063 00            	ds.b	1
5160                     	xdef	_T
5161  0064               _Udb:
5162  0064 0000          	ds.b	2
5163                     	xdef	_Udb
5164  0066               _Ui:
5165  0066 0000          	ds.b	2
5166                     	xdef	_Ui
5167  0068               _Un:
5168  0068 0000          	ds.b	2
5169                     	xdef	_Un
5170  006a               _I:
5171  006a 0000          	ds.b	2
5172                     	xdef	_I
5173                     	switch	.bss
5174  0000               _adress_error:
5175  0000 00            	ds.b	1
5176                     	xdef	_adress_error
5177  0001               _adress:
5178  0001 00            	ds.b	1
5179                     	xdef	_adress
5180  0002               _adr:
5181  0002 000000        	ds.b	3
5182                     	xdef	_adr
5183                     	xdef	_adr_drv_stat
5184                     	xdef	_led_ind
5185                     	switch	.ubsct
5186  006c               _led_ind_cnt:
5187  006c 00            	ds.b	1
5188                     	xdef	_led_ind_cnt
5189  006d               _adc_plazma:
5190  006d 000000000000  	ds.b	10
5191                     	xdef	_adc_plazma
5192  0077               _adc_plazma_short:
5193  0077 0000          	ds.b	2
5194                     	xdef	_adc_plazma_short
5195  0079               _adc_cnt:
5196  0079 00            	ds.b	1
5197                     	xdef	_adc_cnt
5198  007a               _adc_ch:
5199  007a 00            	ds.b	1
5200                     	xdef	_adc_ch
5201                     	switch	.bss
5202  0005               _adc_buff_:
5203  0005 000000000000  	ds.b	20
5204                     	xdef	_adc_buff_
5205  0019               _adc_buff:
5206  0019 000000000000  	ds.b	320
5207                     	xdef	_adc_buff
5208                     	switch	.ubsct
5209  007b               _mess:
5210  007b 000000000000  	ds.b	14
5211                     	xdef	_mess
5212                     	switch	.bit
5213  0004               _b1Hz:
5214  0004 00            	ds.b	1
5215                     	xdef	_b1Hz
5216  0005               _b2Hz:
5217  0005 00            	ds.b	1
5218                     	xdef	_b2Hz
5219  0006               _b5Hz:
5220  0006 00            	ds.b	1
5221                     	xdef	_b5Hz
5222  0007               _b10Hz:
5223  0007 00            	ds.b	1
5224                     	xdef	_b10Hz
5225  0008               _b100Hz:
5226  0008 00            	ds.b	1
5227                     	xdef	_b100Hz
5228                     	xdef	_t0_cnt4
5229                     	xdef	_t0_cnt3
5230                     	xdef	_t0_cnt2
5231                     	xdef	_t0_cnt1
5232                     	xdef	_t0_cnt0
5233                     	xdef	_bVENT_BLOCK
5234                     	xref.b	c_lreg
5235                     	xref.b	c_x
5236                     	xref.b	c_y
5256                     	xref	c_ldiv
5257                     	xref	c_lgadd
5258                     	xref	c_itolx
5259                     	xref	c_ladd
5260                     	xref	c_umul
5261                     	xref	c_idiv
5262                     	xref	c_lcmp
5263                     	xref	c_ltor
5264                     	xref	c_lgadc
5265                     	xref	c_rtol
5266                     	xref	c_vmul
5267                     	xref	c_eewrw
5268                     	end
