function logfO2 = logfO2_CO_CO2(T_degC,CO2_percent)
% Calculate log(fO2) for a CO–CO2 mix
% T in °C
% CO2_percent in %

fO2 = logspace(1,-40,1e3);
log10_fO2 = log10(fO2);

T_K = T_degC + 273.15;
delta_G_0_kcal = 62.110326-0.02144446*T_degC+0.0000004720325*T_degC.^2-0.0000000000045574288*T_degC.^3-7.3430182E-15*T_degC.^4; % units: kcal
delta_G_0_J = delta_G_0_kcal * 1000 * 4.184; % units: J
K = exp(-delta_G_0_J/(8.314 * T_K)); % reaction constant
R_m = (K - 3*K * fO2 - 2 * (fO2).^(3/2))./(2*K*fO2 + fO2 + (fO2).^(3/2) + (fO2).^(1/2)); % from Deines et al. (1974)
CO2_percent_intermed = 100./(1+R_m);

logfO2 = interp1(CO2_percent_intermed, log10_fO2, CO2_percent);
% fprintf('For CO2 = %4.2f%% at T = %4.0f°C, estimated log(fO2) = %f\n', CO2_percent, T_degC, logfO2);
end