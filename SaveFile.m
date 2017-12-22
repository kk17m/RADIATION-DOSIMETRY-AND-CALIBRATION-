function varargout = SaveFile(varargin)
% SAVEFILE MATLAB code for SaveFile.fig
%      SAVEFILE, by itself, creates a new SAVEFILE or raises the existing
%      singleton*.
%
%      H = SAVEFILE returns the handle to a new SAVEFILE or the handle to
%      the existing singleton*.
%
%      SAVEFILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAVEFILE.M with the given input arguments.
%
%      SAVEFILE('Property','Value',...) creates a new SAVEFILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SaveFile_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SaveFile_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SaveFile

% Last Modified by GUIDE v2.5 16-Dec-2017 23:54:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @SaveFile_OpeningFcn, ...
    'gui_OutputFcn',  @SaveFile_OutputFcn, ...
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


% --- Executes just before SaveFile is made visible.
function SaveFile_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SaveFile (see VARARGIN)

% Choose default command line output for SaveFile
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SaveFile wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SaveFile_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
hMainGui = getappdata(0,'hMainGui');

selection      =  getappdata(hMainGui,'selection');

switch selection
    
    case 2
        [file, path] = uiputfile('CalibrationData1.csv');
        filePath=fullfile(path,file);
        fid = fopen('Calibration_Data.csv','r');
        if fid~=-1 && path~=0 
            rdtbl = readtable('Calibration_Data.csv');
            writetable(rdtbl,filePath);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 3
        [file, path] = uiputfile('Mplus_Data.txt');
        filePath=fullfile(path,file);
        spf=fopen(filePath,'wt');
        fid = fopen('Mplus_Data.txt','r');
        if fid~=-1 && path~=0
            format long g
            CalibData =  fscanf(fid,'%f');
            fprintf(spf,CalibData);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 4
        [file, path] = uiputfile('Mminus_Data.txt');
        filePath=fullfile(path,file);
        spf=fopen(filePath,'wt');
        fid = fopen('Mminus_Data.txt','r');
        if fid~=-1 && path~=0
            format long g
            CalibData =  fscanf(fid,'%f');
            fprintf(spf,CalibData);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 5
        [file, path] = uiputfile('Temp_Data.txt');
        filePath=fullfile(path,file);
        spf=fopen(filePath,'wt');
        fid = fopen('Temp_Data.txt','r');
        if fid~=-1 && path~=0
            format long g
            CalibData =  fscanf(fid,'%f');
            fprintf(spf,CalibData);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 6
        [file, path] = uiputfile('Pressure_Data.txt');
        filePath=fullfile(path,file);
        spf=fopen(filePath,'wt');
        fid = fopen('Pressure_Data.txt','r');
        if fid~=-1 && path~=0
            format long g
            CalibData =  fscanf(fid,'%f');
            fprintf(spf,CalibData);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 7 
        [file, path] = uiputfile('ValueSet1_Data.txt');
        filePath=fullfile(path,file);
        spf=fopen(filePath,'wt');
        fid = fopen('Mplus_Data.txt','r');
        if fid~=-1 && path~=0
            format long g
            CalibData =  fscanf(fid,'%f');
            fprintf(spf,CalibData);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 8
        [file, path] = uiputfile('ValueSet2_Data.txt');
        filePath=fullfile(path,file);
        spf=fopen(filePath,'wt');
        fid = fopen('ValueSet2_Data.txt','r');
        if fid~=-1 && path~=0
            format long g
            CalibData =  fscanf(fid,'%f');
            fprintf(spf,CalibData);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 9 
        [file, path] = uiputfile('ValueSet3_Data.txt');
        filePath=fullfile(path,file);
        spf=fopen(filePath,'wt');
        fid = fopen('ValueSet3_Data.txt','r');
        if fid~=-1 && path~=0
            format long g
            CalibData =  fscanf(fid,'%f');
            fprintf(spf,CalibData);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 10
        [file, path] = uiputfile('ValueSet4_Data.txt');
        filePath=fullfile(path,file);
        spf=fopen(filePath,'wt');
        fid = fopen('ValueSet4_Data.txt','r');
        if fid~=-1 && path~=0
            format long g
            CalibData =  fscanf(fid,'%f');
            fprintf(spf,CalibData);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 11
        [file, path] = uiputfile('BeamQual_Data.txt');
        filePath=fullfile(path,file);
        spf=fopen(filePath,'wt');
        fid = fopen('Mplus_Data.txt','r');
        if fid~=-1 && path~=0
            format long g
            CalibData =  fscanf(fid,'%f');
            fprintf(spf,CalibData);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
    case 12
        [file, path] = uiputfile('DetRespData_Data.txt');
        filePath=fullfile(path,file);
        spf=fopen(filePath,'wt');
        fid = fopen('DetRespData_Data.txt','r');
        if fid~=-1 && path~=0
            format long g
            CalibData =  fscanf(fid,'%f');
            fprintf(spf,CalibData);
        end
        if fid ==-1
            setappdata(hMainGui,'ErrorText','ERROR: No such data available to be saved!!');
            Error;
        end
        fclose('all');
        
end
%delete(handles.figure1)

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
str = get(hObject, 'String');
val = get(hObject,'Value');

hMainGui         =  getappdata(0,'hMainGui');
setappdata(hMainGui,'selection',val);
