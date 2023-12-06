function PtRh = PtRh(raw_mV)
% Temperature conversion for the Pt–Pt13Rh thermocouple
% Input: thermocouple reading in mV
% Output: temperature in °C
% Source: TC Ltd flipbook
% Compare to: https://catalysts.basf.com/files/literature-library/BASF-EMFTable-PtvsPt13Rh.pdf

% Low-T coefficients (-50–1064.18°C)
a_1 = 5.28961729765;
a_2 = 1.39166589782e-2;
a_3 = -2.38855693017e-5;
a_4 = 3.56916001063e-8;
a_5 = -4.62347666298e-11;
a_6 = 5.00777441034e-14;
a_7 = -3.73105886191e-17;
a_8 = 1.57716482367e-20;
a_9 = -2.81038625251e-24;

% High-T coefficients (1064.18–1664.5°C)
A_0 = 2.95157925316e3;
A_1 = -2.52061251332;
A_2 = 1.59564501865e-2;
A_3 = -7.64085947576e-6;
A_4 = 2.05305291024e-9;
A_5 = -2.93359668173e-13;

% producing an array of T values (°C)
low_T = linspace(-50.0,1064.18,639);
high_T = linspace(1064.18,1664.5,361);

% calculating the mV values for the arrays
low_T_microV = a_1*low_T + a_2*low_T.^2 + a_3*low_T.^3 + a_4*low_T.^4 + a_5*low_T.^5 + a_6*low_T.^6 + a_7*low_T.^7 + a_8*low_T.^8 + + a_9*low_T.^9;
high_T_microV = A_0 + A_1*high_T + A_2*high_T.^2 + A_3*high_T.^3 + A_4*high_T.^4 + A_5*high_T.^5;

low_T_mV = low_T_microV.*1e-3;
high_T_mV = high_T_microV.*1e-3;

% combining the low-T and high-T arrays together into one
mV = [low_T_mV,high_T_mV];
sample_T = [low_T,high_T];

% interpolating
PtRh = interp1(mV,sample_T,raw_mV);
end