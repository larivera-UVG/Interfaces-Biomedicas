function [out] = wl(x)
    s = size(x);
    H = zeros(s(1),s(2)-1);
    for j = 1:s(1)
        for i = 1:s(2)-1
           H(j,i) = abs(x(j,i+1)-x(j,i));
        end
    end
    out = sum(H,2);

end


