% -------------------------------------------------------------------------
% 
% Descripción: Este código permite obtener el vector de caracteríscas y
% vector de objetivos de una grabación determinada. Seguir el archivo
% README.txt para identificar cuantas características y subdivisiones se
% extraen. Al correr este código ya se pueden utilizar los códigos dentro
% de la carpeta Classifiers para entrenar un SVM o NN. El funcionamiento
% del código depende de que dentro del path esten las funciones dentro de
% la carpeta Features y las grabaciones de la carpeta Database que 
% contienen las señales EMG, EEG, EOG y el hypnograma con las anotaciones. 
% -------------------------------------------------------------------------

%Seleccionar que grabación se quiere utilizar
load('data_1')

% Extracción de señales
classes = 5; %Seleccionar si se quieren 4 (sin REM) o 5 clases
signals = 4;
ft = 7; 
numEp = length(hypnogram);
L = 3000;   % longitud de las epochs (número de muestras)
Raw_secc = cell(1,signals);

% Extraer las épocas de las señales enteras
for n = 1:numEp
    Raw_secc{1,1}(:,n) = fpz(((n-1)*L+1):n*L);
    Raw_secc{1,2}(:,n) = pz(((n-1)*L+1):n*L);
    Raw_secc{1,3}(:,n) = eog(((n-1)*L+1):n*L);
    Raw_secc{1,4}(:,n) = emg(((n-1)*L+1):n*L);
end

Labels = hypnogram';

col = 400;
Raw = cell(signals,classes);

for i = 1:classes
    for j = 1:2
        Raw{j,i} = zeros(L,col);
    end
end

cont_W = 0;
cont_S1 = 0;
cont_S2= 0;
cont_S3 = 0;
cont_S4 = 0;
cont_REM = 0;

for e = 1:signals
    for n = 1:numEp
        if(Labels(n) == 'W')
            cont_W = cont_W + 1;
            Raw{e,1}(:,cont_W) = Raw_secc{1,e}(:,n) ;
            
        elseif(Labels(n) == '1')
            cont_S1 = cont_S1 + 1;
            Raw{e,2}(:,cont_S1) = Raw_secc{1,e}(:,n) ;

        elseif(Labels(n) == '2')
            cont_S2 = cont_S2 + 1;
            Raw{e,3}(:,cont_S2) = Raw_secc{1,e}(:,n) ;

        elseif(Labels(n) == '3')
            cont_S3 = cont_S3 + 1;
            Raw{e,4}(:,cont_S3) = Raw_secc{1,e}(:,n) ;

        else
            cont_REM = cont_REM + 1;
            Raw{e,5}(:,cont_REM) = Raw_secc{1,e}(:,n);
        end
    end
    
    if (e == 1 || e == 2 || e == 3)
        cont_W = 0;
        cont_S1 = 0;
        cont_S2 = 0;
        cont_S3 = 0;
        cont_S4 = 0;
        cont_REM = 0;
    end 
end

% Quitar las columnas que sobraron
for r = 1:signals
    Raw{r,1} = Raw{r,1}(:,1:cont_W);
    Raw{r,2} = Raw{r,2}(:,1:cont_S1);
    Raw{r,3} = Raw{r,3}(:,1:cont_S2);
    Raw{r,4} = Raw{r,4}(:,1:cont_S3);
    Raw{r,5} = Raw{r,5}(:,1:cont_REM);
end

%% Extracción de características
Tag = cell(1,classes);
Tag{1,1} = zeros(classes,cont_W);
Tag{1,2} = zeros(classes,cont_S1);
Tag{1,3} = zeros(classes,cont_S2);
Tag{1,4} = zeros(classes,cont_S3);

Input = cell(1,classes);
Input{1,1} = zeros(ft,cont_W);
Input{1,2} = zeros(ft,cont_S1);
Input{1,3} = zeros(ft,cont_S2);
Input{1,4} = zeros(ft,cont_S3);

if (classes == 5)
    Tag{1,5} = zeros(classes,cont_REM);
    Input{1,5} = zeros(ft,cont_REM);
end 

