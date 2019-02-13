function y=CSV_To_Matrix_0_0(x)

%Input:  CSV file
%Output:  matrix

%Program:  Reads CSV file beginning at row 0, column 0, & outputs the
%corresponding matrix

format long

y=dlmread(x,',',0,0);

end
