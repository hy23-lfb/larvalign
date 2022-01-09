function [status, cmdout] = h_tif2mhd(scount, ecount, path_suffix)
%%
%% Generate mhd files out of tif files.
%%
%% Author: Harsha Yogeshappa
%%
warning('off','MATLAB:MKDIR:DirectoryExists');
rootpath = 'D:\Harsha\Repository\larvalign\source\larvalign';
FijiExe = ['"' rootpath '\resources\exe\Fiji\ImageJ-win64.exe" ' ];
tmpDir = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\tmp\';
mkdir(tmpDir);
%path_suffix = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\';

for j=scount:ecount
    i = num2str(j);
    file = append('D', i);
    in_path = [path_suffix file '.tif'];
    out_path = [path_suffix 'mhd\' file '.mhd'];
    
    fijiOpen=[' run("ImageJ2...", "scijavaio=true");  open("' sep(in_path) '"); '];
    window = [file '.tif'];
    fijiProc=[ 'selectWindow("' window '"); '...
        'run("MHD/MHA ...", "save=[' sep(out_path) ']"); '];
    
    stringBuffer = [ fijiOpen fijiProc ' run("Quit"); '];
    
    fileID = fopen([sep(tmpDir) '\tif2mhd.txt'],'w');
    fprintf(fileID,'%s\n',stringBuffer);
    fclose(fileID);
    
    fprintf("Converting %s.tif to mhd\n", file);
    [status,cmdout] = system([FijiExe ' --headless -macro "' sep(tmpDir) '\tif2mhd.txt"']);
end
end

function sepStr = sep( pathfilename  )
sepStr = strrep( pathfilename, '\','\\');
end