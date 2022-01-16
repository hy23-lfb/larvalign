function [status, cmdout] = h_generateTemplateFiles(scount, ecount, path_suffix)
%%
%% Generate mhd files out of tif files.
%%
%% Author: Harsha Yogeshappa
%%
warning('off','MATLAB:MKDIR:DirectoryExists');

% Create mhd files.
[status, cmdout] = h_tif2mhd(scount, ecount, path_suffix);

% for all the created files, create template files.
for j=scount:ecount
   i = num2str(j);
   file=['D' i];
   h_createTemplateFiles(path_suffix, file);
end
end