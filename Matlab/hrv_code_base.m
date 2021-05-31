clear all; close all; clc;

cd 'C:\Users\user\Desktop\data_mining\8주차';

load Sleep_score;
load ECG_PEAK;
load test_ECG_2;
x=1/Fs:1/Fs:length(data)/Fs;

[b, a]     = butter(5, 30/(Fs/2), 'low'); % 30hz low pass
fdata      = filtfilt(b, a, data);

[b2, a2]     = butter(5, 3/(Fs/2), 'high');%3hz high pass
fdata      = filtfilt(b2, a2, fdata);

%%
% 미분
dif_data = diff(fdata); 

% 절대값
abs_data = abs(dif_data);

%이동평균
mva_data = smooth(abs_data, 0.3*Fs, 'moving');
mva_data = smooth(mva_data, 0.3*Fs, 'moving');

% 피크 찾기
[pv, pi] = findpeaks(mva_data);


% 최종 피크 찾기
r_peak = [];
for k=3:1:length(pi)
    tmp = fdata(pi(k)-round(Fs/20):pi(k));
    [ev, ei] = findpeaks(tmp);
    
    r_peak = [r_peak; ei+pi(k)-round(Fs/20)-1];
end

rri = diff(r_peak)./Fs;

figure;
plot(r_peak(1:end-1)./Fs, rri,'ro'); %ro하면 빨간색 동그라미로 찍힘 o--하면 동그라미점에 점선으로이은거 나옴

%% time domain HRV (once in 30s)
epoch = 30;
len_td = length(fdata)/epoch/Fs;

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
plot(pNN50); 

%% frequency domain (once in 30s, window size: 300s, sliding window)

epoch = 30;
len_fd = (length(fdata)/epoch/Fs);

LF  =  zeros(1, len_fd);
HF  =   zeros(1, len_fd);
TF  =   zeros(1, len_fd);
VLF =   zeros(1, len_fd);

nLF =  zeros(1, len_fd);
nHF =  zeros(1, len_fd);
LFHF =  zeros(1, len_fd);

for k=1:1:len_fd-9
    idx = find(r_peak >= (k-1)*Fs*epoch+1 & r_peak <= (k+9)*epoch*Fs);
    t_rpeak = r_peak(idx); % shift 구간안에있는 rpeak만 가져오기
    
    RRI  =  diff(t_rpeak)/Fs;
    RRI(end+1)  =  RRI(end-1);
    %t_rpeak(end) = []; or %t_rpeak(1) = []; 둘중하나만 하면됨 

    %Frequency domain
    t_i =  t_rpeak/Fs;
    t   =  t_rpeak(1)/Fs:1/Fs:t_rpeak(end)/Fs; % 1/fs 간격으로 데이터를 모두 만들겠다.
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

    LF(k+9)  =  simpson_int(p(lf_1:lf_2), f(2))*1e6;
    HF(k+9)  =  simpson_int(p(hf_1:hf_2), f(2))*1e6;
    TF(k+9)  =  simpson_int(p(2:hf_2), f(2))*1e6;
    VLF(k+9) =  TF(k+9)-(LF(k+9) + HF(k+9));

    nLF(k+9) = LF(k+9)./(LF(k+9) + HF(k+9));
    nHF(k+9) = HF(k+9)./(LF(k+9) + HF(k+9));
    LFHF(k+9) = LF(k+9)./HF(k+9);
end

figure;
plot(LFHF);


