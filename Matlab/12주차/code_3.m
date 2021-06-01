clear all; close all; clc;

cd 'C:\Users\user\Desktop\data_mining\12주차'

TR_SET   = [];
TR_LABEL = [];

% for tr
for subj = 1:1:4
    file_name = ['ECG_PEAK' num2str(subj) '.mat'];
    load(file_name);
    
    file_name = ['sleep_score_' num2str(subj) '.mat'];
    load(file_name);
    % stg가 7인거 (램수면인거) 에는 2를 집어넣고 아닌거는 1로 만듬.
    r_nr_stg = ones(length(stg), 1);
    idx = find(stg == 7);
    r_nr_stg(idx, 1) = 2;
    
    
    HRV_SET = zeros(length(stg), 10);
    
    for k=1:1:length(stg)
        idx     = find(rpeak_i > (k-1)*fs*30+1 & rpeak_i <= (k)*fs*30);
        t_rpeak = rpeak_i(idx);
        
        %SDNN, RMSSD, pNN50, M_HR 를 HRVSET에 한방에 집어넣음.
        [HRV_SET(k, 1), HRV_SET(k, 2), HRV_SET(k, 3), HRV_SET(k, 4)]  =  TD_HRV(fs, t_rpeak);
    end
    
    % 주파수 도메인 HRV분석
    for k=1:1:length(stg)-9
        [subj k]; % 코드 잘돌아가는지 확인할라고 넣어주넛
        idx     = find(rpeak_i > (k-1)*fs*30+1 & rpeak_i <= (k+9)*fs*30);
        t_rpeak = rpeak_i(idx);
        
        % LF, HF, TF, VLF, nLF, nHF, LFHF.     nHF and nLF are mathmetically equal
        % 1~9번까지ㅡㄴ 값이 없음 0으로 채워져있을것 > 수면판단 불가능
        [HRV_SET(k+9, 5), HRV_SET(k+9, 6), HRV_SET(k+9, 7), HRV_SET(k+9, 8), HRV_SET(k+9, 9), ~, HRV_SET(k+9, 10)] = FD_HRV(fs, t_rpeak);     
    end
    
    % 값 확인 , 3개다 값범위가 겁나 다를것. scale이 다다름
    % 4 > mean_hr, 8> vlf , 10 > lf  그래프를 그려보면 값범위가 많이다름.
    %figure;
    %subplot(311); plot(HRV_SET(:,4));axis tight;
    %subplot(312); plot(HRV_SET(:,8));axis tight;
    %subplot(313); plot(HRV_SET(:,10));axis tight;
    
 
    tHRV_SET  = HRV_SET(10:end,:);
    tr_nr_stg = r_nr_stg(10:end, :);
    
    [r, c] = size(HRV_SET);
    % feature normalize : scale이 다 다른 값을 norm해준것. 
    % 평균빼고 표준편차로 나눠줌.
    for k=1:1:c
        tHRV_SET(:,k) = smooth(tHRV_SET(:,k),50,'moving'); % 아래 결과분석 문제 해결법 300으로도 한번해보기
        tHRV_SET(:,k) = (tHRV_SET(:,k) - mean(tHRV_SET(:,k)))/std(tHRV_SET(:,k));
    end
    %여기서 그림 다시그려보면 스케일이 맞춰진걸 볼 수 있음.
    % 요 4개는 train
    TR_SET   = [TR_SET; tHRV_SET];
    TR_LABEL = [TR_LABEL; tr_nr_stg];
end

