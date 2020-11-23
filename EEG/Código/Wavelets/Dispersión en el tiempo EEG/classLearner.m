%% Wavelet Time Scattering for EEG Signal Classification
% Rodrigo Ralda - 14813
% 2020

% Ejemplo para meter datos al classification learner y obtener los modelos
% ya entrenados con los agloritmos que presenten mejor rendimiento. En la
% mayoria de los casos es el SVM polinomial grado 3.


 clear all;
 load('caracteristicas.mat');

%%
cantCanal = 2;
record = data{2,11};%11
label = record(66,:);
record(65:end,:)=[];

caracteristicas = [];
etiquetas = [];
    
for cc = 1:cantCanal
    
    if (cc == 1)
        canal = record(9,:);%C3=9*****O1=61*****Pz=51
    elseif (cc == 2)
        canal = record(10,:);%C1=10*****P3=49*****Fpz=23
    elseif (cc == 3)
        canal = record(58,:);%C6
    elseif (cc == 4)
        canal = record(15,:);%Cp5
    elseif (cc == 5)
        canal = record(43,:);%T9
    elseif (cc == 6)
        canal = record(44,:);%T10
    elseif (cc == 7)
        canal = record(58,:);%Poz
    elseif (cc == 8)
        canal = record(59,:);%Po4
    end


    fil = 1;
    dataOrd = [];
    labelOrd = [0];
    labelAnt = 0;
    col = 0;
    for i=1:19920
        if (label(i) ~= labelAnt)
            %labelOrd(columna)=label(i);
            fil = fil+1;
            labelOrd(fil)=label(i);
            col = 0;   
        end
        col = col+1;
                if (label(i) == 0)
                    dataOrd(fil,col)=canal(i);

                elseif (label(i) == 1)
                    dataOrd(fil,col)=canal(i);

                elseif (label(i) == 2)
                    dataOrd(fil,col)=canal(i);
                end

                labelAnt = label(i);

    end

    eti0=[];
    eti1=[];
    eti2=[];
    dat0=[];
    dat1=[];
    dat2=[];
    for j=1:30
                if (labelOrd(1,j) == 0)
                    eti0=[eti0;"T0"];
                    dat0=[dat0;dataOrd(j,:)];

                elseif (labelOrd(1,j) == 1)
                    eti1=[eti1;"T1"];
                    dat1=[dat1;dataOrd(j,:)];
                elseif (labelOrd(1,j) == 2)
                    eti2=[eti2;"T2"];
                    dat2=[dat2;dataOrd(j,:)];
                end
    end

    EEGData = {};
    EEGData.Data = [dat0;dat1;dat2];
    EEGData.Labels = [eti0;eti1;eti2];

    clasLearn = [dataOrd,labelOrd'];

    %% Crear datos de entrenamiento y validacion

    percent_train = 70;
    [trainData,testData,trainLabels,testLabels] = ...
        helperRandomSplits(percent_train,EEGData);
    %%
 
    Ctrain = countcats(categorical(trainLabels))./numel(trainLabels).*100
    Ctest = countcats(categorical(testLabels))./numel(testLabels).*100

    %% Wavelet Time Scattering 
    % The key parameters to specify in a wavelet time scattering decomposition
    % are the scale of the time invariant, the number of wavelet transforms,
    % and the number of wavelets per octave in each of the wavelet filter
    % banks. In many applications, the cascade of two filter banks is
    % sufficient to achieve good performance. In this example, we construct a
    % wavelet time scattering decomposition with the default filter banks: 
    % 8 wavelets per octave in the first filter bank and 1 wavelet per octave
    % in the second filter bank. The invariance scale is set to 160 seconds.
    N = size(EEGData.Data,2);
    sf = waveletScattering('SignalLength',N,'SamplingFrequency',160); %se quito Invariance Scale


    %%
    % After constructing the scattering decomposition framework, obtain the
    % scattering coefficients for the training data as a matrix. When you run
    % |featureMatrix| with multiple signals, each column is treated a single
    % signal.
    scat_features_train = featureMatrix(sf,trainData');

    %%
    % In order to obtain a matrix compatible with the SVM classifier, reshape
    % the multisignal scattering transform into a matrix where each column
    % corresponds to a scattering path and each row is a scattering time
    % window. 
    Nwin = size(scat_features_train,2);
    scat_features_train = permute(scat_features_train,[2 3 1]);
    scat_features_train = reshape(scat_features_train,...
        size(scat_features_train,1)*size(scat_features_train,2),[]);
    %%
    % Repeat the process for the test data. 
    scat_features_test = featureMatrix(sf,testData');
    scat_features_test = permute(scat_features_test,[2 3 1]);
    scat_features_test = reshape(scat_features_test,...
        size(scat_features_test,1)*size(scat_features_test,2),[]);
    %%
    % The helper function 
    % |createSequenceLabels| does this based on the number of windows.
    [sequence_labels_train,sequence_labels_test] = createSequenceLabelss(Nwin,trainLabels,testLabels);
    %% Cross Validation
    % For classification, two analyses are performed. The first uses all the
    % scattering data and fits a multi-class SVM with a quadratic kernel. Estimated using 5-fold
    % cross validation.
    scat_features = [scat_features_train; scat_features_test];
    allLabels_scat = [sequence_labels_train; sequence_labels_test];

    %% class learner
    % Preparar datos para ser ingresados al App de Classification Learner y
    % tambien segmentar en entrenamiento y validacion para poner a prueba
    % los modelos obtenidos.
    %clasLearn2 = [scat_features, allLabels_scat];
    largo = length(allLabels_scat);
    labelWv = zeros(largo,1); %Etiquetas para wavelets
    labelRn = zeros(largo, 3); %Etiquetas para redes neuronales
    for k = 1:largo

          if(strcmp(allLabels_scat(k), 'T0'))
              labelWv(k) = 0;
              labelRn(k,1) = 1;

          elseif(strcmp(allLabels_scat(k), 'T1'))
              labelWv(k) = 1;    
              labelRn(k,2) = 1;

          elseif(strcmp(allLabels_scat(k), 'T2'))
               labelWv(k) = 2;    
               labelRn(k,3) = 1;
          end


    end
    caracteristicas = [caracteristicas, scat_features];
    etiquetas = [etiquetas, labelWv];
  
end
%labelRn = labelRn';
clasLearn2 = [caracteristicas, etiquetas(:,1)]; %Features de wavelets
clasTrain = clasLearn2(1:242,:);
clasPred = clasLearn2(243:end,:);
%% Clasificador Binario
% En lugar de separar los datos en 3 etiquetas como en las lineas
% anteriores, se separan los datos en solamente 2 etiquetas y se ignoran
% los de la tercer etiqueta. Para tener la oppcion de poner a prueba los
% clasificadores con este tipo de datos.
clasLearn3 = [];
for jj=1:size(clasLearn2,1)
    if(clasLearn2(jj,end)==0)
         clasLearn3 = [clasLearn3; clasLearn2(jj,:)];
    elseif(clasLearn2(jj,end)==1)  
         clasLearn3 = [clasLearn3; clasLearn2(jj,:)];
    end
    
end
clasTrainB = clasLearn3(1:187,:);
clasPredB = clasLearn3(188:end,:);
%% PCA 
% Descomentar lineas de codigo en caso se desee poner a prueba la reduccion
% de dimensionalidad con pca, no presento buenos resultados por lo cual se
% recomienda dejarlo comentado.

% % reduced = pca(caracteristicas');
% % 
% % clasLearn3 = [reduced, etiquetas(:,1)];% No funciona con reduced' 66% de rendimiento max
% % %con reduced si tiene 91% de rendimiento pero malas predicciones

%y=[dataOrd(1,:),dataOrd(2,:),dataOrd(3,:)];



% figure(1); clf
% plot(y);
% title('señal capturada completa');

%% Feature Extraction
% Las siguientes lineas de codigo son paara calcular las caracteristicas en
% el dominio del tiempo a las señales ya procesadas con wavelets. Estas
% pruebas tampoco dieron muy buen resultado.

totZC = zeros(1,size(clasLearn2,1));
totMav = zeros(1,size(clasLearn2,1));
bP = zeros(1,size(clasLearn2,1));
curtos = zeros(1,size(clasLearn2,1));

for i=1:size(clasLearn2,1)
    x = clasLearn2(i,:);
    [totZC(i), totMav(i)] = metricas(x, 0, mean(x));
    bP(i) = bandpower(x);
    curtos(i) = kurtosis(x);
end

clasLearn4 = [totZC',totMav',bP',curtos',etiquetas(:,1)];
clasTrainZ = clasLearn4(1:242,:);
clasPredZ = clasLearn4(243:end,:);

yfitS = trainedModelSVM3.predictFcn(clasPred(:,1:end-1));

ppp = full(ind2vec(clasPred(:,end)'+1));
ooo = full(ind2vec(yfitS'+1));

figure(9); clf;
plotconfusion(ppp,ooo);
% 
% % figure(1); clf;
% % s = confusionchart(clasPred(:,end),yfitS);
% % s.Title = 'Matriz de confusión SVM grado 3';
% % s.RowSummary = 'row-normalized';
% % s.ColumnSummary = 'column-normalized';
% % 