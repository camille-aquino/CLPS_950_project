function [numzero] = count_derivatives_camille(d, lowerl, upperl, sweep, width)

% counting the number of derivatives that equal 0

% Step 1: form derivative -- diff(y) - diff(x)

% making derivative of every single vm measurement is too much! need to
% find
% width of each AP so I can go up by that amount only

dy = diff(d(lowerl:width:upperl,3,sweep)) ./ diff(lowerl:width:upperl);

numzero = 0;

for i = lowerl:upperl
    if dy == 0
        numzero = numzero + 1;
    end
end

end

%Check:      
%d = abfload('22d11014.abf','start',0,'stop','e');
%size(d)
%lowerl = 1;
%upperl = 60000;
%sweep = 1;
