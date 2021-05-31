clear all; close all; clc;

cd 'C:\Users\user\Desktop\data_mining\8주차';

load Sleep_score
load ECG_PEAK;

Fs=fs;
r_peak=rpeak_i;

figure;
subplot(211); plot(interval); axis tight;
subplot(212); plot(stg); axis tight;
%% time domain HRV (once in 30s)
epoch = 30;
len_td = length(data)/epoch/Fs;

SDNN  = zeros(1, len_td);
RMSSD = zeros(1, len_td);
pNN50 = zeros(1, len_td);
M_HR  = zeros(1, len_td);

for k=1:1:len_td
    idx = find(r_peak >= (k-1)*Fs*epoch+1 & r_peak <= k*epoch*Fs);
    t_rpeak = r_peak(idx);
    
    [SDNN(k), RMSSD(k), pNN50(k), M_HR(k)] = Time_HRV(t_rpeak, Fs);
    
    RRI=diff(t_rpeak)/Fs;
    RRI(end+1)=RRI(end-1);
    %t_rpeak(end) = []; or %t_rpeak(1) = [];

    % Time domain
    SDNN(k) = std(RRI)*1000;
    RMSSD(k) = sqrt(mean(diff(RRI).^2))*1000;

    dRRI = diff(RRI);
    NN50 = find(dRRI>0.05); % 50ms
    pNN50(k) = (length(NN50)/length(dRRI))*100;

    HR  =  60./RRI;
    M_HR(k) = mean(HR);
end

figure;
%plot(pNN50); 
%subplot(211);plot(M_HR);hold on; plot(smooth(M_HR,30,'moving')); axis tight;
subplot(211);plot(SDNN);hold on; plot(smooth(M_HR,30,'moving')); axis tight;
subplot(212);plot(stg); axis tight;
% 두 독립된 그룹에 대한 비교분석
% 램수면에서의 HR과 깊은수면에서의 HR 에서 통계적으로 유의한 차이가 나는가. -> stg에서 수면단계에 해당하는 인덱스값을
% 가져외야댐
idx_r = find(stg == 7); % 램수면에 해당하는 인덱스를 모두가져옴
idx_d = find(stg ==3 | stg == 2); % 깊은수면
idx_w = find(stg == 6); % 얕은수면

HR_r(:,1) = M_HR(idx_r)'; % 램수면에 해당하는 mean hr만 가져와라 > 행벡터로되어있음 메트랩에서는 열벡터로 들어가야함 따라서 '로 transpose
HR_r(:,2) = ones(length(HR_r),1); % 램수면은 일관적으로 1

HR_d(:,1) = M_HR(idx_d)';
HR_d(:,2) = 2*ones(length(HR_d),1); % 딥수면은 2

HR_w(:,1) = M_HR(idx_w)';
HR_w(:,2) = 3*ones(length(HR_w),1); % 위크는 3 >> 이따아노바분석할때 그룹인덱스가 필요하기떄문에 넣은것

%h=1 > 귀무가설 기각시켰다는 것 p가 0.05보다 작으면 통계적으로 유의한차이가 있다는 뜻. 
[h,p] = ttest2(HR_r(:,1),HR_d(:,1)); % 깊 과 램의 평균차이가 나는가 >> ttest라는 함수 우린 그룹이 2개니까 2

% 세개그룹 램, 깊은, 꺰 
SET=[];
SET=[HR_r(:,1); HR_d(:,1); HR_w(:,1)];
GP=[HR_r(:,2); HR_d(:,2); HR_w(:,2)];
% anobatab : f 값, st : 이를 이용해 다중 비교검정가능
[P,Anobatab,st]=anova1(SET,GP,'off');% 1이 일원분산분석 아노바는 겨ㅕㄹ과가 세개그룹내에 차이가보이는 그룹이 존재한다 만이 결과임. 따라서 어떤그룹사이에 차이를보이는지는 모름 > 사후분석을 통해서,  off는 그림그리지말라는거
% 사후분석 도움말 참조 > 유으ㅐ수준 5퍼센트 , 씨타입은 본페르니로하겠다 : 개별비교시 방법중하나 
[c,m,h,gnames]=multcompare(st,'alpha',0.05,'ctype','bonferroni'); 
% c에서 95%신뢰구간 min|평균차이정도|max|p_value
%% frequency domain (once in 30s, window size: 300s, sliding window)

epoch = 30;
len_fd = (length(data)/epoch/Fs);

LF  =  zeros(1, len_fd);
HF  =   zeros(1, len_fd);
TF  =   zeros(1, len_fd);
VLF =   zeros(1, len_fd);

nLF =  zeros(1, len_fd);
nHF =  zeros(1, len_fd);
LFHF =  zeros(1, len_fd);

