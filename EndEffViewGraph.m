function varargout = EndEffViewGraph(varargin)
%VIEWGRAPH M-file for EndEffViewGraph.fig
%      VIEWGRAPH, by itself, creates a new VIEWGRAPH or raises the existing
%      singleton*.
%
%      H = VIEWGRAPH returns the handle to a new VIEWGRAPH or the handle to
%      the existing singleton*.
%
%      VIEWGRAPH('Property','Value',...) creates a new VIEWGRAPH using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to EndEffViewGraph_OpeningFcn.  This calling syntax produces a
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

% Edit the above text to modify the response to help EndEffViewGraph

% Last Modified by GUIDE v2.5 13-Dec-2017 04:47:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EndEffViewGraph_OpeningFcn, ...
                   'gui_OutputFcn',  @EndEffViewGraph_OutputFcn, ...
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


% --- Executes just before EndEffViewGraph is made visible.
function EndEffViewGraph_OpeningFcn(hObject, eventdata, handles, varargin)

hMainGui     =  getappdata(0,'hMainGui');

EndEfffitresult  =  getappdata(hMainGui,'EndEffFitResult');
EndEffFitFunc    =  getappdata(hMainGui,'EndEffFitFunc');
EndEffgof        =  getappdata(hMainGui,'EndEffgof');
EndEffXdata      =  getappdata(hMainGui,'EndEffXdata');
EndEffYdata      =  getappdata(hMainGui,'EndEffYdata');
EndEffCI         =  getappdata(hMainGui,'EndEffCI');
EndEffcovB       =  getappdata(hMainGui,'EndEffcovB');

if isempty(EndEfffitresult)
       fprintf('Detector response data is missing. Make sure no field in this section is left empty\n');
       setappdata(hMainGui,'ErrorText','ERROR: Detector response data is missing. Make sure no field in this section is left empty.');
       Error;
end

Coeff = flip(coeffvalues(EndEfffitresult))';
CIB   = EndEffCI;

a0CIB    = ['(' num2str(CIB(1,1)) ','  num2str(CIB(2,1)) ')']; 
a1CIB    = ['(' num2str(CIB(1,2)) ','  num2str(CIB(2,2)) ')'];
resultsTab     = {num2str(Coeff(1)) , num2str(Coeff(2)) ; a0CIB , a1CIB}';

set(handles.CMTab,'Data',EndEffcovB);
set(handles.resultsTab,'Data',resultsTab)
set(handles.RMSE,'String',num2str(EndEffgof.rmse));
set(handles.SSE,'String',num2str(EndEffgof.sse));
set(handles.Rsq,'String',num2str(EndEffgof.rsquare));
set(handles.AdjRsq,'String',num2str(EndEffgof.adjrsquare));

Yeval    = feval(EndEffFitFunc,EndEffXdata);
Residual = EndEffYdata-Yeval;

pltxData = feval(EndEffFitFunc,[0 max(EndEffXdata)]);

axes(handles.plotAxes);
cla;
hold on
xlim([0 EndEffXdata(end)+1])
plot(EndEffXdata,EndEffYdata,'ro','MarkerFaceColor','r');
plot([0 max(EndEffXdata)],pltxData,'b');
ylabel('Response ( Air Kerma / Gy )');
xlabel(' Time / sec ')
hold off

axes(handles.ResAxes);
cla;
hold on
xlim([0 EndEffXdata(end)+1])
plot(EndEffXdata,Residual,'go','MarkerFaceColor','g');
plot(get(handles.ResAxes,'XLim'),[0 0],'k-');
xlabel('Time / sec')
ylabel('Residuals');
hold off
        

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EndEffViewGraph wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EndEffViewGraph_OutputFcn(hObject, eventdata, handles)
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
