close all;clc;

%Inicializar puerto serial
puerto = 'COM14';
delete(instrfind({'Port'},{puerto}));
pserial=serial(puerto,'BaudRate',115200);
fopen(pserial);

srate = 1000;   %frec. muestreo
t = 1;          %tiempo
m = t*srate;    %no. muestras

cont = 1;       %contador no. de muestras

data = zeros(1,m);   %array para almacenar datos del arduino
data_c = zeros(1,m); %array para almacenar datos centrados
data_f = [];         %array para almacenar datos filtro pasa bandas
data_n = [];         %array para almacenar datos filtro notch

v = 0;               
s = 0;               %bandera inicio ciclo 


promp = 'Presiona 0 + enter para inciar';
x = input(promp)                           %Recibir dato del usuario para inciar
fwrite(pserial,107,'uint8');               %Iniciar el envío de datos de arduino
tic
while s == 0;
    v = fscanf(pserial,'%d');                   %leer datos puerto serial
    if x == 0
%         if cont == 1
%             tic
%         end
        data(cont) = v(1)*5/1024;                   %convertir de 0-5 voltios
        data_c(cont) = data(cont) - mav(data);      %centrar datos  
        cont = cont +1;                             %aumentar contador
        if(cont == (m+1))                           %evaluar longitud del contador
            toc
            F_pb = filtroPasaBandasML;              
            F_notch = filtroStopBandML;
            data_f = filter(F_pb, data_c);          %aplicar filtro pasa bandas
            data_n = filter(F_notch, data_f);       %aplicar filtro notch
            save ('señal.mat', 'data_n');           %almacenar la señal filtrada en un .mat
            x = 1;                                  %detener el ciclo
        end
    end
end

fclose(pserial);
delete(pserial);

  