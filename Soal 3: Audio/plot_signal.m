[x, Fs] = audioread('kereta.aac');
maxt = (length(x)-1)/Fs;
t = [0:1/Fs:maxt];

figure;
plot(t, x, 'b');
xlabel('Time(s)');
ylabel('Amplitude');
title('Sinyal Audio Palang Pintu Kereta');


