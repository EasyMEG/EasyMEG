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

% Last Modified by GUIDE v2.5 11-Dec-2016 10:54:25

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
global EasyMEGPath;
global FieldTripPath;

dataSet = [];
currentData = 0;

updateWindow(handles);

% uercfg
EasyMEGPath = mfilename('fullpath');
EasyMEGPath = fileparts(EasyMEGPath);
cd(EasyMEGPath);
path(path, './external/inifile/');
try
    key = {'','','FieldTripPath',''};
    cfgFilePath = fullfile(EasyMEGPath,'config.ini');
    readsett = inifile(cfgFilePath,'read',key);
    FieldTripPath = readsett{1};
    path(path,FieldTripPath);
    ft_defaults;
catch
    FieldTripPath = uigetdir('.','Please set the FieldTrip toolbox directory.');
    cfgFilePath = fullfile(EasyMEGPath,'config.ini');
    if FieldTripPath~=0
        key = {'','','FieldTripPath',FieldTripPath};
        
        inifile(cfgFilePath,'new');
        inifile(cfgFilePath,'write',key,'plain');
        
        path(path,FieldTripPath);
        ft_defaults;
    end
end
    

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

if length(dataSet)>9
    ed = errordlg('You can only have 10 datasets in memory.','Error');
    waitfor(ed);
    return
end

dataDir = uigetdir('.','Pick a CTF data directory');
if dataDir~=0
    dispWait(handles);
    data = [];
  
    % define trial or not
    btnName = questdlg('Define trial now? ', ...
                     'Define trial', ...
                     'Yes','No','Yes');
    switch btnName
        case 'Yes'                       
            cfg = RedefineTrails(dataDir);
            if ~isempty(cfg)
                try
                    cfg = ft_definetrial(cfg);
                    data.data = ft_preprocessing(cfg);
                    data.event = ft_read_event(dataDir);
                    data.name = getDatasetName();
                    
                    currentData = currentData + 1;
                    dataSet{currentData} = data;
                    updateWindow(handles);
                catch ep
                    ed = errordlg(ep.message,'Error');
                    waitfor(ed);
                    updateWindow(handles);
                    return
                end
            end
            
        case 'No'
            % load data without defining trial
            try
                cfg = [];
                cfg.dataset = dataDir;
                data.data = ft_preprocessing(cfg);
                data.event = ft_read_event(dataDir);
                data.name = getDatasetName();
                
                currentData = currentData + 1;
                dataSet{currentData} = data;
                updateWindow(handles);
            catch ep
                ed = errordlg(ep.message,'Error');
                waitfor(ed);
                updateWindow(handles);
            end
    end
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

for i=1:length(dataSet)
    if isfield(dataSet{i},'name')    
        if isequal(dname,dataSet{i}.name)
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

if length(dataSet)>9
    ed = errordlg('You can only have 10 datasets in memory.','Error');
    waitfor(ed);
    return
end

[filename, pathname]  = uigetfile('*.mat', 'Pick a FieldTrip dataset (.mat file)');
dataDir = fullfile(pathname, filename);

if isequal(filename,0) || isequal(pathname,0)
    disp('Loading canceled...');
else
    dispWait(handles);
    
    load(dataDir);
    dataName = whos('-file',dataDir);
    currentData = currentData + 1;
    dataSet{currentData}.data = eval(dataName.name);
    
    dataSet{currentData}.name = getDatasetName(dataName.name);
    
    updateWindow(handles);
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
    dataName = whos('-file',dataDir);
    
    if dataName.size(1)>10
        ed = errordlg('You can only have 10 datasets in memory.','Error');
        waitfor(ed);
        return
    end
    
    dispWait(handles);
    
    if isequal(dataName.name,'dataSet')
        load(dataDir);
        currentData = length(dataSet);

        updateWindow(handles);
    else
        ed = errordlg('This is not a EasyMEG dataset.');
        waitfor(ed);
        updateWindow(handles);
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
   dispWait(handles);
   save(fullfile(pathname, filename),'dataSet','-v7.3');
   updateWindow(handles);
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
        eval([dataSet{i}.name,'=dataSet{i}.data']);
        try
            save(fullfile(dir,dataSet{i}.name) ,dataSet{i}.name,'-v7.3');
        catch me
            ed = errordlg(me.message,'Error');
            waitfor(ed);
            updateWindow(handles);
        end
    end
    updateWindow(handles);
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


function updateWindow(handles)
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;


