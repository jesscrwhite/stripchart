function logfO2 = logfO2_H2_CO2(T_degC,CO2_percent)
% Calculate log(fO2) for a H2–CO2 mix
% T in °C
% CO2_percent in %

fO2 = logspace(1,-40,1e3);
log10_fO2 = log10(fO2);

T_K = T_degC + 273.15;
delta_G_0_1_kcal = 62.110326-0.02144446*T_degC+0.0000004720325*T_degC.^2-0.0000000000045574288*T_degC.^3-7.3430182E-15*T_degC.^4; % units: kcal
delta_G_0_1_J = delta_G_0_1_kcal * 1000 * 4.184; % units: J
K_1 = exp(-delta_G_0_1_J/(8.314 * T_K)); % reaction constant
delta_G_0_3_kcal = 55.025254 - 1.1212207e-2 * T_degC - 2.0800406e-6 * T_degC.^2 + 7.6484887e-10 * T_degC.^3 - 1.1232833e-13 * T_degC.^4; % units: kcal. % from Deines et al. (1974), p.12
delta_G_0_3_J = delta_G_0_3_kcal * 1000 * 4.184; % units: J
K_3 = exp(-delta_G_0_3_J/(8.314 * T_K)); % reaction constant
a = K_1 ./ (K_1 + (fO2).^(1/2));
b = (fO2).^(1/2) ./ (K_3 + (fO2).^(1/2));
R_m_3 = ((a).*(1-fO2) - 2*(fO2)) ./ ((b).*(1-(fO2)) + 2*(fO2));
CO2_percent_intermed = 100./(1+R_m_3);

logfO2 = interp1(CO2_percent_intermed, log10_fO2, CO2_percent);
% fprintf('For CO2 = %4.2f%% at T = %4.0f°C, estimated log(fO2) = %f\n', CO2_percent, T_degC, logfO2);
end