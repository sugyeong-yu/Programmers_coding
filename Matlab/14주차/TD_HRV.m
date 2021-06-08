function [SDNN,RMSSD,pNN50,M_HR] = TD_HRV(Fs, R_PEAK_IDX)

RRI=diff(R_PEAK_IDX)/Fs;
RRI(end+1)=RRI(end-1);
%t_rpeak(end) = []; or %t_rpeak(1) = [];

% Time domain
SDNN= std(RRI)*1000;
RMSSD= sqrt(mean(diff(RRI).^2))*1000;

dRRI = diff(RRI);
NN50 = find(dRRI>0.05); % 50ms
pNN50= (length(NN50)/length(dRRI))*100;

HR  =  60./RRI;
M_HR= mean(HR);

