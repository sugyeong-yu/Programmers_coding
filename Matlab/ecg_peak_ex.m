clear all; close all; clc;

cd 'C:\Users\user\Desktop\lab_1';

% ECG+ 60Hz noise
load test_ECG_1;

x=1/Fs:1/Fs:length(data)/Fs;

[b, a]     = butter(5, 30/(Fs/2), 'low');
fdata      = filtfilt(b, a, data);
% 0.5라 한거를 노란색에서 peak를 찾으려하면 twave가 너무 커서 그냥적용하기ㅏ엔 눈에 거슬림 따라서 필터를 적용해서 저
% twqve를 좀 깎고 싶을때 : r peak는 빨리변함 = 고헤르츠성분 ,  twave 는 느리게변함 =- 로우성분 
% 따라서 하이패스를 좀 쎄게먹이면 twqve가 없을것
% 0.5를 3으로 바꿔서 하면 t wave가 작아짐. 
[b2, a2]     = butter(5, 0.5/(Fs/2), 'high');
fdata2      = filtfilt(b2, a2, fdata);
% 원래사ㅣㄴ호 로우패스 하아ㅣ패스까지한 밴드패스 순으로 나올것
% 60hz노이즈를 잘잡았음. 
figure;
plot(x, data); hold on;
plot(x, fdata); hold on;
plot(x, fdata2); hold on;
axis tight; title('filtered ECG'); xlabel('time (s)'); ylabel('amplitude(mv)');

%%
dif_data = diff(fdata2); % 미분

figure;
plot(x, fdata2);  hold on; plot(x(1:end-1), dif_data); axis tight; xlabel('time (s)'); ylabel('amplitude(v)');

% 절대값
abs_data = abs(dif_data);
% 자글자글한게 보기싫으니까 무빙에버리지 윚ㄴ도우를 씌움.
figure;
plot(x, fdata2); hold on; plot(x(1:end-1), dif_data);  hold on; plot(x(1:end-1), abs_data);axis tight; xlabel('time (s)'); ylabel('amplitude(v)');

%이동평균
%스무스라는 내부함수가있고 무빙이란 옵션을 주면됨. 
% 무빙을 두번나눠서함 > 꿀팁ㄴ임. 
% 힌번할때 0.5로 하면 잘안됨 0.8로하면 자세히보면 피크가 많이나옴. 
% 노하우는 두번나눠서함. 그러면 결과적을 잘나옴 (박스크기를 작게하고 한번해서 돌려보면 신호를 사이즈만큼 다시 에버리지)
% fs*03 >> 0.3초로 윈도우사이즈를 0.3을 하란것 > 소수점으로낭로것 > 알아서보정해서 76으로 계산할것
mva_data = smooth(abs_data, 0.3*Fs, 'moving');
mva_data = smooth(mva_data, 0.3*Fs, 'moving');
figure;
subplot(211); plot(x, data); axis tight; 
subplot(212); plot(x(1:end-1), mva_data); axis tight; xlabel('time (s)'); ylabel('amplitude(v)');

% 피크 찾기
% 내부함수가 있음 findpeaks 몇보다 큰거에서 찾으라는 옵션을 넣어줄수도있음
[pv, pi] = findpeaks(mva_data);
% 인덱스를 pi에 나옴.
figure;
plot(x, fdata2); hold on;
plot(x(1:end-1), mva_data); hold on; plot(pi./Fs, pv, 'ro'); axis tight; xlabel('time (s)'); ylabel('amplitude(v)');

figure;
subplot(211); plot(x, fdata2); axis tight;
subplot(212); plot(x(1:end-1), mva_data); hold on; plot(pi./Fs, pv, 'ro'); axis tight; xlabel('time (s)'); ylabel('amplitude(v)');


% 최종 피크 찾기
ecg_peak = [];
% 3부터 시작 > peak를 찾았을때 첫번째부터가아니라 세번째부터 찾음 > 우연에 의해 데이터가 없거나 안정성이 없을수도.
for k=3:1:length(pi)
    % 피크 찾은 인덱스에서 fs/20 >> 20분의 1초 만큼 앞으로 윈도우를 자르고 피크위치만큼의 데이터를 가져와서 이중애서
    % 피크를 찾음
    tmp = fdata(pi(k)-round(Fs/20):pi(k));
    [ev, ei] = findpeaks(tmp);
    
    ecg_peak = [ecg_peak; ei+pi(k)-round(Fs/20)-1];
end

figure;
plot(x, fdata); hold on; plot(ecg_peak./Fs, fdata(ecg_peak), 'ro'); axis tight; 

rri = diff(ecg_peak)./Fs;

['심박간격 (sec): ' num2str(rri')]
['심박수 (bpm): ' num2str(60./rri')]