% Nama file: power_spectrum_EKG.m

% Load file EKG.mat
load('EKG.mat');
EKG = data;

% Parameter pengukuran
ADC = 500; % Jumlah sampel per detik
Fs = 1 / ADC; % Frekuensi sampling
t = (0:length(EKG) - 1) * Fs; % Vektor waktu

% Hitung Transformasi Fourier dari sinyal EKG
N = length(EKG);
frequencies = (0:N-1) * Fs / N;
power_spectrum = abs(fft(EKG) / N).^2;

psdb=20*log10(power_spectrum);

% Plot Spektrum Daya
figure;

% Hanya tampilkan setengah frekuensi karena sinyal real
plot(frequencies(1:N/2), psdb(1:N/2));
title('Spektrum Daya Sinyal EKG');
xlabel('Frekuensi (Hz)');
ylabel('Spektrum Daya (dB)');

% Menyertakan grid untuk mempermudah pembacaan
grid on;
