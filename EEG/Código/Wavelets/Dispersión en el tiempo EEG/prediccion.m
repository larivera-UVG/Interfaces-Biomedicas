%% Predicciones
% Rodrigo Ralda
% Codigo para probar los modelos obtenidos del classification learner ya
% entrenados

% Cargar datos y ordenar correctamente

%clear all;
load('caracteristicas.mat');
load('modelosEntrenados.mat');

cantCanal = 2;
record = data{2,12};
label = record(66,:);

caracteristicas = [];
etiquetas = [];
    
for cc = 1:cantCanal
    
    if (cc == 1)
        canal = record(23,:);%9
    elseif (cc == 2)
        canal = record(51,:);
    elseif (cc == 3)
        canal = record(58,:);
    elseif (cc == 4)
        canal = record(15,:);
    elseif (cc == 5)
        canal = record(43,:);
    elseif (cc == 6)
        canal = record(44,:);
    elseif (cc == 7)
        canal = record(58,:);
    elseif (cc == 8)
        canal = record(59,:);
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
    % Because for each signal we obtained 16 scattering windows, we need to
    % create labels to match the number of windows. The helper function 
    % |createSequenceLabels| does this based on the number of windows.
    [sequence_labels_train,sequence_labels_test] = createSequenceLabelss(Nwin,trainLabels,testLabels);
    %% Cross Validation
    % For classification, two analyses are performed.  The error rate, or loss, is estimated using 5-fold
    % cross validation.
    scat_features = [scat_features_train; scat_features_test];
    allLabels_scat = [sequence_labels_train; sequence_labels_test];

    %% class learner
    % Se separan los datos de las wavelets para ingresar al classification
    % learner con el formato requerido.
    
    %clasLearn2 = [scat_features, allLabels_scat];
    largo = length(allLabels_scat);
    labelWv = zeros(largo,1);
    for k = 1:largo

          if(strcmp(allLabels_scat(k), 'T0'))
              labelWv(k) = 0;

          elseif(strcmp(allLabels_scat(k), 'T1'))
              labelWv(k) = 1;    


          elseif(strcmp(allLabels_scat(k), 'T2'))
               labelWv(k) = 2;    

          end


    end
    caracteristicas = [caracteristicas, scat_features];
    etiquetas = [etiquetas, labelWv];
  
end
clasLearn2 = [caracteristicas, etiquetas(:,1)];
clasTrain = clasLearn2(1:242,:);
clasPred = clasLearn2(243:end,:);
%% PCA
% Se aplico PCA para reducir dimensionalidad pero no se obtuvieron buenos
% resultados. Por ese motivo esta comentado.
% reduced = pca(caracteristicas');
% yfitL = trainedModelNBG.predictFcn(reduced);

%% Clasificador Binario
% clasLearn3 = [];
% for jj=1:size(clasLearn2,1)
%     if(clasLearn2(jj,end)==0)
%          clasLearn3 = [clasLearn3; clasLearn2(jj,:)];
%     elseif(clasLearn2(jj,end)==1)  
%          clasLearn3 = [clasLearn3; clasLearn2(jj,:)];
%     end
%     
% end

%% Prediccion

% Validacion de los modelos del classification learnes y obtencion de
% matrices de confusion.

%yfitL = trainedModelLn.predictFcn(clasLearn3(:,1:end-1));
yfitS = trainedModelSVM3.predictFcn(clasLearn2(:,1:end-1));


figure(1); clf;
s = confusionchart(clasLearn2(:,end),yfitS);
s.Title = 'Matriz de confusión SVM grado 3';
s.RowSummary = 'row-normalized';
s.ColumnSummary = 'column-normalized';

%figure(9); clf;
%plotconfusion(clasLearn2(:,end),yfitS);
% 
% figure(2); clf;
% L = confusionchart(clasLearn3(:,end),yfitL)
% L.Title = 'Matriz de confusión Discriminante Lineal';
% L.RowSummary = 'row-normalized';
% L.ColumnSummary = 'column-normalized';
% 
% yfitK = trainedModelKNN.predictFcn(clasLearn3(:,1:end-1));
% 
% figure(3); clf;
% L = confusionchart(clasLearn3(:,end),yfitK)
% L.Title = 'Matriz de confusión KNN';
% L.RowSummary = 'row-normalized';
% L.ColumnSummary = 'column-normalized';

% yfitS = trainedModelSVM3.predictFcn(clasPred(:,1:end-1));
% 
% 
% figure(1); clf;
% s = confusionchart(clasPred(:,end),yfitS);
% s.Title = 'Matriz de confusión SVM grado 3';
% s.RowSummary = 'row-normalized';
% s.ColumnSummary = 'column-normalized';
