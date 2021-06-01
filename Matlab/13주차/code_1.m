%%

clear all; close all; clc;

load ionosphere;
% 분류를 검색해보면 결정트리를 어떻게사용하는지 볼 수 있음.
% 34개의 관측값에 대해 bad ? or good?
rng(1); % For reproducibility
MdlDefault = fitctree(X,Y,'CrossVal','on');
view(MdlDefault.Trained{1},'Mode','graph')% 기본적으로 10개의 모델이 생성될 것 그 중 첫번째 모델을 보여줘라라는 것.
% MdlDefault 열기 > trained > 1 > cutpoint, cutpredictor > 분기된 조건들이 표시되어있음

Mdl7 = fitctree(X,Y,'MaxNumSplits',7,'CrossVal','on'); % 분기점을 몇개사용할건지 결정가능
view(Mdl7.Trained{3},'Mode','graph')

classErrorDefault = kfoldLoss(MdlDefault)
classError7 = kfoldLoss(Mdl7) % 7개로했을때 로스가 더 컸음.

%%
clear all; close all; clc;
% 붓꽃데이터사용
load fisheriris

mdl = fitctree(meas(:,1:2), species,'PredictorNames',{'SL' 'SW' });
% mdl2 = fitctree(meas, species,'PredictorNames',{'SL' 'SW' 'PL' 'PW'});
% view(mdl2,'Mode','graph');
[x,y] = meshgrid(4:.1:8,2:.1:4.5);
x = x(:);
y = y(:);

[grpname,node] = predict(mdl,[x y]);
gscatter(x,y,grpname,'grb','sod');

view(mdl,'Mode','graph'); % 오버피팅 (feature는 4개밖에 없는데 분기가 너무많음)

cp = cvpartition(species,'KFold',10);% 10fold 

dtResubErr = resubLoss(mdl)% 모델이가지고있는 loss

cvt = crossval(mdl,'CVPartition',cp);
dtCVErr = kfoldLoss(cvt)% 크로스val해봣더니 로스가 더 커짐 >> 모델자체가 과적합되었다는 뜻.

% 그래프 그려보기
% kfoldloss와 cvloss의 차이 : cvloss와 달리 kfoldLoss는 SE, Nleaf 또는 BestLevel을
% 반환하지 않는다. , kfold는 분류오류이외의 오류를 검사할 수 없다.
resubcost = resubLoss(mdl,'Subtrees','all');
[cost,secost,ntermnodes,bestlevel] = cvloss(mdl,'Subtrees','all');% 모델만든 후 closs validation을 통해 cost, standard error, 그떄 terminal node수, 
plot(ntermnodes,cost,'b-', ntermnodes,resubcost,'r--')
figure(gcf);
xlabel('Number of terminal nodes');
ylabel('Cost (misclassification error)')
legend('Cross-validation','Resubstitution')

[mincost,minloc] = min(cost);% cost가 젤 작은것의 min값과 location을 가지고 있는것 
cutoff = mincost + secost(minloc); % min cost에 std error를 더한걸 cutoff로 둘것.
% cutoff아래에서 가장 최저점을 찾아라가 될것. 
hold on
plot([0 20], [cutoff cutoff], 'k:')
plot(ntermnodes(bestlevel+1), cost(bestlevel+1), 'mo') % best level+1 > 매트랩은 인덱스가 1부터인데 이 데이터는 0번부터 시작함 이를 빼주기위해 +1
legend('Cross-validation','Resubstitution','Min + 1 std. err.','Best choice')
hold off

pt = prune(mdl,'Level',bestlevel); % best level로 가지치기를 해줘라.
view(pt,'Mode','graph')

%%
clear all; close all; clc;

load fisheriris

X = meas;
Y = species;
% 의사결정트리 최적화과정(자동화)
Mdl = fitctree(X,Y,'OptimizeHyperparameters','auto')

view(Mdl,'Mode','graph')

%%
clear all; close all; clc;

load fisheriris

tr_s = (1:1:150)';
ts_s = [46:50, 96:100, 146:150]';
tr_s(ts_s,:) = [];

X_tr = meas(tr_s,:);
Y_tr = species(tr_s,:);

X_ts = meas(ts_s,:);
Y_ts = species(ts_s,:);
% 자동으로
Mdl = fitctree(X_tr,Y_tr,'OptimizeHyperparameters','auto')

view(Mdl,'Mode','graph')

[label, node] = predict(Mdl, X_ts) % node는 두 분포의 확률을 보여줌 (둘의차이가 클수록 좋음 분류가 더 잘된다는것)

% 모델을 만들고 모델의 오차와 cross val 을 만든 후 cross val을 했을때의 오차보기
Mdl2 = fitctree(meas, species);
view(Mdl2,'Mode','graph');

cp = cvpartition(species,'KFold',10);

dtResubErr = resubLoss(Mdl2)

cvt = crossval(Mdl2,'CVPartition',cp);
dtCVErr = kfoldLoss(cvt) % 오차가 크므로 과적합이구나

% 결과 시각화 및 최소 cost찾기
resubcost = resubLoss(Mdl2,'Subtrees','all');%regreesion loss
[cost,secost,ntermnodes,bestlevel] = cvloss(Mdl2,'Subtrees','all'); % closs val loss
plot(ntermnodes,cost,'b-', ntermnodes,resubcost,'r--')
figure(gcf);
xlabel('Number of terminal nodes');
ylabel('Cost (misclassification error)')
legend('Cross-validation','Resubstitution')

[mincost,minloc] = min(cost);
cutoff = mincost + secost(minloc);
hold on
plot([0 20], [cutoff cutoff], 'k:')
plot(ntermnodes(bestlevel+1), cost(bestlevel+1), 'mo')
legend('Cross-validation','Resubstitution','Min + 1 std. err.','Best choice')
hold off

pt = prune(Mdl2,'Level',bestlevel);
view(pt,'Mode','graph')

[label2, node2] = predict(pt, X_ts)
