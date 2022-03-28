function h_computePercentDefField()

warning('off','MATLAB:MKDIR:DirectoryExists');

path = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\important\18Lin-24-Nonlinear_Register\percents\';

sPercent = 0.05;
folders = ["5p", "10p", "15p", "20p", "25p", "30p", "35p", "40p", "45p", "50p", "55p", "60p", "65p", "70p", "75p", "80p", "85p", "90p", "95p", "100p"];

[~, c] = size(folders);

for i = 1:c
    fol = folders{i};
    fol = convertStringsToChars(fol);
    
    filedir = [path fol];
    mkdir(filedir);
    
    [df, ~] = read_mhd('D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\important\18Lin-24-Nonlinear_Register\deformationField\deformationField.mhd');

    fprintf("iteration %d\n", i);
    
    fprintf("df\n");
    df.datax(100:105, 100:105)
    
    img = df;
    
    fprintf("percent is %d\n", sPercent*i);
    img.datax = df.datax * sPercent * i;
    img.datay = df.datay * sPercent * i;
    img.dataz = df.dataz * sPercent * i;
    
    fprintf("img\n");
    img.datax(100:105, 100:105)
    
    img.data = img.datax.^2 + img.datay.^2 + img.dataz.^2;
    
    file = [filedir '\' 'deformationField.mhd'];
    f = write_mhd(file, img);
    if (f == 0)
        sprintf("Invalid file.\n");
    end
    clear img;
end
end