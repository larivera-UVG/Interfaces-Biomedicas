//LECTURA DE DATOS DE UN PUERTO ANALÓGICO DEL ARDUINO

#include <TimerOne.h>

int analogPin1 = A0;  
int T=1e-3;
int v=0;

void setup(void)
{
  pinMode(analogPin1, INPUT);
  Serial.begin(115200);
  Timer1.initialize(800);         // Dispara cada 1 ms  
}

void sendSerial()
{   
   v = analogRead(analogPin1);  
   Serial.println(v);
        
}

void loop(void)
{
  if (Serial.available() > 0) {
  int input = Serial.read();
    if(input == 107) { 
      Timer1.attachInterrupt(sendSerial); // Activa la interrupción
    }
  } 
}
