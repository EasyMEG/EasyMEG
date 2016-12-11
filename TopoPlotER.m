function varargout = TopoPlotER(varargin)
% TopoPlotER MATLAB code for TopoPlotER.fig
%      TopoPlotER, by itself, creates a new TopoPlotER or raises the existing
%      singleton*.
%
%      H = TopoPlotER returns the handle to a new TopoPlotER or the handle to
%      the existing singleton*.
%
%      TopoPlotER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TopoPlotER.M with the given input arguments.
%
%      TopoPlotER('Property','Value',...) creates a new TopoPlotER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TopoPlotER_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TopoPlotER_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TopoPlotER

% Last Modified by GUIDE v2.5 08-Dec-2016 22:59:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TopoPlotER_OpeningFcn, ...
                   'gui_OutputFcn',  @TopoPlotER_OutputFcn, ...
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


% --- Executes just before TopoPlotER is made visible.
function TopoPlotER_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TopoPlotER (see VARARGIN)

% Choose default command line output for TopoPlotER
handles.output   = hObject;
handles.cfg      = [];
handles.idx      = [];
handles.dataName = [];

% Update handles structure
guidata(hObject, handles);

% Set listDataset and listData
global dataSet;
dataSetList = [];
for i=1:length(dataSet)
    dataSetList{i} = dataSet{i}.name;
end
set(handles.popDataset,'String',dataSetList);

data = dataSet{1};
dataList = fieldnames(data);
set(handles.popData,'String',dataList);

% UIWAIT makes TopoPlotER wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TopoPlotER_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.cfg;
varargout{2} = handles.idx;
varargout{3} = handles.dataName;

delete(handles.figure1);


% --- Executes on button press in btnPlot.
function btnPlot_Callback(hObject, eventdata, handles)
% hObject    handle to btnPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cfg = [];
layout                = get(handles.popLayout,'String');
cfg.layout            = layout{get(handles.popLayout,'Value')};
maskstyle             = get(handles.popMaskStyle,'String');
cfg.maskstyle         = maskstyle{get(handles.popMaskStyle,'Value')};
cfg.xlim              = eval(get(handles.editXlim,'String'));
cfg.ylim              = eval(get(handles.editYlim,'String'));
cfg.zlim              = eval(get(handles.editZlim,'String'));
cfg.fontsize          = eval(get(handles.editFontSize,'String'));
cfg.linewidth         = eval(get(handles.editLineWidth,'String'));
cfg.baseline          = eval(get(handles.editBaseline,'String'));
baselinetype          = get(handles.popBaselineType,'String');
cfg.baselinetype      = baselinetype{get(handles.popBaselineType,'Value')};
colormap              = get(handles.popColorMap,'String');
cfg.colormap          = colormap{get(handles.popColorMap,'Value')};
marker                = get(handles.popMarker,'String');
cfg.marker            = marker{get(handles.popMarker,'Value')};
cfg.markersymbol      = eval(get(handles.editMarkerSymbol,'String'));
cfg.markercolor       = get(handles.btnMarkerColor,'BackgroundColor');
cfg.markersize        = eval(get(handles.editMarkerSize,'String'));
cfg.markerfontsize    = eval(get(handles.editMarkerFontSize,'String'));
highlight             = get(handles.popHighlight,'String');
cfg.highlight         = highlight{get(handles.popHighlight,'Value')};
cfg.highlightsymbol   = eval(get(handles.editHighlightSymbol,'String'));
cfg.highlightcolor    = get(handles.btnHighlightColor,'BackgroundColor');
cfg.highlightsize     = eval(get(handles.editHighlightSize,'String'));
cfg.highlightfontsize = eval(get(handles.editHighlightFontSize,'String'));
interplimits          = get(handles.popInterplimits,'String');
cfg.interplimits      = interplimits{get(handles.popInterplimits,'Value')};
interpolation         = get(handles.popInterpolation,'String');
cfg.interpolation     = interpolation{get(handles.popInterpolation,'Value')};
cfg.girdscale         = eval(get(handles.editGirdScale,'String'));
shading               = get(handles.popShading,'String');
cfg.shading           = shading{get(handles.popShading,'Value')};

if ~isempty(get(handles.editHighlightChannel,'String'))
    cfg.highlightchannel  = eval(get(handles.editHighlightChannel,'String'));
end

colorbar              = {'yes','no','North','South','East','West','NorthOutside','SouthOutside','EastOutside','WestOutside'};
cfg.colorbar          = colorbar{get(handles.popColorbar,'Value')};
style                 = {'straight','contour','both','fill','blank'};
cfg.style             = style{get(handles.popStyle,'Value')};

switch get(handles.popParameter,'Value')
    case 1
    case 2
        cfg.parameter = 'avg';
    case 3
        cfg.parameter = 'powspctrm';
    case 4
        cfg.parameter = 'cohspctrm';
end

cfg.channel  = eval(get(handles.editChannels,'String'));
cfg.trials   = eval(get(handles.editTrials,'String'));

handles.cfg      = cfg;
handles.idx      = get(handles.popDataset,'Value');
dataName         = get(handles.popData,'String');
handles.dataName = dataName{get(handles.popData,'Value')};

guidata(hObject, handles);
uiresume(handles.figure1);

% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.figure1);

% --- Executes during object creation, after setting all properties.
function editChannels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editChannels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popParameter.
function popParameter_Callback(hObject, eventdata, handles)
% hObject    handle to popParameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popParameter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popParameter


% --- Executes during object creation, after setting all properties.
function popParameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popParameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editTrials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popMaskStyle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popMaskStyle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editXlim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editXlim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function editYlim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editYlim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editBaseline_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBaseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popBaselineType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popBaselineType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popShowOutline_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popShowOutline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popShowLabels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popShowLabels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editFontSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFontSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editLineWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLineWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popLayout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popLayout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editLineStyle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLineStyle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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



