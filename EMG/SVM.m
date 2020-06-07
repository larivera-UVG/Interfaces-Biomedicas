%% CLASIFICACI�N CON SVM
%Mar�a Fernanda Gir�n, 16820
%Dise�o e Innovaci�n, secci�n: 10

%Utilizando la librer�a libsvm disponible para matlab
%% EXTRACCI�N CARACTER�STICAS
%tine 6 clases (2 canales x clase)(30 veces cada mov. 3000 puntos de la se�al.)
%Separar y extraer features, para crear la matriz con el formato correcto.
load data.mat

labels = labels_r;
data = data_r;
clase = 6;                           %no. clases
muestras = 180;                      %no. muestras

%Extracci�n caracter�sticas para cada canal
for i = 1:muestras
    v_mav(i,:) = [mav(data(i,1:3000)),mav(data(i,3001:end))];
    v_zc(i,:) = [zc(data(i,1:3000),0),zc(data(i,3001:end),0)];
    v_iemg(i,:) = [emg(data(i,1:3000)),emg(data(i,3001:end))];
    v_rms(i,:) = [rms(data(i,1:3000)),rms(data(i,3001:end))];
    v_wl(i,:) = [wl(data(i,1:3000)),wl(data(i,3001:end))];
    v_var(i,:) = [varianza(data(i,1:3000)),varianza(data(i,3001:end))];
    v_desv(i,:) = [desv(data(i,1:3000)),desv(data(i,3001:end))];
end

features = [v_mav,v_zc,v_iemg,v_wl,v_rms];   %Vector de caracter�sticas

fs = sparse(features);
libsvmwrite('DB',labels,fs); %formato especial de la librer�a 
[X,Y] = libsvmread('DB');    %X = labels; Y = features

%Dividir los datos para validaci�n cruzada
X_div = reshape(X,[36,5]);
Y_1 = Y(1:36,:);
Y_2 = Y(37:72,:);
Y_3 = Y(73:108,:);
Y_4 = Y(109:144,:);
Y_5 = Y(145:180,:);

%% SVM

M = 0;
M2 = 0;
%Five fold cross validation (80% train 20% test)
for i = 1:5
    switch i
        case 1
            X_test = X_div(:,i);
            X_train = X_div;
            X_train(:,i) = [];
            X_train = reshape(X_train,[180-36,1]);
            Y_test = Y_1;
            Y_train = [Y_2;Y_3;Y_4;Y_5];
        case 2
            X_test = X_div(:,i);
            X_train = X_div;
            X_train(:,i) = [];
            X_train = reshape(X_train,[180-36,1]);
            Y_test = Y_2;
            Y_train = [Y_1;Y_3;Y_4;Y_5];
        case 3
            X_test = X_div(:,i);
            X_train = X_div;
            X_train(:,i) = [];
            X_train = reshape(X_train,[180-36,1]);
            Y_test = Y_3;
            Y_train = [Y_1;Y_2;Y_4;Y_5];
        case 4
            X_test = X_div(:,i);
            X_train = X_div;
            X_train(:,i) = [];
            X_train = reshape(X_train,[180-36,1]);
            Y_test = Y_4;
            Y_train = [Y_1;Y_2;Y_3;Y_5];
        case 5
            X_test = X_div(:,i);
            X_train = X_div;
            X_train(:,i) = [];
            X_train = reshape(X_train,[180-36,1]);
            Y_test = Y_5;
            Y_train = [Y_1;Y_2;Y_3;Y_4];
    end

    % Kernel Lineal
    model_linear = svmtrain(X_train, Y_train, '-t 0 -h 0 -q');  %entrenamiento 
    [predict_label_L, accuracy_L, dec_values_L] = svmpredict(X_test,Y_test, model_linear);  %clasificaci�n
    A2(i) = accuracy_L(1,1);
    M2 = M2 + confusionmat(X_test,predict_label_L);    %matriz confusi�n
     
    %Kernel Polinomial 
    model_pol = svmtrain(X_train, Y_train, '-t 1 -h 0 -q');   %entrenamiento 
    [predict_label_P, accuracy_P, dec_values_P] = svmpredict(X_test,Y_test, model_pol);   %clasificaci�n
    A(i) = accuracy_P(1,1);
    M = M + confusionmat(X_test,predict_label_P);      %matriz confusi�n
end

acP = mean(A)    %accuracy promedio kernel polinomial
acL = mean(A2)   %accuracy promedio kernel lineal
M_L = M2*100/muestras;     %matriz de confusi�n porcentajes kernel lineal
M_P = M*100/muestras;      %matriz de confusi�n porcentajes kernel polinomial


