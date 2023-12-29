% Memuat file .mat
load('EMG_IEMG.mat');
myData = data;
emgSignal = myData(:, 1);

% Contoh penggunaan bandstop filter untuk menghilangkan frekuensi 60 Hz
fs = 500;  % Frekuensi sampel (disesuaikan dengan kondisi Anda)
f_notch = 60;  % Frekuensi yang akan dihilangkan
bw_notch = 10;  % Lebar pita filter
notch_filter = designfilt('bandstopiir','FilterOrder',2, ...
                           'HalfPowerFrequency1',f_notch-bw_notch/2, ...
                           'HalfPowerFrequency2',f_notch+bw_notch/2, ...
                           'DesignMethod','butter','SampleRate',fs);
emg_filtered = filtfilt(notch_filter, emgSignal);

% Contoh pemulusan dengan moving average
window_size = 100;  % Ukuran jendela pemulusan (disesuaikan dengan kondisi Anda)
moving_avg_filter = ones(1, window_size) / window_size;
iemg = conv(emg_filtered.^2, moving_avg_filter, 'same');

% Menampilkan data kolom pertama
figure;
subplot(2, 1, 1);
plot(myData(:, 1));
title('Data EMG Kolom Pertama');
xlabel('Waktu');
ylabel('Amplitudo');

% Menampilkan data kolom kedua
subplot(2, 1, 2);
plot(myData(:, 2));
title('Data EMG Kolom Kedua');
xlabel('Waktu');
ylabel('Amplitudo');

% Menghitung PSD dari kolom pertama
[pxx1, f1] = pwelch(myData(:, 1), [], [], [], fs); % Fs adalah frekuensi sampel, sesuaikan dengan data Anda

% Menghitung PSD dari kolom kedua
[pxx2, f2] = pwelch(myData(:, 2), [], [], [], fs);

% Menampilkan hasil PSD
figure;

% Grafik PSD untuk kolom pertama
subplot(2, 1, 1);
plot(f1, 10*log10(pxx1));
title('PSD Kolom Pertama');
xlabel('Frekuensi (Hz)');
ylabel('Power/Frekuensi (dB/Hz)');

% Grafik PSD untuk kolom kedua
subplot(2, 1, 2);
plot(f2, 10*log10(pxx2));
title('PSD Kolom Kedua');
xlabel('Frekuensi (Hz)');
ylabel('Power/Frekuensi (dB/Hz)');

% Memperoleh sinyal EMG dari kolom pertama (gantilah indeks kolom sesuai kebutuhan)
emgSignal = myData(:, 1);

% Rectification: Mengubah sinyal menjadi positif
rectifiedSignal = abs(emgSignal);

% Menentukan panjang jendela (window length) untuk moving average
windowLength = 100;  % Sesuaikan panjang jendela dengan kebutuhan

% Menerapkan moving average untuk menghasilkan IEMG
iemgSignal = movmean(rectifiedSignal, windowLength);

% Menampilkan sinyal EMG dan IEMG
figure;
subplot(2, 1, 1);
plot(emgSignal);
title('Sinyal EMG');
xlabel('Waktu');
ylabel('Amplitudo');

subplot(2, 1, 2);
plot(iemgSignal);
title('IEMG (Envelope)');
xlabel('Waktu');
ylabel('Amplitudo');

% Hilbert Transform untuk mendapatkan envelope
hilbertTransform = hilbert(emgSignal);
hilbertEnvelope = abs(hilbertTransform);

% Menampilkan sinyal EMG dan IEMG dengan Hilbert Transform
figure;
subplot(2, 1, 1);
plot(emgSignal);
title('Sinyal EMG');
xlabel('Waktu');
ylabel('Amplitudo');

subplot(2, 1, 2);
plot(hilbertEnvelope);
title('IEMG (Envelope) dengan Hilbert Transform');
xlabel('Waktu');
ylabel('Amplitudo');

figure;
subplot(3,1,1);
plot(emgSignal);
title('Sinyal EMG Asli');

subplot(3,1,2);
plot(emg_filtered);
title('Sinyal EMG Setelah Filtering');

subplot(3,1,3);
plot(iemg);
title('IEMG');

window = hamming(256); % Fungsi jendela, dapat diganti sesuai kebutuhan
overlap = 128; % Jumlah sample tumpang tindih antara jendela

% Menghitung PSD dengan pwelch
[psd, f] = pwelch(emg_filtered, window, overlap, [], fs);

% Plot PSD
figure;
plot(f, 10*log10(psd));
title('Power Spectral Density (PSD)');
xlabel('Frekuensi (Hz)');
ylabel('PSD');