function [LF,HF,TF,VLF,nLF,nHF,LFHF] = FD_HRV(SR, R_PEAK_IDX)

RRI  =  diff(R_PEAK_IDX)/SR;
RRI(end+1)  =  RRI(end-1);
%t_rpeak(end) = []; or %t_rpeak(1) = []; 둘중하나만 하면됨 

%Frequency domain
t_i =  R_PEAK_IDX/SR;
t   =  R_PEAK_IDX(1)/SR:1/SR:R_PEAK_IDX(end)/SR;
% t   =  t_rpeak(1)/Fs:1/4:t_rpeak(end)/Fs; for 4Hz interpolation


RRI_INTERPOL = interp1(t_i(1:end), RRI, t, 'PCHIP');

[p, f]=periodogram(RRI_INTERPOL,[],length(RRI_INTERPOL), SR);
%[p, f]=periodogram(RRI_INTERPOL,[],length(RRI_INTERPOL), 4);for 4Hz 

vlf_1 = 2;
vlf_2 = length(find(f < 0.04));

lf_1 = vlf_2+1;
lf_2 = length(find(f < 0.15));

hf_1 = lf_2+1;
hf_2 = length(find(f < 0.4));

LF =  simpson_int(p(lf_1:lf_2), f(2))*1e6; %(f,res)
HF =  simpson_int(p(hf_1:hf_2), f(2))*1e6;
TF =  simpson_int(p(2:hf_2), f(2))*1e6;
VLF =  TF-(LF + HF);

nLF = LF./(LF + HF);
nHF = HF./(LF + HF);
LFHF = LF./HF;

