function generate_RSCT_histogram(strain_input,type,name)

strain_bins = [-Inf -0.35:0.1:0.05 Inf];
strain_edges = -0.45:0.1:0.15;
map_strain = [242 207 238; 229 158 221; 216 110 204; 144 38.4 132; 56 15.4 51.8]./255;

% strain histogram
y = (histcounts(strain_input,strain_bins))./numel(strain_input).*100;
figure; hold all; %b = bar(y,'hist');
b = bar((strain_edges(1:end-1)+strain_edges(2:end))/2,y);
%set(gcf, 'Color','none'); set(gca,'Color','none')
b.BarWidth = 1;
b.CData = [1 1 1; map_strain];
b.FaceColor = 'flat';
ylim([0 100])%ylim([0 max(y) + 0.2.*range(y)])
xlim([-0.8 0.25])%xlim([-3 7])
xlabel('End-Systolic RS_C_T')
ylabel('% RV')
set(gca,'XTick',[-0.45:0.1:0.15])
set(gca,'XTickLabel',{'<-0.35','-0.35','-0.25','-0.15','-0.05','0.05','>0.05'})
for z = 1:length(y)
    ytext = y(z) + 0.08.*range(y);
    text(strain_edges(z)+0.05,ytext,[num2str(round(y(z)))],'HorizontalAlignment','center')
end
 % set(gca,'XTick',[])
 % set(gca,'YTickLabel',{})
axis('square')
box on
set(findall(gcf,'-property','FontSize'),'FontSize',20)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)
set(findall(gcf,'-property','MarkerSize'),'MarkerSize',15)

% figpath = ['figures/Strain-Histogram/',type,'/'];
% if ~exist(figpath)
%     mkdir(figpath)
% else 
% 
% end
%[new_img_strain,a] = save_transparent_figures(b,figpath,name);
%imwrite(new_img_strain,[figpath,'strain-hist-',name,'-labels','.png'],'Alpha',a);
%imwrite(new_img_strain,[figpath,'strain-hist-',name,'.png'], 'Alpha', a);
end
