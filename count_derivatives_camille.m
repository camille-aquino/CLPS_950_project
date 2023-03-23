function [success] = count_derivatives_camille(d, lowerl, upperl, sweep, width)

% counting the number of derivatives that are close to 0

% Step 1: form derivative -- diff(y) - diff(x)

dy = diff(d(lowerl:upperl,3,sweep)) ./ diff(lowerl:upperl);

% detect when the derivative is very different from 0 (difference > ?), then
% start counting APs


start_loc = find(dy>0.01, 1); % finds first place where dy is much greater than 0 (i.e. 0.5)

dy = dy(start_loc:end);

numzero = [];

numzero = sum(dy == 0);

end



%Check:      
d = abfload('22d11014.abf','start',0,'stop','e');
size(d)
lowerl = 1;
upperl = 10000;
sweep = 1;
 width = 0.08
