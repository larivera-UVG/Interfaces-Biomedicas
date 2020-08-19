% =========================================================================
% MT3005 - LABORATORIO 6: Cinem�tica Diferencial Num�rica
% -------------------------------------------------------------------------
% Ver las instrucciones en la gu�a adjunta.
% =========================================================================
function K = getFK(DH)
    
    K = eye(4);
    % Nos movemos fila a fila de la matriz de par�metros DH
    for i = 1:size(DH, 1)
        K = K*genDHmatrix(DH(i,1),DH(i,2),DH(i,3),DH(i,4));  
    end
end