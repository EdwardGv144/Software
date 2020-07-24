//SPI MASTER (ARDUINO)
//SPI COMMUNICATION BETWEEN TWO ARDUINO 
//CIRCUIT DIGEST

#include<SPI.h>                             //Library for SPI 

byte Mastersend,Mastereceive;
unsigned char x = 0;
unsigned char err = 0;

void setup (void){  
  Serial.begin(115200);
  SPI.begin();                            //Begins the SPI commnuication
  SPI.setClockDivider(SPI_CLOCK_DIV16);    //Sets clock for SPI communication at 8 (16/8=2Mhz)
  digitalWrite(SS,HIGH);                  // Setting SlaveSelect as HIGH (So master doesnt connnect with slave)
  Mastersend = x;
}

void loop(void){
  digitalWrite(SS, LOW);                  //Starts communication with Slave connected to master
  
  
                        
  Mastereceive=SPI.transfer(Mastersend); //Send the mastersend value to slave also receives value from slave

  /*
  if(Mastereceive != Mastersend){
    Serial.print("ERROR: ");
    Serial.println(err);
    err++;
  }
  */
  //x++;
  delay(1000);
  digitalWrite(SS,HIGH);
}