% feature 하나하나 확인해보기 , 결과분석 > traindata확인
% 첫번째 데이터에서 전반적으로 증가하는거 알겠는데 논램에서의 값이나 램에서의 값이나 차이가별로없음
% 로우데이터 바로집어넣었더니 이런문제가 발생한것. > 1. smooth로 해결 2. 램일때 아닐때 높이차에 균일?성이 없음 > 엄청큰
% 스무딩 300정도로 해서 빼내면 크게 울렁이는 트렌드가 빠져버림 이런식으로 처리를 하는 것.
%moving말고 rloess라는 방법등 여러개가 있음
%figure;
%subplot(311); plot(HRV_SET(:,4));hold; plot(smooth(HRV_SET(:,4),300,'moving')); axis tight; % > ;hold; plot(smooth(HRV_SET(:,4),50,'moving');axis tight;추가
%subplot(312); plot(HRV_SET(:,10));hold; plot(smooth(HRV_SET(:,4),300,'moving')); axis tight;
%subplot(313); plot(stg);axis tight;


% 여기부턴 5번에대한 test만들기 (과정은 train과 같음)
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
        tHRV_SET(:,k) = smooth(tHRV_SET(:,k),50,'moving');
        tHRV_SET(:,k) = (tHRV_SET(:,k) - mean(tHRV_SET(:,k)))/std(tHRV_SET(:,k));
    end
    
    TS_SET   = [TS_SET; tHRV_SET];
    TS_LABEL = [TS_LABEL; tr_nr_stg];
end



%% 
% kNN 하이퍼파라미터 자동화하는 함수사용 
rng(1)
Mdl = fitcknn(TR_SET, TR_LABEL,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',...
    struct('AcquisitionFunctionName','expected-improvement-plus', 'Kfold', 10))

label = predict(Mdl,TS_SET);
% multi_kappa는 교수님이 따로 만드신 함수임. table은 confision 매트릭스
% 일치도볼때  카파값을 많이본다.> 0.6~0.7 나오면 베스트일것. (어그리먼트는 잘 보지않음 > 모든수면단계를 논램수면이라 하면 어그리먼트는 최소 80은 나옴 따라서 값에 의미가없음)
% agreement가 높으면서 kappa가 높아야함. 
[result, table]=multi_kappa(TS_LABEL, label, [1, 2]);

figure;
% 레이블끼리 비교 (label이 pred, 밑에가 실제(정답)
subplot(211); bar(label); axis tight;
subplot(212); bar(TS_LABEL); axis tight;

%% naive baysian
% 하이퍼파라미터 옵티마이즈하는거 사용예제
% 결과가 안좋음 > 무조건 자동화가 아니라 하나한하ㅏ면서 확인할 ㅣㄹ요도 있음.
% 또 사전확률을 고려할 수 있음.
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

% linear 판별분석 사용예제
% 자동화코드
rng(1)

Mdl = fitcdiscr(TR_SET, TR_LABEL,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',...
    struct('AcquisitionFunctionName','expected-improvement-plus'))

label = predict(Mdl,TS_SET) 

[result, table]=multi_kappa(TS_LABEL, label, [1, 2])

figure;
subplot(211); bar(label); axis tight;
subplot(212); bar(TS_LABEL); axis tight;

% 나이브베이즈 하이퍼파라미터 지정 qua방법.
% 분석점 1 : linear는 하나도 안맞았는데 qua는 왜맞을까? > qua가 잘맞는 ,이렇게되려면 linear도 사실 잘맞아야함. 
% 하이퍼파라미터를 조정하는데 문제가생기는거구나를 인지 > 자동화하면안되는구나
% 분석점 2 : 사전확률을 이용해보자
rng(1)
Mdl = fitcdiscr(TR_SET, TR_LABEL, 'DiscrimType', 'quadratic');

label = predict(Mdl,TS_SET) 

[result, table]=multi_kappa(TS_LABEL, label, [1, 2])

figure;
subplot(211); bar(label); axis tight;
subplot(212); bar(TS_LABEL); axis tight;

% 사전확률 지정.나이브베이즈
prior = [0.8,0.2]%[0.8 0.2]; % 0.9,0.1 이거 조정하면서 하면 카파좀 올라감 0.9 0.1 일때가 제일높음 
Mdl = fitcnb(TR_SET, TR_LABEL,'ClassNames',[1, 2],'Prior',prior)

label = predict(Mdl,TS_SET) 

[result, table]=multi_kappa(TS_LABEL, label, [1, 2])

figure;
subplot(211); bar(label); axis tight;
subplot(212); bar(TS_LABEL); axis tight;


% 우리가 만든 feature가 얼마나 어떻게이상하길래 이상한데서 feature를 찾는것인가를 봐야함.
% app > 분류학습기 > 새세션 > 입력데이터 TR_SET >응답변수 TR_label
% 1번2번 구분을 못하고있음. 4번과 10번 > 잘모르겠음...
% 빠른훈련 ,,,, 우리는 카파값을 보고싶은데 정확도만 보여줌 
% 훈련의 방향성이 컨퓨전매트릭스 , 우리는 모든단계를 논램수면이라해도 정확도가 85%가 나오는것,,, 정답을 맞추느니 모든걸
% 논램이라고 하는게 최적이라고 판단하고 훈련된것,,,
% 다시 원점으로돌아와서 우리는 feature의 모습을 확인해봐야함! 