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

%numzero = sum(abs(dy_bit) <= 0.01); % count how many derivatives are close to 0
%            % check how many are very close to each other

while(num_sweep <= size(d,3))
    while(num_loops > 0)
       for i = lowerl:400:(upperl-400) % 400 inputs is width of an AP
           dy_bit = dy(i:i+400);
           numzero = sum(abs(dy_bit) <= 0.01);
           j = 1:400;
           is_last_bit_index = (mod(400, j) == 0); 
           if(~is_last_bit_index) % if you're not at the end of the AP, compare it to its right adjacent neighbor
               if(abs(dy_bit(j+1) - dy_bit(j)) < 0.01) % if it is roughly the same value as its neighbor, remove one numzero. the last zero in the "group" of zeros will be counted so we're not overcounting
               numzero = numzero - 1;
               end
           end
     
           if(numzero>=4) % successful AP if at least 4 (dy = 0)s
                 count_ap = count_ap + 1;
                 sweep_ap = sweep_ap + 1;
             end
        end
        count_ap 
             
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
    lowerl = find(abs(dy) > 0.1, 1); % if APs don't start within first 20000 data points
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

count_ap

end

% 1726 APs

