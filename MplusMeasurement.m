function varargout = MplusMeasurement(varargin)
% MPLUSMEASUREMENT MATLAB code for MplusMeasurement.fig
%      MPLUSMEASUREMENT, by itself, creates a new MPLUSMEASUREMENT or raises the existing
%      singleton*.
%
%      H = MPLUSMEASUREMENT returns the handle to a new MPLUSMEASUREMENT or the handle to
%      the existing singleton*.
%
%      MPLUSMEASUREMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MPLUSMEASUREMENT.M with the given input arguments.
%
%      MPLUSMEASUREMENT('Property','Value',...) creates a new MPLUSMEASUREMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MplusMeasurement_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MplusMeasurement_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MplusMeasurement

% Last Modified by GUIDE v2.5 10-Dec-2017 19:43:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MplusMeasurement_OpeningFcn, ...
    'gui_OutputFcn',  @MplusMeasurement_OutputFcn, ...
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


% --- Executes just before MplusMeasurement is made visible.
function MplusMeasurement_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.

fid = fopen('Mplus_Data.txt','r');
if fid~=-1 %if the file doesn't exist ignore the reading code
    format long g
    Mplus =  fscanf(fid,'%f');
    set(handles.MplusMeasEdit1,'String',num2str(Mplus(1),'%.8f'))
    set(handles.MplusMeasEdit2,'String',num2str(Mplus(2),'%.8f'))
    set(handles.MplusMeasEdit3,'String',num2str(Mplus(3),'%.8f'))
    set(handles.MplusMeasEdit4,'String',num2str(Mplus(4),'%.8f'))
    set(handles.MplusMeasEdit5,'String',num2str(Mplus(5),'%.8f'))
    fclose(fid);
end

% Choose default command line output for MplusMeasurement
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MplusMeasurement wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MplusMeasurement_OutputFcn(hObject, eventdata, handles)
% global Mp1 Mp2 Mp3 Mp4 Mp5;
% varargout = {Mp1, Mp2, Mp3, Mp4, Mp5};

global Mplus
varargout{1} = mean(Mplus);

% Get default command line output from handles structure
% varargout{1} = handles.output;
return;

function save_Callback(hObject, eventdata, handles)
global Mp1 Mp2 Mp3 Mp4 Mp5 Mplus;
Mp1 = str2double(get(handles.MplusMeasEdit1,'String'));
Mp2 = str2double(get(handles.MplusMeasEdit2,'String'));
Mp3 = str2double(get(handles.MplusMeasEdit3,'String'));
Mp4 = str2double(get(handles.MplusMeasEdit4,'String'));
Mp5 = str2double(get(handles.MplusMeasEdit5,'String'));
Mplus = [Mp1 Mp2 Mp3 Mp4 Mp5];
fid = fopen('Mplus_Data.txt','wt');
fprintf(fid,'%.15f\n',Mplus);
fclose(fid);

hMainGui = getappdata(0,'hMainGui');
UpdateMeanMplus = getappdata(hMainGui,'UpdateMeanMplus');

VdMplus = Mplus;
VdMplus(isnan(VdMplus)) = [];
MeanMplus = mean(VdMplus);
setappdata(hMainGui,'MeanMplus',MeanMplus);
feval(UpdateMeanMplus);




function MplusMeasEdit1_Callback(hObject, eventdata, handles)

function MplusMeasEdit2_Callback(hObject, eventdata, handles)

function MplusMeasEdit3_Callback(hObject, eventdata, handles)

function MplusMeasEdit4_Callback(hObject, eventdata, handles)

function MplusMeasEdit5_Callback(hObject, eventdata, handles)


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
delete(handles.figure1);