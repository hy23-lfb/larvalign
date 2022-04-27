# Template Generation for Metamorphosis Dataset

Template is generated by mutually registering every image (moving image) to every other image (fixed image) in the dataset. These individual deformation fields are then averaged to warp the moving image to 'average space'. The process is repeated across all other images; iteratively assigning a new moving image and warping it to 'average space'. Finally, at the end of the iteration, the median of all these 'average space' images gives the template (atlas) image.

To generate a symmetrical template, the given images were further flipped in horizontal direction to generate new set of images (data augmentation). Using these images, in addition to the original image captures, ensures that there is symmetry when the moving image is warpped to 'average space.'

### Requisites to run the program.
1. The dataset location containing both the images and its horizontally flipped versions must be provided.
3. The registration pipeline itself uses masked images, SDT images (signed distance transform) images, and preprocessed images. These images are generated "on the go" for moving images. However for the fixed images, it is our responsibility to provide them.
4. Since the moving images are registered to every other images (fixed images), we need to have mask image, SDT image, and preprocessed image for all the images in the dataset so that the registration pipeline can make use of it.
5. The template generation pipeline will then copy these mask, SDT, and preprocessed images to a local directory when needed. This copying is handled, just that the files must be already available for the pipeline to copy them.
6. The files are stored in 'mhd/template/' folder of directory mentioned in (1) for the template generation pipeline to copy from.
7. Overall, the directory mentioned in (1) looks as follows:

```
Root Directory
│   *.tif    
│
└───mhd
│   │
│   └───template
│       │   *_MASK.mhd
│       │   *_MASK.zraw
│       │   *_PP.mhd
│       │   *_PP.zraw
│       │   *_SDT.mhd
│       │   *_SDT.raw
│       │   ...
│   
```
### Command to run the program.
1. Give the root directory where the images and its templates are stored e.g., *path = 'I:\Dataset\Standard_Brain\02.Standard_Brain\meta18_25_percent\meta18\';*
2. Call the function in matlab with path as an argument *h_MetaPipeline(path);*.
3. At the completion of step 2, the average space results are stored under their respective folders in the directory dictated by the variable *df_dstPath_suffix* mentioned in file h_Metapipeline.m

### Things to know.
To generate the template, the median of the averaged spaced images needs to be computed separately. It is not incorporated as part of this commit yet.