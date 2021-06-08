%% 계층적 군집 1
clear all; close all; clc;

rng default;  % For reproducibility
X = [1 2;2.5 4.5;2 2;4 1.5;4 2.5];

figure;
plot(X(:,1), X(:,2), 'ko'); xlim([0 5]); ylim([1 5]); grid on;

Y = pdist(X)
squareform(Y)

Z = linkage(Y) % 링크를 만듬 (연결법) default가 sigle > 단일연결법이 default

figure;
dendrogram(Z)% 덴드로그램 그래프

I = inconsistent(Z)% 불일치계수 계산

mean([1 1 1 1 2.06155 2.06155])
std([1 1 2.06155])

T = cluster(Z,'cutoff',1.2)% z를 가지고 cluster를 할건데 cutoff를 지정. 1.2보다 큰값이 없으면 그룹통합 
T = cluster(Z,'cutoff',0.8)

T = cluster(Z,'maxclust',2)%cluster 계수 (군집갯수)를 지정할 수도 있음.
T = cluster(Z,'maxclust',3)
%% 계층적 군집 2
clear all; close all; clc;

rng('default'); % For reproducibility
X = [(randn(20,2)*0.75)+1; (randn(20,2)*0.25)-1]; %데이터로 난수를 발생

figure;
scatter(X(:,1),X(:,2));
title('Randomly Generated Data');

Z = linkage(X,'ward'); %ward > 내부 제곱 거리(최소 분산 알고리즘)로, 유클리드 거리에만 적합함

figure;
dendrogram(Z) %덴드로그램

T = cluster(Z,'maxclust',3);

figure;
gscatter(X(:,1),X(:,2),T)
%% 계층적 군집 3
% 직관적으로 덴드로그램에서의 cutoff를 지정하는 방법.
clear all; close all; clc;

load fisheriris
%붓꽃데이터 5개씩만 불러옴 
meas = meas([1:5, 81:85, 111:115],:);

t = [1:5, 81:85, 111:115]
for k=1:1:length(t)
    species2{k} = species{t(k)};
end
species2 = species2';

figure;
gscatter(meas(:,3),meas(:,4),species2,'rgb','do*')
title("Actual Clusters of Fisher's Iris Data")

Z = linkage(meas(:,3:4),'average','euclidean');

figure;
dendrogram(Z)

T = cluster(Z,'cutoff',1,'Criterion','distance') % 옵션에 distance를 넣어주면됨 . 안쓰면 불일치계수기준, 쓰면 덴드로그램 기준으로 잘라줌.

length(unique(T))

figure;
gscatter(meas(:,3),meas(:,4),T,'rgbm','do*s')
title("Cluster Assignments of Fisher's Iris Data")



T = cluster(Z,'maxclust',3);
cutoff = median([Z(end-2,3) Z(end-1,3)]);
figure;
dendrogram(Z,'ColorThreshold',cutoff)

length(unique(T))

figure;
gscatter(meas(:,3),meas(:,4),T,'grb','dos')
title("Cluster Assignments of Fisher's Iris Data")


