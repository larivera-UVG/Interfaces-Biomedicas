% -------------------------------------------------------------------------
% Autor: Jos� Pablo Mu�oz 
% Descripci�n: C�digo para generar una matriz de confusi�n a partir 
% de los outputs generados por Neural_Network.m 
% -------------------------------------------------------------------------

targets = Target_Vector;

outputs = net(Input_Vector);
[~, clase_asign] = max(outputs,[],1);

figure(2);
plotconfusion(targets,outputs);

tind = vec2ind(targets);
yind = vec2ind(outputs);
percentErrors = sum(tind ~= yind)/numel(tind);
% Porcentaje de acierto
result_2 = round(100 - 100*percentErrors,1);