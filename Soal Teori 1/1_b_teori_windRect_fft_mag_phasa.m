close all;clc;
% Define the signal parameters
N = 100; % number of samples
n = 0:N-1; % sample indices
x = 0.5 + cos(2*pi*0.1*n) + 0.1*cos(2*pi*0.105*n) + 0.001*cos(2*pi*0.111*n); % signal

% Perform windowing rectanguler
w = ones(1,N); % rectanguler window function
xw = x.*w; % windowed signal

% Perform FFT
X = fft(xw); % FFT of windowed signal
f = (0:N-1)/N; % normalized frequency vector


% Perform FFT before window
z = fft(x); % FFT of windowed signal
f = (0:N-1)/N; % normalized frequency vector

% Plot the results x[n]
figure
subplot(2,1,1); % create a subplot
stem(n,xw); % plot the windowed signal as discrete signal
xlabel('n'); % label the x-axis
ylabel('x[n]'); % label the y-axis
title('x[n] after Windowed signal'); % add a title


subplot(2,1,2); % create another subplot
stem(n,x); % plot the windowed signal as discrete signal
xlabel('n'); % label the x-axis
ylabel('x[n]'); % label the y-axis
title('x[n] '); % add a title


% Plot the results fft 

figure 
subplot(2,1,1); % create another subplot
stem(f,abs(X)); % plot the magnitude spectrum as discrete signal
xlabel('f(Hz)'); % label the x-axis
ylabel('|X(f)|'); % label the y-axis
title('Magnitude spectrum (FFT signal) after windowing'); % add a title

subplot(2,1,2); % create another subplot
stem(f,abs(z)); % plot the magnitude spectrum as discrete signal
xlabel('f(Hz)'); % label the x-axis
ylabel('|X(f)|'); % label the y-axis
title('Magnitude spectrum (FFT signal) before windowing'); % add a title

% Plot the results phase spectrum
figure
subplot(2,1,1); % create another subplot
stem(f,angle(X)); % plot the phase spectrum as discrete signal
xlabel('f(Hz)'); % label the x-axis
ylabel('\angle X(f)'); % label the y-axis
title('Phase spectrum (FFT signal) after windowing'); % add a title

subplot(2,1,2); % create another subplot
stem(f,angle(z)); % plot the phase spectrum as discrete signal
xlabel('f(Hz)'); % label the x-axis
ylabel('\angle X(f)'); % label the y-axis
title('Phase spectrum (FFT signal) before windowing'); % add a title
