function varargout = gui_workspace(varargin)
% GUI_3DVIWER MATLAB code for gui_3dviwer.fig
%      GUI_3DVIWER, by itself, creates a new GUI_3DVIWER or raises the existing
%      singleton*.
%
%      H = GUI_3DVIWER returns the handle to a new GUI_3DVIWER or the handle to
%      the existing singleton*.
%
%      GUI_3DVIWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_3DVIWER.M with the given input arguments.
%
%      GUI_3DVIWER('Property','Value',...) creates a new GUI_3DVIWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_3dviwer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_3dviwer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_3dviwer

% Last Modified by GUIDE v2.5 03-Jun-2015 15:34:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_workspace_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_workspace_OutputFcn, ...
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


% --- Executes just before gui_3dviwer is made visible.
function gui_workspace_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_3dviwer (see VARARGIN)

% Choose default command line output for gui_3dviwer

% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

global vBody; global vS0_L; global vS0_R; global vS1_L; global vS1_R;
global vE0_L; global vE0_R;  global vE1_L; global vE1_R; global vW0_L;
global vW0_R; global vW1_L;  global vW1_R; global vW2_L; global vW2_R;
global HS0_L;  global HS0_R; global HS1; global HE0; global HE1;
global HW0; global HW1; global HW2; global HEndEff;

vBody = stlread('baxter_body.STL');
vS0_L = stlread('S0.STL');
vS0_R = stlread('S0.STL');
vS1_L = stlread('S1.STL');
vS1_R = stlread('S1.STL');
vE0_L = stlread('E0.STL');
vE0_R = stlread('E0.STL');
vE1_L = stlread('E1.STL');
vE1_R = stlread('E1.STL');
vW0_L = stlread('W0.STL');
vW0_R = stlread('W0.STL');
vW1_L = stlread('W1.STL');
vW1_R = stlread('W1.STL');
vW2_L = stlread('W2.STL');
vW2_R = stlread('W2.STL');

% translation / rotate to normal position
vBody.vertices = ones(length(vBody.vertices), 1) * [-500 -500 0] +  vBody.vertices;
vS0_R.vertices = ones(length(vS0_R.vertices), 1) * [-115 -115 -1082] + vS0_R.vertices;
vS0_L.vertices = ones(length(vS0_L.vertices), 1) * [-115 -115 -1082] + vS0_L.vertices;
vS1_R.vertices = ones(length(vS1_R.vertices), 1) * [-115 -140 -174.87] + vS1_R.vertices;
vS1_L.vertices = ones(length(vS1_L.vertices), 1) * [-115 -140 -174.87] + vS1_L.vertices;
vE0_R.vertices = (ones(length(vE0_R.vertices), 1) * [-124.6191 -121.9409 0] + vE0_R.vertices) * rotx(180);
vE0_L.vertices = (ones(length(vE0_L.vertices), 1) * [-124.6191 -121.9409 0] + vE0_L.vertices) * rotx(180);
vE1_R.vertices = (ones(length(vE1_R.vertices), 1) * [-115 -115.01 -62.1653] + vE1_R.vertices) * rotz(-90);
vE1_L.vertices = (ones(length(vE1_L.vertices), 1) * [-115 -115.01 -62.1653] + vE1_L.vertices) * rotz(90);
vW0_R.vertices = (ones(length(vW0_R.vertices), 1) * [-115 -115.2681 0] + vW0_R.vertices);
vW0_L.vertices = (ones(length(vW0_L.vertices), 1) * [-115 -115.2681 0] + vW0_L.vertices);
vW1_R.vertices = (ones(length(vW1_R.vertices), 1) * [-65.3227 -75 -65] + vW1_R.vertices);
vW1_L.vertices = (ones(length(vW1_L.vertices), 1) * [-65.3227 -75 -65] + vW1_L.vertices);
vW2_R.vertices = (ones(length(vW2_R.vertices), 1) * [-35 -35 0] + vW2_R.vertices);
vW2_L.vertices = (ones(length(vW2_L.vertices), 1) * [-35 -35 0] + vW2_L.vertices);

