Autor: Rodrigo Ralda G. - ral14813@uvg.edu.gt

# Interfaz Biomédica para el Control de Sistemas Robóticos Utilizando Señales EEG

Este proyecto de investigación consiste en el desarrollo de una primera fase de una interfaz cerebro-computador (BCI) que permite controlar sistemas robóticos por medio de señales electroencefalográficas. El proyecto se dividió en cuatro etapas principales. La primera etapa consistió en establecer un mecanismo de adquisición,  filtrado y visualización en tiempo real de señales EEG en MATLAB. 

La segunda etapa consistió en seleccionar características que redujeran la dimensionalidad de las señales sin afectar la información significativa que estas brindan. Por lo que se calcularon diferentes características como MAV, ZC, curtosis, varianza, potencia media, distancia máxima-mínima y ondículas para evaluar el rendimiento de dos algoritmos diferentes de aprendizaje automático supervisado los cuales fueron Redes Neuronales Artificiales y Máquinas de Vectores de Soporte, para encontrar la combinación que presentará el menor error de clasificación. Luego de varias pruebas, se encontró que el mejor rendimiento fue mayor a 90\% y se obtuvo con la Red Neuronal Artificial y  cinco características en el dominio del tiempo.

La tercera etapa consistió en desarrollar la parte gráfica de la BCI. Esto se divide en dos partes, el robot y la interfaz gráfica. Se desarrollaron tres modelos robóticos los cuales fueron el UR5, el R17 y el Puma 560 para ser accionados por la interfaz. Para la interfaz era una prioridad que esta fuese intuitiva para el usuario y debía mostrar las señales en tiempo real, el resultado de su clasificación y el comando que ejecuta el robot. La cuarta etapa consistió en validar el correcto funcionamiento de las etapas antes mencionadas trabajando conectadas.

## Índice

**[1. Instalación](#instal)**
  * [1.1. Bases de Datos](#dbPhys)
  * [1.2. Funciones de Lectura](#func)
  * [1.3. Librerías](#lib)
  
**[2. Contenido Carpetas](#carpetas)**
  * [2.1. Código](#codigo)
  * [2.2. Referencias Bibliográficas](#ref)
  * [2.3. Trabajo de Graduación](#tG)
   
## Instalación <a name="instal"></a>

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

## Contenido Carpetas <a name="carpetas"></a>
A continuación se presenta un resumen del contenido de las carpetas de este repositorio. 

### 2.1 Código <a name="codigo"></a>
En esta carpeta se encuentran las carpetas siguientes:

1. [Arduino](https://github.com/larivera-UVG/Interfaces-Biomedicas/tree/master/EEG/Código/Arduino) 
    * En esta carpeta se encuentra el código que se le debe cargar al Arduino para simular la recepción de señales en tiempo real con comunicación serial.
2. [Interfaz](https://github.com/larivera-UVG/Interfaces-Biomedicas/tree/master/EEG/Código/Interfaz)
    * En esta carpeta se encuentra el código de diseño de la interfaz, las funciones auxiliares y los datos que se usan para la demostración final del proyecto.
3. [Pruebas Base de Datos Sueño](https://github.com/larivera-UVG/Interfaces-Biomedicas/tree/master/EEG/Código/Pruebas%20Base%20de%20datos%20Sueño)
    * En esta carpeta se encuentran los datos de la base de datos de sueño y también las pruebas que se realizaron a estos datos en el dominio del tiempo y en el dominio del tiempo-frecuencia, así como sus funciones auxiliares.
 4. [Pruebas SVM y RN Dominio del Tiempo](https://github.com/larivera-UVG/Interfaces-Biomedicas/tree/master/EEG/Código/Pruebas%20SVM%20y%20RN%20dominio%20del%20tiempo)
    * En esta carpeta se encuentran las pruebas con SVM y RN con características en el dominio del tiempo a la base de datos de gestos.
    
 5. [Robot](https://github.com/larivera-UVG/Interfaces-Biomedicas/tree/master/EEG/Código/Robot)
    * En esta carpeta se encuentra el desarrollo de los modelos de los robots R17, UR5 y Puma 560 con sus respectivas trayectorias para controlar los modelos.
    
 6. [Serial](https://github.com/larivera-UVG/Interfaces-Biomedicas/tree/master/EEG/Código/Serial)
    * En esta carpeta se encuentra el código de MATLAB para probar la comunicación serial con el Arduino.
 7. [Wavelets](https://github.com/larivera-UVG/Interfaces-Biomedicas/tree/master/EEG/Código/Wavelets)
    * En esta carpeta se encuentran los códigos correspondientes a las pruebas en el dominio tiempo/frecuencia con wavelets para la base de datos de gestos. 
Los códigos presentes en cada carpeta se detallaran más adelante.
  
### 2.2. Referencias Bibliográficas <a name="ref"></a>
En esta carpeta se encuentran documentos importantes que se usaron para esta investigación.

### 2.3. Trabajo de Graduación <a name="tG"></a>
En esta carpeta se encuentra el documento de tesis.

## Uso




En el siguiente repositorio se encuentran 4 archivos .m desarrollados en MATLAB R2018a.
Para utilizar los códigos es necesario descargar las funciones Eventread.m y edfread.m
Las cuales se encuentran en el siguiente enlace: 
https://es.mathworks.com/matlabcentral/answers/375362-how-can-i-read-edf-event-file-since-i-have-corresponded-edf-file-in-matlab
Con un ejemplo para entender su uso.

La base de datos con la que se trabaja es de Physionet y se encuentra en el siguiente enlace:
https://physionet.org/content/eegmmidb/1.0.0/

Cada archivo tiene sus comentarios y la idea general de cada uno se detalla a continuación:

createData.m
Abre, lee, selecciona canales de interés y extrae características de los mismos.

metricas.m
Función para extraer características de Zero Crossing y Mean Absolute Value.

SVMdata.m
Implementa Máquinas de Soporte Vectorial con 6 núcleos diferentes. Se presentan resultados como matrices de confusión.

RNdata.m
Implementa Redes Neuronales. Utilizando como base el código generado por la app de MATLAB.
