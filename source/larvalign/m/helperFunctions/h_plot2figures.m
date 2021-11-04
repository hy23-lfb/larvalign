function h_plot2figures(name, titlex, x, titley, y)
figure("Name", name);
    subplot(1,2,1);
    imagesc(x);
    title(titlex);
    colorbar;
    
    subplot(1,2,2);
    imagesc(y);
    title(titley);
    colorbar;
end
