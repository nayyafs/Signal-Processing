% Nama file: read_display_EKG.m

% Load file EKG.mat
load('EKG.mat');
EKG=data;

% Parameter pengukuran
ADC = 5000; % Jumlah sampel per detik
Fs = 1 / ADC; % Frekuensi sampling
t = (0:length(EKG) - 1) * Fs; % Vektor waktu

% Plot sinyal EKG dalam domain waktu
figure;
plot(t, EKG);
title('Sinyal EKG dalam Domain Waktu');
xlabel('Waktu (milisecond)');
ylabel('Amplitudo');

% Menyertakan grid untuk mempermudah pembacaan
grid on;
