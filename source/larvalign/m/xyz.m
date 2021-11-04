%%
%% Template registration framework for registration of the larval CNS of Drosophila melanogaster
%%
%% Author: Harsha Yogeshappa
%%
function msg = xyz(img_out)
warning('off','MATLAB:MKDIR:DirectoryExists');

%% Global Inits
avgDef_x = zeros(3684, 1624, 280);
avgDef_y = zeros(3684, 1624, 280);
avgDef_z = zeros(3684, 1624, 280);

%% Flags

move_images = ["'B3'", "'B4'", "'B5'", "'B6'", "'B7'", "'B3_Flip'","'B4_Flip'", "'B5_Flip'", "'B6_Flip'", "'B7_Flip'"];
move_images_cp = ["B3", "B4", "B5", "B6", "B7", "B3_Flip","B4_Flip", "B5_Flip", "B6_Flip", "B7_Flip"];

[r_move_images, c_move_images] = size(move_images);

noOfDefFields = c_move_images - 1;
fprintf("no of def fields is %g\n", noOfDefFields);

for mv_image_num = 1 : c_move_images
    mv_cp = move_images_cp{mv_image_num};
    
    %%
    %% Generate Template Lists for the give moving images.
    fixed_images = move_images;
    fixed_images(strcmp(move_images, move_images{mv_image_num})) = [];
    %%
    %% Extract each Template file and register the moving image to it.
    [r_fix_images, c_fix_images] = size(fixed_images);
    for fx_image_num = 1 : c_fix_images
        %msg = larvalignMain();
        msg = 0;
        
        src_prefix_mhd = '\DIR\deformationField.mhd';
        src_suffix = 'D:\Harsha\Files_Hiwi\Output\tmp\';
        mv_cp = convertStringsToChars(mv_cp);
        src_mhd = [src_suffix mv_cp src_prefix_mhd];
        
        fprintf("%s\n", src_mhd);
        %[defX, defY, defZ] = h_processDeformationField(src_mhd, noOfDefFields);
        defX = ones(3684, 1624, 280);
        defY = ones(3684, 1624, 280);
        defZ = ones(3684, 1624, 280);
        
        avgDef_x = avgDef_x + defX;
        avgDef_y = avgDef_y + defY;
        avgDef_z = avgDef_z + defZ;
        
        clear defX;
        clear defY;
        clear defZ;
    end

    img_out.datax = avgDef_x;
    img_out.datay = avgDef_y;
    img_out.dataz = avgDef_z;
    img_out.data = avgDef_x.^2+avgDef_y.^2+ avgDef_z.^2;
    
    clear avgDef_x;
    clear avgDef_y;
    clear avgDef_z;
    dst_suffix = 'I:\metamorphosis\deformationFields\';
    mv_cp = convertStringsToChars(mv_cp);
    mkdir([dst_suffix mv_cp]);
    path = [dst_suffix mv_cp '\deformationField.mhd'];
    fprintf("path is %s\n", path);
    f = write_mhd(path, img_out); 
end
