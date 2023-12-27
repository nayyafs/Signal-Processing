% Program untuk menampilkan fft dalam frekuensi analog dan digital
close all;clc;

L = 100; % Panjang sinyal
n = 0:(L-1); % Vektor waktu/sampel

% Komponen sinyal
x1 = cos(2 * pi * (0.100) * n); % x1(n)
x2 = 0.1 * cos(2 * pi * (0.105) * n); % x2(n)
x3 = 0.001 * cos(2 * pi * (0.111) * n); % x3(n)

% Sinyal total
x = 0.5 + x1 + x2 + x3;

% Window rektangular
rect_window = ones(1, L);

% Terapkan window ke sinyal
x_windowed = x .* rect_window;

% Frekuensi sampling
Fs = 1; % Frekuensi sampling adalah 1 sampel per detik

% N-DFT
X = fft(x_windowed);

% Menggeser spektrum setelah fft
X_shifted = fftshift(X);

% Mendapatkan magnitude dari spektrum
X_magnitude = abs(X_shifted);

% Hitung vektor frekuensi analog dan digital
f_digital = linspace(-Fs/2, Fs/2, length(x_windowed)); % vektor frekuensi digital
f_analog = f_digital * Fs; % vektor frekuensi analog

% Plot spektrum dengan frekuensi analog
figure;
stem(f_analog, X_magnitude);
xlabel('Frekuensi (siklus per sampel)');
ylabel('Magnitude');
title('Spektrum Sinyal dalam Frekuensi Analog');
grid on;

% Plot spektrum dengan frekuensi digital
figure;
stem(f_digital, X_magnitude);
xlabel('Frekuensi (radian per sampel)');
ylabel('Magnitude');
title('Spektrum Sinyal dalam Frekuensi Digital');
grid on;