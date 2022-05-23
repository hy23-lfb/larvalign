This is method number 1 for generating the mean and the standard deviation for the rich dataset.

Step1: Individual images are registered to template. Saved in the directory ./files/source_files/
Step2: Mean stack and standard deviation stack is created out of the registered images. Saved in the following directory ./files/
Step3: 3D Gaussian filter with sigma value of 1.0 in x, y, and z directions is applied on these mean and standard deviation stack to create a blur version. Saved in the same directory as the readme.txt file i.e., ./
Step4: The gaussian filtered mean stack and standard deviation stacks are maximum intensity projected in z-direction to get ./MAX_mean_gaussian_filtered.tif and ./MAX_std_dev_gaussian_filtered.tif files which are then imagesc'd and saved as ./mean_and_stddev_method1.fig