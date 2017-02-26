function varargout = SourceModel(varargin)
% SOURCEMODEL MATLAB code for SourceModel.fig
%      SOURCEMODEL, by itself, creates a new SOURCEMODEL or raises the existing
%      singleton*.
%
%      H = SOURCEMODEL returns the handle to a new SOURCEMODEL or the handle to
%      the existing singleton*.
%
%      SOURCEMODEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOURCEMODEL.M with the given input arguments.
%
%      SOURCEMODEL('Property','Value',...) creates a new SOURCEMODEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SourceModel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SourceModel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SourceModel

% Last Modified by GUIDE v2.5 23-Sep-2016 16:06:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SourceModel_OpeningFcn, ...
                   'gui_OutputFcn',  @SourceModel_OutputFcn, ...
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


% --- Executes just before SourceModel is made visible.
function SourceModel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SourceModel (see VARARGIN)

% Choose default command line output for SourceModel
handles.output = hObject;
handles.useTemplate = [];
handles.cfg = [];

% Update handles structure
guidata(hObject, handles);

set(handles.rbtnCustomTemplate,'Value',0);
set(handles.rbtnFieldTripTemplate,'Value',1);

set(handles.editSourcemodelPath,'Enable','On');
set(handles.btnBrowse,'Enable','On');

set(handles.editResolution,'Enable','Off');
set(handles.editInwardShift,'Enable','Off');
set(handles.editMoveInward,'Enable','Off');
set(handles.rbtnNonLinearYes,'Enable','Off');
set(handles.rbtnNonLinearNo,'Enable','Off');

% UIWAIT makes SourceModel wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SourceModel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.useTemplate;
varargout{2} = handles.cfg;

delete(handles.figure1);


% --- Executes on button press in rbtnFieldTripTemplate.
function rbtnFieldTripTemplate_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnFieldTripTemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnFieldTripTemplate
if get(hObject,'Value')
    set(handles.rbtnCustomTemplate,'Value',0);
    
    set(handles.editSourcemodelPath,'Enable','On');
    set(handles.btnBrowse,'Enable','On');
    
    set(handles.editResolution,'Enable','Off');
    set(handles.editInwardShift,'Enable','Off');
    set(handles.editMoveInward,'Enable','Off');
    set(handles.rbtnNonLinearYes,'Enable','Off');
    set(handles.rbtnNonLinearNo,'Enable','Off');
else
    set(handles.rbtnCustomTemplate,'Value',1);
    
    set(handles.editSourcemodelPath,'Enable','Off');
    set(handles.btnBrowse,'Enable','Off');
    
    set(handles.editResolution,'Enable','On');
    set(handles.editInwardShift,'Enable','On');
    set(handles.editMoveInward,'Enable','On');
    set(handles.rbtnNonLinearYes,'Enable','On');
    set(handles.rbtnNonLinearNo,'Enable','On');
end


% --- Executes on button press in rbtnCustomTemplate.
function rbtnCustomTemplate_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnCustomTemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnCustomTemplate
if ~get(hObject,'Value')
    set(handles.rbtnFieldTripTemplate,'Value',1);
    
    set(handles.editSourcemodelPath,'Enable','On');
    set(handles.btnBrowse,'Enable','On');
    
    set(handles.editResolution,'Enable','Off');
    set(handles.editInwardShift,'Enable','Off');
    set(handles.editMoveInward,'Enable','Off');
    set(handles.rbtnNonLinearYes,'Enable','Off');
    set(handles.rbtnNonLinearNo,'Enable','Off');
else
    set(handles.rbtnFieldTripTemplate,'Value',0);
    
    set(handles.editSourcemodelPath,'Enable','Off');
    set(handles.btnBrowse,'Enable','Off');
    
    set(handles.editResolution,'Enable','On');
    set(handles.editInwardShift,'Enable','On');
    set(handles.editMoveInward,'Enable','On');
    set(handles.rbtnNonLinearYes,'Enable','On');
    set(handles.rbtnNonLinearNo,'Enable','On');
end


% --- Executes on button press in btnOk.
function btnOk_Callback(hObject, eventdata, handles)
% hObject    handle to btnOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
useTemplate = get(handles.rbtnFieldTripTemplate,'Value');
handles.useTemplate = useTemplate;

if useTemplate
    cfg.templatePath = get(handles.editSourcemodelPath,'String');
else
    cfg = [];
    cfg.resolution = str2double(get(handles.editResolution,'String'));
    cfg.inwardshift = str2double(get(handles.editInwardShift,'String'));
    cfg.moveinward = str2double(get(handles.editMoveInward,'String'));
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



% --- Executes on button press in btnBrowse.
function btnBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to btnBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global EasyMEGPath
global FieldTripPath

cd(fullfile(FieldTripPath,'template','sourcemodel'));

[filename, pathname]  = uigetfile('*.mat', 'Pick a FieldTrip sourcemodel template (.mat file)');
dataDir = fullfile(pathname, filename);

cd(EasyMEGPath);

if isequal(filename,0) || isequal(pathname,0)
    disp('Loading canceled...');
else
    set(handles.editSourcemodelPath,'String',dataDir)
end



% --- Executes on button press in rbtnNonLinearYes.
function rbtnNonLinearYes_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnNonLinearYes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnNonLinearYes
if get(hObject,'Value')
    set(handles.rbtnNonLinearNo,'Value',0);
else
    set(handles.rbtnNonLinearNo,'Value',1);
end



% --- Executes on button press in rbtnNonLinearNo.
function rbtnNonLinearNo_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnNonLinearNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnNonLinearNo
if get(hObject,'Value')
    set(handles.rbtnNonLinearYes,'Value',0);
else
    set(handles.rbtnNonLinearYes,'Value',1);
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
