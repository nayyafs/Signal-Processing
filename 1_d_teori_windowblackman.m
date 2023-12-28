% Program untuk menampilkan fft dalam frekuensi analog dan digital
close all;clc;

L = 8100; % Panjang sinyal
n = 0:(L-1); % Vektor waktu/sampel

% Komponen sinyal
x1 = cos(2 * pi * (0.100) * n); % x1(n)
x2 = 0.1 * cos(2 * pi * (0.105) * n); % x2(n)
x3 = 0.001 * cos(2 * pi * (0.111) * n); % x3(n)

% Sinyal total
x = 0.5 + x1 + x2 + x3;

% Window blackman
blackman_window = 0.42 - 0.5 * cos(2 * pi * n / (L - 1)) + 0.08 * cos(4 * pi * n / (L - 1)); % Rumus window blackman

% Terapkan window ke sinyal
x_windowed = x .* blackman_window;

% Membuat plot sinyal x[n] setelah windowing
figure(3)
plot(n, x_windowed)
xlabel('n')
ylabel('x[n]')
title('Sinyal x[n] setelah Windowing')

% Frekuensi sampling
Fs = 1; % Frekuensi sampling adalah 1 sampel per detik

% N-DFT
N = 8192; % Nilai N yang diinginkan

% Menambahkan nol sebanyak N-L di akhir sinyal
x_padded = [x_windowed zeros(1, N-L)];

% Melakukan fft 
X = fft(x_padded);

% Menggeser spektrum setelah fft
X_shifted = fftshift(X);

% Mendapatkan magnitude dari spektrum
X_magnitude = abs(X_shifted);

% Membuat vektor frekuensi analog
f = (-N/2 : N/2-1) * Fs / N;

% Membuat vektor frekuensi digital (siklus per sampel)
f_digital = f / Fs;

% Membuat plot magnitude vs frekuensi analog
figure(1)
stem(f, X_magnitude)
xlabel('Frekuensi (Hz)')
ylabel('Magnitude')
title('Spektrum FFT dalam Frekuensi Analog')

% Membuat plot magnitude vs frekuensi digital
figure(2)
stem(f_digital, X_magnitude)
xlabel('Frekuensi (siklus per sampel)')
ylabel('Magnitude')
title('Spektrum FFT dalam Frekuensi Digital')
