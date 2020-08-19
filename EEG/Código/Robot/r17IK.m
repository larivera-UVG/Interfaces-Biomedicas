 % =========================================================================
% LABORATORIO 8
% -------------------------------------------------------------------------
% Complete la funci�n UR5IK, responsable de resolver de forma num�rica el
% problema de cinem�tica inversa (tanto de posici�n como de orientaci�n) 
% para un manipulador UR5. Las funciones UR5FK(q) y pumaJ(q) regresan la 
% cinem�tica directa y el jacobiano del robot respectivamente, siempre y 
% cuando q sea pasado como un vector columna. 
%
% La funci�n UR5IK tiene como argumentos una pose de efector final
% deseada Td, una configuraci�n inicial q0 y un valor binario solop que 
% permite la selecci�n de s�lo calcular la cinem�tica inversa de posici�n, 
% mientras que regresa la configuraci�n deseada q.
%
% Puede emplear la Toolbox de rob�tica para verificar que el resultado de
% su funci�n es correcta, al cargar el modelo del robot Puma mediante el
% comando mdl_ur5 y usando el m�todo 
% ur5.ikine(Td, 'q0', q0)
% =========================================================================
function q = r17IK(Td, q0, solop)
    eps_p = 1e-06; % Tolerancia del error de posici�n
    eps_o = 1e-05; % Tolerancia del error de orientaci�n
    % N�mero m�ximo de iteraciones (reducir en caso de mala performance 
    % durante la simulaci�n)
    K = 50; 
    
    % Inicializaci�n de variables
    q = q0;
    k = 0;
    
    pd = Td(1:3, 4);
    Rd = Td(1:3, 1:3);
    sd = rot2cuat(Rd);
    
    T = r17FK(q);
    p = T(1:3, 4);
    R = T(1:3, 1:3);
    s = rot2cuat(R);
    
    e_p = pd - p;
    s_e = multcuat(sd, invcuat(s));
    e_o = s_e(2:end);
    
    % Complete la inicializaci�n y el ciclo responsable de implementar el
    % m�todo iterativo, seg�n el algoritmo descrito en la gu�a del
    % laboratorio y sus notas de clase
    while((norm(e_p) > eps_p) && (norm(e_o) > eps_o) && (k < K))
        T = r17FK(q);
        J = r17J(q);
        
        p = T(1:3, 4);
        e_p = pd - p;
        
        if(solop == 1)
%             e_o = zeros(3,1);
            J = J(1:3,:);
            Ji = J'/(J*J'+0.1*eye(3));
            e = e_p;
        else
            R = T(1:3, 1:3);
            s = rot2cuat(R);
            s_e = multcuat(sd, invcuat(s));
            e_o = s_e(2:end);
            Ji = J'/(J*J'+0.1*eye(6));
            e = [e_p; e_o];
        end
        
        q = q + Ji*e; % Se actualiza la soluci�n
        k = k + 1;
    end
end