vvS0_L = zeros(size(vS0_L.vertices));
vvS1_L = zeros(size(vS1_L.vertices));
vvE0_L = zeros(size(vE0_L.vertices));
vvE1_L = zeros(size(vE1_L.vertices));
vvW0_L = zeros(size(vW0_L.vertices));
vvW1_L = zeros(size(vW1_L.vertices));
vvW2_L = zeros(size(vW2_L.vertices));
vvS0_R = zeros(size(vS0_R.vertices));
vvS1_R = zeros(size(vS1_R.vertices));
vvE0_R = zeros(size(vE0_R.vertices));
vvE1_R = zeros(size(vE1_R.vertices));
vvW0_R = zeros(size(vW0_R.vertices));
vvW1_R = zeros(size(vW1_R.vertices));
vvW2_R = zeros(size(vW2_R.vertices));


%HS0_R = [1 0 0 -355; 0 1 0 -45; 0 0 1 58; 0 0 0 1];
%HS1 = [0 0 1 0; 0 1 0 0; -1 0 0 1342; 0 0 0 1];
HS0_L = [-1 0 0 278; 0 -1 0 64; 0 0 1 1104; 0 0 0 1];
HS0_R = [1 0 0 -355; 0 1 0 -45; 0 0 1 1140; 0 0 0 1];
HS1 = [0 0 1 0; 0 1 0 0; -1 0 0 260; 0 0 0 1];
HE0 = [1 0 0 0; 0 1 0 0; 0 0 1 -165; 0 0 0 1];
HE1 = [-1 0 0 95; 0 1 0 0; 0 0 -1 -297.5; 0 0 0 1];
HW0 = [1 0 0 0; 0 1 0 0; 0 0 1 120; 0 0 0 1];
HW1 = [1 0 0 0; 0 1 0 0; 0 0 1 419; 0 0 0 1];
HW2 = [1 0 0 0; 0 1 0 0; 0 0 1 220; 0 0 0 1];

