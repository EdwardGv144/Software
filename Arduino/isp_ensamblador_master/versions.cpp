#include <SPI.h>

byte Mastersend, Mastereceive;
unsigned char count = 0;
unsigned char array_pos;
unsigned char data[20];

void setup() {
  Serial1.begin(9600);
  SPI.begin();
  SPI.setClockDivider(SPI_CLOCK_DIV16);
  asm("sbi 0x05,0");
  Mastersend = 0;
  array_pos = 0;
}

void loop() {
  delay(3000);  //Allow Serial to start
  asm("start:");  //start inline assembler to diminish time
  asm("cbi 0x05, 0"); //set SS to Low

  Serial.println(Mastersend);

  Mastereceive=SPI.transfer(Mastersend);//generate SPI communication and receive output from the slave
  data[array_pos] = Mastereceive;
  /*transfer Subroutine*/
  /*SPDR = data;
     //*
     //* The following NOP introduces a small delay that can prevent the wait
     //* loop form iterating when running at the maximum speed. This gives
     //* about 10% more speed, even if it seems counter-intuitive. At lower
     //* speeds it is unnoticed.
     //*
    asm volatile("nop");
    while (!(SPSR & _BV(SPIF))) ; // wait
    return SPDR;*/
  Serial.println(Mastereceive);
  Serial.println(array_pos);
  if (Mastereceive != Mastersend){
    Serial.print("ERROR :");
    Serial.println(count);
    count ++;
  }else{
    Serial.print("SUCCESS :");
    Serial.println(count);
    count++;
  }
  Mastersend++;
  array_pos++;

  if(array_pos == 20){
    asm("sbi 0x05, 0");//set SS to High
    array_pos = 0;
  }
  delay(500);

  asm("rjmp start");//Access start again
}
