function generate_MWCT_profiling_histogram(work_input,type,name)

% work histogram
work_bins = [-Inf 0:5:20 Inf];
work_edges = -5:5:25;
%work map colors from generate3Dmap_RVMWCT_profiling
colorMapLength = 10;
dark = [85.8 163.9 238.7];
light = [220 234 255];
colors_p = [linspace(dark(1),light(1),colorMapLength)', linspace(dark(2),light(2),colorMapLength)', linspace(dark(3),light(3),colorMapLength)'];
map_work = [9.8 28 56; 36.3 104.5 169.4; 85.8 163.9 238.7; colors_p(5,:); 220 234 255]./255;

y = (histcounts(work_input,work_bins))./numel(work_input).*100;
figure; hold all; %b = bar(y,'hist');
b = barh((work_edges(1:end-1)+work_edges(2:end))/2,y);
%set(gcf, 'Color','none'); set(gca,'Color','none')
b.BarWidth = 1;
b.CData = [map_work; 1 1 1];
b.FaceColor = 'flat';
b.LineWidth = 1.5;
xlim([0 100])%xlim([0 max(y) + 0.2.*range(y)])
ylim([-25 55])
xlabel('% RV')
ylabel('MW_C_T (mmHg)')
set(gca,'YTick',work_edges)
set(gca,'YTickLabel',{'<0','0','5','10','15','20','>20'})
for z = 1:length(y)
    xtext = y(z) + 0.03.*range(y);
    text(xtext,work_edges(z)+2.5,[num2str(round(y(z)))],'VerticalAlignment','middle')
end
 % set(gca,'XTickLabel',{})
 % set(gca,'YTick',[])
axis('square')
box on
set(findall(gcf,'-property','FontSize'),'FontSize',20)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)
set(findall(gcf,'-property','MarkerSize'),'MarkerSize',15)

% figpath = ['/Users/amandacraine/Documents/ContijochLab/repos/ac-squeez-scripts/RV-MWCT-profiling/figures/Work-Histogram/',type,'/'];
% if ~exist(figpath)
%     mkdir(figpath)
% else 
% end
% [new_img_work,a] = save_transparent_figures(b,figpath,name);
% %imwrite(new_img_work,[figpath,'work-hist-',name,'-labels','.png'], 'Alpha', a);
% imwrite(new_img_work,[figpath,'work-hist-',name,'.png'], 'Alpha', a);
end