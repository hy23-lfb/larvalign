function h_callWarp()

logstr = [datestr(datetime) sprintf(' -- CallWarp -- ')];
fprintf("%s\n", logstr);
move_images = ["'B3'", "'B4'", "'B5'", "'B6'", "'B7'", "'B3_Flip'","'B4_Flip'", "'B5_Flip'", "'B6_Flip'", "'B7_Flip'"];
move_images_cp = ["B3", "B4", "B5", "B6", "B7", "B3_Flip","B4_Flip", "B5_Flip", "B6_Flip", "B7_Flip"];

[r,c] = size(move_images);

for i = 1:c
    imFile = move_images_cp{i};
    h_WarpImages(imFile, "mhd");
end

end