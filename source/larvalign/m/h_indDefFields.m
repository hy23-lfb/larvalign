function h_indDefFields(img, dir, name)
x = max(img.datax, [], 3);
y = max(img.datay, [], 3);
z = max(img.dataz, [], 3);

figure;
subplot(1,3,1);
imagesc(x);
title("x");
colorbar;

subplot(1,3,2);
imagesc(y);
title("y");
colorbar;

subplot(1,3,3);
imagesc(z);
title("z");
colorbar;

filename = [dir '\' name '.png'];
saveas(gcf, filename);
fprintf('figure saved in %s\n', filename);
close;
end