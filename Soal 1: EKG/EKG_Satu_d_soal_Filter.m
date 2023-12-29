% Nama file: EKG_filter.m

% Load file EKG.mat
load('EKG.mat');
EKG = data;

% Parameter pengukuran
ADC = 500; % Jumlah sampel per detik
Fs = ADC; % Frekuensi sampling
t = (0:length(EKG) - 1) / Fs; % Vektor waktu

% Desain filter Butterworth
fc_low = 0.5; % Frekuensi cut-off rendah (Hz)
fc_high = 30; % Frekuensi cut-off tinggi (Hz)
order = 4; % Urutan filter

% Normalisasi frekuensi cut-off
Wn_low = fc_low / (Fs / 2);
Wn_high = fc_high / (Fs / 2);

% Desain filter Butterworth
[b, a] = butter(order, [Wn_low, Wn_high], 'bandpass');

% Gunakan filter pada sinyal EKG
filtered_EKG = filtfilt(b, a, EKG);

% Tentukan threshold untuk deteksi puncak
threshold = max(filtered_EKG) * 0.5; % Contoh: setengah dari nilai puncak maksimum

% Plot sinyal EKG asli dan hasil filter
figure;
subplot(2,1,1);
plot(t, EKG);
title('Sinyal EKG Asli');
xlabel('Waktu (detik)');
ylabel('Amplitudo');
grid on;

subplot(2,1,2);
plot(t, filtered_EKG);
title('Sinyal EKG Setelah Filter Bandpass');
xlabel('Waktu (detik)');
ylabel('Amplitudo');
grid on;

% Deteksi puncak R
[pks, locs] = findpeaks(filtered_EKG, 'MinPeakHeight', threshold); % threshold perlu disesuaikan

% Menghitung interval R-R
RR_intervals = diff(locs) / Fs; % Mengonversi indeks sampel ke detik

% Menghitung Heart Rate
HR = 60 ./ mean(RR_intervals); % Menggunakan rata-rata interval R-R

% Tampilkan Heart Rate
disp(['Heart Rate: ', num2str(HR), ' bpm']);
