//Código para obtener los datos del bitalino mediante el arduino
//Y enviarlos a través del puerto serial cada 2ms

#include <MsTimer2.h>

const int analogInPin = A1;  //Declarar pin analógico
float sensorValue = 0;        //Valor leído del bitalino
//float outputValue = 0;        //Valor en voltios del bitalino

//Función realizada por el timer2 cada 2ms
void enviar(){
  //Leer valor analógico
  sensorValue = analogRead(analogInPin);
  //outputValue = (sensorValue*5)/1023;
  
  //Envíar los valores por el puerto serial
  Serial.println(sensorValue);
}

void setup() {
 //Se establece la conexión serial
 Serial.begin(115200);
 MsTimer2::set(2, enviar); // 2ms period
}
 
void loop(){
 //Esperar a recibir el valor 107 de python para iniciar el envío de datos
 if (Serial.available() > 0) {
  int input = Serial.read();
 if(input == 107) { 
  //Inicializar timer2
  MsTimer2::start();
 }
 }
}
