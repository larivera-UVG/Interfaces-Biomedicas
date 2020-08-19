load('data_1')
load('trainedModelSVM3.mat')
load('robotData.mat')

largoBuffer = 1;

Epocas = 3000;

L = largoBuffer*Epocas;



data = zeros(4,L);

etiquetasRN = zeros(757,1);
etiquetasSVM = zeros(757,1);
contEpocs = 1;

%*****Insertar figuras
t=1:L;
figure(1); clf;
%h = plot(t,data(1,:))
subplot(2,2,1);
h1 = plot(t,data(1,:))
title('Subplot 1: fpz')

subplot(2,2,2); 
h2 = plot(t,data(1,:))
title('Subplot 2: pz')

subplot(2,2,3); 
h3 = plot(t,data(1,:))
title('Subplot 3: eog')

subplot(2,2,4); 
h4 = plot(t,data(1,:))
title('Subplot 4: emg')
%*******************

for i=1:size(fpz,1)
    n = mod(i,Epocas);
    
    if n == 0
        n = Epocas;
    end
    
    data(:,n)=[fpz(i);
                pz(i);
                eog(i);
                emg(i)];
            
    %*****************Figuras
    %h.YData(n) = fpz(i);
    h1.YData(n) = fpz(i);
    h2.YData(n) = pz(i);
    h3.YData(n) = eog(i);
    h4.YData(n) = emg(i);
    drawnow limitrate
    %**********************
    if n == Epocas
       % Calcular metricas 
%        media = [mean(data(1,:)), metricas(data(1,:),0,0), MMD(data(1,:)), bandpower(data(1,:)), kurtosis(data(1,:));
%                 mean(data(2,:)), metricas(data(2,:),0,0), MMD(data(2,:)), bandpower(data(2,:)), kurtosis(data(2,:));
%                 mean(data(3,:)), metricas(data(3,:),0,0), MMD(data(1,:)), bandpower(data(3,:)), kurtosis(data(3,:));
%                 mean(data(4,:)), metricas(data(4,:),0,0), MMD(data(4,:)), bandpower(data(4,:)), kurtosis(data(4,:))];
         media = [mean(abs(data(1,:))), metricas(data(1,:),0,0), MMD(data(1,:)), bandpower(data(1,:)), kurtosis(data(1,:)),...
                mean(abs(data(2,:))), metricas(data(2,:),0,0), MMD(data(2,:)), bandpower(data(2,:)), kurtosis(data(2,:)),...
                mean(abs(data(3,:))), metricas(data(3,:),0,0), MMD(data(1,:)), bandpower(data(3,:)), kurtosis(data(3,:)),...
                mean(abs(data(4,:)))];
        etiquetasSVM(contEpocs)= trainedModelSVM3.predictFcn(media);
        etiquetasSVM(contEpocs)
        
        %Robot
        figure(2); clf;
        r17.plot(Qtot{1,etiquetasSVM(contEpocs)})

        % Redes neuronales
%         ys_prueba = net(media');
%         etiquetasRN(contEpocs) = vec2ind(ys_prueba); % contiene las etiquetas asignadas
        
        contEpocs = contEpocs+1;
    end
    
end

% figure(1); clf;
% s = confusionchart(label,etiquetasSVM);
% s.Title = 'Matriz de confusión SVM grado 3';
% s.RowSummary = 'row-normalized';
% s.ColumnSummary = 'column-normalized'
% 
% figure(2); clf;
% s = confusionchart(label,etiquetasRN);
% s.Title = 'Matriz de confusión RN';
% s.RowSummary = 'row-normalized';
% s.ColumnSummary = 'column-normalized'