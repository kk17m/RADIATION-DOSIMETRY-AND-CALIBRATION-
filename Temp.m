function varargout = Temp(varargin)
% Temp MATLAB code for Temp.fig
%      Temp, by itself, creates a new Temp or raises the existing
%      singleton*.
%
%      H = Temp returns the handle to a new Temp or the handle to
%      the existing singleton*.
%
%      Temp('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Temp.M with the given input arguments.
%
%      Temp('Property','Value',...) creates a new Temp or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Temp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Temp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Temp

% Last Modified by GUIDE v2.5 10-Dec-2017 19:46:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Temp_OpeningFcn, ...
    'gui_OutputFcn',  @Temp_OutputFcn, ...
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


% --- Executes just before Temp is made visible.
function Temp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.

fid = fopen('Temp_Data.txt','r');
if fid~=-1 %if the file doesn't exist ignore the reading code
    format long g
    Temp =  fscanf(fid,'%f');
    set(handles.TempMeasEdit1,'String',num2str(Temp(1),'%.8f'))
    set(handles.TempMeasEdit2,'String',num2str(Temp(2),'%.8f'))
    set(handles.TempMeasEdit3,'String',num2str(Temp(3),'%.8f'))
    set(handles.TempMeasEdit4,'String',num2str(Temp(4),'%.8f'))
    set(handles.TempMeasEdit5,'String',num2str(Temp(5),'%.8f'))
    fclose(fid);
end


% Choose default command line output for Temp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Temp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Temp_OutputFcn(hObject, eventdata, handles)

global Temp
varargout{1} = mean(Temp);

% Get default command line output from handles structure
% varargout{1} = handles.output;
return;

function save_Callback(hObject, eventdata, handles)

global Tm1 Tm2 Tm3 Tm4 Tm5 Temp;
Tm1 = str2double(get(handles.TempMeasEdit1,'String'));
Tm2 = str2double(get(handles.TempMeasEdit2,'String'));
Tm3 = str2double(get(handles.TempMeasEdit3,'String'));
Tm4 = str2double(get(handles.TempMeasEdit4,'String'));
Tm5 = str2double(get(handles.TempMeasEdit5,'String'));
Temp = [Tm1 Tm2 Tm3 Tm4 Tm5];
fid = fopen('Temp_Data.txt','wt');
fprintf(fid,'%.15f\n',Temp);
fclose(fid);

hMainGui = getappdata(0,'hMainGui');
UpdateTemp = getappdata(hMainGui,'UpdateTemp');

VdTemp = Temp;
VdTemp(isnan(VdTemp)) = [];
MeanTemp = num2str(mean(VdTemp));
setappdata(hMainGui,'MeanTemp',MeanTemp);
feval(UpdateTemp);




function TempMeasEdit1_Callback(hObject, eventdata, handles)

function TempMeasEdit2_Callback(hObject, eventdata, handles)

function TempMeasEdit3_Callback(hObject, eventdata, handles)

function TempMeasEdit4_Callback(hObject, eventdata, handles)

function TempMeasEdit5_Callback(hObject, eventdata, handles)


% --- Executes on button press in delete.
function delete_Callback(hObject, eventdata, handles)
delete(handles.figure1)
