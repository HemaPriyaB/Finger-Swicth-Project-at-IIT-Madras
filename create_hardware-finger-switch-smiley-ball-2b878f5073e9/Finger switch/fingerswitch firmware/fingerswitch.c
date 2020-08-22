//==============================================================================
/*
PIC 18F4550
20MHz Crystal
LEFT BUTTON-RB4
OUTPUT BUZZER-RD4
*/
unsigned char readbuff[64] absolute 0x200;      //readbuffer should be in RAM  (MCU specific)
unsigned char writebuff[64] absolute 0x240;     //writebuffer should be in RAM (MCU specific)

//=====================        MOUSE VARIABLES       ==========================
unsigned char buttons;
int old_state;
int curnt_state;
void interrupt()
{
     USB_Interrupt_Proc();        // USB servicing inside the interrupt
}
//#############################    M O U S E   #################################
 void readMouse(){
               if (old_state!=curnt_state && PORTB.F4==1){       //USB OUTPUT

               writebuff[0]=0x02;
               writebuff[1]=0x01;
               writebuff[2]=0;
               writebuff[3]=0;
               while(!HID_Write(&writebuff,4));    //Send Data
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
   //Send Data
              PORTC.F5=0;
              old_state=0;
              curnt_state=1;
              }

              }
//##############################################################################
void Init_main(){
  ADCON1 |= 0x0F;                         // Configure all ports with analog function as digital
  //CMCON  |= 7;                            // Disable comparators
       TRISB=0xFF;
        TRISC=0x00;               // Set inputs
       PORTB=0X00;                  //Initialize PORTS
        PORTC=0X00;
        HID_Enable(&readbuff,&writebuff);

}

//==============================================================================
void main()
{
        //Initialize ports
        Init_main();

//------------------------------------------------------------------------------
        while(1){  
              //MAIN LOOP
           readMouse();
           Delay_ms(5);

        }
}