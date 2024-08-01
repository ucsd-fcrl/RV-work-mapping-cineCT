function generate_segRV_MWCT_profiling_plots(input,ytitle,labels,idx)
figure; set(gcf, 'Position',[200 300 1500 600])
s = subplot(1,3,1);
boxplot(input{idx,3},labels,'Whisker',Inf)
title('HF')
ylabel(ytitle{idx})
ylim([-5 105])
axis('square')

s1 = subplot(1,3,2);
boxplot(input{idx,2},labels,'Whisker',Inf)
title('CTEPH')
ylabel(ytitle{idx})
ylim([-5 105])
axis('square')

s2 = subplot(1,3,3);
boxplot(input{idx,1},labels,'Whisker',Inf)
title('rTOF')
ylabel(ytitle{idx})
ylim([-5 105])
axis('square')

s1pos = get(s,'Position');
spos = get(s1,'Position');
spos2 = get(s2,'Position');
spos([2,3,4]) = s1pos([2,3,4]);
spos2([2,3,4]) = s1pos([2,3,4]);
set(s1,'Position',spos)
set(s2,'Position',spos2)
s1pos([2,3,4]) = spos([2,3,4]);
set(s,'Position',s1pos)
set(findall(gcf,'-property','FontSize'),'FontSize',25)
set(findall(gcf,'-property','LineWidth'),'LineWidth',3)
set(findall(gcf,'-property','MarkerSize'),'MarkerSize',30)

end