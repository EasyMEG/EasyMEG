function varargout = VisualInspect(varargin)
% VisualInspect MATLAB code for VisualInspect.fig
%      VisualInspect, by itself, creates a new VisualInspect or raises the existing
%      singleton*.
%
%      H = VisualInspect returns the handle to a new VisualInspect or the handle to
%      the existing singleton*.
%
%      VisualInspect('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VisualInspect.M with the given input arguments.
%
%      VisualInspect('Property','Value',...) creates a new VisualInspect or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VisualInspect_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VisualInspect_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VisualInspect

% Last Modified by GUIDE v2.5 25-Aug-2016 19:17:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VisualInspect_OpeningFcn, ...
                   'gui_OutputFcn',  @VisualInspect_OutputFcn, ...
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


% --- Executes just before VisualInspect is made visible.
function VisualInspect_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VisualInspect (see VARARGIN)

% Choose default command line output for VisualInspect
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VisualInspect wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VisualInspect_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function editPassBand_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPassBand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function editStopBand_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editStopBand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function editEegScaling_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEegScaling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function editEogScaling_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEogScaling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editEcgScaling_Callback(hObject, eventdata, handles)
% hObject    handle to editEcgScaling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEcgScaling as text
%        str2double(get(hObject,'String')) returns contents of editEcgScaling as a double


% --- Executes during object creation, after setting all properties.
function editEcgScaling_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEcgScaling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function editEmgScaling_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEmgScaling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function editMegScaling_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMegScaling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popRender_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popRender (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rbtnContinuousYes.
function rbtnContinuousYes_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnContinuousYes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnContinuousYes
if get(hObject,'Value')
    set(handles.rbtnContinuousNo,'Value',0);
else
    set(handles.rbtnContinuousNo,'Value',1);
end


% --- Executes on button press in rbtnContinuousNo.
function rbtnContinuousNo_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnContinuousNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnContinuousNo
if get(hObject,'Value')
    set(handles.rbtnContinuousYes,'Value',0);
else
    set(handles.rbtnContinuousYes,'Value',1);
end

% --- Executes on button press in rbtnEventLabelsOn.
function rbtnEventLabelsOn_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnEventLabelsOn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnEventLabelsOn
if get(hObject,'Value')
    set(handles.rbtnEventLabelsOff,'Value',0);
else
    set(handles.rbtnEventLabelsOff,'Value',1);
end

% --- Executes on button press in rbtnEventLabelsOff.
function rbtnEventLabelsOff_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnEventLabelsOff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnEventLabelsOff
if get(hObject,'Value')
    set(handles.rbtnEventLabelsOn,'Value',0);
else
    set(handles.rbtnEventLabelsOn,'Value',1);
end

% --- Executes on button press in rbtnViewModeVertical.
function rbtnViewModeVertical_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnViewModeVertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnViewModeVertical
if get(hObject,'Value')
    set(handles.rbtnViewModeButterfly,'Value',0);
else
    set(handles.rbtnViewModeButterfly,'Value',1);
end

% --- Executes on button press in rbtnViewModeButterfly.
function rbtnViewModeButterfly_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnViewModeButterfly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnViewModeButterfly
if get(hObject,'Value')
    set(handles.rbtnViewModeVertical,'Value',0);
else
    set(handles.rbtnViewModeVertical,'Value',1);
end


% --- Executes during object creation, after setting all properties.
function editVerticalScaling_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVerticalScaling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editBlockSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBlockSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in btnRunBrowser.
function btnOk_Callback(hObject, eventdata, handles)
% hObject    handle to btnRunBrowser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

data = dataSet{currentData};

cfg = [];

if(get(handles.rbtnContinuousYes,'value'))
    cfg.continuous = 'yes';
else
    cfg.continuous = 'no';
end

if(get(handles.rbtnEventLabelsOn,'value'))
    cfg.plotlabels = 'yes';
else
    cfg.plotlabels = 'no';
end

if(get(handles.rbtnViewModeVertical,'value'))
    cfg.viewmode = 'vertical';
else
    cfg.viewmode = 'butterfly';
end

eval(['cfg.ylim=',get(handles.editVerticalScaling,'String'),';']);

if(str2double(get(handles.editBlockSize,'String')))
    eval(['cfg.blocksize=',get(handles.editBlockSize,'String'),';']);
end


if(str2double(get(handles.editMegScaling,'String')))
    eval(['cfg.megscale=',get(handles.editMegScaling,'String'),';']);
end

if(str2double(get(handles.editEegScaling,'String')))
    eval(['cfg.eegscale=',get(handles.editEegScaling,'String'),';']);
end

if(str2double(get(handles.editEogScaling,'String')))
    eval(['cfg.eogscale=',get(handles.editEogScaling,'String'),';']);
end

if(str2double(get(handles.editEcgScaling,'String')))
    eval(['cfg.ecgscale=',get(handles.editEcgScaling,'String'),';']);
end

if(str2double(get(handles.editEmgScaling,'String')))
    eval(['cfg.emgscale=',get(handles.editEmgScaling,'String'),';']);
end

if(get(handles.checkboxPassBand,'Value'))
    eval(['cfg.emgscale=',get(handles.editPassBand,'String'),';']);
end

if(get(handles.checkboxStopBand,'Value'))
    eval(['cfg.emgscale=',get(handles.editStopBand,'String'),';']);
end

if(get(handles.checkboxDFT,'Value'))
    cfg.preproc.detrend = 'yes';
end

renderList = get(handles.popRender,'String');
renderNum  = get(handles.popRender,'Value');
cfg.render = renderList{renderNum};

cfg = ft_databrowser(cfg,data);
data = ft_rejectartifact(cfg, data);

dataSet{currentData} = data;
close;

% --- Executes on button press in rbtnTrail.
function rbtnTrail_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnTrail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnTrail
if get(hObject,'Value')
    set(handles.rbtnChannel,'Value',0);
    set(handles.rbtnSummary,'Value',0);
end


% --- Executes on button press in rbtnChannel.
function rbtnChannel_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnChannel
if get(hObject,'Value')
    set(handles.rbtnTrail,'Value',0);
    set(handles.rbtnSummary,'Value',0);
end

% --- Executes on button press in rbtnSummary.
function rbtnSummary_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnSummary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnSummary
if get(hObject,'Value')
    set(handles.rbtnTrail,'Value',0);
    set(handles.rbtnChannel,'Value',0);
end


% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;
