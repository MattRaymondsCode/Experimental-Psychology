function z=TDB_Acquire(x)

%Input:  TDB file
%Output:  cell array {first row string labels; remaining rows data}

%Program:  Takes TDB input file, eliminates irrelevant data, and coverts
%what remains to cellular array.  Output columns are [time, trial #, diameter (left), diameter (right)]  

format long
y=readtable(x);

%keep only relevant data columns: time, trial number, left diameter, right
%diameter

y=y(:,[1 3 10 13]);
temp=table2cell(y);
clear y
z=vertcat({'time','trial #','diameter (left)','diameter (right)'},temp);
clear temp

end




