function varargout = HighPassFilter(varargin)
% LOWPASSFILTER MATLAB code for LowPassFilter.fig
%      LOWPASSFILTER, by itself, creates a new LOWPASSFILTER or raises the existing
%      singleton*.
%
%      H = LOWPASSFILTER returns the handle to a new LOWPASSFILTER or the handle to
%      the existing singleton*.
%
%      LOWPASSFILTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOWPASSFILTER.M with the given input arguments.
%
%      LOWPASSFILTER('Property','Value',...) creates a new LOWPASSFILTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LowPassFilter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LowPassFilter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% edithighpass the above text to modify the response to help LowPassFilter

% Last Modified by GUIDE v2.5 25-Aug-2016 19:35:42

% Begin initialization code - DO NOT EDITHIGHPASS
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HighPassFilter_OpeningFcn, ...
                   'gui_OutputFcn',  @HighPassFilter_OutputFcn, ...
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
% End initialization code - DO NOT EDITHIGHPASS


% --- Executes just before HighPassFilter is made visible.
function HighPassFilter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HighPassFilter (see VARARGIN)

% Choose default command line output for HighPassFilter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HighPassFilter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HighPassFilter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in btnOk.
function btnOk_Callback(hObject, eventdata, handles)
% hObject    handle to btnOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

data = dataSet{currentData,1};

channel = [];

if get(handles.checkboxMEG,'value')
    channel{length(channel)+1} = 'meg';
end

if get(handles.checkboxEEG,'value')
    channel{length(channel)+1} = 'eeg';
end

if get(handles.checkboxEOG,'value')
    channel{length(channel)+1} = 'eog';
end

if get(handles.checkboxECG,'value')
    channel{length(channel)+1} = 'ecg';
end

if get(handles.checkboxEMG,'value')
    channel{length(channel)+1} = 'emg';
end

if get(handles.checkboxALL,'value')
    channel = 'all';
end

channel = ft_channelselection(channel,data.label);

cfg = [];
cfg.hpfilter = 'yes';
cfg.hpfreq = str2double(get(handles.editHighPass,'String'));
cfg.channel = channel;
data = ft_preprocessing(cfg,data);

dataSet{currentData,1} = data;

close;

% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;



% --- Executes during object creation, after setting all properties.
function editHighPass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editHighPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: editHighPass controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editHighPass_Callback(hObject, eventdata, handles)
% hObject    handle to editHighPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editHighPass as text
%        str2double(get(hObject,'String')) returns contents of editHighPass as a double

% --- Executes on button press in checkboxALL.
function checkboxALL_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxALL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxALL


% --- Executes on button press in checkboxMEG.
function checkboxMEG_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxMEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxMEG


% --- Executes on button press in checkboxEEG.
function checkboxEEG_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxEEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxEEG


% --- Executes on button press in checkboxEOG.
function checkboxEOG_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxEOG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxEOG


% --- Executes on button press in checkboxECG.
function checkboxECG_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxECG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxECG


% --- Executes on button press in checkboxEMG.
function checkboxEMG_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxEMG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxEMG
