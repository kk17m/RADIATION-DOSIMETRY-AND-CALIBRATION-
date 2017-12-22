function varargout = MMEACSaveFile(varargin)
% MMEACSAVEFILE MATLAB code for MMEACSaveFile.fig
%      MMEACSAVEFILE, by itself, creates a new MMEACSAVEFILE or raises the existing
%      singleton*.
%
%      H = MMEACSAVEFILE returns the handle to a new MMEACSAVEFILE or the handle to
%      the existing singleton*.
%
%      MMEACSAVEFILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MMEACSAVEFILE.M with the given input arguments.
%
%      MMEACSAVEFILE('Property','Value',...) creates a new MMEACSAVEFILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MMEACSaveFile_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MMEACSaveFile_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MMEACSaveFile

% Last Modified by GUIDE v2.5 21-Dec-2017 03:38:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MMEACSaveFile_OpeningFcn, ...
    'gui_OutputFcn',  @MMEACSaveFile_OutputFcn, ...
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


% --- Executes just before MMEACSaveFile is made visible.
function MMEACSaveFile_OpeningFcn(hObject, eventdata, handles, varargin)
hMainGui = getappdata(0,'hMainGui');

Energy          = getappdata(hMainGui,'SpectumEnergy')';
mA              = getappdata(hMainGui,'mA');
RealTime        = getappdata(hMainGui,'RealTime'); 
LiveTime        = getappdata(hMainGui,'LiveTime'); 
DetWinMaterial  = getappdata(hMainGui,'DetWinMaterial');
WinMatDensity   = getappdata(hMainGui,'WinMatDensity');
DetWinThickness = getappdata(hMainGui,'DetWinThickness');
DiodeMaterial   = getappdata(hMainGui,'DiodeMaterial');
DiodeMatDensity = getappdata(hMainGui,'DiodeMatDensity');
DiodeThickness  = getappdata(hMainGui,'DiodeThickness');
ICR             = getappdata(hMainGui,'ICR');
OCR             = getappdata(hMainGui,'OCR');
SpectSDD        = getappdata(hMainGui,'SpectSDD');
FieldRadiusRf   = getappdata(hMainGui,'FieldRadiusRf');
SolidAngle = getappdata(hMainGui,'SolidAngle');
MMEAC_WaterToAir = getappdata(hMainGui,'MMEAC_WaterToAir');


MeasuredSpectrumData = getappdata(hMainGui,'SpectrumData');
writetable(MeasuredSpectrumData,'MeasuredSpectrumData.csv'); 

ICspect = getappdata(hMainGui,'ICspect');
Table = table(Energy,ICspect);
writetable(Table,'ICspectData.csv'); 

QuantumEfficiency = getappdata(hMainGui,'QuantumEff');
Table = table(Energy,QuantumEfficiency);
writetable(Table,'QuantumEfficiencyData.csv');

TotalEfficiency = getappdata(hMainGui,'TotalEff');
Table = table(Energy,TotalEfficiency);
writetable(Table,'TotalEfficiencyData.csv');

IncidentSpectra = getappdata(hMainGui,'IncidentSpectra');
Table = table(Energy,IncidentSpectra);
writetable(Table,'IncidentSpectraData.csv');

IncidentSpectraPerSr = getappdata(hMainGui,'IncidentSpectraPerSr');
Table = table(Energy,IncidentSpectraPerSr);
writetable(Table,'IncidentSpectraPerSrData.csv');

IncidentSpectraPerArea = getappdata(hMainGui,'IncidentSpectraPerArea');
Table = table(Energy,IncidentSpectraPerArea);
writetable(Table,'IncidentSpectraPerAreaData.csv');

IncidentSpectraPerAreaPermAsPerKev = getappdata(hMainGui,'IncidentSpectraPerAreaPermAsPerKev');
Table = table(Energy,IncidentSpectraPerAreaPermAsPerKev);
writetable(Table,'IncidentSpectraPerAreaPermAsPerKevData.csv');



