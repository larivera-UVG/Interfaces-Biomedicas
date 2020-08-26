 if ~isempty(instrfind);
  fclose(instrfind);
  delete(instrfind);
  clear s
 end
 
s = serial('COM11', 'BaudRate',115200);
fopen(s);
cont = 0;
while(cont<1000);
  cont = cont +1;
  
  v = fscanf(s,'%d');
  %cont
  if v==1
     cont 
  else
      v
  end
%   if isempty(v)
%       v
%   else
%       cont
%   end
      
      
  
end