function varargout = DetRespData(varargin)
% DetRespData MATLAB code for DetRespData.fig
%      DetRespData, by itself, creates a new DetRespData or raises the existing
%      singleton*.
%
%      H = DetRespData returns the handle to a new DetRespData or the handle to
%      the existing singleton*.
%
%      DetRespData('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DetRespData.M with the given input arguments.
%
%      DetRespData('Property','Value',...) creates a new DetRespData or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DetRespData_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DetRespData_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DetRespData

% Last Modified by GUIDE v2.5 13-Dec-2017 23:21:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @DetRespData_OpeningFcn, ...
    'gui_OutputFcn',  @DetRespData_OutputFcn, ...
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


% --- Executes just before DetRespData is made visible.
function DetRespData_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.

fid = fopen('DetRespData_Data.txt','r');
if fid~=-1 %if the file doesn't exist ignore the reading code
    format long g
    DetRespData =  fscanf(fid,'%f');
    set(handles.DetRespDataMeasEdit1,'String',num2str(DetRespData(1),'%.8f'))
    set(handles.DetRespDataMeasEdit2,'String',num2str(DetRespData(2),'%.8f'))
    set(handles.DetRespDataMeasEdit3,'String',num2str(DetRespData(3),'%.8f'))
    set(handles.DetRespDataMeasEdit4,'String',num2str(DetRespData(4),'%.8f'))
    set(handles.DetRespDataMeasEdit5,'String',num2str(DetRespData(5),'%.8f'))
    
    set(handles.DetRespDataMeasEdit6,'String',num2str(DetRespData(6),'%.8f'))
    set(handles.DetRespDataMeasEdit7,'String',num2str(DetRespData(7),'%.8f'))
    set(handles.DetRespDataMeasEdit8,'String',num2str(DetRespData(8),'%.8f'))
    set(handles.DetRespDataMeasEdit9,'String',num2str(DetRespData(9),'%.8f'))
    set(handles.DetRespDataMeasEdit10,'String',num2str(DetRespData(10),'%.8f'))
    fclose(fid);
end


% Choose default command line output for DetRespData
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DetRespData wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DetRespData_OutputFcn(hObject, eventdata, handles)

global DetRespData
varargout{1} = mean(DetRespData);

% Get default command line output from handles structure
% varargout{1} = handles.output;
return;

function save_Callback(hObject, eventdata, handles)

global  Tm1 Tm2 Tm3 Tm4 Tm5 Tm6 Tm7 Tm8 Tm9 Tm10 DetRespData;

Tm1   =  str2double(get(handles.DetRespDataMeasEdit1,'String'));
Tm2   =  str2double(get(handles.DetRespDataMeasEdit2,'String'));
Tm3   =  str2double(get(handles.DetRespDataMeasEdit3,'String'));
Tm4   =  str2double(get(handles.DetRespDataMeasEdit4,'String'));
Tm5   =  str2double(get(handles.DetRespDataMeasEdit5,'String'));

Tm6   =  str2double(get(handles.DetRespDataMeasEdit6,'String'));
Tm7   =  str2double(get(handles.DetRespDataMeasEdit7,'String'));
Tm8   =  str2double(get(handles.DetRespDataMeasEdit8,'String'));
Tm9   =  str2double(get(handles.DetRespDataMeasEdit9,'String'));
Tm10  =  str2double(get(handles.DetRespDataMeasEdit10,'String'));

DetRespData = [ Tm1 Tm2 Tm3 Tm4 Tm5 Tm6 Tm7 Tm8 Tm9 Tm10];
fid = fopen('DetRespData_Data.txt','wt');
fprintf(fid,'%.15f\n',DetRespData);
fclose(fid);

hMainGui = getappdata(0,'hMainGui');
UpdateDetRespData = getappdata(hMainGui,'UpdateDetRespData');

VdDetRespData = DetRespData;
VdDetRespData(isnan(VdDetRespData)) = [];

setappdata(hMainGui,'DetRespData',VdDetRespData);
feval(UpdateDetRespData);




function DetRespDataMeasEdit1_Callback(hObject, eventdata, handles)

function DetRespDataMeasEdit2_Callback(hObject, eventdata, handles)

function DetRespDataMeasEdit3_Callback(hObject, eventdata, handles)

function DetRespDataMeasEdit4_Callback(hObject, eventdata, handles)

function DetRespDataMeasEdit5_Callback(hObject, eventdata, handles)


% --- Executes on button press in delete.
function delete_Callback(hObject, eventdata, handles)
delete(handles.figure1)



function DetRespDataVoltageMinus_Callback(hObject, eventdata, handles)
% hObject    handle to DetRespDataVoltageMinus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DetRespDataVoltageMinus as text
%        str2double(get(hObject,'String')) returns contents of DetRespDataVoltageMinus as a double


% --- Executes during object creation, after setting all properties.
function DetRespDataVoltageMinus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DetRespDataVoltageMinus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to DetRespDataMeasEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DetRespDataMeasEdit1 as text
%        str2double(get(hObject,'String')) returns contents of DetRespDataMeasEdit1 as a double


% --- Executes during object creation, after setting all properties.
function DetRespDataMeasEdit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DetRespDataMeasEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to DetRespDataMeasEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DetRespDataMeasEdit2 as text
%        str2double(get(hObject,'String')) returns contents of DetRespDataMeasEdit2 as a double


% --- Executes during object creation, after setting all properties.
function DetRespDataMeasEdit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DetRespDataMeasEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to DetRespDataMeasEdit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DetRespDataMeasEdit3 as text
%        str2double(get(hObject,'String')) returns contents of DetRespDataMeasEdit3 as a double


% --- Executes during object creation, after setting all properties.
function DetRespDataMeasEdit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DetRespDataMeasEdit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to DetRespDataMeasEdit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DetRespDataMeasEdit4 as text
%        str2double(get(hObject,'String')) returns contents of DetRespDataMeasEdit4 as a double


% --- Executes during object creation, after setting all properties.
function DetRespDataMeasEdit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DetRespDataMeasEdit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to DetRespDataMeasEdit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DetRespDataMeasEdit5 as text
%        str2double(get(hObject,'String')) returns contents of DetRespDataMeasEdit5 as a double


% --- Executes during object creation, after setting all properties.
function DetRespDataMeasEdit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DetRespDataMeasEdit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function DetRespDataVoltagePlus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DetRespDataVoltagePlus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



