function  Diameter_Descriptives()

%INPUT:    a CSV file containing a single column vector of sorted
%(ascending) diameter data, & a percentage p in decimal form
%Output:   a column vector containing [min, max, min_cutoff, max_cutoff]

%Program:  Collects minimum, maximum, and cutoffs that remove the least
%amount of data such that at least the lowest p% & highest (100-p)% of data
%have been removed.

format long

%Prompts for min acceptable number of measurements per trial and maximum acceptable number of
%measurements per trial.

min_number=input('What would you like the mininum acceptable number of measurements per trial to be? ');
max_number=input('What would you like the maxmimum acceptable number of measurements per trial to be? ');
%Prompts for what percent of data to exclude from tails

p=input('What percent of data would you like excluded from the top and bottom of the diameter distribution?');
p=p/100;

%Converts diameter data from input CSV file into matrix

diameters=CSV_To_Matrix_0_0(strcat(Diameter_Data_Sorted,'diameters [',num2str(min_number),',',num2str(max_number),'].csv'));

y={'percent cutoff','diameter min (raw)','diameter min (calc.)','cutoff min (# of trials omitted below)','diameter max (raw)','diameter max (calc.)','cutoff max (# of trials omitted above)','# of trials remaining'};

%caclulates min & max values of raw data

y{2,1}=p*100;
y{2,2}=min(diameters);
y{2,5}=max(diameters);

%calculates total number of measurements

number_of_measurements=length(diameters(:,1));

%calculates trial number least lower bound, & greatest upper bound, such that at least 100p% of the data will be
%removed from the top & bottom

trial_number_least_lower_bound=ceil(p*number_of_measurements);
trial_number_greatest_upper_bound=floor((1-p)*number_of_measurements);

%calculates the diameter values corresponding to the least lower bound &
%greatest upper bound

diameter_lower_bound=diameters(trial_number_least_lower_bound,1);
diameter_upper_bound=diameters(trial_number_greatest_upper_bound,1);

%finds the maximum row corresponding to the least lower bound, & the
%minimum row corresponding to the greatest upper bound

row_cut_bottom=max(find(diameters(:,1)==diameter_lower_bound));
row_cut_top=min(find(diameters(:,1)==diameter_upper_bound));

%reports minimum diameter kept & maximum diameter kept

y{2,3}=diameters(row_cut_bottom+1,1);
y{2,6}=diameters(row_cut_top-1,1);

%reports number of measurements cut on the low end & high, & total number
%of remaining measurements

y{2,4}=row_cut_bottom;
y{2,7}=number_of_measurements-row_cut_top+1;
y{2,8}=row_cut_top-row_cut_bottom-1;

%writes resulting column vector as a XLS file

xlswrite(strcat(Diameter_Data_Descriptives,num2str(min_number),'.',num2str(max_number),'(',num2str(p*100),').xls'),y);

end





















