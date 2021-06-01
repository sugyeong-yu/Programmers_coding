% SVM 실행결과
% 마찬가지로 분류 들어가보면 svm설명을 볼 수 있음 기본적으로 svm은 이진분류 
% 근데 class가 3개이상일때의 사용방법을 볼 수 있음. 
clear all; close all; clc;

load fisheriris
inds = ~strcmp(species,'setosa'); % setosa까지는 0을 만들었고 나머지는 다 1
% setosa는 뺴고 나머지 둘에대해서 분류를 해보겠다는것
X = meas(inds,3:4);
y = species(inds);

SVMModel = fitcsvm(X,y)% svm의 기본커널은 RBF커널일것. 

sv = SVMModel.SupportVectors;
figure;
gscatter(X(:,1),X(:,2),y)
hold on
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
legend('versicolor','virginica','Support Vector')
hold off

%% SVM loss구해보기
clear all; close all; clc;

load ionosphere
rng(1); % For reproducibility

SVMModel = fitcsvm(X,Y,'Standardize',true,'KernelFunction','RBF', 'KernelScale','auto');
CVSVMModel = crossval(SVMModel);
classLoss = kfoldLoss(CVSVMModel)

%% SVM가지고 다중분류를 할때
clear all; close all; clc;

load fisheriris
X = meas(:,3:4);
Y = species;

figure
gscatter(X(:,1),X(:,2),Y);
h = gca;
lims = [h.XLim h.YLim]; % Extract the x and y axis limits
title('{\bf Scatter Diagram of Iris Measurements}');
xlabel('Petal Length (cm)');
ylabel('Petal Width (cm)');
legend('Location','Northwest');
ylabel('Sepal Width (cm)')
legend('Observation','Support Vector')
hold off
% 모델을 3개만들것
%setosa와 setosa 아닌것 , 버즈니카인것과 버즈니카 아닌것....
SVMModels = cell(3,1); % 모델을 3개만들어서 각각의 cell에다가 저장할것
classes = unique(Y);
rng(1); % For reproducibility

%3개의 모델을 만듬
for j = 1:numel(classes)
    indx = strcmp(Y,classes(j)); % Create binary classes for each classifier, ex) setosa랑 같은걸 불러옴(같으면 1 아니면 0)
    SVMModels{j} = fitcsvm(X,indx,'ClassNames',[false true],'Standardize',true,...
        'KernelFunction','rbf','BoxConstraint',1);
end

%신경 x
d = 0.02;
[x1Grid,x2Grid] = meshgrid(min(X(:,1)):d:max(X(:,1)),...
    min(X(:,2)):d:max(X(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];
N = size(xGrid,1);
Scores = zeros(N,numel(classes));

%predict해보기
for j = 1:numel(classes)
    [~,score] = predict(SVMModels{j},xGrid);
    Scores(:,j) = score(:,2); % Second column contains positive-class scores
end

[~,maxScore] = max(Scores,[],2); % 3개의 모델 score중에 가장 큰 score를 갖는 class로

figure
h(1:3) = gscatter(xGrid(:,1),xGrid(:,2),maxScore,...
    [0.1 0.5 0.5; 0.5 0.1 0.5; 0.5 0.5 0.1]);
hold on
h(4:6) = gscatter(X(:,1),X(:,2),Y);
title('{\bf Iris Classification Regions}');
xlabel('Petal Length (cm)');
ylabel('Petal Width (cm)');
legend(h,{'setosa region','versicolor region','virginica region',...
    'observed setosa','observed versicolor','observed virginica'},...
    'Location','Northwest');
axis tight
hold off

%% SVM자동으로 하이퍼파라미터 최적화
clear all; close all; clc;

load ionosphere

rng default
Mdl = fitcsvm(X,Y,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    'expected-improvement-plus'))
% svm은 연산량이 많음ㅇ 따라서 시간 되게오래 걸릴것
