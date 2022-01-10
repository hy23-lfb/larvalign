function WarpImages( rootpath, deffieldPN, scanID, ChannelImgPFN, outputDir, ext, LogFileID)
%%
%% Warping of channel images
%%
%% Author: S.E.A. Muenzing, PhD
%% SEAM@2016-10-17
%%
try
% dirs & exe
imFile_suffix = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\deformationFields\';
imFile = 'D5_Unsharp;
deffieldPN = [imFile_suffix imFile];
deffieldPN = convertStringsToChars(deffieldPN);
warning('off','MATLAB:MKDIR:DirectoryExists');
exeDir = [rootpath '\resources\exe\'];
c3d = ['"' exeDir 'c3d.exe" '];
deffieldPFN = [deffieldPN '\deformationField.mhd'];
fprintf("deffieldPFN is %s\n", deffieldPFN);

% input image channels
srcNPPFN = ChannelImgPFN.WNP;
srcNTPFN = ChannelImgPFN.WNT;
srcGEPFN = ChannelImgPFN.WGE;

% output registered scans
registeredScansPN = [outputDir 'RegisteredScans\' ];
outputNPPN = [registeredScansPN 'NP\'];mkdir(outputNPPN) % NP -- Neuropil
outputNTPN = [registeredScansPN 'NT\'];mkdir(outputNTPN) % NT -- Nerve tracts
outputGEPN = [registeredScansPN 'GE\'];mkdir(outputGEPN) % GE -- Expression pattern

% Warping
tic
logstr = [datestr(datetime) sprintf(' -- Warping of channels...')];
display(sprintf(logstr)), fprintf(LogFileID,[logstr '\n']);
operation=['  -interpolation cubic -warp -clip 0 65535 -type ushort -compress -o  '];
if ~isempty(srcNTPFN)
warpNT = [' -push defX -push defY -push defZ ' '"' srcNTPFN '"'  operation  '"' outputNTPN scanID '.' ext '"'];
else
warpNT = [];
end
if ~isempty(srcGEPFN)
warpGE = [' -push defX -push defY -push defZ ' '"' srcGEPFN '"' operation  '"' outputGEPN scanID '.' ext '"'];
else
warpGE = [];
end

[status,cmdout] = system( [ c3d '-mcs ' '"' deffieldPFN '"' ' -popas defZ -popas defY -popas defX '...
' -push defX -push defY -push defZ ' '"' srcNPPFN '"' operation '"' outputNPPN scanID '.' ext '"' ' -clear ' warpNT  ' -clear ' warpGE] );
assert(status==0, [datestr(datetime) sprintf([' -- Warping of scan:  ' scanID '  failed.\n' cmdout])] )
t=toc;
logstr = [datestr(datetime) sprintf(' -- Warping took: %g s' ,t)];
display(sprintf(logstr)), fprintf(LogFileID,[logstr '\n']);


catch ME;
throwAsCaller(ME)
end

end
%%
%%
%%
