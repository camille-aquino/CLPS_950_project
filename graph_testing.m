%<<<<<<< Updated upstream
d = abfload('22918005.abf','start',0,'stop','e');
close all
lowerl = 55000
upperl = 57500
plot(lowerl:upperl, d(lowerl:upperl,3,1))
xlabel('Time(ms)')
ylabel('Membrane Potential (mV)')

function  = plot_abfload(fn, lowerl, upperl)
%>>>>>>> Stashed changes

d = abfload(fn, 'start', lowerl, )
%d = abfload('22d11014.abf','start',0,'stop','e');
%close all
%plot(1:60000, d(:,3,20))
%xlabel('Time(ms)')
%ylabel('Membrane Potential (mV)')

%plot(1:60000, d(:,3,20))

% x = 1:60000;
% y = d(:,3,20);



% IDEA: maybe loop through each peak and find the slope with curvefitter?

% numAPs = 0;

%for each sweep
% for i = 1:width of each AP/nonAP :end
%   curvefitter ( x = 1:size(d,1), y = 

%<<<<<<< HEAD
%=======
%>>>>>>> 9ee7ab1d530a738f33cc00faed53dbb0fbe70369
