function varargout = WaterToAirMeanMassEnergyAbsCoeff(varargin)
% WATERTOAIRMEANMASSENERGYABSCOEFF MATLAB code for WaterToAirMeanMassEnergyAbsCoeff.fig
%      WATERTOAIRMEANMASSENERGYABSCOEFF, by itself, creates a new WATERTOAIRMEANMASSENERGYABSCOEFF or raises the existing
%      singleton*.
%
%      H = WATERTOAIRMEANMASSENERGYABSCOEFF returns the handle to a new WATERTOAIRMEANMASSENERGYABSCOEFF or the handle to
%      the existing singleton*.
%
%      WATERTOAIRMEANMASSENERGYABSCOEFF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WATERTOAIRMEANMASSENERGYABSCOEFF.M with the given input arguments.
%
%      WATERTOAIRMEANMASSENERGYABSCOEFF('Property','Value',...) creates a new WATERTOAIRMEANMASSENERGYABSCOEFF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WaterToAirMeanMassEnergyAbsCoeff_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WaterToAirMeanMassEnergyAbsCoeff_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WaterToAirMeanMassEnergyAbsCoeff

% Last Modified by GUIDE v2.5 21-Dec-2017 03:34:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WaterToAirMeanMassEnergyAbsCoeff_OpeningFcn, ...
                   'gui_OutputFcn',  @WaterToAirMeanMassEnergyAbsCoeff_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before WaterToAirMeanMassEnergyAbsCoeff is made visible.
function WaterToAirMeanMassEnergyAbsCoeff_OpeningFcn(hObject, eventdata, handles, varargin)

set(gca,'xtick',[])
set(gca,'ytick',[])

hMainGui = getappdata(0,'hMainGui');

MMEAC_WaterToAir = getappdata(hMainGui,'MMEAC_WaterToAir');
set(handles.MuByRho,'String',MMEAC_WaterToAir)
SolidAngle = getappdata(hMainGui,'SolidAngle');
set(handles.SolidAngle,'String',SolidAngle)
RealTime = getappdata(hMainGui,'RealTime');
set(handles.RealTime,'String',RealTime)
LiveTime = getappdata(hMainGui,'LiveTime');
set(handles.LiveTime,'String',LiveTime)
ICR = getappdata(hMainGui,'ICR');
set(handles.ICR,'String',ICR)
OCR = getappdata(hMainGui,'OCR');
set(handles.OCR,'String',OCR)
WinMatDensity = getappdata(hMainGui,'WinMatDensity');
set(handles.WinMatDensity,'String',WinMatDensity)
DetWinThickness = getappdata(hMainGui,'DetWinThickness');
set(handles.DetWinThickness,'String',DetWinThickness)
DiodeMatDensity = getappdata(hMainGui,'DiodeMatDensity');
set(handles.DiodeMatDensity,'String',DiodeMatDensity)
DiodeThickness = getappdata(hMainGui,'DiodeThickness');
set(handles.DiodeThickness,'String',DiodeThickness)
mA = getappdata(hMainGui,'mA');
set(handles.mA,'String',mA)
SpectSDD = getappdata(hMainGui,'SpectSDD');
set(handles.SpectSDD,'String',SpectSDD)
FieldRadiusRf = getappdata(hMainGui,'FieldRadiusRf');
set(handles.FieldRadiusRf,'String',FieldRadiusRf)

% Choose default command line output for WaterToAirMeanMassEnergyAbsCoeff
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WaterToAirMeanMassEnergyAbsCoeff wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = WaterToAirMeanMassEnergyAbsCoeff_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in LoadSpectrum.
function LoadSpectrum_Callback(hObject, eventdata, handles)
[file, path] = uigetfile('*.csv');
filePath=fullfile(path,file);
if path~=0
    rdtbl = readtable(filePath);
end
fclose('all');

hMainGui = getappdata(0,'hMainGui');
setappdata(hMainGui,'SpectrumData',rdtbl);


hMainGui = getappdata(0,'hMainGui');
setappdata(hMainGui,'ErrorText','Note: Ensure that the spectrum file is an nx3 array with second column holding the energy and third column holding the counts. Also, the calculations may take a while to complete.');
Note;



% --- Executes on button press in CALC.
function CALC_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
rdtbl = getappdata(hMainGui,'SpectrumData');
UpdateWaterAirMMEAC = getappdata(hMainGui,'UpdateWaterAirMMEAC');


N=size(rdtbl,1);           % number of positive valued bins
n= 0:1:N-1;
Enrgy = table2array(rdtbl(:,2))'; % Col-1 = Channel, Col-2 = Energy, Col-3 = Counts
if any(Enrgy(:,1)<0) 
   fprintf('Please ensure that the energy values are nonnegative. \n');
   setappdata(hMainGui,'ErrorText','ERROR: Please ensure that the energy [eV] values are nonnegative.');
   Error;
