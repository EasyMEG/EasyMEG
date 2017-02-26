function varargout = SplitTrial(varargin)
% SPLITTRIAL MATLAB code for SplitTrial.fig
%      SPLITTRIAL, by itself, creates a new SPLITTRIAL or raises the existing
%      singleton*.
%
%      H = SPLITTRIAL returns the handle to a new SPLITTRIAL or the handle to
%      the existing singleton*.
%
%      SPLITTRIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPLITTRIAL.M with the given input arguments.
%
%      SPLITTRIAL('Property','Value',...) creates a new SPLITTRIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SplitTrial_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SplitTrial_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SplitTrial

% Last Modified by GUIDE v2.5 24-Feb-2017 10:36:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SplitTrial_OpeningFcn, ...
                   'gui_OutputFcn',  @SplitTrial_OutputFcn, ...
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


% --- Executes just before SplitTrial is made visible.
function SplitTrial_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SplitTrial (see VARARGIN)

% Choose default command line output for SplitTrial
handles.output = hObject;
handles.cfg = [];
handles.name = [];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SplitTrial wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SplitTrial_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.cfg;
varargout{2} = handles.name;

delete(handles.figure1);

% --- Executes on button press in btnOk.
function btnOk_Callback(hObject, eventdata, handles)
% hObject    handle to btnOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
timeRange = get(handles.editTimeRange,'String');
name = get(handles.editName,'String');

if isempty(timeRange)||isempty(name)
    wd = warndlg('The input cannot be blank.','Warning');
    waitfor(wd);
    return
end

try
    cfg = [];
    cfg.toilim = eval(timeRange);
catch ep
    ed = errordlg(ep,message,'Error');
    waitfor(ed);
    return
end

handles.cfg = cfg;
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
