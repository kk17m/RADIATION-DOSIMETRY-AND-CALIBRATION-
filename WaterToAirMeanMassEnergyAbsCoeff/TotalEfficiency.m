function [TotalEff] = TotalEfficiency
% TOTAL EFFICIENCY CALCULATION
hMainGui    = getappdata(0,'hMainGui');
QuantumEff  = getappdata(hMainGui,'QuantumEff');
SDD         = str2double(getappdata(hMainGui,'SpectSDD')); 
FieldRadius = str2double(getappdata(hMainGui,'FieldRadiusRf'));

% Total efficiency T(E) = Integral(Product_i(exp(-AttenuationCoeff_i(E)*X_i))*(1-exp(-AttenuationCoeff_d(E)*X_d))dOmega)
SolidAngle = (2*pi*(1 - SDD / sqrt(SDD^2 + FieldRadius))); 
setappdata(hMainGui,'SolidAngle',SolidAngle);
TotalEff = QuantumEff.*SolidAngle; % Units: Steradian
