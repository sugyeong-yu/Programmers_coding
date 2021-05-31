function [SDNN,RMSSD,pNN50,M_HR] = Time_HRV(t_rpeak,Fs)
%UNTITLED 이 함수의 요약 설명 위치
%   자세한 설명 위치
RRI=diff(t_rpeak)/Fs;
RRI(end+1)=RRI(end-1);

SDNN=std(RRI)*1000;
RMSSD=sqrt(mean(diff(RRI).^2))*1000;
dRRI=diff(RRI);
NN50=find(dRRI>0.05);
pNN50=(length(NN50)/length(dRRI))*100;

HR=60./RRI;
M_HR=mean(HR);
end

