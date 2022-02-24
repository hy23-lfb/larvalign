function h_computeMedianOfImages()
c3_path = 'I:\metamorphosis\deformationFields\25p_24h\C3\C3.tif';
c4_path = 'I:\metamorphosis\deformationFields\25p_24h\C4\C4.tif';
c5_path = 'I:\metamorphosis\deformationFields\25p_24h\C5\C5.tif';
c3_flip_path = 'I:\metamorphosis\deformationFields\25p_24h\C3_Flip\C3_Flip.tif';
c4_flip_path = 'I:\metamorphosis\deformationFields\25p_24h\C4_Flip\C4_Flip.tif';
c5_flip_path = 'I:\metamorphosis\deformationFields\25p_24h\C5_Flip\C5_Flip.tif';

tiff_info = imfinfo(c3_path);
stack_size = size(tiff_info, 1);
c3 = imread(c3_path, 1);
[r,c] = size(c3);

output_stack = zeros(r,c,stack_size);

for no_of_stack = 1:stack_size
    c3 = imread(c3_path, no_of_stack);
    c4 = imread(c4_path, no_of_stack);
    c5 = imread(c5_path, no_of_stack);
    c3_Flip = imread(c3_flip_path, no_of_stack);
    c4_Flip = imread(c4_flip_path, no_of_stack);
    c5_Flip = imread(c5_flip_path, no_of_stack);

    cat_Stack = cat(3, c3, c4, c5, c3_Flip, c4_Flip, c5_Flip);
    output_stack(:,:,no_of_stack) = median(cat_Stack, 3);
end
output = uint16(output_stack);
for ii = 1 : stack_size
imwrite(output(:,:,ii) , '24h_new_stack.tif' , 'WriteMode' , 'append') ;
end