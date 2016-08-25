function varargout = EasyMEG(varargin)
% EASYMEG MATLAB code for EasyMEG.fig
%      EASYMEG, by itself, creates a new EASYMEG or raises the existing
%      singleton*.
%
%      H = EASYMEG returns the handle to a new EASYMEG or the handle to
%      the existing singleton*.
%
%      EASYMEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EASYMEG.M with the given input arguments.
%
%      EASYMEG('Property','Value',...) creates a new EASYMEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EasyMEG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EasyMEG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EasyMEG

% Last Modified by GUIDE v2.5 25-Aug-2016 00:14:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EasyMEG_OpeningFcn, ...
                   'gui_OutputFcn',  @EasyMEG_OutputFcn, ...
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


% --- Executes just before EasyMEG is made visible.
function EasyMEG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EasyMEG (see VARARGIN)

% Choose default command line output for EasyMEG
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EasyMEG wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% global variables
global dataSet;
global currentData;

dataSet = [];
currentData = 0;


% --- Outputs from this function are returned to the command line.
function varargout = EasyMEG_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function menuQuit_Callback(hObject, eventdata, handles)
% hObject    handle to menuQuit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;


% --------------------------------------------------------------------
function menuCTFData_Callback(hObject, eventdata, handles)
% hObject    handle to menuCTFData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

dataDir = uigetdir('.','Pick a CTF data directory');
if dataDir~=0
    dispWait(handles)
    
    cfg = [];
    cfg.dataset = dataDir;
    data = ft_preprocessing(cfg);
    currentData = currentData + 1;
    dataSet{currentData,1} = data;
       
    dataSet{currentData,2} = getDatasetName();
    
    dispDatasetInfo(handles);
end

function dataName = getDatasetName(varargin)
global dataSet;
global currentData;

prompt        = {'Please enter the name of this dataset:'};
name          = 'Input dataset name';
numlines      = 1;

if nargin>0
    defaultanswer = varargin(1);
else
    defaultanswer = {['dataset',num2str(currentData)]};
end

dname          = inputdlg(prompt,name,numlines,defaultanswer);
dname          = dname{1};

if ~isvarname(dname)
    ed = errordlg('Invalid dataset name. Dataset name must be a matlab variable name.','Error');
    waitfor(ed);
    dname = getDatasetName();
end

if size(dataSet,2)>1
    for i=1:length(dataSet)
        if isequal(dname,dataSet{i,2})
            ed = errordlg('Invalid dataset name. The name you entered is already existed.');
            waitfor(ed);
            dname = getDatasetName();
            break;
        end
    end
end
dataName = dname;


% --------------------------------------------------------------------
function menuLoadFieldTripData_Callback(hObject, eventdata, handles)
% hObject    handle to menuLoadFieldTripData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

[filename, pathname]  = uigetfile('*.mat', 'Pick a FieldTrip dataset (.mat file)');
dataDir = fullfile(pathname, filename);

if isequal(filename,0) || isequal(pathname,0)
    disp('Loading canceled...');
else
    dispWait(handles)
    
    load(dataDir);
    dataName = whos('-file',dataDir);
    currentData = currentData + 1;
    dataSet{currentData,1} = eval(dataName.name);
    
    dataSet{currentData,2} = getDatasetName(dataName.name);
    
    dispDatasetInfo(handles);
end


% --------------------------------------------------------------------
function menuLoadEasyMegData_Callback(hObject, eventdata, handles)
% hObject    handle to menuLoadEasyMegData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
global dataSet;
global currentData;

[filename, pathname] = uigetfile('*.mat', 'Pick a EasyMeg dataset (.mat file)');
dataDir = fullfile(pathname, filename);

if isequal(filename,0) || isequal(pathname,0)
    disp('Loading canceled...');
else
    dispWait(handles)
    
    dataName = whos('-file',dataDir);
    if isequal(dataName.name,'dataSet')
        load(dataDir);
        currentData = length(dataSet);

        dispDatasetInfo(handles);
    else
        ed = errordlg('This is not a EasyMEG dataset.');
        waitfor(ed);
        dispDatasetInfo(handles);
    end
end


function menuSaveAsEasyMegData_Callback(hObject, eventdata, handles)
% hObject    handle to menuSaveAsEasyMegData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;

[filename, pathname] = uiputfile('*.mat', 'Save as EasyMEG dataset');
if isequal(filename,0) || isequal(pathname,0)
   disp('Save file canceld.');
else
   dispWait(handles)
   save(fullfile(pathname, filename),'dataSet','-v7.3');
   dispDatasetInfo(handles);
end


% --------------------------------------------------------------------
function menuSaveAsFieldTripData_Callback(hObject, eventdata, handles)
% hObject    handle to menuSaveAsFieldTripData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;

dir = uigetdir('','Pick a folder to save datasets');
if dir~=0
    dispWait(handles);
    for i = 1:length(dataSet)
        eval([dataSet{i,2},'=dataSet{i,1}']);
        try
            save(fullfile(dir,dataSet{i,2}) ,dataSet{i,2},'-v7.3');
        catch me
            errordlg(me.message,'Error');
        end
    end
    dispDatasetInfo(handles);
end


% --------------------------------------------------------------------
function menuFile_Callback(hObject, eventdata, handles)
% hObject    handle to menuSaveAsEasyMegData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuImportData_Callback(hObject, eventdata, handles)
% hObject    handle to menuSaveAsEasyMegData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function dispWait(handles)
% handles    structure with handles and user data (see GUIDATA)
set(handles.panelMain,'Title','Processing...');

