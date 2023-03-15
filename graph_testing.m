d = abfload('22918005.abf','start',0,'stop','e');
close all
lowerl = 55000
upperl = 60000
plot(lowerl:upperl, d(lowerl:upperl,3,1))
xlabel('Time(ms)')
ylabel('Membrane Potential (mV)')

<<<<<<< HEAD
plot(1:60000, d(:,3,20))

x = 1:60000;
y = d(:,3,20);


% IDEA: maybe loop through each peak and find the slope with curvefitter?

% for i = 1:width of each AP/nonAP :end

% curvefitter ( x = 1:size

=======
>>>>>>> 9ee7ab1d530a738f33cc00faed53dbb0fbe70369
