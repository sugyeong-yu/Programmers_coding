clear all; close all; clc;
% kmeans

load fisheriris
X = meas(:,3:4); % 붓꽃데이터의 3,4 지표만 사용

figure;
plot(X(:,1),X(:,2),'k*','MarkerSize',5);
title 'Fisher''s Iris Data';
xlabel 'Petal Lengths (cm)'; 
ylabel 'Petal Widths (cm)';

rng(1); % For reproducibility
[idx,C] = kmeans(X,3);%featyre, k 넣어주면 센터의 중심좌표 C, 어떻게 카테고리를 나누었는지 idx를 반환

x1 = min(X(:,1)):0.01:max(X(:,1));
x2 = min(X(:,2)):0.01:max(X(:,2));
[x1G,x2G] = meshgrid(x1,x2);
XGrid = [x1G(:),x2G(:)]; % Defines a fine grid on the plot

[idx2Region,C] = kmeans(XGrid,3,'MaxIter',10,'Start',C);
%kmeans가 알고리즘이 수렴되지 않았음을 나타내는 경고를 표시합니다. 이는 소프트웨어가 1회 반복만 구현했기 때문에 예상되는 동작입니다.

figure;
gscatter(XGrid(:,1),XGrid(:,2),idx2Region,...
    [0,0.75,0.75;0.75,0,0.75;0.75,0.75,0],'..');
hold on;
plot(X(:,1),X(:,2),'k*','MarkerSize',5);
title 'Fisher''s Iris Data';
xlabel 'Petal Lengths (cm)';
ylabel 'Petal Widths (cm)'; 
legend('Region 1','Region 2','Region 3','Data','Location','SouthEast');
hold off;

%% 랜덤한 데이터로 적용.
clear all; close all; clc;

rng default; % For reproducibility
X = [randn(100,2)*0.75+ones(100,2);
    randn(100,2)*0.5-ones(100,2)];

figure;
plot(X(:,1),X(:,2),'.');
title 'Randomly Generated Data';

opts = statset('Display','final');
[idx,C] = kmeans(X,2,'Distance','cityblock',...
    'Replicates',5,'Options',opts);

figure;
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12)
plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3) 
legend('Cluster 1','Cluster 2','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'
hold off

%% 클러스터 evaluation 
clear all; close all; clc;

load fisheriris
X = meas;
y = categorical(species);

eva = evalclusters(X,'kmeans','CalinskiHarabasz','KList',1:10)
%optimal k가 1이라고 나옴 > 없는값이니까 무시하면됨

figure; 
plot(eva)
