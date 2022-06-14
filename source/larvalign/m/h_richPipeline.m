%%
%% Pipeline to perform pair-wise image registrations in a loop for rich
%% image dataset.
%%
%% Author: Harsha Yogeshappa
%%
function msg = h_richPipeline(srcFilePath)
warning('off','MATLAB:MKDIR:DirectoryExists');

%% Begin Pipeline
srcFilePath = convertStringsToChars(srcFilePath);

%% Global Inits
% Get the image dimensions.
rich_file = [srcFilePath '\rich_1.tif'];
tiff_info = imfinfo(rich_file);
%z = size(tiff_info, 1);
z = 30;
tstack = imread(rich_file,1);
[c, r] = size(tstack);
%%
% Used to create directories or read files from the existing directories.
movImages = ["rich_1", "rich_2", "rich_3", "rich_4", "rich_5", "rich_6"];
[~, c_movImages] = size(movImages);

[optimizer, metric] = imregconfig('multimodal');
mvng = imread([srcFilePath '\rich_1.tif'], 1);
% only to capture structure of tform.
tform_ref = imregtform(mvng, mvng, 'affine', optimizer, metric);

% Iterate through each moving images.
for itr_movImg = 2 : c_movImages
    % Get the current moving image.
    mv = movImages{itr_movImg};
    mv = convertStringsToChars(mv);

    % Generate Template List for the give moving images.
    % fixed images are all images except the current moving image.
    fixed_images = movImages;
    fixed_images(strcmp(movImages, movImages{itr_movImg})) = [];
    
    % c_fixImages will always be one less than c_movImages.
    [~, c_fixImages] = size(fixed_images);

    for slice = 1 : z
        srcfile = [srcFilePath '\' mv '.tif'];
        moving = imread(srcfile, slice);
       
        eul = [0 0 0];
        trn = [0;0];
        b_first = true;

        dstfile = [srcFilePath '\template\' mv '.tif'];

        % Iterate through each template image and register the moving image
        % against it.
        for itr_fixImg = 1 : c_fixImages
            fx = fixed_images{itr_fixImg};
            fx = convertStringsToChars(fx);

            srcfile = [srcFilePath '\' fx '.tif'];
            fixed = imread(srcfile, slice);
            
            %% compute affine transformation matrix for each slice
            
            tform = imregtform(moving, fixed, 'affine', optimizer, metric);
            T = transpose(tform.T);
            [eul, trn] = h_computeMeanAffineTransformation(T, b_first, eul, trn);
            
            fprintf("mv: %s, fx: %s\n", mv, fx);
            %fprintf("srcfile: %s\n", srcfile);
            b_first = false;
        end
        mat = h_buildAffineTransformation(eul, trn);
        mat
        tform_ref.T = transpose(mat);
        reg = imwarp(moving, tform_ref,'OutputView',imref2d([c, r]));

        imwrite(reg, dstfile , 'WriteMode' , 'append')
        %fprintf("dstfile: %s\n", dstfile)
        fprintf("slice: %d\n", slice);
        fprintf("\n");
    end
end

end