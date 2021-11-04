%%
%% Template registration framework for registration of the larval CNS of Drosophila melanogaster
%%
%% Author: Harsha Yogeshappa
%%
function h_printDebugStmts()
fid_debug = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\larvalignMain.m");
C=textscan(fid_debug,'%s','delimiter','\n');
fclose(fid_debug);
template = C{1,1};
idxT=find(~cellfun(@isempty, strfind(template,'fm =')));
%fprintf("Moving Image in Larvalign is %s\n", template{idxT,1});
harsha = template{idxT, 1};

fprintf("\nMoving Image in Larvalign is %s\n", harsha);
fid_debug = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\GenerateTransformParameterFile.m");
C=textscan(fid_debug,'%s','delimiter','\n');
fclose(fid_debug);
template = C{1,1};
idxT=find(~cellfun(@isempty, strfind(template,'atlasLabel=')));
fprintf("The template image GenerateTransform PP is %s\n", template{idxT,1});

fid_debug = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\Subject2TemplateRegistration.m");
C=textscan(fid_debug,'%s','delimiter','\n');
fclose(fid_debug);
template = C{1,1};
idxT=find(~cellfun(@isempty, strfind(template,'atlasLabel=')));
fprintf("The template image Subject2Template PP is %s\n", template{idxT,1});
idxT=find(~cellfun(@isempty, strfind(template,'atlasMaskN=')));
fprintf("The template image Subject2Template Mask is %s\n", template{idxT,1});

fid_debug = fopen("D:\Harsha\Repository\larvalign\source\larvalign\m\ZflipRotationRegistration.m");
C=textscan(fid_debug,'%s','delimiter','\n');
fclose(fid_debug);
template = C{1,1};
idxT=find(~cellfun(@isempty, strfind(template,'atlasLabel=')));
fprintf("The template image ZFlipRotation PP is %s\n", template{idxT,1});
idxT=find(~cellfun(@isempty, strfind(template,'atlasSDTN=')));
fprintf("The template image ZFlipRotation SDT is %s\n\n", template{idxT,1});
end