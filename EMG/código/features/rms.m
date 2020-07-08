function [out] = rms(x)
    s = size(x);
    out = sqrt(sum(x.^2,2)/s(2)); 
end
