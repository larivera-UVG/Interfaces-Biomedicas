%%SIMULACIÓN CON DATOS ADQUIRIDOS EN TIEMPO REAL

function varargout = interfaz_tiempo_real(varargin)
% INTERFAZ_TIEMPO_REAL MATLAB code for interfaz_tiempo_real.fig
%      INTERFAZ_TIEMPO_REAL, by itself, creates a new INTERFAZ_TIEMPO_REAL or raises the existing
%      singleton*.
%
%      H = INTERFAZ_TIEMPO_REAL returns the handle to a new INTERFAZ_TIEMPO_REAL or the handle to
%      the existing singleton*.
%
%      INTERFAZ_TIEMPO_REAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFAZ_TIEMPO_REAL.M with the given input arguments.
%
%      INTERFAZ_TIEMPO_REAL('Property','Value',...) creates a new INTERFAZ_TIEMPO_REAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interfaz_tiempo_real_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interfaz_tiempo_real_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interfaz_tiempo_real

% Last Modified by GUIDE v2.5 17-Oct-2020 18:25:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interfaz_tiempo_real_OpeningFcn, ...
                   'gui_OutputFcn',  @interfaz_tiempo_real_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before interfaz_tiempo_real is made visible.
function interfaz_tiempo_real_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interfaz_tiempo_real (see VARARGIN)

% Choose default command line output for interfaz_tiempo_real
handles.output = hObject;

% Initialise tabs
handles.tabManager = TabManager( hObject );
%Importar imagen del disp. robótico.
axes(handles.axes5);
path = 'C:\Users\ferna\Desktop\R17.PNG';   %Colocar el path en donde se encuentre la imagen 
imag = imread(path);
imshow(imag);
axis off;

%Inicializar puerto serial
global pserial
puerto = 'COM3';
delete(instrfind({'Port'},{puerto}));
pserial=serial(puerto,'BaudRate',115200,'Timeout',10);
fopen(pserial);

% Set-up a selection changed function on the create tab groups
% tabGroups = handles.tabManager.TabGroups;
% for tgi=1:length(tabGroups)
%     set(tabGroups(tgi),'SelectionChangedFcn',@tabChangedCB)
% end

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = interfaz_tiempo_real_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSelectMain.
function buttonSelectMain_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSelectMain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tabMan = handles.tabManager;
tabMan.Handles.TabA.SelectedTab = tabMan.Handles.TabA01Main;

% --- Executes on button press in buttonSelectSupplementary.
function buttonSelectSupplementary_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSelectSupplementary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tabMan = handles.tabManager;
tabMan.Handles.TabA.SelectedTab = tabMan.Handles.TabA02Supplementary;

function editSup1_Callback(hObject, eventdata, handles)
% hObject    handle to editSup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSup1 as text
%        str2double(get(hObject,'String')) returns contents of editSup1 as a double


% --- Executes during object creation, after setting all properties.
function editSup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSup2_Callback(hObject, eventdata, handles)
% hObject    handle to editSup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSup2 as text
%        str2double(get(hObject,'String')) returns contents of editSup2 as a double


% --- Executes during object creation, after setting all properties.
function editSup2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSup3_Callback(hObject, eventdata, handles)
% hObject    handle to editSup3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSup3 as text
%        str2double(get(hObject,'String')) returns contents of editSup3 as a double


% --- Executes during object creation, after setting all properties.
function editSup3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSup3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in robot.
function robot_Callback(hObject, eventdata, handles)
global Robot
global Q_traj
global q_conf
global q0
global select_rob
select_rob = 0;

