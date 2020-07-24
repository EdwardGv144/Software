/*******************************************************
This program was created by the CodeWizardAVR V3.42 
Automatic Program Generator
© Copyright 1998-2020 Pavel Haiduc, HP InfoTech S.R.L.
http://www.hpinfotech.ro

Project : 
Version : 
Date    : 7/22/2020
Author  : 
Company : 
Comments: 


Chip type               : ATmega32U4
Program type            : Application
AVR Core Clock frequency: 16.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 640
*******************************************************/

#include <mega32u4.h>

// TWI functions
#include <twi.h>

// Alphanumeric LCD functions for TWI
#include <alcd_twi.h>

// SPI functions
#include <spi.h>

// Declare your global variables here

#include <delay.h>

// Declare your global variables here

// Voltage Reference: AVCC pin
#define ADC_VREF_TYPE ((0<<REFS1) | (1<<REFS0) | (1<<ADLAR))

// Read the 8 most significant bits
// of the AD conversion result
unsigned char read_adc(unsigned char adc_input)
{
ADMUX=(adc_input & 0x1f) | ADC_VREF_TYPE;
if (adc_input & 0x20) ADCSRB|=(1<<MUX5);
else ADCSRB&= ~(1<<MUX5);
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=(1<<ADSC);
// Wait for the AD conversion to complete
while ((ADCSRA & (1<<ADIF))==0);
ADCSRA|=(1<<ADIF);
return ADCH;
}

