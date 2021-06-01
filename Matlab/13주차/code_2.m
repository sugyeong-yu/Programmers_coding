% 랜덤포레스트 
% 여러 방법이 있다 treeBagger, fitc앙상블
clear all; close all; clc;

load fisheriris;
% dataset나누기
tr_s = (1:1:150)';
ts_s = [46:50, 96:100, 146:150]';
tr_s(ts_s,:) = [];

X_tr = meas(tr_s,:);
Y_tr = species(tr_s,:);

X_ts = meas(ts_s,:);
Y_ts = species(ts_s,:);

%treebagger라는 함수를 이용해서 (트리몇개?,데이터,레이블,..., method는 classification) 
rng(1); % For reproducibility
Mdl = TreeBagger(50,X_tr,Y_tr,'OOBPrediction','On','Method','classification') % 'Method','regression' 도 가능
% Mdl열어서 tree들어가보면 50개의 tree가 만들어져있을것
view(Mdl.Trees{1},'Mode','graph')

figure;
oobErrorBaggedEnsemble = oobError(Mdl);
plot(oobErrorBaggedEnsemble)
xlabel 'Number of grown trees';
ylabel 'Out-of-bag classification error';

label = predict(Mdl, X_ts)

% %% 컨트롤 티 > 전체주석제거
% clear all; close all; clc;
% 
% load ionosphere;
% 
% t = templateTree('MaxNumSplits',5); % 베이스 트리
% Mdl =
% fitcensemble(X,Y,'Method','AdaBoostM1','Learners',t,'CrossVal','on');%
% 에이다 부스트는 같은 나무이긴한데 가중치가 모두다르고 adaptive하게 웨이트를 바꿔가면서 적용하는 방법, 랜덤포레스트의 기초를
% 가지고있고 웨이트를 달리하면서 붙인 어드벤스 방법
% kflc = kfoldLoss(Mdl,'Mode','cumulative');
% figure;
% plot(kflc);
% ylabel('10-fold Misclassification rate');
% xlabel('Learning cycle');
% estGenError = kflc(end)
% 
% %%
% clear all; close all; clc;
% 
% load ionosphere;
% 
% rng('default')
% t = templateTree('Reproducible',true);
% Mdl = fitcensemble(X,Y,'OptimizeHyperparameters','auto','Learners',t, ...
%     'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName','expected-improvement-plus'))
% 
