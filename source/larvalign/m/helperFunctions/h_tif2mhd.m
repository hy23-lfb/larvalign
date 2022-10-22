function [status, cmdout] = h_tif2mhd(count, filepath, images)
%%
%% Generate mhd files out of tif files.
%%
%% Author: Harsha Yogeshappa
%%
warning('off','MATLAB:MKDIR:DirectoryExists');
rootpath = 'D:\Harsha\Repository\larvalign\source\larvalign';
FijiExe = ['"' rootpath '\resources\exe\Fiji\ImageJ-win64.exe" ' ];

mhdpath = fullfile(filepath, "mhd");
mkdir(mhdpath);

%update this.
tmpDir = fullfile(filepath, "tmp");
mkdir(tmpDir);

mhdpath = convertStringsToChars(mhdpath);
tmpDir = convertStringsToChars(tmpDir);

for j=1:count
    [~, file, ~] = fileparts(images(j));
    file = convertStringsToChars(file);


    in_path = fullfile(filepath, images(j));
    in_path = convertStringsToChars(in_path);

    out_path = fullfile(mhdpath, [file '.mhd']);
    out_path = convertStringsToChars(out_path);
    
    fijiOpen=[' run("ImageJ2...", "scijavaio=true");  open("' sep(in_path) '"); '];
    window = [file '.tif'];
    fijiProc=[ 'selectWindow("' window '"); run("MHD/MHA ...", "save=[' sep(out_path) ']"); '];
    
    stringBuffer = [ fijiOpen fijiProc ' run("Quit"); '];
    
    fileID = fopen([sep(tmpDir) '\tif2mhd.txt'],'w');
    fprintf(fileID,'%s\n',stringBuffer);
    fclose(fileID);
    
    tic
    fprintf("Converting %s.tif to mhd\n", file);
    [status,cmdout] = system([FijiExe ' --headless -macro "' sep(tmpDir) '\tif2mhd.txt"']);
    fprintf("status is %d\n", status);
    t = toc;
    logstr = [datestr(datetime) sprintf(' -- Tif2Mhd took: %g s' ,t)];
    fprintf([logstr '\n\n']);
end
end

function sepStr = sep( pathfilename  )
sepStr = strrep( pathfilename, '\','\\');
end