void main(void)
{
// Declare your local variables here

// Crystal Oscillator division factor: 1
#pragma optsize-
CLKPR=(1<<CLKPCE);
CLKPR=(0<<CLKPCE) | (0<<CLKPS3) | (0<<CLKPS2) | (0<<CLKPS1) | (0<<CLKPS0);
#ifdef _OPTIMIZE_SIZE_
#pragma optsize+
#endif

// Input/Output Ports initialization
// Port B initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=Out Bit2=In Bit1=In Bit0=In 
DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (1<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=0 Bit2=T Bit1=T Bit0=T 
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

// Port C initialization
// Function: Bit7=In Bit6=In 
DDRC=(0<<DDC7) | (0<<DDC6);
// State: Bit7=T Bit6=T 
PORTC=(0<<PORTC7) | (0<<PORTC6);

// Port D initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);

// Port E initialization
// Function: Bit6=In Bit2=In 
DDRE=(0<<DDE6) | (0<<DDE2);
// State: Bit6=T Bit2=T 
PORTE=(0<<PORTE6) | (0<<PORTE2);

// Port F initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit1=In Bit0=In 
DDRF=(0<<DDF7) | (0<<DDF6) | (0<<DDF5) | (0<<DDF4) | (0<<DDF1) | (0<<DDF0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit1=T Bit0=T 
PORTF=(0<<PORTF7) | (0<<PORTF6) | (0<<PORTF5) | (0<<PORTF4) | (0<<PORTF1) | (0<<PORTF0);

PLLCSR=(0<<PINDIV) | (0<<PLLE) | (0<<PLOCK);
PLLFRQ=(0<<PINMUX) | (0<<PLLUSB) | (0<<PLLTM1) | (0<<PLLTM0) | (0<<PDIV3) | (0<<PDIV2) | (0<<PDIV1) | (0<<PDIV0);

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=0xFF
// OC0A output: Disconnected
// OC0B output: Disconnected
TCCR0A=(0<<COM0A1) | (0<<COM0A0) | (0<<COM0B1) | (0<<COM0B0) | (0<<WGM01) | (0<<WGM00);
TCCR0B=(0<<WGM02) | (0<<CS02) | (0<<CS01) | (0<<CS00);
TCNT0=0x00;
OCR0A=0x00;
OCR0B=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer1 Stopped
// Mode: Normal top=0xFFFF
// OC1A output: Disconnected
// OC1B output: Disconnected
// OC1C output: Disconnected
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<COM1C1) | (0<<COM1C0) | (0<<WGM11) | (0<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;
OCR1CH=0x00;
OCR1CL=0x00;

// Timer/Counter 3 initialization
// Clock source: System Clock
// Clock value: Timer3 Stopped
// Mode: Normal top=0xFFFF
// OC3A output: Disconnected
// OC3B output: Disconnected
// OC3C output: Disconnected
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer3 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR3A=(0<<COM3A1) | (0<<COM3A0) | (0<<COM3B1) | (0<<COM3B0) | (0<<COM3C1) | (0<<COM3C0) | (0<<WGM31) | (0<<WGM30);
TCCR3B=(0<<ICNC3) | (0<<ICES3) | (0<<WGM33) | (0<<WGM32) | (0<<CS32) | (0<<CS31) | (0<<CS30);
TCNT3H=0x00;
TCNT3L=0x00;
ICR3H=0x00;
ICR3L=0x00;
OCR3AH=0x00;
OCR3AL=0x00;
OCR3BH=0x00;
OCR3BL=0x00;
OCR3CH=0x00;
OCR3CL=0x00;

// Timer/Counter 4 initialization
// Clock: Timer4 Stopped
// Mode: Normal top=OCR4C
// OC4A output: OC4A=Disc. /OC4A=Disc.
// OC4B output: OC4B=Disc. /OC4B=Disc.
// OC4D output: OC4D=Disc. /OC4D=Disc.
// Fault Protection: Off
// Fault Protection Noise Canceler: Off
// Fault Protection triggered on Falling Edge
// Timer4 Overflow Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare D Match Interrupt: Off
// Fault Protection Interrupt: Off
// Dead Time Prescaler: 1
// Dead Time Rising Edge: 0.000 us
// Dead Time Falling Edge: 0.000 us

// Set Timer4 for synchronous operation
PLLFRQ&=(1<<PINMUX) | (1<<PLLUSB) | (0<<PLLTM1) | (0<<PLLTM0) | (1<<PDIV3) | (1<<PDIV2) | (1<<PDIV1) | (1<<PDIV0);

TCCR4A=(0<<COM4A1) | (0<<COM4A0) | (0<<COM4B1) | (0<<COM4B0) | (0<<FOC4A) | (0<<FOC4B) | (0<<PWM4A) | (0<<PWM4B);
TCCR4B=(0<<PWM4X) | (0<<PSR4) | (0<<DTPS41) | (0<<DTPS40) | (0<<CS43) | (0<<CS42) | (0<<CS41) | (0<<CS40);
TCCR4C=(0<<COM4A1S) | (0<<COM4A0S) | (0<<COM4B1S) | (0<<COM4B0S) | (0<<COM4D1) | (0<<COM4D0) | (0<<FOC4D) | (0<<PWM4D);
TCCR4D=(0<<FPIE4) | (0<<FPEN4) | (0<<FPNC4) | (0<<FPES4) | (0<<FPAC4) | (0<<FPF4) | (0<<WGM41) | (0<<WGM40);
TCCR4E=(0<<TLOCK4) | (0<<ENHC4) | (0<<OC4OE5) | (0<<OC4OE4) | (0<<OC4OE3) | (0<<OC4OE2) | (0<<OC4OE1) | (0<<OC4OE0);
TC4H=0x00;
TCNT4=0x00;
TC4H=0x00;
OCR4A=0x00;
TC4H=0x00;
OCR4B=0x00;
TC4H=0x00;
OCR4C=0x00;
TC4H=0x00;
OCR4D=0x00;
DT4=0x00;

// Timer/Counter 0 Interrupt(s) initialization
TIMSK0=(0<<OCIE0B) | (0<<OCIE0A) | (0<<TOIE0);

// Timer/Counter 1 Interrupt(s) initialization
TIMSK1=(0<<ICIE1) | (0<<OCIE1C) | (0<<OCIE1B) | (0<<OCIE1A) | (0<<TOIE1);

// Timer/Counter 3 Interrupt(s) initialization
TIMSK3=(0<<ICIE3) | (0<<OCIE3C) | (0<<OCIE3B) | (0<<OCIE3A) | (0<<TOIE3);

// Timer/Counter 4 Interrupt(s) initialization
TIMSK4=(0<<OCIE4D) | (0<<OCIE4A) | (0<<OCIE4B) | (0<<TOIE4);

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
// INT3: Off
// INT6: Off
EICRA=(0<<ISC31) | (0<<ISC30) | (0<<ISC21) | (0<<ISC20) | (0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
EICRB=(0<<ISC61) | (0<<ISC60);
EIMSK=(0<<INT6) | (0<<INT3) | (0<<INT2) | (0<<INT1) | (0<<INT0);
// PCINT0 interrupt: Off
// PCINT1 interrupt: Off
// PCINT2 interrupt: Off
// PCINT3 interrupt: Off
// PCINT4 interrupt: Off
// PCINT5 interrupt: Off
// PCINT6 interrupt: Off
// PCINT7 interrupt: Off
PCMSK0=(0<<PCINT7) | (0<<PCINT6) | (0<<PCINT5) | (0<<PCINT4) | (0<<PCINT3) | (0<<PCINT2) | (0<<PCINT1) | (0<<PCINT0);
PCICR=(0<<PCIE0);

// USART1 initialization
// USART1 disabled
UCSR1B=(0<<RXCIE1) | (0<<TXCIE1) | (0<<UDRIE1) | (0<<RXEN1) | (0<<TXEN1) | (0<<UCSZ12) | (0<<RXB81) | (0<<TXB81);

// Analog Comparator initialization
// Analog Comparator: Off
// The Analog Comparator's positive input is
// connected to the AIN0 pin
// The Analog Comparator's negative input is
// connected to the AIN1 pin
ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
ADCSRB=(0<<ACME);
// Digital input buffer on AIN0: On
DIDR1=(0<<AIN0D);

// ADC initialization
// ADC Clock frequency: 1000.000 kHz
// ADC Voltage Reference: AVCC pin
// ADC High Speed Mode: Off
// ADC Auto Trigger Source: ADC Stopped
// Only the 8 most significant bits of
// the AD conversion result are used
// Digital input buffers on ADC0: On, ADC1: Off
// ADC4: On, ADC5: On, ADC6: Off, ADC7: On
DIDR0=(0<<ADC7D) | (1<<ADC6D) | (0<<ADC5D) | (0<<ADC4D) | (1<<ADC1D) | (0<<ADC0D);
// Digital input buffers on ADC8: On, ADC9: On, ADC10: On, ADC11: On
// ADC12: On, ADC13: On
DIDR2=(0<<ADC13D) | (0<<ADC12D) | (0<<ADC11D) | (0<<ADC10D) | (0<<ADC9D) | (0<<ADC8D);
ADMUX=ADC_VREF_TYPE;
ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (1<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
ADCSRB=(1<<ADHSM) | (0<<MUX5) | (0<<ADTS3) | (0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);

// SPI initialization
// SPI Type: Slave
// SPI Clock Rate: 4000.000 kHz
// SPI Clock Phase: Cycle Start
// SPI Clock Polarity: Low
// SPI Data Order: MSB First
SPCR=(0<<SPIE) | (1<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
SPSR=(0<<SPI2X);

// TWI initialization
// Mode: TWI Master
// Bit Rate: 100 kHz
twi_master_init(100);

// Globally enable interrupts
#asm("sei")

// I2C LCD Shield initialization for TWI
// PCF8574 I2C bus address: 0x27
// LCD characters/line: 20
lcd_twi_init(0x3F,20);
//lcd_putsf("Prueba Serial");
while (1)
      {
      // Place your code here     
      lcd_printfxy(1,2,"%u",read_adc(1));       
      lcd_printfxy(2,3,"%u",read_adc(6));
          
      

      }
}
