function [n] = zc(x,u)
    s = size(x);
    u_l = -u;
    u_h = u;
    n = zeros(s(1),1);
   
    for j = 1:s(1)
        b_l = 0;
        b_h = 0;
        for i = 1:s(2)
            if (x(j,i)< u_l) && (b_l == 0)
                b_l = 1;
            end
            if (b_l == 1) && (x(j,i)> u_h)
                n(j) = n(j)+1;
                b_l = 0;
                b_h =  1;
            end
            if (x(j,i) > u_h) && (b_h == 0)
                b_h = 1;
            end
            if (b_h == 1) && (x(j,i)< u_l)
                n(j) = n(j)+1;
                b_l = 1;
                b_h =  0;
            end
        end
        
    end
end
