% =========================================================================
% MT3005 - LABORATORIO 6: Cinemática Diferencial Numérica
% -------------------------------------------------------------------------
% Ver las instrucciones en la guía adjunta.
% =========================================================================
% Funcion auxiliar para calcular la cinematica directa del R17
function T = r17FK(q)
    DH = [0,q(1),0,-pi/2;q(2)+(pi/2),-0.355,0,-pi/2;q(3)+(pi/2),0,0.375,0;...
        q(4),0,0.375,0;q(5)-(pi/2),0,0,-pi/2;q(6)+(pi/2),0,0,0];
    alpha=-pi/2;
    rotX = [1,0,0,0;0,cos(alpha),-sin(alpha),0;0,sin(alpha),cos(alpha),0;0,0,0,1];
    d = -0.355;
    translZ = [1,0,0,0;0,1,0,0;0,0,1,d;0,0,0,1];
    T = translZ*rotX*getFK(DH); 
end