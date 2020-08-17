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

% Last Modified by GUIDE v2.5 15-Aug-2020 22:43:49

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

%% Parámetros de Denavit-Hartenberg
a1 = 0; a2 = 0; a3 = 375; a4 = 375; a5 = 0; a6 = 0;
d1 = 0; d2 = -355; d3 = 0; d4 = 0; d5 = 0;  d6 = 0;
alpha1 = -pi/2; alpha2 =  -pi/2; alpha3 = 0; alpha4 = 0; alpha5 = -pi/2; alpha6 = 0;
theta1 = 0; theta2 = pi/2; theta3 = pi/2; theta4 = 0; theta5 = -pi/2; theta6 = pi/2;
q0 = zeros(1,6);

% Definición de links y creación del robot
L1 = Prismatic('a', a1, 'alpha', -pi/2 ,'theta',0,'offset',0);
L1.qlim = [0,625/2];

L2 = Revolute('d',-355, 'a', a2, 'alpha', pi/2,'offset',-pi/2);
L3 = Revolute('d', 0 , 'a', a3, 'alpha',0 ,'offset',-pi/2);
L4 = Revolute('d', 0, 'a', a4, 'alpha', 0,'offset',0);
L5 = Revolute('d', 0, 'a', a5, 'alpha', -pi/2,'offset',-pi/2 );
L6 = Revolute('d', 0, 'a', a6, 'alpha', 0,'offset',0 );

R17 = SerialLink([L1,L2,L3,L4,L5,L6], 'name', 'R17');
% Transformación de Base (roto -90 en x)
R17.base = transl(0, 0, d2)*trotx(-pi/2);
R17.plot(q0);

global stop
stop = 0;

% Choose default command line output for interfaz
handles.output = hObject;
handles.R17 = R17;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interfaz wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interfaz_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

R17 = handles.R17;
global stop
stop = 0;

load RN_female.mat
load NET.mat

labels = labels;
data = data;
clase = 6;
net = net;
muestras = 180;                      %no. muestras

r = randn(180,10);   %Ordenas las muestras en un orden random
rand_num = randperm(size(r,1));
data = data(rand_num(1:round(length(rand_num))),:); 

while stop == 0
    
    for i = 1:muestras
        v_mav(i,:) = [mav(data(i,1:3000)),mav(data(i,3001:end))];
        v_zc(i,:) = [zc(data(i,1:3000),0),zc(data(i,3001:end),0)];
        v_iemg(i,:) = [emg(data(i,1:3000)),emg(data(i,3001:end))];
        v_rms(i,:) = [rms(data(i,1:3000)),rms(data(i,3001:end))];
        v_wl(i,:) = [wl(data(i,1:3000)),wl(data(i,3001:end))];
        v_var(i,:) = [varianza(data(i,1:3000)),varianza(data(i,3001:end))];
        v_desv(i,:) = [desv(data(i,1:3000)),desv(data(i,3001:end))];
        
        features = [v_mav(i,:),v_zc(i,:)];   %Características
        y_prueba = net(features');
        clase_prueba = vec2ind(y_prueba);   % contiene la etiqueta asignada
        plot(handles.axes1,data(i,1:3000));
        plot(handles.axes6,data(i,3001:end));
        
        n = clase_prueba;
        switch n
            case 1
                q0 = [0,0,pi/2,pi/2,0,0];
            case 2
                q0 = [0,0,pi/2,0,0,0];
            case 3
                q0 = [0,0,-pi/2,0,0,0];
            case 4
                q0 = [0,0,0,pi/2,0,0];
            case 5
                q0 = [0,0,0,-pi/2,0,0];
            case 6
                q0 = [0,0,0,0,0,0];
        end
      %caso = n
      set(handles.num,'String',n);
      %handles.axes6 = plot(R17,q0);
      R17.plot(q0); 
      pause(0.5);
    end
end

% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop
stop = 1;
close(gcbf);



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



function num_Callback(hObject, eventdata, handles)
% hObject    handle to num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num as text
%        str2double(get(hObject,'String')) returns contents of num as a double


% --- Executes during object creation, after setting all properties.
function num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
