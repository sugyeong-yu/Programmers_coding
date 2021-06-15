% CPPG와 RPPG의 paired t-test & 회귀모델링하기
clear all; close all; clc;

cd 'D:\prlab\ysg\rppg\rppg_HRV\inter_result';

% data load ( LF, HF, LF/HF Ratio 중 선택)
result= dir('*.csv');
[h,~]= size(result);
c_feature = zeros(11,h);
r_feature = zeros(11,h);
for i = 1:h
    n= result(i).name;
    opts = detectImportOptions(n);
    preview(n,opts)
    opts.SelectedVariableNames = {'c_lf_hf_ratio'};
    c=readmatrix(n,opts);
    c_feature(:,i)=c(1:11,:);
    opts.SelectedVariableNames = {'r_lf_hf_ratio'};
    r=readmatrix(n,opts);
    r_feature(:,i)=r(1:11,:);

end

% data concat(하나의 열로 합치기)
C_f = vertcat(c_feature(:,1),c_feature(:,2),c_feature(:,3),c_feature(:,4),c_feature(:,5),c_feature(:,6),c_feature(:,7),c_feature(:,8),c_feature(:,9),c_feature(:,10)); 
R_f = vertcat(r_feature(:,1),r_feature(:,2),r_feature(:,3),r_feature(:,4),r_feature(:,5),r_feature(:,6),r_feature(:,7),r_feature(:,8),r_feature(:,9),r_feature(:,10)); 
%% 반복측정 paired t-test
% 데이터벡터 x와 y간의 쌍별차가 평균0을 갖는다는 귀무가설을 검증한다.
%[p,h,stats] = ranksum(c_LF,r_LF); 비모수검정 랭크썸사용

[h,p] =ttest(C_f,R_f); % h=1로 귀무가설 기각 , 즉 두 지표에 유의한 차이를 보임.

%% 회귀모델링
%% Train
% 종속변수 y = cppg, 독립변수 = rppg

train_x = vertcat(r_feature(:,1),r_feature(:,2),r_feature(:,3),r_feature(:,4),r_feature(:,5),r_feature(:,6),r_feature(:,7)); 
train_y = vertcat(c_feature(:,1),c_feature(:,2),c_feature(:,3),c_feature(:,4),c_feature(:,5),c_feature(:,6),c_feature(:,7)); 

% regress(종속변수,독립변수) > 다중회귀에 주로사용되는 matlab함수 
weights      =     regress(train_y, [ones(size(train_x)) train_x ]); % ones는 절편값에 대한 계수 그리고 설명변수 집어넣음 % 결과로 ones,HR,PAT 의 가중치가 순서로나옴
Estimated     =    weights(1)+weights(2)*train_x;

mean(abs(train_y-Estimated))


figure;
crosscorr(train_y, Estimated); % 추정된 sbp와 기존sbp의 correlation이 0.934정도 된다는 뜻. 위의 파란줄은 유의한 0.95일때 값 즉 y가 0.23이 넘으면 0.05 이상이라는 것
% corrcoef(SBP, Estimated_SBP)
                                
figure;   
plot(train_y,Estimated,'rx','LineWidth',6);  hold on;
set(gca,'fontsize',16,'fontweight','b'); xlabel('Reference ','fontsize',16,'fontweight','b'); ylabel('Estimated ','fontsize',16,'fontweight','b');


%% Test해보기

test_x = vertcat(r_feature(:,8),r_feature(:,9),r_feature(:,10)); 
test_y = vertcat(c_feature(:,8),c_feature(:,9),c_feature(:,10)); 

TS_Estimated   = weights(1)+weights(2)*test_x;

% 오차계산하기
mean(abs(test_y-TS_Estimated))

plot(test_y, TS_Estimated,'bx','LineWidth',6);  hold off;
% 여기까지 hold off > hold on ~ hold off까지 한 캔버스에 그림을 겹쳐그림

figure;
crosscorr(test_y, TS_Estimated); 


