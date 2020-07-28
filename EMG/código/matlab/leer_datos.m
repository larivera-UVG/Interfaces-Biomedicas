%% ALGORITMO DE ADQUISICIÓN DE SEÑALES sEMG E IDENTIFICACIÓN DE ACTIVIDAD
close all;clc;

%Inicializar puerto serial
puerto = 'COM14';
delete(instrfind({'Port'},{puerto}));
pserial=serial(puerto,'BaudRate',115200);
fopen(pserial);

srate = 1000;     %Frec. muestreo
t_inicio = 1000;  %Tiempo inicial sin mov. en ms
t = 1;            %Tiempo total
t_m = t*0.85;     %Tiempo mov.
t_r = t*0.15;     %Tiempo sin mov.
m = t*srate;      %No. muestras totales
m_m = t_m*srate;  %No. muestras mov.
m_r = t_r*srate;  %No. muestras sin mov.

cont = 1;         %Contador no. de muestras
cont_r = m_r;     %Contador no. de muestras anteriores sin mov.
cont_f = 0;       %Contador no. grabaciones
grab = 2;         %No. grabaciones

data = zeros(1,m_m);    %Array para almacenar datos con movimiento
data_c = zeros(1,m);    %Array para almacenar datos centrados 
data_r = zeros(1,m_r);  %Array para almacenar un tiempo sin mov.
data_f = [];            %Array para almacenar datos filtro pasa bandas
data_n = [];            %Array para almacenar datos filtro notch

almacenar = zeros(grab,m);                 %Almacenar todas las corridas

F_pb = filtroPasaBandasML(srate,50,200);   %Diseñar filtro pasa bandas         
F_notch = filtroStopBandML(srate);         %Diseñar filtro notch 

%Inicializar variables
v = 0;    
volt = 0;     
ga = 0.05;                                 %Tolerancia threshold
b_act = 0;                                 %Bandera para detectar actividad

%Detalles gráfica
figure(1); clf;
h = plot(1:m,zeros(1,m));
xlim([0,m]);

th = identificacion(pserial,t_inicio);     %Identificar el valor del threshold

while cont_f < grab
    v = fscanf(pserial,'%d');              %Leer datos puerto serial
    volt = v(1)*5/1024;                    %Convertir de 0-5V
    data_r(cont_r) = volt;                 %Almacenar una ventada de muestras anteriores al mov.
    cont_r = cont_r - 1;
    
    if volt > (th + ga) && b_act == 0      
        %Activar bandera de inicio de actividad
        b_act = 1
    end
    
    if b_act == 1                                                   
        data(cont) = volt;                                          %Guardo la señal activa
        cont = cont +1;                                            
        if(cont == (m_m+1))                                         %Evaluar longitud del contador
            data_c = [data_r - mav(data_r),data - mav(data)];       %Centrar datos
            data_f = filter(F_pb, data_c);                          %Aplicar filtro pasa bandas
            data_n = filter(F_notch, data_f);                       %Aplicar filtro notch
            cont = 1;                                               %Reiniciar contador
            cont_f = cont_f + 1;                                    %Aumentar contador para no. de grabaciones
            b_act = 0                                               %Reiniciar bandera de actividad
            almacenar(cont_f,:) = data_n;                           %Almacenar todas las corridas 
            h.YData = data_n;                                       %Actualizar gráfica
            drawnow limitrate
        end
    end
    
    if cont_r == 0                          %Reset el contador para las muestras anteriores al mov.
        cont_r = m_r;
    end 
end

fclose(pserial);
delete(pserial);
%save('corridas.mat', 'almacenar');          %Almacenar todas las señales filtradas en un .mat