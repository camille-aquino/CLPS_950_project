function plot_me = plot_abfload(d, lowerl, upperl, sweep)

close all

plot_me = plot(lowerl:upperl, d(lowerl:upperl,3,sweep))
xlabel('Time(ms)')
ylabel('Membrane Potential (mV)')
end

