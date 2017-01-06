function varargout = SourceAnalysis(varargin)
% SOURCEANALYSIS MATLAB code for SourceAnalysis.fig
%      SOURCEANALYSIS, by itself, creates a new SOURCEANALYSIS or raises the existing
%      singleton*.
%
%      H = SOURCEANALYSIS returns the handle to a new SOURCEANALYSIS or the handle to
%      the existing singleton*.
%
%      SOURCEANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOURCEANALYSIS.M with the given input arguments.
%
%      SOURCEANALYSIS('Property','Value',...) creates a new SOURCEANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SourceAnalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SourceAnalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SourceAnalysis

% Last Modified by GUIDE v2.5 06-Jan-2017 11:00:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SourceAnalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @SourceAnalysis_OutputFcn, ...
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


% --- Executes just before SourceAnalysis is made visible.
function SourceAnalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SourceAnalysis (see VARARGIN)

% Choose default command line output for SourceAnalysis
handles.output = hObject;
handles.cfg    = [];
handles.conA   = [];
handles.conB   = [];
handles.whole  = [];
handles.mri    = [];

% Update handles structure
guidata(hObject, handles);

% Set listDataset and listData
global dataSet;
dataSetList = [];
for i=1:length(dataSet)
    dataSetList{i} = dataSet{i}.name;
end
set(handles.popMriDataset,'String',dataSetList);
set(handles.popHeadmodelDataset,'String',dataSetList);
set(handles.popSourcemodelDataset,'String',dataSetList);
set(handles.popLeadfieldDataset,'String',dataSetList);
set(handles.popConADataset,'String',dataSetList);
set(handles.popConBDataset,'String',dataSetList);
set(handles.popWholeDataset,'String',dataSetList);

data = dataSet{1};
dataList = fieldnames(data);

set(handles.popMriData,'String',dataList);
set(handles.popHeadmodelData,'String',dataList);
set(handles.popSourcemodelData,'String',dataList);
set(handles.popLeadfieldData,'String',dataList);
set(handles.popConAData,'String',dataList);
set(handles.popConBData,'String',dataList);
set(handles.popWholeData,'String',dataList);


% UIWAIT makes SourceAnalysis wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SourceAnalysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.cfg;
varargout{2} = handles.conA;
varargout{3} = handles.conB;
varargout{4} = handles.whole;
varargout{5} = handles.mri;

delete(handles.figure1);



% --- Executes on selection change in popSourcemodelDataset.
function popSourcemodelDataset_Callback(hObject, eventdata, handles)
% hObject    handle to popSourcemodelDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popSourcemodelDataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popSourcemodelDataset
global dataSet;

idx = get(hObject,'Value');
data = dataSet{idx};

dataList = fieldnames(data);

set(handles.popSourcemodelData,'String',dataList);

% --- Executes on selection change in popMriDataset.
function popMriDataset_Callback(hObject, eventdata, handles)
% hObject    handle to popMriDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popMriDataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popMriDataset
global dataSet;

idx = get(hObject,'Value');
data = dataSet{idx};

dataList = fieldnames(data);

set(handles.popMriData,'String',dataList);

% --- Executes on selection change in popHeadmodelDataset.
function popHeadmodelDataset_Callback(hObject, eventdata, handles)
% hObject    handle to popHeadmodelDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popHeadmodelDataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popHeadmodelDataset
global dataSet;

idx = get(hObject,'Value');
data = dataSet{idx};

dataList = fieldnames(data);

set(handles.popHeadmodelData,'String',dataList);

% --- Executes on selection change in popLeadfieldDataset.
function popLeadfieldDataset_Callback(hObject, eventdata, handles)
% hObject    handle to popLeadfieldDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popLeadfieldDataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popLeadfieldDataset
global dataSet;

idx = get(hObject,'Value');
data = dataSet{idx};

dataList = fieldnames(data);

set(handles.popLeadfieldData,'String',dataList);

% --- Executes on button press in btnOK.
function btnOK_Callback(hObject, eventdata, handles)
% hObject    handle to btnOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;

cfg = [];

MriDataset = get(handles.popMriDataset,'Value');
MriData    = get(handles.popMriData,'String');
MriData    = MriData{get(handles.popMriData,'Value')};
mri = eval(['dataSet{MriDataset}.',MriData]);

HeadmodelDataset = get(handles.popHeadmodelDataset,'Value');
HeadmodelData    = get(handles.popHeadmodelData,'String');
HeadmodelData    = HeadmodelData{get(handles.popHeadmodelData,'Value')};
cfg.headmodel = eval(['dataSet{HeadmodelDataset}.',HeadmodelData]);

SourcemodelDataset = get(handles.popSourcemodelDataset,'Value');
SourcemodelData    = get(handles.popSourcemodelData,'String');
SourcemodelData    = SourcemodelData{get(handles.popSourcemodelData,'Value')};
cfg.grid = eval(['dataSet{SourcemodelDataset}.',SourcemodelData]);

if get(handles.checkboxLeadfield,'Value')
    LeadfieldDataset = get(handles.popLeadfieldDataset,'Value');
    LeadfieldData    = get(handles.popLeadfieldData,'String');
    LeadfieldData    = LeadfieldData{get(handles.popLeadfieldData,'Value')};
    cfg.grid.leadfield = eval(['dataSet{LeadfieldDataset}.',LeadfieldData]);
