function varargout = gui_3dviwer(varargin)
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

% Last Modified by GUIDE v2.5 08-Jun-2015 10:22:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_3dviwer_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_3dviwer_OutputFcn, ...
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
function gui_3dviwer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_3dviwer (see VARARGIN)

% Choose default command line output for gui_3dviwer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_3dviwer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_3dviwer_OutputFcn(hObject, eventdata, handles) 
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
global hBody; global hS0_L;  global hS0_R; global hS1_L; global hS1_R;
global hE0_L; global hE0_R; global hE1_L;  global hE1_R; global hW0_L;
global hW0_R; global hW1_L;  global hW1_R; global hW2_L; global hW2_R;
global hTarget; global HEND;
global HS0_L;  global HS0_R; global HS1; global HE0; global HE1;
global HW0; global HW1; global HW2; global HEndEff;
global htextLeft; global htextRight;
global vBody2; global hBody2;

%vBody = stlread('baxter_body.STL');
vBody = stlread('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\baxter-study-master\GIT STL Files\PEDESTAL.STL');
vBody2 = stlread('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\baxter-study-master\GIT STL Files\BASE_LINK.STL');
vS0_L = stlread('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\baxter-study-master\GIT STL Files\S0.STL');
vS0_R = stlread('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\baxter-study-master\GIT STL Files\S0.STL');
vS1_L = stlread('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\baxter-study-master\GIT STL Files\S1.STL');
vS1_R = stlread('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\baxter-study-master\GIT STL Files\S1.STL');
vE0_L = stlread('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\baxter-study-master\GIT STL Files\E0.STL');
vE0_R = stlread('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\baxter-study-master\GIT STL Files\E0.STL');
vE1_L = stlread('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\baxter-study-master\GIT STL Files\E1.STL');
vE1_R = stlread('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\baxter-study-master\GIT STL Files\E1.STL');
vW0_L = stlread('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\baxter-study-master\GIT STL Files\W0.STL');
vW0_R = stlread('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\baxter-study-master\GIT STL Files\W0.STL');
vW1_L = stlread('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\baxter-study-master\GIT STL Files\W1.STL');
vW1_R = stlread('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\baxter-study-master\GIT STL Files\W1.STL');
vW2_L = stlread('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\baxter-study-master\GIT STL Files\W2.STL');
vW2_R = stlread('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\baxter-study-master\GIT STL Files\W2.STL');
% fv.vertices = fv.vertices - 500;
hBody = patch(vBody, 'FaceColor', [0.8 0.8 1], 'EdgeColor', 'none');
hBody2 = patch(vBody2, 'FaceColor', [0.8 0.8 1], 'EdgeColor', 'none');
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
% Light and Default View
camlight('headlight');
material('dull');
view([110, 30]);
axis([-2000 2000 -2000 2000 -1000 1000]);
grid on;

% translation / rotate to normal position
vBody.vertices = ones(length(vBody.vertices), 1) * [0 0 0] +  vBody.vertices*1000; % changed from -500 -500 0
%vBody.vertices = ones(length(vBody.vertices), 1) * [-500 -500 0] +  vBody.vertices; % changed from -500 -500 0
vBody2.vertices = ones(length(vBody2.vertices), 1) * [0 0 0] +  vBody2.vertices*1000; 


set(hBody, 'Vertices', vBody.vertices);
set(hBody2, 'Vertices', vBody2.vertices);
vS0_R.vertices = ones(length(vS0_R.vertices), 1) * [0 0 0] + vS0_R.vertices * 1000; % modified
vS0_L.vertices = ones(length(vS0_L.vertices), 1) * [0 0 0] +  vS0_L.vertices*1000; % modified
vS1_R.vertices = ones(length(vS1_R.vertices), 1) * [0 0 0] + vS1_R.vertices * 1000; % modified
vS1_L.vertices = ones(length(vS1_L.vertices), 1) * [0 0 0] + vS1_L.vertices * 1000; %modified
vE0_R.vertices = (ones(length(vE0_R.vertices), 1) * [0 0 0] + vE0_R.vertices) * 1000; % modified
vE0_L.vertices = (ones(length(vE0_L.vertices), 1) * [0 0 0] + vE0_L.vertices) * 1000; %modified
vE1_R.vertices = (ones(length(vE1_R.vertices), 1) * [0 0 0] + vE1_R.vertices) * 1000; % modified
vE1_L.vertices = (ones(length(vE1_L.vertices), 1) * [0 0 0] + vE1_L.vertices) * 1000; %modified
vW0_R.vertices = (ones(length(vW0_R.vertices), 1) * [0 0 0] + vW0_R.vertices) * 1000; % modified
vW0_L.vertices = (ones(length(vW0_L.vertices), 1) * [0 0 0] + vW0_L.vertices) * 1000; %modified
vW1_R.vertices = (ones(length(vW1_R.vertices), 1) * [0 0 0] + vW1_R.vertices) * 1000; % modified
vW1_L.vertices = (ones(length(vW1_L.vertices), 1) * [0 0 0] + vW1_L.vertices) * 1000; %modified
vW2_R.vertices = (ones(length(vW2_R.vertices), 1) * [0 0 0] + vW2_R.vertices) * 1000; % modified
vW2_L.vertices = (ones(length(vW2_L.vertices), 1) * [0 0 0] + vW2_L.vertices) * 1000; %modified


