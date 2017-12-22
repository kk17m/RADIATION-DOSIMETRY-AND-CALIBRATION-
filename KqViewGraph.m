function varargout = ISViewGraph(varargin)
%VIEWGRAPH M-file for ISViewGraph.fig
%      VIEWGRAPH, by itself, creates a new VIEWGRAPH or raises the existing
%      singleton*.
%
%      H = VIEWGRAPH returns the handle to a new VIEWGRAPH or the handle to
%      the existing singleton*.
%
%      VIEWGRAPH('Property','Value',...) creates a new VIEWGRAPH using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to KqViewGraph_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      VIEWGRAPH('CALLBACK') and VIEWGRAPH('CALLBACK',hObject,...) call the
%      local function named CALLBACK in VIEWGRAPH.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ISViewGraph

% Last Modified by GUIDE v2.5 14-Dec-2017 03:38:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KqViewGraph_OpeningFcn, ...
                   'gui_OutputFcn',  @KqViewGraph_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before ISViewGraph is made visible.
function KqViewGraph_OpeningFcn(hObject, eventdata, handles, varargin)

hMainGui     =  getappdata(0,'hMainGui');

BeamQualData  = getappdata(hMainGui,'BeamQualData');

if isempty(BeamQualData)
       fprintf('Beam quality data missing. Please enter the data in order to carryout the calculations. \n');
       setappdata(hMainGui,'ErrorText','ERROR: Beam quality data missing. Please enter the data in order to carryout the calculations.');
       delete(handles.figure1)
       Error;
end
 
 BeamQualxData = BeamQualData(1:ceil(end/2));
 BeamQualyData = BeamQualData((ceil(end/2)+1):end);
 
 
axes(handles.KqplotAxes);
cla;
hold on
plot(BeamQualxData,BeamQualyData,'ro','MarkerFaceColor','r');
plot(0:BeamQualxData(end), pchip(BeamQualxData,BeamQualyData, 0:BeamQualxData(end)),'b')
ylabel('K_{Q}');
xlabel('HVL (mm Al)')
grid on
set(gca, 'xscale', 'log');
Ylb   = get(gca,'YLabel');
ylPos = get(Ylb, 'Position');
set(get(gca,'YLabel'),'Rotation',0,'position',ylPos + [-0.1 0 0])
legend('Calibration Points','Polynomial')
hold off

      

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ISViewGraph wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = KqViewGraph_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function uipushtool_New_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool_New (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipushtool_Open_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool_Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipushtool_Save_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool_Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
