function h_computeMedianOfImages()
b3_path = 'I:\metamorphosis\deformationFields\B3\B3_out.tif';
b4_path = 'I:\metamorphosis\deformationFields\B4\B4_out.tif';
b5_path = 'I:\metamorphosis\deformationFields\B5\B5_out.tif';
b6_path = 'I:\metamorphosis\deformationFields\B6\B6_out.tif';
b7_path = 'I:\metamorphosis\deformationFields\B6\B7_out.tif';
b3_Flip_path = 'I:\metamorphosis\deformationFields\B3_Flip\B3_Flip_out.tif';
b4_Flip_path = 'I:\metamorphosis\deformationFields\B4_Flip\B4_Flip_out.tif';
b5_Flip_path = 'I:\metamorphosis\deformationFields\B5_Flip\B5_Flip_out.tif';
b6_Flip_path = 'I:\metamorphosis\deformationFields\B6_Flip\B6_Flip_out.tif';
b7_Flip_path = 'I:\metamorphosis\deformationFields\B6_Flip\B7_Flip_out.tif';

tiff_info = imfinfo(b3_path);
stack_size = size(tiff_info, 1);
b3 = imread(b3_path, 1);
[r,c] = size(b3);

output_stack = zeros(r,c,stack_size);

for no_of_stack = 1:stack_size
    b3 = imread(b3_path, no_of_stack);
    b4 = imread(b4_path, no_of_stack);
    b5 = imread(b5_path, no_of_stack);
    b6 = imread(b6_path, no_of_stack);
    b7 = imread(b7_path, no_of_stack);
    b3_Flip = imread(b3_Flip_path, no_of_stack);
    b4_Flip = imread(b4_Flip_path, no_of_stack);
    b5_Flip = imread(b5_Flip_path, no_of_stack);
    b6_Flip = imread(b6_Flip_path, no_of_stack);
    b7_Flip = imread(b7_Flip_path, no_of_stack);

    cat_Stack = cat(3, b3, b4, b5, b6, b7, b3_Flip, b4_Flip, b5_Flip, b6_Flip, b7_Flip);
    output_stack(:,:,no_of_stack) = median(cat_Stack, 3);
end
output = uint16(output_stack);
for ii = 1 : stack_size
imwrite(output(:,:,ii) , '18h_new_stack.tif' , 'WriteMode' , 'append') ;
end