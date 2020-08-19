%% Pruebas SVM multiclase y otros clasificadores
% Luis Alberto Rivera

%load('L15_datos.mat');

% Gráfica de muestras originales
% figure(1); clf;
% scatter3(X1(:,1),X1(:,2),X1(:,3),'b');
% hold on;
% scatter3(X2(:,1),X2(:,2),X2(:,3),'r');
% scatter3(X3(:,1),X3(:,2),X3(:,3),'g');
% grid on;
% xlabel('x1'); ylabel('x2'); zlabel('x3');
% legend('Clase 1','Clase 2','Clase 3');
% title('Muestras Originales');

%% Entrenamiento de modelo SVM
%X = [Datos{1,1};Datos{1,2};Datos{1,3};Datos{1,4}];
X = Input_Vector';
if (classes == 4)
    Etiquetas = [ones(cont_W,1);2*ones(cont_S1,1);3*ones(cont_S2,1); 4*ones(cont_S3,1)];
else
    Etiquetas = [ones(size(Datos{1,1},2),1);2*ones(size(Datos{1,2},2),1);3*ones(size(Datos{1,3},2),1); 4*ones(size(Datos{1,4},2),1);5*ones(size(Datos{1,5},2),1)];
end
% SVM
% t1 = templateSVM('KernelFunction','gaussian');
% t1 = templateSVM('KernelFunction','polynomial','PolynomialOrder',3);
% Mdl1 = fitcecoc(X,Etiquetas,'Learners',t1,'Verbose',2);
tic;
Mdl1 = fitcecoc(X,Etiquetas,'Learners','svm','Verbose',2);
t_entreno = toc;

tic;
CVMdl1 = crossval(Mdl1);
t_cval = toc;

genError1 = kfoldLoss(CVMdl1);

% KNN
% Mdl2 = fitcecoc(X,Etiquetas,'Learners','knn','Verbose',2);
% CVMdl2 = crossval(Mdl2);
% genError2 = kfoldLoss(CVMdl2)

% % Discriminant
% Mdl3 = fitcecoc(X,Etiquetas,'Learners','discriminant','Verbose',2);
% CVMdl3 = crossval(Mdl3);
% genError3 = kfoldLoss(CVMdl3)

%% Clasificación
% Xtest = [5,-1,0;2,-1,2;3,1,5];
% Resultados1 = predict(Mdl1,Xtest);
% Resultados2 = predict(Mdl2,Xtest);


