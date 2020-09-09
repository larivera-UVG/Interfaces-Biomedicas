% x = 0:3000/2-1;
% n = 0.5;
% y = 3*sin(1/(2*pi*n)*x)+8*cos(1/(2*pi*8*n)*x)+2*sin(pi+1/(2*pi*50*n)*x);
% 
% plot(x,y)

load('data_1')

y1  = emg(1:300);

y2  = eog(1:300)/20;

y3  = fpz(1:300)/5;

y4  = pz(1:300)/3;

l = size(emg,1);

ll=l/3000;

EMG = zeros(ll*300+l,1);
EOG = zeros(ll*300+l,1);
FPZ = zeros(ll*300+l,1);
PZ = zeros(ll*300+l,1);
for i = 1:ll
    ant = i-1;
    init = ant*3300+1;
    fin = i*3300;
    
    init2 = ant*3000+1;%init+ant*300;
    fin2 = i*3000;
    
   EMG(init:fin) = [y1;emg(init2:fin2)];
   EOG(init:fin) = [y2;eog(init2:fin2)];
   FPZ(init:fin) = [y3;fpz(init2:fin2)];
   PZ(init:fin) = [y4;pz(init2:fin2)];
  % EMG(init2:fin2) = y1;
end

emg = EMG;
eog = EOG;
fpz = FPZ;
pz = PZ;