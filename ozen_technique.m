% Ozen Technique Ideal Design Example
clc
clf
close all
clearvars

theta = deg2rad(-41);
Z11 = 116;
Z12 = -96*exp(-1j*theta);
Z21 = Z12;
Z22 = 30.55+104.66*exp(-1j*2*theta);
z_params = [Z11, Z12; Z21, Z22];

s_params = z2s(z_params);
s_params_dB = 20*log(abs(s_params))