function varargout = MminusMeasurement(varargin)
% MMINUSMEASUREMENT MATLAB code for MminusMeasurement.fig
%      MMINUSMEASUREMENT, by itself, creates a new MMINUSMEASUREMENT or raises the existing
%      singleton*.
%
%      H = MMINUSMEASUREMENT returns the handle to a new MMINUSMEASUREMENT or the handle to
%      the existing singleton*.
%
%      MMINUSMEASUREMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MMINUSMEASUREMENT.M with the given input arguments.
%
%      MMINUSMEASUREMENT('Property','Value',...) creates a new MMINUSMEASUREMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MminusMeasurement_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MminusMeasurement_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MminusMeasurement

% Last Modified by GUIDE v2.5 10-Dec-2017 19:46:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MminusMeasurement_OpeningFcn, ...
    'gui_OutputFcn',  @MminusMeasurement_OutputFcn, ...
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


% --- Executes just before MminusMeasurement is made visible.
function MminusMeasurement_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.

fid = fopen('Mminus_Data.txt','r');
if fid~=-1 %if the file doesn't exist ignore the reading code
    format long g
    Mminus =  fscanf(fid,'%f');
    set(handles.MminusMeasEdit1,'String',num2str(Mminus(1),'%.8f'))
    set(handles.MminusMeasEdit2,'String',num2str(Mminus(2),'%.8f'))
    set(handles.MminusMeasEdit3,'String',num2str(Mminus(3),'%.8f'))
    set(handles.MminusMeasEdit4,'String',num2str(Mminus(4),'%.8f'))
    set(handles.MminusMeasEdit5,'String',num2str(Mminus(5),'%.8f'))
    fclose(fid);
end


% Choose default command line output for MminusMeasurement
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MminusMeasurement wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MminusMeasurement_OutputFcn(hObject, eventdata, handles)
% global Mm1 Mm2 Mm3 Mm4 Mm5;
% varargout = {Mm1, Mm2, Mm3, Mm4, Mm5};

global Mminus
varargout{1} = mean(Mminus);

% Get default command line output from handles structure
% varargout{1} = handles.output;
return;

function save_Callback(hObject, eventdata, handles)

global Mm1 Mm2 Mm3 Mm4 Mm5 Mminus;
Mm1 = str2double(get(handles.MminusMeasEdit1,'String'));
Mm2 = str2double(get(handles.MminusMeasEdit2,'String'));
Mm3 = str2double(get(handles.MminusMeasEdit3,'String'));
Mm4 = str2double(get(handles.MminusMeasEdit4,'String'));
Mm5 = str2double(get(handles.MminusMeasEdit5,'String'));
Mminus = [Mm1 Mm2 Mm3 Mm4 Mm5];
fid = fopen('Mminus_Data.txt','wt');
fprintf(fid,'%.15f\n',Mminus);
fclose(fid);

hMainGui = getappdata(0,'hMainGui');
UpdateMeanMminus = getappdata(hMainGui,'UpdateMeanMminus');

VdMminus = Mminus;
VdMminus(isnan(VdMminus)) = [];
MeanMminus = mean(VdMminus);
setappdata(hMainGui,'MeanMminus',MeanMminus);
feval(UpdateMeanMminus);




function MminusMeasEdit1_Callback(hObject, eventdata, handles)

function MminusMeasEdit2_Callback(hObject, eventdata, handles)

function MminusMeasEdit3_Callback(hObject, eventdata, handles)

function MminusMeasEdit4_Callback(hObject, eventdata, handles)

function MminusMeasEdit5_Callback(hObject, eventdata, handles)


% --- Executes on button press in delete.
function delete_Callback(hObject, eventdata, handles)
delete(handles.figure1)
