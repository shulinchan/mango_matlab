function varargout = mangoGui(varargin)
% MANGOGUI MATLAB code for mangoGui.fig
%      MANGOGUI, by itself, creates a new MANGOGUI or raises the existing
%      singleton*.
%
%      H = MANGOGUI returns the handle to a new MANGOGUI or the handle to
%      the existing singleton*.
%
%      MANGOGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MANGOGUI.M with the given input arguments.
%
%      MANGOGUI('Property','Value',...) creates a new MANGOGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mangoGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mangoGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mangoGui

% Last Modified by GUIDE v2.5 28-Apr-2018 15:48:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mangoGui_OpeningFcn, ...
                   'gui_OutputFcn',  @mangoGui_OutputFcn, ...
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


% --- Executes just before mangoGui is made visible.
function mangoGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mangoGui (see VARARGIN)

% Choose default command line output for mangoGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mangoGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mangoGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    input1 = get(handles.edit1,'String'); %edit1 being Tag of ur edit box
    input2 = get(handles.edit2,'String');
    if isempty(input1) || isempty(input2)
        %handles.errorText = 'Please enter text in both fields';
        set(handles.errorText,'string','Please enter text in both fields');
        set(handles.text6,'string','');
        set(handles.text7,'string','');
    else
        set(handles.errorText,'string','');
        results = single_mango(input1,input2);
        
        %set results
        if results(1,2) == 1
            set(handles.text6,'string','Defected');
        else
            set(handles.text6,'string','Not Defected');
        end
       
        if results(1,1) == 1
            set(handles.text7,'string','Mature');
        else
            set(handles.text7,'string','Immature');
        end
        
        set(handles.text20,'string',results(1,3));
        set(handles.text21,'string',round(results(1,4)));
        set(handles.text22,'string',round(results(1,5)));
        set(handles.text23,'string',round(results(1,6)));
        set(handles.text24,'string',round(results(1,7)));
        set(handles.text25,'string',round(results(1,8)));
        set(handles.text26,'string',round(results(1,9)));
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
