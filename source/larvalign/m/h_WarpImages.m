function h_WarpImages( imFile, ext)
%%
%% Warping of channel images
%%
%% Author: S.E.A. Muenzing, PhD
%% Edit: Harsha Yogeshappa, MSc
%% SEAM@2016-10-17
%%
try
    % dirs & exe
    warning('off','MATLAB:MKDIR:DirectoryExists');
    
    ext = convertStringsToChars(ext);
    
    imFile_suffix = 'I:\metamorphosis\deformationFields\';
    exeDir = 'C:\Program Files\Convert3D\bin\';
    
    c3d = ['"' exeDir 'c3d.exe" '];
    
    deffieldPN = [imFile_suffix imFile];
    deffieldPFN = [deffieldPN '\deformationField.mhd'];
      
    % input image channels
    WNP = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\meta18\mhd\';
    srcNPPFN = [WNP imFile '.mhd'];
    
    % output registered scans
    registeredScansPN = [deffieldPN '\MeanDFile_RegisteredScans\' ];
    outputNPPN = [registeredScansPN 'NP\'];mkdir(outputNPPN) % NP -- Neuropil
    
    if(0)
        fprintf("c3d is %s\n", c3d);
        fprintf("deffieldPFN in warping is %s\n", deffieldPFN);
        fprintf("srcNPPFN in warping is %s\n", srcNPPFN);
        fprintf("outputNPPN is %s\n\n", outputNPPN);
    end
    
    tic
    logstr = [datestr(datetime) sprintf(' -- Warping of channels...')];
    fprintf("%s\n", logstr);
    
    operation='  -interpolation cubic -warp -clip 0 65535 -type ushort -compress -o  ';
    warpCmd = [c3d '-mcs ' '"' deffieldPFN '"' ' -popas defZ -popas defY -popas defX '...
        ' -push defX -push defY -push defZ ' '"' srcNPPFN '"' operation '"' outputNPPN imFile '.' ext '"'];
    fprintf("WarpCmd is %s\n\n", warpCmd);
    
    [status,cmdout] = system(warpCmd);
    assert(status==0, [datestr(datetime) sprintf([' -- Warping of scan:  ' imFile '  failed.\n' cmdout])] )
    t=toc;
    logstr = [datestr(datetime) sprintf(' -- Warping took: %g s' ,t)];
    fprintf("logstr is %s\n", logstr);
catch ME;
    throwAsCaller(ME)
end
end
%%
