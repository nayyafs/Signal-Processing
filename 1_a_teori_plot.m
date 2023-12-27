close all;clc;
L = 100; % Panjang sinyal : bisa diganti ke menjadi 25,50,100
n = 0:(L-1); % Vektor waktu/sampel

% Komponen sinyal
x1 = cos(2 * pi * (0.100) * n); % x1(n)
x2 = 0.1 * cos(2 * pi * (0.105) * n); % x2(n)
x3 = 0.001 * cos(2 * pi * (0.111) * n); % x3(n)

% Sinyal total
x = 0.5 + x1 + x2 + x3;

% Plot gambar sinyal x1
figure
stem(n, x1);
xlabel('Sampel');
ylabel('Amplitudo');
title('Sinyal Diskrit x1');
grid on;

% Plot gambar sinyal x2
figure
stem(n, x2);
xlabel('Sampel');
ylabel('Amplitudo');
title('Sinyal Diskrit X2');
grid on;

% Plot gambar sinyal x3
figure
stem(n, x3);
xlabel('Sampel');
ylabel('Amplitudo');
title('Sinyal Diskrit X3');
grid on;

% Plot gambar sinyal x
figure
stem(n, x);
xlabel('Sampel');
ylabel('Amplitudo');
title('Sinyal Diskrit x[n]');
grid on;
