%SOAL NOMOR 2C

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

% Menghitung respon impuls filter menggunakan impz.
impulse_response = impz(Hd);

% Menentukan panjang yang diinginkan (misalnya, 50 sampel).
desired_length = 2000;

% Potong respon impuls filter menjadi panjang yang diinginkan.
cut_impulse_response = impulse_response(1:desired_length);

% Plot respon impuls filter yang dipotong.
figure;
stem(cut_impulse_response);
title('Respon Impuls Filter 2000 Sampel');
xlabel('Sampel');
ylabel('Amplitudo');

% Menghitung respon frekuensi filter menggunakan freqz.
[Hfir, Freqfir] = freqz(cut_impulse_response, 1);

% Plot respon frekuensi filter (amplitudo linear).
figure;
plot(Freqfir, abs(Hfir));
title('Respon Frekuensi Filter 2000 Sampel');
xlabel('Frekuensi (Hz)');
ylabel('Amplitudo (linear)');

% Plot respon frekuensi filter (amplitudo dalam dB).
figure;
plot(Freqfir, 20*log10(abs(Hfir)));
title('Respon Frekuensi Filter 2000 Sampel (dB)');
xlabel('Frekuensi (Hz)');
ylabel('Amplitudo (dB)');

% Menghitung respon step filter menggunakan stepz.
step_response = stepz(cut_impulse_response);

% Plot respon step filter.
figure;
plot(step_response);
title('Respon Step Filter 2000 Sampel');
xlabel('Sampel');
ylabel('Amplitudo');