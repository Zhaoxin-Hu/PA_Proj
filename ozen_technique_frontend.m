clc
clf
close all
clearvars

% input parameters
f = 28e9;
omega = 2*pi*f;
ZLPA = 6.2+1j*12.3;
ZPAOFF = -1j*17.6;
ZSLNA = 50+1j*70;
ZSWON = 4.4;
ZSWOFF = -1j*159.7;

% tuning inductance for PA
Lseries = abs(imag(ZPAOFF))/omega;
ZLPAtune = ZLPA-1j*omega*Lseries;

% boundary conditions
YLPAtune = 1/ZLPAtune;
YSLNA = 1/ZSLNA;
YSWON = 1/ZSWON;
YSWOFF = 1/ZSWOFF;
Y22 = YSLNA - YSWOFF;
% Y22 = 0.0171*exp(1j*deg2rad(67));
den = YSWON^2+abs(Y22)^2+2*real(Y22)*YSWON;
Y11re = real(YLPAtune)/(1-real(Y22)*(YSWON+real(Y22))/den);
Y11im = imag(YLPAtune)+Y11re*real(Y22)*imag(Y22)/den;
Y11 = Y11re+1j*Y11im;
Y12 = sqrt(real(Y11)*real(Y22));

% solutions given in the paper
Y11sol = 0.1323*exp(1j*deg2rad(35));
Y12sol = 0.02694;
Y22sol = 0.0171*exp(1j*deg2rad(67));

% verify the solutions
% (1)
RHS1 = Y11sol - Y12sol^2/(Y22+YSWON);
% (3)
RHS3 = Y22+YSWOFF;
% (12)
RHS12 = sqrt(real(Y11sol)*real(Y22));