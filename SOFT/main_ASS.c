//Ветка основная, для первой платочки FAT42.

//#define _24_
char bVENT_BLOCK=0;

#define BLOCK_INIT  GPIOB->DDR|=(1<<2);GPIOB->CR1|=(1<<2);GPIOB->CR2&=~(1<<2);
#define BLOCK_ON 	{GPIOB->ODR|=(1<<2);bVENT_BLOCK=1;}
#define BLOCK_OFF 	{GPIOB->ODR&=~(1<<2);bVENT_BLOCK=0;}
#define BLOCK_IS_ON (GPIOB->ODR&(1<<2))

#include "string.h"
//#include <iostm8s208.h>
#include <iostm8s103.h>
#include "stm8s.h"
//#include "main.h"
short t0_cnt0=0;
char t0_cnt1=0,t0_cnt2=0,t0_cnt3=0,t0_cnt4=0;
_Bool b100Hz, b10Hz, b5Hz, b2Hz, b1Hz;

u8 mess[14];

@near signed short adc_buff[10][16],adc_buff_[10];
char adc_ch,adc_cnt;
signed short adc_plazma_short,adc_plazma[5];
char led_ind_cnt;
char led_ind=5;
char adr_drv_stat=0;
@near char adr[3],adress;
@near char adress_error;



#define BPS_MESS_STID	0x018e
#define BPS_MESS_STID_MASK	0x03ff
#define UKU_MESS_STID	0x009e
#define UKU_MESS_STID_MASK	0x03ff

#define XMAX 		25

#define CMND		0x16
#define MEM_KF 	0x62 
#define MEM_KF1 	0x26
#define MEM_KF4 	0x29
#define MEM_KF2 	0x27
#define ALRM_RES 	0x63
#define GETID 		0x90
#define PUTID 		0x91
#define PUTTM1 	0xDA
#define PUTTM2 	0xDB
#define PUTTM 		0xDE
#define GETTM 		0xED 
#define KLBR 		0xEE

#define ON 0x55
#define OFF 0xaa


signed short I,Un,Ui,Udb;
signed char T;
@eeprom signed short ee_K[4][2];


signed short umax_cnt,umin_cnt;
char link,link_cnt;

char flags=0; // байт аварийных и др. флагов
// 0 -  anee iaao a?aiia? oi 0, anee iao oi 1
// 1 -  авария по Tmax (1-авария);
// 2 -  авария по Tsign (1-авария);
// 3 -  авария по Umax (1-авария);
// 4 -  авария по Umin (1-авария);
// 5 -  внешняя блокровка (1-заблокировано); 
// 6 -  внешняя блокировка срабатывания аварий (1-заблокировано);

//Телеуправление
char flags_tu; // oi?aaey?uaa neiai io oinoa
// 0 -  aeiee?iaea, anee 1 oi caaeiee?iaaou 
// 1 -  aeiee?iaea ecaia caueo(1-aeoeai.); 
signed short _x_,_x__; 
int _x_cnt;
@eeprom signed _x_ee_;
unsigned short vol_u_temp;
unsigned short vol_i_temp;
char flags_tu_cnt_on,flags_tu_cnt_off;

//Работа источника

char off_bp_cnt;
signed short main_cnt, main_cnt1;

@eeprom signed short ee_TZAS;
@eeprom signed short ee_Umax;
@eeprom signed short ee_dU;
@eeprom signed short ee_tmax;
@eeprom signed short ee_tsign;
@eeprom signed short ee_U_AVT;

signed short tsign_cnt,tmax_cnt; 

signed short pwm_u=200,pwm_i=50;
enum {jp0,jp1,jp2,jp3} jp_mode;
char cnt_JP0,cnt_JP1;
_Bool bBL;
_Bool bBL_IPS=0;
char apv_cnt[3];
int apv_cnt_;
_Bool bAPV;
char cnt_apv_off;

//Управление пересбросом
@eeprom char res_fl,res_fl_;
char bRES=0;
char bRES_=0; 
char res_fl_cnt;

//Управление светодиодами
long led_red=0x00000000L;
long led_green=0x03030303L;
char led_drv_cnt=30;
long led_red_buff;
long led_green_buff;

