%% Trayectorias R17
% Codigo para calcular las trayectorias de las juntas del R17 para cada
% comando.

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
a2 = 0;
d2 = -0.355;

a3 = 0.375;
d3 = 0;

a4 = 0.375;
d4 = 0;

a5 = 0;
d5 = 0;

a6 = 0;
d6 = 0;

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
q1 = [0 pi/2 pi/2 0 0 0];
q2 = [0.6  pi/2 0 0 0 0];
%r17.plot(q0, 'zoom', 10);

q0 =  [0 pi/2 pi/4 pi/4 0 0];
q0 =  [0 -pi/2 pi/4 pi/4 0 0];
q0 =  [0.473 pi/2 pi/4 pi/4 0 0];
q0 =  [0.473 -pi/2 pi/4 pi/4 0 0];
q0 =  [0.473 0 pi/4 pi/4 0 0];

%r17.teach(q0)

%% *********************************************************************
Qtot = cell(1,5);
  
 %s = 5;
 for s=1:5
     
     if s==1
       x = 0.64;
       y = 0;
       z = 0.265;
     elseif s==2
       x = -0.64;
       y = 0;
       z = 0.265; 
     elseif s==3
       x = 0.64;
       y = 0.473;
       z = 0.265; 

     elseif s==4
       x = -0.64;
       y = 0.473;
       z = 0.265;  
     else
       x = 0;
       y = 0.55;
       z = 0.75;   
     end

     %Se establecen los puntos X,Y,Z donde se quiere que pase el robot.
    via=[ 0,0,0.750;
          x,y,z;%final
          x,y,z;
          x,y,z;
          0,0,0.750];

     %Se establece la configuracion incial del robot.
     q0 = [0; 0; 0; 0; 0; 0];

     %Se inicializan variables a utilizar.
     T=[];
     Q=[];
     qp=[];
     dim = size(via);

     %Se colocan los tiempos en segundos que se quiere que dure cada segmento.
     t1=3;%3
     t2=1;%1
     t3=3;%3
     t4=1;%1

    %Con los tiempos establecidos anteriormente se calculan 15 muestras
    %equidistantes para cada periodo de tiempo.

     t1s=    [0:t1/14:t1]';
     t2s=   [0:t2/14:t2]';
     t3s=  [0:t3/14:t3]';
     t4s=   [0:t4/14:t4]';

     %Se almacenan todas en un vector.
     t=[
         t1s,t2s,t3s,t4s
        ];
     %% Cinematica inversa
     %Se realizaran las mismas operaciones varias veces para cada segmento.
         for i = 1:dim(1)


            %Antes de llegar a la lata (i=4) rotar la garra para que pueda
            %agarrarla

            if(i<5)
                Tp = transl(via(i,:))*troty(90)*trotz(90);

            %Al llegar al ultimo segmento rotar la garra para que pueda soltar
            %la lata y esta caiga en la canasta como se requiere.
            else
               Tp = transl(via(i,:))*trotx(-90)*trotz(-10);

            end


            %Calcular la cinematica inversa para configuracion deseada de cada
            %final de segmento
            q = r17IK(Tp,q0,0);
            %Almacenar todas las posiciones de las juntas en una sola matriz.
            qp = [qp;q'];

            %Teniendo ya dos configuraciones de juntas se procede a interpolar
            %suavemente dichas configuraciones, mediante la joint-space
            %trajectory de Peter Corke
            if (i>1)
                [qf,qfd,qfdd]=jtraj(qp(i-1,:), qp(i,:), t(:,i-1));
                %Solamente se almace nan las posiciones en la matriz Q, a pesar
                %que se tiene velocidad y aceleracion pero no se usan en este
                %caso.
                Q = [Q;qf];
            end
         end
        %Graficar trayectoria para corroborar.
     Q(:,1)=abs(Q(:,1));
     
     Qtot{1,s}=Q;
     
 end
 r17.plot(Q);
 %ur5.teach(Q(60,:))
 
 %Se escribe como .txt para solo agregar llaves, comas y pegar en webots.
% dlmwrite('vectorQ.txt',Q)