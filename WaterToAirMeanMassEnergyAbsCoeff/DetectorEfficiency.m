function [QuantumEff] =  DetectorEfficiency
hMainGui       = getappdata(0,'hMainGui');

DetWinMaterial  = getappdata(hMainGui,'DetWinMaterial');
WinMatDensity   = str2double(getappdata(hMainGui,'WinMatDensity'));   % Units: g/cm^3
DetWinThickness = str2double(getappdata(hMainGui,'DetWinThickness')); % Units: nm 
DiodeMaterial   = getappdata(hMainGui,'DiodeMaterial');
DiodeMatDensity = str2double(getappdata(hMainGui,'DiodeMatDensity')); % Units: g/cm^3
DiodeThickness  = str2double(getappdata(hMainGui,'DiodeThickness'));  % Units: nm 

Energy = getappdata(hMainGui,'SpectumEnergy'); % eV

MassAttCoeff_DetWin = PhotonAttenuation(DetWinMaterial, Energy./10^6, 'mac'); % mu/rho , Units: cm^2/g
LinAttCoeff_DetWin = MassAttCoeff_DetWin.*WinMatDensity; % (mu/rho)*rho , Units: 1/cm
AttLength_DetWin = 1./LinAttCoeff_DetWin*10^7; % Epsilon = 1/mu , Units: nm

MassAttCoeff_Diode = PhotonAttenuation(DiodeMaterial, Energy./10^6, 'mac'); % mu/rho , Units: cm^2/g
LinAttCoeff_Diode = MassAttCoeff_Diode.*DiodeMatDensity; % (mu/rho)*rho , Units: 1/cm
AttLength_Diode = 1./LinAttCoeff_Diode*10^7; % Epsilon = 1/mu , Units: nm

% efficiency without solid angle consideration
TransmissionEff   = exp(-DetWinThickness./AttLength_DetWin); 
setappdata(hMainGui,'TransmissionEff',TransmissionEff);
AbsorptionEff = ( 1 - exp(-DiodeThickness./AttLength_Diode));
setappdata(hMainGui,'AbsorptionEff',AbsorptionEff);
QuantumEff = exp(-DetWinThickness./AttLength_DetWin).*( 1 - exp(-DiodeThickness./AttLength_Diode));
setappdata(hMainGui,'QuantumEff',QuantumEff);
 

