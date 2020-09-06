% =========================================================================
%CÓDIGO PARA GENERAR LAS TRAYECTORIAS DEL LOS ROBOTS
% =========================================================================
% SIMULACIÓN DEL R17
%Parámetros de Denavit-Hartenberg
q0 = zeros(1,6);
a1 = 0; a2 = 0; a3 = 375; a4 = 375; a5 = 0; a6 = 0;
d1 = 0; d2 = -355; d3 = 0; d4 = 0; d5 = 0;  d6 = 0;
alpha1 = -pi/2; alpha2 =  -pi/2; alpha3 = 0; alpha4 = 0; alpha5 = -pi/2; alpha6 = 0;
theta1 = 0; theta2 = pi/2; theta3 = pi/2; theta4 = 0; theta5 = -pi/2; theta6 = pi/2;

% Definición de links y creación del robot
L1 = Prismatic('a', a1, 'alpha', -pi/2 ,'theta',0,'offset',0);
L1.qlim = [0,625/2];

L2 = Revolute('d',-355, 'a', a2, 'alpha', pi/2,'offset',-pi/2);
L3 = Revolute('d', 0 , 'a', a3, 'alpha',0 ,'offset',-pi/2);
L4 = Revolute('d', 0, 'a', a4, 'alpha', 0,'offset',0);
L5 = Revolute('d', 0, 'a', a5, 'alpha', -pi/2,'offset',-pi/2 );
L6 = Revolute('d', 0, 'a', a6, 'alpha',  0,'offset',0 );

R17 = SerialLink([L1,L2,L3,L4,L5,L6], 'name', 'R17');
% Transformación de Base (roto -90 en x)
R17.base = transl(0, 0, d2)*trotx(-pi/2);
teach(R17, q0,'zoom',1);
%% Robot 2 eslabones
a1 = 1; a2 = 1;
L1 = Revolute('d', 0, 'a', a1, 'alpha', pi/2);
L2 = Revolute('d', 0, 'a', a2, 'alpha', 0);
Robot = SerialLink([L1,L2], 'name', '2 juntas');

q0 = zeros(1,2);
teach(Robot, q0,'zoom',1);

%% SCARA
%Dimensiones robot
l1=1; l2=1; l3=1; l4=0.5;
% Definición del robot usando DH (th,d,a,alfa,P/R)
L1 = Link([0, l1, l2, 0, 0]);
L2 = Link([0, 0, l3, 0, 0]);
L3 = Link([0, 0, 0, 0, 1]);
L3.qlim = [0,1];
L4 = Link([0, 0, 0, pi, 0]);
Robot = SerialLink([L1,L2,L3,L4], 'name', 'scara'); 

q0 = zeros(1,4);
teach(Robot, q0,'zoom',1);

%% TRAYECTORIA ROBOT 2 ESLABONES
Q_traj = cell(1,5);

% Se describe el vector de tiempo para la trayectoria. Se desea que esta
% ocurra durante 0.25s con tiempo de muestreo de 50ms
t = 0:0.1:0.25; 
t = t';
for s=0:5
    if s==0
        q1 = [-pi/4,pi/4];
    elseif s == 1
        q1 = [0,pi/2]; 
    elseif s==2
        q1 = [0,-pi/2];
    elseif s==3
        q1 = [pi/2,0]; 
    elseif s==4
        q1 = [-pi/2,0];
    else  
        q1 = [0,pi/4];
end

Q1 = jtraj(q0, q1, t);
     
Q_traj{1,s+1}=Q1;

end
%save("Rsimple_traj.mat","Q_traj")
%% Trayectoria SCARA
Q_traj = cell(1,5);

% Se describe el vector de tiempo para la trayectoria. 
t = 0:0.1:0.25; 
t = t';
for s=0:5
    if s==0
        q1 = [0,-pi/4,0,0];
    elseif s==1
        q1 = [0,pi/2,0,0];  
    elseif s==2
        q1 = [0,-pi/2,0,0];
    elseif s==3
        q1 = [pi/2,0,0,0]; 
    elseif s==4
        q1 = [-pi/2,0,0,0];
    else  
        q1 = [0,-pi/2,1,0];
end

Q1 = jtraj(q0, q1, t);
     
Q_traj{1,s+1}=Q1;

end
%save("SCARA_traj.mat","Q_traj")
%% Trayectoria R17
Q_traj = cell(1,5);

% Se describe el vector de tiempo para la trayectoria. 
t = 0:0.1:0.25; 
t = t';
for s=0:5
    if s==0
        q1 = [0,0,0,pi/4,0,0]; 
    elseif s==1 
        q1 = [0,0,pi/2,pi/2,0,0]; 
    elseif s==2
        q1 = [0,0,pi/2,0,0,0];
    elseif s==3
        q1 = [0,0,-pi/2,0,0,0];
    elseif s==4
        q1 = [0,0,0,pi/2,0,0];
    else  
        q1 = [0,0,0,-pi/2,0,0];
end

Q1 = jtraj(q0, q1, t);
     
Q_traj{1,s+1}=Q1;

end
%save("R17_traj.mat","Q_traj")

