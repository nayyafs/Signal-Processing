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

%implementasi filter dengan DFT
n = 1:1000;
x = 0.5 + cos(2*pi*n/10) + 0.1*cos(2*pi*1.05*n/10)+0.001*cos(2*pi*1.11*n/10); 
x2 = 0.1*cos(2*pi*1.05*n/10);

b_dft = fft(b, length(x));
x_dft = fft(x);

filter_fft = (x_dft.* b_dft);

filtered_signal = ifft(filter_fft);

figure;
subplot(2, 1, 1);
plot(real(filtered_signal));
xlabel("Time(s)");
ylabel("Amplitude");
title("Sinyal Output Window-Based FIR Filter dengan Perkalian DFT");
subplot(2, 1, 2);
plot(n, x2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sinyal x2(n) sebagai Referensi');


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
