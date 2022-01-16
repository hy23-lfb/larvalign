function h_generateMIProjection(file)
%%
%% Create z-projection based on maximum intensity.
%%
%% Author: Harsha Yogeshappa
%%
warning('off','MATLAB:MKDIR:DirectoryExists');
warning('off','all');

in_filepath = 'C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\';
out_filepath = 'C:\Users\yogeshappa\Documents\Files_Hiwi\Output\RegisteredScans\TIFF\';

inputfile = [in_filepath file '.tif'];
outputfile = [out_filepath file '.tif'];

fprintf("input file is %s\n", in_filepath);
fprintf("output file is %s\n", out_filepath);
rootpath = 'C:\Users\yogeshappa\Documents\Repository\larvalign\source\larvalign';
FijiExe = ['"' rootpath '\resources\exe\Fiji\ImageJ-win64.exe" ' ];

%exeDir = [rootpath '\resources\exe\'];
%c3d = ['"' exeDir 'c3d.exe" '];

fijiOpen=[' run("ImageJ2...", "scijavaio=true");'];
opStringOut=[' open("' outputfile '"); '...
    'run("Z Project...", "projection=[Max Intensity]"); '...
    'run("Save", "save=C:\\Users\\yogeshappa\\Documents\\Files_Hiwi\\PostAnalysis\\D6_After_Registration.tif"); '...
    'close(); selectWindow("72h_brain_2101_D6_NCad_CLAHE-25_rot.tif"); close();'];

opStringIn=[' open("' inputfile '"); '...
    'run("Z Project...", "projection=[Max Intensity]");' ...
    'run("Save", "save=C:\\Users\\yogeshappa\\Documents\\Files_Hiwi\\PostAnalysis\\D6_Before_Registration.tif"); '...
    ' close(); selectWindow("72h_brain_2101_D6_NCad_CLAHE-25_rot.tif"); close();'];

fijiproc = [opStringOut...
    opStringIn...
    ' run("Quit"); '];

stringBuffer = [ fijiOpen fijiproc ];
fileID = fopen('C:\\Users\\yogeshappa\\Documents\\Files_Hiwi\\PostAnalysis\\MIProjection.txt','w');
fprintf(fileID,'%s\n',stringBuffer);
fclose(fileID);

[status,cmdout] = system([FijiExe ' --headless -macro "' 'C:\Users\yogeshappa\Documents\Files_Hiwi\PostAnalysis\MIProjection.txt']);
end
















