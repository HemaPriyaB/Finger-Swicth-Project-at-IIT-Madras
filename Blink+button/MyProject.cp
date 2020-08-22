#line 1 "C:/Users/Priya/Desktop/buzzer_test/Blink+button/MyProject.c"
bit oldstate;
void interrupt()
{
if (TMR0IF_bit){
 TMR0IF_bit = 0;
 TMR0H = 0xFB;
 TMR0L = 0x1E;
 PORTC.F4=~PORTC.F4;
 }
}
void InitTimer0()
{
T0CON = 0x88;
TMR0H = 0xFB;
TMR0L = 0x1E;
GIE_bit = 1;
TMR0IE_bit = 0;
}
void main() {
 ANSEL = 0;
 ANSELH = 0;
 C1ON_bit = 0;
 C2ON_bit = 0;
 TRISB4_bit = 1;
 TRISC = 0x00;
 PORTC = 0x00;
 oldstate = 0;
 InitTimer0();
 do {
 delay_ms(2);
 if (Button(&PORTB, 4, 10, 1)) {
 TMR0IE_bit = 1;
 PORTC.F5 = 1;
 delay_ms(500);
 TMR0IE_bit = 0;
 PORTC.F5 = 0;
 }
 } while(1);
}
