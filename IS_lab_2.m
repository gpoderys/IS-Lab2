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

% 3. Skaičiuojamas tinklo atsakas
lr = 0.05;
for ind_n = 1:100000;
for indx = 1:length(x1)
    % pirmojo sluoksnio atsakas
    v1_1 = x1(indx)* w11_1 + b1_1;
    v2_1 = x1(indx)* w21_1 + b2_1;
    v3_1 = x1(indx)* w31_1 + b3_1;
    v4_1 = x1(indx)* w41_1 + b4_1;
    % aktyvavimo f-jos pritaikymas
    y1_1 = 1/(1+exp(-v1_1));
    y2_1 = 1/(1+exp(-v2_1));
    y3_1 = 1/(1+exp(-v3_1));
    y4_1 = 1/(1+exp(-v4_1));
    % antro sluoksnio atsakas
    v1_2 = y1_1*w11_2 + y2_1*w12_2 + y3_1*w13_2 + y4_1*w14_2 + b1_2;
    % aktyvavimo f-jos pritaikymas išėjimui
    y1_2 = tanh(v1_2);
    y = y1_2;
    % apsskaičiuojama klaida
    e = d(indx) - y;
end
end