%% Wavelet Time Scattering for EEG Signal Classification
% Rodrigo Ralda - 14813
% 2020

% En este codigo se encuentran las primeras pruebas realizadas para
% implementar wavelets a la base de datos de sueño.



%% Lectura e identificacion
% Se leen los datos y se separan segun sus etiquetas y ventanas de tiempo.
cantCanal = 4;
 
for cc = 1:cantCanal
      if cc==1
         caracteristicas=[];
         etiquetas=[]; 
      end

   etiq = [];
    for i=1:size1
       etiq=[etiq;"T0"]; 
    end
    for i=1:size3
       etiq=[etiq;"T1"];  
    end
    for i=1:size4
       etiq=[etiq;"T2"];  
    end
    
    data = [Raw{cc,1}';Raw{cc,3}';Raw{cc,4}'];
    
    EEGData = {};
    EEGData.Data = data;
    EEGData.Labels = etiq;

    %% Create Training and Test Data
    % Randomly split the data into two sets - training and test data sets. The
    % helper function |helperRandomSplit| performs the random split.
    % |helperRandomSplit| accepts the desired split percentage for the training
    % data and  |ECGData|. The |helperRandomSplit| function outputs two data
    % sets along with a set of labels for each. Each row of |trainData| and
    % |testData| is an ECG signal. Each element of |trainLabels| and
    % |testLabels| contains the class label for the corresponding row of the
    % data matrices. In this example, we randomly assign 70% percent of the
    % data in each class to the training set. The remaining 30% is held out for
    % testing (prediction) and are assigned to the test set.
    percent_train = 70;
    [trainData,testData,trainLabels,testLabels] = ...
        helperRandomSplits(percent_train,EEGData);
    %%
    % Examine the percentage of each class in the
    % training and test sets. The percentages in each are consistent with the
    % overall class percentages in the data set.
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
    % in the second filter bank. The invariance scale is set to 150 seconds.
    N = size(EEGData.Data,2);
    sf = waveletScattering('SignalLength',N,'SamplingFrequency',100); %se quito Invariance Scale

    %%
    % After constructing the scattering decomposition framework, obtain the
    % scattering coefficients for the training data as a matrix. When you run
    % |featureMatrix| with multiple signals, each column is treated a single
    % signal.
    scat_features_train = featureMatrix(sf,trainData');
    %%
    % The output of |featureMatrix| in this case is 416-by-16-by-113. Each page
    % of the tensor, |scat_features_train|, is the scattering transform of one
    % signal. The wavelet scattering transform is critically downsampled in
    % time based on the bandwidth of the scaling function. In this case, this
    % results in 16 time windows for each of the 416 scattering paths.
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
    % Because for each signal we obtained 16 scattering windows, we need to
    % create labels to match the number of windows. The helper function 
    % |createSequenceLabels| does this based on the number of windows.
    [sequence_labels_train,sequence_labels_test] = createSequenceLabelss(Nwin,trainLabels,testLabels);
    %% Cross Validation
    % For classification, two analyses are performed. The first uses all the
    % scattering data and fits a multi-class SVM with a quadratic kernel. 
    % The error rate, or loss, is estimated using 5-fold
    % cross validation.
    scat_features = [scat_features_train; scat_features_test];
    allLabels_scat = [sequence_labels_train; sequence_labels_test];

    %% class learner
    % Se preparan los datos para ingresar al classification learner.
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
clasTrain = clasLearn2(1:4824,:);
clasPred = clasLearn2(4825:end,:);
%% Clasificador Binario
% En caso se quieran solo 2 clases y no 3, se desarrollan las siguientes
% lineas.
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
% Aplicar reduccion de dimensionalidad con PCA, no funciono de la manera
% esperada. Motivo por el cual esta comentado

% % reduced = pca(caracteristicas');
% % 
% % clasLearn3 = [reduced, etiquetas(:,1)];% No funciona con reduced' 66% de rendimiento max
% % %con reduced si tiene 91% de rendimiento pero malas predicciones

%y=[dataOrd(1,:),dataOrd(2,:),dataOrd(3,:)];



% figure(1); clf
% plot(y);
% title('señal capturada completa');

%% Ejemplo codigo Luis detectar actividad
% Calcular features en el dominio del tiempoa las wavelets.

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

% Descomentar para obtener matriz de confusión

% yfitS = trainedModelSVM3.predictFcn(clasPred(:,1:end-1));
% 
% 
% figure(1); clf;
% s = confusionchart(clasPred(:,end),yfitS);
% s.Title = 'Matriz de confusión SVM grado 3';
% s.RowSummary = 'row-normalized';
% s.ColumnSummary = 'column-normalized';