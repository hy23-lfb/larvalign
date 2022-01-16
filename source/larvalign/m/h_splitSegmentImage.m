function h_splitSegmentImage(r, c, J)
u = 1;
v = r;
output_file = 'C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Segmented_Files\d3\';
for i = 1 : no_of_slices
   filename = [output_file, num2str(i), '.tif'];
   tbd = J(u:v, 1:c);
   imwrite(tbd, filename);
   u = u + r;
   v = v + r;
end