//Отладка
signed short rotor_int=123;
signed short plazma_int[3];


_Bool bMAIN;
char cnt_net_drv;

@eeprom int UU_AVT;
signed short volum_u_main_=700;
signed short x[6];
signed short i_main[6];
char i_main_flag[6];
signed short i_main_avg;
char i_main_num_of_bps;
signed short i_main_sigma;
char i_main_bps_cnt[6];

@eeprom int ee_AVT_MODE;			//какой-то переключатель, переключается последним байтом в посылке с MEM_KF
@eeprom signed short ee_DEVICE;	//переключатель, переключается MEM_KF4 или MEM_KF1, MEM_KF4 устанавливает его в 1
							// и означает что это БПС неибэпный, включается и выключается только по команде,
							//никакие TZAS, U_AVT не работают 


char pwm_vent_cnt;
char pwm_stat;

//short vent_pos;
short vent_pwm;
enum {bpsIBEP,bpsIPS} bps_class;
@eeprom short ee_IMAXVENT;

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
void led_drv(void)
{
} 




//-----------------------------------------------
//Воздействие на силу
//5Hz
void pwr_drv(void)
{

//pwm_u=1000;
//pwm_i=1000;

//GPIOB->ODR|=(1<<3);

//pwm_u=300;
//vent_pwm=600;


pwm_u=1050-adc_buff_[0];

if(pwm_u>1020)pwm_u=1020;
pwm_i=adc_buff_[0];
//vent_pwm=100;


TIM1->CCR2H= (char)(pwm_u/256);	
TIM1->CCR2L= (char)pwm_u;

TIM1->CCR1H= (char)(pwm_i/256);	
TIM1->CCR1L= (char)pwm_i;

TIM1->CCR3H= (char)(vent_pwm/256);	
TIM1->CCR3L= (char)vent_pwm;
}

//-----------------------------------------------
//Вычисление воздействий на силу
//10Hz
void pwr_hndl(void)				
{

}

//-----------------------------------------------
void matemat(void)
{


}


/* -------------------------------------------------------------------------- */
/*void adr_drv(void)
{
//#define ADR_CONST_0	445
//#define ADR_CONST_1	696
//#define ADR_CONST_2	537
//#define ADR_CONST_3	1015

GPIOB->DDR&=~(1<<0);
GPIOB->CR1&=~(1<<0);
GPIOB->CR2&=~(1<<0);
ADC2->CR2=0x08;
ADC2->CR1=0x40;
ADC2->CSR=0x20+0;
ADC2->CR1|=1;
ADC2->CR1|=1;
adr_drv_stat=1;
while(adr_drv_stat==1);

GPIOB->DDR&=~(1<<1);
GPIOB->CR1&=~(1<<1);
GPIOB->CR2&=~(1<<1);
ADC2->CR2=0x08;
ADC2->CR1=0x40;
ADC2->CSR=0x20+1;
ADC2->CR1|=1;
ADC2->CR1|=1;
adr_drv_stat=3;
while(adr_drv_stat==3);

GPIOE->DDR&=~(1<<6);
GPIOE->CR1&=~(1<<6);
GPIOE->CR2&=~(1<<6);
ADC2->CR2=0x08;
ADC2->CR1=0x40;
ADC2->CSR=0x20+9;
ADC2->CR1|=1;
ADC2->CR1|=1;
adr_drv_stat=5;
while(adr_drv_stat==5);



if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
else adr[0]=5;

if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
else adr[1]=5;

if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
else adr[2]=5;

if((adr[0]==5)||(adr[0]==5)||(adr[0]==5))adress=100;
else adress = adr[0] + (adr[1]*4) + (adr[2]*16);

//adress=1;
}*/

