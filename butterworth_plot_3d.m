Fs = 1;
nyquist_freq = Fs/2;
low_freq = 0.104/nyquist_freq;
high_freq = 0.106/nyquist_freq;

orde = 4;
[b, a] = butter(orde, [low_freq, high_freq], 'bandpass');

n = 0:999;
x = cos(2*pi*n/10) + 0.1*cos(2*pi*1.05*n/10)+0.001*cos(2*pi*1.11*n/10); 
x2 = 0.1*cos(2*pi*1.05*n/10);

filtered_signal = filter(b, a, x);

figure;
subplot(2, 1, 1);
plot(filtered_signal);
subplot(2, 1, 2);
plot(x2);

