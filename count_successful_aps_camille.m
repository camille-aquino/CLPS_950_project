function [count_ap] = count_successful_aps_camille(d)

% d = abfload('22918005.abf','start',0,'stop','e'); <- example of data, copy into command window
 
% GOAL: Count the number of successful APs in each sweep and overall. 
%       Sometimes an injection of current to a cell fails to elicit an action
%       potential (AP). This function seeks to count how many successful APs are
%       formed based on the general shape of a true action potential vs an
%       irrelevant peak: a true AP will have at least 4 maxima/minima overall (at
%       least 4 times dy/dx = 0), while with an irrelevant peak will have
%       this only 3 times.

%   Other things to consider: An action potential may have a slope not equal 
%       to, but close enough to zero, still making it successful. While we count 
%       "close to zero" derivatives, we also have to be conscious of there may 
%       be neighboring values with the same value, and a cluster of (dy/dx = 0)
%       should count as one derivative taken (or else you are over-counting the amount of
%       APs there are over the entire data set)
%  

% If the data is larger than 30000 points, Matlab cannot make an array, so
% we break it up into groups of 20000 because that's the smallest overlal data size
% for any arbitrary datafile d.

lowerl = 1; %lower limit
upperl = 20000; %highest limit

dy = diff(d(lowerl:upperl,3,1)) ./ diff(lowerl:upperl); % first segment of the first sweep

lowerl = find(abs(dy) > 0.1, 1); % finds first place where dy is much greater than 0 (i.e. 0.5)
         % don't want to start counting at the start before injecting a current, 
         % as all of those values will be considered 0 and lead to an
         % overstated AP success rate

numzero = []; % placeholder for derivative close to 0

num_sweep = 1; % starting sweep number at 1 since matlab is 1 indexed

num_loops = size(d,1)/20000; % breaking up data by looking through 20000 points at a time

count_ap = 0;
sweep_ap = 0;

sweep_plot = [];

while(num_sweep <= size(d,3)) % looping through each sweep
    while(num_loops > 0) % looping through broken up segments of a single sweep

   % 400 inputs is width of a possible AP. We will parse through each AP 
   % (failed and successful) and count the number of times dy/dx = 0 in each 
       for i = lowerl:400:(upperl-400) 
           dy_bit = dy(i:i+400); % focusing on a single attempted AP
           
           % adding up the total amount of times a derivative was close to
           % 0 within the one segment
           numzero = sum(abs(dy_bit) <= 0.01); 
           
          % Now: subtracting repeated counts for the same AP (e.g. if there
          % was a group of very similar values close to each other and all
          % were close to 0, this causes an overstated AP count so we must reconcile that)

           j = 1:400;
           % Comparing the value at an index to the value to the right of it
          
           is_last_bit_index = (mod(400, j) == 0); 
           % Can't compare the last value in an array if there's a value to its right    

           if(~is_last_bit_index) 
               % if you're not at the end of the AP, compare it to its right adjacent neighbor
               if(abs(dy_bit(j+1) - dy_bit(j)) < 0.01) % if it is roughly the same value as its neighbor, 
                   %        remove one numzero. the last zero in the "group" 
                   %        of zeros will be counted so we're not overcounting
               numzero = numzero - 1;
               end
           end
     
           if(numzero>=4) % counts as a successful AP if at least 4 (dy = 0)s
                 count_ap = count_ap + 1; % adding to overall count
                 sweep_ap = sweep_ap + 1; % adding to AP count for the given sweep
             end
       end

      %  count_ap 
             
        if(lowerl < 20000) % If lowerl still in the first segment boundary, reset to 0
                           % so it can be added to in the future
            lowerl = 0; 

        end

        % resetting lowerl to a number divisible by 20000
        % restting lowerl and upperl to updated amounts
                if(lowerl < 40000)
                 lowerl = lowerl + 20000;
                end
        
                if(upperl < 60000)
                 upperl = upperl + 20000;
                end

         num_loops = num_loops - 1;

         % reupdating dy with updated lowerl and upperl
         dy = diff(d(lowerl:upperl,3,num_sweep)) ./ diff(lowerl:upperl);  
    end
    sweep_plot = [sweep_plot sweep_ap];
    disp(["Sweep" num_sweep "has" sweep_ap "successful APs"])
    sweep_ap = 0;
   
    num_sweep = num_sweep + 1 % keeping track of sweep number
    
    num_loops = size(d,1)/20000; % reinstate the num of loops
    
    lowerl = 1;    %if done with first segment, reset lowerl to 1 so it can take over the previous upperl 

    upperl = 20000; % end of first segment of possible fails for this subject
 
    % ending while loop for sweeps once you hit 20 sweeps
   if(num_sweep > size(d,3))
        break
   end

   dy = diff(d(lowerl:upperl,3,num_sweep)) ./ diff(lowerl:upperl);
   lowerl = find(abs(dy) > 0.1, 1); % finding the "first time" (second time for whoever is training me) 
   
   % if the sweep's start time (lowerl) is empty because it starts past
   % 20000 data points, look past 20000 to check for start point
  
        if(isempty(lowerl))
            lowerl = 20000;
            upperl = 40000;
            dy = diff(d(lowerl:upperl,3,num_sweep)) ./ diff(lowerl:upperl);
            lowerl = find(abs(dy) > 0.1, 1);
            lowerl = lowerl + 20000;
        end

   numzero = [];
    
end

disp(["There are" count_ap "successful APs overall"])

%count_ap    

close("all")
bar(sweep_plot)
xlabel('Sweep Number')
ylabel('Number of Successful APs')
title('Number of APs Per Sweep')

end




