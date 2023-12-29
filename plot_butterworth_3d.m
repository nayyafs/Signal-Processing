% Filter Butterworth
% All frequency values are in Hz.
Fs = 1;  % Sampling Frequency

N   = 8;      % Order
Fc1 = 0.104;  % First Cutoff Frequency
Fc2 = 0.106;  % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
Hd = design(h, 'butter');

%implementasi filter
n = 1:1000;
x = 0.5 + cos(2*pi*n/10) + 0.1*cos(2*pi*1.05*n/10)+0.001*cos(2*pi*1.11*n/10); 
filtered_signal = filter(Hd, x);

figure;
plot(n, filtered_signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sinyal Output Hasil Filter IIR Sederhana');

%periksa hasil output dengan fft
N = length(filtered_signal);

fft_signal = fft(filtered_signal);

P = abs(fft_signal)/N;

P = P(1:N/2+1);
P(2:end-1) = 2*P(2:end-1);

freq = (0:(N/2))*Fs/N;

figure;
plot(freq, P);
xlabel('Frekuensi (Hz)');
ylabel('Magnitude');
title('FFT Sinyal Output Hasil Filter');

