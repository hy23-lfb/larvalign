function h_plotDefFields(path1, name)
path1 = convertStringsToChars(path1);
[img1, ~] = read_mhd(path1);
fprintf('Done reading img1\n');
%path2 = convertStringsToChars(path2);
%[img2, info2] = read_mhd(path2);
%fprintf('Done reading img2\n');

x1 = max(img1.datax, [], 3);
%x2 = max(img2.datax, [], 3);

y1 = max(img1.datay, [], 3);
%y2 = max(img2.datay, [], 3);

z1 = max(img1.dataz, [], 3);
%z2 = max(img2.dataz, [], 3);

figure('Name', name)
subplot(2,3,1);
imagesc(x1);
colorbar;
title('defx 25 percent');


subplot(2,3,2);
imagesc(y1);
colorbar;
title('defy 25 percent');

subplot(2,3,3);
imagesc(z1);
colorbar;
title('defz 25 percent');

%{
subplot(2,3,4);
imagesc(x2);
colorbar;
title('defx 75 percent');

subplot(2,3,5);
imagesc(y2);
colorbar;
title('defy 75 percent');

subplot(2,3,6);
imagesc(z2);
colorbar;
title('defz 75 percent');
%}
filename = [name '.png'];
saveas(gcf, filename);
fprintf('figure saved in %s\n', filename);

end