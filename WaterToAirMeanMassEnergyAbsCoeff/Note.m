function varargout = Error(varargin)
% ERROR MATLAB code for Error.fig
%      ERROR, by itself, creates a new ERROR or raises the existing
%      singleton*.
%
%      H = ERROR returns the handle to a new ERROR or the handle to
%      the existing singleton*.
%
%      ERROR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ERROR.M with the given input arguments.
%
%      ERROR('Property','Value',...) creates a new ERROR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Error_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Error_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Error

% Last Modified by GUIDE v2.5 16-Dec-2017 05:43:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Error_OpeningFcn, ...
                   'gui_OutputFcn',  @Error_OutputFcn, ...
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


% --- Executes just before Error is made visible.
function Error_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Error (see VARARGIN)
hMainGui = getappdata(0,'hMainGui');

ErrorText = getappdata(hMainGui,'ErrorText');
set(handles.ErrorText,'String',ErrorText)


% Choose default command line output for Error
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Error wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Error_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function continue_Callback(hObject, eventdata, handles)
delete(handles.figure1)