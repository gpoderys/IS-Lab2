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
w12_1 = randn(1);
w13_1 = randn(1);
w14_1 = randn(1);
w21_1 = randn(1);
w22_1 = randn(1);
w23_1 = randn(1);
w24_1 = randn(1);
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
lr = 0.5;
for ind_n = 1:10000
for indx = 1:length(x1)
    % pirmojo sluoksnio atsakas
    v1_1 = x1(indx)* w11_1 + x2(indx)*w21_1 + b1_1;
    v2_1 = x1(indx)* w12_1 + x2(indx)*w22_1 + b2_1;
    v3_1 = x1(indx)* w13_1 + x2(indx)*w23_1 + b3_1;
    v4_1 = x1(indx)* w14_1 + x2(indx)*w24_1 + b4_1;
    % aktyvavimo f-jos pritaikymas
    y1_1 = 1/(1+exp(-v1_1));
    y2_1 = 1/(1+exp(-v2_1));
    y3_1 = 1/(1+exp(-v3_1));
    y4_1 = 1/(1+exp(-v4_1));
    % antro sluoksnio atsakas
    v1_2 = y1_1*w11_2 + y2_1*w12_2 + y3_1*w13_2 + y4_1*w14_2 + b1_2;
    % aktyvavimo f-jos pritaikymas išėjimui
    y = v1_2;
    % apsskaičiuojama klaida
    e = d(indx) - y;
    
    % 4. Ryšių svorių atnaujinimas
    % skaičiuojamas klaidos gradientas išėjimo sluoksnio neuronui
    delta1_2 = e;
    % skaičiuojamas klaidos gradientas paslepto sluoksnio neuronams
    delta1_1 = y1_1*(1 - y1_1)*delta1_2*w11_2;
    delta2_1 = y2_1*(1 - y2_1)*delta1_2*w12_2;
    delta3_1 = y3_1*(1 - y3_1)*delta1_2*w13_2;
    delta4_1 = y4_1*(1 - y4_1)*delta1_2*w14_2;
   % atnaujinami išėjimo sluoksnio svoriai
    w11_2 = w11_2 + lr*delta1_2.*y1_1;
    w12_2 = w12_2 + lr*delta1_2.*y2_1;
    w13_2 = w13_2 + lr*delta1_2.*y3_1;
    w14_2 = w14_2 + lr*delta1_2.*y4_1;
    b1_2 = b1_2 + lr*delta1_2;
   % atnaujinami paslėpto sluoksnio svoriai
   w11_1 = w11_1 + lr*delta1_1*x1(indx);
   w12_1 = w12_1 + lr*delta2_1*x1(indx);
   w13_1 = w13_1 + lr*delta3_1*x1(indx);
   w14_1 = w14_1 + lr*delta4_1*x1(indx);
   w21_1 = w21_1 + lr*delta1_1*x2(indx);
   w22_1 = w22_1 + lr*delta2_1*x2(indx);
   w23_1 = w22_1 + lr*delta3_1*x2(indx);
   w24_1 = w24_1 + lr*delta4_1*x2(indx);
   b1_1 = b1_1 + lr*delta1_1;
   b2_1 = b2_1 + lr*delta2_1;
   b3_1 = b3_1 + lr*delta3_1;
   b4_1 = b4_1 + lr*delta4_1;  
end
end

% Sistemos patikrinimas
Y = zeros(1, length(d));
for indx = 1:length(x1)
    % pirmojo sluoksnio atsakas
    v1_1 = x1(indx)* w11_1 + x2(indx)*w21_1 + b1_1;
    v2_1 = x1(indx)* w12_1 + x2(indx)*w22_1 + b2_1;
    v3_1 = x1(indx)* w13_1 + x2(indx)*w23_1 + b3_1;
    v4_1 = x1(indx)* w14_1 + x2(indx)*w24_1 + b4_1;
    % aktyvavimo f-jos pritaikymas
    y1_1 = 1/(1+exp(-v1_1));
    y2_1 = 1/(1+exp(-v2_1));
    y3_1 = 1/(1+exp(-v3_1));
    y4_1 = 1/(1+exp(-v4_1));
    % antro sluoksnio atsakas
    v1_2 = y1_1*w11_2 + y2_1*w12_2 + y3_1*w13_2 + y4_1*w14_2 + b1_2;
    % aktyvavimo f-jos pritaikymas išėjimui
    y = v1_2;
    Y(indx) = y;
end
hold on, plot(x1, Y, 'b+'),plot(x2, Y, 'r+'), hold off
