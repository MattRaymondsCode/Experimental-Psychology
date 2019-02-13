function y=Diameter_Averages_left_right(x)

%Input:  cell array {first row string labels; remaining rows data}
%Output:  cell array {first row string labels; remaining rows data}, with
%additional column of 'average diameter' data

%Program:  Calculates average of 'diameter (left)' & 'diameter (right)' &
%appends results in additional column 'diameter (avg.)'

format long

%identifies which columns indicate 'diameter (left)' & 'diameter (right)'

for i=1:length(x(1,:))
    if strcmp(x{1,i},'diameter (left)')
        diameter_left=i;
    end    
    if strcmp(x{1,i},'diameter (right)')
        diameter_right=i;
    end
end

%isolates numerical data & converts it to a matrix.  Deletes data portion
%of input cell array (for efficiency) but keeps first row that labels
%variables

temp=cell2mat(x(2:length(x(:,1)),:));
x=x(1,:);

%adds new column 'diameter (avg.)' to list of labels

x{1,end+1}='diameter (avg.)';

%take average of left & right diameters and appends it to original data set

temp(:,end+1)=(temp(:,diameter_left)+temp(:,diameter_right))/2;

%converts new matrix of data into a cell

temp_2=num2cell(temp);
clear temp

%vertically concatenate labels to sorted data

y=vertcat(x,temp_2);
clear temp_2

end
