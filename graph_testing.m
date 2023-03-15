d = abfload('22918005.abf','start',0,'stop','e');
close all
lowerl = 55000
upperl = 60000
plot(lowerl:upperl, d(lowerl:upperl,3,1))
xlabel('Time(ms)')
ylabel('Membrane Potential (mV)')

