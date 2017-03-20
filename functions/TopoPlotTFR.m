function varargout = TopoPlotTFR(varargin)
% TopoPlotTFR MATLAB code for TopoPlotTFR.fig
%      TopoPlotTFR, by itself, creates a new TopoPlotTFR or raises the existing
%      singleton*.
%
%      H = TopoPlotTFR returns the handle to a new TopoPlotTFR or the handle to
%      the existing singleton*.
%
%      TopoPlotTFR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TopoPlotTFR.M with the given input arguments.
%
%      TopoPlotTFR('Property','Value',...) creates a new TopoPlotTFR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TopoPlotTFR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TopoPlotTFR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TopoPlotTFR

% Last Modified by GUIDE v2.5 20-Mar-2017 16:04:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TopoPlotTFR_OpeningFcn, ...
                   'gui_OutputFcn',  @TopoPlotTFR_OutputFcn, ...
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


% --- Executes just before TopoPlotTFR is made visible.
function TopoPlotTFR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TopoPlotTFR (see VARARGIN)

% Choose default command line output for TopoPlotTFR
handles.output   = hObject;
handles.cfg      = [];
handles.idx      = [];
handles.dataName = [];

% Update handles structure
guidata(hObject, handles);

% Set popDataset and popData
global dataSet;
dataSetList = [];
for i=1:length(dataSet)
    dataSetList{i} = dataSet{i}.name;
end
set(handles.popDataset,'String',dataSetList);

data = dataSet{1};
dataList = fieldnames(data);
set(handles.popData,'String',dataList);

% UIWAIT makes TopoPlotTFR wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TopoPlotTFR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.cfg;
varargout{2} = handles.idx;
varargout{3} = handles.dataName;

delete(handles.figure1);


% --- Executes on button press in btnPlot.
function btnPlot_Callback(hObject, eventdata, handles)
% hObject    handle to btnPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cfg = [];
layout                = get(handles.popLayout,'String');
cfg.layout            = layout{get(handles.popLayout,'Value')};
cfg.xlim              = eval(get(handles.editXlim,'String'));
cfg.ylim              = eval(get(handles.editYlim,'String'));
cfg.zlim              = eval(get(handles.editZlim,'String'));
cfg.fontsize          = eval(get(handles.editFontSize,'String'));
cfg.linewidth         = eval(get(handles.editLineWidth,'String'));
cfg.baseline          = eval(get(handles.editBaseline,'String'));
baselinetype          = get(handles.popBaselineType,'String');
cfg.baselinetype      = baselinetype{get(handles.popBaselineType,'Value')};
colormap              = get(handles.popColorMap,'String');
cfg.colormap          = eval(colormap{get(handles.popColorMap,'Value')});
marker                = get(handles.popMarker,'String');
cfg.marker            = marker{get(handles.popMarker,'Value')};
cfg.markersymbol      = eval(get(handles.editMarkerSymbol,'String'));
cfg.markercolor       = get(handles.btnMarkerColor,'BackgroundColor');
cfg.markersize        = eval(get(handles.editMarkerSize,'String'));
cfg.markerfontsize    = eval(get(handles.editMarkerFontSize,'String'));
highlight             = get(handles.popHighlight,'String');
cfg.highlight         = highlight{get(handles.popHighlight,'Value')};
cfg.highlightsymbol   = eval(get(handles.editHighlightSymbol,'String'));
cfg.highlightcolor    = get(handles.btnHighlightColor,'BackgroundColor');
cfg.highlightsize     = eval(get(handles.editHighlightSize,'String'));
cfg.highlightfontsize = eval(get(handles.editHighlightFontSize,'String'));
interplimits          = get(handles.popInterplimits,'String');
cfg.interplimits      = interplimits{get(handles.popInterplimits,'Value')};
interpolation         = get(handles.popInterpolation,'String');
cfg.interpolation     = interpolation{get(handles.popInterpolation,'Value')};
cfg.girdscale         = eval(get(handles.editGirdScale,'String'));
shading               = get(handles.popShading,'String');
cfg.shading           = shading{get(handles.popShading,'Value')};

if ~isempty(get(handles.editHighlightChannel,'String'))
    cfg.highlightchannel  = eval(get(handles.editHighlightChannel,'String'));
end

colorbar              = {'yes','no','North','South','East','West','NorthOutside','SouthOutside','EastOutside','WestOutside'};
cfg.colorbar          = colorbar{get(handles.popColorbar,'Value')};
style                 = {'straight','contour','both','fill','blank'};
cfg.style             = style{get(handles.popStyle,'Value')};

switch get(handles.popParameter,'Value')
    case 1
    case 2
        cfg.parameter = 'avg';
    case 3
        cfg.parameter = 'powspctrm';
    case 4
        cfg.parameter = 'cohspctrm';
end

cfg.channel  = eval(get(handles.editChannels,'String'));
cfg.trials   = eval(get(handles.editTrials,'String'));

handles.cfg      = cfg;
handles.idx      = get(handles.popDataset,'Value');
dataName         = get(handles.popData,'String');
handles.dataName = dataName{get(handles.popData,'Value')};

guidata(hObject, handles);
uiresume(handles.figure1);

% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.figure1);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(get(hObject, 'waitstatus'), 'waiting')
% The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
% The GUI is no longer waiting, just close it
    delete(hObject);
end



% --- Executes on button press in btnMarkerColor.
function btnMarkerColor_Callback(hObject, eventdata, handles)
% hObject    handle to btnMarkerColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c = uisetcolor;
set(hObject,'BackgroundColor',c)




% --- Executes on selection change in popDataset.
function popDataset_Callback(hObject, eventdata, handles)
% hObject    handle to popDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popDataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popDataset
global dataSet;

idx = get(hObject,'Value');
data = dataSet{idx};

dataList = fieldnames(data);
set(handles.popData,'Value',1);
set(handles.popData,'String',dataList);
