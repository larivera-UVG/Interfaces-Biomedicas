% -------------------------------------------------------------------------
% Autor: José Pablo Muñoz 
% Descripción: Código para hacer validación cruzada, se corre el NN 10
% veces. Se entrena con 9 grabaciones y la que queda libre se usa para  
% validar. Results_net almacena todos los resultados del entranmiento de la
% red mientras que results_input son los resultados de la validación
% cruzada. 
% -------------------------------------------------------------------------
id = ["1","2","3","4","5","6","7","8","9","10"]; 
runs = 9;
header = 'data_';
hypnograms = zeros(1,runs);
Input_Vectors = cell(1,runs);
Target_Vectors = cell(1,runs);
result_net = zeros(1,length(id));
result_input = zeros(1,length(id));
cont = 0;
for inputs = 1:runs
    Input_Vectors{1,inputs} = zeros(21,1200);
    Target_Vectors{1,inputs} = zeros(5,1200);
end


while cont < runs
    for s = 1:length(id)
        shift = circshift(id,s-1);
        ext = shift(10);
    
        for numbase = 1:runs 
            data = strcat(header,shift(numbase));
            run Ext_comb.m
            hypnograms(1,numbase)= length(hypnogram);
            Input_Vectors{1,numbase} = Input_Vector; 
            Target_Vectors{1,numbase} = Target_Vector; 
        end 
    
        Input_Vector = [Input_Vectors{1,1},Input_Vectors{1,2},Input_Vectors{1,3},Input_Vectors{1,4},Input_Vectors{1,5},Input_Vectors{1,6},Input_Vectors{1,7},Input_Vectors{1,8},Input_Vectors{1,9}];

        Target_Vector = [Target_Vectors{1,1},Target_Vectors{1,2},Target_Vectors{1,3},Target_Vectors{1,4},Target_Vectors{1,5},Target_Vectors{1,6},Target_Vectors{1,7},Target_Vectors{1,8},Target_Vectors{1,9}];
    
        run Neural_Network.m
        result_net(1,s) = result_1;
        data = strcat(header,ext);
        run Ext_comb.m
        run Create_confusion.m
        result_input(1,s) = result_2;
        cont = cont + 1;
        break
    end
end
