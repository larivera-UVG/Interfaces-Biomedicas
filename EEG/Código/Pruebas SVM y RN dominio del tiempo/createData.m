%Rodrigo Ralda - 14813
%2020
%El siquiente codigo abre los archivos .edf de la base de datos de Physionet, selecciona los canales de
%interes y extrae caracteristicas de los mismos. Las caracteristicas son MAV, ZA, Varianza y Curtosis.
%Separa estas caracteristicas en dos etiquetas, las cuales vienen identificadas en la base de datos
%Debido a la organizacion de la base de datos, se realiza la misma operacion 3 veces
%Los resultados finales de las caracteristicas estraidas se almacenan en la celda data.
% %[hdr, record]=edfread('C:\Users\rodri\Downloads\Semestre 9 UVG\DiseñoIngenieria1\Base de Datos\eeg-motor-movementimagery-dataset-1.0.0\files\S001\S001R01.edf')
% 
% %clear all;
% 
% [filename,pathname] = uigetfile({'*.*';'*.edf'},'Pick edf File');

pathname = 'C:\Users\rodri\Downloads\Semestre 9 UVG\DiseñoIngenieria1\Base de Datos\eeg-motor-movementimagery-dataset-1.0.0\files\S001\';
% Varianza, amplitud maxima y curtosis
data = cell(2,10);
data{1,1}='Etiqueta 1';
data{1,2}='Etiqueta 2';
data{1,3}='ZC1';
data{1,4}='ZC2';
data{1,5}='MAV1';
data{1,6}='MAV2';
data{1,7}='VAR1';
data{1,8}='VAR2';
data{1,9}='KURTO1';
data{1,10}='KURTO2';

eti11 = [];
XtestZC11 = [];
XtestMAV11  = [];
XtestVAR11  =  [];
XtestKUR11  =  [];

eti21 = [];
XtestZC21 =  [];
XtestMAV21  = [];
XtestVAR21  =  [];
XtestKUR21  =  [];

for ii=1:3

    if (ii == 1)
        filename = 'S001R03.edf';
        
    elseif (ii == 2)
        filename = 'S001R07.edf';
    else
        filename = 'S001R11.edf';
    end

    [hdr, record] = edfread([pathname,filename]);
    [Task_label,Time_duration,Task_sym,strArray] =Eventread(pathname,filename);
    [n,m] = size(record);
    record=[record;zeros(1,m)];
    len = 0;
    dt = 160;
    sum = 0;
    anotaciones = length(Task_label);
    zc=zeros(anotaciones,n);
    mav=zeros(anotaciones,n);
    varian=zeros(anotaciones,n);
    curtos=zeros(anotaciones,n);

    canalIzq = 9;
    canalDer = 37;

    eti1 = [];
    XtestZC1 = [];
    XtestMAV1 = [];   
    XtestVAR1 = [];
    XtestKUR1 = [];
            
    eti2 = [];
    XtestZC2 = [];
    XtestMAV2 = []; 
    XtestVAR2 = [];
    XtestKUR2 = [];

    for i=1:anotaciones    
        %Colocar etiqueta donde: T0=0 T1=1 y T2=2

        len = dt*Time_duration(i,1);
        sum=sum+len;
        record(n+1,sum-len+1:sum)=Task_label(i);
        for j=1:n
            [zc(i,j),mav(i,j)]=metricas(record(j,sum-len+1:sum),0,0);  
            varian(i,j) = var(record(j,sum-len+1:sum));
            curtos(i,j) = kurtosis(record(j,sum-len+1:sum));

        end

        if (Task_label(i) == 1)
            eti1 = [eti1;Task_label(i)];
            XtestZC1 = [XtestZC1;zc(i,canalIzq:canalIzq+4)];
            XtestMAV1 = [XtestMAV1;mav(i,canalIzq:canalIzq+4)];
            XtestVAR1 = [XtestVAR1;varian(i,canalIzq:canalIzq+4)];
            XtestKUR1 = [XtestKUR1;curtos(i,canalIzq:canalIzq+4)];

        elseif (Task_label(i) == 2)
            eti2 = [eti2;Task_label(i)];
            XtestZC2 = [XtestZC2;zc(i,canalIzq:canalIzq+4)];
            XtestMAV2 = [XtestMAV2;mav(i,canalIzq:canalIzq+4)]; 
            XtestVAR2 = [XtestVAR2;varian(i,canalIzq:canalIzq+4)];
            XtestKUR2 = [XtestKUR2;curtos(i,canalIzq:canalIzq+4)];
        end
    end

        eti11 =   [eti11;eti1];
        XtestZC11 =   [XtestZC11;XtestZC1];
        XtestMAV11  =  [XtestMAV11;XtestMAV1];
        XtestVAR11  =  [XtestVAR11;XtestVAR1];
        XtestKUR11  =  [XtestKUR11;XtestKUR1];

        eti21 =   [eti21;eti2];
        XtestZC21 =   [XtestZC21;XtestZC2];
        XtestMAV21  =  [XtestMAV21;XtestMAV2];
        XtestVAR21  =  [XtestVAR21;XtestVAR2];
        XtestKUR21  =  [XtestKUR21;XtestKUR2];

end

data{2,1}=eti11;
data{2,2}=eti21;
data{2,3}=XtestZC11;
data{2,4}=XtestZC21;
data{2,5}=XtestMAV11;
data{2,6}=XtestMAV21;
data{2,7}=XtestVAR11;
data{2,8}=XtestVAR21;
data{2,9}=XtestKUR11;
data{2,10}=XtestKUR21;

