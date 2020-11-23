%% Trayectorias UR5
% Este codigo tiene como fin definir la trayectoria suave que hara el UR5
% para los diferentes comandos necesarios.

% Rodrigo Ralda - 14813
% 2020

% mdl_ur5;
% ur5.teach()

% mdl_onelink;
% onelink.teach()

% mdl_puma560;
% p560.teach()
%clear all

%  mdl_simple6;
%  s6.teach()

% mdl_puma560;
% p = [0.8 0 0];
% T = transl(p) * troty(pi/2);
% qr(1) = -pi/2;
% qqr = p560.ikine6s(T, 'ru');
% qrt = jtraj(qr, qqr, 50);
% ae = [138 8];
% p(1) = 1;
% clf
% plot_sphere(p, 0.05, 'y');
% p560.plot3d(qrt, 'view', ae);

% % clear all;
% % % =========================================================================
% % % EJEMPLO: MOVIMIENTO PUNTO A PUNTO EN ESPACIO DE CONFIGURACIÓN
% % % =========================================================================
% % mdl_puma560; % Cargamos el modelo del robot Puma 560
% % 
% % % Se decriben dos poses de efector final deseadas
% % T1 = transl(0.4, 0.2, 0) * trotx(pi);
% % T2 = transl(0.4, -0.2, 0) * trotx(pi/2);
% % 
% % % Se obtienen las configuraciones inicial y final mediante cinemática
% % % inversa (analítica)
% % q1 = p560.ikine6s(T1); 
% % q2 = p560.ikine6s(T2);
% % 
% % % Se describe el vector de tiempo para la trayectoria. Se desea que esta
% % % ocurra durante 2s con tiempo de muestreo de 50ms
% % t = 0:0.05:2; 
% % t = t';
% % 
% % % Se obtiene la trayectoria en el espacio de configuración mediante la
% % % función jtraj y graficamos la trayectoria de cada parámetro de la
% % % configuración
% % Q = p560.jtraj(T1, T2, t);
% % figure;
% % qplot(t, Q);
% % 
% % % Graficamos esferas en los puntos inicial y final de la trayectoria
% % figure;
% % plot_sphere(T1(1:3,end), 0.05, 'green');
% % plot_sphere(T2(1:3,end), 0.05, 'green');
% % 
% % % Se anima la trayectoria del robot
% % p560.plot3d(Q);
% % 
% % % Se obtiene y grafica la trayectoria del efector final
% % T = p560.fkine(Q);
% % p = T.transl;
% % figure;
% % subplot(1,2,1);
% % plot(p(:,1),p(:,2), 'LineWidth', 1);
% % subplot(1,2,2);
% % plot(t, T.torpy('xyz'), 'LineWidth', 1);

mdl_ur5; % Cargamos el modelo del robot Puma 560
%ur5.teach()
q0 = [0 -pi/2 0 0 0 0];
Qur5 = cell(1,5);

% Se describe el vector de tiempo para la trayectoria. Se desea que esta
% ocurra durante 0.25s con tiempo de muestreo de 50ms
t = 0:0.05:0.25; 
t = t';
for s=1:5
if s==1
       q1 = [0 -pi 0 0 0 0];
     elseif s==2
       q1 = [0 0 0 0 0 0];
     elseif s==3
      q1 = [pi/4 -pi 0 0 0 0];
     elseif s==4
       q1 = [-pi/4 0 0 0 0 0];
     else  
       q1 = [pi/2 -pi 0 0 0 0];
end

Q1 = jtraj(q0, q1, t);
Q2 = flipud(Q1);%jtraj(q1, q0, t);

Q = [Q1;Q2];
     
Qur5{1,s}=Q;

end

ur5.plot((Qur5{1,2}));
%p560.plot3d(Q);

[0 0 0 0 0 0]