%%
%% Template registration framework for registration of the larval CNS of Drosophila melanogaster
%%
%% Author: Harsha Yogeshappa
%%
function [defX, defY, defZ]=h_processDeformationField(src_mhd, noOfDefFields)

src_prefix_mhd = '\DIR\deformationField.mhd';
src_suffix = convertStringsToChars(src_suffix);
mv_cp = convertStringsToChars(mv_cp);
src_mhd = [src_suffix mv_cp src_prefix_mhd];

[img, info] = read_mhd(src_mhd);
multiplier = 1/noOfDefFields;
defX = img.datax*multiplier;
defY = img.datay*multiplier;
defZ = img.dataz*multiplier;
fprintf("processing of deformation field is done\n");

end