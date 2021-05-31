clear all; close all; clc;

cd 'C:\Users\user\Desktop\lab_1';
% 60초부터 숨을 천천히 쉬었음.
% 초로 나올꺼고 60으로 나눠주면 bpm나올것.
% 호흡과 피크 정보 불러오기 

load('RESP_PEAK.mat');

x = 1/fs:1/fs:length(data)/fs;

[b, a]     = butter(5, 0.5/(fs/2), 'low');
fdata      = filtfilt(b, a, data);

figure;
subplot(211); plot(x, data); hold on; plot(rpeak_i./fs, data(rpeak_i), 'ro');  axis tight; title('raw'); 
subplot(212); plot(x, fdata); axis tight; title('filtered'); xlabel('time (s)'); ylabel('amplitude(v)');

%%
% 1. 피크 간격
% 피크의 위치의 차를 구한담에 fs로 나누면 시간이 됨. (timedomain)
bri = diff(rpeak_i)./fs;
bri_60 = 60./bri;
% 60으로 나눠줘서 bpm이 됨.

figure;
subplot(211); plot(rpeak_i(1:end-1)./fs, bri, 'ro--'); axis tight; ylabel('sec');
subplot(212); plot(rpeak_i(1:end-1)./fs, bri_60, 'ro--'); axis tight; xlabel('time(s)');  ylabel('bpm');


% 2. 주파수 분석
% 60초 이후 데이터에 대해서 주파수분석을 해볼것.
tmp_data = fdata(60*fs+1:end);
x_ = 1/fs:1/fs:length(tmp_data)/fs;

figure;
plot(x_, tmp_data); axis tight; xlabel('time(s)');
%주파수분석, 주파수 크기가 나오게됨.
[pxx, f] = periodogram(tmp_data, [], length(tmp_data), fs);

figure;
plot(f, pxx); axis tight; xlim([0.15 0.5]); xlabel('frequency(Hz)');
% 호흡에 영향이 가장클것 따라서 가장큰 주파수는 호흡정보를 가지고있을것

% 주파수가 0.15부터 0.5인 거만 찾음. 
% f랑 pxx를 비교해보면 0 hz의 크기값은 0.13~~
% 우리는 관심헤르츠정보만 보면되는 것.
t_idx = find(f>=0.15 & f <= 0.5);
[mv, mi] = max(pxx(t_idx)); % 가장크기가 큰 헤르츠를 가져옴

br_freq = f(t_idx(mi));
m_br = 1/br_freq
m_br_60 = 60/m_br

% 3. 힐버트 변환
Hilbert_resp     =  hilbert(fdata);
Imag_data        =  imag(Hilbert_resp);

% real은 원래신호랑 똑같을 거고 hibert는 2/파이 만큼 시프크시킨 신호가나옴
figure;
subplot(211); plot(x, fdata); axis tight;
subplot(212); plot(x, real(Hilbert_resp)); hold on;  plot(x, imag(Hilbert_resp));axis tight; xlabel('time(s)');
% 위상 구하는 코드
CHES_phase      =   unwrap(angle(Hilbert_resp));
% 나온거를 이제 -파이부터 파이까지 표현하기위해 (모드는 나머지계산하는거 2파일나눈 나머지)
figure;
plot(x, fdata); hold on; 
plot(x, mod(CHES_phase, 2*pi)-pi); axis tight; xlabel('time(s)');