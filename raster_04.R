# http://neondataskills.org/R/Multi-Band-Rasters-In-R/


setwd("~/R_projektit/Raster_04")
library(raster)
library(rgdal)

# Read in multi-band raster with raster function. 
# Default is the first band only.
RGB_band1_HARV <-raster("C:/Users/pomik/OneDrive/Tiedostot/R_projektit/Raster_04/HARV/RGB_Imagery/HARV_RGB_Ortho.tif")

# create a grayscale color palette to use for the image.

# create a grayscale color palette to use for the image.
grayscale_colors <- gray.colors(100,            # number of different color levels 
                                start = 0.0,    # how black (0) to go
                                end = 1.0,      # how white (1) to go
                                gamma = 2.2,    # correction between how a digital 
                                # camera sees the world and how human eyes see it
                                alpha = NULL)   #Null=colors are not transparent
# Plot band 1
plot(RGB_band1_HARV, 
     col=grayscale_colors, 
     axes=FALSE,
     main="RGB Imagery - Band 1-Red\nNEON Harvard Forest Field Site") 

# view min value
minValue(RGB_band1_HARV)


# view max value
maxValue(RGB_band1_HARV)

# Can specify which band we want to read in
RGB_band2_HARV <-raster("C:/Users/pomik/OneDrive/Tiedostot/R_projektit/Raster_04/HARV/RGB_Imagery/HARV_RGB_Ortho.tif", 
         band = 2)

# plot band 2
plot(RGB_band2_HARV,
     col=grayscale_colors, # we already created this palette & can use it again
     axes=FALSE,
     main="RGB Imagery - Band 2- Green\nNEON Harvard Forest Field Site")
# view attributes of band 2 
RGB_band2_HARV

# Use stack function to read in all bands
RGB_stack_HARV <- 
  stack("C:/Users/pomik/OneDrive/Tiedostot/R_projektit/Raster_04/HARV/RGB_Imagery/HARV_RGB_Ortho.tif")
RGB_stack_HARV

#We can view the attributes of each band the stack using RGB_stack_HARV@layers.
#Or we if we have hundreds of bands, we can specify which band we'd like to view attributes for 
#using an index value: RGB_stack_HARV[[1]].
#We can also use the plot()
#and hist() functions on the RasterStack to plot and view the distribution of raster band values.


# view raster attributes
RGB_stack_HARV@layers

# view attributes for one band
RGB_stack_HARV[[1]]


# view histogram of all 3 bands
hist(RGB_stack_HARV,
     maxpixels=ncell(RGB_stack_HARV))

# plot all three bands separately
plot(RGB_stack_HARV, 
     col=grayscale_colors)

# revert to a single plot layout 
par(mfrow=c(1,1))

# plot band 2 
plot(RGB_stack_HARV[[2]], 
     main="Band 2\n NEON Harvard Forest Field Site",
     col=grayscale_colors)

# Create an RGB image from the raster stack
plotRGB(RGB_stack_HARV, 
        r = 1, g = 2, b = 3)

# what does stretch do?
plotRGB(RGB_stack_HARV,
        r = 1, g = 2, b = 3, 
        scale=800,
        stretch = "lin")

plotRGB(RGB_stack_HARV,
        r = 1, g = 2, b = 3, 
        scale=800,
        stretch = "hist")


# view size of the RGB_stack object that contains our 3 band image
object.size(RGB_stack_HARV)

# convert stack to a brick
RGB_brick_HARV <- brick(RGB_stack_HARV)

# view size of the brick
object.size(RGB_brick_HARV)

# plot brick
plotRGB(RGB_brick_HARV)
