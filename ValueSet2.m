function varargout = ValueSet2(varargin)
% ValueSet2 MATLAB code for ValueSet2.fig
%      ValueSet2, by itself, creates a new ValueSet2 or raises the existing
%      singleton*.
%
%      H = ValueSet2 returns the handle to a new ValueSet2 or the handle to
%      the existing singleton*.
%
%      ValueSet2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ValueSet2.M with the given input arguments.
%
%      ValueSet2('Property','Value',...) creates a new ValueSet2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ValueSet2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ValueSet2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ValueSet2

% Last Modified by GUIDE v2.5 12-Dec-2017 16:25:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ValueSet2_OpeningFcn, ...
    'gui_OutputFcn',  @ValueSet2_OutputFcn, ...
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


% --- Executes just before ValueSet2 is made visible.
function ValueSet2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.

fid = fopen('ValueSet2_Data.txt','r');
if fid~=-1 %if the file doesn't exist ignore the reading code
    format long g
    ValueSet2 =  fscanf(fid,'%f');
    set(handles.ValueSet2VoltagePlus,'String',num2str(ValueSet2(1),'%d'))
    set(handles.ValueSet2MeasEdit1,'String',num2str(ValueSet2(2),'%.8f'))
    set(handles.ValueSet2MeasEdit2,'String',num2str(ValueSet2(3),'%.8f'))
    set(handles.ValueSet2MeasEdit3,'String',num2str(ValueSet2(4),'%.8f'))
    set(handles.ValueSet2MeasEdit4,'String',num2str(ValueSet2(5),'%.8f'))
    set(handles.ValueSet2MeasEdit5,'String',num2str(ValueSet2(6),'%.8f'))
    
    set(handles.ValueSet2VoltageMinus,'String',num2str(ValueSet2(7),'%d'))
    set(handles.ValueSet2MeasEdit6,'String',num2str(ValueSet2(8),'%.8f'))
    set(handles.ValueSet2MeasEdit7,'String',num2str(ValueSet2(9),'%.8f'))
    set(handles.ValueSet2MeasEdit8,'String',num2str(ValueSet2(10),'%.8f'))
    set(handles.ValueSet2MeasEdit9,'String',num2str(ValueSet2(11),'%.8f'))
    set(handles.ValueSet2MeasEdit10,'String',num2str(ValueSet2(12),'%.8f'))
    fclose(fid);
end


% Choose default command line output for ValueSet2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ValueSet2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ValueSet2_OutputFcn(hObject, eventdata, handles)

global ValueSet2
varargout{1} = mean(ValueSet2);

% Get default command line output from handles structure
% varargout{1} = handles.output;
return;

function save_Callback(hObject, eventdata, handles)

global VP Tm1 Tm2 Tm3 Tm4 Tm5 VM Tm6 Tm7 Tm8 Tm9 Tm10 ValueSet2;
VP    =  str2double(get(handles.ValueSet2VoltagePlus,'String'));
Tm1   =  str2double(get(handles.ValueSet2MeasEdit1,'String'));
Tm2   =  str2double(get(handles.ValueSet2MeasEdit2,'String'));
Tm3   =  str2double(get(handles.ValueSet2MeasEdit3,'String'));
Tm4   =  str2double(get(handles.ValueSet2MeasEdit4,'String'));
Tm5   =  str2double(get(handles.ValueSet2MeasEdit5,'String'));

VM    =  str2double(get(handles.ValueSet2VoltageMinus,'String'));
Tm6   =  str2double(get(handles.ValueSet2MeasEdit6,'String'));
Tm7   =  str2double(get(handles.ValueSet2MeasEdit7,'String'));
Tm8   =  str2double(get(handles.ValueSet2MeasEdit8,'String'));
Tm9   =  str2double(get(handles.ValueSet2MeasEdit9,'String'));
Tm10  =  str2double(get(handles.ValueSet2MeasEdit10,'String'));

ValueSet2 = [VP Tm1 Tm2 Tm3 Tm4 Tm5 VM Tm6 Tm7 Tm8 Tm9 Tm10];
fid = fopen('ValueSet2_Data.txt','wt');
fprintf(fid,'%.15f\n',ValueSet2);
fclose(fid);

hMainGui = getappdata(0,'hMainGui');
UpdateValueSet2 = getappdata(hMainGui,'UpdateValueSet2');

VdValueSet2 = [Tm1 Tm2 Tm3 Tm4 Tm5 Tm6 Tm7 Tm8 Tm9 Tm10];
VdValueSet2(isnan(VdValueSet2)) = [];
MeanValueSet2 = num2str(mean(VdValueSet2));
setappdata(hMainGui,'MeanValueSet2',MeanValueSet2);
setappdata(hMainGui,'ValueSet2Voltage',VM);
feval(UpdateValueSet2);




function ValueSet2MeasEdit1_Callback(hObject, eventdata, handles)

function ValueSet2MeasEdit2_Callback(hObject, eventdata, handles)

function ValueSet2MeasEdit3_Callback(hObject, eventdata, handles)

function ValueSet2MeasEdit4_Callback(hObject, eventdata, handles)

function ValueSet2MeasEdit5_Callback(hObject, eventdata, handles)


% --- Executes on button press in delete.
function delete_Callback(hObject, eventdata, handles)
delete(handles.figure1)



function ValueSet2VoltageMinus_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet2VoltageMinus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet2VoltageMinus as text
%        str2double(get(hObject,'String')) returns contents of ValueSet2VoltageMinus as a double


% --- Executes during object creation, after setting all properties.
function ValueSet2VoltageMinus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet2VoltageMinus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet2MeasEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet2MeasEdit1 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet2MeasEdit1 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet2MeasEdit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet2MeasEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet2MeasEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet2MeasEdit2 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet2MeasEdit2 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet2MeasEdit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet2MeasEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet2MeasEdit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet2MeasEdit3 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet2MeasEdit3 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet2MeasEdit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet2MeasEdit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet2MeasEdit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet2MeasEdit4 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet2MeasEdit4 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet2MeasEdit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet2MeasEdit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet2MeasEdit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet2MeasEdit5 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet2MeasEdit5 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet2MeasEdit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet2MeasEdit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ValueSet2VoltagePlus_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet2VoltagePlus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet2VoltagePlus as text
%        str2double(get(hObject,'String')) returns contents of ValueSet2VoltagePlus as a double


% --- Executes during object creation, after setting all properties.
function ValueSet2VoltagePlus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet2VoltagePlus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
