function h_createTemplateFiles(file)
%%
%% Create template files for registration
%%
%% Author: Harsha Yogeshappa
%%
warning('off','MATLAB:MKDIR:DirectoryExists');
warning('off','all');

file = convertStringsToChars(file);

filepath = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\E12e_BP106\borderline\mhd\';
rootpath = 'D:\Harsha\Repository\larvalign\source\larvalign';

exeDir = [rootpath '\resources\exe\'];
c3d = ['"' exeDir 'c3d.exe" '];

inputfile = [filepath file '.mhd'];
templatepath = [filepath 'template\'];
mkdir(templatepath);

ppfilename = [templatepath file '_PP.mhd'];
sdtfilename = [templatepath file '_SDT.mhd'];
maskfilename = [templatepath file '_MASK.mhd'];

%% create pre-processed template.
fprintf("Creating preprocessed template.\n");
[status,cmdout] = system([ c3d '"' inputfile '"  -info-full ']);
Ctmp=textscan(cmdout,'%s','Delimiter',{'  Mean Intensity     : '});
lowclip=num2str(ceil(cell2mat(textscan(Ctmp{1,1}{7,1},'%f'))));
[status,cmdout] = system([  c3d '"' inputfile '"  -clip ' lowclip ' 255  -replace ' lowclip ' 0  -type uchar -compress -o "' ppfilename '"']);
fprintf("Finished creating preprocessed template.\n");

%% create sdt template.
fprintf("Creating sdt template.\n");
[status,cmdout] = system([ c3d '"' ppfilename '"' ' -info-full ']);
Ctmp=textscan(cmdout,'%s','Delimiter',{'  Mean Intensity     : '});
meanIntensity = cell2mat(textscan(Ctmp{1,1}{7,1},'%f')); % estimation of background intensity
lowclip=num2str(ceil(meanIntensity)+5);
[status,cmdout] = system([ c3d '"' ppfilename '"'...
    ' -clip ' lowclip ' 255  -replace ' lowclip ' 0 -binarize -erode 1 1x1x1 -dilate 1 1x1x1 -dilate 1 1x1x1 -dilate 1 1x1x1 -popas mask '...
    ' -push mask -sdt -type short -compress -o ' '"' sdtfilename '"' ]);
fprintf("Finished creating sdt template.\n");

%% create mask template.
fprintf("Creating mask template.\n");
[status,cmdout] = system([ c3d '"' ppfilename '"' ' -info-full ']);
Ctmp=textscan(cmdout,'%s','Delimiter',{'  Mean Intensity     : '});
meanIntensity = cell2mat(textscan(Ctmp{1,1}{7,1},'%f')); % estimation of background intensity
lowclip=num2str(ceil(meanIntensity)+5);
[status,cmdout] = system([ c3d '"' ppfilename '"'...
    ' -clip ' lowclip ' 255  -replace ' lowclip ' 0 -binarize -erode 1 1x1x1 -dilate 1 1x1x1 -dilate 1 1x1x1 -dilate 1 1x1x1 -popas mask '...
    ' -push mask -type short -compress -o ' '"' maskfilename '"' ]);
fprintf("Finished creating mask template.\n");
end