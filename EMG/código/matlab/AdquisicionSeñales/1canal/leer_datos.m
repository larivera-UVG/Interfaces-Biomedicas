%% ALGORITMO DE ADQUISICIÓN DE SEÑALES sEMG E IDENTIFICACIÓN DE ACTIVIDAD
%LECTURA DATOS DEL BITALINO UN CANAL
close all;clc;

%Inicializar puerto serial
puerto = 'COM3';
delete(instrfind({'Port'},{puerto}));
pserial=serial(puerto,'BaudRate',115200,'Timeout',50);
fopen(pserial);

srate = 1000;     %Frec. muestreo
t_inicio = 2000;  %Tiempo inicial sin mov. en ms
t = 1;            %Tiempo total en segundos
t_m = t*0.90;     %Tiempo mov.
t_r = t*0.10;     %Tiempo sin mov.
m = t*srate;      %No. muestras totales
m_m = t_m*srate;  %No. muestras mov.
m_r = t_r*srate;  %No. muestras sin mov.

cont = 1;         %Contador no. de muestras
cont_r = 1;       %Contador no. de muestras anteriores sin mov.
cont_f = 0;       %Contador no. grabaciones

data = zeros(1,m_m);    %Array para almacenar datos con movimiento
data_c = zeros(1,m);    %Array para almacenar datos centrados 
data_r = zeros(1,m_r);  %Array para almacenar un tiempo sin mov.
data_f = [];            %Array para almacenar datos filtro pasa bandas
data_n = [];            %Array para almacenar datos filtro notch

grab = 10;                                 %No. grabaciones
almacenar = zeros(grab,m);                 %Almacenar todas las corridas

%50-200
F_pb = filtro_pasa_banda(srate,20,450);    %Diseñar filtro pasa banda       
F_notch = filtro_rechaza_banda(srate);     %Diseñar filtro rechaza banda 

%Inicializar variables
v = 0;    
volt = 0;     
ga = 0.2;                                 %Tolerancia threshold
b_act = 0;                                %Bandera para detectar actividad

%Detalles gráfica
figure(1); clf;
h = plot(1:m,zeros(1,m));
xlim([0,m]);
error = 0;

[th,data_s] = identificacion(pserial,t_inicio);     %Identificar el valor del threshold

while cont_f < grab
    v = fscanf(pserial,'%d');             %Leer datos puerto serial
    if(isempty(v) == 1)
        v = fscanf(pserial,'%d');
    end
    volt = v(1)*5/1024;                   %Convertir de 0-5V
    
    %Detectar inicio de actividad
    if volt > (th + ga) && volt < 4 && b_act == 0      
        %Activar bandera de inicio de actividad
        b_act = 1; 
    end
    
    if b_act == 0
        data_r(cont_r) = volt;                 %Almacenar una ventada de muestras anteriores al mov.
        cont_r = cont_r + 1;
        if cont_r == m_r + 1                   %Reset el contador para las muestras anteriores al mov.
            cont_r = 1;
        end
    else     
        data(cont) = volt;                                      %Guardo la señal activa
        data_c = [data_r - mav(data_r),data - mav(data)];       %Centrar datos
        data_f = filter(F_pb, data_c);                          %Aplicar filtro pasa bandas
        data_n = filter(F_notch, data_f);                       %Aplicar filtro notch
        h.YData(cont) = data_n(cont);                           %Actualizar gráfica
        drawnow limitrate
        cont = cont +1;                                           
        if(cont == (m_m+1))                                         %Evaluar longitud del contador
            cont = 1;                                               %Reiniciar contadores
            cont_r = 1;
            cont_f = cont_f + 1;                                    %Aumentar contador para no. de grabaciones
            b_act = 0;                                              %Reiniciar bandera de actividad
            almacenar(cont_f,:) = data_n;                           %Almacenar todas las corridas            
        end
    end
    
end

fclose(pserial);
delete(pserial);
%save('corridas.mat', 'almacenar');          %Almacenar todas las señales filtradas en un .mat