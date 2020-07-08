%% ORGANIZAR LOS DATOS
%María Fernanda Girón, 16820
%Diseño e Innovación, sección: 10

%En este sript se organizan los datos según cada clasificador.
%Se crea el vector o la matriz que contiene las etiquetas correspondientes
%a cada clase. 

%% BASE DE DATOS (6 clases para SVM)

load female_1

c1 = cyl_ch1;
c1_2 = cyl_ch2;
c2 = hook_ch1;
c2_2 = hook_ch2;
c3 = lat_ch1;
c3_2 = lat_ch2;
c4 = palm_ch1;
c4_2 = palm_ch2;
c5 = spher_ch1;
c5_2 = spher_ch2;
c6 = tip_ch1;
c6_2 = tip_ch2;

data = [c1,c1_2;c2,c2_2;c3,c3_2;c4,c4_2;c5,c5_2;c6,c6_2];  %Unir las muestras
N = size(c1,1);

labels = [ones(N,1);2*ones(N,1);3*ones(N,1);4*ones(N,1);5*ones(N,1);6*ones(N,1)]; %Vector de etiquetas
n = size(labels,1);

r = randn(180,10);   %Ordenas las muestras en un orden random
rand_num = randperm(size(r,1));
data_r = data(rand_num(1:round(length(rand_num))),:);  
labels_r = labels(rand_num(1:round(length(rand_num))),:);
save ('data_svm.mat', 'labels_r', 'data_r');    %Almacenar los datos para importar en SVM


%% 6 clases para Redes Neuronales
load female_1

c1 = cyl_ch1;
c1_2 = cyl_ch2;
c2 = hook_ch1;
c2_2 = hook_ch2;
c3 = lat_ch1;
c3_2 = lat_ch2;
c4 = palm_ch1;
c4_2 = palm_ch2;
c5 = spher_ch1;
c5_2 = spher_ch2;
c6 = tip_ch1;
c6_2 = tip_ch2;

data = [c1,c1_2;c2,c2_2;c3,c3_2;c4,c4_2;c5,c5_2;c6,c6_2];  %Unir las muetras
N = size(c1,1);
m = 180;
c = 6;

labels = zeros(m,c);            %Etiquetas en el formato requerido.
labels(1:30,1)=ones(30,1);
labels(31:60,2)=ones(30,1);
labels(61:90,3)=ones(30,1);
labels(91:120,4)=ones(30,1);
labels(121:150,5)=ones(30,1);
labels(151:180,6)=ones(30,1);

% r = randn(180,10);   %La separación en random
% rand_num = randperm(size(r,1));
% data_r = data(rand_num(1:round(length(rand_num))),:);  
% labels_r = labels(rand_num(1:round(length(rand_num))),:);
save ('RN_female.mat', 'labels', 'data'); 
