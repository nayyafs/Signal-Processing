% All frequency values are normalized to 1.
fs = 1;
N             = 480;      % Order
Fc1           = 0.191;    % First Cutoff Frequency
Fc2           = 0.205;    % Second Cutoff Frequency
flag          = 'scale';  % Sampling Flag
SidelobeAtten = 25;       % Window Parameter

% Create the window vector for the design algorithm.
win = chebwin(N+1, SidelobeAtten);

% Calculate the coefficients using the FIR1 function.
b  = fir1(N, [Fc1 Fc2], 'stop', win, flag);
Hd = dfilt.dffir(b);

% All frequency values are normalized to 1.
N1              = 480;      % Order
Fc2_1           = 0.220;    % First Cutoff Frequency
Fc2_2           = 0.230;    % Second Cutoff Frequency
flag1           = 'scale';  % Sampling Flag
SidelobeAtten1  = 25;       % Window Parameter

% Create the window vector for the design algorithm.
win1 = chebwin(N1+1, SidelobeAtten1);

% Calculate the coefficients using the FIR1 function.
b1  = fir1(N1, [Fc2_1 Fc2_2], 'stop', win1, flag);
Hd1 = dfilt.dffir(b1);

%implementasi filter dengan konvolusi
n = 0:999;
x = 0.5 + cos(2*pi*n/10) + 0.1*cos(2*pi*1.05*n/10)+0.001*cos(2*pi*1.11*n/10); 

y1 = conv(x, b);

y2 = conv(y1, b1);
y2 = y2(1:length(x));

output = y2 - 0.5;

figure;
plot(n, output);