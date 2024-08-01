clear; clc

%%
%get existing patient cohort function
addpath('natsortfiles/')
TOFstrain_res = natsortfiles(dir('data/RSCT_data/rTOF*')); 
TOFwork_res = natsortfiles(dir('data/MWCT_data/rTOF*')); 
TOFlids_res = natsortfiles(dir('data/lid_framepts/rTOF*')); 
TOFvols_res = natsortfiles(dir('data/RV_volumes/rTOF*')); 
TOF_FWpts_res = natsortfiles(dir('data/FW_framepts/rTOF*')); 
TOF_SWpts_res = natsortfiles(dir('data/SW_framepts/rTOF*')); 

for i = 1:length(TOFstrain_res)
    name = TOFstrain_res(i).name;
    rmvstr = strfind(name,'_');
    TOFpatnames{i} = name(1:rmvstr-1);
    TOFstrain{i} = readtable([TOFstrain_res(i).folder,'/',TOFstrain_res(i).name]);
    TOFwork{i} = readtable([TOFwork_res(i).folder,'/',TOFwork_res(i).name]);
    TOFlids{i} = readtable([TOFlids_res(i).folder,'/',TOFlids_res(i).name]);
    TOFvols{i} = readtable([TOFvols_res(i).folder,'/',TOFvols_res(i).name]);
    [TOF_MWCT{i},TOF_ESRSCT{i},TOF_minRSCT{i}] = getPatientPerformance(TOFwork{i},TOFstrain{i},TOFvols{i},TOFlids{i},[]);
    [TOFStrain_percent(i,:),TOF_strain_profiles{i}] = getStrainProfiles(TOF_ESRSCT{i});
    [TOFWork_percent(i,:),TOF_work_profiles{i}] = getWorkProfiles(TOF_MWCT{i});
    [TOFPeakStrain_percent(i,:),TOF_peakstrain_profiles{i}] = getStrainProfiles(TOF_minRSCT{i});
    TOF_meanMWCT(i,:) = mean(TOF_MWCT{i});
    % 
    TOF_FWpts = readtable([TOF_FWpts_res(i).folder,'/',TOF_FWpts_res(i).name]);
    TOF_SWpts = readtable([TOF_SWpts_res(i).folder,'/',TOF_SWpts_res(i).name]);
    [~,rmv_FW{i},rmv_SW{i}] = intersect(table2array(TOF_FWpts),table2array(TOF_SWpts));

    [FWTOF_MWCT{i},FWTOF_ESRSCT{i},FWTOF_minRSCT{i}] = getPatientPerformance(TOFwork{i},TOFstrain{i},TOFvols{i},TOFlids{i},TOF_FWpts,rmv_FW{i});
    [FW_TOFStrain_percent(i,:),FWTOF_strain_profiles{i}] = getStrainProfiles(FWTOF_ESRSCT{i});
    [FW_TOFWork_percent(i,:),FWTOF_work_profiles{i}] = getWorkProfiles(FWTOF_MWCT{i});
    [FW_TOFPeakStrain_percent(i,:),FWTOF_peakstrain_profiles{i}] = getStrainProfiles(FWTOF_minRSCT{i});
    FWTOF_meanMWCT(i,:) = mean(FWTOF_MWCT{i});
    
    [SWTOF_MWCT{i},SWTOF_ESRSCT{i},SWTOF_minRSCT{i}] = getPatientPerformance(TOFwork{i},TOFstrain{i},TOFvols{i},TOFlids{i},TOF_SWpts,rmv_SW{i});
    [SW_TOFStrain_percent(i,:),SWTOF_strain_profiles{i}] = getStrainProfiles(SWTOF_ESRSCT{i});
    [SW_TOFWork_percent(i,:),SWTOF_work_profiles{i}] = getWorkProfiles(SWTOF_MWCT{i});
    [SW_TOFPeakStrain_percent(i,:),SWTOF_peakstrain_profiles{i}] = getStrainProfiles(SWTOF_minRSCT{i});
    SWTOF_meanMWCT(i,:) = mean(SWTOF_MWCT{i});
end

