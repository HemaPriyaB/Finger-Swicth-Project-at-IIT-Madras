
_interrupt:

;HID.c,7 :: 		void interrupt(){
;HID.c,8 :: 		USB_Interrupt_Proc();
	CALL        _USB_Interrupt_Proc+0, 0
;HID.c,9 :: 		}
L_end_interrupt:
L__interrupt10:
	RETFIE      1
; end of _interrupt

_main:

;HID.c,11 :: 		void main(void){
;HID.c,12 :: 		ANSEL = 0;
	CLRF        ANSEL+0 
;HID.c,13 :: 		ANSELH = 0;
	CLRF        ANSELH+0 
;HID.c,15 :: 		HID_Enable(&readbuff,&writebuff);
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
;HID.c,17 :: 		while(1){
L_main0:
;HID.c,18 :: 		while(!HID_Read())
L_main2:
	CALL        _HID_Read+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
;HID.c,19 :: 		;
	GOTO        L_main2
L_main3:
;HID.c,21 :: 		for(cnt=0;cnt<64;cnt++)
	CLRF        _cnt+0 
L_main4:
	MOVLW       64
	SUBWF       _cnt+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main5
;HID.c,22 :: 		writebuff[cnt]=readbuff[cnt];
	MOVLW       _writebuff+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FSR1H 
	MOVF        _cnt+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _readbuff+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FSR0H 
	MOVF        _cnt+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;HID.c,21 :: 		for(cnt=0;cnt<64;cnt++)
	INCF        _cnt+0, 1 
;HID.c,22 :: 		writebuff[cnt]=readbuff[cnt];
	GOTO        L_main4
L_main5:
;HID.c,24 :: 		while(!HID_Write(&writebuff,64))
L_main7:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
;HID.c,25 :: 		;
	GOTO        L_main7
L_main8:
;HID.c,26 :: 		}
	GOTO        L_main0
;HID.c,27 :: 		}//end main
L_end_main:
	GOTO        $+0
; end of _main
