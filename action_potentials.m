%load data and plot 
d = abfload('22918005.abf','start',0,'stop','e');
size(d)
close all
lowerl = 50000
upperl = 52000
plot(lowerl:upperl, d(lowerl:upperl,3,1))
xlabel('Time(ms)')
ylabel('Membrane Potential (mV)')
%take derivative of data
dy=diff(d(lowerl:upperl,3,1))./diff(lowerl:upperl);
size(dy)
plot(lowerl:upperl,dy(lowerl:upperl))

%count positive deflecitons
total_sweep_num=19;%# of sweeps
file='22918005.abf';%abf file name
channel=3;%4 channels for clampex: Vm_primary (1), Im_sec (2), Vm_prime2 (3), Im_sec2 (4), we choose #3 because we are using a current clamp
samp_frequency=20%input('20');%sampling frequency (20kHz for tested protocol)
data=abfload(file);

for a = 1:total_sweep_num
    x = linspace(0,10,200000);% n points in a linear vector with evenly spaced points
    threshold_for_APs =10;
       spike_count = [];%creating empty matrix to count APs
       trace = data(:,channel,a);%selecting all of the measurments from channel 3 in the current sweep we are in (inputs rk like plotting)
       %this focuses on one trace at a time (trace=sweep)

      
       clear('above_thres')
    % find indices of samples above the threshold:
    above_thres=find(trace(1:end) > threshold_for_APs)  ;
    clear('index_shift_neg');%APs rising phase (index values of Vm are growing)
    clear('index_shift_pos');%APs falling phase (index values of Vm are lowering)

    if isempty(above_thres) < 1 %if we have any values above threshold
        clear('set_cross_plus');
        clear('set_cross_minus');
        % first index pos = 1st sample above the threshold:
        index_shift_pos(1)=min(above_thres);
        % set last index neg to the last sample above the threshold:
        index_shift_neg(length(above_thres))=max(above_thres);

        for i=1:length(above_thres)-1;
            if above_thres(i+1) > above_thres(i)+1 
                index_shift_pos(i+1)=i; %this was the first sample (left or rising phase)
                index_shift_neg(i)=i; %this was the last sample (right or falling phase)
            end
        end

        set_cross_plus=  above_thres(find(index_shift_pos));   % find(x) returns nonzero arguments.
        set_cross_minus=  above_thres(find(index_shift_neg));   
        set_cross_minus(length(set_cross_plus))= above_thres(end);

        spike_count= length(set_cross_plus); % Number of pulses, i.e. number of windows.
        disp(['spike count at sweep:' a])
        disp(spike_count)
    end
end
