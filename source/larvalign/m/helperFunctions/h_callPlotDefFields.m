function h_callPlotDefFields()

files = ["B4", "B5", "B6", "B3_Flip", "B4_Flip", "B5_Flip", "B6_Flip"];
path = 'I:\metamorphosis\deformationFields\B3\';

[~, c] = size(files);
for i = 6 : 6
    name = files{i};
    path1 = [path name '\deformationField.mhd'];
    fprintf("%s\n", path1);
    h_plotDefFields(path1, name);
end