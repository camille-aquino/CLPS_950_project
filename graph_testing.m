d = abfload('22d11014.abf','start',0,'stop','e');

plot(1:60000, d(:,3,20))

x = 1:60000;
y = d(:,3,20);


% IDEA: maybe loop through each peak and find the slope with curvefitter?

% for i = 1:width of each AP/nonAP :end

% curvefitter ( x = 1:size

