function varargout = Pressure(varargin)
% Pressure MATLAB code for Pressure.fig
%      Pressure, by itself, creates a new Pressure or raises the existing
%      singleton*.
%
%      H = Pressure returns the handle to a new Pressure or the handle to
%      the existing singleton*.
%
%      Pressure('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Pressure.M with the given input arguments.
%
%      Pressure('Property','Value',...) creates a new Pressure or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Pressure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Pressure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Pressure

% Last Modified by GUIDE v2.5 12-Dec-2017 20:48:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Pressure_OpeningFcn, ...
    'gui_OutputFcn',  @Pressure_OutputFcn, ...
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


% --- Executes just before Pressure is made visible.
function Pressure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.

fid = fopen('Pressure_Data.txt','r');
if fid~=-1 %if the file doesn't exist ignore the reading code
    format long g
    Pressure =  fscanf(fid,'%f');
    set(handles.PressureMeasEdit1,'String',num2str(Pressure(1),'%.8f'))
    set(handles.PressureMeasEdit2,'String',num2str(Pressure(2),'%.8f'))
    set(handles.PressureMeasEdit3,'String',num2str(Pressure(3),'%.8f'))
    set(handles.PressureMeasEdit4,'String',num2str(Pressure(4),'%.8f'))
    set(handles.PressureMeasEdit5,'String',num2str(Pressure(5),'%.8f'))
    fclose(fid);
end


% Choose default command line output for Pressure
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Pressure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Pressure_OutputFcn(hObject, eventdata, handles)

global Pressure
varargout{1} = mean(Pressure);

% Get default command line output from handles structure
% varargout{1} = handles.output;
return;

function save_Callback(hObject, eventdata, handles)

global Pm1 Pm2 Pm3 Pm4 Pm5 Pressure;
Pm1 = str2double(get(handles.PressureMeasEdit1,'String'));
Pm2 = str2double(get(handles.PressureMeasEdit2,'String'));
Pm3 = str2double(get(handles.PressureMeasEdit3,'String'));
Pm4 = str2double(get(handles.PressureMeasEdit4,'String'));
Pm5 = str2double(get(handles.PressureMeasEdit5,'String'));
Pressure = [Pm1 Pm2 Pm3 Pm4 Pm5];
fid = fopen('Pressure_Data.txt','wt');
fprintf(fid,'%.15f\n',Pressure);
fclose(fid);

hMainGui = getappdata(0,'hMainGui');
UpdatePressure = getappdata(hMainGui,'UpdatePressure');

VdPressure = Pressure;
VdPressure(isnan(VdPressure)) = [];
MeanPressure = num2str(mean(VdPressure));
setappdata(hMainGui,'MeanPressure',MeanPressure);
feval(UpdatePressure);




function PressureMeasEdit1_Callback(hObject, eventdata, handles)

function PressureMeasEdit2_Callback(hObject, eventdata, handles)

function PressureMeasEdit3_Callback(hObject, eventdata, handles)

function PressureMeasEdit4_Callback(hObject, eventdata, handles)

function PressureMeasEdit5_Callback(hObject, eventdata, handles)


% --- Executes on button press in delete.
function delete_Callback(hObject, eventdata, handles)
delete(handles.figure1)
