function [c] = colorrbg(p)
    if p < .5
        r = 1;
        g = p;
        b = 0;
    elseif p >= .5
        r = (1-p);
        b = 1;
        g = 0;
    end   
    c = [r b g];
end
