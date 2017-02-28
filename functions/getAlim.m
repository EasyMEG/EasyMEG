function varargout = getAlim(varargin)
% GETALIM MATLAB code for getAlim.fig
%      GETALIM, by itself, creates a new GETALIM or raises the existing
%      singleton*.
%
%      H = GETALIM returns the handle to a new GETALIM or the handle to
%      the existing singleton*.
%
%      GETALIM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GETALIM.M with the given input arguments.
%
%      GETALIM('Property','Value',...) creates a new GETALIM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before getAlim_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to getAlim_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help getAlim

% Last Modified by GUIDE v2.5 25-Aug-2016 20:21:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @getAlim_OpeningFcn, ...
                   'gui_OutputFcn',  @getAlim_OutputFcn, ...
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


% --- Executes just before getAlim is made visible.
function getAlim_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to getAlim (see VARARGIN)

% Choose default command line output for getAlim
handles.output = hObject;
handles.isOk = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes getAlim wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = getAlim_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.isOk;

varargout{2} = str2double((get(handles.editBase,'String')));
varargout{3} = str2double((get(handles.editMEG,'String')));
varargout{4} = str2double((get(handles.editEEG,'String')));
varargout{5} = str2double((get(handles.editECG,'String')));
varargout{6} = str2double((get(handles.editEOG,'String')));
varargout{7} = str2double((get(handles.editEMG,'String')));

delete(handles.figure1);


% --- Executes on button press in btnOk.
function btnOk_Callback(hObject, eventdata, handles)
% hObject    handle to btnOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.isOk = 1;
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
