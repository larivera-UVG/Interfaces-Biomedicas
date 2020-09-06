% seriallist
% R17 = R17Init('COMX', 4000);
% q=[0;0;0;0;0;0];
% q=[0.5;0;0;0;0;0];
% q=[0;0.5;0;0;0;0];
% q=[0;0;0.5;0;0;0];
% q=[0;0;0;0.5;0;0];
% q=[0;0;0;0;0.5;0];
% q=[0;0;0;0;0;0.5];
% fK = R17fKine(R17, q);

% q=[0;0;0;0;0;0];
% R17Close(R17);


% Dimensiones del robot
a2 = 0; d2 = -0.355;
a3 = 0.375; d3 = 0;
a4 = 0.375; d4 = 0;
a5 = 0; d5 = 0;
a6 = 0; d6 = 0;

% Definimos el robot como un objeto SerialLink
L1 = Prismatic('theta', 0, 'a', 0, 'alpha', -pi/2, 'offset', 0);
L1.qlim = [0,0.600];
L2 = Revolute('d', d2, 'a', a2, 'alpha', -pi/2, 'offset', pi/2);
L3 = Revolute('d', d3, 'a', a3, 'alpha', 0, 'offset', pi/2);
L4 = Revolute('d', d4, 'a', a4, 'alpha', 0, 'offset', 0);
L5 = Revolute('d', d5, 'a', a5, 'alpha', -pi/2, 'offset', -pi/2);
L6 = Revolute('d', d6, 'a', a6, 'alpha', 0, 'offset', pi/2);
r17 = SerialLink([L1, L2, L3, L4, L5, L6], 'name', 'r17');

% Se establece la transformada de base para ajustar las coordenadas
% globales
r17.base=transl(0,0,-0.355)*trotx(-90);
q0 = [0 0 0 0 0 0];
r17.teach()
%r17.plot(q0, 'zoom', 10);

%r17.teach()

Qtot = cell(1,5);

% Se describe el vector de tiempo para la trayectoria. Se desea que esta
% ocurra durante 0.25s con tiempo de muestreo de 50ms
t = 0:0.05:0.25; 
t = t';
for s=1:5
if s==1
       q1 = [0 pi/2 pi/4 pi/4 0 0];
     elseif s==2
       q1 = [0 -pi/2 pi/4 pi/4 0 0];
     elseif s==3
      q1 = [0.473 pi/2 pi/4 pi/4 0 0];
     elseif s==4
       q1 = [0.473 -pi/2 pi/4 pi/4 0 0];
     else  
       q1 = [0.473 0 pi/4 pi/4 0 0];
end

Q1 = jtraj(q0, q1, t);
Q2 = flipud(Q1);%jtraj(q1, q0, t);

Q = [Q1;Q2];
     
Qtot{1,s}=Q;

end

r17.plot((Qtot{1,2}));