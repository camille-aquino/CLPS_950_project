%function [count_ap] = count_successful_aps_camille(d, lowerl, upperl, sweep, width)

        % counting the number of derivatives that are close to 0
        % Step 1: form derivative -- diff(y) - diff(x)

%dy = diff(d(lowerl:upperl,3,sweep)) ./ diff(lowerl:upperl);

        % detect when the derivative is very different from 0 (difference > ?), then
        % start counting APs


%start_loc = find(abs(dy) > 0.1, 1); % finds first place where dy is much greater than 0 (i.e. 0.5)

%dy = dy(start_loc:end); % but is this in the right dimension??

%numzero = [];

%count_ap = 0;

%for i = start_loc:400:upperl-400 % assuming 400 is the width of each ap
%    dy_bit = dy(i:i+400);
%    numzero = sum(abs(dy_bit) <= 0.01); % count how many derivatives are close to 0
%    if(numzero >= 4) % successful AP if at least 4 0s
%        count_ap = count_ap+1;
%    end
%end

%count_ap

%end


            %Check:      
            
            %size(d)
            %lowerl = 30000;
            %upperl = 60000;
            %sweep = 1;
            %width = 0.08

            % did 1 to 30000 , then 30000 to 60000
                % got 46 + 96 = 142 APs for sweep 1
            % can't do the full 1 to 60000 because in my dy formula it creates an array
            % that's too large for matlab to process. It seems 30000 is an okay amount
            % to go up by. Should make a function that maybe loops this by 10000 at a
            % time and counts the number of APs of each set of 10000. And this is all
            % for one single sweep, so I should also loop this for the certain amount
            % of sweeps. 
function [count_ap] = count_successful_aps_camille(d)
d = abfload('22d11014.abf','start',0,'stop','e');
lowerl = 1;
upperl = 20000; % first thing to parse through

dy = diff(d(lowerl:upperl,3,1)) ./ diff(lowerl:upperl); % first segment of the first sweep
%dy =  diff(d(lowerl:upperl,3,3)) ./ diff(lowerl:upperl); check

lowerl = find(abs(dy) > 0.1, 1); % finds first place where dy is much greater than 0 (i.e. 0.5)

numzero = []; % placeholder for derivative close to 0

count_ap = 0; % initializing AP counter

num_sweep = 1; % starting sweep number at 1 since matlab is 1 indexed

sweep_ap = 0; % variable for number of successful APs in a given sweep

num_loops = size(d,1)/20000; % breaking up data by looking through 30000 points at a time
% tried 10000 and 20000 but it turns out some of the sweeps start beyond
% 20000 
group_zero = 0;

while(num_sweep <= size(d,3))
    while(num_loops > 0)
       for i = lowerl:400:(upperl-400) % 400 inputs is width of an AP
           dy_bit = dy(i:i+400);
           for j = 1:400
           numzero = sum(abs(dy_bit) <= 0.01); % count how many derivatives are close to 0
            % check how many are very close to each other
           if((diff(abs(dy_bit(j+1),dy_bit(j))) < 0.1))
               group_zero = group_zero + 1;
           end
           end

             if(group_zero >= 4) % successful AP if at least 4 0s
                 count_ap = count_ap + 1;
                 sweep_ap = sweep_ap + 1;
             end
        end
        count_ap % first 20000 of first sweep: 41 APs 2nd loop: 45 3rd loop: 93 APs
             
        if(lowerl < 20000)
            lowerl = 0; % if done with first segment, reset lowerl to 0 so it can take over the previous upperl 
        end

        if(lowerl < 40000)
         lowerl = lowerl + 20000;
        end

        if(upperl < 60000)
         upperl = upperl + 20000;
        end
         num_loops = num_loops - 1;
         dy = diff(d(lowerl:upperl,3,num_sweep)) ./ diff(lowerl:upperl);  
    end

    disp(["Sweep" num_sweep "has" sweep_ap "successful APs"])
    sweep_ap = 0;
    num_sweep = num_sweep + 1
    num_loops = size(d,1)/20000; % reinstate the num of loops
    
    lowerl = 1;
    upperl = 20000;
    if(num_sweep > 20)
        break
    end
    dy = diff(d(lowerl:upperl,3,num_sweep)) ./ diff(lowerl:upperl);
    lowerl = find(abs(dy) > 0.1, 1);
    numzero = [];
    
end

disp(["There are" count_ap "successful APs overall"])

count_ap

end