%DEFINICIÓN DEL DISP. ROBÓTICO SEGÚN LA SELECCIÓN
contents = cellstr(get(hObject,'String'));
value = contents{get(hObject,'Value')};
switch value
    case 'R17'   %Disp. R17
        axes(handles.axes5);
        path = 'C:\Users\ferna\Desktop\R17.PNG';   %Verificar el path de la imagen
        imag = imread(path);
        imshow(imag);
        load 'R17_traj.mat'   %Cargar trajectorias
        load 'R17_conf.mat'   %Cargar configuraciones para mov. por junta
        set(handles.uibuttongroup1, 'Visible', 'of');
        set(handles.uibuttongroup2, 'Visible', 'of');
        set(handles.uibuttongroup3, 'Visible', 'on');
        set(handles.text42, 'Visible', 'on');
        set(handles.text43, 'Visible', 'of');
        select_rob = 1;
        %Dimensiones robot
        q0 = zeros(1,6);
        a1 = 0; a2 = 0; a3 = 375; a4 = 375; a5 = 0; a6 = 0;
        d2 = -355; d3 = 0; d4 = 0; d5 = 0;  d6 = 0;
        alpha1 = -pi/2; alpha2 =  -pi/2; alpha3 = 0; alpha4 = 0; alpha5 = -pi/2; alpha6 = 0;
        theta1 = 0; theta2 = pi/2; theta3 = pi/2; theta4 = 0; theta5 = -pi/2; theta6 = pi/2;

        % Definición de links y creación del robot como objeto SerialLink
        L1 = Prismatic('a', a1, 'alpha', alpha1 ,'theta',0,'offset',theta1);
        L1.qlim = [0,625/2];  %Topes de la primera junta
        L2 = Revolute('d', d2, 'a', a2, 'alpha', alpha2, 'offset', theta2);
        L3 = Revolute('d', d3, 'a', a3, 'alpha', alpha3, 'offset', theta3);
        L4 = Revolute('d', d4, 'a', a4, 'alpha', alpha4, 'offset', theta4);
        L5 = Revolute('d', d5, 'a', a5, 'alpha', alpha5, 'offset', theta5);
        L6 = Revolute('d', d6, 'a', a6, 'alpha', alpha6, 'offset', theta6);
        Robot = SerialLink([L1,L2,L3,L4,L5,L6], 'name', 'R17');
    case 'Scara'     %Robot SCARA
        axes(handles.axes5);
        path = 'C:\Users\ferna\Desktop\scara.PNG';  %Verificar path de la imagen
        imag = imread(path);
        imshow(imag);
        load 'SCARA_traj.mat'   %Cargar trayectorias 
        load 'SCARA_conf.mat'   %Cargar configuraciones para mov. por junta
        set(handles.uibuttongroup1, 'Visible', 'of');
        set(handles.uibuttongroup2, 'Visible', 'on');
        set(handles.uibuttongroup3, 'Visible', 'of');
        set(handles.text42, 'Visible', 'of');
        set(handles.text43, 'Visible', 'on');
        select_rob = 2;
        %Dimensiones robot
        q0 = zeros(1,4);
        l1=1; l2=1; l3=1; l4=0.5;
        % Definición del robot usando DH (th,d,a,alfa,P/R)
        L1 = Link([0, l1, l2, 0, 0]);
        L2 = Link([0, 0, l3, 0, 0]);
        L3 = Link([0, 0, 0, 0, 1]);
        L3.qlim = [0,1];
        L4 = Link([0, 0, 0, pi, 0]);
        Robot = SerialLink([L1,L2,L3,L4], 'name', 'scara'); 
    case '2 juntas'   %Disp. con 2 juntas
        axes(handles.axes5);
        path = 'C:\Users\ferna\Desktop\simple.PNG';    %Verificar path de la imagen
        imag = imread(path);
        imshow(imag);
        load 'Rsimple_traj.mat'    %Cargar trayectorias
        load 'Rsimple_conf.mat'    %Cargar configuraciones para mov. por junta
        set(handles.uibuttongroup1, 'Visible', 'on');
        set(handles.uibuttongroup2, 'Visible', 'of');
        set(handles.uibuttongroup3, 'Visible', 'of');
        set(handles.text42, 'Visible', 'of');
        set(handles.text43, 'Visible', 'on');
        select_rob = 3;
        q0 = zeros(1,2); 
        a1 = 1; a2 = 1;
        L1 = Revolute('d', 0, 'a', a1, 'alpha', pi/2);
        L2 = Revolute('d', 0, 'a', a2, 'alpha', 0);
        Robot = SerialLink([L1,L2], 'name', 'two link');
end

%Gráfica robot
figure(1); 
plot(Robot,q0);

