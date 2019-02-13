function  diameters=Diameter_Data_Collect_restricted_number_of_measurements()

%Input:  folder location (as a string) containing raw TDB data
%Output: CSV file containing column vector 

%Program: Prompts for min acceptable number of measurements per trial and maximum acceptable number of
%measurements per trial.  Then, omitting trials where the number of measurements is outside this range,
%collects & writes a CSV file (a single column vector) containing all 
%diameter measurements sorted in ascending order.

format long

%Prompts for min acceptable number of measurements per trial and maximum acceptable number of
%measurements per trial.

min_number=input('What would you like the mininum acceptable number of measurements per trial to be? ');
max_number=input('What would you like the maxmimum acceptable number of measurements per trial to be? ');

%collects names of raw data TDB files

data_dir=dir([Raw_Data '*.txt']);

%keeps track of last row data written into

diameters=[];

for i=1:length(data_dir(:,1))
    
    %runs analysis on subject data
    
    temp=TDB_Acquire([Raw_Data data_dir(i,1).name]);
    temp_2=Data_Fidelity_number_of_measurements_per_trial(temp,min_number,max_number);
    clear temp
    
    %checks to make sure data exists after fidelity checks
    
    if length(temp_2(:,1))==1
        continue
    end
    
    %computes average diameter
    
    temp_3=Diameter_Averages(temp_2);
    clear temp_2
    
    %identifies which column indicates 'diameter (avg.)'

    for j=1:length(temp_3(1,:))
        if strcmp(temp_3{1,j},'diameter (avg.)')
            diameter_avg=j;
        end    
    end

    %converts cell array to matrix form
    
    temp_4=cell2mat(temp_3(2:length(temp_3(:,1)),:));
    clear temp_3
    
    %isolates diameter data
    
    temp_4=temp_4(:,diameter_avg); 
    
    diameters=vertcat(diameters,temp_4(:,1));
    
end

%sorts diameters in ascending order

diameters=sort(diameters);

%writes resulting column vector as a CSV file

csvwrite(strcat(Diameter_Data_Sorted,'diameters [',num2str(min_number),',',num2str(max_number),'].csv'),diameters);

end


