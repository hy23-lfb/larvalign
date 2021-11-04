function h_plot4figures(name, titlew, w, titlex, x, titley, y, titlez, z)
figure("Name", name);
    subplot(2,2,1);
    imagesc(w);
    title(titlew);
    colorbar;
    
    subplot(2,2,2);
    imagesc(x);
    title(titlex);
    colorbar;
    
    subplot(2,2,3);
    imagesc(y);
    title(titley);
    colorbar;
    
    subplot(2,2,4);
    imagesc(z);
    title(titlez);
    colorbar;
end
