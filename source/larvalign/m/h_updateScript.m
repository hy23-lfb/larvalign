%%
%% Template registration framework for registration of the larval CNS of Drosophila melanogaster
%%
%% Author: Harsha Yogeshappa
%%
function h_updateScript(sc, ex)

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
fprintf("expunging %s\n", ex);
fprintf("sacntioning %s\n", sc);

[status, cmdout] = system('D:\Harsha\Files_Hiwi\Scripts\find_replace_Template_string_18h.sh');
if(status==0)
    fprintf("template script executed successfully.\n");
else
    fprintf("template script failed.\n");
end
end