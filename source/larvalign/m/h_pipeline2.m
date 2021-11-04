%%
%% Template registration framework for registration of the larval CNS of Drosophila melanogaster
%%
%% Author: Harsha Yogeshappa
%%
function msg = h_pipeline2(img_out)
warning('off','MATLAB:MKDIR:DirectoryExists');

%% Global Inits
tiff_info = imfinfo('D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\meta18\B3.tif');
tstack = imread('D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\meta18\B3.tif',1);
[c, r] = size(tstack);
z = size(tiff_info, 1);
move_images = ["'B3'", "'B4'", "'B5'", "'B6'", "'B7'", "'B3_Flip'","'B4_Flip'", "'B5_Flip'", "'B6_Flip'", "'B7_Flip'"];
move_images_cp = ["B3", "B4", "B5", "B6", "B7", "B3_Flip","B4_Flip", "B5_Flip", "B6_Flip", "B7_Flip"];

%% Flags
debug = 1;

h_updateLarvalignPath();

[r_move_images, c_move_images] = size(move_images);
noOfDefFields = c_move_images - 1;
fprintf("no of def fields is %g\n", noOfDefFields);

for mv_image_num = 1 : c_move_images
    %% Create new array for deformation fields for every new image.
    avgDef_x = zeros(r, c, z);
    avgDef_y = zeros(r, c, z);
    avgDef_z = zeros(r, c, z);
    
    %% Prepare the moving image name.
    mv = move_images{mv_image_num};
    mv_cp = move_images_cp{mv_image_num};
    % Update it to larvalignMain.m
    h_updateMovingFileinLarvalign(mv);
    
    %% Generate Template Lists for the give moving images.
    fixed_images = move_images;
    fixed_images_cp = move_images_cp;
    fixed_images(strcmp(move_images, move_images{mv_image_num})) = [];
    fixed_images_cp(strcmp(move_images_cp, move_images_cp{mv_image_num})) = [];
    [r_fix_images, c_fix_images] = size(fixed_images);
    
    %% Extract each Template file and register the moving image to it.
    for fx_image_num = 1 : c_fix_images
        fx_cp = fixed_images_cp{fx_image_num};
        
        %% Update the template files by calling script.
        sc = convertStringsToChars(fixed_images(fx_image_num));
        if(fx_image_num == 1)
            ex = convertStringsToChars(move_images(c_move_images));
        else
            ex = convertStringsToChars(fixed_images(fx_image_num-1));
        end
        h_updateScript(sc, ex);
        
        if(debug == 1)
            h_printDebugStmts();
        end
        
        msg = larvalignMain();
        
        src_prefix_mhd = '\DIR\deformationField.mhd';
        src_suffix = 'D:\Harsha\Files_Hiwi\Output\tmp\';
        mv_cp = convertStringsToChars(mv_cp);
        src_mhd = [src_suffix mv_cp src_prefix_mhd];
        fprintf("src_mhd is %s\n", src_mhd);
        fprintf("template is %s\n", fx_cp);
        
        [img, info] = read_mhd(src_mhd);
        multiplier = 1/noOfDefFields;
        defX = img.datax*multiplier;
        defY = img.datay*multiplier;
        defZ = img.dataz*multiplier;
        fprintf("processing of deformation field is done\n");
        
        avgDef_x = avgDef_x + defX;
        avgDef_y = avgDef_y + defY;
        avgDef_z = avgDef_z + defZ;
        
        clear defX;
        clear defY;
        clear defZ;
        clear img;
        clear info;
        
    end
    
    img_out.datax = single(avgDef_x);
    img_out.datay = single(avgDef_y);
    img_out.dataz = single(avgDef_z);
    img_out.data = img_out.datax.^2+img_out.datay.^2+ img_out.dataz.^2;
    
    clear avgDef_x;
    clear avgDef_y;
    clear avgDef_z;
    
    dst_suffix = 'I:\metamorphosis\deformationFields\';
    mv_cp = convertStringsToChars(mv_cp);
    mkdir([dst_suffix mv_cp]);
    path = [dst_suffix mv_cp '\deformationField.mhd'];
    fprintf("path is %s\n", path);
    f = write_mhd(path, img_out);
    
    img_out.datax = 0;
    img_out.datay = 0;
    img_out.dataz = 0;
    
    [status, message, messageid] = rmdir(src_suffix,'s');
    [status, message, messageid] = rmdir(fileparts(src_suffix));
end
end
