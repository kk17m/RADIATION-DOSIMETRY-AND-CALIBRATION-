# RADIATION-DOSIMETRY-AND-CALIBRATION-
About: Calibration GUI application for the absorbed dose to water calculations.

To run the application open calibration.fig

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

*  *ParseChemicalFormula.m, **PhotonAttenuation.m**, PhotonAttenuationQ.m and PhysProps.m are functions that provede the attenuation and energy absorption of x-ray and gamma-ray photons in various materials including mixtures and compounds, based on NIST report 5632, by J. Hubbell and S.M. Seltzer.*   


