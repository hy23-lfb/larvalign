%%
%%
%% Author: Harsha Yogeshappa
%%
function h_updateScript(sc, ex)

filename = "D:\Harsha\Repository\larvalign\source\larvalign\m\helperScripts\updateTemplates_18h.sh";
fid = fopen(filename);
C=textscan(fid,'%s','delimiter','\n');
fclose(fid);
template = C{1,1};
idxT=find(~cellfun(@isempty, strfind(template,'sanction=')));
template{idxT,1} = ['sanction=' sc];
idxT=find(~cellfun(@isempty, strfind(template,'expunge=')));
template{idxT,1} = ['expunge=' ex];
fid = fopen(filename, 'w');
fprintf(fid,'%s\n',template{:});
fclose(fid);
fprintf("expunging %s\n", ex);
fprintf("sacntioning %s\n", sc);

filename = convertStringsToChars(filename);
[status, ~] = system(filename);
if(status==0)
    fprintf("template script executed successfully.\n");
else
    fprintf("template script failed.\n");
end
end