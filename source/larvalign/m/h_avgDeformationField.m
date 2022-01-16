function h_avgDeformationField(path_suffix)
%%
%% Create average deformation field.
%%
%% Author: Harsha Yogeshappa
%%
img_files = ["B3", "B4", "B5","B6"];
[r,c] = size(img_files);
for j=1:c
    noOfDefFields = 3;
    multiplier = 1/noOfDefFields;
    imgname = convertStringsToChars(img_files(j));
    path = [path_suffix imgname '\' num2str(1) '\deformationField.mhd'];
    path = convertStringsToChars(path);
    %fprintf("path is %s\n", path);
    [img, info] = read_mhd(path);
    x = img.datax*multiplier;
    y = img.datay*multiplier;
    z = img.dataz*multiplier;
    for no=2:noOfDefFields
        ex = num2str(no);
        path = [path_suffix imgname '\' ex '\deformationField.mhd'];
        path = convertStringsToChars(path);
        %fprintf("path is %s\n", path);
        [imgt, infot] = read_mhd(path);
        xt = imgt.datax*multiplier;
        yt = imgt.datay*multiplier;
        zt = imgt.dataz*multiplier;
        
        x = x + xt;
        y = y + yt;
        z = z + zt;
    end
    img_out = img;
    img_out.datax = x;
    img_out.datay = y;
    img_out.dataz = z;
    img_out.data = x.^2+y.^2+z.^2;
    
    path = [path_suffix imgname '\deformationField.mhd'];
    path = convertStringsToChars(path);
    %fprintf("path is %s\n", path);
    fprintf("Averaged %s's deformation field\n", imgname);
    f = write_mhd(path, img_out);
end
end