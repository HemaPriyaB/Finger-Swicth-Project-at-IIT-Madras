
_interrupt:

;MyProject.c,7 :: 		void interrupt()
;MyProject.c,9 :: 		USB_Interrupt_Proc();
	CALL        _USB_Interrupt_Proc+0, 0
;MyProject.c,10 :: 		}
L_end_interrupt:
L__interrupt15:
	RETFIE      1
; end of _interrupt

_readMouse:

;MyProject.c,11 :: 		void readMouse(){
;MyProject.c,12 :: 		if (old_state!=curnt_state && PORTB.F4==1){
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
;MyProject.c,13 :: 		writebuff[0]=0x02;
	MOVLW       2
	MOVWF       648 
;MyProject.c,14 :: 		writebuff[1]=0x01;
	MOVLW       1
	MOVWF       649 
;MyProject.c,15 :: 		writebuff[2]=0;
	CLRF        650 
;MyProject.c,16 :: 		writebuff[3]=0;
	CLRF        651 
;MyProject.c,17 :: 		while(!HID_Write(&writebuff,4));
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
;MyProject.c,18 :: 		Delay_ms(500);
	MOVLW       8
	MOVWF       R11, 0
	MOVLW       157
	MOVWF       R12, 0
	MOVLW       5
	MOVWF       R13, 0
L_readMouse5:
	DECFSZ      R13, 1, 1
	BRA         L_readMouse5
	DECFSZ      R12, 1, 1
	BRA         L_readMouse5
	DECFSZ      R11, 1, 1
	BRA         L_readMouse5
	NOP
	NOP
;MyProject.c,19 :: 		writebuff[0]=0x02;
	MOVLW       2
	MOVWF       648 
;MyProject.c,20 :: 		writebuff[1]=0;
	CLRF        649 
;MyProject.c,21 :: 		writebuff[2]=0;
	CLRF        650 
;MyProject.c,22 :: 		writebuff[3]=0;
	CLRF        651 
;MyProject.c,23 :: 		while(!HID_Write(&writebuff,4));
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
;MyProject.c,24 :: 		old_state=curnt_state;
	MOVF        _curnt_state+0, 0 
	MOVWF       _old_state+0 
	MOVF        _curnt_state+1, 0 
	MOVWF       _old_state+1 
;MyProject.c,25 :: 		}
	GOTO        L_readMouse8
L_readMouse2:
;MyProject.c,26 :: 		else if( PORTB.F4==0)
	BTFSC       PORTB+0, 4 
	GOTO        L_readMouse9
;MyProject.c,28 :: 		old_state=0;
	CLRF        _old_state+0 
	CLRF        _old_state+1 
;MyProject.c,29 :: 		curnt_state=1;
	MOVLW       1
	MOVWF       _curnt_state+0 
	MOVLW       0
	MOVWF       _curnt_state+1 
;MyProject.c,30 :: 		}
L_readMouse9:
L_readMouse8:
;MyProject.c,31 :: 		}
L_end_readMouse:
	RETURN      0
; end of _readMouse

_Init_main:

;MyProject.c,32 :: 		void Init_main(){
;MyProject.c,33 :: 		ADCON1 |= 0x0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;MyProject.c,34 :: 		TRISB=0xFF;
	MOVLW       255
	MOVWF       TRISB+0 
;MyProject.c,35 :: 		PORTB=0X00;
	CLRF        PORTB+0 
;MyProject.c,36 :: 		HID_Enable(&readbuff,&writebuff);
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
;MyProject.c,37 :: 		}
L_end_Init_main:
	RETURN      0
; end of _Init_main

_main:

;MyProject.c,38 :: 		void main()
;MyProject.c,40 :: 		Init_main();
	CALL        _Init_main+0, 0
;MyProject.c,41 :: 		while(1){
L_main10:
;MyProject.c,42 :: 		readMouse();
	CALL        _readMouse+0, 0
;MyProject.c,43 :: 		Delay_ms(5);
	MOVLW       20
	MOVWF       R12, 0
	MOVLW       121
	MOVWF       R13, 0
L_main12:
	DECFSZ      R13, 1, 1
	BRA         L_main12
	DECFSZ      R12, 1, 1
	BRA         L_main12
	NOP
	NOP
;MyProject.c,44 :: 		}
	GOTO        L_main10
;MyProject.c,45 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
