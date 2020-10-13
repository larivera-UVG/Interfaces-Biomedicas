%% CLASIFICACIÓN CON RN BASE DE DATOS PROPIA
%4 clases (2 canales x clase)(40 veces cada mov. 1000 puntos de la señal.)
clear; clc;

% EXTRACCIÓN CARACTERÍSTICAS ENTRENAMIENTO
load DATABASE_PROPIA3.mat

clase = 4;          %no. clases
m = 40;             %no. muestras x clase
muestras = clase*m; %no. muestras totales
n = 500;            %no. puntos x canal
n2 = 1000;
n3 = 1500;
end1 = 2000;
accuracy_rn = zeros(1,10);
accuracy_rn_t = zeros(1,10);

%Extracción características (usando el método de dividir los canales en 2
%secciones) para los datos de entrenamiento.
for i = 1:muestras
    v_mav(i,:) = [mav(data(i,1:n)),mav(data(i,n+1:n2)),mav(data(i,n2+1:n3)),mav(data(i,n3+1:end))];
    v_zc(i,:) = [zc(data(i,1:n),0),zc(data(i,n+1:n2),0),zc(data(i,n2+1:n3),0),zc(data(i,n3+1:end),0)];
    v_iemg(i,:) = [emg(data(i,1:n)),emg(data(i,n+1:n2)),emg(data(i,n2+1:n3)),emg(data(i,n3+1:end))];
    v_rms(i,:) = [rms(data(i,1:n)),rms(data(i,n+1:n2)),rms(data(i,n2+1:n3)),rms(data(i,n3+1:end))];
    v_wl(i,:) = [wl(data(i,1:n)),wl(data(i,n+1:n2)),wl(data(i,n2+1:n3)),wl(data(i,n3+1:end))];
    v_var(i,:) = [varianza(data(i,1:n)),varianza(data(i,n+1:n2)),varianza(data(i,n2+1:n3)),varianza(data(i,n3+1:end))];
    v_desv(i,:) = [desv(data(i,1:n)),desv(data(i,n+1:n2)),desv(data(i,n2+1:n3)),desv(data(i,n3+1:end))];
end
features = [v_mav,v_zc,v_wl,v_rms];   %Características

%EXTRACCIÓN DE CARACTERÍSTICAS PRUEBA
load 'datos_test_1.mat'                
muestras_t = 20;    %no. muestras

%Extracción características (usando el método de dividir los canales en 2
%secciones) para los datos de prueba.
for i = 1:muestras_t
    v_mav_t(i,:) = [mav(data_t(i,1:n)),mav(data_t(i,n+1:n2)),mav(data_t(i,n2+1:n3)),mav(data_t(i,n3+1:end))];
    v_zc_t(i,:) = [zc(data_t(i,1:n),0),zc(data_t(i,n+1:n2),0),zc(data_t(i,n2+1:n3),0),zc(data_t(i,n3+1:end),0)];
    v_iemg_t(i,:) = [emg(data_t(i,1:n)),emg(data_t(i,n+1:n2)),emg(data_t(i,n2+1:n3)),emg(data_t(i,n3+1:end))];
    v_rms_t(i,:) = [rms(data_t(i,1:n)),rms(data_t(i,n+1:n2)),rms(data_t(i,n2+1:n3)),rms(data_t(i,n3+1:end))];
    v_wl_t(i,:) = [wl(data_t(i,1:n)),wl(data_t(i,n+1:n2)),wl(data_t(i,n2+1:n3)),wl(data_t(i,n3+1:end))];
    v_var_t(i,:) = [varianza(data_t(i,1:n)),varianza(data_t(i,n+1:n2)),varianza(data_t(i,n2+1:n3)),varianza(data_t(i,n3+1:end))];
    v_desv_t(i,:) = [desv(data_t(i,1:n)),desv(data_t(i,n+1:n2)),desv(data_t(i,n2+1:n3)),desv(data_t(i,n3+1:end))];
end
features_t = [v_mav_t,v_zc_t,v_wl_t,v_rms_t];   %Características

%% REDES NEURONALES
% Script generado con Neural Pattern Recognition app
x = features';   %características
t = labels;      %etiquetas
trainFcn = 'trainlm';  % Scaled conjugate gradient backpropagation.

% Crear una red para reconocimiento de patrones
hiddenLayerSize = 15;

%El entrenamiento y clasificación se realiza 10 veces
for i = 1:10
    t_inicial_rn = tic;
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
    accuracy_rn(1,i) = (1-percentErrors)*100;
    
    %EVALUAR LA RED NEURONAL CON LOS DATOS DE PRUEBA 
    x_prueba = features_t';             %features de prueba
    y_prueba = net(x_prueba);
    clase_prueba = vec2ind(y_prueba);   %contiene la etiqueta predichas
    clase_real = vec2ind(labels_t);
    percentErrors_t = sum(clase_real ~= clase_prueba)/numel(clase_real);
    accuracy_rn_t(1,i) = (1-percentErrors_t)*100;
    t_final_rn = toc(t_inicial_rn);     %rendimiento
end

A_RN = mean(accuracy_rn);         %rendimiento promedio datos de entrenamiento
A_RN_t = mean(accuracy_rn_t);     %rendimiento promedio datos de prueba   

%Matriz de confusión
figure(1), plotconfusion(labels_t,y_prueba);
title("Redes Neuronales")

%% SVM LINEAL PARA BASE DE DATOS PROPIA

accuracy_svm = zeros(1,10);
r = randn(muestras,10);   %Ordenas las muestras en un orden random
rand_num = randperm(size(r,1));
features_svm = features(rand_num(1:round(length(rand_num))),:);  
l = labels_svm';
labels_svm = l(rand_num(1:round(length(rand_num))),:);

r_t = randn(muestras_t,10);   %Ordenas las muestras en un orden random
rand_num_t = randperm(size(r_t,1));
features_svm_t = features_t(rand_num_t(1:round(length(rand_num_t))),:);  
l_t = labels_svm_t';
labels_svm_t = l_t(rand_num_t(1:round(length(rand_num_t))),:);

%Establecer el formato para los datos de entrenamiento
fs = sparse(features_svm);
libsvmwrite('DB',labels_svm,fs); %formato especial de la librería
[X_train,Y_train] = libsvmread('DB');    %X = labels; Y = features

%Establecer el formato para los datos de prueba
fs_t = sparse(features_svm_t);
libsvmwrite('DB_t',labels_svm_t,fs_t); %formato especial de la librería
[X_test,Y_test] = libsvmread('DB_t');    %X = labels; Y = features


%Kernel Lineal
%El entrenamiento y clasificación se realiza 10 veces
for i = 1:10
    model_linear = svmtrain(X_train, Y_train, '-t 0 -h 0 -q ' );  %entrenamiento 
    [predict_label_L, accuracy_L, dec_values_L] = svmpredict(X_test,Y_test, model_linear);  %clasificación

    accuracy_svm(:,i) = accuracy_L(1);
end

A_SVM = mean(accuracy_svm);

%Matriz de confusión
X_test_t = full(ind2vec(X_test',4));
predict_label_L_t = full(ind2vec(predict_label_L',4));
figure(2), plotconfusion(X_test_t,predict_label_L_t);
title("SVM lineal")
