%this code will count action potentials (how many and their timing) in a Vm
%vs time graph and then go back and check if they are all active APs or just positive membrane deflections byt combining information from Vm graph and derivative function.
%inspired by code written by lab member previously and modified to exclude
%failed events


total_sweep_num=19%input('19');%# of sweeps
file='22d11014.abf'%input('22d11014.abf');%abf file name
channel=3%input('What ');%4 channels for clampex: Vm_primary (1), Im_sec (2), Vm_prime2 (3), Im_sec2 (4), we choose #3 because we are using a current clamp
samp_frequency=20%input('20');%sampling frequency (20kHz for tested protocol)
data=abfload(file);

%creating a for loop that will check every sweep from 1 to max # of sweeps
%and will add 1 to the AP count every time the membrne potential exceeds a
%threshold

%Threshold setting: a normal resting membrane potential of a healthy neuron
%can very but doesn't usually go above -50mV. at the same time, a thresholf
%of -10mV for the determination of an action potential works because it is
%high enough (if membrane potential reaches is it's an AP or the neuron is
%dead) but not too high (some APs would be missed that way)
%every AP will go through -10mV

for a = 1:total_sweep_num
    x = linspace(0,10,200000);% n points in a linear vector with evenly spaced points
    threshold_for_APs =10;
       spike_count = [];%creating empty matrix to count APs
       trace = data(:,channel,a);%selecting all of the measurments from channel 3 in the current sweep we are in (inputs rk like plotting)
       %this focuses on one trace at a time (trace=sweep)

      
       clear('above_thres')
    % find indices of samples above the threshold:
    above_thres=find(trace(1:end) > threshold_for_APs)  ;%search the entire sweep for values bigger than threshold, name those inputs above_threshold
     %creating two new matrices to group all the rising phases together and the falling phases
       %together, then pair one rising phase with one falling phase and make an AP
    clear('index_shift_neg');%APs rising phase (index values of Vm are growing)
    clear('index_shift_pos');%APs falling phase (index values of Vm are lowering)

    if isempty(above_thres) < 1 %if we have any values above threshold
        clear('set_cross_plus');
        clear('set_cross_minus');
        % first index pos = 1st sample above the threshold:
        index_shift_pos(1)=min(above_thres);
        % set last index neg to the last sample above the threshold:
        index_shift_neg(length(above_thres))=max(above_thres);

        %now the goal is to detect a jump between the indices (where the
        %next AP begins, and make it differentiate the events

        %to detect continuous events (same AP): above_thres+1= above_thres'
        %(500+1=501), don't count the indices
        %to detect discontinous events (next AP):above_thres+1=~ above_thres'
        %(500+1=~347), record the indices

        for i=1:length(above_thres)-1;
            if above_thres(i+1) > above_thres(i)+1 
                index_shift_pos(i+1)=i; %this was the first sample (left or rising phase)
                index_shift_neg(i)=i; %this was the last sample (right or falling phase)
            end
        end

        %Now we need to detect slopes and count:
        %indices of the truncated "above_threshold" trace are converted into sample indices of the original trace:

        set_cross_plus=  above_thres(find(index_shift_pos));   % find(x) returns nonzero arguments.
        set_cross_minus=  above_thres(find(index_shift_neg));   
        set_cross_minus(length(set_cross_plus))= above_thres(end);

        spike_count= length(set_cross_plus); % Number of pulses, i.e. number of windows.
        disp(['spike count at sweep:' a])
        disp(spike_count)
    end
end

%20kHz is the frequency of recording,
%so 20,000*0.010=200 steps of the x axis for the 100Hz protocol(every 200 steps count how many 0s
%in the derivative).
%this is 0.015 --300 for 60Hz and 0.030--600 for 30Hz (just change this in
%the code edepending on which protocol is being checked 

%determination of 'values close to 0' :looking at the derivative graph,
%zooming in to successful events to see how close to 0 the threshold should
%be 