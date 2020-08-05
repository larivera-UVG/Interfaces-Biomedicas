%% Predicciones
% Rodrigo Ralda

%clear all;
%load('caracteristicas.mat');
%load('modelosEntrenados.mat');

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
    %%
    % |ECGData| is a structure array with two fields: |Data| and |Labels|.
    % |Data| is a 162-by-65536 matrix where each row is an ECG recording
    % sampled at 128 hertz. Each ECG time series has a total duration of 512
    % seconds. |Labels| is a 162-by-1 cell array of diagnostic
    % labels, one for each row of |Data|. The three diagnostic categories are:
    % 'ARR' (arrhythmia), 'CHF' (congestive heart failure), and 'NSR' (normal
    % sinus rhythm).
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
    % There are 113 records in the |trainData| set and 49 records in
    % |testData|. By design the training data contains 69.75% (113/162) of
    % the data. Recall that the ARR class represents 59.26% of the data
    % (96/162), the CHF class represents 18.52% (30/162), and the NSR class
    % represents 22.22% (36/162). Examine the percentage of each class in the
    % training and test sets. The percentages in each are consistent with the
    % overall class percentages in the data set.
    Ctrain = countcats(categorical(trainLabels))./numel(trainLabels).*100
    Ctest = countcats(categorical(testLabels))./numel(testLabels).*100
    %% Plot Samples
    % Plot the first few thousand samples of four randomly selected records
    % from |ECGData|. The helper function |helperPlotRandomRecords| does this.
    % |helperPlotRandomRecords| accepts |ECGData| and a random seed as input.
    % The initial seed is set at 14 so that at least one record from each class
    % is plotted. You can execute |helperPlotRandomRecords| with |ECGData| as
    % the only input argument as many times as you wish to get a sense of the
    % variety of ECG waveforms associated with each class. You can find the
    % source code for this and all helper functions in the Supporting Functions
    % section at the end of this example.
% %     helperPlotRandomRecordss(EEGData,14)
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
    sf = waveletScattering('SignalLength',N,'SamplingFrequency',160); %se quito Invariance Scale
    %%
    % You can visualize the wavelet filters in the two filter banks with the
    % following.
% %     [fb,f,filterparams] = filterbank(sf);
% %     subplot(211)
% %     plot(f,fb{2}.psift)
% %     xlim([0 160])
% %     grid on
% %     title('1st Filter Bank Wavelet Filters');
% %     subplot(212)
% %     plot(f,fb{3}.psift)
% %     xlim([0 160])
% %     grid on
% %     title('2nd Filter Bank Wavelet Filters');
% %     xlabel('Hz');
    %%
    % To demonstrate the invariance scale, obtain the inverse Fourier transform
    % of the scaling function and center it at 0 seconds in time. The two
    % vertical black lines mark the -75 and 75 second boundaries. Additionally,
    % plot the real and imaginary parts of the coarsest-scale (lowest
    % frequency) wavelet from the first filter bank. Note that the
    % coarsest-scale wavelet does not exceed the invariant scale determined by
    % the time support of the scaling function. This is an important property
    % of wavelet time scattering.
% %     figure;
% %     phi = ifftshift(ifft(fb{1}.phift));
% %     psiL1 = ifftshift(ifft(fb{2}.psift(:,end)));
% %     t = (-2^9:2^9-1).*1/160;
% %     scalplt = plot(t,phi);
% %     hold on
% %     grid on
% %     %ylim([-9e-3 9e-3]);
% %     %plot([-75 -75],[-1.5e-4 1.6e-4],'k--');
% %     %plot([75 75],[-1.5e-4 1.6e-4],'k--');
% %     xlabel('Seconds'); ylabel('Amplitude');
% %     wavplt = plot(t,[real(psiL1) imag(psiL1)]);
% %     legend([scalplt wavplt(1) wavplt(2)],{'Scaling Function','Wavelet-Real Part','Wavelet-Imaginary Part'});
% %     title({'Scaling Function';'Coarsest-Scale Wavelet First Filter Bank'})
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
    % window. In this case, you obtain 1808 rows because there are 16 time
    % windows for each of the 113 signals in the training data.
    Nwin = size(scat_features_train,2);
    scat_features_train = permute(scat_features_train,[2 3 1]);
    scat_features_train = reshape(scat_features_train,...
        size(scat_features_train,1)*size(scat_features_train,2),[]);
    %%
    % Repeat the process for the test data. Initially, |scat_features_test| is
    % 416-by-16-by-49 because there are 49 ECG waveforms in the training set.
    % After reshaping for the SVM classifier, the feature matrix is 784-by-416.
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
    % scattering data and fits a multi-class SVM with a quadratic kernel. In
    % total there 2592 scattering sequences in the entire dataset, 16 for each
    % of the 162 signals. The error rate, or loss, is estimated using 5-fold
    % cross validation.
    scat_features = [scat_features_train; scat_features_test];
    allLabels_scat = [sequence_labels_train; sequence_labels_test];

    %% class learner
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

%yfitL = trainedModelLn.predictFcn(clasLearn3(:,1:end-1));
yfitS = trainedModelSVM3.predictFcn(clasLearn2(:,1:end-1));


figure(1); clf;
s = confusionchart(clasLearn2(:,end),yfitS);
s.Title = 'Matriz de confusión SVM grado 3';
s.RowSummary = 'row-normalized';
s.ColumnSummary = 'column-normalized';
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