% Características
for n = 1:cont_W
    Input{1,1}(1,n) = mean(abs(Raw{1,1}(:,n)));
    Input{1,1}(2,n) = metricas(Raw{1,1}(:,n),0,0);
    Input{1,1}(3,n) = MMD(Raw{1,1}(:,n));
    Input{1,1}(4,n) = bandpower(Raw{1,1}(:,n));
    Input{1,1}(5,n) = kurtosis(Raw{1,1}(:,n));
    
    Input{1,1}(6,n) = mean(abs(Raw{2,1}(:,n)));
    Input{1,1}(7,n) = metricas(Raw{2,1}(:,n),0,0);
    Input{1,1}(8,n) = MMD(Raw{2,1}(:,n));
    Input{1,1}(9,n) = bandpower(Raw{2,1}(:,n));
    Input{1,1}(10,n) = kurtosis(Raw{2,1}(:,n));
    
    Input{1,1}(11,n) = mean(abs(Raw{3,1}(:,n)));
    Input{1,1}(12,n) = metricas(Raw{3,1}(:,n),0,0);
    Input{1,1}(13,n) = MMD(Raw{3,1}(:,n));
    Input{1,1}(14,n) = bandpower(Raw{3,1}(:,n));
    Input{1,1}(15,n) = kurtosis(Raw{3,1}(:,n));
    
    Input{1,1}(16,n) = mean(abs(Raw{4,1}(:,n)));
    Tag{1,1}(1,n) = 1;
end

for n = 1:cont_S1    
    Input{1,2}(1,n) = mean(abs(Raw{1,2}(:,n)));
    Input{1,2}(2,n) = metricas(Raw{1,2}(:,n),0,0);
    Input{1,2}(3,n) = MMD(Raw{1,2}(:,n));
    Input{1,2}(4,n) = bandpower(Raw{1,2}(:,n));
    Input{1,2}(5,n) = kurtosis(Raw{1,2}(:,n));
    
    Input{1,2}(6,n) = mean(abs(Raw{2,2}(:,n)));
    Input{1,2}(7,n) = metricas(Raw{2,2}(:,n),0,0);
    Input{1,2}(8,n) = MMD(Raw{2,2}(:,n));
    Input{1,2}(9,n) = bandpower(Raw{2,2}(:,n));
    Input{1,2}(10,n) = kurtosis(Raw{2,2}(:,n));
    
    Input{1,2}(11,n) = mean(abs(Raw{3,2}(:,n)));
    Input{1,2}(12,n) = metricas(Raw{3,2}(:,n),0,0);
    Input{1,2}(13,n) = MMD(Raw{3,2}(:,n));
    Input{1,2}(14,n) = bandpower(Raw{3,2}(:,n));
    Input{1,2}(15,n) = kurtosis(Raw{3,2}(:,n));
    
    Input{1,2}(16,n) = mean(abs(Raw{4,2}(:,n)));
    Tag{1,2}(2,n) = 1;
end

for n = 1:cont_S2    
    Input{1,3}(1,n) = mean(abs(Raw{1,3}(:,n)));
    Input{1,3}(2,n) = metricas(Raw{1,3}(:,n),0,0);
    Input{1,3}(3,n) = MMD(Raw{1,3}(:,n));
    Input{1,3}(4,n) = bandpower(Raw{1,3}(:,n));
    Input{1,3}(5,n) = kurtosis(Raw{1,3}(:,n));
   
    Input{1,3}(6,n) = mean(abs(Raw{2,3}(:,n)));
    Input{1,3}(7,n) = metricas(Raw{2,3}(:,n),0,0);
    Input{1,3}(8,n) = MMD(Raw{2,3}(:,n));
    Input{1,3}(9,n) = bandpower(Raw{2,3}(:,n));
    Input{1,3}(10,n) = kurtosis(Raw{2,3}(:,n));
     
    Input{1,3}(11,n) = mean(abs(Raw{3,3}(:,n)));
    Input{1,3}(12,n) = metricas(Raw{3,3}(:,n),0,0);
    Input{1,3}(13,n) = MMD(Raw{3,3}(:,n));
    Input{1,3}(14,n) = bandpower(Raw{3,3}(:,n));
    Input{1,3}(15,n) = kurtosis(Raw{3,3}(:,n));
    
    Input{1,3}(16,n) = mean(abs(Raw{4,3}(:,n)));

    
    Tag{1,3}(3,n) = 1;
end

