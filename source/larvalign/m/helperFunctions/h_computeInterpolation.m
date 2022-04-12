function h_computeInterpolation()
warning('off','MATLAB:MKDIR:DirectoryExists');

filepath1 = 'D:\Harsha\Files_Hiwi\Datasets\01.24hrLin_vs_18hr\percents\';
filepath2 = 'D:\Harsha\Files_Hiwi\Datasets\02.18hrLin_vs_24hr\percents\';
outfilepath = 'D:\Harsha\Files_Hiwi\Datasets\Interpolation\';

folders = ["5p", "10p", "15p", "20p", "25p", "30p", "35p", "40p", "45p", "50p", "55p", "60p", "65p", "70p", "75p", "80p", "85p", "90p", "95p", "100p"];
[~, fsize] = size(folders);

x = 0.05;

for i = 1 : fsize
    filepath1 = convertStringsToChars(filepath1);
    filepath2 = convertStringsToChars(filepath2);  
    outfilepath = convertStringsToChars(outfilepath);
    
    folder = convertStringsToChars(folders{i});

    outfile = [outfilepath 'output' folder '.tif'];
    
    file1 = [filepath1 folder '\input.tif'];
    file2 = [filepath2 folder '\input.tif'];

    mkdir(outfilepath);
    
    img1 = imread(file1);
    img2 = imread(file2);
    
    t_img1 = (1-x)*img1; % 18hr images.
    t_img2 = x*img2; % 24hr images.

    outimg = t_img1 + t_img2;
    outstack = uint16(outimg);
    imwrite(outstack, outfile);
    x = x + 0.05;
    
    fprintf("input file img1 %s\n", file1);
    fprintf("input file img2 %s\n", file2);
    fprintf("percent of x is %f\n", x);
    fprintf("output path is %s\n\n", outfile);
end
end