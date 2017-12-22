function varargout = ValueSet3(varargin)
% ValueSet3 MATLAB code for ValueSet3.fig
%      ValueSet3, by itself, creates a new ValueSet3 or raises the existing
%      singleton*.
%
%      H = ValueSet3 returns the handle to a new ValueSet3 or the handle to
%      the existing singleton*.
%
%      ValueSet3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ValueSet3.M with the given input arguments.
%
%      ValueSet3('Property','Value',...) creates a new ValueSet3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ValueSet3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ValueSet3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ValueSet3

% Last Modified by GUIDE v2.5 12-Dec-2017 16:25:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ValueSet3_OpeningFcn, ...
    'gui_OutputFcn',  @ValueSet3_OutputFcn, ...
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


% --- Executes just before ValueSet3 is made visible.
function ValueSet3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.

fid = fopen('ValueSet3_Data.txt','r');
if fid~=-1 %if the file doesn't exist ignore the reading code
    format long g
    ValueSet3 =  fscanf(fid,'%f');
    set(handles.ValueSet3VoltagePlus,'String',num2str(ValueSet3(1),'%d'))
    set(handles.ValueSet3MeasEdit1,'String',num2str(ValueSet3(2),'%.8f'))
    set(handles.ValueSet3MeasEdit2,'String',num2str(ValueSet3(3),'%.8f'))
    set(handles.ValueSet3MeasEdit3,'String',num2str(ValueSet3(4),'%.8f'))
    set(handles.ValueSet3MeasEdit4,'String',num2str(ValueSet3(5),'%.8f'))
    set(handles.ValueSet3MeasEdit5,'String',num2str(ValueSet3(6),'%.8f'))
    
    set(handles.ValueSet3VoltageMinus,'String',num2str(ValueSet3(7),'%d'))
    set(handles.ValueSet3MeasEdit6,'String',num2str(ValueSet3(8),'%.8f'))
    set(handles.ValueSet3MeasEdit7,'String',num2str(ValueSet3(9),'%.8f'))
    set(handles.ValueSet3MeasEdit8,'String',num2str(ValueSet3(10),'%.8f'))
    set(handles.ValueSet3MeasEdit9,'String',num2str(ValueSet3(11),'%.8f'))
    set(handles.ValueSet3MeasEdit10,'String',num2str(ValueSet3(12),'%.8f'))
    fclose(fid);
end


% Choose default command line output for ValueSet3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ValueSet3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ValueSet3_OutputFcn(hObject, eventdata, handles)

global ValueSet3
varargout{1} = mean(ValueSet3);

% Get default command line output from handles structure
% varargout{1} = handles.output;
return;

function save_Callback(hObject, eventdata, handles)

global VP Tm1 Tm2 Tm3 Tm4 Tm5 VM Tm6 Tm7 Tm8 Tm9 Tm10 ValueSet3;
VP    =  str2double(get(handles.ValueSet3VoltagePlus,'String'));
Tm1   =  str2double(get(handles.ValueSet3MeasEdit1,'String'));
Tm2   =  str2double(get(handles.ValueSet3MeasEdit2,'String'));
Tm3   =  str2double(get(handles.ValueSet3MeasEdit3,'String'));
Tm4   =  str2double(get(handles.ValueSet3MeasEdit4,'String'));
Tm5   =  str2double(get(handles.ValueSet3MeasEdit5,'String'));

VM    =  str2double(get(handles.ValueSet3VoltageMinus,'String'));
Tm6   =  str2double(get(handles.ValueSet3MeasEdit6,'String'));
Tm7   =  str2double(get(handles.ValueSet3MeasEdit7,'String'));
Tm8   =  str2double(get(handles.ValueSet3MeasEdit8,'String'));
Tm9   =  str2double(get(handles.ValueSet3MeasEdit9,'String'));
Tm10  =  str2double(get(handles.ValueSet3MeasEdit10,'String'));

ValueSet3 = [VP Tm1 Tm2 Tm3 Tm4 Tm5 VM Tm6 Tm7 Tm8 Tm9 Tm10];
fid = fopen('ValueSet3_Data.txt','wt');
fprintf(fid,'%.15f\n',ValueSet3);
fclose(fid);

hMainGui = getappdata(0,'hMainGui');
UpdateValueSet3 = getappdata(hMainGui,'UpdateValueSet3');

VdValueSet3 = [Tm1 Tm2 Tm3 Tm4 Tm5 Tm6 Tm7 Tm8 Tm9 Tm10];
VdValueSet3(isnan(VdValueSet3)) = [];
MeanValueSet3 = num2str(mean(VdValueSet3));
setappdata(hMainGui,'MeanValueSet3',MeanValueSet3);
setappdata(hMainGui,'ValueSet3Voltage',VM);
feval(UpdateValueSet3);




function ValueSet3MeasEdit1_Callback(hObject, eventdata, handles)

function ValueSet3MeasEdit2_Callback(hObject, eventdata, handles)

function ValueSet3MeasEdit3_Callback(hObject, eventdata, handles)

function ValueSet3MeasEdit4_Callback(hObject, eventdata, handles)

function ValueSet3MeasEdit5_Callback(hObject, eventdata, handles)


% --- Executes on button press in delete.
function delete_Callback(hObject, eventdata, handles)
delete(handles.figure1)



function ValueSet3VoltageMinus_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet3VoltageMinus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet3VoltageMinus as text
%        str2double(get(hObject,'String')) returns contents of ValueSet3VoltageMinus as a double


% --- Executes during object creation, after setting all properties.
function ValueSet3VoltageMinus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet3VoltageMinus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet3MeasEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet3MeasEdit1 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet3MeasEdit1 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet3MeasEdit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet3MeasEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet3MeasEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet3MeasEdit2 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet3MeasEdit2 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet3MeasEdit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet3MeasEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet3MeasEdit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet3MeasEdit3 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet3MeasEdit3 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet3MeasEdit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet3MeasEdit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet3MeasEdit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet3MeasEdit4 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet3MeasEdit4 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet3MeasEdit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet3MeasEdit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet3MeasEdit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet3MeasEdit5 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet3MeasEdit5 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet3MeasEdit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet3MeasEdit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ValueSet3VoltagePlus_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet3VoltagePlus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet3VoltagePlus as text
%        str2double(get(hObject,'String')) returns contents of ValueSet3VoltagePlus as a double


% --- Executes during object creation, after setting all properties.
function ValueSet3VoltagePlus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet3VoltagePlus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
