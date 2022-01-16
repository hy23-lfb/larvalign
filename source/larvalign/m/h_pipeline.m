%%
%% Template registration framework for registration of the larval CNS of Drosophila melanogaster
%%
%% Author: Harsha Yogeshappa
%%
function msg = h_pipeline()

fixed_images = ["'D3'","'D5'","'D6'", "'D3'"];
fixed_cp = ["D3","D5","D6", "D3"];
[rf,cf]=size(fixed_images);
for i=1:cf-1
    sc = convertStringsToChars(fixed_images(i+1));
    ex = convertStringsToChars(fixed_images(i));
    
    % Update the template files to D5 from D3.
    fid = fopen("D:\Harsha\Files_Hiwi\Scripts\find_replace_Template_string.sh");
    C=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    template = C{1,1};
    idxT=find(~cellfun(@isempty, strfind(template,'sanction=')));
    template{idxT,1} = ['sanction=' sc];
    idxT=find(~cellfun(@isempty, strfind(template,'expunge=')));
    template{idxT,1} = ['expunge=' ex];
    fid = fopen("D:\Harsha\Files_Hiwi\Scripts\find_replace_Template_string.sh", 'w');
    fprintf(fid,'%s\n',template{:});
    fclose(fid);
    
    [status, cmdout] = system('D:\Harsha\Files_Hiwi\Scripts\find_replace_Template_string.sh');
    if(status==0)
        fprintf("\n find_replace_Template_string.sh executed successfully.\n");
    else
        fprintf("\n find_replace_Template_string.sh failed.\n");
    end
    
    if(i==1)
        moving_files = ["'D3'", "'D6'", "'D3_Flip'","'D6_Flip'"];
        moving_cp = ["D3", "D6","D3_Flip","D6_Flip"];
    elseif(i==2)
        moving_files = ["'D3'", "'D5'","'D3_Flip'","'D5_Flip'"];
        moving_cp = ["D3", "D5","D3_Flip","D5_Flip"];
    elseif(i==3)
        moving_files = ["'D5'", "'D6'","'D5_Flip'", "'D6_Flip'"];
        moving_cp = ["D5", "D6","D5_Flip", "D6_Flip"];
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
        
        fprintf("\n\nRegistration between %s and %s\n\n", mv, sc);
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