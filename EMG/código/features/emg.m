function [out] = emg(x)
    %out = sum(abs(x));  %si es un array  
    s = size(x,1);
    out = zeros(s,1);
    for i = 1:s
         out(i) = sum(abs(x(i,:)));      
    end 
end