end
E_max = max(Enrgy);    % eV
E_min = min(Enrgy(Enrgy>0));  % eV
Del_E = (E_max-E_min)/(N-1);  % eV energy bin
E_n = E_min+ n*Del_E;  
E = E_min:Del_E:E_max;
setappdata(hMainGui,'SpectumEnergy',E);
setappdata(hMainGui,'EnergyBinSize',Del_E);


%-------------------------------------------------------------------------------------------------------------------
% Generate Basis
h = waitbar(0,'Please wait...');
Phi_n = zeros(N,length(E));
for n = 1:1:N
    for num = 1:1:length(E);
        if  abs(E(num) - E_n(n)) > Del_E
            Phi_n(n,num)= 0;
        else if (E_n(n) - Del_E <= E(num)) && (E(num) <= E_n(n))
                Phi_n(n,num)= 1 + (E(num) - E_n(n))/Del_E;
            else if (E_n(n) <= E(num)) && (E(num) <= E_n(n) + Del_E)
                    Phi_n(n,num)= 1 - (E(num) - E_n(n))/Del_E;
                end
            end
        end
    end
    waitbar(n/N)
end
close(h);

density = 1.225*10^-3; % g/cm^3
mass_att_coeff  = PhotonAttenuation('AIR', E./10^6, 'mac'); % mu/rho cm^2/g, Input: energy eV
mu_E =  mass_att_coeff.*density; % (mu/rho)*rho 1/cm

for n = 1:1:N
    A_mn(1,n) = sum(Phi_n(n,:));
end

%---------------------------------------------------------------------------------------------
% Initial coeff c^(0)_n assumption
% Inner product <a,b> = sum(a_i*b_i), Matlab equivalent: sum(a.*b) or a*b'
% Where both a, b are nx1 dimensional.

S=table2array(rdtbl(:,3));
setappdata(hMainGui,'MeasuredSpectra',S)

