[x, Fs] = audioread('kereta.aac');
maxt = (length(x)-1)/Fs;
t = [0:1/Fs:maxt];

%diketahui sampling rate / Fs = 44100

dt = 1/Fs; %time interval 
t_discrete = 0:dt:maxt;
discrete_signal = interp1(t, x, t_discrete);

rect_window = ones(size(x));    %window rectangular
windowed_signal = discrete_signal.* rect_window;

start_sample = 1;
end_sample = start_sample + 1213539;
window_signal = windowed_signal(start_sample:end_sample);

window_size = 220;
overlap = 110;
nfft = 220;

spectrogram_data = spectrogram(window_signal, window_size, overlap, nfft, Fs);
time_vector = 0:(length(window_signal)-1)/Fs;
freq_vector = 0:Fs/nfft:Fs/2;

figure;
imagesc(time_vector, freq_vector, 10*log10(abs(spectrogram_data)));
colorbar;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Spectogram of Kereta')

