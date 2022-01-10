%%
%% Template registration framework for registration of the larval CNS of Drosophila melanogaster
%%
%% Author: Harsha Yogeshappa
%%
function status = h_pipeline1()

% Update the moving file in larvalignMain.m
fid = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\larvalignMain.m");
C=textscan(fid,'%s','delimiter','\n');
fclose(fid);
template = C{1,1};
idxT=find(~cellfun(@isempty, strfind(template,'fm =')));
template{idxT,1} = ['fm = ''D3'';'];
fid = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\larvalignMain.m", 'w');
fprintf(fid,'%s\n',template{:});
fclose(fid);

% Update the template files to D5 from D3.
fid = fopen("D:\Harsha\Files_Hiwi\Scripts\find_replace_Template_string.sh");
C=textscan(fid,'%s','delimiter','\n');
fclose(fid);
template = C{1,1};
idxT=find(~cellfun(@isempty, strfind(template,'sanction=')));
template{idxT,1} = ['sanction="D5"'];
idxT=find(~cellfun(@isempty, strfind(template,'expunge=')));
template{idxT,1} = ['expunge="D3"'];
fid = fopen("D:\Harsha\Files_Hiwi\Scripts\find_replace_Template_string.sh", 'w');
fprintf(fid,'%s\n',template{:});
fclose(fid);

[status, cmdout] = system('D:\Harsha\Files_Hiwi\Scripts\find_replace_Template_string.sh');
if(status==0)
    fprintf("find_replace_Template_string.sh executed successfully.\n");
else
    fprintf("find_replace_Template_string.sh failed.\n");
end

% Run larvalignMain to perform registration.
run larvalignMain.m

% Copy deformationFields.
copyfile("D:\Harsha\Files_Hiwi\Output\tmp\D3\DIR\deformationField.raw",...
    "D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\deformationFields\deformationField_3-5.raw");
copyfile("D:\Harsha\Files_Hiwi\Output\tmp\D3\DIR\deformationField.mhd",...
    "D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\deformationFields\deformationField_3-5.mhd");

end