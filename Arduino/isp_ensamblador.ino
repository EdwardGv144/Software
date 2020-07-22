#include <SPI.h>

void setup() {
  SPI.begin();
  SPI.setClockDivider(SPI_CLOCK_DIV16);    
  asm("sbi 0x05,0");
}

void loop() {
  
  int x=5;
  int recv;
  
  asm("start:");//start inline assembler to diminish time
  asm("cbi 0x05, 0");//set SS to Low

  recv=SPI.transfer(x);//generate SPI communication and receive output from the slave
  
  asm("sbi 0x05, 0");//set SS to High
  asm("rjmp start");//Access start again


}
