function [status, cmdout] = h_tif2mhd(scount, ecount, path_suffix)
%%
%% Generate mhd files out of tif files.
%%
%% Author: Harsha Yogeshappa
%%
warning('off','MATLAB:MKDIR:DirectoryExists');
rootpath = 'D:\Harsha\Repository\larvalign\source\larvalign';
FijiExe = ['"' rootpath '\resources\exe\Fiji\ImageJ-win64.exe" ' ];

%update this.
tmpDir = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\meta18\tmp\';
mkdir(tmpDir);

for j=scount:ecount
    i = num2str(j);
    file = append('B', i);
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
    fprintf("status is %d\n", status);
end
end

function sepStr = sep( pathfilename  )
sepStr = strrep( pathfilename, '\','\\');
end