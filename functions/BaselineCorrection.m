function varargout = BaselineCorrection(varargin)
% BASELINECORRECTION MATLAB code for BaselineCorrection.fig
%      BASELINECORRECTION, by itself, creates a new BASELINECORRECTION or raises the existing
%      singleton*.
%
%      H = BASELINECORRECTION returns the handle to a new BASELINECORRECTION or the handle to
%      the existing singleton*.
%
%      BASELINECORRECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BASELINECORRECTION.M with the given input arguments.
%
%      BASELINECORRECTION('Property','Value',...) creates a new BASELINECORRECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BaselineCorrection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BaselineCorrection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BaselineCorrection

% Last Modified by GUIDE v2.5 28-Feb-2017 19:11:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BaselineCorrection_OpeningFcn, ...
                   'gui_OutputFcn',  @BaselineCorrection_OutputFcn, ...
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


% --- Executes just before BaselineCorrection is made visible.
function BaselineCorrection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BaselineCorrection (see VARARGIN)

% Choose default command line output for BaselineCorrection
handles.output = hObject;
handles.cfg = [];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BaselineCorrection wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BaselineCorrection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.cfg;
delete(handles.figure1);

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


% --- Executes on button press in btnOK.
function btnOK_Callback(hObject, eventdata, handles)
% hObject    handle to btnOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cfg=[];
cfg.demean='yes';
cfg.baselinewindow=eval(get(handles.editBaselinewindow,'String'));
handles.cfg=cfg;

guidata(hObject, handles);
uiresume(handles.figure1);

% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.figure1);
