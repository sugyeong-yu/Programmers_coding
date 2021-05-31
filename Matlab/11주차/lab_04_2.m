
%%
clear all;
% begin시작 몇초부터 몇초까지 불러올 수 있음
% 웹에서 바로불러오는 방법. 
data=rdsamp('fantasia/f1o01','begin','00:00:00','stop','00:01:00');
anno=rdann('meditation/data/C1med', 'qrs', 'type', 'N');

%%
clear all;
data =rdsamp('drivedb/drive01');

%%
clear all;
data =rdsamp('mitdb/101');
anno = rdann('mitdb/101', 'atr', 'type', 'N');



%%
% web에서 받기
% 예. from fantasia DB의 f1o01 데이터
data1 = rdsamp('fantasia/f1o01','begin','00:00:00','stop','00:01:00'); % 시간 설정 가능
data1 = rdsamp('fantasia/f1o01'); % 전체

% 예. from meditation DB의 C1med 데이터 (annotation만 있음)
anno1 = rdann('meditation/data/C1med', 'qrs', 'type', 'N');

% 예. from stdb DB의 300 데이터
data2 = rdsamp('stdb/300'); % 전체
anno2 = rdann('stdb/300', 'atr', 'type', 'N');

figure;
subplot(211); plot(data2(:,2)); axis tight;
subplot(212); plot(data2(:,3)); axis tight;
%%
% 다운 후 받기
data = rdsamp('f1o01');

anno = rdann('C1med', 'qrs', 'type', 'N');
