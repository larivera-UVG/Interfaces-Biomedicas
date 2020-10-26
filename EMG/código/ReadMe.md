# Código

Esta carpeta almacena códigos tanto para Matlab y Arduino que se fueron desarrollando a lo largo del proyecto, a continuación se presenta un resumen del contenido de las carpetas ubicadas en este repositorio.

1. **Arduino:** En esta carpeta se encuentran los códigos de Arduino para leer datos de un canal y dos canales del Bitalino y enviarlos por puerto serial a Matlab.
    * 1canal
    * 2canales
2. **Features:** En esta carpeta se encuentran la funciones utilizadas para extraer características temporales de las señales EMG.
3. **Matlab**
    * **Adquisición Señales:** Almacena los códigos para establecer la comunicación entre Arduino y Matlab.
         + 1canal
         + 2canales
    * **Clasificadores Base de Datos Propia:** En esta carpeta se encuentran archivos .mat con las señales utilizadas para entrenamiento de clasificadores y con las señales de prueba. Además, el código que se utilizó para realizar pruebas y ver el rendimiento de los clasificadores.
    * **Clasificadores Base de Datos Pública:** En estas carpetas se almacenan archivos .mat con la información de la base de datos pública según el formato requerido por cada clasificador. Y el código para realizar pruebas de entrenamiento y clasificación con RN y SVM.
         + RN
         + SVM
    * **Filtros:** Almacena las funciones utilizadas para implementar un filtro pasa bandas y un filtro rechaza bandas.
    * **Interfaz:**  En estas carpetas se encuentra el código principal y archivos auxiliares requeridos para realizar la simulación del sistema final.
         + Simulación base de datos pública
         + Simulación tiempo real
