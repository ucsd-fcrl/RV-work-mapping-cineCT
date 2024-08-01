function r = correlate_impaired_RV_performance_global_function(demo,input,y_title,ylimits,z)

RVEDV = table2array(demo(:,24));
RVESV = table2array(demo(:,25));
RVEF = (RVEDV - RVESV)./RVEDV.*100;

figure; hold all
box on
xline(40,'Color',[0.7 0.7 0.7])
xline(49,'Color',[0.7 0.7 0.7])
line([40 49],[0 0],'Color',[0.7 0.7 0.7])
line([40 49],[100 100],'Color',[0.7 0.7 0.7])
plot(RVEF(31:end),input{z}(31:end),'.r');
plot(RVEF(20:30),input{z}(20:30),'.','Color',[0.9290 0.6940 0.1250]);
plot(RVEF(1:19),input{z}(1:19),'.b');
xlabel('RVEF (%)')
ylabel(y_title{z})
ylim(ylimits{z})
xlim([0 100])
axis('square')
[r,p] = corr(RVEF(~isnan(RVEF)),input{z}(~isnan(RVEF)),'type','Spearman');
xtext = max(xlim) - 0.015.*range(xlim);
ytext = max(ylim) - 0.06.*range(ylim);
ytext2 = max(ylim) - 0.145.*range(ylim);
ytext3 = max(ylim) - 0.2.*range(ylim);
text(xtext,ytext,['R = ',num2str(r,'%.2f')],'HorizontalAlignment','right')
if p < 0.01
    text(xtext,ytext2,'p < 0.01','HorizontalAlignment','right')
else
    text(xtext,ytext2,['p = ',num2str(p,'%.2f')],'HorizontalAlignment','right')
end
fit = polyfit(RVEF(~isnan(RVEF)),input{z}(~isnan(RVEF)),1);
yfit = polyval(fit,[0 100]);
plot([0 100],yfit,'k')
%text(xtext,ytext3,['y = ',num2str(fit(1),'%.2f'),'x + ',num2str(fit(2),'%.2f')],'HorizontalAlignment','right')
if z == 2
    legend({'','','','','HF','CTEPH','rTOF'},'Position',[0.57,0.52,0.22,0.22])
end
set(findall(gcf,'-property','FontSize'),'FontSize',25)
set(findall(gcf,'-property','LineWidth'),'LineWidth',3)
set(findall(gcf,'-property','MarkerSize'),'MarkerSize',30)

end