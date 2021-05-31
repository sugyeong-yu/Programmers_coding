clear all; close all; clc;

load fisheriris;

figure;
% meas : 꽃의 petal,sepal의 w,h , species : 꽃종류(정답레이블)
gscatter(meas(:,2), meas(:,3), species,'rgb','osd');
xlabel('Sepal length');
ylabel('Sepal width');
N = size(meas,1);

%%
clear all; close all; clc;

load fisheriris;

tr_s = (1:1:150)';
ts_s = [46:50, 96:100, 146:150]'; % 종류별로 마지막 5개는 test set
tr_s(ts_s,:) = [];

X_tr = meas(tr_s,:);
Y_tr = species(tr_s,:);

X_ts = meas(ts_s,:);
Y_ts = species(ts_s,:);

Mdl = fitcknn(X_tr,Y_tr,'NumNeighbors',3,'Standardize',1);

rng(1); % For reproducibility
CVKNNMdl = crossval(Mdl);
classError = kfoldLoss(CVKNNMdl)

label = predict(Mdl,X_ts) 

%% 자동 하이퍼파라미터 최적화, 5-fold
clear all; close all; clc;

load fisheriris

tr_s = (1:1:150)';
ts_s = [46:50, 96:100, 146:150]';
tr_s(ts_s,:) = [];

X_tr = meas(tr_s,:);
Y_tr = species(tr_s,:);

X_ts = meas(ts_s,:);
Y_ts = species(ts_s,:);

rng(1)
% ...은 의미없는거임, auto , 하이퍼파라미터 지정
Mdl = fitcknn(X_tr, Y_tr,'OptimizeHyperparameters','auto', ...
              'HyperparameterOptimizationOptions', ...
                struct('AcquisitionFunctionName','expected-improvement-plus', 'Kfold',5 )) % , 'Kfold',10 (default: 5)


label = predict(Mdl,X_ts) 

%%
clear all; close all; clc;

load fisheriris;

tr_s = (1:1:150)';
ts_s = [46:50, 96:100, 146:150]';
tr_s(ts_s,:) = [];

figure;
gscatter(meas(:,1), meas(:,4), species,'rgb','osd'); hold on;

plot(meas(ts_s,1), meas(ts_s,4), 'kx');
hold off;
