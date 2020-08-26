%%INTERFAZ SIMULACIÓN CON BASE DE DATOS 

function varargout = interfaz(varargin)
% INTERFAZ MATLAB code for interfaz.fig
%      INTERFAZ, by itself, creates a new INTERFAZ or raises the existing
%      singleton*.
%
%      H = INTERFAZ returns the handle to a new INTERFAZ or the handle to
%      the existing singleton*.
%
%      INTERFAZ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFAZ.M with the given input arguments.
%
%      INTERFAZ('Property','Value',...) creates a new INTERFAZ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interfaz_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interfaz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interfaz

% Last Modified by GUIDE v2.5 24-Aug-2020 19:14:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interfaz_OpeningFcn, ...
                   'gui_OutputFcn',  @interfaz_OutputFcn, ...
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


% --- Executes just before interfaz is made visible.
function interfaz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interfaz (see VARARGIN)

% Choose default command line output for interfaz
handles.output = hObject;

% Initialise tabs
handles.tabManager = TabManager( hObject );

% Set-up a selection changed function on the create tab groups
% tabGroups = handles.tabManager.TabGroups;
% for tgi=1:length(tabGroups)
%     set(tabGroups(tgi),'SelectionChangedFcn',@tabChangedCB)
% end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interfaz wait for user response (see UIRESUME)
% uiwait(handles.mainFigure);


% Called when a user clicks on a tab
%function tabChangedCB(src, eventdata)

%disp(['Changing tab from ' eventdata.OldValue.Title ' to ' eventdata.NewValue.Title ] );




% --- Outputs from this function are returned to the command line.
function varargout = interfaz_OutputFcn(hObject, eventdata, handles) 
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
global Robot;
global select_rob;
select_rob = 0;

contents = cellstr(get(hObject,'String'));
value = contents{get(hObject,'Value')};
switch value
    case 'R17'
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
    case 'Scara'
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
    case '2 juntas'
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


% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, ~)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles) 
global Robot
global select_rob
global stop
stop = 1;

if (select_rob == 1)
    switch(get( eventdata.NewValue,'Tag'))
        case 'radiobutton2'
            q0 = zeros(1,6);
        case 'radiobutton3'
            q0 = [0,0,pi/2,pi/2,0,0]; 
        case 'radiobutton4'
            q0 = [0,0,pi/2,0,0,0];
        case 'radiobutton5'
            q0 = [0,0,-pi/2,0,0,0]; 
        case 'radiobutton6'
            q0 = [0,0,0,pi/2,0,0];
        case 'radiobutton7'
            q0 = [0,0,0,-pi/2,0,0];
    end
elseif(select_rob == 2)  
    switch(get( eventdata.NewValue,'Tag'))
        case 'radiobutton2'
            q0 = zeros(1,4);
        case 'radiobutton3'
            q0 = [0,pi/2,0,0]; 
        case 'radiobutton4'
            q0 = [0,-pi/2,0,0];
        case 'radiobutton5'
            q0 = [pi/2,0,0,0]; 
        case 'radiobutton6'
            q0 = [-pi/2,0,0,0];
        case 'radiobutton7'
            q0 = [0,-pi/2,1,0];
    end
elseif(select_rob == 3)
    switch(get( eventdata.NewValue,'Tag'))
        case 'radiobutton2'
            q0 = zeros(1,2);
        case 'radiobutton3'
            q0 = [0,pi/2]; 
        case 'radiobutton4'
            q0 = [0,-pi/2];
        case 'radiobutton5'
            q0 = [pi/2,0]; 
        case 'radiobutton6'
            q0 = [-pi/2,0];
        case 'radiobutton7'
            q0 = [0,pi/4];
    end
end
%axes(handles.graf_rob);
figure(1);
plot(Robot,q0);

% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
global caracteristicas
global select_rob
global Robot
global stop
stop = 0;

load RN_female.mat
load net4.mat

%labels = labels;
%data = data;
clase = 6;
%net = net;
muestras = 20;                      %no. muestras
n_m = 3000;

r = randn(180,10);   %Ordenas las muestras en un orden random
rand_num = randperm(size(r,1));
data = data(rand_num(1:round(length(rand_num))),:); 

