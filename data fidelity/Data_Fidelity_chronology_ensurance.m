function y=Data_Fidelity_chronology_ensurance(x)
 
%Input:  cell array {first row string labels; remaining rows data}
%Output:  cell array {first row string labels; remaining rows data}

%Program:  Sorts input rows by trial # (ascending) then by time
%(ascending).  This is a check on what should have naturally been output by
%the instrument.  

format long

%identifies which columns indicate time & trial #

for i=1:length(x(1,:))
    if strcmp(x{1,i},'time')
        time=i;
    end    
    if strcmp(x{1,i},'trial #')
        trial_number=i;
    end
end

%isolates numerical data & converts it to a matrix.  Deletes data portion
%of input cell array (for efficiency) but keeps first row that labels
%variables

temp=cell2mat(x(2:length(x(:,1)),:));
x=x(1,:);

%sorts data entries first by trial # (ascending), then by time (ascending)

temp_2=sortrows(temp,[trial_number time]);
clear temp

%converts sorted matrix into cell

temp_3=num2cell(temp_2);
clear temp_2

%vertically concatenate original labels to sorted data

y=vertcat(x,temp_3);
clear temp_3

end
