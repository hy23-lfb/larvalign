This is method number 2 for generating the mean and the standard deviation for the rich dataset.

Step1: Individual images are registered to template.
These registered images and their z-projections are saved in the directory ./step1/

Step2: The individual images are then z-score normalized to have zero mean and unit variance.
Now, the pixel values are of type double and since its visualization in Fiji is difficult, their z-projection is saved in the directory ./step2/ for visualization.

Step3: These z-score normalized images are then filtered using gaussian filter with sigma 2.0 and filter size = 3.
Agian, the pixel values are of type double and since its visualization in Fiji is difficult, their z-projection is saved in the directory ./step3/ for visualization.

Step4: Output of Step3 are 3D images with 30 slices in z-direction. Mean stack and Standard Deviation Stack is computed out of these. For visualization, these stacks are z-projected and is saved in the directory ./step4/mean_and_stddev_method2-z_score.fig