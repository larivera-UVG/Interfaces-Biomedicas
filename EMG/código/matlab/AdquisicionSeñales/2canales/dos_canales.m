%% ALGORITMO DE ADQUISICIÓN DE SEÑALES sEMG E IDENTIFICACIÓN DE ACTIVIDAD 
%LECTURA DATOS DEL BITALINO DOS CANALES
close all;clc;

%Inicializar puerto serial
puerto = 'COM3';
delete(instrfind({'Port'},{puerto}));
pserial=serial(puerto,'BaudRate',115200,'Timeout',10);
fopen(pserial);

srate = 1000;     %Frec. muestreo
t_inicio = 2000;  %Tiempo inicial sin mov. en ms
t = 1;            %Tiempo total en segundos
t_m = t*0.95;     %Tiempo mov.
t_r = t*0.05;     %Tiempo sin mov.
m = t*srate;      %No. muestras totales
m_m = t_m*srate;  %No. muestras mov.
m_r = t_r*srate;  %No. muestras sin mov.

cont = 1;         %Contador no. de muestras
cont_r = 1;       %Contador no. de muestras anteriores sin mov.
cont_f = 0;       %Contador no. grabaciones
grab = 25;        %No. grabaciones

canales = 2;                  %No. canales
data = zeros(canales,m_m);    %Array para almacenar datos con movimiento
data_c = zeros(canales,m);    %Array para almacenar datos centrados 
data_r = zeros(canales,m_r);  %Array para almacenar un tiempo sin mov.
data_f = [];                  %Array para almacenar datos filtro pasa bandas
data_n = [];                  %Array para almacenar datos filtro notch

canal_1 = zeros(grab,m);                   %Almacenar todas las corridas canal 1
canal_2 = zeros(grab,m);                   %Almacenar todas las corridas canal 2
almacenar = zeros(grab,2*m);               %Almacenar canales juntos

F_pb = filtro_pasa_banda(srate,20,450);    %Diseñar filtro pasa banda       
F_notch = filtro_rechaza_banda(srate);     %Diseñar filtro rechaza banda 

%Inicializar variables
v = 0;
v2 = zeros(1,canales);    
volt = 0;     
ga = 0.15;                                 %Tolerancia threshold
b_act = 0;                                 %Bandera para detectar actividad

%Detalles gráfica
figure(1); clf;
subplot(2,1,1);
h1 = plot(1:m,zeros(1,m));
xlim([0,m]);
title('Canal 1');
subplot(2,1,2);
h2 = plot(1:m,zeros(1,m));
xlim([0,m]);
title('Canal 2');

th = identificacion2(pserial,t_inicio);    %Identificar el valor del threshold

while cont_f < grab
    for n = 1:canales
        v = fscanf(pserial,'%d');          %Leer datos puerto serial, convertir de 0-5V
        if(isempty(v) == 1)
            v = fscanf(pserial,'%d');
        end
        v2(n) = v(1)*5/1024;                %Almacenar una ventada de muestras anteriores al mov.
    end  
    volt = max([v2(1),v2(2)]);   %Obtener el valor máximo del voltaje entre ambos canales
   
    %Detectar inicio de actividad
    if volt > (th + ga) && b_act == 0 && volt < 5 && cont_r > 25
        %Activar bandera de inicio de actividad
        b_act = 1;
    end
    
    if b_act == 0
        data_r(1,cont_r) = v2(1);        %Almaceno una ventana de muestras anteriores al mov.
        data_r(2,cont_r) = v2(2); 
        cont_r = cont_r + 1;             
        if cont_r == m_r + 1             %Reset el contador para las muestras anteriores al mov.
            cont_r = 1;
        end
    else   
        for n = 1:canales
            data(n,cont) = v2(n);        %Guardo la señal activa
        end
        data_c = [data_r - mav(data_r),data - mav(data)];       %Centrar datos
        data_f = filter(F_pb, data_c);                          %Aplicar filtro pasa bandas
        data_n = filter(F_notch, data_f);                       %Aplicar filtro notch
        %h1.YData(cont) = data_n(1,cont);                       %Actualizar gráfica
        %h2.YData(cont) = data_n(2,cont); 
        %drawnow limitrate
        cont = cont +1;                                            
        if(cont == (m_m+1))                                  %Evaluar longitud del contador
            h1.YData = data_n(1,:);                          %Actualizar gráfica
            h2.YData = data_n(2,:); 
            drawnow limitrate
            cont = 1;                                        %Reiniciar contadores
            cont_r = 1;
            cont_f = cont_f + 1;                             %Aumentar contador para no. de grabaciones
            b_act = 0;                                       %Reiniciar bandera de actividad
            canal_1(cont_f,:) = data_n(1,:);                 %Almacenar todas las corridas 
            canal_2(cont_f,:) = data_n(2,:);                        
            almacenar(cont_f,:) = [data_n(1,:),data_n(2,:)];
        end
    end
    
end

fclose(pserial);
delete(pserial);
%save('corridas.mat', 'canal_1','canal_2','almacenar');       %Almacenar todas las señales filtradas en un .mat
