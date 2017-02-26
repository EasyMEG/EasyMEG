function varargout = CorticoMuscularCoherence(varargin)
% CORTICOMUSCULARCOHERENCE MATLAB code for CorticoMuscularCoherence.fig
%      CORTICOMUSCULARCOHERENCE, by itself, creates a new CORTICOMUSCULARCOHERENCE or raises the existing
%      singleton*.
%
%      H = CORTICOMUSCULARCOHERENCE returns the handle to a new CORTICOMUSCULARCOHERENCE or the handle to
%      the existing singleton*.
%
%      CORTICOMUSCULARCOHERENCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CORTICOMUSCULARCOHERENCE.M with the given input arguments.
%
%      CORTICOMUSCULARCOHERENCE('Property','Value',...) creates a new CORTICOMUSCULARCOHERENCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CorticoMuscularCoherence_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CorticoMuscularCoherence_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CorticoMuscularCoherence

% Last Modified by GUIDE v2.5 29-Aug-2016 22:15:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CorticoMuscularCoherence_OpeningFcn, ...
                   'gui_OutputFcn',  @CorticoMuscularCoherence_OutputFcn, ...
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


% --- Executes just before CorticoMuscularCoherence is made visible.
function CorticoMuscularCoherence_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CorticoMuscularCoherence (see VARARGIN)

% Choose default command line output for CorticoMuscularCoherence
handles.output = hObject;
handles.cfg = [];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CorticoMuscularCoherence wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CorticoMuscularCoherence_OutputFcn(hObject, eventdata, handles) 
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
cfg                 = [];
cfg.output          = 'powandcsd';
cfg.method          = 'mtmfft';
cfg.taper           = 'dpss';
cfg.tapsmofrq       = str2double(get(handles.editSpectralSmoothing,'String'));
cfg.foilim          = eval(get(handles.editFOI,'String'));
if get(handles.rbtnKeepTrailsYes,'Value')
    cfg.keeptrails  = 'yes';
else
    cfg.keeptrails  = 'no';
end
cfg.channel         = eval(get(handles.editChannel,'String'));
cfg.channelcmb      = eval(get(handles.editChannelPairs,'String'));
cfg.pad             = 'nextpow2';

handles.cfg = cfg;
guidata(hObject, handles);
uiresume(handles.figure1);



% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.figure1);



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
