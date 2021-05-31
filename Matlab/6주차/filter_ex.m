
%% 드래그 f9
clear all; close all; clc; %다없어짐

cd 'C:\Users\user\Desktop\lab_1';

% ECG+ 60Hz noise
load Sample_ECG_Filter;

x=1/Fs:1/Fs:length(data)/Fs;

% time도메인 그림
figure;
plot(x, data);  axis tight; title('raw ECG'); xlabel('time (s)'); ylabel('amplitude(mv)');


%주파수 변환 각해당주파수의 크기값을 반환해줌
[pxx, f] = periodogram(data, [], length(data), Fs);

% frequency도메인 그림
figure;
plot(f, pxx);  axis tight; ylim([0 0.2]); title('raw ECG'); xlabel('frequency (Hz)'); ylabel('magnitude(mv^2)');

%% off-line filtering 
% fir & iir
% filterDesigner 이거 명령창에 치고 엔터누르면 그래픽하게 필터를 만들수있도록해줌
x=1/Fs:1/Fs:length(data)/Fs;

% 5차로 만들거고 cutofffrequency는 30이야, 우리가 볼수있는 주파수는 fs/2니까 이걸 분모에 넣어주면 30hz loww pass
% filter를 만들어주게됨
% filter라는 내부함수를 사용하면 fdata가 나옴.
[b_iir, a_iir] = butter(5, 30/(Fs/2), 'low');
fdata_iir      = filter(b_iir, a_iir, data);

% fir은 여러가지 내부함수가 있는데 똑같이 5차 ~~ 하면됨. low로 설계 
% 얘는 분모성분이 없으니까 a_fir에 1을 넣어주면됨.
% 수학적으로  conv는 filter와 같다 따라서 두 결과가 같아야한다
% bfir을 그려보면 싱크펑션이아
% 100개로 하면 데이터를 찾을때까지 딜레이가 생김 (신호의 차수만큼 딜레이가 생김)
% 우리가 얼마나 딜레이가 될지알고있기때문에 보정해주면됨. 상관없음.
[b_fir]        = fir1(5, 30/(Fs/2), 'low');
fdata_fir      = filter(b_fir, 1, data);
fdata_conv      = conv(b_fir, data);

figure;
plot(x, data); hold on;
plot(x, fdata_iir); hold on;
plot(x, fdata_fir); hold on;
axis tight; title('filtered ECG'); xlabel('time (s)'); ylabel('amplitude(mv)');

% 컨볼루션은 양쪽 끝에만큼 데이터갯수가 늘어나기때문에 뒷부분으 ㄹ잘라내면됨
% 빨간색이 컨볼루션한건데 자세히보면 똑같음
% fir차수를 몇개하지않았기때문에 성능이 좋진않음 한 100정돈해야함
figure;
plot(x, fdata_fir); hold on;
plot(x, fdata_conv(1:end-5)); hold on;
axis tight; title('filtered ECG'); xlabel('time (s)'); ylabel('amplitude(mv)');


%% off-line filtering (zero-phase filtering)
% 내부함스로 filtfilt란걸 씀
% 앞쪽으로 필터링 ㅇ뒷쪽으로 필터링해서 중간값을 가져오면 페이즈가 0으로 보정이됨.
% 버터워스 차수가 5차 그러면 6개가나옴(보통 +1) 로우패스의 컷오프프리퀀시와 fs만 주면  b와 a성분이 만들어짐
[b, a]     = butter(5, 30/(Fs/2), 'low');
fdata      = filtfilt(b, a, data);

x=1/Fs:1/Fs:length(fdata)/Fs;

% time도메인 그림
figure;
plot(x, fdata);  axis tight; title('filtered ECG'); xlabel('time (s)'); ylabel('amplitude(mv)');

% 필터가 제대로 적용이됐다면 60hz가 없어져야함
%주파수 변환
[pxx2, f2] = periodogram(fdata, [], length(fdata), Fs);

% frequency도메인 그림
figure;
plot(f2, pxx2);  axis tight; ylim([0 0.7]); title('raw ECG'); xlabel('frequency (Hz)'); ylabel('magnitude(mv^2)');

%% on-line filtering (fir)
% 로우데이터를 메모리때매 다 갖고있을수가없음
% 따라서 필터를 실시간으로 계속 처리해줘야ㅕ함.
clear all; close all; clc;

cd 'C:\Users\user\Desktop\lab_1';;

% ECG+ 60Hz noise
load Sample_ECG_Filter;
% 10개가 들어가있음 (9차필터) 따라서 tap이 10
h        = fir1(9, 35/(Fs/2), 'low');

x     =  [0 0 0 0 0 0 0 0 0 0];
taps = 10;
f_data = [];

figure;
al1 = animatedline;
al2 = animatedline('color', 'b');

for n=1:1:length(data)
    % shift시키는 부분
    for k=taps:-1:2
        x(k) = x(k-1);
    end
    % 새로운데이터 넣고 시프트시킨다음에
    new_input = data(n);
    x(1)         =  new_input;
   
    out_value = 0;
    % out value를 가져옴
    for k=1:1:taps
        out_value = out_value + h(k)*x(k);
    end 
% 누적된걸로 할거면 필터된 데이터 n이라고해서 out value를 넣어주면됨    
%     f_data(n) = out_value;
    % 이건 실시간을 처리되고있는걸 보여주기위함 
    % 파란색이 실시간. 검은색이 원신호
    addpoints(al1, n, new_input); drawnow;
    addpoints(al2, n, out_value); drawnow;
end

%% on-line filtering (iir)

clear all; close all; clc;

cd 'D:\상명대학교\수업\2021_1\데이터마이닝\코드';

% ECG+ 60Hz noise
load Sample_ECG_Filter;
% taps는 3개가 나오게됨
[b_iir, a_iir] = butter(2, 35/(Fs/2), 'low');
%데이터가 들어오기전에 시프트를 시킥 마지막에 데이터넣음.
x_iir     = [0, 0, 0];
y_iir     = [0, 0, 0];
taps_iir = 3;

figure;
al1 = animatedline;
al2 = animatedline('color', 'b');

for n=1:1:length(data)
    % 시프트시키고
    x_iir(3) = x_iir(2);
    x_iir(2) = x_iir(1);
    
    %new input 새로넣고
    new_input = data(n);
    x_iir(1) = new_input;
    
    %y shift
    y_iir(3) = y_iir(2);
    y_iir(2) = y_iir(1);
    
    % filtering y_iir이 최종적으로 얻게된 데이터인데
    % 쌓아놓고 어느정도 쌓이면 피크찾아서 심박검출하고 ㅎㅏ면됨
    y_iir(1) = b_iir(1)*x_iir(1) + b_iir(2)*x_iir(2) + b_iir(3)*x_iir(3) - a_iir(2)*y_iir(2) - a_iir(3)*y_iir(3);
    
    addpoints(al1, n, new_input); drawnow;
    addpoints(al2, n, y_iir(1)); drawnow;

end
