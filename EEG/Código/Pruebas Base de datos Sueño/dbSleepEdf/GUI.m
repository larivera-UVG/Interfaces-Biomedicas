%%
%Miniproyecto Biomedica
%Rodrigo Ralda - 14813
%Lee datos enviados por comunicacion serial de arduino
%Con Baudrate de 115200 y periodo de muestreo de 1ms
%Presenta grafico en tiempo real en la interfaz
%Junto con metricas como MAV y ZC.
%%

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

% Last Modified by GUIDE v2.5 01-Mar-2020 23:29:16

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

%% Inicializacion
%  if ~isempty(instrfind);
%   fclose(instrfind);
%   delete(instrfind);
%   clear s
%  end
%  
% global s;
% s = serial('COM9', 'BaudRate',115200);
% fopen(s);
% 
% global cont;
% global max;
% global data;
% global v;
% global t;
% global ini;
% global h;
% 
% cont = 1;
% max =1000;
% %d=fscanf(s,'%d');
% data=zeros(1,max);
% v=0;
% t=1:max;
% ini = 1;
% %fprintf(s, 'a');
%  %figure(1); clf;
% h = plot(handles.axes2,t,data)
% title('Señal de BITalino V(t)');
% xlabel('$Tiempo (ms)$', 'Interpreter', 'latex', 'FontSize', 12);
% ylabel('$ Voltaje (V)$', 'Interpreter', 'latex', 'Fontsize', 12);
% ylim([-5 5]);
% xlim([0 1000]);
% grid minor;
% hold on;

%% Fin Inicializacion
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

% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%  if ~isempty(instrfind);
%   fclose(instrfind);
%   delete(instrfind);
%   clear s
%  end
%  
% global s;
% s = serial('COM9', 'BaudRate',115200);
% fopen(s);
% 
% global cont;
% global max;
% global data;
% global v;
% global t;
% global ini;
% global h;
% 
% despArriba = 0;
% zc = 0;
% mav = 0;
% vNew=zeros(1,max);
% result= zeros(1,(max+4));
% rfinal=[];
% band = 1;
% newDat = zeros(1,max);
% 
% cont = 1;
% data=zeros(1,max);
% v=0;
% t=1:max;
% PB =0;
% SB=0;
% vN=[];
% vN1=[];
% 
% % h = plot(handles.axes2,t,data)
% % title('EMG');
% % xlabel('T (ms)');
% % ylabel('Señal (V)');
% % ylim([-5 5]);
% % xlim([0 1000]);
% % grid on;
% % hold on;

% Hint: get(hObject,'Value') returns toggle state of togglebutton1
%principal = get(hObject,'Value');



% while (band == 1);
%   principal = get(hObject,'Value');
%   if (principal == 1)
%       set(handles.togglebutton1, 'String', 'Parar');
%       v = fscanf(s,'%d');
%       data(cont) = v(1)*5/1024; 
% 
%        h.YData(cont) = data(cont);
%        drawnow limitrate
% 
%        cont = cont +1; 
%         if(cont == (max+1))
%               
%         %text7 y 9
%        %      newDat = data;
%               despArriba = mean(data);
%               [zc, mav, vNew] = metricas(data,0.15, despArriba);
%               set(handles.text7, 'String', num2str(zc));
%               set(handles.text9, 'String', num2str(mav));
%               result=[zc, 0, mav, 0, vNew];
%               %rfinal(length(rfinal)+1,1)=result
%               cont=1;
%         end
%   else 
%      set(handles.togglebutton1, 'String', 'Iniciar');
%      csvwrite('serialResult.csv',result,0,0);
% %      figure(2); clf;
% %      plot(vNew)
% %      title('vNew')
% %      ylim([-1 1]);
% %      xlim([0 1000]);
%      
%      PB = filtroPasaBandasML;
%      SB = filtroStopBandML;
% 
%      vN = filter(PB, vNew);
%      vN1 = filter(SB, vN);
% 
% %      figure(3); clf;
% %      plot(vN)
% %      title('Filtro PB')
% %      ylim([-1 1]);
% %      xlim([0 1000]);
% 
%      figure(2); clf;
%      plot(t,vNew,t,vN1)
%      title('Resultados Finales Señal de BITalino V(t)');
%      xlabel('$Tiempo (ms)$', 'Interpreter', 'latex', 'FontSize', 12);
%      ylabel('$ Voltaje (V)$', 'Interpreter', 'latex', 'Fontsize', 12);
%      legend({'Señal Sin Filtro','Señal Filtrada'},'Location','southwest')
%      ylim([-1 1]);
%      xlim([0 1000]);
%      grid minor;
% 
%      band = 0;
%   end
%      
% end
