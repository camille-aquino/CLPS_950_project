%attempt to plot derivative of graph in a new plot that is going to hit 0
%everytime the Vm value does not change

d = abfload('22918005.abf','start',0,'stop','e');
size(d)
close all
lowerl = 1
upperl = 40000
plot(lowerl:upperl, d(lowerl:upperl,3,1))
xlabel('Time(ms)')
ylabel('Membrane Potential (mV)')

%derivative of Vm (change in Vm over change of time), looking for dVm/dt==0
%the derivative plot is called a phase plot, and it is useful data for
%action potentials so we should keep it and make it pretty
dy=diff(d(lowerl:upperl,3,1))./diff(lowerl:upperl);

size(dy)
plot(lowerl:upperl,dy(lowerl:upperl))

%this created a phase plot for the action potentials 
%derivative plot is made and our new strategy is to make 2 conditional
%statements refering to the two different graphs (Vm-time and dy-time)

%1. if Vm reaches a value above a threshold (+20mV), up count by 1
%2. if there are 4 events/ groups of zeros in the derivative plot in that
%same time period as 1., then this is an AP 
%if not (3 zero chunks or less), then the AP previously counted as valid needs to be removed (lower
%count by 1)


i=1;
total_sweep_num=19
for a = 1:total_sweep_num
    threshold_deri =0.1;
    trace = data(:,channel,a)

clear("start_of_dericount")
    for i=lowerl:upperl
        if abs(dy)>=threshold_deri
            start_of_dericount=dy(dy, i:upperl)
        end
    end
   disp(start_of_dericount)

end
plot(start_of_dericount)

        
idx = find(abs(dy) < threshold);
zero_count=0;
        

