clc,clear,close;
input_ecg=200;           %% input signal ECG
[M,fs,SAMPLES2READ]=read_ecg(input_ecg);   %% reading ECG Signal and header file
view=60;
ecg=M(1:SAMPLES2READ,1)-M(1:SAMPLES2READ,2);

[R_i,R_amp,S_i,S_amp,T_i,T_amp]=peakdetect(ecg,fs,view);
time_scale = length(ecg)/fs; % total time;

%% conditions
R_R = diff(R_i); % calculate the distance between each R wave
heart_rate=length(R_i)/(time_scale/60); % calculate heart rate
msgbox(strcat('Heart-rate is = ',mat2str(heart_rate)));

if heart_rate < 10
     msgbox('Irregular Rhythm','Asystole');
end

if heart_rate < 60
     msgbox('Irregular Rhythm','Arrythmia Bradycardia');
end

if heart_rate > 100
     msgbox('Irregular Rhythm','Arrythmia Tachycardia');
end

% % compute the min max R-R wave
% max_R_interval = max(R_R);
% min_R_interval = min(R_R);
% % detect arythmia if there is any irregularity
% if (max_R_interval/fs)-(min_R_interval/fs) > 0.16
%      msgbox('Irregular Rhythm','Arrythmia Detected');
% end

