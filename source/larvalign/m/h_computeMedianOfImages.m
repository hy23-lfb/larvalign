function h_computeMedianOfImages()
b3_path = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\deformationFields\B3\B3.tif';
b4_path = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\deformationFields\B4\B4.tif';
b5_path = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\deformationFields\B5\B5.tif';
b6_path = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\deformationFields\B6\B6.tif';
b3_Flip_path = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\deformationFields\B3_Flip\B3_Flip.tif';
b4_Flip_path = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\deformationFields\B4_Flip\B4_Flip.tif';
b5_Flip_path = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\deformationFields\B5_Flip\B5_Flip.tif';
b6_Flip_path = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\metamorphosis\deformationFields\B6_Flip\B6_Flip.tif';

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
    b3_Flip = imread(b3_Flip_path, no_of_stack);
    b4_Flip = imread(b4_Flip_path, no_of_stack);
    b5_Flip = imread(b5_Flip_path, no_of_stack);
    b6_Flip = imread(b6_Flip_path, no_of_stack);

    cat_Stack = cat(3, b3, b4, b5, b6, b3_Flip, b4_Flip, b5_Flip, b6_Flip);
    output_stack(:,:,no_of_stack) = median(cat_Stack, 3);
end
output = uint16(output_stack);
for ii = 1 : stack_size
imwrite(output(:,:,ii) , '18h_stack.tif' , 'WriteMode' , 'append') ;
end