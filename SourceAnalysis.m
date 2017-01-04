function varargout = SourceAnalysis(varargin)
% SOURCEANALYSIS MATLAB code for SourceAnalysis.fig
%      SOURCEANALYSIS, by itself, creates a new SOURCEANALYSIS or raises the existing
%      singleton*.
%
%      H = SOURCEANALYSIS returns the handle to a new SOURCEANALYSIS or the handle to
%      the existing singleton*.
%
%      SOURCEANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOURCEANALYSIS.M with the given input arguments.
%
%      SOURCEANALYSIS('Property','Value',...) creates a new SOURCEANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SourceAnalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SourceAnalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SourceAnalysis

% Last Modified by GUIDE v2.5 04-Jan-2017 10:14:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SourceAnalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @SourceAnalysis_OutputFcn, ...
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


% --- Executes just before SourceAnalysis is made visible.
function SourceAnalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SourceAnalysis (see VARARGIN)

% Choose default command line output for SourceAnalysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SourceAnalysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SourceAnalysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listDataset.
function listDataset_Callback(hObject, eventdata, handles)
% hObject    handle to listDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listDataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listDataset


% --- Executes during object creation, after setting all properties.
function listDataset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function listConA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listConA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnAddConA.
function btnAddConA_Callback(hObject, eventdata, handles)
% hObject    handle to btnAddConA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnRemoveConA.
function btnRemoveConA_Callback(hObject, eventdata, handles)
% hObject    handle to btnRemoveConA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnAddConB.
function btnAddConB_Callback(hObject, eventdata, handles)
% hObject    handle to btnAddConB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnRemoveConB.
function btnRemoveConB_Callback(hObject, eventdata, handles)
% hObject    handle to btnRemoveConB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popSourcemodelDataset.
function popSourcemodelDataset_Callback(hObject, eventdata, handles)
% hObject    handle to popSourcemodelDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popSourcemodelDataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popSourcemodelDataset


% --- Executes on selection change in popMriDataset.
function popMriDataset_Callback(hObject, eventdata, handles)
% hObject    handle to popMriDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popMriDataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popMriDataset


% --- Executes on selection change in popHeadmodelDataset.
function popHeadmodelDataset_Callback(hObject, eventdata, handles)
% hObject    handle to popHeadmodelDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popHeadmodelDataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popHeadmodelDataset


% --- Executes on selection change in popLeadfieldDataset.
function popLeadfieldDataset_Callback(hObject, eventdata, handles)
% hObject    handle to popLeadfieldDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popLeadfieldDataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popLeadfieldDataset


% --- Executes on button press in btnOK.
function btnOK_Callback(hObject, eventdata, handles)
% hObject    handle to btnOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
