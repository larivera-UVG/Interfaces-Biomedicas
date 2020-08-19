% =========================================================================
% MT3005 - LABORATORIO 6: Cinemática Diferencial Numérica
% -------------------------------------------------------------------------
% Ver las instrucciones en la guía adjunta.
% =========================================================================
function A = genDHmatrix(theta, d, a, alpha)
    rotZ = [cos(theta),-sin(theta),0,0;sin(theta),cos(theta),0,0;0,0,1,0;0,0,0,1];
    translZ = [1,0,0,0;0,1,0,0;0,0,1,d;0,0,0,1];
    translX = [1,0,0,a;0,1,0,0;0,0,1,0;0,0,0,1];
    rotX = [1,0,0,0;0,cos(alpha),-sin(alpha),0;0,sin(alpha),cos(alpha),0;0,0,0,1];

    A = rotZ*translZ*translX*rotX;      
end