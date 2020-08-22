#line 1 "C:/Users/Priya/Desktop/usb hid interfacing/MyProject.c"
unsigned char readbuff[8] absolute 0x280;
unsigned char writebuff[8] absolute 0x288;
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
 Delay_ms(500);
 writebuff[0]=0x02;
 writebuff[1]=0;
 writebuff[2]=0;
 writebuff[3]=0;
 while(!HID_Write(&writebuff,4));
 old_state=curnt_state;
 }
 else if( PORTB.F4==0)
 {
 old_state=0;
 curnt_state=1;
 }
 }
void Init_main(){
 ADCON1 |= 0x0F;
 TRISB=0xFF;
 PORTB=0X00;
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
