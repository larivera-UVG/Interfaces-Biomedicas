# Interfaz Biomédica para el Control de Sistemas Robóticos Utilizando Señales EEG

Autor: Rodrigo Ralda G. - ral14813@uvg.edu.gt

Este proyecto de investigación consiste en el desarrollo de una primera fase de una interfaz cerebro-computador (BCI) que permite controlar sistemas robóticos por medio de señales electroencefalográficas (EEG). 

El proyecto consistió en establecer un mecanismo de adquisición,  filtrado y visualización en tiempo real de señales EEG en MATLAB. A partir de estas señales se seleccionaron características que redujeran la dimensionalidad de las señales sin afectar la información significativa que estas brindan. Por lo que se calcularon diferentes características como MAV, ZC, curtosis, varianza, potencia media, distancia máxima-mínima y ondículas para evaluar el rendimiento de dos algoritmos diferentes de aprendizaje automático supervisado los cuales fueron Redes Neuronales Artificiales y Máquinas de Vectores de Soporte, para encontrar la combinación que presentara el mejor rendimiento de clasificación. Luego de varias pruebas, se encontró que el mejor rendimiento fue mayor a 90\% y se obtuvo con la Red Neuronal Artificial y  cinco características en el dominio del tiempo. 

Para mostrar el correcto funcionamiento del clasificador se desarrollaron tres modelos robóticos los cuales fueron el UR5, el R17 y el Puma 560 para ser accionados por la interfaz. Para la interfaz era una prioridad que esta fuese intuitiva para el usuario y debía mostrar las señales en tiempo real, el resultado de su clasificación y el comando que ejecuta el robot. 

## Índice

**[1. Instalación](#instal)**
  * [1.1. Bases de Datos](#dbPhys)
  * [1.2. Funciones de Lectura](#func)
  * [1.3. Librerías](#lib)
  
**[2. Contenido Carpetas](#carpetas)**
  * [2.1. Código](#codigo)
  * [2.2. Referencias Bibliográficas](#ref)
  * [2.3. Trabajo de Graduación](#tG)
  
**[3. Instrucciones de Uso](#uso)**
   
## 1. Instalación <a name="instal"></a>

### 1.1. Bases de Datos <a name="dbPhys"></a>
1. Descargar la base de datos [EEG Motor Movement/Imagery Dataset](https://physionet.org/content/eegmmidb/1.0.0/) de *Physionet*.
2. Descargar la base de datos [Sleep-EDF Database Expanded](https://physionet.org/content/sleep-edfx/1.0.0/) de *Physionet*. 

### 1.2. Funciones de Lectura <a name="func"></a>
1. Descargar la función [edfreadUntilDone.m](https://es.mathworks.com/matlabcentral/fileexchange/31900-edfread).
2. Descargar las funciones [Eventread.m y edfread.m](https://es.mathworks.com/matlabcentral/answers/375362-how-can-i-read-edf-event-file-since-i-have-corresponded-edf-file-in-matlab).
3. Correr el ejemplo presentado en el segundo enlace en caso sea necesario para familiarizarse con las funciones.

### 1.3. Librerías <a name="lib"></a>

#### Líbreria de Robótica de Peter Corke
1. Descargar la [Librería de Robótica](https://petercorke.com/toolboxes/robotics-toolbox/2) de Peter Corke. 
2. Desde el explorador de archivos de MATLAB dirigirse a la ubicación del archivo descargado y dar doble click sobre el mismo para finalizar la instalación.

## 2. Contenido Carpetas <a name="carpetas"></a>
A continuación se presenta un resumen del contenido de las carpetas de este repositorio. 

### 2.1. Código <a name="codigo"></a>
En esta carpeta se encuentran las carpetas siguientes:

1. [Arduino](https://github.com/larivera-UVG/Interfaces-Biomedicas/tree/master/EEG/Código/Arduino). 
        
2. [Interfaz](https://github.com/larivera-UVG/Interfaces-Biomedicas/tree/master/EEG/Código/Interfaz)
    
3. [Pruebas Base de Datos Sueño](https://github.com/larivera-UVG/Interfaces-Biomedicas/tree/master/EEG/Código/Pruebas%20Base%20de%20datos%20Sueño)
    
4. [Pruebas SVM y RN Dominio del Tiempo](https://github.com/larivera-UVG/Interfaces-Biomedicas/tree/master/EEG/Código/Pruebas%20SVM%20y%20RN%20dominio%20del%20tiempo)
        
5. [Robot](https://github.com/larivera-UVG/Interfaces-Biomedicas/tree/master/EEG/Código/Robot)
        
6. [Serial](https://github.com/larivera-UVG/Interfaces-Biomedicas/tree/master/EEG/Código/Serial)
    
7. [Wavelets](https://github.com/larivera-UVG/Interfaces-Biomedicas/tree/master/EEG/Código/Wavelets)
      
### 2.2. Referencias Bibliográficas <a name="ref"></a>
En esta carpeta se encuentran documentos importantes que se usaron para esta investigación.

### 2.3. Trabajo de Graduación <a name="tG"></a>
En esta carpeta se encuentra el documento de tesis.

## 3. Instrucciones de Uso <a name="uso"></a>
Para comprender las funciones y como utilizar los códigos presentes en las carpetas antes mencionadas se recomienda leer los comentarios incluídos en cada código.

Para observar el funcionamiento del proyecto completo, es decir todos los módulos trabajando en conjunto se recomienda seguir los siguientes pasos:

* Conectar el *hardware* de Arduino a la computadora.
* Abrir y cargar el código [serial.ino](https://github.com/larivera-UVG/Interfaces-Biomedicas/tree/master/EEG/Código/Arduino/serial) en el Arduino.
* Abrir en MATLAB la aplicación [appR17mlapp.mlapp](https://github.com/larivera-UVG/Interfaces-Biomedicas/tree/master/EEG/Código/Interfaz).
* Dar click en el botón de *Run* con la flecha verde.
* La interfaz está en modo manual, para familiarizarse se recomienda seleccionar que tipo de movimiento se desea en el botón del panel izquierdo, seleccionar el modelo de robot a utilizar en el panel central y seleccionar el tipo de comando a ejecutar en la parte inferior del panel central.
* Para utilizar la interfaz en modo automático cambie de pestaña, seleccione en el deslizador la cantidad de segundos que desea dure la ventana de captura de datos y presione el botón *Iniciar Grabación*. Si desea observar las características calculadas para cada ventana seleccione la pestaña de *Desplegar Características*.


