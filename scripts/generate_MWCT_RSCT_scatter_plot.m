function generate_MWCT_RSCT_scatter_plot(work,strain,type,name,HF_MWCT,CTEPH_MWCT,TOF_MWCT,HF_ESRSCT,CTEPH_ESRSCT,TOF_ESRSCT)
%first plot all the points
tof_idx = 1:length(TOF_MWCT);%[2 4 6 8 9 11 12 14];%1:length(TOF_MWCT);%randi([1 length(TOF_MWCT)],1,8);
hf_idx = 1:length(HF_MWCT);%randi([1 length(HF_MWCT)],1,8);
patMWCT = [TOF_MWCT(tof_idx) CTEPH_MWCT HF_MWCT(hf_idx)];
patRSCT = [TOF_ESRSCT(tof_idx) CTEPH_ESRSCT HF_ESRSCT(hf_idx)];

count = 1;
figure; hold all
for i = 1:numel(patMWCT)
    num_pts = length(patMWCT{i});
    %pts = randi([1 num_pts],round(0.20.*num_pts),1);
    pts = 1:num_pts;%randi([1 num_pts],1000,1);
    plot(patRSCT{i}(pts),patMWCT{i}(pts),'.','Color',[0.8 0.8 0.8]);
    if i == 1
        count2 = numel(pts);
    else
        count2 = count + numel(pts) - 1;
    end
    totRSCT(count:count2) = patRSCT{i}(pts);
    totMWCT(count:count2) = patMWCT{i}(pts);
    count = count2 + 1;
    clear num_pts pts
end

plot(strain,work,'k.')
% plot(FWHF_ESRSCT{hf_pat},FWHF_MWCT{hf_pat},'.','Color',[0 0.4470 0.7410])
% plot(SWHF_ESRSCT{hf_pat},SWHF_MWCT{hf_pat},'.','Color',[0.9290 0.6940 0.1250])

%set(gcf, 'Color','none'); set(gca,'Color','none')
xline(0.05,'--')
xline(-0.05,'--')
xline(-0.15,'--')
xline(-0.25,'--')
xline(-0.35,'--')
%xline(-0.5,'--')
yline(0,'--'); yline(5,'--'); yline(10,'--'); yline(15,'--'); yline(20,'--')
fit = polyfit(totRSCT,totMWCT,1);
yfit = polyval(fit,totRSCT);
plot(totRSCT,yfit,'r')
xlabel('End-Systolic RS_C_T')
ylabel('MW_C_T (mmHg)')
xlim([-0.8 0.25])
ylim([-25 55])
 % set(gca,'XTick',[])
 % set(gca,'YTick',[])
axis('square')
box on
set(findall(gcf,'-property','FontSize'),'FontSize',20)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)
set(findall(gcf,'-property','MarkerSize'),'MarkerSize',15)

% figpath = ['/Users/amandacraine/Documents/ContijochLab/repos/ac-squeez-scripts/RV-MWCT-profiling/figures/Work-Strain-Scatter/',type,'/'];
% if ~exist(figpath)
%     mkdir(figpath)
% else 
% end

% [new_img_scatter,a] = save_transparent_figures(gcf,figpath,name);
% imwrite(new_img_scatter,[figpath,'work-strain-scatter-',name,'-labels','.png'],'Alpha',a);
%imwrite(new_img_scatter,[figpath,'work-strain-scatter-',name,'.png'], 'Alpha', a);
% saveas(gcf,[figpath,'work-strain-scatter-',name,'-labels','.jpg'])
% %saveas(gcf,[figpath,'work-strain-scatter-',name,'.jpg'])

end