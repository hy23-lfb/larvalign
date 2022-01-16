function h_registerToTargetSpace()
%%
%% Register individual images to target spaces.
%%
%% Author: Harsha Yogeshappa
%%
img_files = ["'D3'", "'D5'", "'D6'", "'D3_Flip'", "'D5_Flip'", "'D6_Flip'"];
i_files = ["D3", "D5", "D6", "D3_Flip", "D5_Flip", "D6_Flip"];

[rm ,cm] = size(i_files);
% Update the moving file in larvalignMain.m
for j=1:cm    
    rootpath = 'D:\Harsha\Repository\larvalign\source\larvalign';
    imFile = convertStringsToChars(i_files(j));
    scanID = imFile;
    tmpDir = 'D:\Harsha\Files_Hiwi\Output\tmp';
    ChannelImgPFN.WNP = [tmpDir '\' imFile '\NP\' imFile '.mhd'];
    %fprintf("ChannelImgPFN.NP is %s\n", ChannelImgPFN.NP);
    ChannelImgPFN.WNT = '';
    ChannelImgPFN.WGE = '';
    ext = 'mhd';
    LogFileID = fopen("D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\tmp\LogFile.txt");
    
    h_WarpImages(rootpath, imFile, scanID, ChannelImgPFN, ext, LogFileID);
end
