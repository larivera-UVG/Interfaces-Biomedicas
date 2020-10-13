%% CLASIFICACIÓN CON SVM PARA BASE DE DATOS PÚBLICA
%María Fernanda Girón, 16820
%Diseño e Innovación, sección: 10

%Utilizando la librería libsvm disponible para matlab
%% EXTRACCIÓN CARACTERÍSTICAS
%tine 6 clases (2 canales x clase)(30 veces cada mov. 3000 puntos de la señal.)
%Separar y extraer features, para crear la matriz con el formato correcto.
load SVM_female1.mat    %Cargar información del sujeto de prueba

labels = labels_r;
data = data_r;
clase = 6;                           %no. clases
muestras = 180;                      %no. muestras
lim = muestras*0.80;

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

features = [v_mav,v_zc,v_wl,v_rms];   %Vector de características

fs = sparse(features);
libsvmwrite('DB',labels,fs); %formato especial de la librería
[X,Y] = libsvmread('DB');    %X = labels; Y = features

%Dividir entre datos de entrenamiento y de prueba
X_train = X(1:lim,:);
Y_train = Y(1:lim,:);
X_test =  X(lim+1:muestras,:);
Y_test = Y(lim+1:muestras,:);
%% SVM
%Five fold cross validation colocar '-v 5' en las opciones esto no devuelve
%un modelo solo el valor de accuracy con el fin de establecer buenos
%parámetros y luego se puede volver a entrenar el clasificador con dichos
%parámetros.

% Kernel Lineal
model_linear = svmtrain(X_train, Y_train, '-t 0 -h 0 -q ' );  %entrenamiento 
[predict_label_L, accuracy_L, dec_values_L] = svmpredict(X_test,Y_test, model_linear);  %clasificación

%Kernel Polinomial 
model_pol = svmtrain(X_train, Y_train, '-t 1 -h 0 -q ');   %entrenamiento 
[predict_label_P, accuracy_P, dec_values_P] = svmpredict(X_test,Y_test, model_pol);   %clasificación

%MATRICES DE CONFUSIÓN
X_test_t = full(ind2vec(X_test',6));
predict_label_L_t = full(ind2vec(predict_label_L',6));
figure(1), plotconfusion(X_test_t,predict_label_L_t);
title("Kernel Lineal")

predict_label_P_t = full(ind2vec(predict_label_P',6));
figure(2), plotconfusion(X_test_t,predict_label_P_t);
title("Kernel Polinomial")


