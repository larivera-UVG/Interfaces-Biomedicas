Autor: Rodrigo Ralda G. - ral14813@uvg.edu.gt

# Interfaz Biomédica para el Control de Sistemas Robóticos Utilizando Señales EEG

Este proyecto de investigación consiste en el desarrollo de una primera fase de una interfaz cerebro-computador (BCI) que permite controlar sistemas robóticos por medio de señales electroencefalográficas. El proyecto se dividió en cuatro etapas principales. La primera etapa consistió en establecer un mecanismo de adquisición,  filtrado y visualización en tiempo real de señales EEG en MATLAB. 

La segunda etapa consistió en seleccionar características que redujeran la dimensionalidad de las señales sin afectar la información significativa que estas brindan. Por lo que se calcularon diferentes características como MAV, ZC, curtosis, varianza, potencia media, distancia máxima-mínima y ondículas para evaluar el rendimiento de dos algoritmos diferentes de aprendizaje automático supervisado los cuales fueron Redes Neuronales Artificiales y Máquinas de Vectores de Soporte, para encontrar la combinación que presentará el menor error de clasificación. Luego de varias pruebas, se encontró que el mejor rendimiento fue mayor a 90\% y se obtuvo con la Red Neuronal Artificial y  cinco características en el dominio del tiempo.

La tercera etapa consistió en desarrollar la parte gráfica de la BCI. Esto se divide en dos partes, el robot y la interfaz gráfica. Se desarrollaron tres modelos robóticos los cuales fueron el UR5, el R17 y el Puma 560 para ser accionados por la interfaz. Para la interfaz era una prioridad que esta fuese intuitiva para el usuario y debía mostrar las señales en tiempo real, el resultado de su clasificación y el comando que ejecuta el robot. La cuarta etapa consistió en validar el correcto funcionamiento de las etapas antes mencionadas trabajando conectadas.

## Índice
[Pruebas base de datos gestos.](Interfaces-Biomedicas/EEG/Código/Pruebas SVM y RN dominio del tiempo/)
## Instalación

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
