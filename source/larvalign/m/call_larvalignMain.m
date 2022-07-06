function call_larvalignMain(src_filepath, findNPChannel)
warning('off','MATLAB:MKDIR:DirectoryExists');

src_filepath = convertStringsToChars(src_filepath);

dir_list = dir(src_filepath);
len_dir  = length(dir_list);

% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    file_or_folder_name = dir_list(dirIdx).name;
    file_or_folder_path = join(src_filepath, file_or_folder_name);
    if (isfile(file_or_folder_path))
		filepath = file_or_folder_path;
        if ((endsWith(file_or_folder_name, '.lsm')) || (endsWith(file_or_folder_name, '.tif')))
			larvalignMain(filepath, findNPChannel);
        end
    end
end
end

function str3 = join(str1, str2)
str3 = [str1 '\' str2];
end