%% PRUEBA ADQUISICI�N DE DATOS E IDENTIFICACI�N DE ACTIVIDAD
%2 SEGUNDOS DE CERO MOV. EN TIEMPO REAL

close all;clc;

%Inicializar puerto serial
puerto = 'COM14';
delete(instrfind({'Port'},{puerto}));
pserial=serial(puerto,'BaudRate',115200);
fopen(pserial);

srate = 1000;     %frec. muestreo
t = 1;            %tiempo total
t_m = 0.80;       %tiempo mov.
t_r = 0.20;       %tiempo sin mov.
m = t*srate;      %no. muestras totales
m_m = t_m*srate;  %no. muestras mov.
m_r = t_r*srate;  %no. muestras sin mov.


cont = 1;       %contador no. de muestras
cont_s = 1;     %contador no. muestras sin mov.
cont_r = m_r;   %contador no. de muestras anteriores sin mov.
cont_f = 0;     %contador detener comunicaci�n
grab = 2;       %no. grabaciones

data = zeros(1,m_m);    %array para almacenar datos con movimiento
data_c = zeros(1,m);    %array para almacenar datos centrados
data_s = zeros(1,2000); %array para almacenar datos del puerto serial 
data_r = zeros(1,m_r);  %array para almacenar 0.25s sin mov.
data_f = [];            %array para almacenar datos filtro pasa bandas
data_n = [];            %array para almacenar datos filtro notch

almacenar = zeros(grab,m);      %almacenar todas las corridas

v = 0;    
volt = 0;     
s = 0;               %bandera inicio ciclo 
r = 0;               %bandera para los 2 sec de ruido

F_pb = filtroPasaBandasML(srate,50,150);   %Dise�ar filtro pasa bandas         
F_notch = filtroStopBandML(srate);         %Dise�ar filtro notch 

th = 0;
ga = 0.1;
b_act = 0; 
x = 1;  %solo para probar

%DETALLES GR�FICA
% figure(1); clf;
% h = plot(1:m,zeros(1,m));
% xlim([0,m]);

promp = 'Presiona 0 + enter para inciar';
x = input(promp)                           %Recibir dato del usuario para inciar
fwrite(pserial,107,'uint8');               %Iniciar el env�o de datos desde arduino

while x == 0 && cont_f < grab
    v = fscanf(pserial,'%d');              %leer datos puerto serial
    volt = v(1)*5/1024;
    data_r(cont_r) = volt;
    cont_r = cont_r - 1;
    
    if cont_s < 2001 && r == 0 
        data_s(cont_s) = volt;
        cont_s = cont_s + 1;                %aumentar contador      
    elseif cont_s == 2001 && r == 0         %capturar los dos segundos sin mov. para encontrar th   
        th = max(abs(data_s));
        cont_s = 1;
        r = 1;
        disp("DONE");
    end
    
    if cont_r == 0                          %reset el contador para las muestras anteriores al mov.
        cont_r = m_r;
    end 
   
    if (volt > (th + ga) && b_act == 0 && r == 1
        %activar bandera de inicio de actividad
        b_act = 1
    end
    
    if b_act == 1                                                   %guardo la se�al activa
        data(cont) = volt;                                          %convertir de 0-5 voltios 
        cont = cont +1;                                             %aumentar contador
        if(cont == (m_m+1))                                         %evaluar longitud del contador
            data_c = [data_r - mav(data_r),data - mav(data)];       %centrar datos
            data_f = filter(F_pb, data_c);                          %aplicar filtro pasa bandas
            data_n = filter(F_notch, data_f);                       %aplicar filtro notch
            cont = 1;                                               %reiniciar contador
            cont_f = cont_f + 1;                                    %aumentar no. co
            b_act = 0;                                              %reiniciar bandera de actividad
            almacenar(cont_f,:) = data_n;                           %Almacenar todas las corridas 
            %plot(data_n);
            %h.YData = data_n;
            %drawnow limitrate
        end
    end
        
end

fclose(pserial);
delete(pserial);
%save('corridas.mat', 'almacenar');           %almacenar todas las se�ales filtradas en un .mat