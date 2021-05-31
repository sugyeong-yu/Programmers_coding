%% 단순한 선형회귀
clear all; close all; clc;

y = 10:0.1:30; % 10~30 까지 0.1 씩 증가시키며
y_t = y' + randn(length(y), 1); % y값에 랜덤값 > 노이지하게 만든것. y'는 행을 열로 열벡터는 행으로 바꾸라는 뜻임. Transpose랑 같음.

x = 1:0.01:3; % 1~3 까지 0.1씩 증가.
x_t = x' + 0.3*randn(length(x), 1);

figure;
plot(x_t, y_t, 'ro');

A = [];
A = [x_t ones(length(x_t), 1)]; % x,1

w = A\y_t % w는 기울기, 절편 (a,b)

t = 0:0.01:4;
y_est = w(1)*t+w(2);


figure;
plot(t, y_est); hold on;
plot(x_t, y_t, 'ro'); hold off;


w2 = ((A'*A)^-1)*A'*y_t % w와 같다.

%% TR_SET : train set >> ECG,혈압,PPG 3개씩 들어가있음 총 5개의 데이터

%figure;
%subplot(311); plot(tr_data1(:,1)); axis tight; %심전도
%subplot(312); plot(tr_data1(:,2)); axis tight; %PPG
%subplot(313); plot(tr_data1(:,3)); axis tight;% 혈압 발살,,발? 해진다고 혈압은 크기가 커지지않음

% 혈압의 윗쪽 Peak > SBP , 아래쪽 peak > DBP >> 혈압은 필터를 적용하고 peak를 뽑으면 절대안됨.
% PAT랑 HR구해서 SBP추정하는 실습.

clear all; close all; clc;

cd 'C:\Users\user\Desktop\data_mining\11주차'

load tr_raw_data
load TR_SET.mat

% TR_SET은 다 구해놓은것. SBP,DBP,HR,PAT
% regress(종속변수,독립변수) > 다중회귀에 주로사용되는 matlab함수 
weights_SBP      =     regress(SBP', [ones(size(Feature_HR')) Feature_HR'  Feature_PAT']); % ones는 절편값에 대한 계수 그리고 설명변수 집어넣음 % 결과로 ones,HR,PAT 의 가중치가 순서로나옴
Estimated_SBP     =    weights_SBP(1)+weights_SBP(2)*Feature_HR+weights_SBP(3)*Feature_PAT;

mean(abs(SBP-Estimated_SBP))


figure;
crosscorr(SBP, Estimated_SBP); % 추정된 sbp와 기존sbp의 correlation이 0.934정도 된다는 뜻. 위의 파란줄은 유의한 0.95일때 값 즉 y가 0.23이 넘으면 0.05 이상이라는 것
% corrcoef(SBP, Estimated_SBP)
                                
figure;   
plot(SBP,Estimated_SBP,'rx','LineWidth',6);  hold on;
set(gca,'fontsize',16,'fontweight','b'); xlabel('Reference SBP(mmHg)','fontsize',16,'fontweight','b'); ylabel('Estimated SBP(mmHg)','fontsize',16,'fontweight','b');


x=110:1/1000:170;
y = x;
plot(x, y,'k','LineWidth',3); hold on;plot(x,y + 5,'b--','LineWidth',2); hold on;plot(x, y - 5,'b--','LineWidth',2); hold on;


%% Test해보기
load TS_SET;

TS_Estimated_SBP   = weights_SBP(1)+weights_SBP(2)*TS_Feature_HR+weights_SBP(3)*TS_Feature_PAT;

% 오차계산하기
mean(abs(TS_SBP-TS_Estimated_SBP))

plot(TS_SBP, TS_Estimated_SBP,'bx','LineWidth',6);  hold off;
% 여기까지 hold off > hold on ~ hold off까지 한 캔버스에 그림을 겹쳐그림

figure;
crosscorr(TS_SBP, TS_Estimated_SBP); 
% corrcoef(TS_SBP, TS_Estimated_SBP)
         