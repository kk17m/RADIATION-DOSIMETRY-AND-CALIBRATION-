# RADIATION DOSIMETRY AND CALIBRATION
**About :**  Computation of absorbed dose to water and dose calibration using GUI application.

*To run the application open calibration.fig*

## FILE CONTENTS

* **Calibration.m :** *Main function.*

* **Calibration.fig :** *Calibration Gui.*

* **BeamQual.m :** *Correction for the user beam quality. Collects and stores data for the beam quality at the corresponding HVL value.*

* **BeamQual.fig :** *Beam quality data Gui*

* **DetRespData.m :** *Collects data for the ionization chamber response (Air-Kerma) with time (sec). Important: Please use the corrected dose values here as the detector response. The End effect correction must be applied only after the correction calculations have been performed.*
                  
* **DetRespData.fig :** *Detector response data Gui.*         

* **EndEffLinRegr.m :** *Performs linear regression on the detector response data.*         

* **Error.m :** *Generates the error statements throughout the program.*    

* **Error.fig :** *Error statement Gui.*   

* **KqViewGraph.m :** *Performs extrapolation and interpolation on the beam quality data.*   

* **KqViewGraph.fig :** *Shows the piecewice cubic polynomial fit of the beam quality data.*   

* **LinRegr.m :** *Performs linear regression to find the ion recombination correction factor.*   

* **MminusMeasurement.m :** *Function to collect and store the negative polarity measurements from the ionization chamber.*   

* **MminusMeasurement.fig :** *Gui to collect and store the negative polarity measurements from the ionization chamber.*   

* **MplusMeasurement.m :** *Function to collect and store the positive polarity measurements from the ionization chamber.*   

* **MplusMeasurement.fig :** *Gui to collect and store the positive polarity measurements from the ionization chamber.*   

* **Pressure.m :** *Function to collect and store the pressure values at the test location.*   

* **Pressure.fig :** *Gui to collect and store the pressure values at the test location.*   

* **SaveFile.m :** *Function to save the entered and calculated data from the Calibration Gui.*   

* **SaveFile.fig :** *Gui to save the entered and calculated data from the Calibration Gui.*   

* **Temp.m :** *Function to collect and store the pressure values at the test location.*   

* **Temp.fig :** *Gui to collect and store the pressure values at the test location.*   

* **ValueSet.m :** *ValueSet1, ValueSet2, ValueSet3 and ValueSet4 collects the current measurements (M+ and M-) at a selected electrometer voltage.*   

* **ViewGraph.m :** *This function executes the LinRegr.m to perform linear regression on the ValueSet data and produces the regression statistics.*   

* **ViewGraph.fig :** *Gui to shows the linear regression results of the ValueSet data and displays the regression statistics.*   


## FILE CONTENTS IN SUB-FOLDER ../WaterToAirMeanMassEnergyAbsCoeff/

* **DetectorEfficiency.m :** *Function to model the quantum efficiency of the photon counting detector.*   

* **MMEACSaveFile.m :** *Function to save the entered and calculated data from the water to air mean mass energy absorption coefficient Gui.*   

* **MMEACSaveFile.fig :** *Gui to save the entered and calculated data from the water to air mean mass energy absorption coefficient Gui.*   

* **Note.m :** *Function to pass helping statements and suggestions.*   

* **Note.fig :** *Gui to display helping statements and suggestions.*   

*  *The functions **ParseChemicalFormula.m**, **PhotonAttenuation.m**, **PhotonAttenuationQ.m** and **PhysProps.m** provide the attenuation and energy absorption of x-ray and gamma-ray photons in various materials including mixtures and compounds, based on NIST report 5632, by J. Hubbell and S.M. Seltzer.*   

* **TotalEfficiency.m :** *Function to approximate the total efficiency of the photon counting detector by including the solid angle calculations.*   

* **WaterToAirMeanMassEnergyAbsCoeff.m :** *Function to approximate the water to air mean mass energy absorption coefficient form the incident X-Ray spectra.*    

* **WaterToAirMeanMassEnergyAbsCoeff.fig :** *Gui to to approximate the water to air mean mass energy absorption coefficient form the incident X-Ray spectra by loading the measured spectrum and getting the user data to approximate the detector properties.*   

## References

* Andreo, Pedro, et al. "Absorbed dose determination in external beam radiotherapy: an international code of practice for dosimetry based on standards of absorbed dose to water." IAEA TRS 398 (2000).

* Chica, U., et al. "Quality indexes based on water measurements for low and medium energy x‐ray beams: A theoretical study with PENELOPE." Medical physics 41.1 (2014).

* Ma, C. M., and J. P. Seuntjens. "Mass-energy absorption coefficient and backscatter factor ratios for kilovoltage x-ray beams." Physics in Medicine & Biology 44.1 (1999): 131.

* Hill, Robin, et al. "An evaluation of ionization chambers for the relative dosimetry of kilovoltage x‐ray beams." Medical physics 36.9Part1 (2009): 3971-3981.

* Bruggmoser, G., et al. "Determination of the recombination correction factor kS for some specific plane-parallel and cylindrical ionization chambers in pulsed photon and electron beams." Physics in Medicine & Biology 52.2 (2006): N35.
