function [isactionpotential] = camille_isactionpotential(d, lowerl, upperl, sweep)

%width of each attempted action potential: 
%width = 

x = 0;
y = 0;
slope = 0;

num_pos_slope = 0;
num_neg_slope = 0;
num_zero_slope = 0;

% parsing through each attempted action potential

for i = lowerl : width : upperl-width
    for j = i : i+width-0.001
        x1 = j;
        x2 = j + 0.001;
        y1 = d(x1,3,sweep);
        y2 = d(x2,3,sweep);
        slope = (y2-y1)/(x2-x1)
        if (slope > 0)
            num_pos_slope = num_pos_slope + 1;
        elseif(slope < 0)
            num_neg_slope = num_neg_slope + 1;
        else 
            num_zero_slope = num_zero_slope + 1;
        end
    end
end

if (num_zero_slope > 1)
    isactionpotential = true;
else
    isactionpotential = false;
end


    