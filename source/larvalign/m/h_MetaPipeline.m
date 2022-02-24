%%
%% Pipeline to perform pair-wise image registrations in a loop for metamorphosis image dataset.
%%
%% Author: Harsha Yogeshappa
%%
function msg = h_MetaPipeline(srcFilePath)
warning('off','MATLAB:MKDIR:DirectoryExists');

%% Global Paths
df_srcPath_prefix = 'D:\Harsha\Files_Hiwi\Output\tmp\';
df_srcPath_suffix = '\DIR\deformationField.mhd';
df_dstPath_suffix = 'I:\metamorphosis\deformationFields\';
avg_df_path = 'D:\Harsha\Files_Hiwi\Output\';

%% Global Inits
% Get the image dimensions. Needed for initializing the deformation fields.
% Dimensions of deformation fields are :
% image_width x image_height x no_of_slices x 3
b3_file = [srcFilePath '\B3.tif'];
tiff_info = imfinfo(b3_file);
tstack = imread(b3_file,1);
[c, r] = size(tstack);
z = size(tiff_info, 1);

% Two separate arrays.
% Used to update the name of the files in the program.
movImages = ["'B3'", "'B4'", "'B5'", "'B6'", "'B7'", "'B3_Flip'","'B4_Flip'", "'B5_Flip'", "'B6_Flip'", "'B7_Flip'"];
% Used to create directories or read files from the existing directories.
movImages_cp = ["B3", "B4", "B5", "B6", "B7", "B3_Flip", "B4_Flip", "B5_Flip", "B6_Flip", "B7_Flip"];

[~, c_movImages] = size(movImages);
numOfPairWiseRegistrations = c_movImages - 1;
fprintf("Number of pair wise registrations are %g\n", numOfPairWiseRegistrations);

%% Flags
debug = 1;
saveDefFields = 1;

%% Begin Pipeline
srcFilePath = convertStringsToChars(srcFilePath);

% Inform larvalignMain.m where the source files are stored.
h_updateLarvalignPath(srcFilePath);

% Iterate through each moving images.
for itr_movImg = 1 : c_movImages
    
    % Every image (moving image) is registered against every other
    % available images (fixed images). The individual deformation fields
    % are then averaged to create an average space. Thus, every moving
    % image will have its own 'averaged deformation field', and it is
    % initialized here with zeros, at the beginning of the loop.
    avgDef_x = zeros(r, c, z);
    avgDef_y = zeros(r, c, z);
    avgDef_z = zeros(r, c, z);
    
    % Get the current moving image.
    mv = movImages{itr_movImg};
    
    % Inform larvalignMain.m the name of the moving image that will be
    % used.
    h_updateMovingFileinLarvalign(mv);
    
    % Generate Template List for the give moving images.
    fixed_images = movImages;
    fixed_images_cp = movImages_cp;
    
    % fixed images are all images except the current moving image.
    fixed_images(strcmp(movImages, movImages{itr_movImg})) = [];
    fixed_images_cp(strcmp(movImages_cp, movImages_cp{itr_movImg})) = [];
    % c_fixImages will always be one less than c_movImages.
    [~, c_fixImages] = size(fixed_images);
    
    mv_cp = movImages_cp{itr_movImg};
    mv_cp = convertStringsToChars(mv_cp);
    
    mv_Dir = [df_dstPath_suffix mv_cp];
    mkdir(mv_Dir);
    avg_Dir = [avg_df_path mv_cp];
    mkdir(avg_Dir);
    
    % Iterate through each template image and register the moving image
    % against it.
    for itr_fixImg = 1 : c_fixImages
        fx_cp = fixed_images_cp{itr_fixImg};
        fx_cp = convertStringsToChars(fx_cp);
        
        % Copy template files to 'Neuropil' directory and inform relevant
        % files.
        h_updateTemplateImages(fixed_images, movImages, itr_fixImg, c_movImages);
        pause(10);
        
        if(debug == 1)
            h_printDebugStmts();
        end
        
        % Trigger Image Registration between the moving image and the fixed
        % image.
        msg = larvalignMain();
        
        defField = [df_srcPath_prefix mv_cp df_srcPath_suffix];
        
        %{
        if(saveDefFields)
            cpMhd = [df_dstPath_suffix mv_cp '\' fx_cp];
            mkdir(cpMhd);
            def_mhd = [df_srcPath_prefix mv_cp '\DIR\deformationField.mhd'];
            def_raw = [df_srcPath_prefix mv_cp '\DIR\deformationField.raw'];
            
            copyfile(def_mhd, cpMhd);
            copyfile(def_raw, cpMhd);
            pause(10);
        end
        %}
        
        [img, ~] = read_mhd(defField);
        
        if(saveDefFields)
            figureName = [mv_cp '_' fx_cp];
            h_indDefFields(img, mv_Dir, figureName);
        end
        
        multiplier = 1 / numOfPairWiseRegistrations;
        defX = img.datax*multiplier;
        defY = img.datay*multiplier;
        defZ = img.dataz*multiplier;
        if(debug == 1)
            fprintf("defField is %s\n", defField);
            fprintf("processing of deformation field is done\n");
        end
        
        avgDef_x = avgDef_x + defX;
        avgDef_y = avgDef_y + defY;
        avgDef_z = avgDef_z + defZ;
        
        clear defX;
        clear defY;
        clear defZ;
        if(itr_fixImg ~= c_fixImages)
            % Clear until last iteration. This is done to handle to the
            % out-of-memory issue that is arising for full-scale
            % metamorphosis images on MatLab.
            % Do not clear for last iteration because this shall be used to
            % write to the mhd file.
            clear img;
        end
        [status, message, messageid] = rmdir(df_srcPath_prefix,'s');
        [status, message, messageid] = rmdir(fileparts(df_srcPath_prefix));
        pause(10);
    end
    
    img.datax = single(avgDef_x);
    img.datay = single(avgDef_y);
    img.dataz = single(avgDef_z);
    img.data = img.datax.^2 + img.datay.^2 + img.dataz.^2;
    
    clear avgDef_x;
    clear avgDef_y;
    clear avgDef_z;
    
    deffieldPFN = [avg_Dir '\deformationField.mhd'];
    fprintf("path is %s\n", deffieldPFN);
    
    f = write_mhd(deffieldPFN, img);
    % pause?? or error code..
    % writing operation is done, clear 'img' now.
    
    exeDir = 'C:\Program Files\Convert3D\bin\';
    c3d = ['"' exeDir 'c3d.exe" '];
    
    WNP = [srcFilePath '\mhd\'];
    srcNPPFN = [WNP mv_cp '.mhd'];
    
    operation='  -interpolation cubic -warp -clip 0 65535 -type ushort -compress -o  ';
    warpCmd = [c3d '-mcs ' '"' deffieldPFN '"' ' -popas defZ -popas defY -popas defX '...
        ' -push defX -push defY -push defZ ' '"' srcNPPFN '"' operation '"' mv_Dir '\' mv_cp '.tif' '"'];
    fprintf("Warping Average Deformation Field %s\n\n", warpCmd);
    
    tic
    [status,cmdout] = system(warpCmd);
    assert(status==0, [datestr(datetime) sprintf([' -- Warping of scan:  ' mv_cp '  failed.\n' cmdout])] )
    t=toc;
    logstr = [datestr(datetime) sprintf(' -- Warping took: %g s' ,t)];
    fprintf("logstr is %s\n", logstr);
    rmdir(avg_Dir, 's');
    
    clear img;
end
end
