function y=Diameter_Averages_over_time_symmetric_difference_categories(x)

%Input:  cell array {first row string labels; remaining rows data} that
%contains statistic 'diameter (avg.)'
%Output:  

%Program:  

format long

%identifies which columns indicate 'time (sym. diff.)', 'trial #', &
%'diameter (avg.)'

for i=1:length(x(1,:))
    if strcmp(x{1,i},'time (sym. diff.)')
        time_sym_diff=i;
    end    
    if strcmp(x{1,i},'trial #')
        trial_number=i;
    end  
    if strcmp(x{1,i},'diameter (avg.)')
        diameter_avg=i;
    end  
end

%isolates numerical data & converts it to a matrix.  Deletes data portion
%of input cell array (for efficiency) but keeps first row that labels
%variables

temp=cell2mat(x(2:length(x(:,1)),:));
x=x(1,:);

%collects unique trial numbers

trial_numbers=unique(temp(:,trial_number));

%Computes average diameters based on Time_Statistic_Original (T)

%bin0:  T>4940
%bin1:  3000=<T<=4940
%bin2:  1000<=T<3000
%bin3:  -1000<=T<1000
%bin4:  -3000<=T<-1000
%bin5:  T<-3000

for i=1:length(trial_numbers(:,1))
    
    %computes bin 0 average
    
    temp_2=temp(:,trial_number)==trial_numbers(i,1) & temp(:,time_sym_diff)>4940;
    trial_numbers(i,2)=mean(temp(temp_2,diameter_avg));
    clear temp_2
    
    %computes bin 1 average
    
    temp_2=temp(:,trial_number)==trial_numbers(i,1) & temp(:,time_sym_diff)<=4940 & temp(:,time_sym_diff)>=3000;
    trial_numbers(i,3)=mean(temp(temp_2,diameter_avg));
    clear temp_2
    
    %computes bin 2 average
    
    temp_2=temp(:,trial_number)==trial_numbers(i,1) & temp(:,time_sym_diff)<3000 & temp(:,time_sym_diff)>=1000;
    trial_numbers(i,4)=mean(temp(temp_2,diameter_avg));
    clear temp_2
    
    %computes bin 3 average
    
    temp_2=temp(:,trial_number)==trial_numbers(i,1) & temp(:,time_sym_diff)<1000 & temp(:,time_sym_diff)>=-1000;
    trial_numbers(i,5)=mean(temp(temp_2,diameter_avg));
    clear temp_2
    
    %computes bin 4 average
    
    temp_2=temp(:,trial_number)==trial_numbers(i,1) & temp(:,time_sym_diff)<-1000 & temp(:,time_sym_diff)>=-3000;
    trial_numbers(i,6)=mean(temp(temp_2,diameter_avg));
    clear temp_2
    
    %computes bin 5 average
    
    temp_2=temp(:,trial_number)==trial_numbers(i,1) & temp(:,time_sym_diff)<-3000;
    trial_numbers(i,7)=mean(temp(temp_2,diameter_avg));
    clear temp_2
    
end

clear temp

%converts sorted matrix into cell

temp_3=num2cell(trial_numbers);
clear trial_numbers

%vertically concatenate original labels to sorted data

y=vertcat({'trial #','bin 0 (avg.)','bin 1 (avg.)','bin 2 (avg.)','bin 3 (avg.)','bin 4 (avg.)','bin 5 (avg.)'}, temp_3);
clear temp_3


end






