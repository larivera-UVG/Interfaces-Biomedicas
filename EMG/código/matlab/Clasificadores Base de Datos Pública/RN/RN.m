%% CLASIFICACIÓN CON RN PARA SEÑALES DE LA BASE DE DATOS PÚBLICA
%María Fernanda Girón, 16820
%Diseño e Innovación, sección: 10
clear;clc;
%% EXTRACCIÓN CARACTERÍSTICAS
%tine 6 clases (2 canales x clase)(30 veces cada mov. 3000 puntos de la señal.)
%Separar y extraer features, para crear la matriz con el formato correcto.
load RN_female3.mat

labels = labels;
data = data;
clase = 6;                    %no. clases
muestras = 180;               %no. muestras

%Extracción características
for i = 1:muestras
    v_mav(i,:) = [mav(data(i,1:3000)),mav(data(i,3001:end))];
    v_zc(i,:) = [zc(data(i,1:3000),0),zc(data(i,3001:end),0)];
    v_iemg(i,:) = [emg(data(i,1:3000)),emg(data(i,3001:end))];
    v_rms(i,:) = [rms(data(i,1:3000)),rms(data(i,3001:end))];
    v_wl(i,:) = [wl(data(i,1:3000)),wl(data(i,3001:end))];
    v_var(i,:) = [varianza(data(i,1:3000)),varianza(data(i,3001:end))];
    v_desv(i,:) = [desv(data(i,1:3000)),desv(data(i,3001:end))];
end
features = [v_mav,v_zc,v_wl,v_iemg,v_rms,v_var,v_desv];   %Características

%% REDES NEURONALES
% Script generado con Neural Pattern Recognition app

x = features';   %características
t = labels';     %etiquetas

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainlm';  % Scaled conjugate gradient backpropagation.

% Crear una red para reconocimiento de patrones
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize, trainFcn);

% Dividir los datos en entrenamiento, validación y prueba. 
net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio = 20/100;
net.divideParam.testRatio = 20/100;

% Entrenamiento de la red neuronal
[net,tr] = train(net,x,t);

% Test de la red neuronal
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y);
tind = vec2ind(t);      %clases originales/reales
yind = vec2ind(y);      %clases predichas
percentErrors = sum(tind ~= yind)/numel(tind);

% Ver la red neuronal
%view(net)

% Plots
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotconfusion(t,y);
%figure, plotroc(t,y)

