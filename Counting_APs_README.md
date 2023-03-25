# CLPS_950_project
CLPS 950 Counting Action Potentials project with Stella and Camille

PROJECT DESCRIPTION

%ectopic action potential signal determination project
%I was trying to edit another person's repository by accident, github was not working for Stella for the first 2 days

%we used an abfload code (cloned the github repository) to load abf format
%files into matlab
%this returned a 3 dimentional table of values, which we then needed to
%plot
% to print data table, we used 
 d=abfload('22d11014.abf', 'start', 0, 'stop','e')

%to plot the data, we used 
close all
lowerl = 20000
upperl = 25000
plot(lowerl:uppe, d(:60000,3,20))
xlabel('Time(ms)')
ylabel('Membrane Potential (mV)')
%this allows us to zoom in (upper and lower limit refer to time in x axis) and look at individual action potentials to determine if they are successful

% 03/15/2023 update
% we have found a file that has confirmed failed action potential events
-file name: 22918005.abf
%goal: to differentiate and count those APs
%ideas:
-plot the derivative of the Vm curve and spot zeros, then tell matlab that those are APs
-go by height, and only count the events that make it past a Vm  threshold 
=======
%03/15/2023 updates
% we found a file that includes failed action potentials at a frequency of 100Hz and zoomed in
% to plot table, we used
close all
lowerl = 20000
upperl = 25000
plot(lowerl:upperl, d(lowerl:uperl,3,1))
xlabel('Time(ms)')
ylabel('Membrane Potential (mV)')
% the upper and lower limits refer to ms (time) on the x axis and they need to match in the plot function


%next goal: to experiment with ways to detect the curve and determine action potential events
%possible directions:
- derivative plot (spot all the places where the derivative is 0, help matlab know where the APs are 
- detect height of Action potentials and count the ones that make it past a Vm value only 