Parameter = {'Real Time [sec]';'Live Time [sec]'; 'Input Count Rate';'Output Count Rate ';...
             'Detector window material';'Window material density [g/cm^3]';...
             'Detector window thickness [nm]';'Diode material';'Diode material density [g/cm^3]';...
             'Diode thickness [nm]';'Nominal tube current [mA]';'SDD (Spectra) [mm]';
             'Field radius [mm]'; 'Solid angle [Sr]';'Water to Air mean mass energy absorption coefficient'};
         
Values    = {RealTime;LiveTime;ICR;OCR;DetWinMaterial;WinMatDensity;DetWinThickness;...
             DiodeMaterial;DiodeMatDensity;DiodeThickness;mA;SpectSDD;FieldRadiusRf;...
             SolidAngle;MMEAC_WaterToAir};
                         
Table = table(Parameter,Values);
writetable(Table,'MMEAC_Data.csv'); 
fclose('all');

% Choose default command line output for MMEACSaveFile
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MMEACSaveFile wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MMEACSaveFile_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');

MMEACselection      =  getappdata(hMainGui,'MMEACselection');

switch MMEACselection
    
    case 2
        [file, path] = uiputfile('MMEACData.csv');
        filePath=fullfile(path,file);
        fid = fopen('MMEAC_Data.csv','r');
        if fid~=-1 && path~=0 
            rdtbl = readtable('MMEAC_Data.csv');
            writetable(rdtbl,filePath);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 3
        [file, path] = uiputfile('IncidentSpectraPerAreaPermAsPerKev.csv');
        filePath=fullfile(path,file);
        fid = fopen('IncidentSpectraPerAreaPermAsPerKevData.csv','r');
        if fid~=-1 && path~=0 
            rdtbl = readtable('IncidentSpectraPerAreaPermAsPerKevData.csv');
            writetable(rdtbl,filePath);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 4
        [file, path] = uiputfile('IncidentSpectraPerArea.csv');
        filePath=fullfile(path,file);
        fid = fopen('IncidentSpectraPerAreaData.csv','r');
        if fid~=-1 && path~=0 
            rdtbl = readtable('IncidentSpectraPerAreaData.csv');
            writetable(rdtbl,filePath);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 5
        [file, path] = uiputfile('IncidentSpectraPerSr.csv');
        filePath=fullfile(path,file);
        fid = fopen('IncidentSpectraPerSrData.csv','r');
        if fid~=-1 && path~=0 
            rdtbl = readtable('IncidentSpectraPerSrData.csv');
            writetable(rdtbl,filePath);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 6
        [file, path] = uiputfile('IncidentSpectra.csv');
        filePath=fullfile(path,file);
        fid = fopen('IncidentSpectraData.csv','r');
        if fid~=-1 && path~=0 
            rdtbl = readtable('IncidentSpectraData.csv');
            writetable(rdtbl,filePath);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 7 
        [file, path] = uiputfile('TotalEfficiency.csv');
        filePath=fullfile(path,file);
        fid = fopen('TotalEfficiencyData.csv','r');
        if fid~=-1 && path~=0 
            rdtbl = readtable('TotalEfficiencyData.csv');
            writetable(rdtbl,filePath);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 8
        [file, path] = uiputfile('QuantumEfficiency.csv');
        filePath=fullfile(path,file);
        fid = fopen('QuantumEfficiencyData.csv','r');
        if fid~=-1 && path~=0 
            rdtbl = readtable('QuantumEfficiencyData.csv');
            writetable(rdtbl,filePath);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 9 
        [file, path] = uiputfile('ICspect.csv');
        filePath=fullfile(path,file);
        fid = fopen('ICspectData.csv','r');
        if fid~=-1 && path~=0 
            rdtbl = readtable('ICspectData.csv');
            writetable(rdtbl,filePath);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 10
        [file, path] = uiputfile('MeasuredSpectrum.csv');
        filePath=fullfile(path,file);
        fid = fopen('MeasuredSpectrumData.csv','r');
        if fid~=-1 && path~=0 
            rdtbl = readtable('MeasuredSpectrumData.csv');
            writetable(rdtbl,filePath);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');        
end
%delete(handles.figure1)

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
str = get(hObject, 'String');
val = get(hObject,'Value');

hMainGui         =  getappdata(0,'hMainGui');
setappdata(hMainGui,'MMEACselection',val);
