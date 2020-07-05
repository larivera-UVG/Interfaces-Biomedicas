# -*- coding: utf-8 -*-
"""
Created on Tue Feb  4 22:51:17 2020
@author: Mafer1
"""
import serial
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import numpy as np
import threading
import tkinter as tk
import csv
from collections import deque

from scipy import signal

srate = 500      #Frecuencia de muestreo 500Hz (500 muestras en 1 segundo)
t = 1

 #Establecer límite del buffer
x_lim = srate*t   #no. datos   
m = 5           #no. muestras   

 #Declarar el buffer lleno de ceros con espacio de 1000 muestras.
datos = deque([0]*x_lim , maxlen=x_lim)  
database = np.zeros((m,x_lim))

#Inicializar la gráfica       
fig = plt.figure()
ax = fig.add_subplot(111)
plt.xlim(0,x_lim)
plt.ylim(-2,2)
x = np.array(range(len(datos)))
hl, = ax.plot(x,datos,'b-', lw = 1)

#Establecer la comunicación serial     
puerto = serial.Serial('COM14',115200,timeout = 1)

mav = 0.0
cont = 0

#Función para obtener el MAV
def MAV(datos):
    lista = datos
    prom = 0.0
    for i in range(0,len(lista)):
        prom = prom + abs(lista[i])
    return prom/len(lista)

#Función que aplica un filtro pasa bandas
def butter_bandpass_filter(data, lowcut, highcut, fs, order=5):
       nyq = 0.5 * fs            
       low = lowcut / nyq
       high = highcut / nyq
       b, a = signal.butter(order, [low, high], btype='band')
       y = signal.lfilter(b, a, data)
       return y

#Función que aplica un filtro notch 
def notch_filter(data,frec,Q,fs):
    b, a = signal.iirnotch(frec, Q, fs)
    y = signal.lfilter(b,a,data)
    return y

#Interfaz gráfica
class App():
    def __init__(self):
        self.root = tk.Tk()

        self.root.configure(bg = 'white')
        self.root.title('Aplicación')
        
        #Establecer los botones y etiquetas
        self.boton3 = tk.Button(self.root, text='Guardar Datos', 
                   command=self.Guardar)
        
        self.boton4 = tk.Button(self.root, text='Salir', 
                   command=self.Salir)
                
        self.boton5 = tk.Button(self.root, text='Iniciar', 
                   command=self.Iniciar)
        
#        self.boton6 = tk.Button(self.root, text='Save', 
#                   command=self.save and self.contador)
        
        #Colocar los botones y etiquetas
        self.boton5.pack()
        self.boton3.pack()
        self.boton4.pack()
#        self.boton6.pack()
        
        
        self.root.mainloop()
        
    
#    def save(self):
#        database[cont] = list(datos)    
        
#    def contador(self):
#        cont = cont + 1
                        
#    #Función para guardar datos en un csv
#    def Guardar(self):       
#        archivo = open('p5.csv','w',newline='')
#        archivo2 = csv.writer(archivo,delimiter = ",")
#        archivo2.writerows(database)
#        archivo.close()
        
    #Función para guardar datos en un csv
    def Guardar(self):       
        archivo = open('p7.csv','w',newline='')
        archivo2 = csv.writer(archivo,delimiter = ",")
        dato = [list(datos)]
        archivo2.writerows(dato)
        archivo.close()  
     
    #Deterner la comunicación con arduino
    def Salir(self):
        puerto.close()
            
    #Iniciar el envío de datos de arduino
    def Iniciar(self):
        puerto.write(b'k') 
        

#Función que se ejecuta en un hilo diferente, para leer los datos constantemente.
def getData(data):
    data_c= []
    while puerto:
        #Obtener los datos
        d = puerto.readline().decode("utf-8")  
        try:   
            #Centrar los datos y agregarlos al buffer
            d2 = float(d)*5/1023
            data_c.append(d2)
            data.append(float(d2)-MAV(data_c))   #Centrar datos usando el MAV
            data.append(float(d2))
            if (len(data_c) > x_lim):
                data_c.pop(0)                     
        except:
            pass

#Función para actualizar la gráfica
def update(num,hl, data): 
    #Se aplican los filtros 
    filtrado = butter_bandpass_filter(data,5,150,srate)   #Pasa bandas
    data = notch_filter(filtrado,60,30,srate)             #Notch 
   
    #Actualizar los valores de la gráfcica
    x = np.array(range(len(data)))
    hl.set_data(x,data)   

    return hl,

ani = animation.FuncAnimation(fig,update,fargs = (hl, datos), interval = 500, blit=True)

#Crear e inicializar el hilo que lee los datos del puerto serial
obtenerDatos = threading.Thread(target = getData, args = (datos,))
obtenerDatos.start()

#Inicializar la interfaz 
app = App()
plt.show()  
  
obtenerDatos.join()