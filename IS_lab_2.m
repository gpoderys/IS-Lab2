close all
clear
clc

% 1. Duomenu paruosimas
x1 = [0.1:1/22:1];
x2 = [0.1:1/22:1];
d =  (1 + 0.6*cos(2*pi*x1/0.7)) + 0.3*sin(2*pi*x2)./2;
figure(1), plot(x1, d), grid on;