for n = 1:cont_S3
    Input{1,4}(1,n) = mean(abs(Raw{1,4}(:,n)));
    Input{1,4}(2,n) = metricas(Raw{1,4}(:,n),0,0);
    Input{1,4}(3,n) = MMD(Raw{1,4}(:,n));
    Input{1,4}(4,n) = bandpower(Raw{1,4}(:,n));
    Input{1,4}(5,n) = kurtosis(Raw{1,4}(:,n));
    
    Input{1,4}(6,n) = mean(abs(Raw{2,4}(:,n)));
    Input{1,4}(7,n) = metricas(Raw{2,4}(:,n),0,0);
    Input{1,4}(8,n) = MMD(Raw{2,4}(:,n));
    Input{1,4}(9,n) = bandpower(Raw{2,4}(:,n));
    Input{1,4}(10,n) = kurtosis(Raw{2,4}(:,n));
    
    Input{1,4}(11,n) = mean(abs(Raw{3,4}(:,n)));
    Input{1,4}(12,n) = metricas(Raw{3,4}(:,n),0,0);
    Input{1,4}(13,n) = MMD(Raw{3,4}(:,n));
    Input{1,4}(14,n) = bandpower(Raw{3,4}(:,n));
    Input{1,4}(15,n) = kurtosis(Raw{3,4}(:,n));
    
    Input{1,4}(16,n) = mean(abs(Raw{4,4}(:,n)));

    
    Tag{1,4}(4,n) = 1;
end

if (classes == 5)
    for n = 1:cont_REM        
        Input{1,5}(1,n) = mean(abs(Raw{1,5}(:,n)));
        Input{1,5}(2,n) = metricas(Raw{1,5}(:,n),0,0);
        Input{1,5}(3,n) = MMD(Raw{1,5}(:,n));
        Input{1,5}(4,n) = bandpower(Raw{1,5}(:,n));
        Input{1,5}(5,n) = kurtosis(Raw{1,5}(:,n));
        
        Input{1,5}(6,n) = mean(abs(Raw{2,5}(:,n)));
        Input{1,5}(7,n) = metricas(Raw{2,5}(:,n),0,0);
        Input{1,5}(8,n) = MMD(Raw{2,5}(:,n));
        Input{1,5}(8,n) = bandpower(Raw{2,5}(:,n));
        Input{1,5}(10,n) = kurtosis(Raw{2,5}(:,n));
        
        Input{1,5}(11,n) = mean(abs(Raw{3,5}(:,n)));
        Input{1,5}(12,n) = metricas(Raw{3,5}(:,n),0,0);
        Input{1,5}(13,n) = MMD(Raw{3,5}(:,n));
        Input{1,5}(14,n) = bandpower(Raw{3,5}(:,n));
        Input{1,5}(15,n) = kurtosis(Raw{3,5}(:,n));

        Input{1,5}(16,n) = mean(abs(Raw{4,5}(:,n)));
        
        Tag{1,5}(5,n) = 1;
    end
end

Datos = cell(1,classes);
Datos{1,1} = Input{1,1};
Datos{1,2} = Input{1,2};
Datos{1,3} = Input{1,3};
Datos{1,4} = Input{1,4};

if (classes == 5)
    Datos{1,5} = Input{1,5};
end

%% Crear Target e Input Vector
if (classes == 5)
    Target_Vector = [Tag{1,1},Tag{1,2},Tag{1,3},Tag{1,4},Tag{1,5}];
    Input_Vector = [Input{1,1},Input{1,2},Input{1,3},Input{1,4},Input{1,5}];
else
    Target_Vector = [Tag{1,1},Tag{1,2},Tag{1,3},Tag{1,4}];
    Input_Vector = [Input{1,1},Input{1,2},Input{1,3},Input{1,4}];
end

%% Vector de muestra para Database_Simulation.m
muestra = cell(4,1);

for i = 1:signals
     muestra{i,1} = zeros(33000,1);
end

for j = 1:signals
    muestra{j,1} = [Raw{j,1}(:,1);Raw{j,1}(:,2);Raw{j,2}(:,5);Raw{j,2}(:,6);...
    Raw{j,3}(:,5);Raw{j,3}(:,6);Raw{j,4}(:,5);Raw{j,4}(:,6);Raw{j,5}(:,5);Raw{j,5}(:,6);Raw{j,5}(:,7)]; 
end

muestra_hypno = ['W' 'W' '1' '1' '2' '2' '3' '3' 'R' 'R' 'R']; %true labels
%% **************************************************************************
largo = length(Labels);
label = zeros(largo,1);
for i=1:largo
    if strcmp(Labels(i),'W')
        label(i)=1;
    elseif strcmp(Labels(i),'1')
        label(i)=2;
    elseif strcmp(Labels(i),'2')
        label(i)=3;
    elseif strcmp(Labels(i),'3')
        label(i)=4;
    elseif strcmp(Labels(i),'R')
        label(i)=5;
    end
    