end

conADataset = get(handles.popConADataset,'Value');
conAData    = get(handles.popConAData,'String');
conAData    = conAData{get(handles.popConAData,'Value')};
conA = eval(['dataSet{conADataset}.',conAData]);

conBDataset = get(handles.popConBDataset,'Value');
conBData    = get(handles.popConBData,'String');
conBData    = conBData{get(handles.popConBData,'Value')};
conB = eval(['dataSet{conBDataset}.',conBData]);

wholeDataset = get(handles.popWholeDataset,'Value');
wholeData    = get(handles.popWholeData,'String');
wholeData    = wholeData{get(handles.popWholeData,'Value')};
whole = eval(['dataSet{wholeDataset}.',wholeData]);

method = {'lcmv','sam','dics','pcc','mne','rv','music','sloreta','eloreta'};
cfg.method = method{get(handles.popMethod,'Value')}; 
cfg.channel      = eval(get(handles.editChannel,'String'));
cfg.frequency    = eval(get(handles.editFrequency,'String'));

jackknife = {'no','yes'};
cfg.jackknife = jackknife{get(handles.popJackKnife,'Value')};

rawtrial = {'no','yes'};
cfg.rawtrial = rawtrial{get(handles.popRawTrial,'Value')};

bootstrap = {'no','yes'};
cfg.bootstrap = bootstrap{get(handles.popBootstrap,'Value')};

numboots = {'no','yes'};
cfg.numboots = numboots{get(handles.popNumboots,'Value')};

permutation = {'no','yes'};
cfg.permutation = permutation{get(handles.popPermutation,'Value')};

randomization = {'no','yes'};
cfg.randomization = randomization{get(handles.popRandomization,'Value')};

cfg.numrandomization = eval{get(handles.editNumrandomization,'String')};

pseudovalue = {'no','yes'};
cfg.pseudovalue = pseudovalue{get(handles.popPseudovalue,'Value')};

cfg.numpermutation = eval{get(handles.editNumpermutation,'String')};

normalize = {'no','yes'};
cfg.normalize = normalize{get(handles.popNormalize,'Value')};

cfg.reduce = eval{get(handles.editReduce,'String')};

if ~isempty(get(handles.editLatency,'String'))
    cfg.latency = eval{get(handles.editLatency,'String')};
end

if ~isempty(get(handles.editLambda,'String'))
    cfg.lambda = eval{get(handles.editlambda,'String')};
end

if ~isempty(get(handles.editRefchan,'String'))
    cfg.refchan = eval{get(handles.editRefchan,'String')};
end

if ~isempty(get(handles.editRefdip,'String'))
    cfg.refdip = eval{get(handles.editRefdip,'String')};
end

if ~isempty(get(handles.editSupchan,'String'))
    cfg.supchan = eval{get(handles.editSupchan,'String')};
end

if ~isempty(get(handles.editSupdip,'String'))
    cfg.supdip = eval{get(handles.editSupdip,'String')};
end

keeptrial = {'no','yes'};
cfg.keeptrial = keeptrial{get(handles.popKeepTrial,'Value')};

keepleadfield = {'no','yes'};
cfg.keepleadfield = keepleadfield{get(handles.popKeepLeadfield,'Value')};

projectnoise = {'no','yes'};
cfg.projectnoise = projectnoise{get(handles.popProjectnoise,'Value')};

keepfilter = {'no','yes'};
cfg.keepfilter = keepfilter{get(handles.popKeepFilter,'Value')};

keepcsd = {'no','yes'};
cfg.keepcsd = keepcsd{get(handles.popKeepCSD,'Value')};

keepmom = {'no','yes'};
cfg.keepmom = keepmom{get(handles.popKeepMom,'Value')};


handles.cfg   = cfg;
handles.conA  = conA;
handles.conB  = conB;
handles.whole = whole;
handles.mri   = mri;

guidata(hObject, handles);
uiresume(handles.figure1);

% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.figure1);

% --- Executes on button press in checkboxLeadfield.
function checkboxLeadfield_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxLeadfield (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxLeadfield
if get(hObject,'Value')
    set(handles.popLeadfieldDataset,'Enable','On');
    set(handles.popLeadfieldData,'Enable','On');
else
    set(handles.popLeadfieldDataset,'Enable','Off');
    set(handles.popLeadfieldData,'Enable','Off');
end


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


% --- Executes on selection change in popConADataset.
function popConADataset_Callback(hObject, eventdata, handles)
% hObject    handle to popConADataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popConADataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popConADataset
global dataSet;

idx = get(hObject,'Value');
data = dataSet{idx};

dataList = fieldnames(data);

set(handles.popConAData,'String',dataList);




% --- Executes on selection change in popConBDataset.
function popConBDataset_Callback(hObject, eventdata, handles)
% hObject    handle to popConBDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popConBDataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popConBDataset
global dataSet;

idx = get(hObject,'Value');
data = dataSet{idx};

dataList = fieldnames(data);

set(handles.popConBData,'String',dataList);


% --- Executes on selection change in popWholeDataset.
function popWholeDataset_Callback(hObject, eventdata, handles)
% hObject    handle to popWholeDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popWholeDataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popWholeDataset
global dataSet;

idx = get(hObject,'Value');
data = dataSet{idx};

dataList = fieldnames(data);

set(handles.popWholeData,'String',dataList);