CTEPHstrain_res = natsortfiles(dir('data/RSCT_data/CTEPH*'));%readtable('RSCT_data/CTEPH4_RSCT.csv');
CTEPHwork_res = natsortfiles(dir('data/MWCT_data/CTEPH*'));
CTEPHlids_res = natsortfiles(dir('data/lid_framepts/CTEPH*'));
CTEPHvols_res = natsortfiles(dir('data/RV_volumes/CTEPH*'));
CTEPH_FWpts_res = natsortfiles(dir('data/FW_framepts/CTEPH*'));
CTEPH_SWpts_res = natsortfiles(dir('data/SW_framepts/CTEPH*'));

for i = 1:length(CTEPHvols_res)
    name = CTEPHstrain_res(i).name;
    rmvstr = strfind(name,'_');
    CTEPHpatnames{i} = name(1:rmvstr-1);
    CTEPHstrain{i} = readtable([CTEPHstrain_res(i).folder,'/',CTEPHstrain_res(i).name]);
    CTEPHwork{i} = readtable([CTEPHwork_res(i).folder,'/',CTEPHwork_res(i).name]);
    CTEPHlids{i} = readtable([CTEPHlids_res(i).folder,'/',CTEPHlids_res(i).name]);
    CTEPHvols{i} = readtable([CTEPHvols_res(i).folder,'/',CTEPHvols_res(i).name]);
    [CTEPH_MWCT{i},CTEPH_ESRSCT{i},CTEPH_minRSCT{i}] = getPatientPerformance(CTEPHwork{i},CTEPHstrain{i},CTEPHvols{i},CTEPHlids{i},[]);
    [CTEPHStrain_percent(i,:),CTEPH_strain_profiles{i}] = getStrainProfiles(CTEPH_ESRSCT{i});
    [CTEPHWork_percent(i,:),CTEPH_work_profiles{i}] = getWorkProfiles(CTEPH_MWCT{i});
    [CTEPHPeakStrain_percent(i,:),CTEPH_peakstrain_profiles{i}] = getStrainProfiles(CTEPH_minRSCT{i});
    CTEPH_meanMWCT(i,:) = mean(CTEPH_MWCT{i});

    CTEPH_FWpts = readtable([CTEPH_FWpts_res(i).folder,'/',CTEPH_FWpts_res(i).name]);
    CTEPH_SWpts = readtable([CTEPH_SWpts_res(i).folder,'/',CTEPH_SWpts_res(i).name]);
    [~,rmv_FW{i},rmv_SW{i}] = intersect(table2array(TOF_FWpts),table2array(TOF_SWpts));
    
    [FWCTEPH_MWCT{i},FWCTEPH_ESRSCT{i},FWCTEPH_minRSCT{i}] = getPatientPerformance(CTEPHwork{i},CTEPHstrain{i},CTEPHvols{i},CTEPHlids{i},CTEPH_FWpts,rmv_FW{i});
    [FW_CTEPHStrain_percent(i,:),FWCTEPH_strain_profiles{i}] = getStrainProfiles(FWCTEPH_ESRSCT{i});
    [FW_CTEPHWork_percent(i,:),FWCTEPH_strain_profiles{i}] = getWorkProfiles(FWCTEPH_MWCT{i});
    [FWCTEPHPeakStrain_percent(i,:),FWCTEPH_peakstrain_profiles{i}] = getStrainProfiles(FWCTEPH_minRSCT{i});
    FWCTEPH_meanMWCT(i,:) = mean(FWCTEPH_MWCT{i});

    [SWCTEPH_MWCT{i},SWCTEPH_ESRSCT{i},SWCTEPH_minRSCT{i}] = getPatientPerformance(CTEPHwork{i},CTEPHstrain{i},CTEPHvols{i},CTEPHlids{i},CTEPH_SWpts,rmv_SW{i});
    [SW_CTEPHStrain_percent(i,:),SWCTEPH_strain_profiles{i}] = getStrainProfiles(SWCTEPH_ESRSCT{i});
    [SW_CTEPHWork_percent(i,:),SWCTEPH_work_profiles{i}] = getWorkProfiles(SWCTEPH_MWCT{i});
    [SWCTEPHPeakStrain_percent(i,:),SWCTEPH_peakstrain_profiles{i}] = getStrainProfiles(SWCTEPH_minRSCT{i});
    SWCTEPH_meanMWCT(i,:) = mean(SWCTEPH_MWCT{i});
