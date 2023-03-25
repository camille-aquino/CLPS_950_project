%attempt to plot derivative of graph in a new plot that is going to hit 0
%everytime the Vm value does not change

d = abfload('22d11014.abf','start',0,'stop','e');
size(d)
close all
lowerl = 15000
upperl = 45000
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
total_sweep_num=19;
for a = 1:total_sweep_num
    threshold_deri =0.1;
    trace = d(:,3,a)

clear("start_of_dericount")
    for i=lowerl:upperl3
        if abs(dy)>=threshold_deri
            start_of_dericount=[dy(i:upperl)]
        end
    end

end

no_slope=[abs(start_of_dericount)<=threshold_deri]%boolean telling us when values are close enough to zero in the entire cropped matrix
group_size=400 %established width of AP taken from Vm plot
AP_groups=reshape(no_slope(1:end-182), group_size, []) % no slope starts where the slope is not 0 for the first time (beginning of firing window) so we can start cropping there
AP_groups=AP_groups' %colums to rows
disp(size(AP_groups));%created 212 groups with 400 boolean datapoints each 

num_ones = sum(AP_groups, 1);%count the number of ones in each group (derivatove close to zero in each AP)
disp(num_ones)
successful=sum(num_ones>85)% out of 212 windows, only 76 had enough zeros to be considered successful APs. The cutoff of 85 was established after counting zeros in successful and unsuccessful events from multiple sweeps, it is prone to human error
 

        

