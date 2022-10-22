%%
%% Template registration framework for registration of the larval CNS of Drosophila melanogaster
%%
%% Author: Harsha Yogeshappa
%%
function h_updateMovingFileinLarvalign(mv)
%% Update the moving file in larvalignMain.m file
fid = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\larvalignMain.m");
C=textscan(fid,'%s','delimiter','\n');
fclose(fid);
template = C{1,1};
idxT=find(~cellfun(@isempty, strfind(template,'fm =')));
template{idxT,1} = ['fm = ''' convertStringsToChars(mv) ''';'];
fid = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\larvalignMain.m", 'w');
fprintf(fid,'%s\n',template{:});
fclose(fid);
end