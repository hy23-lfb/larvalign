function [status, cmdout] = h_generateTemplateFiles(src_filepath)
%%
%% Generate mhd files out of tif files.
%%
%% Author: Harsha Yogeshappa
%%

warning('off','MATLAB:MKDIR:DirectoryExists');

src_filepath = convertStringsToChars(src_filepath);

dir_list = dir(src_filepath);
len_dir  = length(dir_list);

images = {};
% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    filename = dir_list(dirIdx).name;
    filepath = fullfile(src_filepath, filename);
    if (isfile(filepath))
        if ((endsWith(filename, '.lsm')) || (endsWith(filename, '.tif')))
            filename = convertCharsToStrings(filename);
			images = [images, filename];
        end
    end
end

count = length(images);

% Create mhd files.
[status, cmdout] = h_tif2mhd(count, src_filepath, images);

% for all the created files, create template files.
for j=1:count
    tic
    
    [~, file, ~] = fileparts(images(j));
    file = convertStringsToChars(file);

    h_createTemplateFiles(src_filepath, file);
    
    t = toc;
    logstr = [datestr(datetime) sprintf(' -- TemplateCreation for %g took: %g s', j, t)];
    fprintf([logstr '\n\n']);
end

end