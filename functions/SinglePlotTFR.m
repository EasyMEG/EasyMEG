function varargout = SinglePlotTFR(varargin)
% SinglePlotTFR MATLAB code for SinglePlotTFR.fig
%      SinglePlotTFR, by itself, creates a new SinglePlotTFR or raises the existing
%      singleton*.
%
%      H = SinglePlotTFR returns the handle to a new SinglePlotTFR or the handle to
%      the existing singleton*.
%
%      SinglePlotTFR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SinglePlotTFR.M with the given input arguments.
%
%      SinglePlotTFR('Property','Value',...) creates a new SinglePlotTFR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SinglePlotTFR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SinglePlotTFR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SinglePlotTFR

% Last Modified by GUIDE v2.5 20-Mar-2017 15:27:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SinglePlotTFR_OpeningFcn, ...
                   'gui_OutputFcn',  @SinglePlotTFR_OutputFcn, ...
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


% --- Executes just before SinglePlotTFR is made visible.
function SinglePlotTFR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SinglePlotTFR (see VARARGIN)

% Choose default command line output for SinglePlotTFR
handles.output = hObject;
handles.cfg = [];
handles.data = [];

% Update handles structure
guidata(hObject, handles);

% Set listDataset and listData
global dataSet;
dataSetList = [];
for i=1:length(dataSet)
    dataSetList{i} = dataSet{i}.name;
end
set(handles.listDataset,'String',dataSetList);

data = dataSet{1};
dataList = fieldnames(data);
set(handles.listData,'String',dataList);

% UIWAIT makes SinglePlotTFR wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SinglePlotTFR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.cfg;
varargout{2} = handles.data;

delete(handles.figure1);


% --- Executes on selection change in listDataset.
function listDataset_Callback(hObject, eventdata, handles)
% hObject    handle to listDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listDataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listDataset
global dataSet;

idx = get(hObject,'Value');
data = dataSet{idx};

dataList = fieldnames(data);
set(handles.listData,'Value',1);
set(handles.listData,'String',dataList);



% --- Executes on button press in btnAdd.
function btnAdd_Callback(hObject, eventdata, handles)
% hObject    handle to btnAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% add selected data to plot list and pass the idx to handles.data

valPlotList = [];

datasetList = get(handles.listDataset,'String');
datasetSelect = get(handles.listDataset,'Value');
valPlotList{1} = datasetSelect;

strPlotList = get(handles.listData,'String');
strPlotList = strPlotList{get(handles.listData,'Value')};
valPlotList{2} = strPlotList;
temp = datasetList{datasetSelect};
strPlotList = [temp,'-->',strPlotList];

temp = get(handles.listPlot,'String');
if isequal(temp,'')
    temp = [];
    temp{1}=strPlotList;
else
    temp = [temp;strPlotList]
end

set(handles.listPlot,'String',temp);

temp2 = handles.data;
temp2 = [temp2;valPlotList];

handles.data = temp2;
guidata(hObject, handles);



% --- Executes on button press in btnRemove.
function btnRemove_Callback(hObject, eventdata, handles)
% hObject    handle to btnRemove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idx = get(handles.listPlot,'Value');
plotList = get(handles.listPlot,'String');
plotList(idx,:) = [];
set(handles.listPlot,'String',plotList);

data = handles.data;
data(idx,:) = [];
handles.data = data;

guidata(hObject,handles);



% --- Executes on button press in btnPlot.
function btnPlot_Callback(hObject, eventdata, handles)
% hObject    handle to btnPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cfg = [];

maskstyle        = get(handles.popMaskStyle,'String');
cfg.maskstyle    = maskstyle{get(handles.popMaskStyle,'Value')};
cfg.xlim         = eval(get(handles.editHlim,'String'));
cfg.ylim         = eval(get(handles.editVlim,'String'));
cfg.zlim         = eval(get(handles.editZlim,'String'));
cfg.fontsize     = eval(get(handles.editFontSize,'String'));
cfg.linewidth    = eval(get(handles.editLineWidth,'String'));
cfg.baseline     = eval(get(handles.editBaseline,'String'));
baselinetype     = get(handles.popBaselineType,'String');
cfg.baselinetype = baselinetype{get(handles.popBaselineType,'Value')};
colormap     = get(handles.popColormap,'String');
cfg.colormap = eval(colormap{get(handles.popColormap,'Value')});


switch get(handles.popParameter,'Value')
    case 1
    case 2
        cfg.parameter = 'powspctrm';
    case 3
        cfg.parameter = 'cohspctrm';
end

cfg.channel = eval(get(handles.editChannels,'String'));
cfg.trials   = eval(get(handles.editTrials,'String'));

handles.cfg = cfg;
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
