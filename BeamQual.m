function varargout = BeamQual(varargin)
% BeamQual MATLAB code for BeamQual.fig
%      BeamQual, by itself, creates a new BeamQual or raises the existing
%      singleton*.
%
%      H = BeamQual returns the handle to a new BeamQual or the handle to
%      the existing singleton*.
%
%      BeamQual('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BeamQual.M with the given input arguments.
%
%      BeamQual('Property','Value',...) creates a new BeamQual or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BeamQual_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BeamQual_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BeamQual

% Last Modified by GUIDE v2.5 13-Dec-2017 23:21:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @BeamQual_OpeningFcn, ...
    'gui_OutputFcn',  @BeamQual_OutputFcn, ...
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


% --- Executes just before BeamQual is made visible.
function BeamQual_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.

fid = fopen('BeamQual_Data.txt','r');
if fid~=-1 %if the file doesn't exist ignore the reading code
    format long g
    BeamQual =  fscanf(fid,'%f');
    set(handles.BeamQualMeasEdit1,'String',num2str(BeamQual(1),'%.8f'))
    set(handles.BeamQualMeasEdit2,'String',num2str(BeamQual(2),'%.8f'))
    set(handles.BeamQualMeasEdit3,'String',num2str(BeamQual(3),'%.8f'))
    set(handles.BeamQualMeasEdit4,'String',num2str(BeamQual(4),'%.8f'))
    set(handles.BeamQualMeasEdit5,'String',num2str(BeamQual(5),'%.8f'))
    
    set(handles.BeamQualMeasEdit6,'String',num2str(BeamQual(6),'%.8f'))
    set(handles.BeamQualMeasEdit7,'String',num2str(BeamQual(7),'%.8f'))
    set(handles.BeamQualMeasEdit8,'String',num2str(BeamQual(8),'%.8f'))
    set(handles.BeamQualMeasEdit9,'String',num2str(BeamQual(9),'%.8f'))
    set(handles.BeamQualMeasEdit10,'String',num2str(BeamQual(10),'%.8f'))
    fclose(fid);
end


% Choose default command line output for BeamQual
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BeamQual wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BeamQual_OutputFcn(hObject, eventdata, handles)

global BeamQual
varargout{1} = mean(BeamQual);

% Get default command line output from handles structure
% varargout{1} = handles.output;
return;

function save_Callback(hObject, eventdata, handles)

global  Tm1 Tm2 Tm3 Tm4 Tm5 Tm6 Tm7 Tm8 Tm9 Tm10 BeamQual;

Tm1   =  str2double(get(handles.BeamQualMeasEdit1,'String'));
Tm2   =  str2double(get(handles.BeamQualMeasEdit2,'String'));
Tm3   =  str2double(get(handles.BeamQualMeasEdit3,'String'));
Tm4   =  str2double(get(handles.BeamQualMeasEdit4,'String'));
Tm5   =  str2double(get(handles.BeamQualMeasEdit5,'String'));

Tm6   =  str2double(get(handles.BeamQualMeasEdit6,'String'));
Tm7   =  str2double(get(handles.BeamQualMeasEdit7,'String'));
Tm8   =  str2double(get(handles.BeamQualMeasEdit8,'String'));
Tm9   =  str2double(get(handles.BeamQualMeasEdit9,'String'));
Tm10  =  str2double(get(handles.BeamQualMeasEdit10,'String'));

BeamQual = [ Tm1 Tm2 Tm3 Tm4 Tm5 Tm6 Tm7 Tm8 Tm9 Tm10];
fid = fopen('BeamQual_Data.txt','wt');
fprintf(fid,'%.15f\n',BeamQual);
fclose(fid);

hMainGui = getappdata(0,'hMainGui');
UpdateBeamQual = getappdata(hMainGui,'UpdateBeamQual');

VdBeamQual = BeamQual;
VdBeamQual(isnan(VdBeamQual)) = [];

setappdata(hMainGui,'BeamQualData',VdBeamQual);
feval(UpdateBeamQual);




function BeamQualMeasEdit1_Callback(hObject, eventdata, handles)

function BeamQualMeasEdit2_Callback(hObject, eventdata, handles)

function BeamQualMeasEdit3_Callback(hObject, eventdata, handles)

function BeamQualMeasEdit4_Callback(hObject, eventdata, handles)

function BeamQualMeasEdit5_Callback(hObject, eventdata, handles)


% --- Executes on button press in delete.
function delete_Callback(hObject, eventdata, handles)
delete(handles.figure1)



function BeamQualVoltageMinus_Callback(hObject, eventdata, handles)
% hObject    handle to BeamQualVoltageMinus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BeamQualVoltageMinus as text
%        str2double(get(hObject,'String')) returns contents of BeamQualVoltageMinus as a double


% --- Executes during object creation, after setting all properties.
function BeamQualVoltageMinus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BeamQualVoltageMinus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to BeamQualMeasEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BeamQualMeasEdit1 as text
%        str2double(get(hObject,'String')) returns contents of BeamQualMeasEdit1 as a double


% --- Executes during object creation, after setting all properties.
function BeamQualMeasEdit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BeamQualMeasEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to BeamQualMeasEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BeamQualMeasEdit2 as text
%        str2double(get(hObject,'String')) returns contents of BeamQualMeasEdit2 as a double


% --- Executes during object creation, after setting all properties.
function BeamQualMeasEdit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BeamQualMeasEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to BeamQualMeasEdit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BeamQualMeasEdit3 as text
%        str2double(get(hObject,'String')) returns contents of BeamQualMeasEdit3 as a double


% --- Executes during object creation, after setting all properties.
function BeamQualMeasEdit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BeamQualMeasEdit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to BeamQualMeasEdit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BeamQualMeasEdit4 as text
%        str2double(get(hObject,'String')) returns contents of BeamQualMeasEdit4 as a double


% --- Executes during object creation, after setting all properties.
function BeamQualMeasEdit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BeamQualMeasEdit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to BeamQualMeasEdit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BeamQualMeasEdit5 as text
%        str2double(get(hObject,'String')) returns contents of BeamQualMeasEdit5 as a double


% --- Executes during object creation, after setting all properties.
function BeamQualMeasEdit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BeamQualMeasEdit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function BeamQualVoltagePlus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BeamQualVoltagePlus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