% display info on the main window
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
    data = dataSet{currentData}.data;
    dataName = dataSet{currentData}.name;
    
    set(handles.panelMain,'Title',strcat('Dataset  #',num2str(currentData),'  --',dataName));
    set(handles.text1, 'String','');
    set(handles.text2, 'String',['Sampling rate                   ',num2str(data.fsample)]);
    set(handles.text3, 'String',['Number of channels              ',num2str(data.hdr.nChans)]);
    set(handles.text4, 'String',['Number of samples               ',num2str(data.hdr.nSamples*data.hdr.nTrials)]);
    set(handles.text5 ,'String',['Number of trails                ',num2str(size(data.trial,2))]);
    set(handles.text6 ,'String',['Coordsys type                   ',data.grad.coordsys]);
    set(handles.text7 ,'String',['Data format                     ',data.grad.type]);
    set(handles.text8 ,'String',['Unit                            ',data.grad.unit]);
    set(handles.text9 ,'String','');

end

% update menu
if isempty(dataSet)
    set(handles.menuPreprocessing,'Enable','Off');
    set(handles.menuDatasets,'Enable','Off');
    set(handles.menuSaveAsFieldTripData,'Enable','Off');
    set(handles.menuSaveAsEasyMegData,'Enable','Off');
    set(handles.menuSensorLevelAnalysis,'Enable','Off');
    set(handles.menuSourceAnalysis,'Enable','Off');
    set(handles.menuImportAnatomyData,'Enable','Off');
    set(handles.menuImportEvent,'Enable','Off');
    set(handles.menuPlot,'Enable','Off');
