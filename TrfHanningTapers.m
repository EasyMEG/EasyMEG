function varargout = TrfHanningTapers(varargin)
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

% Edit the above text to modify the response to help LowPassFilter

% Last Modified by GUIDE v2.5 29-Aug-2016 19:08:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TrfHanningTapers_OpeningFcn, ...
                   'gui_OutputFcn',  @TrfHanningTapers_OutputFcn, ...
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


% --- Executes just before TrfHanningTapers is made visible.
function TrfHanningTapers_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TrfHanningTapers (see VARARGIN)

% Choose default command line output for TrfHanningTapers
handles.output = hObject;
handles.cfg = [];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TrfHanningTapers wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TrfHanningTapers_OutputFcn(hObject, eventdata, handles) 
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
cfg = [];
cfg.channel = eval(get(handles.editChannel,'String'));
cfg.trails = eval(get(handles.editTrails,'String'));
cfg.method = 'mtmconvol';
cfg.taper  = 'hanning';

if get(handles.rbtnKeepTrailsYes,'Value')
    cfg.keeptrials = 'yes';
else
    cfg.keeptrials = 'no';
end

cfg.foi       = eval(get(handles.editFOI,'String'));
cfg.toi       = eval(get(handles.editTOI,'String'));
%cfg.t_ftimwin = str2double(get(handles.editTimeWindow,'String')) * ones(length(cfg.foi), 1);
cfg.t_ftimwin = eval(get(handles.editTimeWindow,'String'));
if get(handles.checkboxPad,'Value')
    cfg.pad = str2double(get(handles.editPad,'String'));
end

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



% --- Executes on button press in rbtnRmMeanYes.
function rbtnRmMeanYes_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnRmMeanYes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnRmMeanYes
if get(hObject,'Value')
    set(handles.rbtnRmMeanNo,'Value',0);
else
    set(handles.rbtnRmMeanNo,'Value',1);
end

% --- Executes on button press in rbtnRmMeanNo.
function rbtnRmMeanNo_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnRmMeanNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnRmMeanNo
if get(hObject,'Value')
    set(handles.rbtnRmMeanYes,'Value',0);
else
    set(handles.rbtnRmMeanYes,'Value',1);
end


% --- Executes on button press in rbtnKeepTrailsYes.
function rbtnKeepTrailsYes_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnKeepTrailsYes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnKeepTrailsYes
if get(hObject,'Value')
    set(handles.rbtnKeepTrailsNo,'Value',0);
else
    set(handles.rbtnKeepTrailsNo,'Value',1);
end

% --- Executes on button press in rbtnKeepTrailsNo.
function rbtnKeepTrailsNo_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnKeepTrailsNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnKeepTrailsNo
if get(hObject,'Value')
    set(handles.rbtnKeepTrailsYes,'Value',0);
else
    set(handles.rbtnKeepTrailsYes,'Value',1);
end