%HS0_L = [0 -1 0 64; 1 0 0 260; 0 0 1 118; 0 0 0 1]; %modified (World to S0_L, 0 deg)
HS0_L = [.707107 -.707107 0 64; .707107 .707107 0 260; 0 0 1 118; 0 0 0 1]; %modified (World to S0_L, 45 deg)
HS0_R = [.707107 .707107 0 64; -.707107 .707107 0 -260; 0 0 1 118; 0 0 0 1]; %modified (World to S0_R, 45 deg)
HS1 = [1 0 0 69; 0 0 -1 0; 0 1 0 269; 0 0 0 1]; %modified (S0 to S1)
HE0 = [0 0 1 102; -1 0 0 0; 0 -1 0 0; 0 0 0 1]; %modified (S1 to E0)
HE1 = [0 -1 0 69; 0 0 -1 0; 1 0 0 262.35 ; 0 0 0 1]; %modified (E0 to E1)
HW0 = [0 0 1 102.5; -1 0 0 0; 0 -1 0 0; 0 0 0 1]; %modified (E1 to W0)
HW1 = [0 -1 0 0; 0 0 -1 0; 1 0 0 271.79; 0 0 0 1]; %modified (W0 to W1)
HW2 = [0 0 1 114; 1 0 0 0; 0 1 0 0; 0 0 0 1]; %modified (W1 to W2)
HEND = [1 0 0 0; 0 1 0 0; 0 0 1 130; 0 0 0 1];
%{
for i=1:length(vS0_R.vertices)
  h = HS0_R * [vS0_R.vertices(i,:) 1]';
  vvS0_R(i,:) = h(1:3, end)';
end
%}
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

H = H * HEND;
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
H = H * HEND;
HEndEff(2, :) = H(1:3, end)';

set(hS0_R, 'Vertices', vvS0_R);
set(hS1_R, 'Vertices', vvS1_R);
set(hE0_R, 'Vertices', vvE0_R);
set(hE1_R, 'Vertices', vvE1_R);
set(hW0_R, 'Vertices', vvW0_R);
set(hW1_R, 'Vertices', vvW1_R);
set(hW2_R, 'Vertices', vvW2_R);


set(hS0_L, 'Vertices', vvS0_L);
set(hS1_L, 'Vertices', vvS1_L);
set(hE0_L, 'Vertices', vvE0_L);
set(hE1_L, 'Vertices', vvE1_L);
set(hW0_L, 'Vertices', vvW0_L);
set(hW1_L, 'Vertices', vvW1_L);
set(hW2_L, 'Vertices', vvW2_L);
set(htextLeft, 'String', sprintf('(%.4f, %.4f, %.4f)', HEndEff(2, 1), HEndEff(2, 2), HEndEff(2, 3)));
set(htextRight, 'String', sprintf('(%.4f, %.4f, %.4f)', HEndEff(1, 1), HEndEff(1, 2), HEndEff(1, 3)));

% --- Executes during object creation, after setting all properties.
function textLeft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global HEndEff; global htextLeft;
htextLeft = hObject;
s = size(HEndEff);
if s(1) >= 2
set(hObject, 'String', sprintf('(%.4f, %.4f, %.4f)', HEndEff(2, 1), HEndEff(2, 2), HEndEff(2, 3)));
end


% --- Executes during object creation, after setting all properties.
function textRight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global HEndEff; global htextRight;
htextRight = hObject;
s = size(HEndEff);
if s(1) >= 2
set(hObject, 'String', sprintf('(%.4f, %.4f, %.4f)', HEndEff(1, 1), HEndEff(1, 2), HEndEff(1, 3)));
end
