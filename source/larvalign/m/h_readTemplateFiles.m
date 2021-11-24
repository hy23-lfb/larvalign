function [in, pp, sdt, mask] = h_readTemplateFiles(getD3, getD4, getD5, getD6)
%%
%% read template files to an array.
%%
%% Author: Harsha Yogeshappa
%%

%% D3 images
if (getD3)
    [d3in, map] = ReadData3D("C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\mhd\72h_brain_2101_D3_NCad_CLAHE-25.mhd");
    [d3pp, map] = ReadData3D("C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\mhd\template\D3\72h_brain_2101_D3_NCad_CLAHE-25_PP.mhd");
    [d3sdt, map] = ReadData3D("C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\mhd\template\D3\72h_brain_2101_D3_NCad_CLAHE-25_SDT.mhd");
    [d3mask, map] = ReadData3D("C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\mhd\template\D3\72h_brain_2101_D3_NCad_CLAHE-25_MASK.mhd");
    in = d3in; pp = d3pp; sdt = d3sdt; mask = d3mask;
end

%% D4 images
if (getD4)
    [d4in, map] = ReadData3D("C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\mhd\72h_brain_2101_D4_NCad_CLAHE-25.mhd");
    [d4pp, map] = ReadData3D("C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\mhd\template\D4\72h_brain_2101_D4_NCad_CLAHE-25_PP.mhd");
    [d4sdt, map] = ReadData3D("C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\mhd\template\D4\72h_brain_2101_D4_NCad_CLAHE-25_SDT.mhd");
    [d4mask, map] = ReadData3D("C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\mhd\template\D4\72h_brain_2101_D4_NCad_CLAHE-25_MASK.mhd");
    in = d4in; pp = d4pp; sdt = d4sdt; mask = d4mask;
end

%% D5 images
if (getD5)
    [d5in, map] = ReadData3D("C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\mhd\72h_brain_2101_D5_NCad_CLAHE-25.mhd");
    [d5pp, map] = ReadData3D("C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\mhd\template\D5\72h_brain_2101_D5_NCad_CLAHE-25_PP.mhd");
    [d5sdt, map] = ReadData3D("C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\mhd\template\D5\72h_brain_2101_D5_NCad_CLAHE-25_SDT.mhd");
    [d5mask, map] = ReadData3D("C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\mhd\template\D5\72h_brain_2101_D5_NCad_CLAHE-25_MASK.mhd");
    in = d5in; pp = d5pp; sdt = d5sdt; mask = d5mask;
end
%% D6 images
if (getD6)
    [d6in, map] = ReadData3D("C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\mhd\72h_brain_2101_D6_NCad_CLAHE-25.mhd");
    [d6pp, map] = ReadData3D("C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\mhd\template\D6\72h_brain_2101_D6_NCad_CLAHE-25_PP.mhd");
    [d6sdt, map] = ReadData3D("C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\mhd\template\D6\72h_brain_2101_D6_NCad_CLAHE-25_SDT.mhd");
    [d6mask, map] = ReadData3D("C:\Users\yogeshappa\Documents\Files_Hiwi\Datasets\Scaled_Files\mhd\template\D6\72h_brain_2101_D6_NCad_CLAHE-25_MASK.mhd");
    in = d6in; pp = d6pp; sdt = d6sdt; mask = d6mask;
end
end