
_interrupt:

;fingerswitch.c,15 :: 		void interrupt()
;fingerswitch.c,17 :: 		USB_Interrupt_Proc();        // USB servicing inside the interrupt
	CALL        _USB_Interrupt_Proc+0, 0
;fingerswitch.c,18 :: 		}
L_end_interrupt:
L__interrupt15:
	RETFIE      1
; end of _interrupt

_readMouse:

;fingerswitch.c,20 :: 		void readMouse(){
;fingerswitch.c,21 :: 		if (old_state!=curnt_state && PORTB.F4==1){       //USB OUTPUT
	MOVF        _old_state+1, 0 
	XORWF       _curnt_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__readMouse17
	MOVF        _curnt_state+0, 0 
	XORWF       _old_state+0, 0 
L__readMouse17:
	BTFSC       STATUS+0, 2 
	GOTO        L_readMouse2
	BTFSS       PORTB+0, 4 
	GOTO        L_readMouse2
L__readMouse13:
;fingerswitch.c,23 :: 		writebuff[0]=0x02;
	MOVLW       2
	MOVWF       1344 
;fingerswitch.c,24 :: 		writebuff[1]=0x01;
	MOVLW       1
	MOVWF       1345 
;fingerswitch.c,25 :: 		writebuff[2]=0;
	CLRF        1346 
;fingerswitch.c,26 :: 		writebuff[3]=0;
	CLRF        1347 
;fingerswitch.c,27 :: 		while(!HID_Write(&writebuff,4));    //Send Data
L_readMouse3:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       4
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_readMouse4
	GOTO        L_readMouse3
L_readMouse4:
;fingerswitch.c,28 :: 		PORTD.F4=1;
	BSF         PORTD+0, 4 
;fingerswitch.c,29 :: 		Delay_ms(500);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       175
	MOVWF       R12, 0
	MOVLW       182
	MOVWF       R13, 0
L_readMouse5:
	DECFSZ      R13, 1, 1
	BRA         L_readMouse5
	DECFSZ      R12, 1, 1
	BRA         L_readMouse5
	DECFSZ      R11, 1, 1
	BRA         L_readMouse5
	NOP
;fingerswitch.c,30 :: 		PORTD.F4=0;
	BCF         PORTD+0, 4 
;fingerswitch.c,31 :: 		writebuff[0]=0x02;
	MOVLW       2
	MOVWF       1344 
;fingerswitch.c,32 :: 		writebuff[1]=0;
	CLRF        1345 
;fingerswitch.c,33 :: 		writebuff[2]=0;
	CLRF        1346 
;fingerswitch.c,34 :: 		writebuff[3]=0;
	CLRF        1347 
;fingerswitch.c,35 :: 		while(!HID_Write(&writebuff,4));
L_readMouse6:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       4
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_readMouse7
	GOTO        L_readMouse6
L_readMouse7:
;fingerswitch.c,36 :: 		old_state=curnt_state;
	MOVF        _curnt_state+0, 0 
	MOVWF       _old_state+0 
	MOVF        _curnt_state+1, 0 
	MOVWF       _old_state+1 
;fingerswitch.c,37 :: 		}
	GOTO        L_readMouse8
L_readMouse2:
;fingerswitch.c,38 :: 		else if( PORTB.F4==0)
	BTFSC       PORTB+0, 4 
	GOTO        L_readMouse9
;fingerswitch.c,41 :: 		PORTD.F4=0;
	BCF         PORTD+0, 4 
;fingerswitch.c,42 :: 		old_state=0;
	CLRF        _old_state+0 
	CLRF        _old_state+1 
;fingerswitch.c,43 :: 		curnt_state=1;
	MOVLW       1
	MOVWF       _curnt_state+0 
	MOVLW       0
	MOVWF       _curnt_state+1 
;fingerswitch.c,44 :: 		}
L_readMouse9:
L_readMouse8:
;fingerswitch.c,46 :: 		}
L_end_readMouse:
	RETURN      0
; end of _readMouse

_Init_main:

;fingerswitch.c,48 :: 		void Init_main(){
;fingerswitch.c,49 :: 		ADCON1 |= 0x0F;                         // Configure all ports with analog function as digital
	MOVLW       15
	IORWF       ADCON1+0, 1 
;fingerswitch.c,50 :: 		CMCON  |= 7;                            // Disable comparators
	MOVLW       7
	IORWF       CMCON+0, 1 
;fingerswitch.c,51 :: 		TRISB=0xFF;
	MOVLW       255
	MOVWF       TRISB+0 
;fingerswitch.c,52 :: 		TRISD=0x00;               // Set inputs
	CLRF        TRISD+0 
;fingerswitch.c,53 :: 		PORTB=0X00;                  //Initialize PORTS
	CLRF        PORTB+0 
;fingerswitch.c,54 :: 		PORTD=0X00;
	CLRF        PORTD+0 
;fingerswitch.c,55 :: 		HID_Enable(&readbuff,&writebuff);
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
;fingerswitch.c,57 :: 		}
L_end_Init_main:
	RETURN      0
; end of _Init_main

_main:

;fingerswitch.c,60 :: 		void main()
;fingerswitch.c,63 :: 		Init_main();
	CALL        _Init_main+0, 0
;fingerswitch.c,66 :: 		while(1){
L_main10:
;fingerswitch.c,68 :: 		readMouse();
	CALL        _readMouse+0, 0
;fingerswitch.c,69 :: 		Delay_ms(5);
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       118
	MOVWF       R13, 0
L_main12:
	DECFSZ      R13, 1, 1
	BRA         L_main12
	DECFSZ      R12, 1, 1
	BRA         L_main12
	NOP
;fingerswitch.c,71 :: 		}
	GOTO        L_main10
;fingerswitch.c,72 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
