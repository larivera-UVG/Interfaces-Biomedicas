%% Aplicacion wavelets señales EEG
% Rodrigo Ralda


%% Generacion data
% clear all;
% pathname = 'C:\Users\rodri\Downloads\Semestre 9 UVG\DiseñoIngenieria1\Base de Datos\eeg-motor-movementimagery-dataset-1.0.0\files\S001\';
% filename = 'S001R03.edf';
% [hdr, record] = edfread([pathname,filename]);
% [Task_label,Time_duration,Task_sym,strArray] =Eventread(pathname,filename);
% [n,m] = size(record);
% dt = 160;
% t=zeros(m,1);
% 
% for k=1:m
%     t(k)=k/dt;
% end
% tm=t;
% eeg_Preprocessed = record(9,:);
% Fs=dt;

%% Lectura de data
clear all;
load('dataS001R03.mat')

% Filtrado de 60 Hz debido al ruido de la corriente electrica.
notchFilt = designfilt('bandstopiir', 'FilterOrder', 6, 'HalfPowerFrequency1', 59, ...
            'HalfPowerFrequency2', 61, 'SampleRate', Fs);
eeg_Preprocessed = filtfilt(notchFilt,  eeg_Preprocessed);

%% %%Prueba 1 Wavelet y luego separacion de bandas por filtros IIR
% se utilizo como base el codigo del ejemplo:
% https://es.mathworks.com/support/search.html/videos/feature-detection-and-extraction-using-wavelets-part-2-feature-extraction--1486677599197.html?q=&fq=asset_type_name:video%20category:wavelet/index&page=1


% Level 3 Details ==> 20 - 40 Hz 
% Level 7 Details ==> 1.25 Hz- 2.5 Hz

% Extraer banda de 1.25 a 40 Hz lo cual equivale a los niveles desde el 3
% al 7 de wavelets

newBand = extractBand(eeg_Preprocessed,7,3,7);

%Graficar nueva señal on wavelets y antigua señal pre-procesada
figure(1); 
plot(t,newBand,'r',t,eeg_Preprocessed, 'b');
title('Nueva señal con Wavelets y señal sin procesamiento')

%Diseño filtros pasabanda IIR de orden 6 para separar bandas.
deltaFil = designfilt('bandpassiir', 'FilterOrder', 6, 'PassbandFrequency1',...
    0.1, 'PassbandFrequency2', 4, 'PassbandRipple', 1, 'SampleRate', Fs);

thetaFil = designfilt('bandpassiir', 'FilterOrder', 6, 'PassbandFrequency1',...
    4, 'PassbandFrequency2', 8, 'PassbandRipple', 1, 'SampleRate', Fs);

alphaFil = designfilt('bandpassiir', 'FilterOrder', 6, 'PassbandFrequency1',...
    8, 'PassbandFrequency2', 14, 'PassbandRipple', 1, 'SampleRate', Fs);

betaFil = designfilt('bandpassiir', 'FilterOrder', 6, 'PassbandFrequency1',...
    14, 'PassbandFrequency2', 30, 'PassbandRipple', 1, 'SampleRate', Fs);

gammaFil = designfilt('bandpassiir', 'FilterOrder', 6, 'PassbandFrequency1',...
    30, 'PassbandFrequency2', 59, 'PassbandRipple', 1, 'SampleRate', Fs);

% Implementacion de filtros diseñados
delta = filtfilt(deltaFil,  newBand);
theta = filtfilt(thetaFil,  newBand);
alpha = filtfilt(alphaFil,  newBand);
beta = filtfilt(betaFil,  newBand);
gamma = filtfilt(gammaFil,  newBand);

%% Prueba 2 Separacion de bandas por niveles de wavelet
%No son exactamente las frecuencias necesarias pero es un aproximado
%Niveles 6 Y 7 *** 1.25 - 5 Hz *** DELTA
delta1 = extractBand(eeg_Preprocessed,7,6,7);
%Nivel 5 *** 5 - 10 Hz *** THETA
theta1 = extractBand(eeg_Preprocessed,5,5,5);
%Nivel 4 *** 10 - 20 Hz *** ALPHA
alpha1 = extractBand(eeg_Preprocessed,4,4,4);
%Nivel 3 *** 20-40 Hz *** BETA
beta1 =  extractBand(eeg_Preprocessed,3,3,3);
%Nivel 2 *** 40-80 Hz *** GAMMA
gamma1 = extractBand(eeg_Preprocessed,2,2,2);

%% Prueba 3  wavelets db2
% Se utilizo ejemplo encontrado en internet
%https://es.mathworks.com/matlabcentral/answers/455469-discrete-wavelet-transform-features-extraction

%Applying bandpass filter to filter out the unwanted signal <4 and >30Hz
selec = designfilt('bandpassiir', 'FilterOrder', 6, 'PassbandFrequency1',...
    0.1, 'PassbandFrequency2', 59, 'PassbandRipple', 1, 'SampleRate', Fs);

% Implementacion de filtros diseñados
yy1 = filtfilt(selec,  eeg_Preprocessed);

%Apply DWT at 5 level of decomposition
waveletFunction = 'db2';
[C,L] = wavedec(yy1,5,waveletFunction);
cD11 = detcoef(C,L,1);                   
cD21 = detcoef(C,L,2);                  
cD31 = detcoef(C,L,3);                   
cD41 = detcoef(C,L,4);                  
cD51 = detcoef(C,L,5);                  
cA51 = appcoef(C,L,waveletFunction,5);   
D11 = wrcoef('d',C,L,waveletFunction,1); %Gamma
D21 = wrcoef('d',C,L,waveletFunction,2); %Beta
D31 = wrcoef('d',C,L,waveletFunction,3); %Alpha
D41 = wrcoef('d',C,L,waveletFunction,4); 
D51 = wrcoef('d',C,L,waveletFunction,5); 
A51 = wrcoef('a',C,L,waveletFunction,5); 

%% Comparacion de resultados
figure(2); 
ax1 = subplot(311);
plot(t,theta,'r',t,delta, 'b');
title('Wavelets General y luego filtrado IIR')
ax2 = subplot(312);
plot(t,theta1,'r',t,delta1, 'b');
title('Solo Wavelets por niveles')
ax3 = subplot(313);
plot(t,D41,'r',t,D51, 'b');
title('Wavelets db2')
linkaxes([ax1,ax2,ax3],'x');