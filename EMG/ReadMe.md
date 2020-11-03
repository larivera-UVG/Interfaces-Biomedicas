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
A continuación se presenta la estructura y contenido de las carpetas de este repositorio.

### 2.1 Código <a name="codigo"></a>
En esta carpeta se encuentran las carpetas siguientes:

1. **Arduino**
    * 1canal
    * 2canales
2. **Features**
3. **Matlab**
    * **Adquisición Señales**
         + 1canal
         + 2canales
    * **Clasificadores Base de Datos Propia**
    * **Clasificadores Base de Datos Pública**
         + RN
         + SVM
    * **Filtros**
    * **Interfaz**
         + Simulación base de datos pública
         + Simulación tiempo real


### 2.2 Documentos <a name="documentos"></a>
En esta carpeta se encuentra los documentos de protocolo y tesis.
