
_interrupt:

;MyProject.c,2 :: 		void interrupt()
;MyProject.c,4 :: 		if (TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt0
;MyProject.c,5 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;MyProject.c,6 :: 		TMR0H         = 0xFB;
	MOVLW       251
	MOVWF       TMR0H+0 
;MyProject.c,7 :: 		TMR0L         = 0x1E;
	MOVLW       30
	MOVWF       TMR0L+0 
;MyProject.c,8 :: 		PORTC.F4=~PORTC.F4;
	BTG         PORTC+0, 4 
;MyProject.c,9 :: 		}
L_interrupt0:
;MyProject.c,10 :: 		}
L_end_interrupt:
L__interrupt8:
	RETFIE      1
; end of _interrupt

_InitTimer0:

;MyProject.c,11 :: 		void InitTimer0()
;MyProject.c,13 :: 		T0CON         = 0x88;
	MOVLW       136
	MOVWF       T0CON+0 
;MyProject.c,14 :: 		TMR0H         = 0xFB;
	MOVLW       251
	MOVWF       TMR0H+0 
;MyProject.c,15 :: 		TMR0L         = 0x1E;
	MOVLW       30
	MOVWF       TMR0L+0 
;MyProject.c,16 :: 		GIE_bit       = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;MyProject.c,17 :: 		TMR0IE_bit    = 0;
	BCF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;MyProject.c,18 :: 		}
L_end_InitTimer0:
	RETURN      0
; end of _InitTimer0

_main:

;MyProject.c,19 :: 		void main() {
;MyProject.c,20 :: 		ANSEL  = 0;                                    // Configure AN pins as digital I/O
	CLRF        ANSEL+0 
;MyProject.c,21 :: 		ANSELH = 0;
	CLRF        ANSELH+0 
;MyProject.c,22 :: 		C1ON_bit = 0;                                  // Disable comparators
	BCF         C1ON_bit+0, BitPos(C1ON_bit+0) 
;MyProject.c,23 :: 		C2ON_bit = 0;
	BCF         C2ON_bit+0, BitPos(C2ON_bit+0) 
;MyProject.c,24 :: 		TRISB4_bit = 1;                                // set RB0 pin as input
	BSF         TRISB4_bit+0, BitPos(TRISB4_bit+0) 
;MyProject.c,25 :: 		TRISC = 0x00;                                  // Configure PORTC as output
	CLRF        TRISC+0 
;MyProject.c,26 :: 		PORTC = 0x00;                                  // Initial PORTC value
	CLRF        PORTC+0 
;MyProject.c,27 :: 		oldstate = 0;
	BCF         _oldstate+0, BitPos(_oldstate+0) 
;MyProject.c,28 :: 		InitTimer0();
	CALL        _InitTimer0+0, 0
;MyProject.c,29 :: 		do {
L_main1:
;MyProject.c,30 :: 		delay_ms(2);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	NOP
	NOP
;MyProject.c,31 :: 		if (Button(&PORTB, 4, 10,  1)) {               // Detect logical one
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       4
	MOVWF       FARG_Button_pin+0 
	MOVLW       10
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
;MyProject.c,32 :: 		TMR0IE_bit         = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;MyProject.c,33 :: 		PORTC.F5 = 1;
	BSF         PORTC+0, 5 
;MyProject.c,34 :: 		delay_ms(500);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       175
	MOVWF       R12, 0
	MOVLW       182
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
;MyProject.c,35 :: 		TMR0IE_bit         = 0;
	BCF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;MyProject.c,36 :: 		PORTC.F5 = 0;
	BCF         PORTC+0, 5 
;MyProject.c,37 :: 		}
L_main5:
;MyProject.c,38 :: 		} while(1);                                    // Endless loop
	GOTO        L_main1
;MyProject.c,39 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
