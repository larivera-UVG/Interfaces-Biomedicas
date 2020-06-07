María Fernanda Girón Arévalo, 16820
Diseño e Innovación, sección 10

El repositorio cuenta con 7 funciones para extracción de características temporales: mav.m, rms.m, wl.m, zc.m, varianza.m, desv.m, emg.m.
  
-Base de datos "female_1.mat" que contiene señales electromiográficas de 6 tipos de agarre diferentes, divididas en 2 canales, 30 muestras por clase.

-CV_DATABASE.m 
Es un script para organización de datos según el clasificador y creación de etiquetas, utiliza la imformación de la base de datos "female_1.mat" para crear un nuevo archivo .mat que se utiliza en los clasificadores. Correr antes de ejecutar cualquiera de los siguientes scripts. 

-SVM.mat
Clasificador utilizando máquinas de vectores de soporte. Se requiere descargar la librería libsvm para matlab antes de correrlo. Adjunto link para descarga.
https://www.csie.ntu.edu.tw/~cjlin/libsvm/

-RN.mat
Clasificador utilizando redes neuronales.




