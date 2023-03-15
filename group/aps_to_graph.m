%ectopic action potential signal determination project
%I was trying to edit another person's repository by accident


%we used an abfload code (cloned the github repository) to load abf format
%files into matlab
%this returned a 3 dimentional table of values, which we then needed to
%plot
% to print data table, we used 
 d=abfload('22d11014.abf', 'start', 0, 'stop','e')


%file number:22d11014.abf
%30Hz protocol with ectopic firing in sweep 7
% sweep duration:3 seconds, with a recording frequency
% of 2000Hz (membrane potential measured 2000 times per second)
%this file contains 20 sweeps

% to see number of sweeps and size of data, we used 'size(d)'

%then, we ploted the data using 'plot'
plot(1:60000,d2(:,3,7))
%this plots all the membrane potential values (1:60000) (3rd dimension) in
%sweep 7 (ectopic AP)