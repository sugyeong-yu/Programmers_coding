clear all; close all; clc;

cd 'D:\상명대학교\수업\2021_1\데이터마이닝\코드\lab_5'

TR_SET   = [];
TR_LABEL = [];

% for tr
for subj = 1:1:4
    file_name = ['ECG_PEAK' num2str(subj) '.mat'];
    load(file_name);
    
    file_name = ['sleep_score_' num2str(subj) '.mat'];
    load(file_name);
    
    r_nr_stg = ones(length(stg), 1);
    idx = find(stg == 7);
    r_nr_stg(idx, 1) = 2;
    
    
    HRV_SET = zeros(length(stg), 10);
    
    for k=1:1:length(stg)
        idx     = find(rpeak_i > (k-1)*fs*30+1 & rpeak_i <= (k)*fs*30);
        t_rpeak = rpeak_i(idx);
        
        %SDNN, RMSSD, pNN50, M_HR
        [HRV_SET(k, 1), HRV_SET(k, 2), HRV_SET(k, 3), HRV_SET(k, 4)]  =  TD_HRV(fs, t_rpeak);
    end
    
    for k=1:1:length(stg)-9
        [subj k]
        idx     = find(rpeak_i > (k-1)*fs*30+1 & rpeak_i <= (k+9)*fs*30);
        t_rpeak = rpeak_i(idx);
        
        % LF, HF, TF, VLF, nLF, nHF, LFHF.     nHF and nLF are mathmetically equal
        [HRV_SET(k+9, 5), HRV_SET(k+9, 6), HRV_SET(k+9, 7), HRV_SET(k+9, 8), HRV_SET(k+9, 9), ~, HRV_SET(k+9, 10)] = FD_HRV(fs, t_rpeak);     
    end
    
    tHRV_SET  = HRV_SET(10:end,:);
    tr_nr_stg = r_nr_stg(10:end, :);
    
    [r, c] = size(HRV_SET);
    for k=1:1:c
        tHRV_SET(:,k) = (tHRV_SET(:,k) - mean(tHRV_SET(:,k)))/std(tHRV_SET(:,k));
    end
 
    TR_SET   = [TR_SET; tHRV_SET];
    TR_LABEL = [TR_LABEL; tr_nr_stg];
end



TS_SET   = [];
TS_LABEL = [];

% for ts
for subj = 5:1:5
    file_name = ['ECG_PEAK' num2str(subj) '.mat'];
    load(file_name);
    
    file_name = ['sleep_score_' num2str(subj) '.mat'];
    load(file_name);
    
    r_nr_stg = ones(length(stg), 1);
    idx = find(stg == 7);
    r_nr_stg(idx, 1) = 2;
    
    
    HRV_SET = zeros(length(stg), 10);
    
    for k=1:1:length(stg)
        idx     = find(rpeak_i > (k-1)*fs*30+1 & rpeak_i <= (k)*fs*30);
        t_rpeak = rpeak_i(idx);
        
        %SDNN, RMSSD, pNN50, M_HR
        [HRV_SET(k, 1), HRV_SET(k, 2), HRV_SET(k, 3), HRV_SET(k, 4)]  =  TD_HRV(fs, t_rpeak);
    end
    
    for k=1:1:length(stg)-9
        [subj k]
        idx     = find(rpeak_i > (k-1)*fs*30+1 & rpeak_i <= (k+9)*fs*30);
        t_rpeak = rpeak_i(idx);
        
        % LF, HF, TF, VLF, nLF, nHF, LFHF.     nHF and nLF are mathmetically equal
        [HRV_SET(k+9, 5), HRV_SET(k+9, 6), HRV_SET(k+9, 7), HRV_SET(k+9, 8), HRV_SET(k+9, 9), ~, HRV_SET(k+9, 10)] = FD_HRV(fs, t_rpeak);     
    end
    
    
    tHRV_SET  = HRV_SET(10:end,:);
    tr_nr_stg = r_nr_stg(10:end, :);
    
    [r, c] = size(HRV_SET);
    for k=1:1:c
        tHRV_SET(:,k) = (tHRV_SET(:,k) - mean(tHRV_SET(:,k)))/std(tHRV_SET(:,k));
    end
        
    TS_SET   = [TS_SET; tHRV_SET];
    TS_LABEL = [TS_LABEL; tr_nr_stg];
end



%% kNN
rng(1)
Mdl = fitcknn(TR_SET, TR_LABEL,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',...
    struct('AcquisitionFunctionName','expected-improvement-plus', 'Kfold', 10))

label = predict(Mdl,TS_SET);

[result, table]=multi_kappa(TS_LABEL, label, [1, 2])

figure;
subplot(211); bar(label); axis tight;
subplot(212); bar(TS_LABEL); axis tight;

%% naive baysian
rng(1)
Mdl = fitcnb(TR_SET, TR_LABEL,'ClassNames',[1, 2],'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    'expected-improvement-plus', 'Kfold', 10))

% Mdl = fitcnb(TR_SET, TR_LABEL)

label = predict(Mdl,TS_SET) 

[result, table]=multi_kappa(TS_LABEL, label, [1, 2])

figure;
subplot(211); bar(label); axis tight;
subplot(212); bar(TS_LABEL); axis tight;


rng(1)
Mdl = fitcdiscr(TR_SET, TR_LABEL,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',...
    struct('AcquisitionFunctionName','expected-improvement-plus'))

label = predict(Mdl,TS_SET) 

[result, table]=multi_kappa(TS_LABEL, label, [1, 2])

figure;
subplot(211); bar(label); axis tight;
subplot(212); bar(TS_LABEL); axis tight;

rng(1)
Mdl = fitcdiscr(TR_SET, TR_LABEL, 'DiscrimType', 'quadratic');

label = predict(Mdl,TS_SET) 

[result, table]=multi_kappa(TS_LABEL, label, [1, 2])

figure;
subplot(211); bar(label); axis tight;
subplot(212); bar(TS_LABEL); axis tight;

prior = [0.9 0.1];
Mdl = fitcnb(TR_SET, TR_LABEL,'ClassNames',[1, 2],'Prior',prior)

label = predict(Mdl,TS_SET) 

[result, table]=multi_kappa(TS_LABEL, label, [1, 2])

figure;
subplot(211); bar(label); axis tight;
subplot(212); bar(TS_LABEL); axis tight;
