clear all; close all; clc;

load fisheriris;

tr_s = (1:1:150)';
ts_s = [46:50, 96:100, 146:150]';
tr_s(ts_s,:) = [];

X_tr = meas(tr_s,3:4);
Y_tr = species(tr_s,:);

X_ts = meas(ts_s,3:4);
Y_ts = species(ts_s,:);


Mdl = fitcknn(X_tr,Y_tr,'NumNeighbors',3,'Standardize',1);

label = predict(Mdl,X_ts) 

%%
nX_tr = [];
std_v  = [];
mean_v = [];

for k=1:1:2
    std_v(k,1) =  std(X_tr(:,k));
    mean_v(k,1) =  mean(X_tr(:,k));
    nX_tr(:,k) = (X_tr(:,k) - mean_v(k,1))./std_v(k,1);
end

[coeff,score,latent,tsquared,explained,mu] = pca(nX_tr);

pca_res = [];
for k=1:1:15
    for j=1:1:2
        ts_s(k, j) = (X_ts(k, j) - mean_v(j,1)) / std_v(j,1);
    end
    
    pca_res(k, :) = ts_s(k,:)*coeff
end

figure;
gscatter(nX_tr(:,1), nX_tr(:,2), Y_tr); hold on;
gscatter(ts_s(:,1), ts_s(:,2), Y_ts, 'k', 'do*'); hold on;

figure;
gscatter(score(:,1), score(:,2), Y_tr); hold on;
gscatter(pca_res(:,1), pca_res(:,2), Y_ts, 'k', 'do*'); hold on;

Mdl = fitcknn(score(:,1),Y_tr,'NumNeighbors',3,'Standardize',1);

label = predict(Mdl,pca_res) 
