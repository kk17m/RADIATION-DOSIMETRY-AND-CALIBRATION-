function WtoA_MMEAC
% Calculation of water to air mean mass energy absorption coefficient
hMainGui       = getappdata(0,'hMainGui');

Energy                 = getappdata(hMainGui,'SpectumEnergy'); % eV
IncidentSpectraPerArea = getappdata(hMainGui,'IncidentSpectraPerArea');


MEAC_air   = PhotonAttenuation('Air', Energy./10^6, 'meac');   % Energy./10^6 in MeV
MEAC_water = PhotonAttenuation('Water', Energy./10^6, 'meac'); % Energy./10^6 in MeV

NormEnergyFluence = (IncidentSpectraPerArea.*Energy')./sum(IncidentSpectraPerArea.*Energy');
setappdata(hMainGui,'NormEnergyFluence',NormEnergyFluence);
NormPhotonFluence = (IncidentSpectraPerArea)./sum(IncidentSpectraPerArea);
setappdata(hMainGui,'NormPhotonFluence',NormPhotonFluence);

MMEAC_air = sum((IncidentSpectraPerArea.*Energy').*(MEAC_air));
MMEAC_water = sum((IncidentSpectraPerArea.*Energy').*(MEAC_water));

MMEAC_WaterToAir = MMEAC_water/MMEAC_air;
setappdata(hMainGui,'MMEAC_WaterToAir',MMEAC_WaterToAir);

% plot(Energy,Counts.*Energy./sum(Counts.*Energy),'b')
% hold on;  plot(Energy,Counts./sum(Counts),'r');hold off

end

