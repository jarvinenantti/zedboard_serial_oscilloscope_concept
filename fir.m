%Adb  = 40dB
%Fs   = 1 MHz
%df   = 50 kHz
%N    = 36, odd 37 => delay (n-1)/2

close all;
clear all;
clf;


f1 = 310000;
f2 = 350000;
delta_f = f2-f1;
Fs = 1000000;
dB  = 30;
N = dB*Fs/(22*delta_f);

f =  [f1 ]/(Fs/2);
hc = fir1(round(N)-1, f,'high'); %for high pass


figure;
plot((-0.5:1/4096:0.5-1/4096)*Fs,20*log10(abs(fftshift(fft(hc,4096)))));
axis([0 400000 -60 20]);
title('Filter Frequency Response');
grid on;

x = sin(2*pi*[1:1000]*50000/Fs) +  sin(2*pi*[1:1000]*20000/Fs) + sin(2*pi*[1:1000]*250000/Fs)  + sin(2*pi*[1:1000]*350000/Fs);

sig = 20*log10(abs(fftshift(fft(x,4096))));
xf = filter(hc,1,x);

figure;
subplot(211);
plot(x);
title('Sinusoid with frequency components 20000, 50000, 250000, and 350000 Hz');


subplot(212);
plot(xf);
title('Filtered Signal');
xlabel('time');
ylabel('amplitude');


x= (x/sum(x))/20;
sig = 20*log10(abs(fftshift(fft(x,4096))));
xf = filter(hc,1,x);

figure;
subplot(211);
plot((-0.5:1/4096:0.5-1/4096)*Fs,sig);
hold on;
plot((-0.5:1/4096:0.5-1/4096)*Fs,20*log10(abs(fftshift(fft(hc,4096)))),'color','r');
hold off;
axis([0 400000 -60 10]);
title('Input to filter - 4 Sinusoids');
grid on;
subplot(212);
plot((-0.5:1/4096:0.5-1/4096)*Fs,20*log10(abs(fftshift(fft(xf,4096)))));
axis([0 400000 -60 10]);
title('Output from filter');
xlabel('Hz');
ylabel('dB');
grid on;