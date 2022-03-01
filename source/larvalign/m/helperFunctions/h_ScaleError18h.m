function h_ScaleError18h()
warpCmd_25 = ["""D:\Harsha\Repository\larvalign\source\larvalign\resources\exe\c3d.exe"" -mcs ""D:\Harsha\Error_Warp\scale_25\deformationField.mhd"" -popas defZ -popas defY -popas defX -push defX -push defY -push defZ ""D:\Harsha\Error_Warp\scale_25\B4.mhd"" -interpolation cubic -warp -clip 0 255 -type uchar -compress -o ""res25.mhd"""];
warpCmd_50 = ["""D:\Harsha\Repository\larvalign\source\larvalign\resources\exe\c3d.exe"" -mcs ""D:\Harsha\Error_Warp\scale_50\deformationField.mhd"" -popas defZ -popas defY -popas defX -push defX -push defY -push defZ ""D:\Harsha\Error_Warp\scale_50\B3.mhd"" -interpolation cubic -warp -clip 0 255 -type uchar -compress -o ""res50.mhd"""];
[status50, cmdout50] = system(warpCmd_50);
[status25, cmdout25] = system(warpCmd_25);
end