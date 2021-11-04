function h_plot(figureName, noOfPlots, x, fGraphName, y, sGraphName, z, tGraphName)
%%
%% Input: 
%%
figure("Name", figureName);
if (noOfPlots == 2)
    
    subplot(1,2,1);
    imagesc(x);
    colorbar;
    title(fGraphName);
    
    subplot(1,2,2);
    imagesc(y);
    colorbar;
    title(sGraphName);
elseif (noOfPlots == 3)
    
    subplot(2,2,1);
    imagesc(x);
    colorbar;
    title(fGraphName);
    
    subplot(2,2,2);
    imagesc(y);
    colorbar;
    title(sGraphName);
    
    subplot(2,1,2);
    imagesc(z);
    colorbar;
    title(tGraphName);
end
