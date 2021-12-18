function h_plot3figures(name, titlex, x, titley, y, titlez, z)
figure("Name", name);   
    subplot(1,3,1);
    imagesc(x);
    title(titlex);
    colorbar;
    
    subplot(1,3,2);
    imagesc(y);
    title(titley);
    colorbar;
    
    subplot(1,3,3);
    imagesc(z);
    title(titlez);
    colorbar;
end
