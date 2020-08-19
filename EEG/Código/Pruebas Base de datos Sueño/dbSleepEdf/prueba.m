ll = zeros(757,16);
for k = 1:757
    ll(k,:) = [mean(abs(Raw_secc{1,1}(:,k))), metricas(Raw_secc{1,1}(:,k),0,0), MMD(Raw_secc{1,1}(:,k)), bandpower(Raw_secc{1,1}(:,k)), kurtosis(Raw_secc{1,1}(:,k)),...
                mean(abs(Raw_secc{1,2}(:,k))), metricas(Raw_secc{1,2}(:,k),0,0), MMD(Raw_secc{1,2}(:,k)), bandpower(Raw_secc{1,2}(:,k)), kurtosis(Raw_secc{1,2}(:,k)),...
                mean(abs(Raw_secc{1,3}(:,k))), metricas(Raw_secc{1,3}(:,k),0,0), MMD(Raw_secc{1,3}(:,k)), bandpower(Raw_secc{1,3}(:,k)), kurtosis(Raw_secc{1,3}(:,k)),...
                mean(abs(Raw_secc{1,4}(:,k)))];
end

ll = [ll,label];

llTrain = ll(219:end,:);
llPred = ll(1:218,:);

% etiquetasSVM= trainedModelSVM3.predictFcn(ll(:,1:end-1));
% 
% % ys_prueba = net(ll');
% % etiquetasRN = vec2ind(ys_prueba); % contiene las etiquetas asignadas
% 
% figure(1); clf;
% s = confusionchart(label,etiquetasSVM);
% s.Title = 'Matriz de confusión SVM grado 3';
% s.RowSummary = 'row-normalized';
% s.ColumnSummary = 'column-normalized'
% % 
% % figure(2); clf;
% % s = confusionchart(label,etiquetasRN);
% % s.Title = 'Matriz de confusión RN';
% % s.RowSummary = 'row-normalized';
% % s.ColumnSummary = 'column-normalized'
% 
% etiquetasSVM= trainedModelSVM3.predictFcn(Input_Vector');
% 
% ys_prueba = net(Input_Vector);
% etiquetasRN = vec2ind(ys_prueba); % contiene las etiquetas asignadas
% 
% figure(1); clf;
% s = confusionchart(vec2ind(Target_Vector),etiquetasSVM);
% s.Title = 'Matriz de confusión SVM grado 3';
% s.RowSummary = 'row-normalized';
% s.ColumnSummary = 'column-normalized'
% 
% figure(2); clf;
% s = confusionchart(vec2ind(Target_Vector),etiquetasRN);
% s.Title = 'Matriz de confusión RN';
% s.RowSummary = 'row-normalized';
% s.ColumnSummary = 'column-normalized'