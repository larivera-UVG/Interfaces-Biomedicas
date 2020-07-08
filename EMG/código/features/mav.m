function [out] = mav(x)
    s = size(x,1);
    out = zeros(s,1);
    for i = 1:s
         out(i) = mean(abs(x(i,:)));      
    end 
end

