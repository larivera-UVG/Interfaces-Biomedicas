/*
 * Comunicacion Serial de Arduino para enviar a Matlab
 * Utilizando el Timer 1 con un desborde a cada 1 ms.
 * Simular conexion de electrocap con frecuencia 100 Hz
 * Rodrigo Ralda - 14813
 */
#include <TimerOne.h>

int analogPin = A1;   
int v=0;
int vN=0;
 


void setup(void)
   {
       pinMode(analogPin, INPUT);
       // set a timer of length 100000 microseconds (or 0.1 sec - or 10Hz => the led will blink 5 times, 5 cycles of on-and-off, per second)
       Timer1.initialize(10000);         // Dispara cada 10 ms - 100 Hz 
       Timer1.attachInterrupt(sendSerial); // Activa la interrupcion y la asocia a ISR_Blink
       Serial.begin(115200);
   }

   void sendSerial()
   {   
      // v = analogRead(analogPin); 
       vN =1;   
       Serial.println(vN, DEC);
            
   }

   void loop(void)
   {

   }
