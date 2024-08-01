clear; clc

%collect patient-specific rv performance data for all populations
rv_work_profile_data_generation
%or load the data file
%load('rv_work_profile_data_generation.mat')

%% Demographic data analysis by population (Table 1)
RVMWCT_profiling_demo_stats

%% RV Statistical Analysis (Table 2)
for i = 1:6
    [strain_stats(i,:),strain_reported_results(i,:)] = table_analysis(HFStrain_percent(:,i),CTEPHStrain_percent(:,i),TOFStrain_percent(:,i),1,1);
    [work_stats(i,:),work_reported_results(i,:)] = table_analysis(HFWork_percent(:,i),CTEPHWork_percent(:,i),TOFWork_percent(:,i),1,1);
end

%% Segmental RV Statistical Analysis (Table 3)
for i = 1:6
    [FWstrain_stats(i,:),FWstrain_reported_results(i,:)] = table_analysis(FW_HFStrain_percent(:,i),FW_CTEPHStrain_percent(:,i),FW_TOFStrain_percent(:,i),1,1);
    [FWwork_stats(i,:),FWwork_reported_results(i,:)] = table_analysis(FW_HFWork_percent(:,i),FW_CTEPHWork_percent(:,i),FW_TOFWork_percent(:,i),1,1);
end

for i = 1:6
    [SWstrain_stats(i,:), SWstrain_reported_results(i,:)] = table_analysis(SW_HFStrain_percent(:,i),SW_CTEPHStrain_percent(:,i),SW_TOFStrain_percent(:,i),1,1);
    [SWwork_stats(i,:), SWwork_reported_results(i,:)] = table_analysis(SW_HFWork_percent(:,i),SW_CTEPHWork_percent(:,i),SW_TOFWork_percent(:,i),1,1);
end

%% Work and Strain Histograms (Figures 3-5)
num = 19;
type = 'TOF';
name = TOFpatnames{num};
strain_input = TOF_ESRSCT{num};
work_input = TOF_MWCT{num};

generate_RSCT_histogram(strain_input,type,0)
generate_MWCT_profiling_histogram(work_input,type,0)

%% Get Work-Strain Scatter Plot (Figures 3-5)
num = 5; %13 1 8
type = 'HF';
name = HFpatnames{num};
work = HF_MWCT{num};
strain = HF_ESRSCT{num};
generate_MWCT_RSCT_scatter_plot(work,strain,type,0,HF_MWCT,CTEPH_MWCT,TOF_MWCT,HF_ESRSCT,CTEPH_ESRSCT,TOF_ESRSCT)

%% Segmental RV Work Profiling Boxplot (Figure 2)
idx = 2; %1 = Free Wall, 2 = Septal Wall
input = [{FW_TOFWork_percent},{FW_CTEPHWork_percent},{FW_HFWork_percent};...
    {SW_TOFWork_percent},{SW_CTEPHWork_percent},{SW_HFWork_percent}];
ytitle = [{'% RV Free Wall'},{'% RV Septal Wall'}];
% labels = {'MW < 0','0 < MW < 5','5 < MW < 10','10 < MW < 15',...
%     '15 < MW < 20','20 < MW'};
labels = {'Negative','Low','Low-Medium','Medium',...
    'Medium-High','High'};
generate_segRV_MWCT_profiling_plots(input,ytitle,labels,idx)

%% Negative work vs RV ejection fraction (Figure 6)
demo = readtable('/Users/amandacraine/Documents/ContijochLab/MW_CT_manuscript/demographics.csv');
demo([4,9,30,40],:) = [];

input = [{[sum(TOFWork_percent(:,1:2),2);sum(CTEPHWork_percent(:,1:2),2);sum(HFWork_percent(:,1:2),2)]},...
    {[sum(TOFStrain_percent(:,1:3),2);sum(CTEPHStrain_percent(:,1:3),2);sum(HFStrain_percent(:,1:3),2)]},...
    [TOFWork_percent(:,1);CTEPHWork_percent(:,1);HFWork_percent(:,1)]];

y_title = [{'% MW_C_T \leq 5 mmHg'},{'% End-Systolic RS_C_T \geq -0.15'},{'% MW_C_T \leq 0 mmHg'}];
ylimits = [{[0 100]};{[0 100]};{[0 100]}];

%figures 6 A, B, D
for z = 1:3 %1 = impaired MWCT, 2 = impaired RSCT, 3 = negative MWCT
    r1(z) = correlate_impaired_RV_performance_global_function(demo,input,y_title,ylimits,z);
end

%figures 6 C&E
xlim_labels = [{[0 100]};{[]};{[0 100]}];
for work_input_indx = [1,3]
    r2(work_input_indx) = correlate_impaired_RV_MWCT_RSCT(input,xlim_labels,y_title,work_input_indx);
end


%fisher's r-to-z transformation comparing RV performance correlations to RVEF
sample_size = input{1};
%comparing Fig 6B to Fig 6A
fisher_negMWCT_impairedRSCT = r_to_z_transformation(r1(3),r1(2),sample_size);
%comparing Fig 6D to Fig 6A
fisher_impairedMWCT_impairedRSCT = r_to_z_transformation(r1(1),r1(2),sample_size);
%comparing Fig 6B to Fig 6D
fisher_impairedMWCT_negMWCT = r_to_z_transformation(r1(1),r1(3),sample_size);

%fisher's r-to-z transformation comparing RV MWCT correlations to impaired
%RSCT
%comparing Fig 6E to Fig 6C
fisher_impairedMWCT_negMWCT2 = r_to_z_transformation(r2(1),r2(3),sample_size);