else
    set(handles.menuPreprocessing,'Enable','On');
    set(handles.menuDatasets,'Enable','On');
    set(handles.menuSaveAsFieldTripData,'Enable','On');
    set(handles.menuSaveAsEasyMegData,'Enable','On');
    set(handles.menuSensorLevelAnalysis,'Enable','On');
    set(handles.menuSourceAnalysis,'Enable','On');
    set(handles.menuImportAnatomyData,'Enable','On');
    set(handles.menuImportEvent,'Enable','On');
    set(handles.menuPlot,'Enable','On');
    
    % delete 'Datasets' menus 
    h = findobj(handles.menuDatasets,'UserData','dataSetList');
    delete(h);
    
    % create new 'Datasets' menus
    for i=1:length(dataSet)
        uimenu(handles.menuDatasets,...
                    'Label',dataSet{i}.name,...
                    'Tag',['cbData',num2str(i)],...
                    'Checked','off',...
                    'Separator','On',...
                    'UserData','dataSetList',...
                    'Callback',@(hObject,eventdata)EasyMEG(['cbData',num2str(i)],guidata(hObject)));
    end
    h = findobj(handles.menuDatasets,'Tag',['cbData',num2str(currentData)]');
    set(h,'Checked','On');
    
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
global dataSet;
global currentData;

[channel , cfg] = LowPassFilter();

if ~isempty(cfg)
    dispWait(handles);
    
    data = dataSet{currentData}.data;
    
    try
        cfg.channel = ft_channelselection(channel,data.label);
        data = ft_preprocessing(cfg,data);
    catch ep
        ed = errordlg(ep.message,'Error');
        waitfor(ed);
        updateWindow(handles);
        return
    end

    dataSet{currentData}.data = data;

    updateWindow(handles);
end



% --------------------------------------------------------------------
function menuHighPass_Callback(hObject, eventdata, handles)
% hObject    handle to menuHighPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

[channel , cfg] = HighPassFilter();

if ~isempty(cfg)
    dispWait(handles);
    
    data = dataSet{currentData}.data;
    
    try
        cfg.channel = ft_channelselection(channel,data.label);
        data = ft_preprocessing(cfg,data);
    catch ep
        ed = errordlg(ep.message,'Error');
        waitfor(ed);
        updateWindow(handles);
        return
    end

    dataSet{currentData}.data = data;

    updateWindow(handles);
end

% --------------------------------------------------------------------
function menuBandPass_Callback(hObject, eventdata, handles)
% hObject    handle to menuBandPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

[channel , cfg] = BandPassFilter();

if ~isempty(cfg)
    dispWait(handles);
    
    data = dataSet{currentData}.data;
    
    try
        cfg.channel = ft_channelselection(channel,data.label);
        data = ft_preprocessing(cfg,data);
    catch ep
        ed = errordlg(ep.message,'Error');
        waitfor(ed);
        updateWindow(handles);
        return
    end
    
    dataSet{currentData}.data = data;

    updateWindow(handles);
end



% --------------------------------------------------------------------
function menuBandStop_Callback(hObject, eventdata, handles)
% hObject    handle to menuBandStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%run('BandStopFilter.m');
global dataSet;
global currentData;

[channel , cfg] = BandStopFilter();

if ~isempty(cfg)
    dispWait(handles);
    
    data = dataSet{currentData}.data;
    
    try
        cfg.channel = ft_channelselection(channel,data.label);
        data = ft_preprocessing(cfg,data);
    catch ep
        ed = errordlg(ep.message,'Error');
        waitfor(ed);
        updateWindow(handles);
        return
    end
    
    dataSet{currentData}.data = data;

    updateWindow(handles);
end


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

data = dataSet{currentData}.data;
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
    dispWait(handles);
    
    try
        data = ft_rejectvisual(cfg,data);
    catch ep
        ed = errordlg(ep.message,'Error');
        waitfor(ed);
        updateWindow(handles);
        return
    end
    
    dataSet{currentData}.data = data;
    updateWindow(handles);

end


% --------------------------------------------------------------------
function menuChannelByChannel_Callback(hObject, eventdata, handles)
% hObject    handle to menuChannelByChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

data = dataSet{currentData}.data;
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
    dispWait(handles);
    
    try
        data = ft_rejectvisual(cfg,data);
    catch ep
        ed = errordlg(ep.message,'Error');
        waitfor(ed);
        updateWindow(handles);
        return
    end
    
    dataSet{currentData}.data = data;
    updateWindow(handles);
end

% --------------------------------------------------------------------
function MenuBySummary_Callback(hObject, eventdata, handles)
% hObject    handle to MenuBySummary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

data = dataSet{currentData}.data;
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
    dispWait(handles);
    try
        data = ft_rejectvisual(cfg,data);
    catch ep
        ed = errordlg(ep.message,'Error');
        waitfor(ed);
        updateWindow(handles);
        return
    end
    dataSet{currentData}.data = data;
    updateWindow(handles);
end

% --------------------------------------------------------------------
function menuBrowseMark_Callback(hObject, eventdata, handles)
% hObject    handle to menuBrowseMark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%run('VisualInspect');
global dataSet;
global currentData;

cfg = VisualInspect();
if ~isempty(cfg)
    dispWait(handles);
    data = dataSet{currentData}.data;
    
    try
        cfg = ft_databrowser(cfg,data);
        data = ft_rejectartifact(cfg, data);
    catch ep
        ed = errordlg(ep.message,'Error');
        waitfor(ed);
        updateWindow(handles);
        return
    end
    
    dataSet{currentData}.data = data;
    updateWindow(handles);
end



% --------------------------------------------------------------------
function menuDatasets_Callback(hObject, eventdata, handles)
% hObject    handle to menuDatasets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function menuRemoveCurrentDataset_Callback(hObject, eventdata, handles)
% hObject    handle to menuRemoveCurrentDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

btnName = questdlg('Remove current dataset?', ...
                     'Remove dataset', ...
                     'Yes','Cancel','Cancel');
if isequal(btnName,'Yes')
    dataSet(currentData) = [];
    currentData = length(dataSet);
end
updateWindow(handles);



% --------------------------------------------------------------------
function menuRemoveAllDatasets_Callback(hObject, eventdata, handles)
% hObject    handle to menuRemoveAllDatasets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

btnName = questdlg('Remove all dataset?', ...
                     'Remove dataset', ...
                     'Yes', 'Cancel','Cancel');
if isequal(btnName,'Yes')
    dataSet = [];
    currentData = 0;
end
updateWindow(handles);

function cbData1(handles)
global currentData;
currentData = 1;
updateWindow(handles);

function cbData2(handles)
global currentData;
currentData = 2;
updateWindow(handles);

function cbData3(handles)
global currentData;
currentData = 3;
updateWindow(handles);

function cbData4(handles)
global currentData;
currentData = 4;
updateWindow(handles);

function cbData5(handles)
global currentData;
currentData = 5;
updateWindow(handles);

function cbData6(handles)
global currentData;
currentData = 6;
updateWindow(handles);

function cbData7(handles)
global currentData;
currentData = 7;
updateWindow(handles);

function cbData8(handles)
global currentData;
currentData = 8;
updateWindow(handles);

function cbData9(handles)
global currentData;
currentData = 9;
updateWindow(handles);

function cbData10(handles)
global currentData;
currentData = 10;
updateWindow(handles);


% --------------------------------------------------------------------
function menuRedefineTrails_Callback(hObject, eventdata, handles)
% hObject    handle to menuRedefineTrails (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuRedefineTrailsEvent_Callback(hObject, eventdata, handles)
% hObject    handle to menuRedefineTrailsEvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;
data = dataSet{currentData}.data;

if ~isempty(data.cfg.previous)
    ed = errordlg('This function need the origin data. You may try to reload this dataset.','Error');
    waitfor(ed);
else
    cfg = RedefineTrails(data.cfg.dataset);
    if ~isempty(cfg)
        dispWait(handles);
        
        try
            cfg = ft_definetrial(cfg);
            data = ft_preprocessing(cfg);
        catch ep
            ed = errordlg(ep.message,'Error');
            waitfor(ed);
            updateWindow(handles);
            return
        end
        dataSet{currentData}.data = data;
        updateWindow(handles);
    end
end

% --------------------------------------------------------------------
function menuSegmentData_Callback(hObject, eventdata, handles)
% hObject    handle to menuSegmentData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

data = dataSet{currentData}.data;

if ~isempty(data.cfg.previous)
    ed = errordlg('This function need the origin data. You may try to reload this dataset.','Error');
    waitfor(ed);
    return
end

if isequal(data.cfg.continuous,'no')
    ed = errordlg('The current dataset is not continuous','Error');
    waitfor(ed);
    return
end

prompt={'Trail length (s):','Overlap (0-1):'};
name='Segment Data';
numlines=1;
defaultanswer={'2','0'};
answer = inputdlg(prompt,name,numlines,defaultanswer);


if ~isempty(answer{1})&&~isempty(answer{2})
    dispWait(handles);
    trailLength = str2double(answer{1});
    overLap = str2double(answer{2});

    if overLap<0||overLap>=1
        ed = errordlg('The value of ''overlap'' must >=0 and <1','Error');
        waitfor(ed);
        updateWindow(handles);
        return
    end
    
    cfg= [];
    cfg.trials = 'all';
    cfg.length  = trailLength;
    cfg.overlap = overLap;

    try
        data = ft_redefinetrial( cfg,data );
    catch ep
        ed = errordlg(ep.message,'Error');
        waitfor(ed);
        updateWindow(handles);
        return
    end
    
    dataSet{currentData}.data = data;
    updateWindow(handles);
end


% --------------------------------------------------------------------
function menuReloadAsContinuous_Callback(hObject, eventdata, handles)
% hObject    handle to menuReloadAsContinuous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

data = dataSet{currentData}.data;

if ~isempty(data.cfg.previous)
    ed = errordlg('This function need the origin data. You may try to reload this dataset.','Error');
    waitfor(ed);
    return
end

if isequal(data.cfg.continuous,'yes')
    ed = errordlg('The current dataset is continuous','Error');
    waitfor(ed);
    return
end

dispWait(handles);

cfg = [];
cfg.continuous = 'yes';
cfg.dataset = data.cfg.dataset;

try
    data = ft_preprocessing(cfg);
catch ep
    ed = errordlg(ep.message,'Error');
    waitfor(ed);
    updateWindow(handles);
    return
end
dataSet{currentData}.data = data;

updateWindow(handles);


% --------------------------------------------------------------------
function menuSensorLevelAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to menuSensorLevelAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuTimeLockAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to menuTimeLockAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

data = dataSet{currentData}.data;

cfg = TimeLockAnalysis();

if isempty(cfg)
    return
end

dispWait(handles);

try
    timelock = ft_timelockanalysis(cfg,data);
catch ep
    ed = errordlg(ep.message,'Error');
    waitfor(ed);
    updateWindow(handles);
    return
end

dataSet{currentData}.timelock = timelock;

updateWindow(handles);


% --------------------------------------------------------------------
function menuTimeFreqAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to menuTimeFreqAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuFreqHanningTapers_Callback(hObject, eventdata, handles)
% hObject    handle to menuFreqHanningTapers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

data = dataSet{currentData}.data;

cfg = TrfHanningTapers();

if isempty(cfg)
    return
end

dispWait(handles);

try
    tfr = ft_freqanalysis(cfg,data);
catch ep
    ed = errordlg(ep.message,'Error');
    waitfor(ed);
    updateWindow(handles);
    return
end

dataSet{currentData}.tfr = tfr;
updateWindow(handles);



% --------------------------------------------------------------------
function menuCorticoMuscularCoherence_Callback(hObject, eventdata, handles)
% hObject    handle to menuCorticoMuscularCoherence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

data = dataSet{currentData}.data;

cfg = CorticoMuscularCoherence();

if isempty(cfg)
    return
end

dispWait(handles);
try
    csd = ft_freqanalysis(cfg,data);
catch ep
    ed = errordlg(ep.message,'Error');
    waitfor(ed);
    updateWindow(handles);
end

cfg                 = [];
cfg.method          = 'coh';
cfg.channelcmb      = {'MEG' 'EMG'};

try
    conn = ft_connectivityanalysis(cfg, csd);
catch ep
    ed = errordlg(ep.message,'Error');
    waitfor(ed);
    updateWindow(handles);
    return
end

dataSet{currentData}.conn = conn;
updateWindow(handles);



% --------------------------------------------------------------------
function menuImportAnatomyData_Callback(hObject, eventdata, handles)
% hObject    handle to menuImportAnatomyData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuMriData_Callback(hObject, eventdata, handles)
% hObject    handle to menuMriData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

data = dataSet{currentData};

if isfield(data,'mri')
    ButtonName = questdlg('The current dataset already has MRI data, import anyway?', ...
                          'Loading MRI data', ...
                          'Yes', 'No', 'No');
    switch ButtonName,
        case 'Yes',
            disp('Removing mri data from current dataset.');
        case 'No',
            disp('Import canceled.')
            return
    end % switch
end

[filename, pathname] = uigetfile('*', 'Pick a MRI datafile (.mri file)');
dataDir = fullfile(pathname, filename);

if isequal(filename,0) || isequal(pathname,0)
    disp('Loading canceled...');
else    
    dispWait(handles);
    
    try
    	mri = ft_read_mri(dataDir);
        % ft_volumereslice to prevent aproblem
        % for detail: http://www.fieldtriptoolbox.org/faq/my_mri_is_upside_down_is_this_a_problem
    	cfg = [];
        mri = ft_volumereslice(cfg, mri);
        data.mri = mri;
        dataSet{currentData} = data;
    catch ep
        ed = errordlg(ep.message,'Error');
        waitfor(ed);
    end
    updateWindow(handles);
end


% --------------------------------------------------------------------
function menuHeadModel_Callback(hObject, eventdata, handles)
% hObject    handle to menuHeadModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;
data = dataSet{currentData};

if isfield(data,'headmodel')
    ButtonName = questdlg('The current dataset already has headmodel, import anyway?', ...
                          'Loading headmodel', ...
                          'Yes', 'No', 'No');
    switch ButtonName,
        case 'Yes',
            disp('Removing headmodel from current dataset.');
        case 'No',
            disp('Import canceled.')
            return
    end % switch
end

[filename, pathname]  = uigetfile('*.mat', 'Pick a FieldTrip Headmodel (.mat file)');
dataDir = fullfile(pathname, filename);

if isequal(filename,0) || isequal(pathname,0)
    disp('Loading canceled...');
else
    dispWait(handles);
    
    load(dataDir);
    dataName = whos('-file',dataDir);
    data.headmodel = eval(dataName.name);
    
    dataSet{currentData} = data;
        
    updateWindow(handles);
end


% --------------------------------------------------------------------
function menuSourceModel_Callback(hObject, eventdata, handles)
% hObject    handle to menuSourceModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;
data = dataSet{currentData};

if isfield(data,'sourcemodel')
    ButtonName = questdlg('The current dataset already has sourcemodel, import anyway?', ...
                          'Load sourcemodel', ...
                          'Yes', 'No', 'No');
    switch ButtonName,
        case 'Yes',
            disp('Removing sourcemodel from current dataset.');
        case 'No',
            disp('Import canceled.')
            return
    end % switch
end

[filename, pathname]  = uigetfile('*.mat', 'Pick a FieldTrip sourcemodel (.mat file)');
dataDir = fullfile(pathname, filename);

if isequal(filename,0) || isequal(pathname,0)
    disp('Loading canceled...');
else
    dispWait(handles);
    
    load(dataDir);
    dataName = whos('-file',dataDir);
    data.sourcemodel = eval(dataName.name);
    
    dataSet{currentData} = data;
        
    updateWindow(handles);
end


% --------------------------------------------------------------------
function menuSourceAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to menuSourceAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuCreateHeadmodel_Callback(hObject, eventdata, handles)
% hObject    handle to menuCreateHeadmodel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet
global currentData

data = dataSet{currentData}

if ~isfield(data,'mri')
    ed = errordlg('Cannot find MRI data in current dataset, you must import MRI data first.');
    waitfor(ed);
    return
end

dispWait(handles);

mri = data.mri;

cfg = [];
cfg.output = 'brain';

try
    segmentedmri = ft_volumesegment(cfg, mri);
catch ep
    ed = errordlg(ep.message,'Error');
    waitfor(ed);
    updateWindow(handles);
    return
end

ButtonName = questdlg('Please select the method for headmodel constructing:', ...
                       'Headmodel', ...
                       'singlesphere', 'localspheres', 'singleshell', 'singleshell');
switch ButtonName,
	case 'singlesphere',
        cfg = [];
        cfg.method = 'singlesphere';
        try
            headmodel = ft_prepare_headmodel(cfg, segmentedmri);
        catch ep
            ed = errordlg(ep.message,'Error');
            waitfor(ed);
            updateWindow(handles);
            return
        end
	case 'localspheres',
        cfg = [];
        cfg.grad = data.grad;
        cfg.method = 'localspheres';
        try
            headmodel = ft_prepare_headmodel(cfg, segmentedmri);
        catch ep
            ed = errordlg(ep.message,'Error');
            waitfor(ed);
            updateWindow(handles);
            return
        end
    case 'singleshell',
        cfg = [];
        cfg.method = 'singleshell';
        try
            headmodel = ft_prepare_headmodel(cfg, segmentedmri);
        catch ep
            ed = errordlg(ep.message,'Error');
            waitfor(ed);
            updateWindow(handles);
            return
        end
           
end % switch

data.headmodel = headmodel;
dataSet{currentData} = data;
updateWindow(handles);


% --------------------------------------------------------------------
function menuCoregisterMriToMeg_Callback(hObject, eventdata, handles)
% hObject    handle to menuCoregisterMriToMeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet
global currentData
data = dataSet{currentData};

if ~isfield(data,'mri')
    ed = errordlg('Cannot find MRI data in current dataset, you must import MRI data first.');
    waitfor(ed);
    return
end

mri = data.mri;

try
    cfg = [];
    cfg.method = 'interactive';
    
    % help message    
    web('/documents/help-CoregisterMRItoMEG.html');
    
    % coordsys should match the MEG dataset
    cfg.coordsys = 'ctf';
    mri_realigned = ft_volumerealign(cfg,mri);
    
    data.mri = mri_realigned;
    dataSet{currentData} = data;
catch ep
    ed = errordlg(ep.message,'Error');
    waitfor(ed);
end


% --------------------------------------------------------------------
function menuCreateSourcemodel_Callback(hObject, eventdata, handles)
% hObject    handle to menuCreateSourcemodel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet
global currentData
global FieldTripPath

data = dataSet{currentData};

if ~isfield(data,'mri')
    ed = errordlg('Cannot find MRI data in current dataset, you must import MRI data first.');
    waitfor(ed);
    return
end

[useTemplate, cfg0] = SourceModel();
mri = data.mri;

if useTemplate
    templatePath = cfg0.templatePath;
    
    try
        load(templatePath);
        templateName = whos('-file',templatePath);
        template = eval(templateName.name);

        cfg                = [];
        cfg.grid.warpmni   = 'yes';
        cfg.grid.template  = template;
        cfg.grid.nonlinear = 'yes'; % use non-linear normalization
        cfg.mri            = mri;
        cfg.grid.unit      ='mm';
        data.sourcemodel   = ft_prepare_sourcemodel(cfg);
        
        dataSet{currentData} = data;
    catch ep
        ed = errordlg(ep.message, 'Error');
        waitfor(ed);
    end
else
    template = ft_read_mri(fullfile(FieldTripPath, '/external/spm8/templates/T1.nii'));
    template.coordsys = 'spm';

    % segment the template brain and construct a volume conduction model (i.e. head model): 
    % this is needed to describe the boundary that define which dipole locations are 'inside' the brain.
    cfg          = [];
    template_seg = ft_volumesegment(cfg, template);

    cfg          = [];
    cfg.method   = 'singleshell';
    template_headmodel = ft_prepare_headmodel(cfg, template_seg);
    template_headmodel = ft_convert_units(template_headmodel, 'cm'); % Convert the vol to cm, because the CTF convenction is to express everything in cm.

    % construct the dipole grid in the template brain coordinates
    % the negative inwardshift means an outward shift of the brain surface for inside/outside detection
    cfg = [];
    cfg.grid.resolution = cfg0.resolution;
    cfg.grid.tight  = 'yes';
    cfg.inwardshift = cfg0.inwardshift;
    cfg.moveinward  = cfg0.moveinward;
    cfg.headmodel   = template_headmodel;
    template_grid   = ft_prepare_sourcemodel(cfg);
   

    cfg                = [];
    cfg.grid.warpmni   = 'yes';
    cfg.grid.template  = template_grid;
    cfg.grid.nonlinear = 'yes'; % use non-linear normalization
    cfg.mri            = mri;
    cfg.grid.unit      ='mm';
    data.sourcemodel   = ft_prepare_sourcemodel(cfg);
    
    dataSet{currentData} = data;
end




% --------------------------------------------------------------------
function menuFilters_Callback(hObject, eventdata, handles)
% hObject    handle to menuFilters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuImportEvent_Callback(hObject, eventdata, handles)
% hObject    handle to menuImportEvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuCTFEvent_Callback(hObject, eventdata, handles)
% hObject    handle to menuCTFEvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;
data = dataSet{currentData};

if isfield(data,'event')
    ButtonName = questdlg('The current dataset already has event, import anyway?', ...
                          'Load event', ...
                          'Yes', 'No', 'No');
    switch ButtonName,
        case 'Yes',
            disp('Removing event from current dataset.');
        case 'No',
            disp('Import canceled.')
            return
    end % switch
end

dataDir = uigetdir('.','Pick a CTF dataset (.ds floder)');

if ~dataDir
    disp('Loading canceled...');
else
    dispWait(handles);
    
    try
        event = ft_read_event(dataDir);
        data.event = event;
        dataSet{currentData} = data;
        updateWindow(handles);
    catch ep
        ed = errordlg(ep.message,'Error');
        waitfor(ed);
    end
end


% --------------------------------------------------------------------
function menuViewHeadmodel_Callback(hObject, eventdata, handles)
% hObject    handle to menuViewHeadmodel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;
data = dataSet{currentData};

if ~isfield(data,'headmodel')
    ed = errordlg('Cannot find headmodel, you need to create headmodel first.','Error');
    waitfor(ed);
    return
end
    
dataDir = uigetdir('.','Import sensors, please select the original data floder.');

if ~dataDir
    disp('Loading canceled...');
else    
    try
        sens = ft_read_sens(dataDir);
        sens = ft_convert_units(sens,'mm');

        figure
        ft_plot_sens(sens, 'style', 'r*');

        hold on
        ft_plot_vol(data.headmodel);
    catch ep
        ed = errordlg(ep.message,'Error');
        waitfor(ed);
    end
end


% --------------------------------------------------------------------
function menuViewSourcemodel_Callback(hObject, eventdata, handles)
% hObject    handle to menuViewSourcemodel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;
data = dataSet{currentData};

if ~isfield(data,'sourcemodel')
    ed = errordlg('Cannot find sourcemodel, you need to create or import sourcemodel first.','Error');
    waitfor(ed);
    return
end

if ~isfield(data,'headmodel')
    ed = errordlg('Cannot find headmodel, you need to create or import headmodel first.','Error');
    waitfor(ed);
    return
end
    
try
    headmodel = ft_convert_units(data.headmodel,'mm');
    sourcemodel = ft_convert_units(data.sourcemodel,'mm');

    figure
    hold on
    ft_plot_vol(headmodel, 'facecolor', 'cortex', 'edgecolor', 'none');
    alpha 0.5;
    camlight;
    ft_plot_mesh(sourcemodel.pos(sourcemodel.inside,:));
catch ep
    ed = errordlg(ep.message,'Error');
    waitfor(ed);
end


% --------------------------------------------------------------------
function menuNeuromagData_Callback(hObject, eventdata, handles)
% hObject    handle to menuNeuromagData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

if length(dataSet)>9
    ed = errordlg('You can only have 10 datasets in memory.','Error');
    waitfor(ed);
    return
end

dataDir = uigetdir('.','Pick a Neuromag data directory');
if dataDir~=0
    dispWait(handles);
    data = [];
  
    % define trial or not
    btnName = questdlg('Define trial now? ', ...
                     'Define trial', ...
                     'Yes','No','Yes');
    switch btnName
        case 'Yes'                       
            cfg = RedefineTrails(dataDir);
            if ~isempty(cfg)
                try
                    cfg = ft_definetrial(cfg);
                    data.data = ft_preprocessing(cfg);
                    data.event = ft_read_event(dataDir);
                    data.name = getDatasetName();
                    
                    currentData = currentData + 1;
                    dataSet{currentData} = data;
                    updateWindow(handles);
                catch ep
                    ed = errordlg(ep.message,'Error');
                    waitfor(ed);
                    updateWindow(handles);
                    return
                end
            end
            
        case 'No'
            % load data without defining trial
            try
                cfg = [];
                cfg.dataset = dataDir;
                data.data = ft_preprocessing(cfg);
                data.event = ft_read_event(dataDir);
                data.name = getDatasetName();
                
                currentData = currentData + 1;
                dataSet{currentData} = data;
                updateWindow(handles);
            catch ep
                ed = errordlg(ep.message,'Error');
                waitfor(ed);
                updateWindow(handles);
            end
    end
end

% --------------------------------------------------------------------
function menuBTiData_Callback(hObject, eventdata, handles)
% hObject    handle to menuBTiData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

if length(dataSet)>9
    ed = errordlg('You can only have 10 datasets in memory.','Error');
    waitfor(ed);
    return
end

dataDir = uigetdir('.','Pick a BTi data directory');
if dataDir~=0
    dispWait(handles);
    data = [];
  
    % define trial or not
    btnName = questdlg('Define trial now? ', ...
                     'Define trial', ...
                     'Yes','No','Yes');
    switch btnName
        case 'Yes'                       
            cfg = RedefineTrails(dataDir);
            if ~isempty(cfg)
                try
                    cfg = ft_definetrial(cfg);
                    data.data = ft_preprocessing(cfg);
                    data.event = ft_read_event(dataDir);
                    data.name = getDatasetName();
                    
                    currentData = currentData + 1;
                    dataSet{currentData} = data;
                    updateWindow(handles);
                catch ep
                    ed = errordlg(ep.message,'Error');
                    waitfor(ed);
                    updateWindow(handles);
                    return
                end
            end
            
        case 'No'
            % load data without defining trial
            try
                cfg = [];
                cfg.dataset = dataDir;
                data.data = ft_preprocessing(cfg);
                data.event = ft_read_event(dataDir);
                data.name = getDatasetName();
                
                currentData = currentData + 1;
                dataSet{currentData} = data;
                updateWindow(handles);
            catch ep
                ed = errordlg(ep.message,'Error');
                waitfor(ed);
                updateWindow(handles);
            end
    end
end

% --------------------------------------------------------------------
function menuYokogawaData_Callback(hObject, eventdata, handles)
% hObject    handle to menuYokogawaData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;

if length(dataSet)>9
    ed = errordlg('You can only have 10 datasets in memory.','Error');
    waitfor(ed);
    return
end

dataDir = uigetdir('.','Pick a Yokogawa data directory');
if dataDir~=0
    dispWait(handles);
    data = [];
  
    % define trial or not
    btnName = questdlg('Define trial now? ', ...
                     'Define trial', ...
                     'Yes','No','Yes');
    switch btnName
        case 'Yes'                       
            cfg = RedefineTrails(dataDir);
            if ~isempty(cfg)
                try
                    cfg = ft_definetrial(cfg);
                    data.data = ft_preprocessing(cfg);
                    data.event = ft_read_event(dataDir);
                    data.name = getDatasetName();
                    
                    currentData = currentData + 1;
                    dataSet{currentData} = data;
                    updateWindow(handles);
                catch ep
                    ed = errordlg(ep.message,'Error');
                    waitfor(ed);
                    updateWindow(handles);
                    return
                end
            end
            
        case 'No'
            % load data without defining trial
            try
                cfg = [];
                cfg.dataset = dataDir;
                data.data = ft_preprocessing(cfg);
                data.event = ft_read_event(dataDir);
                data.name = getDatasetName();
                
                currentData = currentData + 1;
                dataSet{currentData} = data;
                updateWindow(handles);
            catch ep
                ed = errordlg(ep.message,'Error');
                waitfor(ed);
                updateWindow(handles);
            end
    end
end


% --------------------------------------------------------------------
function menuFT_multiplotER_Callback(hObject, eventdata, handles)
% hObject    handle to menuFT_multiplotER (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;

[cfg,data] = MultiPlotER();
if isempty(data)
    ed = warndlg('No data in Plot List, ploting cancel.','Error');
    waitfor(ed);
    return
end

dispWait(handles);

dataPlot = [];
for i = 1:size(data,1)
    dataPlot{i} = eval(['dataSet{data{i,1}}.',data{i,2}]);
end

strDataPlot = 'dataPlot{1}';
for i = 2:length(dataPlot)
    strDataPlot = [strDataPlot,',dataPlot{',num2str(i),'}'];
end


try
    figure;
    eval(['ft_multiplotER(cfg,',strDataPlot,');']);
catch ep
    ed = errordlg(ep.message,'Error');
    waitfor(ed);
end

updateWindow(handles);




% --------------------------------------------------------------------
function menuFT_SinglePlotER_Callback(hObject, eventdata, handles)
% hObject    handle to menuFT_SinglePlotER (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;

[cfg,data] = SinglePlotER();
if isempty(data)
    ed = warndlg('No data in Plot List, ploting cancel.','Error');
    waitfor(ed);
    return
end

dispWait(handles);

dataPlot = [];
for i = 1:size(data,1)
    dataPlot{i} = eval(['dataSet{data{i,1}}.',data{i,2}]);
end

strDataPlot = 'dataPlot{1}';
for i = 2:length(dataPlot)
    strDataPlot = [strDataPlot,',dataPlot{',num2str(i),'}'];
end


try
    figure;
    eval(['ft_singleplotER(cfg,',strDataPlot,');']);
catch ep
    ed = errordlg(ep.message,'Error');
    waitfor(ed);
end

updateWindow(handles);


% --------------------------------------------------------------------
function menuFT_topoplotER_Callback(hObject, eventdata, handles)
% hObject    handle to menuFT_topoplotER (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;

[cfg,idx,dataName] = TopoPlotER();
if isempty(idx)
    ed = warndlg('No data in Plot List, ploting cancel.','Error');
    waitfor(ed);
    return
end
disp(dataName)
disp(['dataSet{idx}.',dataName]);
data = eval(['dataSet{idx}.',dataName]);

try
    figure;
    ft_topoplotER(cfg,data);
catch ep
    ed = errordlg(ep.message,'Error');
    waitfor(ed);
end

updateWindow(handles);


% --------------------------------------------------------------------
function menuMTMFFT_Callback(hObject, eventdata, handles)
% hObject    handle to menuMTMFFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataSet;
global currentData;
data = dataSet{currentData};

cfg = FreqMTMFFT();

if isempty(cfg)
    return
end

dispWait(handles);

try
    cfg.method = 'mtmfft';
    timefreq = ft_freqanalysis(cfg,data.data);
    data.timefreq = timefreq;
    dataSet{currentData} = data;
catch ep
    ed = errordlg(ep.message,'Error');
    waitfor(ed);
end

updateWindow(handles);


% --------------------------------------------------------------------
function menuMTMCONVOL_Callback(hObject, eventdata, handles)
% hObject    handle to menuMTMCONVOL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuWAVELET_Callback(hObject, eventdata, handles)
% hObject    handle to menuWAVELET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuTRF_Callback(hObject, eventdata, handles)
% hObject    handle to menuTRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuMVAR_Callback(hObject, eventdata, handles)
% hObject    handle to menuMVAR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