% % Ax=b in phi basis
coeff_phi = Phi_n'\S;                 % c^(0)_n
% S_phi_check = (coeff_phi'*Phi_n)';  % To Check

c_n=coeff_phi;

e = sum(A_mn, 1).';
k = 100;  % Iterations
ICR =  str2double(getappdata(hMainGui,'ICR'));
RealTime = str2double(getappdata(hMainGui,'RealTime'));
d = ICR*RealTime; % ICRestimated*RealTime or Here: ICR*RealTime, Units: input counts

for i = 1 : k
    c_n = c_n .* (A_mn.' * (d ./ (A_mn * c_n)) ./ e);
end

c_n(isnan(c_n))=0;

% Photon Spectra interms of input counts from DPP. Units: #ICphotons.
ICspect=(c_n'*Phi_n)';
setappdata(hMainGui,'ICspect',ICspect);

% Quantum Efficiency of the X-Ray detector (Photon Counting).
QuantumEff = DetectorEfficiency;
setappdata(hMainGui,'QuantumEff',QuantumEff);

% Total Efficiency of the X-Ray detector (including solid angle), Units: Steradian.
TotalEff = TotalEfficiency;
setappdata(hMainGui,'TotalEff',TotalEff);

% Incident spectra: Number of incident photons. 
IncidentSpectra = ICspect./QuantumEff;     % Units: #photons
setappdata(hMainGui,'IncidentSpectra',IncidentSpectra);

% Incident spectra: Number of incident photons per solid angle.
IncidentSpectraPerSr   = ICspect./TotalEff; % Units: #photons/Steradian
setappdata(hMainGui,'IncidentSpectraPerSr',IncidentSpectraPerSr);

% Incident spectra: Number of incident photons per area.
SpectSDD = str2double(getappdata(hMainGui,'SpectSDD'));
SqSDD     = SpectSDD^2;
IncidentSpectraPerArea = ICspect./(TotalEff.*SqSDD); % Units: #photons/mm^2
setappdata(hMainGui,'IncidentSpectraPerArea',IncidentSpectraPerArea);

% Incident spectra: Number of incident photons per area per mAs per keV
mAs = str2double(getappdata(hMainGui,'mA'))*RealTime;   % Units: mA*sec
BinSizekeV = getappdata(hMainGui,'EnergyBinSize')/1000; % Units: keV
IncidentSpectraPerAreaPermAsPerKev = (ICspect./(TotalEff.*SqSDD))/(mAs*BinSizekeV); % Units: #photons/mm^2
setappdata(hMainGui,'IncidentSpectraPerAreaPermAsPerKev',IncidentSpectraPerAreaPermAsPerKev);

WtoA_MMEAC;
MMEAC_WaterToAir = getappdata(hMainGui,'MMEAC_WaterToAir');
set(handles.MuByRho,'String',MMEAC_WaterToAir)
setappdata(hMainGui,'WaterAirMMEAC',MMEAC_WaterToAir);

SolidAngle = getappdata(hMainGui,'SolidAngle');
set(handles.SolidAngle,'String',SolidAngle)


feval(UpdateWaterAirMMEAC);



function RealTime_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
RealTime  = get(handles.RealTime,'String');
setappdata(hMainGui,'RealTime',RealTime);



function LiveTime_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
LiveTime  = get(handles.LiveTime,'String');
setappdata(hMainGui,'LiveTime',LiveTime);


function DetWinMaterial_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
DetWinMaterial  = get(handles.DetWinMaterial,'String');
setappdata(hMainGui,'DetWinMaterial',DetWinMaterial);


function WinMatDensity_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
WinMatDensity  = get(handles.WinMatDensity,'String');
setappdata(hMainGui,'WinMatDensity',WinMatDensity);


function DetWinThickness_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
DetWinThickness  = get(handles.DetWinThickness,'String');
setappdata(hMainGui,'DetWinThickness',DetWinThickness);


function DiodeMaterial_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
DiodeMaterial  = get(handles.DiodeMaterial,'String');
setappdata(hMainGui,'DiodeMaterial',DiodeMaterial);


function DiodeMatDensity_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
DiodeMatDensity  = get(handles.DiodeMatDensity,'String');
setappdata(hMainGui,'DiodeMatDensity',DiodeMatDensity);


function DiodeThickness_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
DiodeThickness  = get(handles.DiodeThickness,'String');
setappdata(hMainGui,'DiodeThickness',DiodeThickness);


function ICR_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
ICR  = get(handles.ICR,'String');
setappdata(hMainGui,'ICR',ICR);


function OCR_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
OCR  = get(handles.OCR,'String');
setappdata(hMainGui,'OCR',OCR);


function SpectSDD_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
SpectSDD  = get(handles.SpectSDD,'String');
setappdata(hMainGui,'SpectSDD',SpectSDD);


function FieldRadiusRf_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
FieldRadiusRf  = get(handles.FieldRadiusRf,'String');
setappdata(hMainGui,'FieldRadiusRf',FieldRadiusRf);


% --- Executes on button press in AbsorptionEff.
function AbsorptionEff_Callback(hObject, eventdata, handles)
hMainGui      = getappdata(0,'hMainGui');
AbsorptionEff = getappdata(hMainGui,'AbsorptionEff');
SpectumEnergy = getappdata(hMainGui,'SpectumEnergy');

axes(handles.axes1);
cla;
hold on
plot(SpectumEnergy,AbsorptionEff.*100,'r','LineWidth',1.5);
ylabel('Absorption Efficiency');
xlabel('Energy (eV)')
xlim([0 SpectumEnergy(end)])
grid on
Ylb   = get(gca,'YLabel');
ylPos = get(Ylb, 'Position');
set(get(gca,'YLabel'),'Rotation',90,'position',ylPos + [-0.1 0 0])
hold off



% --- Executes on button press in TransmissionEff.
function TransmissionEff_Callback(hObject, eventdata, handles)
hMainGui      = getappdata(0,'hMainGui');
TransmissionEff = getappdata(hMainGui,'TransmissionEff');
SpectumEnergy = getappdata(hMainGui,'SpectumEnergy');

axes(handles.axes1);
cla;
hold on
plot(SpectumEnergy,TransmissionEff.*100,'r','LineWidth',1.5);
ylabel('Transmission Efficiency');
xlabel('Energy (eV)')
xlim([0 SpectumEnergy(end)])
grid on
Ylb   = get(gca,'YLabel');
ylPos = get(Ylb, 'Position');
set(get(gca,'YLabel'),'Rotation',90,'position',ylPos + [-0.1 0 0])
hold off


% --- Executes on button press in DetectionEff.
function DetectionEff_Callback(hObject, eventdata, handles)
hMainGui      = getappdata(0,'hMainGui');
QuantumEff    = getappdata(hMainGui,'QuantumEff');
SpectumEnergy = getappdata(hMainGui,'SpectumEnergy');

axes(handles.axes1);
cla;
hold on
plot(SpectumEnergy,QuantumEff.*100,'r','LineWidth',1.5);
ylabel('Quantum Efficiency');
xlabel('Energy (eV)')
xlim([0 SpectumEnergy(end)])
grid on
Ylb   = get(gca,'YLabel');
ylPos = get(Ylb, 'Position');
set(get(gca,'YLabel'),'Rotation',90,'position',ylPos + [-0.1 0 0])
hold off

% --- Executes on button press in IncidentSpectra.
function IncidentSpectra_Callback(hObject, eventdata, handles)
ISViewGraph;


function mA_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
mA  = get(handles.mA,'String');
setappdata(hMainGui,'mA',mA);


% --- Executes on button press in SaveMMEAC.
function SaveMMEAC_Callback(hObject, eventdata, handles)
MMEACSaveFile;
