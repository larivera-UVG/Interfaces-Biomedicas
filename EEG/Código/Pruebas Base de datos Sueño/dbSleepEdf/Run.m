% -------------------------------------------------------------------------
% Autor: José Pablo Muñoz 
% Descripción: Código para correr un número determinado de veces
% los códigos de clasificadores
% -------------------------------------------------------------------------
runs = 10; 
results = zeros(2,runs);

for i = 1:runs
    run Neural_Network.m
    %run Pruebas_SVM_y_otros.m
    results(1,i) = round(100 - 100*percentErrors,1);
    %results(2,i) = round(100 - 100*genError1,1); 
end

prom = mean(results(1,:))

