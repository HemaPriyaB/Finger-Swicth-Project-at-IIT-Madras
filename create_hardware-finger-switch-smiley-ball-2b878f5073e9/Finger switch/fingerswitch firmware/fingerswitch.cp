#line 1 "C:/Users/Priya/Desktop/Finger Switch/create_hardware-finger-switch-smiley-ball-2b878f5073e9/Finger switch/fingerswitch firmware/fingerswitch.c"
#line 8 "C:/Users/Priya/Desktop/Finger Switch/create_hardware-finger-switch-smiley-ball-2b878f5073e9/Finger switch/fingerswitch firmware/fingerswitch.c"
unsigned char readbuff[64] absolute 0x200;
unsigned char writebuff[64] absolute 0x240;


unsigned char buttons;
int old_state;
int curnt_state;
void interrupt()
{
 USB_Interrupt_Proc();
}

 void readMouse(){
 if (old_state!=curnt_state && PORTB.F4==1){

 writebuff[0]=0x02;
 writebuff[1]=0x01;
 writebuff[2]=0;
 writebuff[3]=0;
 while(!HID_Write(&writebuff,4));
 PORTB.F4=1;
 Delay_ms(500);
 PORTC.F5=0;
 writebuff[0]=0x02;
 writebuff[1]=0;
 writebuff[2]=0;
 writebuff[3]=0;
 while(!HID_Write(&writebuff,4));
 old_state=curnt_state;
 }
 else if( PORTB.F4==0)
 {

 PORTC.F5=0;
 old_state=0;
 curnt_state=1;
 }

 }

void Init_main(){
 ADCON1 |= 0x0F;

 TRISB=0xFF;
 TRISC=0x00;
 PORTB=0X00;
 PORTC=0X00;
 HID_Enable(&readbuff,&writebuff);

}


void main()
{

 Init_main();


 while(1){

 readMouse();
 Delay_ms(5);

 }
}
