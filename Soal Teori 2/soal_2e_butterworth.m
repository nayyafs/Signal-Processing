% SOAL NOMOR 2e
% Filter Butterworth
% All frequency values are in Hz.
Fs = 1;  % Sampling Frequency

N   = 8;      % Order
Fc1 = 0.104;  % First Cutoff Frequency
Fc2 = 0.106;  % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
Hd = design(h, 'butter');

% Deklarasi beberapa sinyal cosinus.
fs = 1; % Frekuensi sampling (Hz)
t = 0:1/fs:1500; % Rentang waktu dari 0 hingga 1 detik dengan langkah 1/fs
x = 0.5 + cos(2*pi*0.1*t) + 0.1*cos(2*pi*0.105*t) + 0.001*cos(2*pi*0.111*t);

% Desain filter IIR bandpass Butterworth.
filtered_signal = filter(Hd, x);
filtered_signal = filtered_signal + 0.5;

% Menghitung respon frekuensi filter menggunakan freqz.
[H, Freq] = freqz(b, 1, 1024, fs);

% Plot respon frekuensi filter (amplitudo linear).
figure;
plot(Freq, abs(H));
title('Respon Frekuensi Filter');
xlabel('Frekuensi (Hz)');
ylabel('Amplitudo (linear)');

% Plot respon frekuensi filter (amplitudo dalam dB).
figure;
plot(Freq, 20*log10(abs(H)));
title('Respon Frekuensi Filter (dB)');
xlabel('Frekuensi (Hz)');
ylabel('Amplitudo (dB)');

% Plot respon fasa filter.
figure;
plot(Freq, angle(H));
title('Respon Fasa Filter');
xlabel('Frekuensi (Hz)');
ylabel('Fasa (radian)');

% Plot sinyal asli (input).
figure;
%subplot(3,1,2);
plot(t, x);
title('Sinyal Asli (Input)');
xlabel('Waktu (s)');
ylabel('Amplitudo (linear)');

% Plot sinyal output setelah filter.
figure;
%subplot(3,1,3);
plot(t, filtered_signal, 'LineWidth', 2);
title('Sinyal Output Setelah Filter Bandpass');
xlabel('Waktu (s)');
ylabel('Amplitudo (linear)');

% Filter data untuk t > 1000.
t_filtered = t(t > 1000);
output_filtered = filtered_signal(t > 1000);

% Plot sinyal asli (input) hanya untuk t > 1000.
figure;
plot(t_filtered, output_filtered);
title('Sinyal output untuk t > 1000');
xlabel('Waktu (s)');
ylabel('Amplitudo (linear)');

% Menghitung FFT dari filtered_signal.
fft_result = fft(filtered_signal);

% Menghitung magnitude spektrum FFT.
magnitude_spectrum = abs(fft_result);

% Menghitung frekuensi normalisasi.
frequencies = linspace(0, fs/2, length(filtered_signal)/2);

% Plot magnitude spektrum FFT.
figure;
plot(frequencies, magnitude_spectrum(1:length(frequencies)));
title('PSD dari Sinyal Output');
xlabel('Frekuensi (Hz)');
ylabel('Amplitudo (linear)');

% Menghitung respon impuls filter menggunakan impz.
impulse_response = impz(Hd, 500);

% Plot respon impuls filter.
figure;
stem(impulse_response);
title('Respon Impuls Filter');
xlabel('Sampel');
ylabel('Amplitudo');

% Menghitung respon step filter menggunakan stepz.
step_response = stepz(Hd, 500);

% Plot respon step filter.
figure;
plot(step_response);
title('Respon Step Filter');
xlabel('Sampel');
ylabel('Amplitudo');