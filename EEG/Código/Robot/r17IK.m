 % =========================================================================
% LABORATORIO 8
% -------------------------------------------------------------------------
% Complete la función UR5IK, responsable de resolver de forma numérica el
% problema de cinemática inversa (tanto de posición como de orientación) 
% para un manipulador UR5. Las funciones UR5FK(q) y pumaJ(q) regresan la 
% cinemática directa y el jacobiano del robot respectivamente, siempre y 
% cuando q sea pasado como un vector columna. 
%
% La función UR5IK tiene como argumentos una pose de efector final
% deseada Td, una configuración inicial q0 y un valor binario solop que 
% permite la selección de sólo calcular la cinemática inversa de posición, 
% mientras que regresa la configuración deseada q.
%
% Puede emplear la Toolbox de robótica para verificar que el resultado de
% su función es correcta, al cargar el modelo del robot Puma mediante el
% comando mdl_ur5 y usando el método 
% ur5.ikine(Td, 'q0', q0)
% =========================================================================
function q = r17IK(Td, q0, solop)
    eps_p = 1e-06; % Tolerancia del error de posición
    eps_o = 1e-05; % Tolerancia del error de orientación
    % Número máximo de iteraciones (reducir en caso de mala performance 
    % durante la simulación)
    K = 50; 
    
    % Inicialización de variables
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
    
    % Complete la inicialización y el ciclo responsable de implementar el
    % método iterativo, según el algoritmo descrito en la guía del
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
        
        q = q + Ji*e; % Se actualiza la solución
        k = k + 1;
    end
end