end

clasLearnTotal = [Input_Vector;label']';

numFilas = 500;
clasTrain = clasLearnTotal(1:numFilas,:);

clasVerif = clasLearnTotal(numFilas+1:end,:);

%% Datos Para SVM
X = [Datos{1,1}';Datos{1,2}';Datos{1,3}';Datos{1,4}';Datos{1,5}'];  % Todos los datos juntos
Etiquetas = [ones(size(Datos{1,1}',1),1); 2*ones(size(Datos{1,2}',1),1);...
    3*ones(size(Datos{1,3}',1),1);4*ones(size(Datos{1,4}',1),1);5*ones(size(Datos{1,5}',1),1)];

l = 50;
Xtrain = [Datos{1,1}(:,1:l)';Datos{1,2}(:,1:l)';Datos{1,3}(:,1:l)';Datos{1,4}(:,1:l)';Datos{1,5}(:,1:l)'];
Ytrain = [ones(size(Datos{1,1}(:,1:l)',1),1); 2*ones(size(Datos{1,2}(:,1:l)',1),1);...
    3*ones(size(Datos{1,3}(:,1:l)',1),1);4*ones(size(Datos{1,4}(:,1:l)',1),1);5*ones(size(Datos{1,5}(:,1:l)',1),1)];

Xpred = [Datos{1,1}(:,l+1:end)';Datos{1,2}(:,l+1:end)';Datos{1,3}(:,l+1:end)';Datos{1,4}(:,l+1:end)';Datos{1,5}(:,l+1:end)'];
Ypred = [ones(size(Datos{1,1}(:,l+1:end)',1),1); 2*ones(size(Datos{1,2}(:,l+1:end)',1),1);...
    3*ones(size(Datos{1,3}(:,l+1:end)',1),1);4*ones(size(Datos{1,4}(:,l+1:end)',1),1);5*ones(size(Datos{1,5}(:,l+1:end)',1),1)];

clasLearn = [X,Etiquetas];

clasLearn = [Xpred,Ypred];

pred = [Xtrain';Ytrain']';
% % %pred = clasVerif;
% % %pred = clasTrain;
% % 
% yfitS = trainedModelSVM3.predictFcn(pred(:,1:end-1));
% 
% % 
% figure(1); clf;
% s = confusionchart(pred(:,end),yfitS);
% s.Title = 'Matriz de confusión SVM grado 3';
% s.RowSummary = 'row-normalized';
% s.ColumnSummary = 'column-normalized';

%% Dividir datos para RN
size1 = size(Tag{1,1},2);
size2 = size(Tag{1,2},2);
size3 = size(Tag{1,3},2);
size4 = size(Tag{1,4},2);
size5 = size(Tag{1,5},2);

ratio = 0.7;

lim1 = round(ratio*size1);
lim2 = round(ratio*size2);
lim3 = round(ratio*size3);
lim4 = round(ratio*size4);
lim5 = round(ratio*size5);

if (classes == 5)
    Target_VectorTrain = [Tag{1,1}(:,1:lim1),Tag{1,2}(:,1:lim2),Tag{1,3}(:,1:lim3)...
        ,Tag{1,4}(:,1:lim4),Tag{1,5}(:,1:lim5)];
    Input_VectorTrain = [Input{1,1}(:,1:lim1),Input{1,2}(:,1:lim2),Input{1,3}(:,1:lim3)...
        ,Input{1,4}(:,1:lim4),Input{1,5}(:,1:lim5)];
    
    Target_VectorTest = [Tag{1,1}(:,lim1+1:end),Tag{1,2}(:,lim2+1:end)...
        ,Tag{1,3}(:,lim3+1:end),Tag{1,4}(:,lim4+1:end),Tag{1,5}(:,lim5+1:end)];
    Input_VectorTest = [Input{1,1}(:,lim1+1:end),Input{1,2}(:,lim2+1:end)...
        ,Input{1,3}(:,lim3+1:end),Input{1,4}(:,lim4+1:end),Input{1,5}(:,lim5+1:end)];
else
    Target_VectorTrain = [Tag{1,1},Tag{1,2},Tag{1,3},Tag{1,4}];
    Input_VectorTrain = [Input{1,1},Input{1,2},Input{1,3},Input{1,4}];

end
%% Predecir
