% =========================================================================
% MT3005 - LABORATORIO 6: Cinemática Diferencial Numérica
% -------------------------------------------------------------------------
% Inciso 5. Complete la función r17J, responsable de calcular de forma 
% numérica el jacobiano de un manipulador R17. La función r17FK(q) regresa 
% la cinemática directa (en forma de una matriz de transformación 
% homogénea) del manipulador para la configuración q (vector columna). 
% Emplee el Toolbox de Robótica para verificar que el resultado de su 
% función efectivamente corresponde al jacobiano del manipulador.
% =========================================================================
function J = r17J(q)
    % El argumento q es el vector de configuración, asuma que está dado por
    % un vector columna q = [q1; q2; q3; q4; q5; q6].
    
    n = 6; % Dimensión de la configuración del manipulador R17
    
    % Calcule la cinemática directa del manipulador R17
    T = r17FK(q); 
    % Extraiga de la matriz anterior, la matriz de rotación R
    R = T(1:3,1:3);
    
    % Inicialización del jacobiano
    J = zeros(6, n);
    delta=1e-5;
    % Complete el ciclo responsable de calcular la j-ésima columna del 
    % jacobiano, en base al algoritmo descrito en la guía del laboratorio
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