% Hints: contents = cellstr(get(hObject,'String')) returns robot contents as cell array
%        contents{get(hObject,'Value')} returns selected item from robot


% --- Executes during object creation, after setting all properties.
function robot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to robot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles) 
global Robot
global select_rob
global Q_traj
global origen


%CONTROL DE MOVIMIENTOS DE FORMA MANUAL PARA EL DISP. DE 2 JUNTAS
if (select_rob == 3)
    origen = [0,0];
    switch(get( eventdata.NewValue,'Tag'))
        case 'radiobutton2'
            Q = Q_traj{:,1};
        case 'radiobutton3'
            Q = Q_traj{:,2};     
        case 'radiobutton4'
            Q = Q_traj{:,3};     
        case 'radiobutton5'
            Q = Q_traj{:,4};    
    end
end
figure(1);
plot(Robot,Q);

% --- Executes when selected object is changed in uibuttongroup3.
function uibuttongroup3_SelectionChangedFcn(hObject, eventdata, handles)
global Robot
global select_rob
global Q_traj
global origen

%CONTROL DE MOVIMIENTOS DE FORMA MANUAL PARA EL DISP. R17
if (select_rob == 1)
    origen = [0,0,0,0,0,0];
    switch(get( eventdata.NewValue,'Tag'))
        case 'radiobutton14'
            Q = Q_traj{:,1};
        case 'radiobutton15'
            Q = Q_traj{:,2};   
        case 'radiobutton16'
            Q = Q_traj{:,3};  
        case 'radiobutton17'
            Q = Q_traj{:,4}; 
    end
end
figure(1);
plot(Robot,Q);

% --- Executes when selected object is changed in uibuttongroup2.
function uibuttongroup2_SelectionChangedFcn(hObject, eventdata, handles)
global Robot
global select_rob
global Q_traj
global origen

%CONTROL DE MOVIMIENTOS DE FORMA MANUAL PARA EL DISP. SCARA
if (select_rob == 2)
    origen = [0,0,0,0];
    switch(get( eventdata.NewValue,'Tag'))
        case 'radiobutton8'
            Q = Q_traj{:,1};
        case 'radiobutton9'
            Q = Q_traj{:,2};
        case 'radiobutton10'
            Q = Q_traj{:,3};
        case 'radiobutton11'
            Q = Q_traj{:,4}; 
    end
end
figure(1);
plot(Robot,Q);

% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
global caracteristicas
global select_rob
global Q_traj
global q_conf
global q0
global Robot
global stop
global pserial
global movimiento
movimiento = 0;
stop = 0;

%load RN_female.mat
load net_database.mat

srate = 1000;     %Frec. muestreo
t_inicio = 2000;  %Tiempo inicial sin mov. en ms
t = 1;            %Tiempo total en segundos
t_m = t*0.93;     %Tiempo mov.
t_r = t*0.07;     %Tiempo sin mov.
m = t*srate;      %No. muestras totales
m_m = t_m*srate;  %No. muestras mov.
m_r = t_r*srate;  %No. muestras sin mov.

cont = 1;         %Contador no. de muestras
cont_r = 1;       %Contador no. de muestras anteriores sin mov.
cont_f = 0;       %Contador no. grabaciones
grab = 10;        %No. grabaciones

canales = 2;                  %No. canales
data = zeros(canales,m_m);    %Array para almacenar datos con movimiento
data_c = zeros(canales,m);    %Array para almacenar datos centrados 
data_r = zeros(canales,m_r);  %Array para almacenar un tiempo sin mov.
n_data = zeros(1,canales*m);  %Array para almacenar los dos canales unidos.
data_f = [];                  %Array para almacenar datos filtro pasa bandas
data_n = [];                  %Array para almacenar datos filtro notch

canal_1 = zeros(1,m);                   %Almacenar todas las corridas canal 1
canal_2 = zeros(1,m);                   %Almacenar todas las corridas canal 2

F_pb = filtro_pasa_banda(srate,20,450);    %Diseñar filtro pasa banda       
F_notch = filtro_rechaza_banda(srate);     %Diseñar filtro rechaza banda 

