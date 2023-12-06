function WRe = WRe(raw_mV)
% Temperature conversion for the WRe5–26 thermocouple
% Input: thermocouple reading in mV
% Output: temperature in °C
% Source: https://catalysts.basf.com/files/literature-library/BASF-EMFTable-W5RevsW26Re.pdf

% Low-T coefficients (0–783°C)
c_0 = 0.0000000;
c_1 = 1.3406032e-2;
c_2 = 1.1924992e-5;
c_3 = -7.9806354e-9;
c_4 = -5.0787515e-12;
c_5 = 1.3164197e-14;
c_6 = -7.9197332e-18;

% High-T coefficients (783–2315°C)
C_0 = 4.0528823e-1;
C_1 = 1.1509355e-2;
C_2 = 1.5696453e-5;
C_3 = -1.3704412e-8;
C_4 = 5.2290873e-12;
C_5 = -9.2082758e-16;
C_6 = 4.5245112e-20;

% producing an array of T values (°C)
low_T = linspace(0.0,783.0,333);
high_T = linspace(783.0,2315.0,667);

% calculating the mV values for the arrays
low_T_mV = c_0 + c_1*low_T + c_2*low_T.^2 + c_3*low_T.^3 + c_4*low_T.^4 + c_5*low_T.^5 + c_6*low_T.^6;
high_T_mV = C_0 + C_1*high_T + C_2*high_T.^2 + C_3*high_T.^3 + C_4*high_T.^4 + C_5*high_T.^5 + C_6*high_T.^6;

% combining the low-T and high-T arrays together into one
mV = [low_T_mV,high_T_mV];
sample_T = [low_T,high_T];

% interpolating
WRe = interp1(mV,sample_T,raw_mV);
end