//¬етка основна€, дл€ первой платочки FAT42.

//#define _24_
char bVENT_BLOCK=0;


#include "string.h"
#include <iostm8.h>
//#include <iostm8s103.h>
#include "stm8s.h"
//#include "main.h"
short t0_cnt0=0;
char t0_cnt1=0,t0_cnt2=0,t0_cnt3=0,t0_cnt4=0;
_Bool b100Hz, b10Hz, b5Hz, b2Hz, b1Hz;



char adc_ch,adc_cnt;
signed short adc_plazma_short,adc_plazma[5];

#define ON 0x55
#define OFF 0xaa


char off_bp_cnt;
signed short main_cnt, main_cnt1;

//ќтладка
signed short rotor_int=123;
signed short plazma_int[3];


_Bool bMAIN;
char cnt_net_drv;

char i_main_num_of_bps;
signed short i_main_sigma;

char buffer_for_timer1_H;
char buffer_for_timer1_L;

//-----------------------------------------------
void gran(signed short *adr, signed short min, signed short max)
{
if (*adr<min) *adr=min;
if (*adr>max) *adr=max; 
} 

//-----------------------------------------------
void granee(@eeprom signed short *adr, signed short min, signed short max)
{
if (*adr<min) *adr=min;
if (*adr>max) *adr=max; 
}

//-----------------------------------------------
long delay_ms(short in)
{
long i,ii,iii;

i=((long)in)*100UL;

for(ii=0;ii<i;ii++)
	{
		iii++;
	}

}

//-----------------------------------------------
void t4_init(void){
	TIM4->PSCR = 4;
	TIM4->ARR= 77;
	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
	
	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
	
}


//-----------------------------------------------
void led_drv(void)
{
} 




//-----------------------------------------------
//¬оздействие на силу
//5Hz
void pwr_drv(void)
{

//pwm_u=1000;
//pwm_i=1000;

//GPIOB->ODR|=(1<<3);

//pwm_u=300;
//vent_pwm=600;


//pwm_u=1050-adc_buff_[0];

//if(pwm_u>1020)pwm_u=1020;
//pwm_i=adc_buff_[0];
//vent_pwm=100;

/*
TIM1->CCR2H= (char)(pwm_u/256);	
TIM1->CCR2L= (char)pwm_u;

TIM1->CCR1H= (char)(pwm_i/256);	
TIM1->CCR1L= (char)pwm_i;

TIM1->CCR3H= (char)(vent_pwm/256);	
TIM1->CCR3L= (char)vent_pwm;*/
}

//-----------------------------------------------
//¬ычисление воздействий на силу
//10Hz
void pwr_hndl(void)				
{

}

//-----------------------------------------------
void matemat(void)
{


}




/* -------------------------------------------------------------------------- */
void adr_drv_v3(void)
{
#define ADR_CONST_0	574
#define ADR_CONST_1	897
#define ADR_CONST_2	695
#define ADR_CONST_3	1015

GPIOB->DDR&=~(1<<0);
GPIOB->CR1&=~(1<<0);
GPIOB->CR2&=~(1<<0);
ADC2->CR2=0x08;
ADC2->CR1=0x40;
ADC2->CSR=0x20+0;
ADC2->CR1|=1;
ADC2->CR1|=1;
//adr_drv_stat=1;
//while(adr_drv_stat==1);

GPIOB->DDR&=~(1<<1);
GPIOB->CR1&=~(1<<1);
GPIOB->CR2&=~(1<<1);
ADC2->CR2=0x08;
ADC2->CR1=0x40;
ADC2->CSR=0x20+1;
ADC2->CR1|=1;
ADC2->CR1|=1;
//adr_drv_stat=3;
//while(adr_drv_stat==3);

GPIOE->DDR&=~(1<<6);
GPIOE->CR1&=~(1<<6);
GPIOE->CR2&=~(1<<6);
ADC2->CR2=0x08;
ADC2->CR1=0x40;
ADC2->CSR=0x20+9;
ADC2->CR1|=1;
ADC2->CR1|=1;
//adr_drv_stat=5;
//while(adr_drv_stat==5);

}




//-----------------------------------------------
void exti_init(void){
EXTI->CR1=0x40;	
GPIOD->DDR&=~(1<<4);
GPIOD->CR1&=~(1<<4);
GPIOD->CR2|=(1<<4);	
	
}

