%%
%% Template registration framework for registration of the larval CNS of Drosophila melanogaster
%%
%% Author: Harsha Yogeshappa
%%
function h_updateLarvalignPath(srcFilePath)
larvalign_path = ['''' srcFilePath '\' ''''];

%% Update the path_sfx in larvalignMain.m
fid = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\larvalignMain.m");
C=textscan(fid,'%s','delimiter','\n');
fclose(fid);
template = C{1,1};
idxT=find(~cellfun(@isempty, strfind(template,'path_sfx =')));
template{idxT,1} = ['path_sfx = ' larvalign_path ';'];
fid = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\larvalignMain.m", 'w');
fprintf(fid,'%s\n',template{:});
fclose(fid);
end