% Rodrigo Ralda
%% Wavelet Time Scattering for EEG Signal Classification
% Ejemplo para meter datos al classification learner
% This example shows how to classify human electrocardiogram (ECG) signals
% using wavelet time scattering and a support vector machine (SVM)
% classifier. In wavelet scattering, data is propagated through a series of
% wavelet transforms, nonlinearities, and averaging to produce low-variance
% representations of time series. Wavelet time scattering yields signal
% representations insensitive to shifts in the input signal without
% sacrificing class discriminability. You must have the Wavelet Toolbox(TM)
% and the Statistics and Machine Learning Toolbox(TM) to run this example.
% The data used in this example are publicly available from
% <https://physionet.org PhysioNet>. You can find a deep learning approach
% to this classification problem in this example
% <docid:wavelet_examples#mw_1972856e-c413-4b6d-bc0a-8fd006ec8b8e Classify
% Time Series Using Wavelets and Deep Learning> and a machine learning
% approach in this example
% <docid:wavelet_examples#mw_7b96e2d1-3e9f-4244-9975-57eb3061c1c4 Signal
% Classification Using Wavelet-Based Features and Support Vector Machines>.
%% Data Description
% This example uses ECG data obtained from three groups, or classes, of
% people: persons with cardiac arrhythmia, persons with congestive heart
% failure, and persons with normal sinus rhythms. The example uses 162 ECG
% recordings from three PhysioNet databases:
% <https://www.physionet.org/physiobank/database/mitdb/ MIT-BIH Arrhythmia
% Database> [3][5], <https://www.physionet.org/physiobank/database/nsrdb/
% MIT-BIH Normal Sinus Rhythm Database> [3], and
% <https://www.physionet.org/physiobank/database/chfdb/ The BIDMC
% Congestive Heart Failure Database> [2][3]. In total, there are 96
% recordings from persons with arrhythmia, 30 recordings from persons with
% congestive heart failure, and 36 recordings from persons with normal
% sinus rhythms. The goal is to train a classifier to distinguish between
% arrhythmia (ARR), congestive heart failure (CHF), and normal sinus rhythm
% (NSR).
%% Download Data
% The first step is to download the data from the
% <https://github.com/mathworks/physionet_ECG_data/ GitHub repository>. To
% download the data, click |Clone or download| and select |Download ZIP|.
% Save the file |physionet_ECG_data-master.zip| in a folder where you have
% write permission. The instructions for this example assume you have
% downloaded the file to your temporary directory, (|tempdir| in MATLAB).
% Modify the subsequent instructions for unzipping and loading the data if
% you choose to download the data in folder different from |tempdir|. If
% you are familiar with Git, you can download the latest version of the
% tools (<https://git-scm.com/ git>) and obtain the data from a system
% command prompt using |git clone
% https://github.com/mathworks/physionet_ECG_data/| .
%%
% The file |physionet_ECG_data-master.zip| contains
%
% * ECGData.zip
% * README.md
%
% and ECGData.zip contains
%
% * ECGData.mat
% * Modified_physionet_data.txt
% * License.txt.
%
% ECGData.mat holds the data used in this example. The .txt file,
% Modified_physionet_data.txt, is required by PhysioNet's copying policy
% and provides the source attributions for the data as well as a
% description of the pre-processing steps applied to each ECG recording.
%% Load Files
% If you followed the download instructions in the previous section, enter
% the following commands to unzip the two archive files.
% unzip(fullfile(tempdir,'physionet_ECG_data-master.zip'),tempdir)
% unzip(fullfile(tempdir,'physionet_ECG_data-master','ECGData.zip'),...
%     fullfile(tempdir,'ECGData'))
% %%
% % After you unzip the ECGData.zip file, load the data into MATLAB.
% load(fullfile(tempdir,'ECGData','ECGData.mat'))

%%
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
    for i=1:size2
       etiq=[etiq;"T3"];  
    end
    for i=1:size5
       etiq=[etiq;"T4"];  
    end
    
    data = [Raw{cc,1}';Raw{cc,3}';Raw{cc,4}';Raw{cc,2}';Raw{cc,5}'];
    
    EEGData = {};
    EEGData.Data = data;
    EEGData.Labels = etiq;

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
    Ctrain = countcats(categorical(trainLabels))./numel(trainLabels).*100;
    Ctest = countcats(categorical(testLabels))./numel(testLabels).*100;
   
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
    labelWv = zeros(largo,1); %Etiquetas para wavelets
    labelRn = zeros(largo, 5); %Etiquetas para redes neuronales
   
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
               
          elseif(strcmp(allLabels_scat(k), 'T3'))
               labelWv(k) = 3;    
               labelRn(k,4) = 1;
               
          elseif(strcmp(allLabels_scat(k), 'T4'))
               labelWv(k) = 4;    
               labelRn(k,5) = 1;
          end


    end
    caracteristicas = [caracteristicas, scat_features];
    etiquetas = [etiquetas, labelWv];
  
end
%labelRn = labelRn';
clasLearn2 = [caracteristicas, etiquetas(:,1)]; %Features de wavelets
clasTrain = clasLearn2(1:6372,:);
clasPred = clasLearn2(6373:end,:);

labTrain = labelRn(1:6372,:);
labPred = labelRn(6373:end,:);
%% Clasificador Binario
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

% % reduced = pca(caracteristicas');
% % 
% % clasLearn3 = [reduced, etiquetas(:,1)];% No funciona con reduced' 66% de rendimiento max
% % %con reduced si tiene 91% de rendimiento pero malas predicciones

%y=[dataOrd(1,:),dataOrd(2,:),dataOrd(3,:)];



% figure(1); clf
% plot(y);
% title('se�al capturada completa');

%% Ejemplo codigo Luis detectar actividad
% Fs=160;
% win=4200;%500
% Tn=4100;%500
% ga=1.5; %Entre 1.1 y 2
% for rr=1:64
%   y=record(rr,1:2000);
%   es = detecta_EMG(y,Fs,win,Tn,ga,2);
% end
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


figure(1); clf;
s = confusionchart(clasPred(:,end),yfitS);
s.Title = 'Matriz de confusi�n SVM grado 3';
s.RowSummary = 'row-normalized';
s.ColumnSummary = 'column-normalized';