#line 1 "C:/Users/Priya/Desktop/13k50/HIDgen_interrupt/HID.c"
unsigned char readbuff[64] absolute 0x280;
unsigned char writebuff[64] absolute 0x2C0;

char cnt;
char kk;

void interrupt(){
 USB_Interrupt_Proc();
}

void main(void){
 ANSEL = 0;
 ANSELH = 0;

 HID_Enable(&readbuff,&writebuff);

 while(1){
 while(!HID_Read())
 ;

 for(cnt=0;cnt<64;cnt++)
 writebuff[cnt]=readbuff[cnt];

 while(!HID_Write(&writebuff,64))
 ;
 }
}
