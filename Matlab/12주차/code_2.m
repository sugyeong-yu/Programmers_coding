clear all; close all; clc;

load fisheriris;

lda = fitcdiscr(meas(:,1:2),species);
ldaClass = resubPredict(lda);

ldaResubErr = resubLoss(lda)

figure;
ldaResubCM = confusionchart(species,ldaClass);


f = figure;
gscatter(meas(:,1), meas(:,2), species,'rgb','osd');
xlabel('Sepal length');
ylabel('Sepal width');
N = size(meas,1);

figure(f)
bad = ~strcmp(ldaClass,species);
hold on;
plot(meas(bad,1), meas(bad,2), 'kx');
hold on;

[x,y] = meshgrid(4:.1:8,2:.1:4.5);
x = x(:);
y = y(:);
j = classify([x y],meas(:,1:2),species);
gscatter(x,y,j,'grb','sod')

%qda
qda = fitcdiscr(meas(:,1:2),species,'DiscrimType','quadratic');
qdaResubErr = resubLoss(qda)

rng(0,'twister');
cp = cvpartition(species,'KFold',10)

cvlda = crossval(lda,'CVPartition',cp);
ldaCVErr = kfoldLoss(cvlda)

cvqda = crossval(qda,'CVPartition',cp);
qdaCVErr = kfoldLoss(cvqda)

[x,y] = meshgrid(4:.1:8,2:.1:4.5);
x = x(:);
y = y(:);
j = classify([x y],meas(:,1:2),species,'quadratic');
gscatter(x,y,j,'grb','sod')

%%
clear all; close all; clc;

load fisheriris;
X = meas(:,3:4);
Y = species;
tabulate(Y)

Mdl = fitcnb(X,Y,'ClassNames',{'setosa','versicolor','virginica'})

setosaIndex = strcmp(Mdl.ClassNames,'setosa');
estimates = Mdl.DistributionParameters{setosaIndex,1}

figure;
gscatter(X(:,1),X(:,2),Y);
h = gca;
cxlim = h.XLim;
cylim = h.YLim;
hold on
Params = cell2mat(Mdl.DistributionParameters); 
Mu = Params(2*(1:3)-1,1:2); % Extract the means
Sigma = zeros(2,2,3);
for j = 1:3
    Sigma(:,:,j) = diag(Params(2*j,:)).^2; % Create diagonal covariance matrix
    xlim = Mu(j,1) + 4*[-1 1]*sqrt(Sigma(1,1,j));
    ylim = Mu(j,2) + 4*[-1 1]*sqrt(Sigma(2,2,j));
    f = @(x,y) arrayfun(@(x0,y0) mvnpdf([x0 y0],Mu(j,:),Sigma(:,:,j)),x,y);
    fcontour(f,[xlim ylim]) % Draw contours for the multivariate normal distributions 
end
h.XLim = cxlim;
h.YLim = cylim;
title('Naive Bayes Classifier -- Fisher''s Iris Data')
xlabel('Petal Length (cm)')
ylabel('Petal Width (cm)')
legend('setosa','versicolor','virginica')
hold off

%% 사전 확률 지정
clear all; close all; clc;

load fisheriris;
X = meas;
Y = species;
classNames = {'setosa','versicolor','virginica'}; % Class order

prior = [0.5 0.2 0.3];
Mdl = fitcnb(X,Y,'ClassNames',classNames,'Prior',prior)

defaultPriorMdl = Mdl;
FreqDist = cell2table(tabulate(Y));
defaultPriorMdl.Prior = FreqDist{:,3};

rng(1); % For reproducibility
defaultCVMdl = crossval(defaultPriorMdl);
defaultLoss = kfoldLoss(defaultCVMdl)

CVMdl = crossval(Mdl);
Loss = kfoldLoss(CVMdl)

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

classNames = {'setosa','versicolor','virginica'};

rng default
Mdl = fitcnb(X_tr,Y_tr,'ClassNames',classNames,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    'expected-improvement-plus'))


label = predict(Mdl,X_ts) 

%%
clear all; close all; clc;

load cancer_dataset;

inputs = cancerInputs;
targets = cancerTargets;

% Create a Pattern Recognition Network
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize);


% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;


% Train the Network
[net,tr] = train(net,inputs,targets);

% Test the Network
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs)

% View the Network
view(net)
