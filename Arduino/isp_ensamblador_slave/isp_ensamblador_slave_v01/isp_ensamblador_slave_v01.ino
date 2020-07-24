//SPI SLAVE (ARDUINO)
//SPI COMMUNICATION BETWEEN TWO ARDUINO 
//CIRCUIT DIGEST
//Pramoth.T

#include<SPI.h>

volatile boolean received;
volatile byte Slavereceived,Slavesend;

void setup(){
  Serial.begin(115200);
  pinMode(MISO,OUTPUT);                   //Sets MISO as OUTPUT (Have to Send data to Master IN 
  SPCR |= _BV(SPE);                       //Turn on SPI in Slave Mode
  SPI.attachInterrupt();                  //Interuupt ON is set for SPI commnucation
  pinMode(SS,INPUT);
  pinMode(13, OUTPUT);
  digitalWrite(13, LOW);
  received = false;
}


ISR (SPI_STC_vect)                        //Inerrrput routine function 
{
  Slavereceived = SPDR;         // Value received from master if store in variable slavereceived
  received = true;                        //Sets received as True 
  digitalWrite(13, HIGH);
}


void loop(){
  if(received){
    Slavesend= Slavereceived + 1;
    SPDR = Slavesend;                           //Sends the x value to master via SPDR 
    delay(1000);
    digitalWrite(13, LOW);
    received = false;
  }
}
