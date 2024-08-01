%load in the spreadsheet
clear; clc;

demo = readtable("data/demographics.csv");
%%
%Patient History
sex = table2array(demo(:,3));
for i = 1:length(sex)
    if sex{i} == 'M'
        females(i,:) = 0;
    elseif sex{i} == 'F'
        females(i,:) = 1;
    end
end

age = table2array(demo(:,4));
BMI = table2array(demo(:,8));
BSA = table2array(demo(:,7));
CT_RHC_time = table2array(demo(:,9));

arr = table2array(demo(:,13));
for i = 1:length(arr)
    if strcmp(arr{i},'No') || strcmp(arr{i},'no')
        conductance(i,:) = 0;
    else
        conductance(i,:) = 1;
    end
end

af = table2array(demo(:,31));
for i = 1:length(af)
    if strcmp(af{i},'No') || strcmp(af{i},'no')
        afib(i,:) = 0;
    else
        afib(i,:) = 1;
    end
end

pacemaker = table2array(demo(:,14));
for i = 1:length(pacemaker)
    if strcmp(pacemaker{i},'No') || strcmp(pacemaker{i},'no') || strcmp(pacemaker{i},'None')
        pm(i,:) = 0;
    else
        pm(i,:) = 1;
    end
end

PS = round(table2array(demo(:,34)));
PR = round(table2array(demo(:,37)));
TR = round(table2array(demo(:,40)));
FC = round(table2array(demo(:,10)));

%note: running the conductance dataset through the table_analysis function
%yields an error when normality of the dataset is tested. this is because
%all of the HF patients have the same value for this variable. can manually
%perform statstical analysis on this variable by setting the normality to 0
%in table_analysis, which performs a nonparametric analysis on the dataset.

demo_results = [females, age,BMI, CT_RHC_time,afib, pm,PS, PR, TR, FC];
for i = 1:size(demo_results,2)
    [demo_stats(i,:),demo_reported_results(i,:)] = table_analysis(demo_results(1:19,i),demo_results(20:30,i),demo_results(31:end,i),1,1);
end

tof_repair_age = table2array(demo(1:19,11));
%%
%CT measurements
RVEDV = table2array(demo(:,18));
%RVSV = table2array(demo(:,27));
%RVEF = table2array(demo(:,28));
RVESV = table2array(demo(:,19));
RVEDVI = RVEDV./BSA;
RVESVI = RVESV./BSA;
RVSVI = RVEDVI - RVESVI;
RVEF = (RVEDVI - RVESVI)./RVEDVI.*100;

CT_results = [RVEDVI, RVESVI, RVSVI, RVEF];
for i = 1:size(CT_results,2)
    [CT_stats(i,:),CT_reported_results(i,:)] = table_analysis(CT_results(1:19,i),CT_results(20:30,i),CT_results(31:end,i),1,1);
end

%%
%cath measurements
HR_cath = table2array(demo(:,24));
CO = table2array(demo(:,25));
CI = CO./BSA;
mPAP = table2array(demo(:,26));
RAP = table2array(demo(:,29));
PCWP = table2array(demo(:,27));
%PVR = table2array(demo(:,28)).*80;
PVR = (mPAP - PCWP)./CO.*80;

RHC_results = [HR_cath, CO, CI, mPAP, RAP, PCWP, PVR];

for i = 1:size(RHC_results,2)
    [RHC_stats(i,:),RHC_reported_results(i,:)] = table_analysis(RHC_results(1:19,i),RHC_results(20:30,i),RHC_results(31:end,i),1,1);
    
end
