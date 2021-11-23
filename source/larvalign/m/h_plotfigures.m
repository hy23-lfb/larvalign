function h_plotfigures(name, no_of_plots, titlex, x, titley, y)
figure("Name", name);
if (no_of_plots == 2)
    subplot(1,2,1);
    imagesc(x);
    title(titlex);
    colorbar;
    
    subplot(1,2,2);
    imagesc(y);
    title(titley);
    colorbar;
end
end
