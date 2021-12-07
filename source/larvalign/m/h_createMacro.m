%open("D:\\Harsha\\Files_Hiwi\\Datasets\\Standard_Brain\\25_Scaled_Tiff\\d4\\p\\2.tif");

%name = ["C:\\Users\\yogeshappa\\Documents\\Files_Hiwi\\Datasets\\Segmented_Files\\d3\\d3_"];
%for i = 1:430
%    file = ["open(" + '"' + name + num2str(i) + ".tif"  + '");'];
%    fprintf("%s\n",file);
%end
%closeStmt = ['run("Concatenate...", "all_open title=[Concatenated Stacks]");'];
%fprintf("%s\n", closeStmt);

name = ["D:\\Harsha\\Files_Hiwi\\Datasets\\Standard_Brain\\25_Scaled_Tiff\\d4\\p\\"];
for i = 1:100
    file = ["open(" + '"' + name + num2str(i) + ".tif"  + '");'];
    fprintf("%s\n",file);
end
closeStmt = ['run("Concatenate...", "all_open title=[Concatenated Stacks]");'];
fprintf("%s\n", closeStmt);