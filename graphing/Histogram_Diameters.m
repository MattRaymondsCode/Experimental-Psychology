function Histogram_Diameters(x)
%CREATEFIGURE(DATA1)
%  DATA1:  histogram data

%  Auto-generated by MATLAB on 09-Feb-2019 16:45:50

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);

% Create histogram
histogram(x,'DisplayName','y','Parent',axes1,'DisplayStyle','stairs',...
    'EdgeColor',[0.164705882352941 0.384313725490196 0.274509803921569],...
    'FaceColor','none',...
    'BinMethod','auto');

box off

% Create xlabel
xlabel('Average Pupil Diameter');

% Create title
title('Histogram of Measured Average (Left/Right) Pupil Diameter',...
    'FontSize',16);


% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 9]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0 160000]);
% Set the remaining axes properties





set(axes1,'FontName','Times New Roman','FontWeight','bold','XColor',[0 0 0],...
    'XMinorTick','on','YColor',[0 0 0],'ZColor',[0 0 0]);

y_ticks = get(gca, 'YTick');

temp=0;

for i=2:20
    if y_ticks(1,2)/10^i<10 && y_ticks(1,2)>=1
        temp=i;
        break
    end
end

        

set(gca, 'YTickLabel', cellstr(num2str(y_ticks(:)/10^temp)));

% Create ylabel
ylabel(strcat('Number of Measurements (\times 10^',num2str(i),')'));

end
