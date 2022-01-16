output_file = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\25_Scaled_Tiff\d4\p\';
for i = 1 : 100
   filename = [output_file, num2str(i), '.tif'];
   in = imread("D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\25_Scaled_Tiff\d4\stk_0006_72h_brain_2101_D4_NCad_CLAHE_resized-1.tif", i);
   out = in .* mask;
   imwrite(out, filename);
end