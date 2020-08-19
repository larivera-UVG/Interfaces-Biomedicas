% =========================================================================
% MT3005 - LABORATORIO 6: Cinem�tica Diferencial Num�rica
% -------------------------------------------------------------------------
% Inciso 5. Complete la funci�n r17J, responsable de calcular de forma 
% num�rica el jacobiano de un manipulador R17. La funci�n r17FK(q) regresa 
% la cinem�tica directa (en forma de una matriz de transformaci�n 
% homog�nea) del manipulador para la configuraci�n q (vector columna). 
% Emplee el Toolbox de Rob�tica para verificar que el resultado de su 
% funci�n efectivamente corresponde al jacobiano del manipulador.
% =========================================================================
function J = r17J(q)
    % El argumento q es el vector de configuraci�n, asuma que est� dado por
    % un vector columna q = [q1; q2; q3; q4; q5; q6].
    
    n = 6; % Dimensi�n de la configuraci�n del manipulador R17
    
    % Calcule la cinem�tica directa del manipulador R17
    T = r17FK(q); 
    % Extraiga de la matriz anterior, la matriz de rotaci�n R
    R = T(1:3,1:3);
    
    % Inicializaci�n del jacobiano
    J = zeros(6, n);
    delta=1e-5;
    % Complete el ciclo responsable de calcular la j-�sima columna del 
    % jacobiano, en base al algoritmo descrito en la gu�a del laboratorio
    for j = 1:n
        deltaQ = zeros(n,1);
        deltaQ(j) = delta;
        deriv = (r17FK(q+deltaQ)-T)/delta;
        %paso 4
        deltaO = deriv(1:3,4); %Fila 1,2,3 de la columna 4
        %paso 5
        deltaR = deriv(1:3,1:3);
        %paso 6
        antiSim = deltaR*R';
        %Ver en lec4
        %paso 7
        w = [antiSim(3,2);antiSim(1,3);antiSim(2,1)];
        
        J(1:3, j) = deltaO;
        J(4:6, j) = w;
    end
end 