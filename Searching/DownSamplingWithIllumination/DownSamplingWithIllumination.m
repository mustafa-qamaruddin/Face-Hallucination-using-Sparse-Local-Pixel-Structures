function varargout = DownSamplingWithIllumination(varargin)
% DOWNSAMPLINGWITHILLUMINATION MATLAB code for DownSamplingWithIllumination.fig
%      DOWNSAMPLINGWITHILLUMINATION, by itself, creates a new DOWNSAMPLINGWITHILLUMINATION or raises the existing
%      singleton*.
%
%      H = DOWNSAMPLINGWITHILLUMINATION returns the handle to a new DOWNSAMPLINGWITHILLUMINATION or the handle to
%      the existing singleton*.
%
%      DOWNSAMPLINGWITHILLUMINATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DOWNSAMPLINGWITHILLUMINATION.M with the given input arguments.
%
%      DOWNSAMPLINGWITHILLUMINATION('Property','Value',...) creates a new DOWNSAMPLINGWITHILLUMINATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DownSamplingWithIllumination_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DownSamplingWithIllumination_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DownSamplingWithIllumination

% Last Modified by GUIDE v2.5 12-Jun-2016 02:57:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DownSamplingWithIllumination_OpeningFcn, ...
                   'gui_OutputFcn',  @DownSamplingWithIllumination_OutputFcn, ...
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


% --- Executes just before DownSamplingWithIllumination is made visible.
function DownSamplingWithIllumination_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DownSamplingWithIllumination (see VARARGIN)

% Choose default command line output for DownSamplingWithIllumination
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DownSamplingWithIllumination wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DownSamplingWithIllumination_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Folder = uigetdir();
 set(handles.edit1,'string',Folder);
 image_files = dir(strcat(Folder, '\*.bmp'));
 num_files = length(image_files);
 OutVideoDir = 'E:\semesters\Graduationproject\FinalProjectGPGit\Searching\DownSamplingWithIllumination\K_LowResolutionwithIllumination';
 user_input = str2double(get(handles.edit2,'string'));
 for i = 1:num_files
     file_name = image_files(i).name;
     handles.training_image{i} = imread(strcat(Folder ,'\', file_name));
     handles.down_image{i} = imresize(handles.training_image{i},user_input);
     baseFileName = sprintf('%d.bmp', i); % e.g. "1.png"
     fullFileName = fullfile(OutVideoDir, baseFileName);
     img = rgb2gray(handles.down_image{i});
     IlluminImg = mat2gray(wavelet_normalization(img));
     imwrite(IlluminImg, fullFileName);
 end
 set(handles.listbox1,'string',{image_files.name});
 guidata(hObject,handles);




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
index = get(handles.listbox1,'value');
im = rgb2gray(handles.down_image{index});
imshow(mat2gray(wavelet_normalization(im)));
guidata(hObject, handles);

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
