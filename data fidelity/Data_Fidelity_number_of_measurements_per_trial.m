function y=Data_Fidelity_number_of_measurements_per_trial(x,min,max)

%Input:  cell array {first row string labels; remaining rows data}, min
%acceptable number of measurements per trial, maximum acceptable number of
%measurements per trial
%Output:  cell array {first row string labels; remaining rows data}

%Program:  Removes all data from trials that have fewer than min or more than max measurements.  

format long

%identifies which column indicates trial #

for i=1:length(x(1,:))  
    if strcmp(x{1,i},'trial #')
        trial_number=i;
    end
end

%isolates numerical data & converts it to a matrix.  Deletes data portion
%of input cell array (for efficiency) but keeps first row that labels
%variables

temp=cell2mat(x(2:end,:));
x=x(1,:);

%finds unique trial numbers

trial_numbers=unique(temp(:,trial_number));
[measurements_per_trial,~]=histc(temp(:,trial_number),trial_numbers);
discarded_trial_numbers=[];

%collect all trial numbers that have fewer than 300 or more than 800
%measurements

for i=1:length(trial_numbers(:,1))
    if min<=measurements_per_trial(i,1) && measurements_per_trial(i,1)<=max
        continue
    else 
        discarded_trial_numbers(end+1,1)=trial_numbers(i,1);
    end
end

clear trial_numbers
clear measurements_per_trial

%delete all data from trials that don't fit the above criteria

for i=1:length(discarded_trial_numbers)
    temp_2=temp(:,trial_number)~=discarded_trial_numbers(i,1);
    temp=temp(temp_2,:);
    clear temp_2
end

clear discarded_trial_numbers

%convert remaining data back into cell array

temp_3=num2cell(temp);
clear temp

%vertically concatenate original labels to edited data

y=vertcat(x,temp_3);
clear temp_3


end