function varargout = LocalizingOscillatorySources(varargin)
% LOCALIZINGOSCILLATORYSOURCES MATLAB code for LocalizingOscillatorySources.fig
%      LOCALIZINGOSCILLATORYSOURCES, by itself, creates a new LOCALIZINGOSCILLATORYSOURCES or raises the existing
%      singleton*.
%
%      H = LOCALIZINGOSCILLATORYSOURCES returns the handle to a new LOCALIZINGOSCILLATORYSOURCES or the handle to
%      the existing singleton*.
%
%      LOCALIZINGOSCILLATORYSOURCES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOCALIZINGOSCILLATORYSOURCES.M with the given input arguments.
%
%      LOCALIZINGOSCILLATORYSOURCES('Property','Value',...) creates a new LOCALIZINGOSCILLATORYSOURCES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LocalizingOscillatorySources_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LocalizingOscillatorySources_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LocalizingOscillatorySources

% Last Modified by GUIDE v2.5 12-Dec-2016 11:46:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LocalizingOscillatorySources_OpeningFcn, ...
                   'gui_OutputFcn',  @LocalizingOscillatorySources_OutputFcn, ...
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


% --- Executes just before LocalizingOscillatorySources is made visible.
function LocalizingOscillatorySources_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LocalizingOscillatorySources (see VARARGIN)

% Choose default command line output for LocalizingOscillatorySources
handles.output = hObject;
handles.cfgFrq = [];
handles.cfgSrc = [];
handles.conA = [];
handles.conB = [];
handles.mri  = [];
handles.name = [];

% Update handles structure
guidata(hObject, handles);

% Set listDataset and listData
global dataSet;
dataSetList = [];
for i=1:length(dataSet)
    dataSetList{i} = dataSet{i}.name;
end
set(handles.listDataset,'String',dataSetList);
set(handles.popHDMDataset,'String',dataSetList);

data = dataSet{1};
dataList = fieldnames(data);
set(handles.listData,'String',dataList);
set(handles.popHDMData,'String',dataList);

% UIWAIT makes LocalizingOscillatorySources wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LocalizingOscillatorySources_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.cfgFrq;
varargout{2} = handles.cfgSrc;
varargout{3} = handles.conA;
varargout{4} = handles.conB;
varargout{5} = handles.mri;
varargout{6} = handles.name;

delete(handles.figure1);



% --- Executes on button press in btnOk.
function btnOk_Callback(hObject, eventdata, handles)
% hObject    handle to btnOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;

cfgFrq = [];
cfgSrc = [];

MriDataset = get(handles.popHDMDataset,'Value');
MriData    = get(handles.popHDMData,'String');
MriData    = MriData{get(handles.popHDMData,'Value')};
mri = eval(['dataSet{MriDataset}.',MriData]);

cfgFrq.tapsmofrq    = eval(get(handles.editTapsmofrq,'String'));
cfgFrq.foilim       = eval(get(handles.editFoilim,'String'));
cfgFrq.channel      = eval(get(handles.editChannel,'String'));

cfgSrc.channel      = eval(get(handles.editChannel,'String'));
cfgSrc.frequency    = string(get(handles.editFrequency,'String'));

projectnoise = {'yes','no'};
cfgSrc.projectnoise = projectnoise{get(handles.popProjectnoise,'Value')};

nameDataset      = eval(get(handles.editName,'String'));

handles.cfgFrq = cfgFrq;
handles.cfgSrc = cfgSrc;
handles.name   = nameDataset;
handles.mri    = mri;
guidata(hObject, handles);
uiresume(handles.figure1);



% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.figure1);

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

set(handles.listData,'String',dataList);

% --- Executes during object creation, after setting all properties.
function listDataset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function listData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function listConA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listConA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnAddA.
function btnAddA_Callback(hObject, eventdata, handles)
% hObject    handle to btnAddA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
valPlotList = [];

datasetList = get(handles.listDataset,'String');
datasetSelect = get(handles.listDataset,'Value');
valPlotList{1} = datasetSelect;

strPlotList = get(handles.listData,'String');
strPlotList = strPlotList{get(handles.listData,'Value')};
valPlotList{2} = strPlotList;
strPlotList = string([datasetList{datasetSelect},'-->',strPlotList]);

temp = get(handles.listConA,'String');
if isequal(temp,'')
    temp = [];
end
set(handles.listConA,'String',[temp;strPlotList]);

temp2 = handles.conA;
temp2 = [temp2;valPlotList];

handles.conA = temp2;
guidata(hObject, handles);

% --- Executes on button press in btnRemoveA.
function btnRemoveA_Callback(hObject, eventdata, handles)
% hObject    handle to btnRemoveA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idx = get(handles.listConA,'Value');
plotList = get(handles.listConA,'String');
plotList(idx,:) = [];
set(handles.listConA,'String',plotList);

data = handles.conA;
data(idx,:) = [];
handles.conA = data;

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function listConB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listConB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnAddB.
function btnAddB_Callback(hObject, eventdata, handles)
% hObject    handle to btnAddB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
valPlotList = [];

datasetList = get(handles.listDataset,'String');
datasetSelect = get(handles.listDataset,'Value');
valPlotList{1} = datasetSelect;

strPlotList = get(handles.listData,'String');
strPlotList = strPlotList{get(handles.listData,'Value')};
valPlotList{2} = strPlotList;
strPlotList = string([datasetList{datasetSelect},'-->',strPlotList]);

temp = get(handles.listConB,'String');
if isequal(temp,'')
    temp = [];
end
set(handles.listConB,'String',[temp;strPlotList]);

temp2 = handles.conB;
temp2 = [temp2;valPlotList];

handles.conB = temp2;
guidata(hObject, handles);

% --- Executes on button press in btnRemoveB.
function btnRemoveB_Callback(hObject, eventdata, handles)
% hObject    handle to btnRemoveB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idx = get(handles.listConB,'Value');
plotList = get(handles.listConB,'String');
plotList(idx,:) = [];
set(handles.listConB,'String',plotList);

data = handles.conB;
data(idx,:) = [];
handles.conB = data;

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editTapsmofrq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTapsmofrq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editFoilim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFoilim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popHDMDataset.
function popHDMDataset_Callback(hObject, eventdata, handles)
% hObject    handle to popHDMDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popHDMDataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popHDMDataset
global dataSet;

idx = get(hObject,'Value');
data = dataSet{idx};

dataList = fieldnames(data);

set(handles.popHDMData,'String',dataList);

% --- Executes during object creation, after setting all properties.
function popHDMDataset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popHDMDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popHDMData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popHDMData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editChannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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

% --- Executes during object creation, after setting all properties.
function editFrequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editLambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popProjectnoise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popProjectnoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