function editZlim_Callback(hObject, eventdata, handles)
% hObject    handle to editZlim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editZlim as text
%        str2double(get(hObject,'String')) returns contents of editZlim as a double


% --- Executes during object creation, after setting all properties.
function editZlim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editZlim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popColorMap.
function popColorMap_Callback(hObject, eventdata, handles)
% hObject    handle to popColorMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popColorMap contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popColorMap


% --- Executes during object creation, after setting all properties.
function popColorMap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popColorMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popMarker.
function popMarker_Callback(hObject, eventdata, handles)
% hObject    handle to popMarker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popMarker contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popMarker


% --- Executes during object creation, after setting all properties.
function popMarker_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popMarker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMarkerSymbol_Callback(hObject, eventdata, handles)
% hObject    handle to editMarkerSymbol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMarkerSymbol as text
%        str2double(get(hObject,'String')) returns contents of editMarkerSymbol as a double


% --- Executes during object creation, after setting all properties.
function editMarkerSymbol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMarkerSymbol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in btnMarkerColor.
function btnMarkerColor_Callback(hObject, eventdata, handles)
% hObject    handle to btnMarkerColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c = uisetcolor;
set(hObject,'BackgroundColor',c)



function editMarkerSize_Callback(hObject, eventdata, handles)
% hObject    handle to editMarkerSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMarkerSize as text
%        str2double(get(hObject,'String')) returns contents of editMarkerSize as a double


% --- Executes during object creation, after setting all properties.
function editMarkerSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMarkerSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMarkerFontSize_Callback(hObject, eventdata, handles)
% hObject    handle to editMarkerFontSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMarkerFontSize as text
%        str2double(get(hObject,'String')) returns contents of editMarkerFontSize as a double


% --- Executes during object creation, after setting all properties.
function editMarkerFontSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMarkerFontSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popHighlight.
function popHighlight_Callback(hObject, eventdata, handles)
% hObject    handle to popHighlight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popHighlight contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popHighlight


% --- Executes during object creation, after setting all properties.
function popHighlight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popHighlight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editHighlightChannel_Callback(hObject, eventdata, handles)
% hObject    handle to editHighlightChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editHighlightChannel as text
%        str2double(get(hObject,'String')) returns contents of editHighlightChannel as a double


% --- Executes during object creation, after setting all properties.
function editHighlightChannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editHighlightChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editHighlightSymbol_Callback(hObject, eventdata, handles)
% hObject    handle to editHighlightSymbol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editHighlightSymbol as text
%        str2double(get(hObject,'String')) returns contents of editHighlightSymbol as a double


% --- Executes during object creation, after setting all properties.
function editHighlightSymbol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editHighlightSymbol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnHighlightColor.
function btnHighlightColor_Callback(hObject, eventdata, handles)
% hObject    handle to btnHighlightColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editHighlightSize_Callback(hObject, eventdata, handles)
% hObject    handle to editHighlightSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editHighlightSize as text
%        str2double(get(hObject,'String')) returns contents of editHighlightSize as a double


% --- Executes during object creation, after setting all properties.
function editHighlightSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editHighlightSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editHighlightFontSize_Callback(hObject, eventdata, handles)
% hObject    handle to editHighlightFontSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editHighlightFontSize as text
%        str2double(get(hObject,'String')) returns contents of editHighlightFontSize as a double


% --- Executes during object creation, after setting all properties.
function editHighlightFontSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editHighlightFontSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popColorbar.
function popColorbar_Callback(hObject, eventdata, handles)
% hObject    handle to popColorbar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popColorbar contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popColorbar


% --- Executes during object creation, after setting all properties.
function popColorbar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popColorbar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popInterplimits.
function popInterplimits_Callback(hObject, eventdata, handles)
% hObject    handle to popInterplimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popInterplimits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popInterplimits


% --- Executes during object creation, after setting all properties.
function popInterplimits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popInterplimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popStyle.
function popStyle_Callback(hObject, eventdata, handles)
% hObject    handle to popStyle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popStyle contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popStyle


% --- Executes during object creation, after setting all properties.
function popStyle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popStyle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popInterpolation.
function popInterpolation_Callback(hObject, eventdata, handles)
% hObject    handle to popInterpolation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popInterpolation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popInterpolation


% --- Executes during object creation, after setting all properties.
function popInterpolation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popInterpolation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editGirdScale_Callback(hObject, eventdata, handles)
% hObject    handle to editGirdScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editGirdScale as text
%        str2double(get(hObject,'String')) returns contents of editGirdScale as a double


% --- Executes during object creation, after setting all properties.
function editGirdScale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editGirdScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popShading.
function popShading_Callback(hObject, eventdata, handles)
% hObject    handle to popShading (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popShading contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popShading


% --- Executes during object creation, after setting all properties.
function popShading_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popShading (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popLayout.
function popLayout_Callback(hObject, eventdata, handles)
% hObject    handle to popLayout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popLayout contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popLayout


% --- Executes on selection change in popDataset.
function popDataset_Callback(hObject, eventdata, handles)
% hObject    handle to popDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popDataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popDataset
global dataSet;

idx = get(hObject,'Value');
data = dataSet{idx};

dataList = fieldnames(data);

set(handles.popData,'String',dataList);



% --- Executes during object creation, after setting all properties.
function popDataset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popData.
function popData_Callback(hObject, eventdata, handles)
% hObject    handle to popData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popData contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popData


% --- Executes during object creation, after setting all properties.
function popData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
