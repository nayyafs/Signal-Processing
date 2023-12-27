[x, Fs] = audioread('kereta.aac');
maxt = (length(x)-1)/Fs;
t = [0:1/Fs:maxt];

%diketahui sampling rate / Fs = 44100

dt = 1/Fs; %time interval 
t_discrete = 0:dt:maxt;
discrete_signal = interp1(t, x, t_discrete);

rect_window = ones(size(x)); %window rectangular
windowed_signal = discrete_signal.* rect_window;

%filter bandpass Butterworth orde 10
SOS = [1, 0, -1, 1, -1.98800673102712, 0.995228616340441;
       1, 0, -1, 1, -1.99087821724263, 0.995985631034686;
       1, 0, -1, 1, -1.98119207523506, 0.987928745583725;
       1, 0, -1, 1, -1.98371394687265, 0.989150667902059;
       1, 0, -1, 1, -1.97980918678060, 0.985852955569397];
G = [0.00710810273951807; 
     0.00710810273951807;
     0.00708302953631303;
     0.00708302953631303;
     0.00707352221530169;
     1];

y = windowed_signal;
for i = 1:size(SOS, 1)
    y = sosfilt(SOS(i, :), y)*G(i);
end

time_signal = (0:length(y)-1)/Fs;

figure;
plot(time_signal, y);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sinyal "tot..tot.." dari Audio Kereta');

output_signal = 'filtered_tot_sound.wav';
audiowrite(output_signal, y, Fs);


