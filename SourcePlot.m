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

% Last Modified by GUIDE v2.5 11-Dec-2016 21:56:20

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

% UIWAIT makes SourcePlot wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SourcePlot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.cfg;
varargout{2} = handles.idx;
varargout{3} = handles.dataName;

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

set(handles.popData,'String',dataList);



% --- Executes during object creation, after setting all properties.
function popDataset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popMethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editFunparameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFunparameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editDownSample_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDownSample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editAtlas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAtlas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnAtlas.
function btnAtlas_Callback(hObject, eventdata, handles)
% hObject    handle to btnAtlas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname]  = uigetfile('*.*', 'Pick atlas file.');
dataDir = fullfile(pathname, filename);
set(handles.editAtlas,'String',dataDir);


% --- Executes during object creation, after setting all properties.
function popColorbar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popColorbar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnOk.
function btnOk_Callback(hObject, eventdata, handles)
% hObject    handle to btnOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cfg = [];

method            = {'slice','ortho','surface','glassbrain','vertex'};
cfg.method        = method{get(handles.popMethod,'Value')};

if ~isempty(get(handles.editFunparameter,'String'))
    cfg.funparameter  = eval(get(handles.editFunparameter,'String'));
end

if ~isempty(get(handles.editAtlas,'String'))
    cfg.atlas         = get(handles.editAtlas,'String');
end

colobar            = {'yes','no'};
cfg.colobar        = colobar{get(handles.popColorbar,'Value')};

cfg.downsample  = eval(get(handles.editDownSample,'String'));

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
