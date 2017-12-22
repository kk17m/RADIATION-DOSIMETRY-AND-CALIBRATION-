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
%      varargin to ISViewGraph_OpeningFcn.  This calling syntax produces a
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

% Last Modified by GUIDE v2.5 25-Dec-2012 01:35:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ISViewGraph_OpeningFcn, ...
                   'gui_OutputFcn',  @ISViewGraph_OutputFcn, ...
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
function ISViewGraph_OpeningFcn(hObject, eventdata, handles, varargin)

   
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ISViewGraph wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ISViewGraph_OutputFcn(hObject, eventdata, handles)
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


% --- Executes on selection change in ISpopmenue.
function ISpopmenue_Callback(hObject, eventdata, handles)
hMainGui     =  getappdata(0,'hMainGui');

SpectumEnergy                      = getappdata(hMainGui,'SpectumEnergy');
MeasuredSpectra                    = getappdata(hMainGui,'MeasuredSpectra');
IncidentSpectra                    = getappdata(hMainGui,'IncidentSpectra');
IncidentSpectraPerSr               = getappdata(hMainGui,'IncidentSpectraPerSr');
IncidentSpectraPerArea             = getappdata(hMainGui,'IncidentSpectraPerArea');
IncidentSpectraPerAreaPermAsPerKev = getappdata(hMainGui,'IncidentSpectraPerAreaPermAsPerKev');
NormEnergyFluence                  = getappdata(hMainGui,'NormEnergyFluence');
NormPhotonFluence                  = getappdata(hMainGui,'NormPhotonFluence');

if isempty(SpectumEnergy) || isempty(IncidentSpectra) || isempty(IncidentSpectraPerSr) || isempty(IncidentSpectraPerArea) || isempty(IncidentSpectraPerAreaPermAsPerKev)
       fprintf('No data available to plot. \n');
       setappdata(hMainGui,'ErrorText','ERROR: No data available to plot.');
       Error;
end
 
str = get(hObject,'String');
val = get(hObject,'Value');

setappdata(hMainGui,'ISVGselectionString',str{val});
setappdata(hMainGui,'ISVGselection',val);
 
switch val
    case 2
        axes(handles.ISplotAxes);
        cla;
        hold on
        xlim([0 SpectumEnergy(end)])
        plot(SpectumEnergy,IncidentSpectra,'r');
        plot(SpectumEnergy,MeasuredSpectra,'b');
        ylabel('#Photons');
        xlabel('Energy (eV)')
        set(gca, 'YLim', [0, inf]);
        grid on
        legend('Approximated Incident Spectra','Measured Spectra')
        hold off
    case 3
        axes(handles.ISplotAxes);
        cla;
        hold on
        xlim([0 SpectumEnergy(end)])
        plot(SpectumEnergy,IncidentSpectraPerSr);
        ylabel('#Photons / Steradian');
        xlabel('Energy (eV)')
        set(gca, 'YLim', [0, inf]);
        grid on
        legend(handles.ISplotAxes,'hide')
        hold off
    case 4 
        axes(handles.ISplotAxes);
        cla;
        hold on
        xlim([0 SpectumEnergy(end)])
        plot(SpectumEnergy,IncidentSpectraPerArea);
        ylabel('#Photons / mm^2');
        xlabel('Energy (eV)')
        set(gca, 'YLim', [0, inf]);
        grid on
        legend(handles.ISplotAxes,'hide')
        hold off
    case 5 
        axes(handles.ISplotAxes);
        cla;
        hold on
        xlim([0 SpectumEnergy(end)])
        plot(SpectumEnergy,IncidentSpectraPerAreaPermAsPerKev);
        ylabel('#Photons / (mm^2 * mAs * keV)');
        xlabel('Energy (eV)')
        set(gca, 'YLim', [0, inf]);
        grid on
        legend(handles.ISplotAxes,'hide')
        hold off
    case 6
        axes(handles.ISplotAxes);
        cla;
        hold on
        xlim([0 SpectumEnergy(end)])
        plot(SpectumEnergy,NormPhotonFluence,'r');
        plot(SpectumEnergy,NormEnergyFluence,'b');
        set(gca, 'YLim', [0, inf]);
        ylabel('Fluence (arbitrary units)');
        xlabel('Energy (eV)')
        grid on
        legend('Photon fluence spectrum','Energy fluence spectrum')
        hold off
end

        