for k=1:1:len_fd-9
    idx = find(r_peak >= (k-1)*Fs*epoch+1 & r_peak <= (k+9)*epoch*Fs);
    t_rpeak = r_peak(idx);
    
    RRI  =  diff(t_rpeak)/Fs;
    RRI(end+1)  =  RRI(end-1);
    %t_rpeak(end) = []; or %t_rpeak(1) = []; 둘중하나만 하면됨 

    %Frequency domain
    t_i =  t_rpeak/Fs;
    t   =  t_rpeak(1)/Fs:1/Fs:t_rpeak(end)/Fs;
    % t   =  t_rpeak(1)/Fs:1/4:t_rpeak(end)/Fs; for 4Hz interpolation
    

    RRI_INTERPOL = interp1(t_i, RRI, t, 'PCHIP');

    [p, f]=periodogram(RRI_INTERPOL,[],length(RRI_INTERPOL), Fs);
    %[p, f]=periodogram(RRI_INTERPOL,[],length(RRI_INTERPOL), 4);for 4Hz 

    vlf_1 = 2;
    vlf_2 = length(find(f < 0.04));
    
    lf_1 = vlf_2+1;
    lf_2 = length(find(f < 0.15));
    
    hf_1 = lf_2+1;
    hf_2 = length(find(f < 0.4));

    LF(k+9)  =  simpson_int(p(lf_1:lf_2), f(2))*1e6; %(f,res)
    HF(k+9)  =  simpson_int(p(hf_1:hf_2), f(2))*1e6;
    TF(k+9)  =  simpson_int(p(2:hf_2), f(2))*1e6;
    VLF(k+9) =  TF(k+9)-(LF(k+9) + HF(k+9));

    nLF(k+9) = LF(k+9)./(LF(k+9) + HF(k+9));
    nHF(k+9) = HF(k+9)./(LF(k+9) + HF(k+9));
    LFHF(k+9) = LF(k+9)./HF(k+9);
end

figure;
%plot(LFHF);
subplot(211);plot(nHF);hold on;  axis tight;
subplot(212);plot(stg); axis tight;
% stg불러올때 1번부터 10번까지는 뺴고 분석해야함.
idx_r = find(stg == 7); % 램수면에 해당하는 인덱스를 모두가져옴
idx_d = find(stg ==3 | stg == 2); % 깊은수면
idx_w = find(stg == 6); % 얕은수면

% stage <10 삭제
bool_r= idx_r >10;
bool_d= idx_d >10;
bool_w= idx_w>10;

idx_r=idx_r(bool_r);
idx_d=idx_d(bool_d);
idx_w=idx_w(bool_w);

LFHF_r(:,1) = LFHF(idx_r)'; % 램수면에 해당하는 mean hr만 가져와라 > 행벡터로되어있음 메트랩에서는 열벡터로 들어가야함 따라서 '로 transpose
LFHF_r(:,2) = ones(length(LFHF_r),1); % 램수면은 일관적으로 1

LFHF_d(:,1) = nHF(idx_d)';
LFHF_d(:,2) = 2*ones(length(LFHF_d),1); % 딥수면은 2

LFHF_w(:,1) = nHF(idx_w)';
LFHF_w(:,2) = 3*ones(length(LFHF_w),1); % 위크는 3 >> 이따아노바분석할때 그룹인덱스가 필요하기떄문에 넣은것

%h=1 > 귀무가설 기각시켰다는 것 p가 0.05보다 작으면 통계적으로 유의한차이가 있다는 뜻. 
[hh,hp] = ttest2(LFHF_r(:,1),LFHF_d(:,1)); % 깊 과 램의 평균차이가 나는가 >> ttest라는 함수 우린 그룹이 2개니까 2

% 세개그룹 램, 깊은, 꺰 
SET=[];
SET=[LFHF_r(:,1); LFHF_d(:,1); LFHF_w(:,1)];
GP=[LFHF_r(:,2); LFHF_d(:,2); LFHF_w(:,2)];
% anobatab : f 값, st : 이를 이용해 다중 비교검정가능
[P,Anobatab,st]=anova1(SET,GP,'off');% 1이 일원분산분석 아노바는 겨ㅕㄹ과가 세개그룹내에 차이가보이는 그룹이 존재한다 만이 결과임. 따라서 어떤그룹사이에 차이를보이는지는 모름 > 사후분석을 통해서,  off는 그림그리지말라는거
% 사후분석 도움말 참조 > 유으ㅐ수준 5퍼센트 , 씨타입은 본페르니로하겠다 : 개별비교시 방법중하나 
[c,m,h,gnames]=multcompare(st,'alpha',0.05,'ctype','bonferroni'); 
