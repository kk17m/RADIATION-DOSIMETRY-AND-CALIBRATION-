function varargout = ValueSet4(varargin)
% ValueSet4 MATLAB code for ValueSet4.fig
%      ValueSet4, by itself, creates a new ValueSet4 or raises the existing
%      singleton*.
%
%      H = ValueSet4 returns the handle to a new ValueSet4 or the handle to
%      the existing singleton*.
%
%      ValueSet4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ValueSet4.M with the given input arguments.
%
%      ValueSet4('Property','Value',...) creates a new ValueSet4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ValueSet4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ValueSet4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ValueSet4

% Last Modified by GUIDE v2.5 12-Dec-2017 16:25:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ValueSet4_OpeningFcn, ...
    'gui_OutputFcn',  @ValueSet4_OutputFcn, ...
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


% --- Executes just before ValueSet4 is made visible.
function ValueSet4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.

fid = fopen('ValueSet4_Data.txt','r');
if fid~=-1 %if the file doesn't exist ignore the reading code
    format long g
    ValueSet4 =  fscanf(fid,'%f');
    set(handles.ValueSet4VoltagePlus,'String',num2str(ValueSet4(1),'%d'))
    set(handles.ValueSet4MeasEdit1,'String',num2str(ValueSet4(2),'%.8f'))
    set(handles.ValueSet4MeasEdit2,'String',num2str(ValueSet4(3),'%.8f'))
    set(handles.ValueSet4MeasEdit3,'String',num2str(ValueSet4(4),'%.8f'))
    set(handles.ValueSet4MeasEdit4,'String',num2str(ValueSet4(5),'%.8f'))
    set(handles.ValueSet4MeasEdit5,'String',num2str(ValueSet4(6),'%.8f'))
    
    set(handles.ValueSet4VoltageMinus,'String',num2str(ValueSet4(7),'%d'))
    set(handles.ValueSet4MeasEdit6,'String',num2str(ValueSet4(8),'%.8f'))
    set(handles.ValueSet4MeasEdit7,'String',num2str(ValueSet4(9),'%.8f'))
    set(handles.ValueSet4MeasEdit8,'String',num2str(ValueSet4(10),'%.8f'))
    set(handles.ValueSet4MeasEdit9,'String',num2str(ValueSet4(11),'%.8f'))
    set(handles.ValueSet4MeasEdit10,'String',num2str(ValueSet4(12),'%.8f'))
    fclose(fid);
end


% Choose default command line output for ValueSet4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ValueSet4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ValueSet4_OutputFcn(hObject, eventdata, handles)

global ValueSet4
varargout{1} = mean(ValueSet4);

% Get default command line output from handles structure
% varargout{1} = handles.output;
return;

function save_Callback(hObject, eventdata, handles)

global VP Tm1 Tm2 Tm3 Tm4 Tm5 VM Tm6 Tm7 Tm8 Tm9 Tm10 ValueSet4;
VP    =  str2double(get(handles.ValueSet4VoltagePlus,'String'));
Tm1   =  str2double(get(handles.ValueSet4MeasEdit1,'String'));
Tm2   =  str2double(get(handles.ValueSet4MeasEdit2,'String'));
Tm3   =  str2double(get(handles.ValueSet4MeasEdit3,'String'));
Tm4   =  str2double(get(handles.ValueSet4MeasEdit4,'String'));
Tm5   =  str2double(get(handles.ValueSet4MeasEdit5,'String'));

VM    =  str2double(get(handles.ValueSet4VoltageMinus,'String'));
Tm6   =  str2double(get(handles.ValueSet4MeasEdit6,'String'));
Tm7   =  str2double(get(handles.ValueSet4MeasEdit7,'String'));
Tm8   =  str2double(get(handles.ValueSet4MeasEdit8,'String'));
Tm9   =  str2double(get(handles.ValueSet4MeasEdit9,'String'));
Tm10  =  str2double(get(handles.ValueSet4MeasEdit10,'String'));

ValueSet4 = [VP Tm1 Tm2 Tm3 Tm4 Tm5 VM Tm6 Tm7 Tm8 Tm9 Tm10];
fid = fopen('ValueSet4_Data.txt','wt');
fprintf(fid,'%.15f\n',ValueSet4);
fclose(fid);

hMainGui = getappdata(0,'hMainGui');
UpdateValueSet4 = getappdata(hMainGui,'UpdateValueSet4');

VdValueSet4 = [Tm1 Tm2 Tm3 Tm4 Tm5 Tm6 Tm7 Tm8 Tm9 Tm10];
VdValueSet4(isnan(VdValueSet4)) = [];
MeanValueSet4 = num2str(mean(VdValueSet4));
setappdata(hMainGui,'MeanValueSet4',MeanValueSet4);
setappdata(hMainGui,'ValueSet4Voltage',VM);
feval(UpdateValueSet4);




function ValueSet4MeasEdit1_Callback(hObject, eventdata, handles)

function ValueSet4MeasEdit2_Callback(hObject, eventdata, handles)

function ValueSet4MeasEdit3_Callback(hObject, eventdata, handles)

function ValueSet4MeasEdit4_Callback(hObject, eventdata, handles)

function ValueSet4MeasEdit5_Callback(hObject, eventdata, handles)


% --- Executes on button press in delete.
function delete_Callback(hObject, eventdata, handles)
delete(handles.figure1)



function ValueSet4VoltageMinus_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet4VoltageMinus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet4VoltageMinus as text
%        str2double(get(hObject,'String')) returns contents of ValueSet4VoltageMinus as a double


% --- Executes during object creation, after setting all properties.
function ValueSet4VoltageMinus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet4VoltageMinus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet4MeasEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet4MeasEdit1 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet4MeasEdit1 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet4MeasEdit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet4MeasEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet4MeasEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet4MeasEdit2 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet4MeasEdit2 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet4MeasEdit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet4MeasEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet4MeasEdit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet4MeasEdit3 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet4MeasEdit3 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet4MeasEdit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet4MeasEdit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet4MeasEdit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet4MeasEdit4 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet4MeasEdit4 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet4MeasEdit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet4MeasEdit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet4MeasEdit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet4MeasEdit5 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet4MeasEdit5 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet4MeasEdit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet4MeasEdit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ValueSet4VoltagePlus_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet4VoltagePlus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet4VoltagePlus as text
%        str2double(get(hObject,'String')) returns contents of ValueSet4VoltagePlus as a double


% --- Executes during object creation, after setting all properties.
function ValueSet4VoltagePlus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet4VoltagePlus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
