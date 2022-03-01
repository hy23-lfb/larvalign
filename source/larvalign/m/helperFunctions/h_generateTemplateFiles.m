function [status, cmdout] = h_generateTemplateFiles(scount, ecount)
%%
%% Generate mhd files out of tif files.
%%
%% Author: Harsha Yogeshappa
%%

warning('off','MATLAB:MKDIR:DirectoryExists');
fname_prefix = 'rich_';
fname_suffix = '';
path_suffix = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\meta_rich\';
% Create mhd files.
[status, cmdout] = h_tif2mhd(scount, ecount, path_suffix, fname_prefix, fname_suffix);

% for all the created files, create template files.
for j=scount:ecount
    tic
    i = num2str(j);
    file=[fname_prefix i fname_suffix];
    h_createTemplateFiles(path_suffix, file);
    t = toc;
    logstr = [datestr(datetime) sprintf(' -- TemplateCreation for %g took: %g s', j, t)];
    fprintf([logstr '\n\n']);
end
end