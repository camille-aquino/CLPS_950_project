d = abfload('22d11014.abf','start',0,'stop','e');
close all
plot(1:60000, d(:,3,20))
xlabel('Time(ms)')
ylabel('Membrane Potential (mV)')

