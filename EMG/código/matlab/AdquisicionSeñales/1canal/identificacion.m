%% FUNCIÓN PARA DETERMINAR EL THRESHOLD
function [th,data_s] = identificacion(pserial,t)

data_s = zeros(1,t); %array para almacenar datos del puerto serial
cont_s = 1;          %contador no. muestras sin mov.

promp = 'Presiona 0 + enter para inciar';
x = input(promp);                           %Recibir dato del usuario para inciar
fwrite(pserial,107,'uint8');               %Iniciar el envío de datos desde arduino

while cont_s < (t + 1)
    v = fscanf(pserial,'%d')*5/1024;       %Leer datos puerto serial
    if(isempty(v) == 1)
        v = fscanf(pserial,'%d')*5/1024;
    end
    data_s(cont_s) = v(1);                 %Almacenar valores 
    cont_s = cont_s + 1;   
end

th = max(abs(data_s));                     %Determinar threshold
end