end

HFstrain_res = natsortfiles(dir('data/RSCT_data/HF*'));%readtable('RSCT_data/HF3_RSCT.csv');
HFwork_res = natsortfiles(dir('data/MWCT_data/HF*'));
HFlids_res = natsortfiles(dir('data/lid_framepts/HF*'));
HFvols_res = natsortfiles(dir('data/RV_volumes/HF*'));
HF_FWpts_res = natsortfiles(dir('data/FW_framepts/HF*'));
HF_SWpts_res = natsortfiles(dir('data/SW_framepts/HF*'));

for i = 1:length(HFvols_res)
    name = HFstrain_res(i).name;
    rmvstr = strfind(name,'_');
    HFpatnames{i} = name(1:rmvstr-1);
    HFstrain{i} = readtable([HFstrain_res(i).folder,'/',HFstrain_res(i).name]);
    HFwork{i} = readtable([HFwork_res(i).folder,'/',HFwork_res(i).name]);
    HFlids{i} = readtable([HFlids_res(i).folder,'/',HFlids_res(i).name]);
    HFvols{i} = readtable([HFvols_res(i).folder,'/',HFvols_res(i).name]);
   [HF_MWCT{i},HF_ESRSCT{i},HF_minRSCT{i}] = getPatientPerformance(HFwork{i},HFstrain{i},HFvols{i},HFlids{i},[]);
    [HFStrain_percent(i,:),HF_strain_profiles{i}] = getStrainProfiles(HF_ESRSCT{i});
    [HFWork_percent(i,:),HF_work_profiles{i}] = getWorkProfiles(HF_MWCT{i});
    [HFPeakStrain_percent(i,:),HF_peakstrain_profiles{i}] = getStrainProfiles(HF_minRSCT{i});
    HF_meanMWCT(i,:) = mean(HF_MWCT{i});

    HF_FWpts = readtable([HF_FWpts_res(i).folder,'/',HF_FWpts_res(i).name]);
    HF_SWpts = readtable([HF_SWpts_res(i).folder,'/',HF_SWpts_res(i).name]);  
    [~,rmv_FW{i},rmv_SW{i}] = intersect(table2array(TOF_FWpts),table2array(TOF_SWpts));

    [FWHF_MWCT{i},FWHF_ESRSCT{i},FWHF_minRSCT{i}] = getPatientPerformance(HFwork{i},HFstrain{i},HFvols{i},HFlids{i},HF_FWpts,rmv_FW{i});
    [FW_HFStrain_percent(i,:),FWHF_strain_profiles{i}] = getStrainProfiles(FWHF_ESRSCT{i});
    [FW_HFWork_percent(i,:),FWHF_work_profiles{i}] = getWorkProfiles(FWHF_MWCT{i});
    [FWHFPeakStrain_percent(i,:),FWHF_peakstrain_profiles{i}] = getStrainProfiles(FWHF_minRSCT{i});
    FWHF_meanMWCT(i,:) = mean(FWHF_MWCT{i});

    [SWHF_MWCT{i},SWHF_ESRSCT{i},SWHF_minRSCT{i}] = getPatientPerformance(HFwork{i},HFstrain{i},HFvols{i},HFlids{i},HF_SWpts,rmv_SW{i});
    [SW_HFStrain_percent(i,:),SWHF_strain_profiles{i}] = getStrainProfiles(SWHF_ESRSCT{i});
    [SW_HFWork_percent(i,:),SWHF_work_profiles{i}] = getWorkProfiles(SWHF_MWCT{i});
    [SWHFPeakStrain_percent(i,:),SWHF_peakstrain_profiles{i}] = getStrainProfiles(SWHF_minRSCT{i});
    SWHF_meanMWCT(i,:) = mean(SWHF_MWCT{i});
end
save('rv_work_profile_data_generation.mat')