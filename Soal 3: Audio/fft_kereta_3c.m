[x, Fs] = audioread('kereta.aac');
maxt = (length(x)-1)/Fs;
t = [0:1/Fs:maxt];

%diketahui sampling rate / Fs = 44100

dt = 1/Fs; %time interval 
t_discrete = 0:dt:maxt;
discrete_signal = interp1(t, x, t_discrete);

rect_window = ones(size(x));    %window rectangular
windowed_signal = discrete_signal.* rect_window;

N = length(windowed_signal);

fft_signal = fft(windowed_signal);

P = abs(fft_signal)/N;

P = P(1:N/2+1);
P(2:end-1) = 2*P(2:end-1);

freq = (0:(N/2))*Fs/N;

figure;
plot(freq, P);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('FFT Sinyal Audio Kereta');
