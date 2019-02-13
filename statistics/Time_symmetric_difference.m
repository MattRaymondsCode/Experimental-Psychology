function y=Time_symmetric_difference(x)

%Input:  cell array {first row string labels; remaining rows data}
%Output:  cell array {first row string labels; remaining rows data}, with
%additional column of 'time (sym. diff.)' data

%Program:  within each trial, pairs the time of the first measurement with
%that of the last, pairs the time second measurement with that of the
%second to last, etc.  Subtracting the former from the latter gives the
%statistic 'time (sym. diff.)', & dividing by 1000 converts microseconds to milli seconds.
%This data is then appended as a new column to the original data set.  

format long

%identifies which columns indicate 'time' & 'trial #'

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

%adds new column 'time (sym. diff.)' to list of labels

x{1,end+1}='time (sym. diff.)';


%create new matrix from trial & time columns, then sort by trial
%(ascending) & time (descending)

temp_2=temp(:,[time trial_number]);
temp_2=sortrows(temp_2,[2 -1]);

%append new time column to parent data set

temp(:,end+1)=temp_2(:,1);
clear temp_2

%compute "diff" time statistic, converts microseconds to milliseconds delete previous data

temp(:,end)=(temp(:,end)-temp(:,time))/1000;

%converts new matrix of data into a cell

temp_2=num2cell(temp);
clear temp

%vertically concatenate labels to sorted data

y=vertcat(x,temp_2);
clear temp_2




end