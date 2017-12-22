function varargout = ValueSet1(varargin)
% ValueSet1 MATLAB code for ValueSet1.fig
%      ValueSet1, by itself, creates a new ValueSet1 or raises the existing
%      singleton*.
%
%      H = ValueSet1 returns the handle to a new ValueSet1 or the handle to
%      the existing singleton*.
%
%      ValueSet1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ValueSet1.M with the given input arguments.
%
%      ValueSet1('Property','Value',...) creates a new ValueSet1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ValueSet1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ValueSet1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ValueSet1

% Last Modified by GUIDE v2.5 12-Dec-2017 16:25:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ValueSet1_OpeningFcn, ...
    'gui_OutputFcn',  @ValueSet1_OutputFcn, ...
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


% --- Executes just before ValueSet1 is made visible.
function ValueSet1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.

fid = fopen('ValueSet1_Data.txt','r');
if fid~=-1 %if the file doesn't exist ignore the reading code
    format long g
    ValueSet1 =  fscanf(fid,'%f');
    set(handles.ValueSet1VoltagePlus,'String',num2str(ValueSet1(1),'%d'))
    set(handles.ValueSet1MeasEdit1,'String',num2str(ValueSet1(2),'%.8f'))
    set(handles.ValueSet1MeasEdit2,'String',num2str(ValueSet1(3),'%.8f'))
    set(handles.ValueSet1MeasEdit3,'String',num2str(ValueSet1(4),'%.8f'))
    set(handles.ValueSet1MeasEdit4,'String',num2str(ValueSet1(5),'%.8f'))
    set(handles.ValueSet1MeasEdit5,'String',num2str(ValueSet1(6),'%.8f'))
    
    set(handles.ValueSet1VoltageMinus,'String',num2str(ValueSet1(7),'%d'))
    set(handles.ValueSet1MeasEdit6,'String',num2str(ValueSet1(8),'%.8f'))
    set(handles.ValueSet1MeasEdit7,'String',num2str(ValueSet1(9),'%.8f'))
    set(handles.ValueSet1MeasEdit8,'String',num2str(ValueSet1(10),'%.8f'))
    set(handles.ValueSet1MeasEdit9,'String',num2str(ValueSet1(11),'%.8f'))
    set(handles.ValueSet1MeasEdit10,'String',num2str(ValueSet1(12),'%.8f'))
    fclose(fid);
end


% Choose default command line output for ValueSet1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ValueSet1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ValueSet1_OutputFcn(hObject, eventdata, handles)

global ValueSet1
varargout{1} = mean(ValueSet1);

% Get default command line output from handles structure
% varargout{1} = handles.output;
return;

function save_Callback(hObject, eventdata, handles)

global VP Tm1 Tm2 Tm3 Tm4 Tm5 VM Tm6 Tm7 Tm8 Tm9 Tm10 ValueSet1;
VP    =  str2double(get(handles.ValueSet1VoltagePlus,'String'));
Tm1   =  str2double(get(handles.ValueSet1MeasEdit1,'String'));
Tm2   =  str2double(get(handles.ValueSet1MeasEdit2,'String'));
Tm3   =  str2double(get(handles.ValueSet1MeasEdit3,'String'));
Tm4   =  str2double(get(handles.ValueSet1MeasEdit4,'String'));
Tm5   =  str2double(get(handles.ValueSet1MeasEdit5,'String'));

VM    =  str2double(get(handles.ValueSet1VoltageMinus,'String'));
Tm6   =  str2double(get(handles.ValueSet1MeasEdit6,'String'));
Tm7   =  str2double(get(handles.ValueSet1MeasEdit7,'String'));
Tm8   =  str2double(get(handles.ValueSet1MeasEdit8,'String'));
Tm9   =  str2double(get(handles.ValueSet1MeasEdit9,'String'));
Tm10  =  str2double(get(handles.ValueSet1MeasEdit10,'String'));

ValueSet1 = [VP Tm1 Tm2 Tm3 Tm4 Tm5 VM Tm6 Tm7 Tm8 Tm9 Tm10];
fid = fopen('ValueSet1_Data.txt','wt');
fprintf(fid,'%.15f\n',ValueSet1);
fclose(fid);

hMainGui = getappdata(0,'hMainGui');
UpdateValueSet1 = getappdata(hMainGui,'UpdateValueSet1');

VdValueSet1 = [Tm1 Tm2 Tm3 Tm4 Tm5 Tm6 Tm7 Tm8 Tm9 Tm10];
VdValueSet1(isnan(VdValueSet1)) = [];
MeanValueSet1 = num2str(mean(VdValueSet1));
setappdata(hMainGui,'MeanValueSet1',MeanValueSet1);
setappdata(hMainGui,'ValueSet1Voltage',VM);
feval(UpdateValueSet1);




function ValueSet1MeasEdit1_Callback(hObject, eventdata, handles)

function ValueSet1MeasEdit2_Callback(hObject, eventdata, handles)

function ValueSet1MeasEdit3_Callback(hObject, eventdata, handles)

function ValueSet1MeasEdit4_Callback(hObject, eventdata, handles)

function ValueSet1MeasEdit5_Callback(hObject, eventdata, handles)


% --- Executes on button press in delete.
function delete_Callback(hObject, eventdata, handles)
delete(handles.figure1)



function ValueSet1VoltageMinus_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet1VoltageMinus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet1VoltageMinus as text
%        str2double(get(hObject,'String')) returns contents of ValueSet1VoltageMinus as a double


% --- Executes during object creation, after setting all properties.
function ValueSet1VoltageMinus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet1VoltageMinus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet1MeasEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet1MeasEdit1 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet1MeasEdit1 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet1MeasEdit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet1MeasEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet1MeasEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet1MeasEdit2 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet1MeasEdit2 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet1MeasEdit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet1MeasEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet1MeasEdit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet1MeasEdit3 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet1MeasEdit3 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet1MeasEdit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet1MeasEdit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet1MeasEdit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet1MeasEdit4 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet1MeasEdit4 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet1MeasEdit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet1MeasEdit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet1MeasEdit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet1MeasEdit5 as text
%        str2double(get(hObject,'String')) returns contents of ValueSet1MeasEdit5 as a double


% --- Executes during object creation, after setting all properties.
function ValueSet1MeasEdit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet1MeasEdit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ValueSet1VoltagePlus_Callback(hObject, eventdata, handles)
% hObject    handle to ValueSet1VoltagePlus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValueSet1VoltagePlus as text
%        str2double(get(hObject,'String')) returns contents of ValueSet1VoltagePlus as a double


% --- Executes during object creation, after setting all properties.
function ValueSet1VoltagePlus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValueSet1VoltagePlus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
