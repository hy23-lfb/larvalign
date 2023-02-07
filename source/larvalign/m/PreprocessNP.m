function PreprocessNP(folder)

    %%
    % likely that the voxel resolution information is being lost during the
    % image processing steps in Convert3D. This can happen if the image 
    % header information is not properly propagated during the processing 
    % steps.
    %
    % Maybe, I should deal with .mhd files like done in larvalign.

    rootpath = 'D:\Harsha\Repository\larvalign\source\larvalign';
    % dirs & exe
    warning('off','MATLAB:MKDIR:DirectoryExists');
    exeDir = [rootpath '\resources\exe\'];
    c3d = ['"' exeDir 'c3d.exe" '];

    BGCDir = [folder '\BGC_Pixel\']; mkdir(BGCDir);

    filePattern = fullfile(folder, '*.tif');
    tifFiles = dir(filePattern);
    for i = 1:length(tifFiles)
        baseFileName = tifFiles(i).name;
        fullFileName = fullfile(folder, baseFileName);
        fprintf('%s\n', fullFileName);

        % Background correction 
        [status,cmdout] = system([ c3d '"' fullFileName '"  -info-full ']);                             
        Ctmp=textscan(cmdout,'%s','Delimiter',{'  Mean Intensity     : '});
        lowclip=num2str(ceil(cell2mat(textscan(Ctmp{1,1}{7,1},'%f'))));  
        [status,cmdout] = system([c3d '"' fullFileName '" -copy-transform -clip ' lowclip ' 255  -replace ' lowclip ' 0  -type uchar -compress -o "' BGCDir baseFileName '"']);
        assert(status==0, 'Processing failure.')
    end
end