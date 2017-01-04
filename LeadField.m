function varargout = LeadField(varargin)
% LEADFIELD MATLAB code for LeadField.fig
%      LEADFIELD, by itself, creates a new LEADFIELD or raises the existing
%      singleton*.
%
%      H = LEADFIELD returns the handle to a new LEADFIELD or the handle to
%      the existing singleton*.
%
%      LEADFIELD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LEADFIELD.M with the given input arguments.
%
%      LEADFIELD('Property','Value',...) creates a new LEADFIELD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LeadField_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LeadField_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LeadField

% Last Modified by GUIDE v2.5 04-Jan-2017 11:04:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LeadField_OpeningFcn, ...
                   'gui_OutputFcn',  @LeadField_OutputFcn, ...
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


% --- Executes just before LeadField is made visible.
function LeadField_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LeadField (see VARARGIN)

% Choose default command line output for LeadField
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LeadField wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LeadField_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popHeadmodelDataset.
function popHeadmodelDataset_Callback(hObject, eventdata, handles)
% hObject    handle to popHeadmodelDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popHeadmodelDataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popHeadmodelDataset
