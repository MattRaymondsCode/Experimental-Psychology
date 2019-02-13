function Binning_Original(input)

%Input:  folder location (as a string) containing raw TDB data
%Output:  

%Program:  

format long

%collects names of TDB data files

data_dir=dir([input '\*.txt']);

%keeps track of last row data written into

output_cell_marker=2;

for i=1:length(data_dir(:,1))
    
    %finds subject number from file name
    
    if data_dir(i,1).name(2)==' '
        subject=str2num(data_dir(i,1).name(1));    
    elseif data_dir(i,1).name(3)==' '
        subject=str2num(data_dir(i,1).name(1:2));
    elseif data_dir(i,1).name(4)==' '
        subject=str2num(data_dir(i,1).name(1:3));
    end
    
    %runs analysis on subject data
    
    temp=TDB_Acquire([input '\' data_dir(i,1).name]);
    temp_2=Data_Fidelity_Chronology(temp);
    clear temp
    
    temp_3=Data_Fidelity_Number_Of_Trials(temp_2);
    clear temp_2
    
    temp_4=Average_Diameter(temp_3);
    clear temp_3
    
    temp_5=Time_Symmetric_Difference(temp_4);
    clear temp_4
    
    temp_6=Average_Diameters_Over_Time_Symmetric_Difference_Categories(temp_5);
    clear temp_5
    
    %appends subject number to left of data set
    
    temp_7=[];
    temp_7(1:length(temp_6(:,1)),1)=subject;
    temp_8=num2cell(temp_7);
    clear temp_7
    results=horzcat(temp_8,temp_6);
    clear temp_6
    clear temp_8
    
    %keeps variable labels only if first data set being analyzed
    
    if output_cell_marker~=2
        results=results(2:end,:);
    else
        results{1,1}='subject';
    end
    
    xlswrite('C:\Users\Footherder\Desktop\goat.xls',results,'Output',strcat('A',num2str(output_cell_marker)));
    
    %keeps track of where to begin writing data from next file
    
    output_cell_marker=output_cell_marker+length(results(:,1));
    
end

end

    
    
    
    
    
    

