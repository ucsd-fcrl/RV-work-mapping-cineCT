function r = correlate_impaired_RV_MWCT_RSCT(input,xlim_labels,y_title,work_input_idx)
figure; hold all
box on
plot(input{2}(1:19),input{work_input_idx}(1:19),'.b');
plot(input{2}(20:30),input{work_input_idx}(20:30),'.','Color',[0.9290 0.6940 0.1250]);
plot(input{2}(31:end),input{work_input_idx}(31:end),'.r');
ylabel(y_title{work_input_idx})
xlabel(y_title{2})
xlim([0 100])
ylim(xlim_labels{work_input_idx})
axis('square')
[r,p] = corr(input{2},input{work_input_idx},'type','Spearman');
if work_input_idx == 3
    xtext = min(xlim) + 0.04.*range(xlim);
    ytext = max(ylim) - 0.06.*range(ylim);
    ytext2 = max(ylim) - 0.145.*range(ylim);
elseif work_input_idx == 1
    xtext = max(xlim) - 0.04.*range(xlim);
    ytext = min(ylim) + 0.06.*range(ylim);
    ytext2 = min(ylim) + 0.145.*range(ylim);
end
%ytext3 = max(ylim) - 0.3.*range(ylim);
if p < 0.01 && work_input_idx == 3
    text(xtext,ytext,['R = ',num2str(r,'%.2f')],'HorizontalAlignment','left')
    text(xtext,ytext2,'p < 0.01','HorizontalAlignment','left')
elseif p < 0.01 && work_input_idx == 1
    text(xtext,ytext2,['R = ',num2str(r,'%.2f')],'HorizontalAlignment','right')
    text(xtext,ytext,'p < 0.01','HorizontalAlignment','right')
elseif p >= 0.01 && work_input_idx == 3
    text(xtext,ytext2,['p = ',num2str(p,'%.2f')],'HorizontalAlignment','left')
elseif p >= 0.01 && work_input_idx == 1
    text(xtext,ytext2,['p = ',num2str(p,'%.2f')],'HorizontalAlignment','right')
end
fit = polyfit(input{2},input{work_input_idx},1);
yfit = polyval(fit,[0 100]);
plot([0 100],yfit,'k')
% text(xtext,ytext3,['y = ',num2str(fit(1),'%.2f'),'x + ',num2str(fit(2),'%.2f')],'HorizontalAlignment','right')

set(findall(gcf,'-property','FontSize'),'FontSize',25)
set(findall(gcf,'-property','LineWidth'),'LineWidth',3)
set(findall(gcf,'-property','MarkerSize'),'MarkerSize',30)
end