canal1 = zeros(1,n_m);
canal2 = zeros(1,n_m);

%DETALLES GRÁFICAS
t = 1:n_m;
h1 = plot(handles.axes2,t,canal1);
ylim(handles.axes2,[-5,5]);
ylabel(handles.axes2,"V");
%xlabel(handles.axes2,"ms");
h2 = plot(handles.axes3,t,canal2);
ylim(handles.axes3,[-5,5]);
ylabel(handles.axes3,"V");
%xlabel(handles.axes3,"ms");

while stop == 0   
    for i = 1:muestras
        for j = 1:n_m
            canal1(:,j) = data(i,j);
            canal2(:,j) = data(i,3000+j);
            %set(h1(j),'YData',canal1(:,j));
            h1.YData(j) = canal1(:,j);
            drawnow limitrate
            h2.YData(j) = canal2(:,j);
            drawnow limitrate
        end 
        
        v_mav(i,:) = [mav(data(i,1:3000)),mav(data(i,3001:end))];
        v_zc(i,:) = [zc(data(i,1:3000),0),zc(data(i,3001:end),0)];
        v_iemg(i,:) = [emg(data(i,1:3000)),emg(data(i,3001:end))];
        v_rms(i,:) = [rms(data(i,1:3000)),rms(data(i,3001:end))];
        v_wl(i,:) = [wl(data(i,1:3000)),wl(data(i,3001:end))];
        v_var(i,:) = [varianza(data(i,1:3000)),varianza(data(i,3001:end))];
        v_desv(i,:) = [desv(data(i,1:3000)),desv(data(i,3001:end))];
        
        features = [v_mav(i,:),v_zc(i,:),v_iemg(i,:),v_wl(i,:)];   %Características
        y_prueba = net(features');
        clase_prueba = vec2ind(y_prueba);   % contiene la etiqueta asignada

        n = clase_prueba;
        if (select_rob == 1)
            switch n
                case 1
                    q0 = zeros(1,6);
                case 2
                    q0 = [0,0,pi/2,pi/2,0,0]; 
                case 3
                    q0 = [0,0,pi/2,0,0,0];
                case 4
                    q0 = [0,0,-pi/2,0,0,0]; 
                case 5
                    q0 = [0,0,0,pi/2,0,0];
                case 6
                    q0 = [0,0,0,-pi/2,0,0];
            end
        elseif(select_rob == 2)  
            switch n
                case 1
                    q0 = zeros(1,4);
                case 2
                    q0 = [0,pi/2,0,0]; 
                case 3
                    q0 = [0,-pi/2,0,0];
                case 4
                    q0 = [pi/2,0,0,0]; 
                case 5
                    q0 = [-pi/2,0,0,0];
                case 6
                    q0 = [0,-pi/2,1,0];
            end
        elseif(select_rob == 3)
            switch n
                case 1
                    q0 = zeros(1,2);
                case 2
                    q0 = [0,pi/2]; 
                case 3
                    q0 = [0,-pi/2];
                case 4
                    q0 = [pi/2,0]; 
                case 5
                    q0 = [-pi/2,0];
                case 6
                    q0 = [0,pi/4];
            end
        end
        
        if caracteristicas == 1
           set(handles.mav,'String',v_mav(i,1));  
           set(handles.zc,'String',v_zc(i,1)); 
           set(handles.iemg,'String',v_iemg(i,1));
           set(handles.wl,'String',v_wl(i,1));
        end
      set(handles.num,'String',n);
      figure(1); 
      plot(Robot,q0);
      pause(0.1);
    end
end



% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
global stop
stop = 1;



% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
global caracteristicas 
contents = cellstr(get(hObject,'String'));
value = contents{get(hObject,'Value')};

switch value
    case 'Sí'
        caracteristicas = 1;
        set(handles.MAV1, 'Visible', 'on');
        set(handles.mav, 'Visible', 'on');
        set(handles.ZC1, 'Visible', 'on');
        set(handles.zc, 'Visible', 'on');
        set(handles.IEMG1, 'Visible', 'on');
        set(handles.iemg, 'Visible', 'on');
        set(handles.RMS1, 'Visible', 'of');
        set(handles.rms, 'Visible', 'of');
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
