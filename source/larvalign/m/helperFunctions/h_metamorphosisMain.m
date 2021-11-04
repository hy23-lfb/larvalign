function h_metamorphosisMain()
%%
%% Register individual images to target spaces.
%%
%% Author: Harsha Yogeshappa
%%
    %{
    [status, cmdout] = system('D:\Harsha\Files_Hiwi\Scripts\reset.sh');
    if(status==0)
        fprintf("\n Conditions are reset.\n");
    else
        fprintf("\n reset.sh failed.\n");
    end
    %}
    h_pipeline();
    f = input("Rename the files: ");
    path_suffix = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\deformationFields\';
    h_avgDeformationField(path_suffix);
    h_registerToTargetSpace();
end