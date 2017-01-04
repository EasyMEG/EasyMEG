function varargout = LeadField(varargin)
% LEADFIELD MATLAB code for LeadField.fig
%      LEADFIELD, by itself, creates a new LEADFIELD or raises the existing
%      singleton*.
%
%      H = LEADFIELD returns the handle to a new LEADFIELD or the handle to
%      the existing singleton*.
%
%      LEADFIELD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LEADFIELD.M with the given input arguments.
%
%      LEADFIELD('Property','Value',...) creates a new LEADFIELD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LeadField_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LeadField_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LeadField

% Last Modified by GUIDE v2.5 04-Jan-2017 15:24:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LeadField_OpeningFcn, ...
                   'gui_OutputFcn',  @LeadField_OutputFcn, ...
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


% --- Executes just before LeadField is made visible.
function LeadField_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LeadField (see VARARGIN)

% Choose default command line output for LeadField
handles.output = hObject;
handles.cfg    = [];

% Update handles structure
guidata(hObject, handles);

% display data in RAM
global dataSet;
dataSetList = [];
for i=1:length(dataSet)
    dataSetList{i} = dataSet{i}.name;
end
set(handles.popHeadmodelDataset,'String',dataSetList);

data = dataSet{1};
dataList = fieldnames(data);
set(handles.popHeadmodelData,'String',dataList);

% UIWAIT makes LeadField wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LeadField_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.cfg;

delete(handles.figure1);


% --- Executes on button press in btnOk.
function btnOk_Callback(hObject, eventdata, handles)
% hObject    handle to btnOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% MriDataset = get(handles.popHDMDataset,'Value');
% MriData    = get(handles.popHDMData,'String');
% MriData    = MriData{get(handles.popHDMData,'Value')};
% mri = eval(['dataSet{MriDataset}.',MriData]);
% 
% cfgFrq.tapsmofrq    = eval(get(handles.editTapsmofrq,'String'));
% cfgFrq.foilim       = eval(get(handles.editFoilim,'String'));
global dataSet;

cfg = [];

HDMDataset = get(handles.popHeadmodelDataset,'Value');

headmodel  = get(handles.popHeadmodelData,'String');
headmodel  = headmodel{get(handles.popHeadmodelData,'Value')};

cfg.headmodel = eval(['dataSet{HDMDataset}.',headmodel]);
cfg.channel   = eval(get(handles.editChannel,'String'));
cfg.xgrid     = eval(get(handles.editXGrid,'String'));
cfg.ygrid     = eval(get(handles.editYGrid,'String'));
cfg.zgrid     = eval(get(handles.editZGrid,'String'));

cfg.resolution     = eval(get(handles.editResolution,'String'));
cfg.reducerank     = eval(get(handles.editReducerank,'String'));

normalize = {'no','yes'};
cfg.normlize = normalize{get(handles.popNormalize,'Value')};

cfg.normalizeparam     = eval(get(handles.editNormalizeparam,'String'));

normalize = {'no','yes'};
cfg.backproject = normalize{get(handles.popBackproject,'Value')};

handles.cfg = cfg;

guidata(hObject, handles);
uiresume(handles.figure1);

% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.figure1);

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
