function [success] = count_derivatives_camille(d, lowerl, upperl, sweep, width)

% counting the number of derivatives that are close to 0

% Step 1: form derivative -- diff(y) - diff(x)

dy = diff(d(lowerl:width:upperl,3,sweep)) ./ diff(lowerl:width:upperl);

% detect when the derivative is very different from 0 (difference > ?), then
% start counting APs

start_loc = [0 0 0];

while(true)
    if (dy >= 2)
start_loc = 
        break
    end
end

    numzero = [];

numzero = dy(dy > -0.01 & dy < 0.01)
        
success = length(numzero) > 

end


%Check:      
%d = abfload('22d11014.abf','start',0,'stop','e');
%size(d)
%lowerl = 1;
%upperl = 10000;
%sweep = 1;
% width = 2