/* -------------------------------------------------------------------------- */
/*void adr_drv_v2(void)
{
#define ADR_CONST_0	635
#define ADR_CONST_1	995
#define ADR_CONST_2	767
#define ADR_CONST_3	1015

GPIOB->DDR&=~(1<<0);
GPIOB->CR1&=~(1<<0);
GPIOB->CR2&=~(1<<0);
ADC2->CR2=0x08;
ADC2->CR1=0x40;
ADC2->CSR=0x20+0;
ADC2->CR1|=1;
ADC2->CR1|=1;
adr_drv_stat=1;
while(adr_drv_stat==1);

GPIOB->DDR&=~(1<<1);
GPIOB->CR1&=~(1<<1);
GPIOB->CR2&=~(1<<1);
ADC2->CR2=0x08;
ADC2->CR1=0x40;
ADC2->CSR=0x20+1;
ADC2->CR1|=1;
ADC2->CR1|=1;
adr_drv_stat=3;
while(adr_drv_stat==3);

GPIOE->DDR&=~(1<<6);
GPIOE->CR1&=~(1<<6);
GPIOE->CR2&=~(1<<6);
ADC2->CR2=0x08;
ADC2->CR1=0x40;
ADC2->CSR=0x20+9;
ADC2->CR1|=1;
ADC2->CR1|=1;
adr_drv_stat=5;
while(adr_drv_stat==5);



if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
else adr[0]=5;

if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
else adr[1]=5;

if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
else adr[2]=5;

if((adr[0]==5)||(adr[0]==5)||(adr[0]==5))adress=100;
else adress = adr[0] + (adr[1]*4) + (adr[2]*16);

//adress=1;
}*/

/* -------------------------------------------------------------------------- */
void adr_drv_v4(char in)
{
if(adress!=in)adress=in;
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
adr_drv_stat=1;
while(adr_drv_stat==1);

GPIOB->DDR&=~(1<<1);
GPIOB->CR1&=~(1<<1);
GPIOB->CR2&=~(1<<1);
ADC2->CR2=0x08;
ADC2->CR1=0x40;
ADC2->CSR=0x20+1;
ADC2->CR1|=1;
ADC2->CR1|=1;
adr_drv_stat=3;
while(adr_drv_stat==3);

GPIOE->DDR&=~(1<<6);
GPIOE->CR1&=~(1<<6);
GPIOE->CR2&=~(1<<6);
ADC2->CR2=0x08;
ADC2->CR1=0x40;
ADC2->CSR=0x20+9;
ADC2->CR1|=1;
ADC2->CR1|=1;
adr_drv_stat=5;
while(adr_drv_stat==5);



if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
else adr[0]=5;

if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
else adr[1]=5;

if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
else adr[2]=5;

//adr[0]=5;

if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
	{
	//adress=100;
	adress_error=1;
	}
else 
	{
	if(adr[2]&0x02) bps_class=bpsIPS;
	else bps_class=bpsIBEP;

	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
	}

//adress=1;
}




//-----------------------------------------------
void t4_init(void){
	TIM4->PSCR = 4;
	TIM4->ARR= 77;
	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
	
	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
	
}

//-----------------------------------------------
void t1_init(void)
{
TIM1->ARRH= 0xa9;
TIM1->ARRL= 0xf6;
TIM1->CCR1H= 0x00;	
TIM1->CCR1L= 0xff;
TIM1->CCR2H= 0x54;	
TIM1->CCR2L= 0xfb;
TIM1->CCR3H= 0x00;	
TIM1->CCR3L= 0x64;

TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
TIM1->BKR|= TIM1_BKR_AOE;
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

if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
GPIOB->ODR|=(1<<3);
if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);

//GPIOB->ODR|=(1<<3);


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

adc_buff[adc_ch][adc_cnt]=temp_adc;

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
		tempSS+=(signed long)adc_buff[0][i];
		}
	adc_buff_[0]=(signed short)(tempSS/10);
	}
	
//adc_buff_[adc_ch]=temp_adc;
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

delay_ms(200);
FLASH_DUKR=0xae;
FLASH_DUKR=0x56;
enableInterrupts();


//adr_drv_v3();
//adr_drv_v4(1);


//t4_init();

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

GPIOA->DDR|=(1<<5);
GPIOA->CR1|=(1<<5);
GPIOA->CR2&=~(1<<5);
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


while (1)
	{

	
	
if(b100Hz)
		{
		b100Hz=0;

		//adc2_init();
      	}  
      	
	if(b10Hz)
		{
		b10Hz=0;
		
        //matemat();
	    //led_drv(); 
		//pwr_hndl();		//вычисление воздействий на силу
      	}

	if(b5Hz)
		{
		b5Hz=0;
		
		//pwr_drv();		//воздействие на силу
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