function varargout = AppendData(varargin)
% APPENDDATA MATLAB code for AppendData.fig
%      APPENDDATA, by itself, creates a new APPENDDATA or raises the existing
%      singleton*.
%
%      H = APPENDDATA returns the handle to a new APPENDDATA or the handle to
%      the existing singleton*.
%
%      APPENDDATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APPENDDATA.M with the given input arguments.
%
%      APPENDDATA('Property','Value',...) creates a new APPENDDATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AppendData_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AppendData_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AppendData

% Last Modified by GUIDE v2.5 07-Jan-2017 22:27:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AppendData_OpeningFcn, ...
                   'gui_OutputFcn',  @AppendData_OutputFcn, ...
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


% --- Executes just before AppendData is made visible.
function AppendData_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AppendData (see VARARGIN)

% Choose default command line output for AppendData
handles.output = hObject;
handles.data   = [];
handles.name   = [];

% Update handles structure
guidata(hObject, handles);

% Set listDataset and listData
global dataSet;
dataSetList = [];
for i=1:length(dataSet)
    dataSetList{i} = dataSet{i}.name;
end
set(handles.listDataset,'String',dataSetList);


% UIWAIT makes AppendData wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AppendData_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.data;
varargout{2} = handles.name;

delete(handles.figure1);



% --- Executes on button press in btnAdd.
function btnAdd_Callback(hObject, eventdata, handles)
% hObject    handle to btnAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

datasetList = get(handles.listDataset,'String');
datasetIdx = double(get(handles.listDataset,'Value'));
strNewDataList = datasetList(datasetIdx);


temp = get(handles.listNewData,'String');
if isequal(temp,'')
    temp = [];
end
set(handles.listNewData,'String',[temp;strNewDataList]);

temp2 = handles.data;
temp2 = [temp2;datasetIdx];

handles.data = temp2;
guidata(hObject, handles);

% --- Executes on button press in btnRemove.
function btnRemove_Callback(hObject, eventdata, handles)
% hObject    handle to btnRemove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idx = get(handles.listNewData,'Value');
newDataList = get(handles.listNewData,'String');
newDataList(idx,:) = [];
set(handles.listNewData,'String',newDataList);

data = handles.data;
data(idx,:) = [];
handles.data = data;

guidata(hObject,handles);

% --- Executes on button press in btnOk.
function btnOk_Callback(hObject, eventdata, handles)
% hObject    handle to btnOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.data)
    ed = errordlg('No data selected.','Error');
    waitfor(ed);
    return
end

name = get(handles.editName,'String');
if isempty(name)
    ed = errordlg('Please enter a name for new dataset.','Error');
    waitfor(ed);
    return    
end
handles.name = name;

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

