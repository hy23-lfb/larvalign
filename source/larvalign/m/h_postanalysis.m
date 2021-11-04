function h_postanalysis
%%
%% Create template files for registration
%%
%% Author: Harsha Yogeshappa
%%
FijiExe = [' "D:\Harsha\Repository\larvalign\source\larvalign\resources\exe\Fiji\ImageJ-win64.exe" ' ];
[status,cmdout] = system([FijiExe ' --headless -macro "postAnalysis.txt"']);
fprintf("status is %d\n", status);
end