function h_registerToTargetSpace()
%%
%% Register individual images to target spaces.
%%
%% Author: Harsha Yogeshappa
%%
img_files = ["'D3'", "'D5'", "'D6'", "'D3_Contrast'", "'D3_Trans'", "'D3_FlipH'", "'D3_Flip'", "'D3_Unsharp'", "'D5_Contrast'", "'D5_Trans'", "'D5_FlipH'", "'D5_Flip'", "'D5_Unsharp'", "'D6_Contrast'", "'D6_Trans'", "'D6_FlipH'", "'D6_Flip'", "'D6_Unsharp"];
i_files = ["D3", "D5", "D6", "D3_Contrast", "D3_Trans", "D3_FlipH", "D3_Flip", "D3_Unsharp", "D5_Contrast", "D5_Trans", "D5_FlipH", "D5_Flip", "D5_Unsharp", "D6_Contrast", "D6_Trans", "D6_FlipH", "D6_Flip", "D6_Unsharp"];

[rm ,cm] = size(img_files);
% Update the moving file in larvalignMain.m
for j=1:cm % for a given template register all possible moving images.
    fid = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\larvalignMain.m");
    C=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    template = C{1,1};
    mv = convertStringsToChars(img_files(j));
    idxT=find(~cellfun(@isempty, strfind(template,'fm =')));
    template{idxT,1} = ['fm = ' mv ';'];
    fid = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\larvalignMain.m", 'w');
    fprintf(fid,'%s\n',template{:});
    fclose(fid);
    
    fid = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\WarpImages.m");
    C=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    template = C{1,1};
    idxT=find(~cellfun(@isempty, strfind(template,'imFile =')));
    template{idxT,1} = ['imFile = ' mv ';'];
    fid = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\WarpImages.m", 'w');
    fprintf(fid,'%s\n',template{:});
    fclose(fid);
    
    fprintf("Running larvalign for %s\n", mv);
    run larvalignMain.m
    
    dst_suffix = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\deformationFields\';
    i_mv = convertStringsToChars(i_files(j));
    dst_dir = [dst_suffix i_mv];
    dst_dir = convertStringsToChars(dst_dir);
    out_suffix = 'D:\Harsha\Files_Hiwi\Output\RegisteredScans\TIFF\';
    out_file = [out_suffix i_mv '.tif'];
    copyfile(out_file, dst_dir);
end
