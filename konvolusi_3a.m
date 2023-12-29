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

% Menghitung respon frekuensi filter menggunakan freqz.
[H, Freq] = freqz(b, 1, 1024, fs);

%implementasi filter dengan konvolusi
n = 1:999;
x = 0.5 + cos(2*pi*n/10) + 0.1*cos(2*pi*1.05*n/10)+0.001*cos(2*pi*1.11*n/10); 

filtered_signal = conv(x, b);
filtered_signal = filtered_signal(1:length(x));

figure;
plot(n, filtered_signal);
xlabel("Time (s)");
ylabel("Amplitude");
title("Sinyal Output Window-Based FIR Filter dengan Konvolusi");

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
