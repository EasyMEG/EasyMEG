function varargout = SourcePlot(varargin)
% SOURCEPLOT MATLAB code for SourcePlot.fig
%      SOURCEPLOT, by itself, creates a new SOURCEPLOT or raises the existing
%      singleton*.
%
%      H = SOURCEPLOT returns the handle to a new SOURCEPLOT or the handle to
%      the existing singleton*.
%
%      SOURCEPLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOURCEPLOT.M with the given input arguments.
%
%      SOURCEPLOT('Property','Value',...) creates a new SOURCEPLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SourcePlot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SourcePlot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SourcePlot

% Last Modified by GUIDE v2.5 27-Feb-2017 11:35:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SourcePlot_OpeningFcn, ...
                   'gui_OutputFcn',  @SourcePlot_OutputFcn, ...
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


% --- Executes just before SourcePlot is made visible.
function SourcePlot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SourcePlot (see VARARGIN)

% Choose default command line output for SourcePlot
handles.output = hObject;
handles.cfgSourcePlot = [];
handles.cfgSourceInt  = [];
handles.idxDataPlot   = [];
handles.dataNamePlot  = [];
handles.idxDataInt    = [];
handles.dataNameInt   = [];

% Update handles structure
guidata(hObject, handles);

% Set popDataset and popData
global dataSet;
dataSetList = [];
for i=1:length(dataSet)
    dataSetList{i} = dataSet{i}.name;
end
set(handles.popDataset,'String',dataSetList);
set(handles.popIntDataset,'String',dataSetList);

data = dataSet{1};
dataList = fieldnames(data);
set(handles.popData,'String',dataList);
set(handles.popIntData,'String',dataList);

% UIWAIT makes SourcePlot wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SourcePlot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.cfgSourcePlot;
varargout{2} = handles.cfgSourceInt;
varargout{3} = handles.idxDataPlot;
varargout{4} = handles.dataNamePlot;
varargout{5} = handles.idxDataInt;
varargout{6} = handles.dataNameInt;

delete(handles.figure1);


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



% --- Executes on button press in btnAtlas.
function btnAtlas_Callback(hObject, eventdata, handles)
% hObject    handle to btnAtlas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname]  = uigetfile('*.*', 'Pick atlas file.');
dataDir = fullfile(pathname, filename);
set(handles.editAtlas,'String',dataDir);


% --- Executes on button press in btnOk.
function btnOk_Callback(hObject, eventdata, handles)
% hObject    handle to btnOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cfgSourceInt = [];
method            = {'nearest', 'linear', 'cubic',  'spline', 'sphere_avg' , 'smudge'};
cfgSourceInt.method        = method{get(handles.popIntMethod,'Value')};
if ~isempty(get(handles.editIntParameter,'String'))
    cfgSourceInt.parameter  = eval(get(handles.editIntParameter,'String'));
end

if ~isempty(get(handles.editIntDownsample,'String'))
    cfgSourceInt.downsample  = eval(get(handles.editIntDownsample,'String'));
end

handles.cfgSourceInt      = cfgSourceInt;
handles.idxDataInt      = get(handles.popIntDataset,'Value');
dataNameInt         = get(handles.popIntData,'String');
handles.dataNameInt = dataNameInt{get(handles.popIntData,'Value')};


cfgSourcePlot = [];

method            = {'slice','ortho','surface','glassbrain','vertex'};
cfgSourcePlot.method        = method{get(handles.popMethod,'Value')};

if ~isempty(get(handles.editFunparameter,'String'))
    cfgSourcePlot.funparameter  = eval(get(handles.editFunparameter,'String'));
end
if ~isempty(get(handles.editAnaparameter,'String'))
    cfgSourcePlot.anaparameter  = eval(get(handles.editAnaparameter,'String'));
end
if ~isempty(get(handles.editMaskparameter,'String'))
    cfgSourcePlot.maskparameter  = eval(get(handles.editMaskparameter,'String'));
end

if ~isempty(get(handles.editAtlas,'String'))
    cfgSourcePlot.atlas  = eval(get(handles.editAtlas,'String'));
end

if ~isempty(get(handles.editDownsample,'String'))
    cfgSourcePlot.downsample = eval(get(handles.editDownsample,'String'));
end

if ~isempty(get(handles.editFuncolormap,'String'))
    cfgSourcePlot.funcolormap = eval(get(handles.editFuncolormap,'String'));
end

if ~isempty(get(handles.editFuncolorlim,'String'))
    cfgSourcePlot.funcolorlim = eval(get(handles.editFuncolorlim,'String'));
end

if ~isempty(get(handles.editOpacitymap,'String'))
    cfgSourcePlot.opacitymap = eval(get(handles.editOpacitymap,'String'));
end

if ~isempty(get(handles.editOpacitylim,'String'))
    cfgSourcePlot.opacitylim = eval(get(handles.editOpacitylim,'String'));
end

if ~isempty(get(handles.editROI,'String'))
    cfgSourcePlot.roi = eval(get(handles.editROI,'String'));
end

colobar            = {'yes','no'};
cfgSourcePlot.colobar        = colobar{get(handles.popColorbar,'Value')};


handles.cfgSourcePlot      = cfgSourcePlot;
handles.idxDataPlot      = get(handles.popDataset,'Value');
dataNamePlot         = get(handles.popData,'String');
handles.dataNamePlot = dataNamePlot{get(handles.popData,'Value')};

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


% --- Executes on selection change in popIntDataset.
function popIntDataset_Callback(hObject, eventdata, handles)
% hObject    handle to popIntDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popIntDataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popIntDataset
global dataSet;

idx = get(hObject,'Value');
data = dataSet{idx};

dataList = fieldnames(data);
set(handles.popIntData,'Value',1);
set(handles.popIntData,'String',dataList);
