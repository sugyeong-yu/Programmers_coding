clear all; close all; clc;

cd 'D:\상명대학교\수업\2021_1\데이터마이닝\코드\lab_7'

TR_SET   = {};
TR_LABEL = {};

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
    
    HRV_SET(:,2) = -HRV_SET(:,2);
    HRV_SET(:,3) = -HRV_SET(:,3);
    HRV_SET(:,6) = -HRV_SET(:,6);
    
    tHRV_SET  = HRV_SET(10:end,:);
    tr_nr_stg = r_nr_stg(10:end, :);
    
    [r, c] = size(HRV_SET);
    for k=1:1:c
        tHRV_SET(:,k) = (tHRV_SET(:,k) - mean(tHRV_SET(:,k)))/std(tHRV_SET(:,k));
    end
 
    TR_SET{subj}   = tHRV_SET;
    TR_LABEL{subj} = tr_nr_stg;
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
    
    HRV_SET(:,2) = -HRV_SET(:,2);
    HRV_SET(:,3) = -HRV_SET(:,3);
    HRV_SET(:,6) = -HRV_SET(:,6);
    
    
    tHRV_SET  = HRV_SET(10:end,:);
    tr_nr_stg = r_nr_stg(10:end, :);
    
    [r, c] = size(HRV_SET);
    for k=1:1:c
        tHRV_SET(:,k) = (tHRV_SET(:,k) - mean(tHRV_SET(:,k)))/std(tHRV_SET(:,k));
    end
    
    TS_SET   = tHRV_SET;
    TS_LABEL = tr_nr_stg;

end
%%
close all; figure;
subplot(611); plot(smooth(TR_SET{3}(:,1), 100, 'moving')); axis tight;
subplot(612); plot(smooth(TR_SET{3}(:,2), 100, 'moving')); axis tight;
subplot(613); plot(smooth(TR_SET{3}(:,3), 100, 'moving')); axis tight;
subplot(614); plot(smooth(TR_SET{3}(:,4), 100, 'moving')); axis tight;
subplot(615); plot(smooth(TR_SET{3}(:,5), 100, 'moving')); axis tight;
subplot(616); bar(TR_LABEL{3}); axis tight;
figure;
subplot(611); plot(smooth(TR_SET{3}(:,6), 100, 'moving')); axis tight;
subplot(612); plot(smooth(TR_SET{3}(:,7), 100, 'moving')); axis tight;
subplot(613); plot(smooth(TR_SET{3}(:,8), 100, 'moving')); axis tight;
subplot(614); plot(smooth(TR_SET{3}(:,9), 100, 'moving')); axis tight;
subplot(615); plot(smooth(TR_SET{3}(:,10), 100, 'moving')); axis tight;
subplot(616); bar(TR_LABEL{3}); axis tight;
%%
comb = nchoosek(1:1:10, 4);
RES_OUT = zeros(4, length(comb));

for subj = 1:1:4
    Feature  =  TR_SET{subj};
    LABEL    = TR_LABEL{subj};
    
    for k=1:1:length(comb)
        [subj k]
        REM_FEATURE   =  Feature(:,comb(k,:));
        [nSET_PARAM]  =  HN_DATA_VECTOR_NORMALIZATION(REM_FEATURE);
        [~,SCORE,~, ~, ~, ~]     =  pca(nSET_PARAM);
        
        F_REM_TREND        =   smooth(SCORE(:, 1), 100, 'moving');%rloess
        
        F_REM_TREND        =   (F_REM_TREND-mean(F_REM_TREND))/std(F_REM_TREND);
        [b, a]             =   butter(5, 2/(length(F_REM_TREND)/2), 'low');
        TH_B               =   filtfilt(b, a, F_REM_TREND)+0.6;
        
        EST_REM            =  ones(1, length(LABEL));
        
        idx                =   find(F_REM_TREND >=TH_B);
        EST_REM(idx)       =   2;
        
        % heuristic
        EST_REM(1:80)      =  1;

        [re1, re2]        =  multi_kappa(EST_REM, LABEL, [1 2]);
    
        RES_OUT(subj, k) = re1.kappa;
    end
end

m_RES_OUT = mean(RES_OUT);
[mv, mi] = max(m_RES_OUT)

comb(mi,:)

%%
Feature  =  TS_SET;
LABEL    =  TS_LABEL;

REM_FEATURE   =  Feature(:,comb(mi,:));
[nSET_PARAM]  =  HN_DATA_VECTOR_NORMALIZATION(REM_FEATURE);
[~,SCORE,~, ~, ~, ~]     =  pca(nSET_PARAM);

F_REM_TREND        =   smooth(SCORE(:, 1), 100, 'moving');%rloess

F_REM_TREND        =   (F_REM_TREND-mean(F_REM_TREND))/std(F_REM_TREND);
[b, a]             =   butter(5, 2/(length(F_REM_TREND)/2), 'low');
TH_B               =   filtfilt(b, a, F_REM_TREND)+0.6;

EST_REM            =  ones(1, length(LABEL));

idx                =   find(F_REM_TREND >=TH_B);
EST_REM(idx)       =   2;

% heuristic
EST_REM(1:80)      =  1;

[re1, re2]        =  multi_kappa(EST_REM, LABEL, [1 2])

figure;
subplot(211); bar(EST_REM); axis tight;
subplot(212); bar(LABEL); axis tight;

