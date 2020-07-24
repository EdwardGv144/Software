#include <SPI.h>
#define ARR_SIZE 20

byte Mastersend, Mastereceive;
unsigned char count = 0;
unsigned char array_pos;
unsigned char data[ARR_SIZE];

void setup() {
  Serial.begin(9600);
  SPI.begin();
  SPI.setClockDivider(SPI_CLOCK_DIV16);
  asm("sbi 0x05,0");
  Mastersend = 0;
  array_pos = 0;
}

void loop() {
  delay(3000);                            //Allow Serial to start
  asm("start:");                          //start inline assembler to diminish time
  asm("cbi 0x05, 0");                     //set SS to Low
  //Serial.println(Mastersend);             //Debbigging print
  Mastereceive=SPI.transfer(Mastersend);  //generate SPI communication and receive output from the slave
  data[array_pos] = Mastereceive;         //Place the received data in the corresponding array position
  //Serial.println(Mastereceive);           //Debbigging print
  //Serial.println(array_pos);              //Debbigging print
  if (Mastereceive != Mastersend){        //Count the errors of SPI protocol
    //Serial.print("ERROR :");
    Serial.println(count);
    count ++;
  }
  /* 
  else{
    Serial.print("SUCCESS :");
    Serial.println(count);
    count++;
  }
  */
  Mastersend++; 
  array_pos++;
  if(array_pos == ARR_SIZE){              //Check if the last position of array has been reached
    asm("sbi 0x05, 0");                   //set SS to High
    array_pos = 0;                        //Reset array index pointer
  }
  delay(100);
  asm("rjmp start");                      //Access start again
}
