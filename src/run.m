function varargout = run(varargin)
% RUN MATLAB code for run.fig
%      RUN, by itself, creates a new RUN or raises the existing
%      singleton*.
%
%      H = RUN returns the handle to a new RUN or the handle to
%      the existing singleton*.
%
%      RUN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RUN.M with the given input arguments.
%
%      RUN('Property','Value',...) creates a new RUN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before run_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to run_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help run

% Last Modified by GUIDE v2.5 14-Jul-2018 14:08:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @run_OpeningFcn, ...
                   'gui_OutputFcn',  @run_OutputFcn, ...
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


% --- Executes just before run is made visible.
function run_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to run (see VARARGIN)

% Choose default command line output for run
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes run wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = run_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
clear all;
close all;
clc;

%////////////////////////////////////////////////////////////

 classes=['b';'m';]; % i
 PName=['a';]; 
cd ('C:\Users\computer\Documents\MATLAB\segmentation Brain Tumor proposed\train\');
AllFile=dir('*.jpg');
r=1;
k1=1;
Col=1;
for i=1:2
    i;
    PerName='';
    for j=1:1
        j;
        cd ('C:\Users\computer\Documents\MATLAB\brain segmentation\lmom\train\');
        AllFile=dir('*.jpg');
        cc=1;        
        for ll=1:length(AllFile(:,1))
            TotalName(ll,1:length(AllFile(ll,1).name))=AllFile(ll,1).name;        
            if (strfind(TotalName(ll,:),classes(i,:)))
                if  (strfind(TotalName(ll,:),PName(j,:)))
                   PerName(cc,1:length(TotalName(ll,:)))=TotalName(ll,:);
                   cc=cc+1;
                end                
            end
        end
%        PerName        
     cd ('C:\Users\computer\Documents\MATLAB\brain segmentation\lmom');
     for k=1:length(PerName(:,1))
         im=imread(strcat('C:\Users\computer\Documents\MATLAB\brain segmentation\lmom\train\',PerName(k,:)));
         rgbimage=imresize(im,[300 300]);
         
         rgbimage=rgb2gray(rgbimage);
 rgbimage=im2double(rgbimage);


% rgbimage=imresize(rgbimage,[256,256]);
 [h_LL,h_LH,h_HL,h_HH]=dwt2(rgbimage,'haar');
% figure;imshow(h_LL);
% figure;imshow(h_LH);
% figure;imshow(h_HL);
% figure;imshow(h_HH);

SP=[-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
% h_LL_lbp=lbp(h_LL,SP,0,'i'); 
h_LH_lbp=lbp(h_LH,SP,0,'i'); 
h_HL_lbp=lbp(h_HL,SP,0,'i'); 
h_HH_lbp=lbp(h_HH,SP,0,'i'); 


h_LH_lbp=imresize(h_LH_lbp,[128 128]);
% figure;imshow(h_LH_lbp);
h_LH_lbp=im2double(h_LH_lbp);
h_LH_lbp_mom=lmom(h_LH_lbp,3);

h_HL_lbp=imresize(h_HL_lbp,[128 128]);
% figure;imshow(h_HL_lbp);
h_HL_lbp=im2double(h_HL_lbp);
h_HL_lbp_mom=lmom(h_HL_lbp,3);

h_HH_lbp=imresize(h_HH_lbp,[128 128]);
% figure;imshow(h_HH_lbp);
h_HH_lbp=im2double(h_HH_lbp);
h_HH_lbp_mom=lmom(h_HH_lbp,3);

feature_vector=cat(1,h_LH_lbp_mom,h_HL_lbp_mom,h_HH_lbp_mom);
feature_vector = reshape (feature_vector, 1, 390);

 FVTrain(Col,1:390)=feature_vector(1,1:390);
FVTrain(Col,391)=i;
 Col=Col+1;

     end
    end
end
save('FVTrain.mat','FVTrain');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
[FileName, PathName] = uigetfile({'*.jpg;*.tif;*.bmp;*.gif','All Image Files'},'Select an Image');
fpath = strcat(PathName, FileName);
im = imread(fpath);
 save('im.mat','im');
axes(handles.axes1) % Select the proper axes
box on
imshow(im);
% figure; imshow(im);
     rgbimage=imresize(im,[300 300]);
         
         rgbimage=rgb2gray(rgbimage);
rgbimage=im2double(rgbimage);
% figure; imshow(rgbimage);
% figure;imshow(rgbimage);
% rgbimage=imresize(rgbimage,[256,256]);
 [h_LL,h_LH,h_HL,h_HH]=dwt2(rgbimage,'haar');
% figure;imshow(h_LL);
% figure;imshow(h_LH);
% figure;imshow(h_HL);
% figure;imshow(h_HH);
% cod_X = wcodemat(X,nbcol); 
% nbcol = size(rgbimage,1);
% cod_cA1 = wcodemat(h_LL,nbcol); 
% cod_cH1 = wcodemat(h_LH,nbcol); 
% cod_cV1 = wcodemat(h_HL,nbcol); 
% cod_cD1 = wcodemat(h_HH,nbcol); 
% dec2d = [... 
%         cod_cA1,     cod_cH1;     ... 
%         cod_cV1,     cod_cD1      ... 
%         ];
%     figure;imshow(dec2d);

SP=[-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
% h_LL_lbp=lbp(h_LL,SP,0,'i'); 
h_LH_lbp=lbp(h_LH,SP,0,'i'); 
h_HL_lbp=lbp(h_HL,SP,0,'i'); 
h_HH_lbp=lbp(h_HH,SP,0,'i'); 
% figure;imshow(h_LH_lbp);
%  figure;imshow(h_HL_lbp);
%  figure;imshow(h_HH_lbp);


h_LH_lbp=imresize(h_LH_lbp,[128 128]);
% figure;imshow(h_LH_lbp);
h_LH_lbp=im2double(h_LH_lbp);
h_LH_lbp_mom=lmom(h_LH_lbp,3);

h_HL_lbp=imresize(h_HL_lbp,[128 128]);
% figure;imshow(h_HL_lbp);
h_HL_lbp=im2double(h_HL_lbp);
h_HL_lbp_mom=lmom(h_HL_lbp,3);

h_HH_lbp=imresize(h_HH_lbp,[128 128]);
% figure;imshow(h_HH_lbp);
h_HH_lbp=im2double(h_HH_lbp);
h_HH_lbp_mom=lmom(h_HH_lbp,3);

feature_vector=cat(1,h_LH_lbp_mom,h_HL_lbp_mom,h_HH_lbp_mom);
feature_vector = reshape (feature_vector, 1, 390);

 FVTest(1,1:390)=feature_vector(1,1:390);
FVTest(1,391)=1;

save('FVTest.mat','FVTest');
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
load('FVTrain.mat');
load('FVTest.mat');
e=FVTrain(1:96,1:end-1);
e1=FVTest(1,1:end-1);
T=FVTrain(1:96,end);
T1=FVTest(1,end);
 model = svmtrain(e,T);
e=[];
T=[];
Class = svmclassify(model,e1);
 if (Class==1)
      set(handles.text1,'String','benign');
 end
 if (Class==2)
      set(handles.text1,'String','Malignant');
 end
len=find(Class==T1);
accnum=length(len);
accnum*100/size(e1,1)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
load('im.mat');
fim=mat2gray(im);
level=graythresh(fim);
bwfim=im2bw(fim,0.1);
[bwfim0,level0]=fcmthresh(fim,0);
[bwfim1,level1]=fcmthresh(fim,1);

axes(handles.axes2) % Select the proper axes
box on
imshow(bwfim1);
