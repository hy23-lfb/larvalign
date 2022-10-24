function h_createTemplateFiles(path_suffix, file)
%%
%% Create template files for registration
%%
%% Author: Harsha Yogeshappa
%%
warning('off','MATLAB:MKDIR:DirectoryExists');
warning('off','all');

rootpath = 'D:\Harsha\Repository\larvalign\source\larvalign';
exeDir = [rootpath '\resources\exe\'];
c3d = ['"' exeDir 'c3d.exe" '];

file = convertStringsToChars(file);

filepath = fullfile(path_suffix, "mhd");
filepath = convertStringsToChars(filepath);

inputfile = fullfile(filepath, [file '.mhd']);
inputfile = convertStringsToChars(inputfile);


templatepath = fullfile(filepath, "template");
templatepath = convertStringsToChars(templatepath);

mkdir(templatepath);

ppfilename      = fullfile(templatepath, [file '_PP.mhd']);
sdtfilename     = fullfile(templatepath, [file '_SDT.mhd']);
maskfilename    = fullfile(templatepath, [file '_MASK.mhd']);

fprintf("Template for %s\n", file);
%% create pre-processed template.
fprintf("\t Creating preprocessed template: \t");
[status,cmdout] = system([ c3d '"' inputfile '"  -info-full ']);
Ctmp=textscan(cmdout,'%s','Delimiter',{'  Mean Intensity     : '});
lowclip=num2str(ceil(cell2mat(textscan(Ctmp{1,1}{7,1},'%f'))));
[status,cmdout] = system([  c3d '"' inputfile '"  -clip ' lowclip ' 65535  -replace ' lowclip ' 0  -type ushort -compress -o "' ppfilename '"']);
fprintf("Finished creating preprocessed template.\n");

%% create sdt template.
fprintf("\t Creating sdt template: \t");
[status,cmdout] = system([ c3d '"' ppfilename '"' ' -info-full ']);
Ctmp=textscan(cmdout,'%s','Delimiter',{'  Mean Intensity     : '});
meanIntensity = cell2mat(textscan(Ctmp{1,1}{7,1},'%f')); % estimation of background intensity
lowclip=num2str(ceil(meanIntensity)+5);
[status,cmdout] = system([ c3d '"' ppfilename '"'...
    ' -clip ' lowclip ' 65535  -replace ' lowclip ' 0 -binarize -erode 1 1x1x1 -dilate 1 1x1x1 -dilate 1 1x1x1 -dilate 1 1x1x1 -popas mask '...
    ' -push mask -sdt -type short -compress -o ' '"' sdtfilename '"' ]);
fprintf("Finished creating sdt template.\n");

%% create mask template.
fprintf("\t Creating mask template: \t");
[status,cmdout] = system([ c3d '"' ppfilename '"' ' -info-full ']);
Ctmp=textscan(cmdout,'%s','Delimiter',{'  Mean Intensity     : '});
meanIntensity = cell2mat(textscan(Ctmp{1,1}{7,1},'%f')); % estimation of background intensity
lowclip=num2str(ceil(meanIntensity)+5);
[status,cmdout] = system([ c3d '"' ppfilename '"'...
    ' -clip ' lowclip ' 65535  -replace ' lowclip ' 0 -binarize -erode 1 1x1x1 -dilate 1 1x1x1 -dilate 1 1x1x1 -dilate 1 1x1x1 -popas mask '...
    ' -push mask -type short -compress -o ' '"' maskfilename '"' ]);
fprintf("Finished creating mask template.\n");
end






