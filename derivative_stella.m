%attempt to plot derivative of graph in a new plot that is going to hit 0
%everytime the Vm value does not change

d = abfload('22d11014.abf','start',0,'stop','e');
size(d)
close all
lowerl = 20000
upperl = 25000
plot(lowerl:upperl, d(lowerl:upperl,3,1))
xlabel('Time(ms)')
ylabel('Membrane Potential (mV)')

dy=diff(y)./diff(x)
plot(x(lowerl:upperl),dy)