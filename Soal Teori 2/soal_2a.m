%SOAL NOMOR 2A

% All frequency values are in Hz.
Fs = 1;  % Sampling Frequency

N             = 540;      % Order
Fc1           = 0.104;    % First Cutoff Frequency
Fc2           = 0.106;    % Second Cutoff Frequency
flag          = 'scale';  % Sampling Flag
SidelobeAtten = 40;       % Window Parameter
% Create the window vector for the design algorithm.
win = chebwin(N+1, SidelobeAtten);

% Calculate the coefficients using the FIR1 function.
b  = fir1(N, [Fc1 Fc2]/(Fs/2), 'bandpass', win, flag);
Hd = dfilt.dffir(b);

% Deklarasi beberapa sinyal cosinus.
fs = 1; % Frekuensi sampling (Hz)
t = 0:1/fs:1500; % Rentang waktu dari 0 hingga 1 detik dengan langkah 1/fs
x = 0.5 + cos(2*pi*0.1*t) + 0.1*cos(2*pi*0.105*t) + 0.001*cos(2*pi*0.111*t);

% Desain filter FIR bandpass Blackman-Harris.
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

% Filter data untuk t < 700.
t_filtered = t(t > 1000);
output_filtered = filtered_signal(t > 1000);

% Plot sinyal output hanya untuk t > 1000.
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

