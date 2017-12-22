function varargout = ViewGraph(varargin)
%VIEWGRAPH M-file for ViewGraph.fig
%      VIEWGRAPH, by itself, creates a new VIEWGRAPH or raises the existing
%      singleton*.
%
%      H = VIEWGRAPH returns the handle to a new VIEWGRAPH or the handle to
%      the existing singleton*.
%
%      VIEWGRAPH('Property','Value',...) creates a new VIEWGRAPH using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to ViewGraph_OpeningFcn.  This calling syntax produces a
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

% Edit the above text to modify the response to help ViewGraph

% Last Modified by GUIDE v2.5 13-Dec-2017 04:47:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ViewGraph_OpeningFcn, ...
                   'gui_OutputFcn',  @ViewGraph_OutputFcn, ...
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


% --- Executes just before ViewGraph is made visible.
function ViewGraph_OpeningFcn(hObject, eventdata, handles, varargin)

hMainGui     =  getappdata(0,'hMainGui');

Ksfitresult  =  getappdata(hMainGui,'KsFitResult');
KsFitFunc    =  getappdata(hMainGui,'KsFitFunc');
Ksgof        =  getappdata(hMainGui,'Ksgof');
KsXdata      =  getappdata(hMainGui,'KsXdata');
KsYdata      =  getappdata(hMainGui,'KsYdata');
KsCI         =  getappdata(hMainGui,'KsCI');
KscovB       =  getappdata(hMainGui,'KscovB');

if isempty(Ksfitresult)
       fprintf('One of the input values are missing. Make sure no field in this section is left empty\n');
       setappdata(hMainGui,'ErrorText','ERROR: One of the input values are missing. Make sure no field in this section is left empty.');
       Error;
end
   
Coeff = flip(coeffvalues(Ksfitresult))';
CIB   = KsCI;

a0CIB    = ['(' num2str(CIB(1,1)) ','  num2str(CIB(2,1)) ')']; 
a1CIB    = ['(' num2str(CIB(1,2)) ','  num2str(CIB(2,2)) ')'];
resultsTab     = {num2str(Coeff(1)) , num2str(Coeff(2)) ; a0CIB , a1CIB}';

set(handles.CMTab,'Data',KscovB);
set(handles.resultsTab,'Data',resultsTab)
set(handles.RMSE,'String',num2str(Ksgof.rmse));
set(handles.SSE,'String',num2str(Ksgof.sse));
set(handles.Rsq,'String',num2str(Ksgof.rsquare));
set(handles.AdjRsq,'String',num2str(Ksgof.adjrsquare));

Yeval    = feval(KsFitFunc,KsXdata);
Residual = KsYdata-Yeval;

pltxData = feval(KsFitFunc,0:0.5:max(KsXdata));

axes(handles.plotAxes);
cla;
hold on
xlim([0 KsXdata(end)+1])
plot(KsXdata,KsYdata,'ro','MarkerFaceColor','r');
plot(0:0.5:max(KsXdata),pltxData,'b');
ylabel('M_{1} / M');
xlabel('(V_{1} / V) ^{2}')
hold off

axes(handles.ResAxes);
cla;
hold on
xlim([0 KsXdata(end)+1])
plot(KsXdata,Residual,'go','MarkerFaceColor','g');
plot(get(handles.ResAxes,'XLim'),[0 0],'k-');
xlabel('(V_{1} / V) ^{2}')
ylabel('Residuals');
hold off
        

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ViewGraph wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ViewGraph_OutputFcn(hObject, eventdata, handles)
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
