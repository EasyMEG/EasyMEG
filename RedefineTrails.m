function varargout = RedefineTrails(varargin)
% RedefineTrails MATLAB code for RedefineTrails.fig
%      RedefineTrails, by itself, creates a new RedefineTrails or raises the existing
%      singleton*.
%
%      H = RedefineTrails returns the handle to a new RedefineTrails or the handle to
%      the existing singleton*.
%
%      RedefineTrails('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RedefineTrails.M with the given input arguments.
%
%      RedefineTrails('Property','Value',...) creates a new RedefineTrails or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RedefineTrails_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RedefineTrails_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RedefineTrails

% Last Modified by GUIDE v2.5 29-Jul-2016 18:14:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RedefineTrails_OpeningFcn, ...
                   'gui_OutputFcn',  @RedefineTrails_OutputFcn, ...
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


% --- Executes just before RedefineTrails is made visible.
function RedefineTrails_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RedefineTrails (see VARARGIN)
handles.output = hObject;
handles.cfg = [];
handles.dataDir = varargin{1};

% Choose default command line output for RedefineTrails
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Ini
global listEventType;
global listEventValue;

try
    event = ft_read_event(handles.dataDir);
catch ep
    ed = errordlg(ep.message,'Error');
    waitfor(ed);
    return
end
event = struct2cell(event);
eventType  = event(1,:);
eventValue = event(3,:);

listEventType = unique(eventType);
listEventValue = [];

for i=1:length(listEventType)
    idx = strcmp(eventType,listEventType{i});
    temp = eventValue(idx);
    temp = cell2mat(temp);
    temp = unique(temp);
    
    listEventValue{i}=temp;
end

set(handles.listboxEventType,'String',listEventType);
set(handles.listboxEventValue,'String',listEventValue{1});

% UIWAIT makes RedefineTrails wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RedefineTrails_OutputFcn(hObject, eventdata, handles) 
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

cfg                         = [];
cfg.dataset                 = handles.dataDir;
cfg.trialfun                = 'ft_trialfun_general';
cfg.trialdef.eventtype      = get(handles.editEventType,'String');
cfg.trialdef.eventvalue     = str2double(get(handles.editEventValue,'String')); % the value of the stimulus trigger for fully incongruent (FIC).
cfg.trialdef.prestim        = str2double(get(handles.editPrestim,'String')); % in seconds
cfg.trialdef.poststim       = str2double(get(handles.editPoststim,'String')); % in seconds

handles.cfg = cfg;


guidata(hObject, handles);
uiresume(handles.figure1);


% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.figure1);


% --- Executes on selection change in listboxEventType.
function listboxEventType_Callback(hObject, eventdata, handles)
% hObject    handle to listboxEventType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxEventType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxEventType
global listEventValue
% set(handles.listboxEventValue,'String',listEventValue{get(hObject,'Value')});

seltype = get(gcf,'selectiontype'); % Right-or-left click?

switch seltype
    case 'alt'
    case 'normal'
        set(handles.listboxEventValue,'Value',1);
        set(handles.listboxEventValue,'String',listEventValue{get(hObject,'Value')});
    otherwise
        eventType = get(handles.listboxEventType,'String');
        eventType = eventType(get(handles.listboxEventType,'Value'));
        set(handles.editEventType,'String',eventType);
end


% --- Executes on selection change in listboxEventValue.
function listboxEventValue_Callback(hObject, eventdata, handles)
% hObject    handle to listboxEventValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxEventValue contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxEventValue
global listEventValue
% set(handles.listboxEventValue,'String',listEventValue{get(hObject,'Value')});

seltype = get(gcf,'selectiontype'); % Right-or-left click?

switch seltype
    case 'alt'
    case 'normal'
    otherwise
        eventValue = get(handles.listboxEventValue,'String');
        eventValue = eventValue(get(handles.listboxEventValue,'Value'));
        set(handles.editEventValue,'String',eventValue);
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


% --------------------------------------------------------------------
function setEventType_Callback(hObject, eventdata, handles)
% hObject    handle to setEventType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eventType = get(handles.listboxEventType,'String');
eventType = eventType(get(handles.listboxEventType,'Value'));
set(handles.editEventType,'String',eventType);


% --------------------------------------------------------------------
function setEventValue_Callback(hObject, eventdata, handles)
% hObject    handle to setEventValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eventValue = get(handles.listboxEventValue,'String');
eventValue = eventValue(get(handles.listboxEventValue,'Value'));
set(handles.editEventValue,'Value',1);
set(handles.editEventValue,'String',eventValue);
