function [L, J, centers, sorted_centers, idx, r1, c1, no_of_slices] = h_colorscaleImage(imagename)
%%
%% Input: the name of image only.
%% Change the filepath here, if required.
%%
    filepath_in = 'C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\';
    
    input_img = convertStringsToChars(imagename);
    ext = '.tif';
    file_in = [filepath_in input_img ext];
        
    %% Input file
    tiff_info = imfinfo(file_in);
    no_of_slices = size(tiff_info, 1);
    I = imread(file_in, 1);
    [r1, c1] = size(I);
    temp = imread(file_in, 2);
    I = cat(1, I, temp);
    for i = 3 : no_of_slices
        temp = imread(file_in, i);
        I = cat(1, I, temp);
    end

    %% L is the labeled output described by the centers.
    [L, centers] = imsegkmeans(I, 256);
    
    %% centers are now sorted.
    [sorted_centers , idx] = sort(centers);
    
    %% new labeled output J is generated according to sorted centers.
    [r, c] = size(I);
    J = zeros(r, c);
    for i = 1 : r
        for j = 1 : c
            J(i,j) = find(idx == L(i,j));
        end
    end
    
    %% Generate color-scaled output.
    % sorted_centers contain intensity values derived from the original
    % image. Therefore, using sorted_centers(J(i,j)) would give us
    % value between 0 and maxIntesity i.e., ~3000.
    
    % However, what we need is value between 0 and 255. Thus, we shall use
    % indices to label J. These indices are sorted in increasing order.
    
    % Larger intensity value would get larger index value. Therefore,
    % maintaining similar intenstiy profile.
    
    % J is between 1 and 256, and is of type 'double'. Therefore, have to
    % decrease the value by 1 and typecast it to uint8.
    
    J = uint8(J-1);

end