set(handles.text1, 'String','');
set(handles.text2, 'String','');
set(handles.text3, 'String','Please wait');
set(handles.text4, 'String','Operation is in progress');
set(handles.text5 ,'String','Do not perform any  operations');
set(handles.text6 ,'String','');
set(handles.text7 ,'String','');
set(handles.text8 ,'String','');
set(handles.text9 ,'String','');

drawnow();


function dispDatasetInfo(handles)
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

if isempty(dataSet)
    set(handles.panelMain,'Title','Please load or import data');
    set(handles.text1, 'String','');
    set(handles.text2, 'String','');
    set(handles.text3, 'String','');
    set(handles.text4, 'String','');
    set(handles.text5 ,'String','');
    set(handles.text6 ,'String','');
    set(handles.text7 ,'String','');
    set(handles.text8 ,'String','');
    set(handles.text9 ,'String','');

else
    set(handles.panelMain,'Title',strcat('Dataset  #',num2str(currentData),'  --',dataSet{currentData,2}));
    set(handles.text1, 'String','');
    set(handles.text2, 'String',['Sampling rate                   ',num2str(dataSet{currentData}.hdr.Fs)]);
    set(handles.text3, 'String',['Number of channels              ',num2str(dataSet{currentData}.hdr.nChans)]);
    set(handles.text4, 'String',['Number of samples               ',num2str(dataSet{currentData}.hdr.nSamples)]);
    set(handles.text5 ,'String',['Number of trails                ',num2str(dataSet{currentData}.hdr.nTrials)]);
    set(handles.text6 ,'String',['Coordsys type                   ',dataSet{currentData}.grad.coordsys]);
    set(handles.text7 ,'String',['Data format                     ',dataSet{currentData}.grad.type]);
    set(handles.text8 ,'String',['Unit                            ',dataSet{currentData}.grad.unit]);
    set(handles.text9 ,'String','');

end

drawnow();


% --------------------------------------------------------------------
function menuPreprocessing_Callback(hObject, eventdata, handles)
% hObject    handle to menuPreprocessing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuLowPass_Callback(hObject, eventdata, handles)
% hObject    handle to menuLowPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('LowPassFilter.m');

% --------------------------------------------------------------------
function menuHighPass_Callback(hObject, eventdata, handles)
% hObject    handle to menuHighPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('HighPassFilter.m');


% --------------------------------------------------------------------
function menuBandPass_Callback(hObject, eventdata, handles)
% hObject    handle to menuBandPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('BandPassFilter.m');


% --------------------------------------------------------------------
function menuBandStop_Callback(hObject, eventdata, handles)
% hObject    handle to menuBandStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('BandStopFilter.m');

% --------------------------------------------------------------------
function menuVisualInspect_Callback(hObject, eventdata, handles)
% hObject    handle to menuVisualInspect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuTrailByTrail_Callback(hObject, eventdata, handles)
% hObject    handle to menuTrailByTrail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

data = dataSet{currentData};
[isOk, base, meg, eeg, ecg, eog, emg]=getAlim();

if isOk
    cfg          = [];
    cfg.method   = 'trial';
    
    if base
        cfg.alim = base;
    end
    if meg
        cfg.megscale = meg;
    end
    if eeg
        cfg.eegscale = eeg;
    end
    if ecg
        cfg.ecgscale = ecg;
    end
    if eog
        cfg.eogscale = eog;
    end
    if emg
        cfg.emgscale = emg;
    end
    
    data = ft_rejectvisual(cfg,data);
    dataSet{currentData} = data;
end


% --------------------------------------------------------------------
function menuChannelByChannel_Callback(hObject, eventdata, handles)
% hObject    handle to menuChannelByChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

data = dataSet{currentData};
[isOk, base, meg, eeg, ecg, eog, emg]=getAlim();

if isOk
    cfg          = [];
    cfg.method   = 'channel';
    
    if base
        cfg.alim = base;
    end
    if meg
        cfg.megscale = meg;
    end
    if eeg
        cfg.eegscale = eeg;
    end
    if ecg
        cfg.ecgscale = ecg;
    end
    if eog
        cfg.eogscale = eog;
    end
    if emg
        cfg.emgscale = emg;
    end
    
    data = ft_rejectvisual(cfg,data);
    dataSet{currentData} = data;
end

% --------------------------------------------------------------------
function MenuBySummary_Callback(hObject, eventdata, handles)
% hObject    handle to MenuBySummary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

data = dataSet{currentData};
[isOk, base, meg, eeg, ecg, eog, emg]=getAlim();

if isOk
    cfg          = [];
    cfg.method   = 'summary';
    
    if base
        cfg.alim = base;
    end
    if meg
        cfg.megscale = meg;
    end
    if eeg
        cfg.eegscale = eeg;
    end
    if ecg
        cfg.ecgscale = ecg;
    end
    if eog
        cfg.eogscale = eog;
    end
    if emg
        cfg.emgscale = emg;
    end
    
    data = ft_rejectvisual(cfg,data);
    dataSet{currentData} = data;
end

% --------------------------------------------------------------------
function menuBrowseMark_Callback(hObject, eventdata, handles)
% hObject    handle to menuBrowseMark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('VisualInspect');
