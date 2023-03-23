function [count_ap] = count_derivatives_camille(d, lowerl, upperl, sweep, width)

% counting the number of derivatives that are close to 0

% Step 1: form derivative -- diff(y) - diff(x)

dy = diff(d(lowerl:upperl,3,sweep)) ./ diff(lowerl:upperl);

% detect when the derivative is very different from 0 (difference > ?), then
% start counting APs


start_loc = find(abs(dy) > 0.1, 1); % finds first place where dy is much greater than 0 (i.e. 0.5)

dy = dy(start_loc:end); % but is this in the right dimension??

numzero = [];

count_ap = 0;

for i = start_loc:4000:upperl % assuming 4000 is the width of each ap
    dy_bit = dy(i:i+400)
    numzero = sum(abs(dy_bit) <= 0.01); % if close to 0
    if(numzero >= 4) % successful AP if at least 4 0s
        count_ap = count_ap+1;
    end
end

count_ap

end

% finished finding total num zeros
% now to count derivatives must parse through every 4*10^4 inputs??? and count
% number of zeros for that?
% how to parse through this 


%Check:      
%d = abfload('22d11014.abf','start',0,'stop','e');
%size(d)
%lowerl = 1;
%upperl = 30000;
%sweep = 1;
%width = 0.08
