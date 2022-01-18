%%
%% Template registration framework for registration of the larval CNS of Drosophila melanogaster
%%
%% Author: Harsha Yogeshappa
%%
function msg = h_pipeline()

larvalign_path = "'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\meta18\'";
larvalign_path = convertStringsToChars(larvalign_path);
fid = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\larvalignMain.m");
C=textscan(fid,'%s','delimiter','\n');
fclose(fid);
template = C{1,1};
idxT=find(~cellfun(@isempty, strfind(template,'path_sfx =')));
template{idxT,1} = ['path_sfx = ' larvalign_path ';'];
fid = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\larvalignMain.m", 'w');
fprintf(fid,'%s\n',template{:});
fclose(fid);

fixed_images = ["'B3'","'B4'","'B5'", "'B6'","'B4_Flip'","'B5_Flip'", "'B6_Flip'", "'B3_Flip'", "'B3'"];
fixed_cp = ["B3","B4","B5", "B6","B4_Flip","B5_Flip", "B6_Flip", "B3_Flip", "B3"];
[rf,cf]=size(fixed_images);
for i=1:cf-1
    sc = convertStringsToChars(fixed_images(i+1));
    ex = convertStringsToChars(fixed_images(i));
    
    % Update the template files to D5 from D3.
    fid = fopen("D:\Harsha\Files_Hiwi\Scripts\find_replace_Template_string_18h.sh");
    C=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    template = C{1,1};
    idxT=find(~cellfun(@isempty, strfind(template,'sanction=')));
    template{idxT,1} = ['sanction=' sc];
    idxT=find(~cellfun(@isempty, strfind(template,'expunge=')));
    template{idxT,1} = ['expunge=' ex];
    fid = fopen("D:\Harsha\Files_Hiwi\Scripts\find_replace_Template_string_18h.sh", 'w');
    fprintf(fid,'%s\n',template{:});
    fclose(fid);
    fprintf("\n\nexpunging %s\n", ex);
    fprintf("sacntioning %s\n", sc);
    
    [status, cmdout] = system('D:\Harsha\Files_Hiwi\Scripts\find_replace_Template_string_18h.sh');
    if(status==0)
        fprintf("template script executed successfully.\n");
    else
        fprintf("template script failed.\n");
    end
    
    if(i==1) %B4
        moving_files = ["'B3'", "'B5'", "'B6'", "'B3_Flip'", "'B4_Flip'", "'B5_Flip'", "'B6_Flip'"];
        moving_cp = ["B3", "B5","B6", "B3_Flip", "B4_Flip", "B5_Flip", "B6_Flip" ];
    elseif(i==2) %B5
        moving_files = ["'B3'", "'B4'", "'B6'", "'B3_Flip'", "'B4_Flip'", "'B5_Flip'", "'B6_Flip'"];
        moving_cp = ["B3", "B4","B6", "B3_Flip", "B4_Flip", "B5_Flip", "B6_Flip" ];
    elseif(i==3) %B6
        moving_files = ["'B3'", "'B4'", "'B5'", "'B3_Flip'", "'B4_Flip'", "'B5_Flip'", "'B6_Flip'"];
        moving_cp = ["B3", "B4", "B5", "B3_Flip", "B4_Flip", "B5_Flip", "B6_Flip" ];
    elseif(i==4) %B4_Flip
        moving_files = ["'B3'", "'B4'", "'B5'", "'B6'", "'B3_Flip'", "'B5_Flip'", "'B6_Flip'"];
        moving_cp = ["B3", "B4", "B5","B6", "B3_Flip", "B5_Flip", "B6_Flip" ];
    elseif(i==5) %B5_Flip
        moving_files = ["'B3'", "'B4'", "'B5'", "'B6'", "'B3_Flip'", "'B4_Flip'", "'B6_Flip'"];
        moving_cp = ["B3", "B4", "B5","B6", "B3_Flip", "B4_Flip", "B6_Flip" ];
    elseif(i==6) %B6_Flip
        moving_files = ["'B3'", "'B4'", "'B5'", "'B6'", "'B3_Flip'", "'B4_Flip'", "'B5_Flip'"];
        moving_cp = ["B3", "B4", "B5","B6", "B3_Flip", "B4_Flip", "B5_Flip"];
    elseif(i==7) %B3_Flip
        moving_files = ["'B3'", "'B4'", "'B5'", "'B6'", "'B4_Flip'", "'B5_Flip'", "'B6_Flip'"];
        moving_cp = ["B3", "B4", "B5","B6", "B4_Flip", "B5_Flip", "B6_Flip" ];
    elseif(i==8) %B3
        moving_files = ["'B4'", "'B5'", "'B6'", "'B3_Flip'", "'B4_Flip'", "'B5_Flip'", "'B6_Flip'"];
        moving_cp = ["B4", "B5","B6", "B3_Flip", "B4_Flip", "B5_Flip", "B6_Flip" ];
    else
        fprintf("Unreachable code.\n");
    end
    
    [rm, cm] = size(moving_files);
    % Update the moving file in larvalignMain.m
    fid = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\larvalignMain.m");
    C=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    template = C{1,1};
    for j=1:cm % for a given template register all possible moving images.
        mv = convertStringsToChars(moving_files(j));
        idxT=find(~cellfun(@isempty, strfind(template,'fm =')));
        template{idxT,1} = ['fm = ' mv ';'];
        fid = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\larvalignMain.m", 'w');
        fprintf(fid,'%s\n',template{:});
        fclose(fid);
        
        % Debug msg for template.
        fid_debug = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\GenerateTransformParameterFile.m");
        C=textscan(fid_debug,'%s','delimiter','\n');
        fclose(fid_debug);
        template = C{1,1};
        idxT=find(~cellfun(@isempty, strfind(template,'atlasLabel=')));
        fprintf("\n\nThe template image being used is %s\n", template{idxT,1});
        
        % Debug msg for moving image.
        fid_debug = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\larvalignMain.m");
        C=textscan(fid_debug,'%s','delimiter','\n');
        fclose(fid_debug);
        template = C{1,1};
        idxT=find(~cellfun(@isempty, strfind(template,'fm =')));
        fprintf("The moving image being used is %s\n", template{idxT,1});
        
        fprintf("\nRegistration between %s and %s\n\n", mv, sc);
        % Run larvalignMain to perform registration.
        msg = larvalignMain();
        
        src_suffix = 'D:\Harsha\Files_Hiwi\Output\tmp\';
        src_prefix_raw = '\DIR\deformationField.raw';
        src_prefix_mhd = '\DIR\deformationField.mhd';
        dst_prefix_raw = '.raw';
        dst_prefix_mhd = '.mhd';
        %dst_suffix = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\deformationFields\deformationField_';
        
        move = convertStringsToChars(moving_cp(j));
        temp = convertStringsToChars(fixed_cp(i+1));
        
        dst_suffix = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\deformationFields\';
        dst_dir = [dst_suffix move '\' num2str(i)];
        mkdir(dst_dir);
        dst_dir = convertStringsToChars(dst_dir);
        src_raw = [src_suffix move src_prefix_raw];
        src_mhd = [src_suffix move src_prefix_mhd];
        
        dst_raw = [dst_dir '\deformationField' dst_prefix_raw];
        dst_mhd = [dst_dir '\deformationField' dst_prefix_mhd];
        
        LogFileID = fopen([dst_dir '\info.log'],'w');
        fprintf(LogFileID, "Copying deformation field from %s to %s-%s\n", move, move, temp);
        fclose(LogFileID);
        fprintf("Copying deformation field from %s to %s-%s\n", move, move, temp);
        copyfile(src_raw, dst_raw);
        copyfile(src_mhd, dst_mhd);
        
        out_suffix = 'D:\Harsha\Files_Hiwi\Output\RegisteredScans\TIFF\';
        out_file = [out_suffix move '.tif'];
        copyfile(out_file, dst_dir);
        %fprintf("src_raw, dst_raw: %s, %s\n", src_raw, dst_raw);
        %fprintf("src_mhd, dst_mhd: %s, %s\n", src_mhd, dst_mhd);
        
    end
end
end