%Inicializar variables
v = 0; 
v2 = zeros(1,canales);    
volt = 0;     
ga = 0.15;                                 %Tolerancia threshold
b_act = 0;                                 %Bandera para detectar actividad


%DETALLES GRÁFICAS
t = 1:m;
h1 = plot(handles.axes2,t,zeros(1,m));
ylim(handles.axes2,[-0.5,0.5]);
ylabel(handles.axes2,"V");
%xlabel(handles.axes2,"ms");
h2 = plot(handles.axes3,t,zeros(1,m));
ylim(handles.axes3,[-0.5,0.5]);
ylabel(handles.axes3,"V");
%xlabel(handles.axes3,"ms");

th = identificacion2(pserial,t_inicio);    %Identificar el valor del threshold

while stop == 0  
    for n = 1:canales
        v = fscanf(pserial,'%d');          %Leer datos puerto serial
        if(isempty(v) == 1)
            v = fscanf(pserial,'%d');
        end
        v2(:,n) = v(1)*5/1024;               %Convertir de 0-5V
        if (v2(:,n) > 2.5)
            v2(:,n) = 0;
        end        
    end  
    volt = max([v2(:,1),v2(:,2)]);   %Obtener el valor máximo del voltaje entre ambos canales
   
    %Detectar inicio de actividad
    if volt > (th + ga) && b_act == 0 && volt < 5 && cont_r > 25
        %Activar bandera de inicio de actividad
        b_act = 1;
    end
    
    if b_act == 0
        data_r(1,cont_r) = v2(:,1);        %Almaceno una ventana de muestras anteriores al mov.
        data_r(2,cont_r) = v2(:,2); 
        cont_r = cont_r + 1;             
        if cont_r == m_r + 1             %Reset el contador para las muestras anteriores al mov.
            cont_r = 1;
        end
    else   
        for n_n = 1:canales
            data(n_n,cont) = v2(:,n_n);        %Guardo la señal activa
        end
        data_c = [data_r - mav(data_r),data - mav(data)];       %Centrar datos
        data_f = filter(F_pb, data_c);                          %Aplicar filtro pasa bandas
        data_n = filter(F_notch, data_f);                       %Aplicar filtro notch
        h1.YData(cont) = data_n(1,cont);                       %Actualizar gráfica
        h2.YData(cont) = data_n(2,cont); 
        drawnow limitrate
        cont = cont +1;                                            
        if(cont == (m_m+1))                                  %Evaluar longitud del contador
            cont = 1;                                        %Reiniciar contadores
            cont_r = 1;
            cont_f = cont_f + 1;                             %Aumentar contador para no. de grabaciones
            b_act = 0;                                       %Reiniciar bandera de actividad
            
            %Extracción características
            n_data = [data_n(1,:),data_n(2,:)];  %unir los 2 canales 
            n1 = 500;        
            n2 = 1000;
            n3 = 1500;
            v_mav  = [mav(n_data(1,1:n1)),mav(n_data(1,n1+1:n2)),mav(n_data(1,n2+1:n3)),mav(n_data(1,n3+1:end))];
            v_zc   = [zc(n_data(1,1:n1),0),zc(n_data(1,n1+1:n2),0),zc(n_data(1,n2+1:n3),0),zc(n_data(1,n3+1:end),0)];
            %v_iemg = [emg(n_data(1,1:n1)),emg(n_data(1,n1+1:n2)),emg(n_data(1,n2+1:n3)),emg(n_data(1,n3+1:end))];
            v_rms  = [rms(n_data(1,1:n1)),rms(n_data(1,n1+1:n2)),rms(n_data(1,n2+1:n3)),rms(n_data(1,n3+1:end))];
            v_wl   = [wl(n_data(1,1:n1)),wl(n_data(1,n1+1:n2)),wl(n_data(1,n2+1:n3)),wl(n_data(1,n3+1:end))];
            %v_var  = [varianza(data(1,1:n1)),varianza(data(1,n1+1:n2)),varianza(data(1,n2+1:n3)),varianza(data(1,n3+1:end))];
            %v_desv = [desv(data(1,1:n1)),desv(data(1,n1+1:n2)),desv(data(1,n2+1:n3)),desv(data(1,n3+1:end))];

            features = [v_mav,v_zc,v_wl,v_rms];   %Características
            y_prueba = net(features');
            clase_prueba = vec2ind(y_prueba);   % contiene la etiqueta asignada
            
            %Establecer la posición según la clase
            if movimiento == 0
                switch clase_prueba
                    case 1
                        Q = Q_traj{:,1};
                    case 2
                        Q = Q_traj{:,2};
                    case 3
                        Q = Q_traj{:,3};
                    case 4
                        Q = Q_traj{:,4};
                end
            elseif movimiento == 1
                switch clase_prueba
                    case 1
                        Q = q_conf{:,1};
                    case 2
                        Q = q_conf{:,2};
                    case 3
                        Q = q_conf{:,3};
                    case 4
                        Q = q_conf{:,4};
                end            
            end
            
            %Actualizar características en pantalla
            if caracteristicas == 1
               set(handles.mav,'String',v_mav(1));  
               set(handles.zc,'String',v_zc(1)); 
               set(handles.rms,'String',v_rms(1));
               set(handles.wl,'String',v_wl(1));
            end
          set(handles.num,'String',clase_prueba);
          figure(1); 
          plot(Robot,Q);
        end
    end
end

fclose(pserial);
delete(pserial);
close(handles.output);
close(figure(1));


% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
global stop
global pserial
stop = 1;

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
global caracteristicas 
contents = cellstr(get(hObject,'String'));
value = contents{get(hObject,'Value')};

%CONTROL DE LAS CARACTERÍSTICAS QUE SE MUESTRAN EN PANTALLA
switch value
    case 'Sí'
        caracteristicas = 1;
        set(handles.MAV1, 'Visible', 'on');
        set(handles.mav, 'Visible', 'on');
        set(handles.ZC1, 'Visible', 'on');
        set(handles.zc, 'Visible', 'on');
        set(handles.IEMG1, 'Visible', 'of');
        set(handles.iemg, 'Visible', 'of');
        set(handles.RMS1, 'Visible', 'on');
        set(handles.rms, 'Visible', 'on');
        set(handles.STD1, 'Visible', 'of');
        set(handles.std, 'Visible', 'of');
        set(handles.VAR1, 'Visible', 'of');
        set(handles.var, 'Visible', 'of');
        set(handles.WL1, 'Visible', 'on');
        set(handles.wl, 'Visible', 'on');
        set(handles.caract, 'Visible', 'on');
    case 'No'
        caracteristicas = 0; 
        set(handles.MAV1, 'Visible', 'of');
        set(handles.mav, 'Visible', 'of');
        set(handles.ZC1, 'Visible', 'of');
        set(handles.zc, 'Visible', 'of');
        set(handles.IEMG1, 'Visible', 'of');
        set(handles.iemg, 'Visible', 'of');
        set(handles.RMS1, 'Visible', 'of');
        set(handles.rms, 'Visible', 'of');
        set(handles.STD1, 'Visible', 'of');
        set(handles.std, 'Visible', 'of');
        set(handles.VAR1, 'Visible', 'of');
        set(handles.var, 'Visible', 'of');
        set(handles.WL1, 'Visible', 'of');
        set(handles.wl, 'Visible', 'of');
        set(handles.caract, 'Visible', 'of');
        
end


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function radiobutton6_Callback(hObject, eventdata, handles)
function radiobutton7_Callback(hObject, eventdata, handles)


% --- Executes on button press in origen.
function origen_Callback(hObject, eventdata, handles)
% hObject    handle to origen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global origen
global Robot
figure(1); 
plot(Robot,origen);      %Colocar el disp. en el origen
draw now


% --- Executes on selection change in movimiento.
function movimiento_Callback(hObject, eventdata, handles)
contents2 = cellstr(get(hObject,'String'));
value2 = contents2{get(hObject,'Value')};
global movimiento

%SELECCIÓN DEL TIPO DE MOVIMIENTO
switch value2
    case 'Pick&Place'
        movimiento = 0;
    case 'Juntas'
        movimiento = 1;
end


% --- Executes during object creation, after setting all properties.
function movimiento_CreateFcn(hObject, eventdata, handles)
% hObject    handle to movimiento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
