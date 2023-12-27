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
dft_signal = fft(windowed_signal);
dft_signal = dft_signal(1:N/2+1);
psd_signal = (1/(Fs*N))*abs(dft_signal).^2;
psd_signal(2:end-1) = 2*psd_signal(2:end-1);
freq = 0:Fs/N:Fs/2;

figure;
plot(freq, pow2db(psd_signal));
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
title('Power Spectral Density of Kereta');