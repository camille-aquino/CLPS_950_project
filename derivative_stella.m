%attempt to plot derivative of graph in a new plot that is going to hit 0
%everytime the Vm value does not change

d = abfload('22d11014.abf','start',0,'stop','e');
size(d)
close all
lowerl = 30000
upperl = 40000
plot(lowerl:upperl, d(lowerl:upperl,3,1));
xlabel('Time(ms)')
ylabel('Membrane Potential (mV)')

%derivative of Vm (change in Vm over change of time), looking for dVm/dt==0
%the derivative plot is called a phase plot, and it is useful data for
%action potentials so we should keep it and make it pretty
dy=diff(d(lowerl:upperl,3,1))./diff(lowerl:upperl);

size(dy)
plot(lowerl:upperl,dy(lowerl:upperl))

%this created a phase plot for the action potentials 