This is method number 2 for generating the mean and the standard deviation for the rich dataset.

Step1: Individual images are registered to template.
Step2: These individual images are then blurred using a 3D Gaussian filter with sigma value of 1.0 in x, y, and z directions. Saved in the directory ./blurred_registered_images
Step3: Mean stack and standard deviation stack is created out of these blurred registered images. Saved in the same directory as the readme.txt file i.e., ./
Step4: The mean stack and standard deviation stacks are maximum intensity projected in z-direction to get ./MAX_mean.tif and ./MAX_std_dev.tif files which are then imagesc'd and saved as ./mean_and_stddev_method2.fig