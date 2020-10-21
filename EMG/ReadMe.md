# Interfaz Biomédica para el Control de Sistemas Robóticos Utilizando Señales EMG

Este proyecto tiene como fin el desarrollo de una interfaz biomédica para el control de dispositivos robóticos mediante la adquisición, filtrado y análisis en tiempo real de señales electromiográficas de superficie (sEMG). Por lo que se implementa un algoritmo para adquisición y filtrado de señales sEMG en tiempo real utilizando Matlab y Arduino. Además, se implementa un algoritmo de clasificación, mediante el entrenamiento de clasificadores basados en máquinas de vectores de soporte (SVM) y redes neuronales (RN). Y una simulación que permite visualizar como los resultados de la clasificación se traducen a comandos de control para manipular el sistema robótico.

## Índice

**[1. Prerrequisitos](#prerrequisitos)**
  * [1.1 Librería libsvm](#libsvm)
  * [1.2 Toolboxes](#toolboxes)
  * [1.3 Base de Datos](#database)

**[2. Estructura de Carpetas](#carpetas)**
  * [2.1 Código](#codigo)
  * [2.2 Documentos](#documentos)

**[3. Instrucciones para Ejecutar la Simulación](#instrucciones)**
  * [3.1 Simulación Base de Datos](#Sdatabase)
  * [3.2 Simulación Tiempo Real](#Streal)

## Prerrequisitos <a name="prerrequisitos"></a>

### 1.1 Librería libsvm <a name="libsvm"></a>
1. Descargar la librería disponible para Matlab del siguiente enlace https://www.csie.ntu.edu.tw/~cjlin/libsvm/#download
2. Ver instrucciones de instalación detalladas en el archivo README ubicado en la carpeta nombrada matlab contenida en el zip.

### 1.2 Toolboxes <a name="toolboxes"></a>
#### *Robotics Toolbox* de Peter Corke
1. Descargar el *Toolbox* de robótica de Peter Corke del siguiente enlace https://petercorke.com/toolboxes/robotics-toolbox/2.
2. Desde el explorador de archivos de Matlab dirigirse a la ubicación del archivo descargado y dar doble click sobre el mismo para finalizar la instalación.

### 1.3 Base de Datos <a name="database"></a>
Descargar la base de datos del siguiente enlace http://archive.ics.uci.edu/ml/datasets/sEMG%2Bfor%2BBasic%2BHand%2Bmovements

## Estructura de Carpetas <a name="carpetas"></a>
A continuación se presenta un resumen del contenido de las carpetas de este repositorio.

### 2.1 Código <a name="codigo"></a>
En esta carpeta se encuentran las carpetas siguientes:

1. **Arduino:** En esta carpeta se encuentran los códigos de Arduino para leer datos de un canal y dos canales del Bitalino y enviarlos por puerto serial a Matlab.
    * 1canal
    * 2canales
2. **Features:**(#features) En esta carpeta se encuentran la funciones utilizadas para extraer características temporales de las señales EMG.
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


### 2.2 Documentos <a name="documentos"></a>
En esta carpeta se encuentra los documentos de protocolo y tesis.

## Instrucciones para Ejecutar la Simulación <a name="instrucciones"></a>

### 3.1 Simulación Base de Datos <a name="Sdatabase"></a>
1. Descargar las funciones de la carpeta Features <a name="features"></a>.
2. Descargar todos los archivos de la carpeta Matlab/Interfaz/Simulación tiempo real.
3. Ejecutar el código ***interfaz.m***

### 3.2 Simulación Tiempo Real <a name="Streal"></a>
1. Conectar el *hardware* de Arduino con el Bitalino y la computadora.
2. Cargar al Arduino el código ***get_data_2.ino*** ubicado en la carpeta Arduino/2canales.
3. Descargar las funciones de la carpeta Features <a name="features"></a>.
4. Descargar las funciones de la carpeta Matlab/Filtros.
5. Descargar todos los archivos de la carpeta Matlab/Interfaz/Simulación tiempo real.
6. Almacenar todos los archivos en una sola carpeta.
7. Ejecutar el código ***interfaz_tiempo_real.m***.
