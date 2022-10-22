%%
%%
%% Author: Harsha Yogeshappa
%%

function h_updateTemplateImages(fixed_images, movImages, itr_fixImg, c_movImages)
% files that are to be copied (sanctioned) to 'Neuropil' directory.
sc = convertStringsToChars(fixed_images(itr_fixImg));
[~, sc, ~] = fileparts(sc);
if(itr_fixImg == 1)
    % assumption is that at the beginning of the iteration, the template
    % files for B7_Flip are available. So, those files needs to be first
    % deleted (expunged).
    ex = convertStringsToChars(movImages(c_movImages));
    [~, ex, ~] = fileparts(ex);
else
    % in the later iterations, whichever files that were previously copied
    % (sanctioned) to 'Neuropil' directory shall now be deleted
    % (expunged).
    ex = convertStringsToChars(fixed_images(itr_fixImg-1));
    [~, ex, ~] = fileparts(ex);
end
% shell script is used to achieve this deleting and copying.
h_updateScript(sc, ex);
end