h = HS0_R * [vS0_R.vertices'; ones(1,length(vS0_R.vertices))];
vvS0_R = h(1:3, :)';

H = HS0_R * HS1;
h = H * [vS1_R.vertices'; ones(1,length(vS1_R.vertices))];
vvS1_R = h(1:3, :)';

H = H * HE0;
h = H * [vE0_R.vertices'; ones(1,length(vE0_R.vertices))];
vvE0_R = h(1:3, :)';

H = H * HE1;
h = H * [vE1_R.vertices'; ones(1,length(vE1_R.vertices))];
vvE1_R = h(1:3, :)';

H = H * HW0;
h = H * [vW0_R.vertices'; ones(1,length(vW0_R.vertices))];
vvW0_R = h(1:3, :)';

H = H * HW1;
h = H * [vW1_R.vertices'; ones(1,length(vW1_R.vertices))];
vvW1_R = h(1:3, :)';

H = H * HW2;
h = H * [vW2_R.vertices'; ones(1,length(vW2_R.vertices))];
vvW2_R = h(1:3, :)';
HEndEff = zeros(2,3);
HEndEff(1,:) = H(1:3, end)';

h = HS0_L * [vS0_L.vertices'; ones(1,length(vS0_L.vertices))];
vvS0_L = h(1:3, :)';

H = HS0_L * HS1;
h = H * [vS1_L.vertices'; ones(1,length(vS1_L.vertices))];
vvS1_L = h(1:3, :)';

H = H * HE0;
h = H * [vE0_L.vertices'; ones(1,length(vE0_L.vertices))];
vvE0_L = h(1:3, :)';

H = H * HE1;
h = H * [vE1_L.vertices'; ones(1,length(vE1_L.vertices))];
vvE1_L = h(1:3, :)';

H = H * HW0;
h = H * [vW0_L.vertices'; ones(1,length(vW0_L.vertices))];
vvW0_L = h(1:3, :)';

H = H * HW1;
h = H * [vW1_L.vertices'; ones(1,length(vW1_L.vertices))];
vvW1_L = h(1:3, :)';

H = H * HW2;
h = H * [vW2_L.vertices'; ones(1,length(vW2_L.vertices))];
vvW2_L = h(1:3, :)';
HEndEff(2, :) = H(1:3, end)';

handles.output = hObject;
load('workspace.mat');
handles.px = px;
handles.py = py;
handles.pz = pz;
handles.vvS0_L = vvS0_L;
handles.vvS1_L = vvS1_L;
handles.vvE0_L = vvE0_L;
handles.vvE1_L = vvE1_L;
handles.vvW0_L = vvW0_L;
handles.vvW1_L = vvW1_L;
handles.vvW2_L = vvW2_L;
handles.vvS0_R = vvS0_R;
handles.vvS1_R = vvS1_R;
handles.vvE0_R = vvE0_R;
handles.vvE1_R = vvE1_R;
handles.vvW0_R = vvW0_R;
handles.vvW1_R = vvW1_R;
handles.vvW2_R = vvW2_R;
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes gui_3dviwer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_workspace_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
% --- Executes during object creation, after setting all properties.
global vBody; global vS0_L; global vS0_R; global vS1_L; global vS1_R;
global vE0_L; global vE0_R;  global vE1_L; global vE1_R; global vW0_L;
global vW0_R; global vW1_L;  global vW1_R; global vW2_L; global vW2_R;

% fv.vertices = fv.vertices - 500;
hBody = patch(vBody, 'FaceColor', [0.8 0.8 1], 'EdgeColor', 'none');
hS0_L = patch(vS0_L, 'FaceColor', [0.8 0.2 0.2], 'EdgeColor', 'none');
hS0_R = patch(vS0_R, 'FaceColor', [0.8 0.2 0.2], 'EdgeColor', 'none');
hS1_L = patch(vS1_L, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hS1_R = patch(vS1_R, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hE0_L = patch(vE0_L, 'FaceColor', [0.2 0.8 0.8], 'EdgeColor', 'none');
hE0_R = patch(vE0_R, 'FaceColor', [0.2 0.8 0.8], 'EdgeColor', 'none');
hE1_L = patch(vE1_L, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hE1_R = patch(vE1_R, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hW0_L = patch(vW0_L, 'FaceColor', [0.8 0.2 0.2], 'EdgeColor', 'none');
hW0_R = patch(vW0_R, 'FaceColor', [0.8 0.2 0.2], 'EdgeColor', 'none');
hW1_L = patch(vW1_L, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hW1_R = patch(vW1_R, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hW2_L = patch(vW2_L, 'FaceColor', [0.2 0.8 0.2], 'EdgeColor', 'none');
hW2_R = patch(vW2_R, 'FaceColor', [0.2 0.8 0.2], 'EdgeColor', 'none');
hold on;
hTarget = [0 0];
hTarget(1) = plot3(0,0,0,'y.', 'MarkerSize', 30);
hTarget(2) = plot3(0,0,0,'r.', 'MarkerSize', 30);
hWorkspace = plot3(0,0,0, 'w.');
% Light and Default View
camlight('headlight');
material('dull');
view([20, 30]);
axis([-2000 2000 -2000 2000 0 2500]);
grid on;
data = guidata(hObject);
set(hS0_R, 'Vertices', data.vvS0_R);
set(hS1_R, 'Vertices', data.vvS1_R);
set(hE0_R, 'Vertices', data.vvE0_R);
set(hE1_R, 'Vertices', data.vvE1_R);
set(hW0_R, 'Vertices', data.vvW0_R);
set(hW1_R, 'Vertices', data.vvW1_R);
set(hW2_R, 'Vertices', data.vvW2_R);

set(hS0_L, 'Vertices', data.vvS0_L);
set(hS1_L, 'Vertices', data.vvS1_L);
set(hE0_L, 'Vertices', data.vvE0_L);
set(hE1_L, 'Vertices', data.vvE1_L);
set(hW0_L, 'Vertices', data.vvW0_L);
set(hW1_L, 'Vertices', data.vvW1_L);
set(hW2_L, 'Vertices', data.vvW2_L);
set(hWorkspace, 'XData', data.px, 'YData', data.py, 'ZData', data.pz, 'MarkerSize', 1);
%% build workspace
%{
px = zeros(2e7+2,1);
py = zeros(2e7+2,1);
pz = zeros(2e7+2,1);
h1 = HS0_L;
h1r = HS0_R;
h2 = HS1;
h3 = HE0;
h4 = HE1;
h5 = HW0;
h6 = HW1;
h7 = HW2;
hend = HEND;
c = 1;
N = 5;
for q1 = linspace(-141,51,N)
  H1L = h1 * [rotz(q1) [0;0;0]; 0 0 0 1]; 
  H1R = h1r * [rotz(-q1) [0;0;0]; 0 0 0 1]; 
for q2 = linspace(-100,30,N)
  H2L = H1L * h2 * [roty(q2) [0;0;0]; 0 0 0 1];
  H2R = H1R * h2 * [roty(q2) [0;0;0]; 0 0 0 1];
for q3 = linspace(-173.5,173.5,N)
  H3L = H2L * h3 * [rotz(q3) [0;0;0]; 0 0 0 1];
  H3R = H2R * h3 * [rotz(q3) [0;0;0]; 0 0 0 1];
for q4 = -linspace(3,80,N)
  H4L = H3L * h4 * [roty(q4) [0;0;0]; 0 0 0 1];
  H4R = H3R * h4 * [roty(q4) [0;0;0]; 0 0 0 1];
for q5 = linspace(-175.25,175.25,N)
  H5L = H4L * h5 * [rotz(q5) [0;0;0]; 0 0 0 1];
  H5R = H4R * h5 * [rotz(q5) [0;0;0]; 0 0 0 1];
for q6 = linspace(-90,120,N)
  H6L = H5L * h6 * [roty(q6) [0;0;0]; 0 0 0 1];
  H6R = H5R * h6 * [roty(q6) [0;0;0]; 0 0 0 1];
for q7 = linspace(-175.25,175.25,N)
  H = H6L * h7 * [rotz(q7) [0;0;0]; 0 0 0 1];
  H = H * hend;
  px(c) = H(1, end);
  py(c) = H(2, end);
  pz(c) = H(3, end);
  H = H6R * h7 * [rotz(q7) [0;0;0]; 0 0 0 1];
  H = H * hend;
  px(c+1) = H(1, end);
  py(c+1) = H(2, end);
  pz(c+1) = H(3, end);
  c = c+2;
end
end
end
end
end
end
end
save('workspace', 'px', 'py', 'pz');
%}
%set(hWorkspace, 'XData', data.px, 'YData', data.py, 'ZData', data.pz, 'MarkerSize', 3);


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2
global vBody; global vS0_L; global vS0_R; global vS1_L; global vS1_R;
global vE0_L; global vE0_R;  global vE1_L; global vE1_R; global vW0_L;
global vW0_R; global vW1_L;  global vW1_R; global vW2_L; global vW2_R;

% fv.vertices = fv.vertices - 500;
hBody = patch(vBody, 'FaceColor', [0.8 0.8 1], 'EdgeColor', 'none');
hS0_L = patch(vS0_L, 'FaceColor', [0.8 0.2 0.2], 'EdgeColor', 'none');
hS0_R = patch(vS0_R, 'FaceColor', [0.8 0.2 0.2], 'EdgeColor', 'none');
hS1_L = patch(vS1_L, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hS1_R = patch(vS1_R, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hE0_L = patch(vE0_L, 'FaceColor', [0.2 0.8 0.8], 'EdgeColor', 'none');
hE0_R = patch(vE0_R, 'FaceColor', [0.2 0.8 0.8], 'EdgeColor', 'none');
hE1_L = patch(vE1_L, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hE1_R = patch(vE1_R, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hW0_L = patch(vW0_L, 'FaceColor', [0.8 0.2 0.2], 'EdgeColor', 'none');
hW0_R = patch(vW0_R, 'FaceColor', [0.8 0.2 0.2], 'EdgeColor', 'none');
hW1_L = patch(vW1_L, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hW1_R = patch(vW1_R, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hW2_L = patch(vW2_L, 'FaceColor', [0.2 0.8 0.2], 'EdgeColor', 'none');
hW2_R = patch(vW2_R, 'FaceColor', [0.2 0.8 0.2], 'EdgeColor', 'none');
hold on;
hWorkspace = plot3(0,0,0, 'w.');
% Light and Default View
camlight('headlight');
material('dull');
view([90, 0, 0]);
axis([-2000 2000 -2000 2000 0 2500]);
grid on;
data = guidata(hObject);
set(hS0_R, 'Vertices', data.vvS0_R);
set(hS1_R, 'Vertices', data.vvS1_R);
set(hE0_R, 'Vertices', data.vvE0_R);
set(hE1_R, 'Vertices', data.vvE1_R);
set(hW0_R, 'Vertices', data.vvW0_R);
set(hW1_R, 'Vertices', data.vvW1_R);
set(hW2_R, 'Vertices', data.vvW2_R);

set(hS0_L, 'Vertices', data.vvS0_L);
set(hS1_L, 'Vertices', data.vvS1_L);
set(hE0_L, 'Vertices', data.vvE0_L);
set(hE1_L, 'Vertices', data.vvE1_L);
set(hW0_L, 'Vertices', data.vvW0_L);
set(hW1_L, 'Vertices', data.vvW1_L);
set(hW2_L, 'Vertices', data.vvW2_L);
set(hWorkspace, 'XData', data.px, 'YData', data.py, 'ZData', data.pz, 'MarkerSize', 1);


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3

global vBody; global vS0_L; global vS0_R; global vS1_L; global vS1_R;
global vE0_L; global vE0_R;  global vE1_L; global vE1_R; global vW0_L;
global vW0_R; global vW1_L;  global vW1_R; global vW2_L; global vW2_R;

% fv.vertices = fv.vertices - 500;
hBody = patch(vBody, 'FaceColor', [0.8 0.8 1], 'EdgeColor', 'none');
hS0_L = patch(vS0_L, 'FaceColor', [0.8 0.2 0.2], 'EdgeColor', 'none');
hS0_R = patch(vS0_R, 'FaceColor', [0.8 0.2 0.2], 'EdgeColor', 'none');
hS1_L = patch(vS1_L, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hS1_R = patch(vS1_R, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hE0_L = patch(vE0_L, 'FaceColor', [0.2 0.8 0.8], 'EdgeColor', 'none');
hE0_R = patch(vE0_R, 'FaceColor', [0.2 0.8 0.8], 'EdgeColor', 'none');
hE1_L = patch(vE1_L, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hE1_R = patch(vE1_R, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hW0_L = patch(vW0_L, 'FaceColor', [0.8 0.2 0.2], 'EdgeColor', 'none');
hW0_R = patch(vW0_R, 'FaceColor', [0.8 0.2 0.2], 'EdgeColor', 'none');
hW1_L = patch(vW1_L, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hW1_R = patch(vW1_R, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hW2_L = patch(vW2_L, 'FaceColor', [0.2 0.8 0.2], 'EdgeColor', 'none');
hW2_R = patch(vW2_R, 'FaceColor', [0.2 0.8 0.2], 'EdgeColor', 'none');
hold on;
hWorkspace = plot3(0,0,0, 'w.');
% Light and Default View
camlight('headlight');
material('dull');
view([0, 90, 0]);
axis([-2000 2000 -2000 2000 0 2500]);
grid on;
data = guidata(hObject);
set(hS0_R, 'Vertices', data.vvS0_R);
set(hS1_R, 'Vertices', data.vvS1_R);
set(hE0_R, 'Vertices', data.vvE0_R);
set(hE1_R, 'Vertices', data.vvE1_R);
set(hW0_R, 'Vertices', data.vvW0_R);
set(hW1_R, 'Vertices', data.vvW1_R);
set(hW2_R, 'Vertices', data.vvW2_R);

set(hS0_L, 'Vertices', data.vvS0_L);
set(hS1_L, 'Vertices', data.vvS1_L);
set(hE0_L, 'Vertices', data.vvE0_L);
set(hE1_L, 'Vertices', data.vvE1_L);
set(hW0_L, 'Vertices', data.vvW0_L);
set(hW1_L, 'Vertices', data.vvW1_L);
set(hW2_L, 'Vertices', data.vvW2_L);
set(hWorkspace, 'XData', data.px, 'YData', data.py, 'ZData', data.pz, 'MarkerSize', 1);


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4

global vBody; global vS0_L; global vS0_R; global vS1_L; global vS1_R;
global vE0_L; global vE0_R;  global vE1_L; global vE1_R; global vW0_L;
global vW0_R; global vW1_L;  global vW1_R; global vW2_L; global vW2_R;

% fv.vertices = fv.vertices - 500;
hBody = patch(vBody, 'FaceColor', [0.8 0.8 1], 'EdgeColor', 'none');
hS0_L = patch(vS0_L, 'FaceColor', [0.8 0.2 0.2], 'EdgeColor', 'none');
hS0_R = patch(vS0_R, 'FaceColor', [0.8 0.2 0.2], 'EdgeColor', 'none');
hS1_L = patch(vS1_L, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hS1_R = patch(vS1_R, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hE0_L = patch(vE0_L, 'FaceColor', [0.2 0.8 0.8], 'EdgeColor', 'none');
hE0_R = patch(vE0_R, 'FaceColor', [0.2 0.8 0.8], 'EdgeColor', 'none');
hE1_L = patch(vE1_L, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hE1_R = patch(vE1_R, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hW0_L = patch(vW0_L, 'FaceColor', [0.8 0.2 0.2], 'EdgeColor', 'none');
hW0_R = patch(vW0_R, 'FaceColor', [0.8 0.2 0.2], 'EdgeColor', 'none');
hW1_L = patch(vW1_L, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hW1_R = patch(vW1_R, 'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
hW2_L = patch(vW2_L, 'FaceColor', [0.2 0.8 0.2], 'EdgeColor', 'none');
hW2_R = patch(vW2_R, 'FaceColor', [0.2 0.8 0.2], 'EdgeColor', 'none');
hold on;
hWorkspace = plot3(0,0,0, 'w.');
% Light and Default View
camlight('headlight');
material('dull');
view([0, 0, 90]);
axis([-2000 2000 -2000 2000 0 2500]);
grid on;
data = guidata(hObject);
set(hS0_R, 'Vertices', data.vvS0_R);
set(hS1_R, 'Vertices', data.vvS1_R);
set(hE0_R, 'Vertices', data.vvE0_R);
set(hE1_R, 'Vertices', data.vvE1_R);
set(hW0_R, 'Vertices', data.vvW0_R);
set(hW1_R, 'Vertices', data.vvW1_R);
set(hW2_R, 'Vertices', data.vvW2_R);

set(hS0_L, 'Vertices', data.vvS0_L);
set(hS1_L, 'Vertices', data.vvS1_L);
set(hE0_L, 'Vertices', data.vvE0_L);
set(hE1_L, 'Vertices', data.vvE1_L);
set(hW0_L, 'Vertices', data.vvW0_L);
set(hW1_L, 'Vertices', data.vvW1_L);
set(hW2_L, 'Vertices', data.vvW2_L);
set(hWorkspace, 'XData', data.px, 'YData', data.py, 'ZData', data.pz, 'MarkerSize', 1);
