[x, Fs] = audioread('kereta.aac');
maxt = (length(x)-1)/Fs;
t = [0:1/Fs:maxt];

%diketahui sampling rate / Fs = 44100

dt = 1/Fs; %time interval 
t_discrete = 0:dt:maxt;
discrete_signal = interp1(t, x, t_discrete);

rect_window = ones(size(x)); %window rectangular
windowed_signal = discrete_signal.* rect_window;

SOS = [1, 0, -1, 1, -1.98246663776642, 0.995330108704695;
       1, 0, -1, 1, -1.98590144290272, 0.995884071827774;
       1, 0, -1, 1, -1.97588138602666, 0.988093494855791;
       1, 0, -1, 1, -1.97854471715262, 0.988985742362779;
       1, 0, -1, 1, -1.97457621539224, 0.985852955569401];

G = [0.00710810273951609;
     0.00710810273951609;
     0.00710810273951609;
     0.00708302953631106;
     0.00707352221529973;
     1];

y = x;
for i = 1:size(SOS, 1)
    y = sosfilt(SOS(i, :), y)*G(i);
end

time_signal = (0:length(y)-1)/Fs;

figure;
plot(time_signal, y);

xlabel('Time (s)');
ylabel('Amplitude');
title('Sinyal "tet..tet.." dari Audio Kereta');

output_signal = 'filtered_tet_sound.wav';
audiowrite(output_signal, y, Fs);