//-----------------------------------------------
void t1_init(void)
{
TIM1->ARRH= 0;
TIM1->ARRL= 100;
TIM1->CCR1H= 0x00;	
TIM1->CCR1L= 0xff;
TIM1->CCR2H= 0;	
TIM1->CCR2L= 25;
TIM1->CCR3H= 0x00;	
TIM1->CCR3L= 0x64;

TIM1->PSCRH= 0;	
TIM1->PSCRL= 15;

TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
TIM1->BKR|= TIM1_BKR_AOE;
}


#define AUTORELOAD2	8000000*100/18500
//-----------------------------------------------
void t2_init_(void){
	TIM2->PSCR = 4;
	TIM2->ARRH= 20;
	TIM2->ARRL= 0;
	TIM2->CCR1H= 10;	
	TIM2->CCR1L= 0;
	
	//TIM2->CCMR1= ((6<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
	///TIM2->CCMR2= ((7<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
	///TIM2->CCMR3= ((7<<4) & TIM2_CCMR_OCM) | TIM2_CCMR_OCxPE; //OC2 toggle mode, prelouded
	/*TIM2->CCER2= TIM2_CCER2_CC3E | TIM2_CCER2_CC3P; //OC1, OC2 output pins enabled*/
	//TIM2->CCER1= TIM2_CCER1_CC1E; //OC1, OC2 output pins enabled
	///TIM2->CCER2= TIM2_CCER2_CC3E | TIM2_CCER2_CC3P; //OC1, OC2 output pins enabled
	
	TIM2->CR1=(TIM2_CR1_CEN /*| TIM2_CR1_ARPE*/);	
	
}


//-----------------------------------------------
void t3_init_(void){
	TIM3->PSCR = 16;
	TIM3->ARRH= 120;
	TIM3->ARRL= 0;
	TIM3->CCR1H= 10;	
	TIM3->CCR1L= 0;
	
	
	
	TIM3->CR1=(TIM3_CR1_CEN | TIM3_CR1_ARPE);	
	
}




//-----------------------------------------------
void t2_init(void)
{
//TIM1->ARRH= 0xa9;
//TIM1->ARRL= 0xf6;
//TIM1->CCR1H= 0x00;	
//TIM1->CCR1L= 0xff;
//TIM1->CCR2H= 0x04;	
//TIM1->CCR2L= 0xfb;
//TIM1->CCR3H= 0x00;	
//TIM1->CCR3L= 0x64;

//TIM2->PSCRH= 0x00;	
TIM2->PSCR= 0x01;

//TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
//TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
//TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
//TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
//TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
TIM2->CR1=(TIM2_CR1_CEN | TIM2_CR1_ARPE);
//TIM1->BKR|= TIM1_BKR_AOE;
}

//-----------------------------------------------
void adc2_init(void)
{
adc_plazma[0]++;


GPIOB->DDR&=~(1<<0);
GPIOB->CR1&=~(1<<0);
GPIOB->CR2&=~(1<<0);

GPIOB->DDR&=~(1<<1);
GPIOB->CR1&=~(1<<1);
GPIOB->CR2&=~(1<<1);

GPIOE->DDR&=~(1<<6);
GPIOE->CR1&=~(1<<6);
GPIOE->CR2&=~(1<<6);

GPIOB->DDR&=~(1<<4);
GPIOB->CR1&=~(1<<4);
GPIOB->CR2&=~(1<<4);

GPIOB->DDR&=~(1<<5);
GPIOB->CR1&=~(1<<5);
GPIOB->CR2&=~(1<<5);

GPIOB->DDR&=~(1<<6);
GPIOB->CR1&=~(1<<6);
GPIOB->CR2&=~(1<<6);

GPIOB->DDR&=~(1<<7);
GPIOB->CR1&=~(1<<7);
GPIOB->CR2&=~(1<<7);

ADC2->TDRL=0xff;
	
ADC2->CR2=0x08;
ADC2->CR1=0x40;

{
	ADC2->CSR=0x20;
	
	ADC2->CR1|=1;
	ADC2->CR1|=1;
	}
}




//***********************************************
//***********************************************
//***********************************************
//***********************************************
@far @interrupt void TIM4_UPD_Interrupt (void) 
{
TIM4->SR1&=~TIM4_SR1_UIF;

if(++t0_cnt0>=100)
	{
	t0_cnt0=0;
	b100Hz=1;

	if(++t0_cnt1>=10)
		{
		t0_cnt1=0;
		b10Hz=1;
		}
		
	if(++t0_cnt2>=20)
		{
		t0_cnt2=0;
		b5Hz=1;

		}
		
	if(++t0_cnt4>=50)
		{
		t0_cnt4=0;
		b2Hz=1;
		}
		
	if(++t0_cnt3>=100)
		{
		t0_cnt3=0;
		b1Hz=1;
		}
	}

			// disable break interrupt
//GPIOA->ODR&=~(1<<4);	
}


