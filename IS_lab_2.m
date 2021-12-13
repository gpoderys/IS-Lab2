close all
clear
clc

% 1. Duomenu paruosimas
x1 = [0.1:1/22:1];
x2 = [0.1:1/22:1];
d =  (1 + 0.6*cos(2*pi*x1/0.7)) + 0.3*sin(2*pi*x2)./2;
figure(1), plot(x1, d), grid on;

% 2. Pasirinkti struktūrą
% pirmo (paslėptojo) sluoksnio ryšių svoriai
w11_1 = randn(1);
w21_1 = randn(1);
w31_1 = randn(1);
w41_1 = randn(1);
b1_1 = randn(1);
b2_1 = randn(1);
b3_1 = randn(1);
b4_1 = randn(1);

% antro sluoksnio(išėjimo) ryšių svoriai
w11_2 = randn(1);
w12_2 = randn(1);
w13_2 = randn(1);
w14_2 = randn(1);
b1_2 = randn(1);
