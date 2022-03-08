function h_computePercentDefField()

warning('off','MATLAB:MKDIR:DirectoryExists');

[df, ~] = read_mhd('D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\Template_Registration_Result\18h_to_24h\100p\deformationField.mhd');
h_indDefFields(df, 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\Template_Registration_Result\18h_to_24h\100p', '100p');

sPercent = 0.10;

folders = ["10p", "20p", "30p", "40p", "50p", "60p", "70p", "80p", "90p"];
path = 'D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\Template_Registration_Result\18h_to_24h\';

[~, c] = size(folders);

for i = 1:c
    fol = folders{i};
    fol = convertStringsToChars(fol);
    
    filedir = [path fol];
    mkdir(filedir);
    
    [df, ~] = read_mhd('D:\Harsha\Files_Hiwi\Datasets\Standard_Brain\Template_Registration_Result\18h_to_24h\100p\deformationField.mhd');

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
    
    h_indDefFields(img, filedir, fol);
    file = [filedir '\' 'deformationField.mhd'];
    f = write_mhd(file, img);
    if (f == 0)
        sprintf("Invalid file.\n");
    end
    clear img;
end
end