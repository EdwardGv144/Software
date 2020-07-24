#include <SPI.h>

volatile boolean received;
volatile byte Slavereceived,Slavesend;
const byte interruptPin = 7;
unsigned char array_pos;
unsigned char data[20];

void setup() {
  Serial.begin(9600);
  pinMode(MISO,OUTPUT); //Sets MISO as OUTPUT (Have to Send data to Master IN)
  SPCR |= _BV(SPE); //Turn on SPI in Slave Mode
  SPI.attachInterrupt(); //Interuupt ON is set for SPI commnucation
  received = false;  
  Slavesend = 0;
  pinMode(13,OUTPUT);
  digitalWrite(13,LOW);
  //pinMode(interruptPin, INPUT_PULLUP);
  //attachInterrupt(digitalPinToInterrupt(interruptPin), RestartArray, FALLING);
  array_pos = 0;
}

ISR(SPI_STC_vect)                        //Inerrrput routine function
{
  Slavereceived = SPDR;         // Value received from master if store in variable slavereceived
  received = true;                        //Sets received as True

}

/*
void RestartArray()                        //Inerrrput routine function
{
  array_pos = 0;
  Serial.println("INTERRUPT");
}
*/

void loop() {
  if(received){
    data[array_pos] = Slavereceived;
    //Serial.println(Slavesend);
    //Serial.println(array_pos);
    Slavesend = Slavereceived + 1;
    SPDR = Slavesend; //Sends the Slavereceived value to master via SPDR
    //Slavesend = Slavereceived + 1;
    array_pos ++;
    received = false;
    if (SS == HIGH){
      array_pos = 0;
      digitalWrite(13,HIGH); 
    }
  }
  delay(100);
  digitalWrite(13,LOW);
}