//***********************************************
@far @interrupt void ADC2_EOC_Interrupt (void) {

signed long temp_adc;


ADC2->CSR&=~(1<<7);

temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));


adc_ch=0;
adc_cnt++;
if(adc_cnt>=16)
	{
	adc_cnt=0;
	}

if((adc_cnt&0x03)==0)
	{
	signed long tempSS;
	char i;
	tempSS=0;
	for(i=0;i<16;i++)
		{
		
		}
	}
	
//adc_buff_[adc_ch]=temp_adc;
}

//***********************************************
@far @interrupt void PortD_Ext_Interrupt (void) {

//GPIOC->ODR^=(1<<2);
GPIOA->ODR^=(1<<5);


buffer_for_timer1_H=TIM2->CNTRH;
buffer_for_timer1_L=TIM2->CNTRL;

TIM2->CNTRH=0;
TIM2->CNTRL=0;

}

//===============================================
//===============================================
//===============================================
//===============================================

main()
{

CLK->ECKR|=1;
while((CLK->ECKR & 2) == 0);
CLK->SWCR|=2;
CLK->SWR=0xB4;

//delay_ms(200);
FLASH->DUKR=0xae;
FLASH->DUKR=0x56;

exti_init();

enableInterrupts();


//adr_drv_v3();
//adr_drv_v4(1);


t4_init();

		GPIOG->DDR|=(1<<0);
		GPIOG->CR1|=(1<<0);
		GPIOG->CR2&=~(1<<0);	
		//GPIOG->ODR^=(1<<0);

		GPIOG->DDR&=~(1<<1);
		GPIOG->CR1|=(1<<1);
		GPIOG->CR2&=~(1<<1);

//adc2_init();

//CAN->DGR&=0xfc;

GPIOC->DDR|=(1<<1);
GPIOC->CR1|=(1<<1);
GPIOC->CR2|=(1<<1);

GPIOC->DDR|=(1<<2);
GPIOC->CR1|=(1<<2);
GPIOC->CR2|=(1<<2);

/*
GPIOB->DDR|=(1<<2);
GPIOB->CR1|=(1<<2);
GPIOB->CR2|=(1<<2);
*/
t1_init();
t2_init_();

GPIOA->DDR|=(1<<5);
GPIOA->CR1|=(1<<5);
GPIOA->CR2&=~(1<<5);

GPIOA->DDR|=(1<<6);
GPIOA->CR1|=(1<<6);
GPIOA->CR2&=~(1<<6);
/*
GPIOB->DDR|=(1<<2);
GPIOB->CR1|=(1<<2);
GPIOB->CR2&=~(1<<2);
*/
GPIOB->DDR&=~(1<<3);
GPIOB->CR1&=~(1<<3);
GPIOB->CR2&=~(1<<3);

GPIOC->DDR|=(1<<3);
GPIOC->CR1|=(1<<3);
GPIOC->CR2|=(1<<3);

//GPIOC->ODR|=(1<<1);//exti_init();


while (1)
	{

	
	
if(b100Hz)
		{
		b100Hz=0;
		
		
		
      	}  
      	
	if(b10Hz)
		{
		b10Hz=0;
		
		//buffer_for_timer1_H=118;
        //matemat();
	    //led_drv(); 
		//pwr_hndl();		//вычисление воздействий на силу
		TIM1->ARRH=0x68;//buffer_for_timer1_H;
		TIM1->ARRL=0x2a;//buffer_for_timer1_L;
		TIM1->CCR2H=0x34;//buffer_for_timer1_H>>1;	
		TIM1->CCR2L=0;
      	}

	if(b5Hz)
		{
		b5Hz=0;
		//if(EXTI_CR1==0)
		//pwr_drv();		//воздействие на силу
		if((TIM2->CNTRL))GPIOA->ODR^=(1<<6);
      	}
      	
	if(b2Hz)
		{
		b2Hz=0;
		
		}
      	
	if(b1Hz)
		{
		b1Hz=0;

		if(main_cnt<1000)main_cnt++;
		}

	}
}