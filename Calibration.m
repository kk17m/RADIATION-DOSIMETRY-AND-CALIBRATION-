function varargout = Calibration(varargin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Absorbed dose in water (Calibration and calculation)                           
% File: Calibration.m                                                            
% Kunal Kumar,                                                                   
% Copyright, 2017 
% Version: 1.0
%
% Copyright Notice: Permission to use, copy, modify, and distribute this 
% application and its components for educational, research, and not for 
% profit purposes, without a signed licensing agreement, is hereby granted,
% provided that the above copyright notice, this paragraph and the 
% following paragraph appear in all copies, modifications, and distributions.
%
% Disclaimer: This application has been developed solely for the purpose of
% research and education, use of this application for clinical dosimetry is
% strongly discouraged without a complete validation and regulatory 
% approval. In no event shall the author of this application be liable to 
% any party for direct, indirect, special, incidental, or consequential 
% damages arising out of the use of this application. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CALIBRATION MATLAB code for Calibration.fig
%      CALIBRATION, by itself, creates a new CALIBRATION or raises the existing
%      singleton*.
%
%      H = CALIBRATION returns the handle to a new CALIBRATION or the handle to
%      the existing singleton*.
%
%      CALIBRATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALIBRATION.M with the given input arguments.
%
%      CALIBRATION('Property','Value',...) creates a new CALIBRATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Calibration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Calibration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Last Modified: Dec-2017

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Calibration_OpeningFcn, ...
    'gui_OutputFcn',  @Calibration_OutputFcn, ...
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


% --- Executes just before Calibration is made visible.
function Calibration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.

addpath(genpath(pwd));

% MAIN
setappdata(0, 'hMainGui',gcf)

% MEAN M-
setappdata(gcf,'MeanMminus',[])
setappdata(gcf,'UpdateMeanMminus',@UpdateMeanMminus)

% MEAN M+
setappdata(gcf,'MeanMplus',[])
setappdata(gcf,'UpdateMeanMplus',@UpdateMeanMplus)

% TEMPERATURE
setappdata(gcf,'MeanTemp',[])
setappdata(gcf,'UpdateTemp',@UpdateTemp)

% PRESSURE
setappdata(gcf,'MeanPressure',[])
setappdata(gcf,'UpdatePressure',@UpdatePressure)

% VOLTAGE POLARITY
% ValueSet1
setappdata(gcf,'MeanValueSet1',[])
setappdata(gcf,'UpdateValueSet1',@UpdateValueSet1)
% ValueSet2
setappdata(gcf,'MeanValueSet2',[])
setappdata(gcf,'UpdateValueSet2',@UpdateValueSet2)
% ValueSet3
setappdata(gcf,'MeanValueSet3',[])
setappdata(gcf,'UpdateValueSet3',@UpdateValueSet3)
% ValueSet4
setappdata(gcf,'MeanValueSet4',[])
setappdata(gcf,'UpdateValueSet4',@UpdateValueSet4)

% BeamQual
setappdata(gcf,'BeamQualData',[])
setappdata(gcf,'UpdateBeamQual',@UpdateBeamQual)

% DetRespData
setappdata(gcf,'DetRespData',[])
setappdata(gcf,'UpdateDetRespData',@UpdateDetRespData)

% DetRespData
setappdata(gcf,'WaterAirMMEAC',[])
setappdata(gcf,'UpdateWaterAirMMEAC',@UpdateWaterAirMMEAC)

% Choose default command line output for Calibration
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Calibration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Calibration_OutputFcn(hObject, eventdata, handles)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------Kpol CORRECTION----------------------------------- %

% --- Executes on button press in EnterM_plus.
function EnterM_plus_Callback(hObject, eventdata, handles)

% Call M- measurement dialog box
MplusMeasurement;

% Set the handles structure to be used in other functions in Main.
% Important: The handes should be passed in the OpeningFcn for
% global use.
setappdata(0,'handles_MplusMeasurement',handles)

% Update with save_callback
UpdateMeanMplus;

function UpdateMeanMplus

% Get the main Gui data and use its fields
hMainGui = getappdata(0,'hMainGui');
MeanMplus   = getappdata(hMainGui,'MeanMplus');

% Use EnterM_plus_Callback handle to set the required value
handles_MplusMeasurement = getappdata(0,'handles_MplusMeasurement');
set(handles_MplusMeasurement.MeanMplus,'String',MeanMplus);

return;

% --- Executes on button press in EnterM_minus.
function EnterM_minus_Callback(hObject, eventdata, handles)

% Call M- measurement dialog box
MminusMeasurement;

% Set the handles structure to be used in other functions in Main.
% Important: The handes should be passed in the OpeningFcn for
% global use.
setappdata(0,'handles_MminusMeasurement',handles)

% Update with save_callback
UpdateMeanMminus;

function UpdateMeanMminus

% Get the main Gui data and use its fields
hMainGui = getappdata(0,'hMainGui');
MeanMminus   = getappdata(hMainGui,'MeanMminus');

% Use EnterM_minus_Callback handle to set the required value
handles_MminusMeasurement = getappdata(0,'handles_MminusMeasurement');
set(handles_MminusMeasurement.MeanMminus,'String',MeanMminus);

return;


% --- Executes on button press in KpolCALC.
function KpolCALC_Callback(hObject, eventdata, handles)
hMainGui    =  getappdata(0,'hMainGui');
MeanMplus   =  getappdata(hMainGui,'MeanMminus');
MeanMminus  =  getappdata(hMainGui,'MeanMplus');
Kpol        = (abs(MeanMplus) + abs(MeanMminus)) / (2 * abs(MeanMplus));

if isnan(Kpol)
       fprintf('Make sure no field in this section is left empty\n');
       setappdata(hMainGui,'ErrorText','ERROR: Make sure no field in this section is left empty.');
       Error;
end

set(handles.Kpol,'String',Kpol);
setappdata(hMainGui,'Kpol',Kpol);


% --------------------- Ktp CORRECTION --------------------------------- %

% TEMPERATURE
% --- Executes on button press in Temperature.
function Temp_Callback(hObject, eventdata, handles)
% Call temp measurement dialog box
Temp;

% Set the handles structure to be used in other functions in Main.
% Important: The handes should be passed in the OpeningFcn for
% global use.
setappdata(0,'handles_Temp',handles)

% Update with save_callback
UpdateTemp;

function UpdateTemp

% Get the main Gui data and use its fields
hMainGui = getappdata(0,'hMainGui');
MeanTemp   = getappdata(hMainGui,'MeanTemp');

% Use EnterM_minus_Callback handle to set the required value
handles_Temp = getappdata(0,'handles_Temp');
set(handles_Temp.MeanTemp,'String',MeanTemp);

return;


% --- Executes on button press in Pressure.
function Pressure_Callback(hObject, eventdata, handles)
Pressure;

% Set the handles structure to be used in other functions in Main.
% Important: The handes should be passed in the OpeningFcn for
% global use.
setappdata(0,'handles_Pressure',handles)

% Update with save_callback
UpdatePressure;

function UpdatePressure

% Get the main Gui data and use its fields
hMainGui = getappdata(0,'hMainGui');
MeanPressure   = getappdata(hMainGui,'MeanPressure');

% Use EnterM_minus_Callback handle to set the required value
handles_Pressure = getappdata(0,'handles_Pressure');
set(handles_Pressure.MeanPressure,'String',MeanPressure);

return;


function RefTemp_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
RefTemp  = get(handles.RefTemp,'String');
setappdata(hMainGui,'RefTemp',RefTemp);

function RefPressure_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
RefPressure  = get(handles.RefPressure,'String');
setappdata(hMainGui,'RefPressure',RefPressure);

% --- Executes on button press in KtpCALC.
function KtpCALC_Callback(hObject, eventdata, handles)
hMainGui      =  getappdata(0,'hMainGui');
MeanTemp      =  str2double(getappdata(hMainGui,'MeanTemp'));
MeanPressure  =  str2double(getappdata(hMainGui,'MeanPressure'));
RefPressure   =  str2double(getappdata(hMainGui,'RefPressure'));
RefTemp       =  str2double(getappdata(hMainGui,'RefTemp'));


ElectrometerKtpEnabled     = get(handles.ElectrometerKtpEnabled,'SelectedObject');
ElecKtpEnab  = get(ElectrometerKtpEnabled,'String');
setappdata(hMainGui,'ElecKtpEnab',ElecKtpEnab)

if strcmp(ElecKtpEnab,'No')
   Ktp           =  (RefPressure / MeanPressure) * (273.2 + MeanTemp) / (273.2 + RefTemp);
   if isnan(Ktp)
       fprintf('Make sure no field in this section is left empty\n');
       setappdata(hMainGui,'ErrorText','ERROR: Make sure no field in this section is left empty.');
       Error;
   end
   set(handles.Ktp,'String',Ktp);
   setappdata(hMainGui,'Ktp',Ktp);

    
else if strcmp(ElecKtpEnab,'Yes')
       Ktp  =  1;
       set(handles.Ktp,'String',Ktp);
       setappdata(hMainGui,'Ktp',Ktp);
    end
end

%----------------------------------------------------------------------------------------------------------

% --------------------- Ks CORRECTION --------------------------------- %


% --- Executes on button press in ValueSet1.
function ValueSet1_Callback(hObject, eventdata, handles)
ValueSet1;

% Set the handles structure to be used in other functions in Main.
% Important: The handes should be passed in the OpeningFcn for
% global use.
setappdata(0,'handles_ValueSet1',handles)

% Update with save_callback
UpdateValueSet1;

function UpdateValueSet1

% Get the main Gui data and use its fields
hMainGui = getappdata(0,'hMainGui');
MeanValueSet1   = getappdata(hMainGui,'MeanValueSet1');

% handles_ValueSet1 = getappdata(0,'handles_ValueSet1');
setappdata(hMainGui,'MeanValueSet1',MeanValueSet1);
return;


% --- Executes on button press in KsCALC.
function KsCALC_Callback(hObject, eventdata, handles)
LinRegr;
hMainGui   =  getappdata(0,'hMainGui');
FitFunc    =  getappdata(hMainGui,'KsFitFunc');
Ks         =  1/FitFunc(0);
if isnan(Ks)
       fprintf('Make sure no field in this section is left empty\n');
       setappdata(hMainGui,'ErrorText','ERROR: Make sure no field in this section is left empty.');
       Error;
end
set(handles.Ks,'String',Ks);
setappdata(hMainGui,'Ks',Ks);




% --- Executes on button press in ValueSet3.
function ValueSet3_Callback(hObject, eventdata, handles)
ValueSet3;

% Set the handles structure to be used in other functions in Main.
% Important: The handes should be passed in the OpeningFcn for
% global use.
setappdata(0,'handles_ValueSet3',handles)

% Update with save_callback
UpdateValueSet3;

function UpdateValueSet3

% Get the main Gui data and use its fields
hMainGui = getappdata(0,'hMainGui');
MeanValueSet3   = getappdata(hMainGui,'MeanValueSet3');

% handles_ValueSet3 = getappdata(0,'handles_ValueSet3');
setappdata(hMainGui,'MeanValueSet3',MeanValueSet3);
return;

% --- Executes on button press in ValueSet2.
function ValueSet2_Callback(hObject, eventdata, handles)
ValueSet2;

% Set the handles structure to be used in other functions in Main.
% Important: The handes should be passed in the OpeningFcn for
% global use.
setappdata(0,'handles_ValueSet2',handles)

% Update with save_callback
UpdateValueSet2;

function UpdateValueSet2

% % Get the main Gui data and use its fields
 hMainGui = getappdata(0,'hMainGui');
 MeanValueSet2   = getappdata(hMainGui,'MeanValueSet2');
% 
% handles_ValueSet2 = getappdata(0,'handles_ValueSet2');
setappdata(hMainGui,'MeanValueSet2',MeanValueSet2);
return;


% --- Executes on button press in ValueSet4.
function ValueSet4_Callback(hObject, eventdata, handles)
ValueSet4;

% Set the handles structure to be used in other functions in Main.
% Important: The handes should be passed in the OpeningFcn for
% global use.
setappdata(0,'handles_ValueSet4',handles)

% Update with save_callback
UpdateValueSet4;

function UpdateValueSet4

% % Get the main Gui data and use its fields
 hMainGui = getappdata(0,'hMainGui');
 MeanValueSet4   = getappdata(hMainGui,'MeanValueSet4');
% 
% % handles_ValueSet4 = getappdata(0,'handles_ValueSet4');
setappdata(hMainGui,'MeanValueSet4',MeanValueSet4);
return;

% --- Executes on button press in ValueGraph.
function ValueGraph_Callback(hObject, eventdata, handles)
ViewGraph;




% --- Executes on button press in Kh.
function Kh_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
KhDisp  = get(handles.KhDisp,'String');
setappdata(hMainGui,'Kh',KhDisp);

% --- Executes on button press in Kelec.
function Kelec_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
KelecDisp  = get(handles.KelecDisp,'String');
setappdata(hMainGui,'Kelec',KelecDisp);



function NominalVoltage_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
NominalVoltage  = get(handles.NominalVoltage,'String');
setappdata(hMainGui,'NominalVoltage',NominalVoltage);





% --- Executes on button press in EnterBeamQual.
function EnterBeamQual_Callback(hObject, eventdata, handles)
BeamQual;
% Set the handles structure to be used in other functions in Main.
% Important: The handes should be passed in the OpeningFcn for
% global use.
setappdata(0,'handles_BeamQual',handles)

% Update with save_callback
UpdateBeamQual;

function UpdateBeamQual

% Get the main Gui data and use its fields
hMainGui = getappdata(0,'hMainGui');
BeamQualData   = getappdata(hMainGui,'BeamQualData');

% handles_BeamQual = getappdata(0,'handles_BeamQual');
setappdata(hMainGui,'BeamQualData',BeamQualData);
return;

% --- Executes on button press in KqCALC.
function KqCALC_Callback(hObject, eventdata, handles)


hMainGui   = getappdata(0,'hMainGui');

KqCALM     = get(handles.KqCALCmethod,'SelectedObject');
KqCALMode  = get(KqCALM,'String');
setappdata(hMainGui,'KqCALMode',KqCALMode)

if strcmp(KqCALMode,'Kilovoltage Beams')
    BeamQualData  = getappdata(hMainGui,'BeamQualData');
    kV            = str2double(getappdata(hMainGui,'kV'));
    
    if isnan(kV)
        fprintf('Make sure nominal tube potential value is set and the beam quality data field is not empty.\n');
        setappdata(hMainGui,'ErrorText','ERROR: Make sure nominal tube potential value is set and the beam quality data field is not empty.');
        Error;
    end
    
    BeamQualxData = BeamQualData(1:ceil(end/2));
    BeamQualyData = BeamQualData((ceil(end/2)+1):end);
    IntrKq        = interp1(BeamQualxData,BeamQualyData,kV,'pchip','extrap');
    set(handles.Kq,'String',IntrKq);
    setappdata(hMainGui,'Kq',IntrKq);
    
else if strcmp(KqCALMode,'Bragg–Gray Theory')
        fprintf(' Bragg-Gray theory has not been implemented yet.\n');
        setappdata(hMainGui,'ErrorText','ERROR: Bragg-Gray theory has not been implemented yet.');
        Error;
    end
end







% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in KqViewGraph.
function KqViewGraph_Callback(hObject, eventdata, handles)
KqViewGraph;

function Nk_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
Nk  = get(handles.Nk,'String');
setappdata(hMainGui,'Nk',Nk);

function kV_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
kV  = get(handles.kV,'String');
setappdata(hMainGui,'kV',kV);


function KhDisp_Callback(hObject, eventdata, handles)
% hObject    handle to KhDisp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KhDisp as text
%        str2double(get(hObject,'String')) returns contents of KhDisp as a double


function KelecDisp_Callback(hObject, eventdata, handles)
% hObject    handle to KelecDisp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KelecDisp as text
%        str2double(get(hObject,'String')) returns contents of KelecDisp as a double


function mA_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
mA  = get(handles.mA,'String');
setappdata(hMainGui,'mA',mA);


function CalibNo_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
CalibNo  = get(handles.CalibNo,'String');
setappdata(hMainGui,'CalibNo',CalibNo);


function RefNo_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
RefNo  = get(handles.RefNo,'String');
setappdata(hMainGui,'RefNo',RefNo);



function BeamQualHVL_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
BeamQualHVL  = get(handles.BeamQualHVL,'String');
setappdata(hMainGui,'BeamQualHVL',BeamQualHVL);


% --- Executes on button press in EnterDetRespData.
function EnterDetRespData_Callback(hObject, eventdata, handles)
DetRespData;
% Set the handles structure to be used in other functions in Main.
% Important: The handes should be passed in the OpeningFcn for
% global use.
setappdata(0,'handles_DetRespData',handles)

% Update with save_callback
UpdateDetRespData;

function UpdateDetRespData

% Get the main Gui data and use its fields
hMainGui = getappdata(0,'hMainGui');
DetRespData   = getappdata(hMainGui,'DetRespData');

% handles_DetRespData = getappdata(0,'handles_DetRespData');
setappdata(hMainGui,'DetRespData',DetRespData);
return;

% --- Executes on button press in DelTCALC.
function DelTCALC_Callback(hObject, eventdata, handles)
EndEffLinRegr;

hMainGui         =  getappdata(0,'hMainGui');
EndEffFitResult  =  getappdata(hMainGui,'EndEffFitResult');
EndEffCoeff      =  coeffvalues(EndEffFitResult);
EndEffroots      = -roots(EndEffCoeff);  % -ve value of the root
setappdata(hMainGui,'delT',EndEffroots);
set(handles.delT,'String',EndEffroots);








% --- Executes on button press in EndEffViewGraph.
function EndEffViewGraph_Callback(hObject, eventdata, handles)
EndEffViewGraph;



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MeasOffset_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
MeasOffset  = get(handles.MeasOffset,'String');
setappdata(hMainGui,'MeasOffset',MeasOffset);



% --- Executes during object creation, after setting all properties.
function MeasOffset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MeasOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
str = get(hObject, 'String');
val = get(hObject,'Value');

hMainGui         =  getappdata(0,'hMainGui');
setappdata(hMainGui,'MselectionString',str{val});
setappdata(hMainGui,'Mselection',val);


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function MeasuredValue_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
MeasuredValue  = get(handles.MeasuredValue,'String');
setappdata(hMainGui,'MeasuredValue',MeasuredValue);

function SSD_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
SSD  = get(handles.SSD,'String');
setappdata(hMainGui,'SSD',SSD);

function FieldSize_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
FieldSize  = get(handles.FieldSize,'String');
setappdata(hMainGui,'FieldSize',FieldSize);



function TotalRadTime_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
TotalRadTime  = get(handles.TotalRadTime,'String');
setappdata(hMainGui,'TotalRadTime',TotalRadTime);



% --- Executes during object creation, after setting all properties.
function TotalRadTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TotalRadTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ResultsCALC.
function ResultsCALC_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');

Kpol            =  getappdata(hMainGui,'Kpol');
Ktp             =  getappdata(hMainGui,'Ktp');
Ks              =  getappdata(hMainGui,'Ks');
Kh              =  str2double(getappdata(hMainGui,'Kh'));
Kelec           =  str2double(getappdata(hMainGui,'Kelec'));

MeasuredValue    =  str2double(getappdata(hMainGui,'MeasuredValue'));
MeasOffset       =  str2double(getappdata(hMainGui,'MeasOffset'));
Mselection       =  getappdata(hMainGui,'Mselection');
CalibNo          =  getappdata(hMainGui,'CalibNo');
RefNo            =  getappdata(hMainGui,'RefNo');
mA               =  str2double(getappdata(hMainGui,'mA'));
kV               =  str2double(getappdata(hMainGui,'kV'));
BeamQualHVL      =  str2double(getappdata(hMainGui,'BeamQualHVL'));
SSD              =  str2double(getappdata(hMainGui,'SSD'));
FieldSize        =  str2double(getappdata(hMainGui,'FieldSize'));
MselectionString =  getappdata(hMainGui,'MselectionString');
RefTemp          =  str2double(getappdata(hMainGui,'RefTemp'));
RefPressure      =  str2double(getappdata(hMainGui,'RefPressure'));
MeanMplus        =  getappdata(hMainGui,'MeanMplus');
MeanMminus       =  getappdata(hMainGui,'MeanMminus');
MeanTemp         =  str2double(getappdata(hMainGui,'MeanTemp'));
MeanPressure     =  str2double(getappdata(hMainGui,'MeanPressure'));
NominalVoltage   =  str2double(getappdata(hMainGui,'NominalVoltage'));
ElecKtpEnab      =  getappdata(hMainGui,'ElecKtpEnab');
KqCALMode        =  getappdata(hMainGui,'KqCALMode');
StemCorrection   =  str2double(getappdata(hMainGui,'StemCorrection'));
Kq               =  getappdata(hMainGui,'Kq');
Nk               =  str2double(getappdata(hMainGui,'Nk'));
TotalRadTime     =  str2double(getappdata(hMainGui,'TotalRadTime'));
delT             =  getappdata(hMainGui,'delT');
BackScatterFactor = str2double(getappdata(hMainGui,'BackScatterFactor'));
MMEAC_WaterToAir  = getappdata(hMainGui,'MMEAC_WaterToAir');

if isempty(Mselection) || isnan(Mselection)
   fprintf('Please select the measurement condition first. \n');
   setappdata(hMainGui,'ErrorText','ERROR: Please select the measurement condition first.');
   Error;
end

switch Mselection
    case 1
       setappdata(hMainGui,'ErrorText','ERROR: Please select the measurement condition.');
       Error;
    case 2
       CorrectedReading = (MeasuredValue - MeasOffset)*Kpol*Ktp*Ks*Kh*Kelec;
       if isempty(CorrectedReading) || isnan(CorrectedReading)
          fprintf('Please ensure that the raw measurement and the offset is entered. \n');
          setappdata(hMainGui,'ErrorText','ERROR: Please ensure that the raw measurement and the offset is entered.');
          Error;
       elseif isempty(Kpol) || isnan(Kpol) || isempty(Ks) || isnan(Ks) || isempty(Kh) || isempty(Kelec) || isempty(Ktp) || isnan(Ktp)
          fprintf('Please ensure that the correction factors are calculated correctly. \n');
          setappdata(hMainGui,'ErrorText','ERROR: Please ensure that the correction factors are calculated correctly.');
          Error;
       end
    case 3
       CorrectedReading = (MeasuredValue - MeasOffset)*Kpol*Ks*Kh*Kelec; 
       if isempty(CorrectedReading) || isnan(CorrectedReading)
          fprintf('Please ensure that the raw measurement and the offset is entered. \n');
          setappdata(hMainGui,'ErrorText','ERROR: Please ensure that the raw measurement and the offset is entered.');
          Error;
       elseif isempty(Kpol) || isnan(Kpol) || isempty(Ks) || isnan(Ks) || isempty(Kh) || isempty(Kelec)
          fprintf('Please ensure that the correction factors are calculated correctly. \n');
          setappdata(hMainGui,'ErrorText','ERROR: Please ensure that the correction factors are calculated correctly.');
          Error;
       end
    case 4 
       CorrectedReading = (MeasuredValue - MeasOffset);
       if isempty(CorrectedReading) || isnan(CorrectedReading)
          fprintf('Please ensure that the raw measurement and the offset is entered. \n');
          setappdata(hMainGui,'ErrorText','ERROR: Please ensure that the raw measurement and the offset is entered.');
          Error;
       end
end

if isempty(Kq) || isnan(Kq)
   fprintf('Please ensure that the beam quality factor is calculated first. \n');
   setappdata(hMainGui,'ErrorText','ERROR: Please ensure that the beam quality factor is calculated first.');
   Error;
elseif isempty(Nk) || isnan(Nk)
   fprintf('Please ensure that the calibration factor (Nk) is entered. \n');
   setappdata(hMainGui,'ErrorText','ERROR: Please ensure that the calibration factor (Nk) is entered.');
   Error;
elseif isempty(StemCorrection) || isnan(StemCorrection)
   fprintf('Please ensure that the stem correction factor is entered. \n');
   setappdata(hMainGui,'ErrorText','ERROR: Please ensure that the stem correction factor is entered.');
   Error;
elseif isempty(TotalRadTime) || isnan(TotalRadTime)
   fprintf('Please ensure that the total radiation time is entered. \n');
   setappdata(hMainGui,'ErrorText','ERROR: Please ensure that the total radiation time is entered.');
   Error;
elseif isempty(delT) || isnan(delT)
   fprintf('Please ensure that the end effect correction is calculated correctly. \n');
   setappdata(hMainGui,'ErrorText','ERROR: Please ensure that the end effect correction is calculated correctly.');
   Error;
end

set(handles.CorrectedReading,'String',CorrectedReading);

Dw =  CorrectedReading*Nk*Kq*StemCorrection*BackScatterFactor*MMEAC_WaterToAir;
setappdata(hMainGui,'Dw',Dw);
set(handles.Dw,'String',Dw);

DoseRate = Dw/(TotalRadTime + delT);
setappdata(hMainGui,'DoseRate',DoseRate);
set(handles.DoseRate,'String',DoseRate);

Parameter = {'Calibration No.';'Reference No.'; 'Nominal Tube Current [mA]';'Nominal Tube Voltage [kV]';...
             'Beam Quality HVL [mm Al]';'Air-Kerma Calibration Nk [Gy/C]';'SSD [cm]';...
             'Field size [cm^2]';'Total Radiation Time [sec]';'Mean M+ [C]';'Mean M- [C]';'Mean Temperature [deg.C]';...
             'Mean Pressure [kPa]';'Reference Temperature [deg.C]';'Reference Pressure [kPa]';
             'Electrometer Nominal Voltage [+/- V]'; 'Kpol'; 'Ktp';'Electrometer Ktp Correction Enabled?';...
             'Ks';'Kh';'Kelec';'Kq';'Kq Calculation Method';'End Effect time [sec]';'Stem Correction Factor';'Back scatter factor';...
             'Measurement Type';'Measurement Value [C]';'Measurement Offset [C]';...
             'Correct Reading M [C]';'Absorbed dose to water Dw [Gy]';'Dose Rate [Gy/sec]'};
         
Values    = {CalibNo;RefNo;mA;kV;BeamQualHVL;Nk;SSD;FieldSize;TotalRadTime;...
             MeanMplus;MeanMminus;MeanTemp;MeanPressure;RefTemp;RefPressure;...
             NominalVoltage;Kpol;Ktp;ElecKtpEnab;Ks;Kh;Kelec;Kq;KqCALMode;...
             delT;StemCorrection;BackScatterFactor;MselectionString;MeasuredValue;MeasOffset;CorrectedReading;...
             Dw;DoseRate};
                         
TableCD = table(Parameter,Values);
writetable(TableCD,'Calibration_Data.csv'); 
fclose('all');

    


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in SaveButton.
function SaveButton_Callback(hObject, eventdata, handles)
SaveFile;


% --- Executes on button press in WaterAirMMEAC.
function WaterAirMMEAC_Callback(hObject, eventdata, handles)
WaterToAirMeanMassEnergyAbsCoeff;
setappdata(0,'handles_WaterAirMMEAC',handles)

% Update with save_callback
UpdateWaterAirMMEAC;

function UpdateWaterAirMMEAC

% Get the main Gui data and use its fields
hMainGui = getappdata(0,'hMainGui');
WaterAirMMEAC   = getappdata(hMainGui,'WaterAirMMEAC');

% handles_DetRespData = getappdata(0,'handles_DetRespData');
setappdata(hMainGui,'WaterAirMMEAC',WaterAirMMEAC);
return;


function StemCorrection_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
StemCorrection  = get(handles.StemCorrection,'String');
setappdata(hMainGui,'StemCorrection',StemCorrection);



function BackScatterFactor_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');
BackScatterFactor  = get(handles.BackScatterFactor,'String');
setappdata(hMainGui,'BackScatterFactor',BackScatterFactor);
