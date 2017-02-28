function varargout = SetFieldTrip(varargin)
% SETFIELDTRIP MATLAB code for SetFieldTrip.fig
%      SETFIELDTRIP, by itself, creates a new SETFIELDTRIP or raises the existing
%      singleton*.
%
%      H = SETFIELDTRIP returns the handle to a new SETFIELDTRIP or the handle to
%      the existing singleton*.
%
%      SETFIELDTRIP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETFIELDTRIP.M with the given input arguments.
%
%      SETFIELDTRIP('Property','Value',...) creates a new SETFIELDTRIP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SetFieldTrip_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SetFieldTrip_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SetFieldTrip

% Last Modified by GUIDE v2.5 22-Feb-2017 16:19:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SetFieldTrip_OpeningFcn, ...
                   'gui_OutputFcn',  @SetFieldTrip_OutputFcn, ...
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


% --- Executes just before SetFieldTrip is made visible.
function SetFieldTrip_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SetFieldTrip (see VARARGIN)

% Choose default command line output for SetFieldTrip
handles.output = hObject;
handles.path = [];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SetFieldTrip wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SetFieldTrip_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.path;

delete(handles.figure1);


% --- Executes on button press in btnOK.
function btnOK_Callback(hObject, eventdata, handles)
% hObject    handle to btnOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path = get(handles.editPath,'String');
handles.path = path;

guidata(hObject, handles);
uiresume(handles.figure1);


% --- Executes on button press in btnBrowse.
function btnBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to btnBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path = uigetdir('.','Please set the FieldTrip toolbox directory.');
set(handles.editPath,'String',path);


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
