clear all; close all; clc;

cd 'C:\Users\user\Desktop\lab_1';

% ECG+ 60Hz noise
load example_ECG_RES;

x=1/Fs:1/Fs:length(data)/Fs;

[b, a]     = butter(5, 30/(Fs/2), 'low');
fdata      = filtfilt(b, a, data);

[b2, a2]     = butter(5, 0.5/(Fs/2), 'high');
fdata      = filtfilt(b2, a2, fdata);

figure;
plot(x, data); hold on;
plot(x, fdata); hold off;

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
ecg_peak = [];
for k=3:1:length(pi)
    tmp = fdata(pi(k)-round(Fs/20):pi(k));
    [ev, ei] = findpeaks(tmp);
    
    ecg_peak = [ecg_peak; ei+pi(k)-round(Fs/20)-1];
end

ecg_peak(end) = [];

figure;
plot(x, fdata); hold on; plot(ecg_peak./Fs, fdata(ecg_peak), 'ro--'); axis tight; 

%% EDR
figure;
% 사이사이 값을 채워서 그림
plot(ecg_peak./Fs, fdata(ecg_peak), 'ro--'); axis tight; title('edr');

t_i = [];
t_i = [1 ecg_peak' length(fdata)];% 피크는 제일처음나온위치가 1인덱스가 아님. 0초부터 0.725 까지는 데이터가 없음 따라서 40000개가 안나옴  뒤에도 보면 마지막위치가 199.28 부터 200사이에는 데이터가 없음. 따라서 200..?
% 따라서 200헤르츠 r peak정보를 40000개 정보로 보간할거임. 

peak_set = [];
peak_set = [mean(fdata(ecg_peak)) fdata(ecg_peak) mean(fdata(ecg_peak))];

t = [];
t = 1/Fs:1/Fs:length(fdata)/Fs; % 1에서 length >> 시간으로 >> /fs
% 200분의 1초 가 첫번째 데이터
% interpolation rpeak으,ㅣ 위치, 값을 t로 보간해라
EDR_INTP   =  interp1(t_i, peak_set, t, 'PCHIP');


figure;
subplot(211); plot(t_i, peak_set); axis tight; title('edr');
subplot(212); plot(t, EDR_INTP); axis tight; title('intp edr');

% filtering
[b, a]     = butter(5, 0.5/(Fs/2), 'low');
fEDR_INTP      = filtfilt(b, a, EDR_INTP);

[b2, a2]     = butter(5, 0.15/(Fs/2), 'high');
fEDR_INTP      = filtfilt(b2, a2, fEDR_INTP);

figure;
subplot(211); plot(t, EDR_INTP); axis tight; 
subplot(212); plot(t, fEDR_INTP); axis tight;


%% RSA
rri = diff(ecg_peak)./Fs;
r_i = ecg_peak(1:end-1);

figure;
plot(r_i./Fs, rri, 'ro--'); axis tight; title('rri');

t_i = [];
t_i = [1 r_i' length(fdata)];
t_i = t_i./Fs;

rri_set = [];
rri_set = [mean(rri) rri' mean(rri)];

t = [];
t = 1/Fs:1/Fs:length(fdata)/Fs;

% interpolation
RSA_INTP   =  interp1(t_i, rri_set, t, 'PCHIP');


figure;
subplot(211); plot(r_i./Fs, rri); axis tight; title('rsa');
subplot(212); plot(t, RSA_INTP); axis tight; title('intp rsa');


[b, a]     = butter(5, 0.5/(Fs/2), 'low');
fRSA_INTP      = filtfilt(b, a, RSA_INTP);

[b2, a2]     = butter(5, 0.15/(Fs/2), 'high');
fRSA_INTP      = filtfilt(b2, a2, fRSA_INTP);

figure;
subplot(211); plot(t, RSA_INTP); axis tight; 
subplot(212); plot(t, fRSA_INTP); axis tight;


figure;
subplot(211); plot(t, fEDR_INTP); axis tight; 
subplot(212); plot(t, fRSA_INTP); axis tight;

figure;
plot(t, fEDR_INTP); hold on;  plot(t, fRSA_INTP*10000); axis tight;