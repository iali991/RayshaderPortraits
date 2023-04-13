library(sf)
library(tidyverse)
library(tigris)
library(ggplot2)
library(stars)
library(MetBrewer)
library(colorspace)
library(rayshader)
library(rayrender)

# Load Kontur data
EG <- st_read("data/kontur_population_EG_20220630.gpkg")

#EG |>
#  ggplot() +
#  geom_sf()

# define aspect ration based on bounding box

bb <- st_bbox(EG)

bottom_left <- st_point(c(bb[["xmin"]], bb[["ymin"]])) |>
  st_sfc(crs = st_crs(EG))

bottom_right <- st_point(c(bb[["xmax"]], bb[["ymin"]])) |>
  st_sfc(crs = st_crs(EG))

width <- st_distance(bottom_left, bottom_right)

top_left <- st_point(c(bb[["xmin"]], bb[["ymax"]])) |>
  st_sfc(crs = st_crs(EG))

#EG |>
#  ggplot() +
#  geom_sf() +
#  geom_sf(data = bottom_left) +
#  geom_sf(data = bottom_right, color='red')

height <- st_distance(bottom_left, top_left)

# Handle conditions of width or height being the longer side
if(width > height) {
  w_ratio <- 1
  h_ratio <- height / width
} else {
  h_ratio <- 1
  w_ratio <- width / height
} 

# Convert to raster so we can then convert to matrix
size <- 100

nx = floor(size * w_ratio)
ny = floor(size * h_ratio)

EG_rast <- st_rasterize(EG, 
                        nx = floor(size * w_ratio), 
                        ny = floor(size * h_ratio))

mat <- matrix(EG_rast$population, 
              nrow = floor(size * w_ratio), 
              ncol = floor(size * h_ratio))

# Create color palette 
color <- MetBrewer::met.brewer(name="Morgenstern")
swatchplot(color)

tx <- grDevices::colorRampPalette(color, bias = 1.5)(256)
swatchplot(tx)

# Plot the matrix

mat |>
  height_shade(texture = tx) |>
  plot_3d(heightmap = mat,
          zscale = 500,
          solid = FALSE,
          shadowdepth = 0)

render_camera(theta = 6, phi = 40, zoom =.57)


# generate test plot

render_highquality (
  filename = "images/test_plot.png"
  # interactive = FALSE,
  # lightdirection = 120,
  # lightaltitude = c(20,80),
  # lightcolor = c(color[4], "white"),
  # lightintensity = c(900,150)
)

rgl::rgl.close()


# generate final plot

# outfile <- "images/final_plot.png"
# 
# {
#   start_time <- Sys.time()
#   cat(crayon::cyan(start_time), "\n")
#   if(!file.exists(outfile)) {
#     png::writePNG(matrix(1), target = outfile)
#   }
#   
#   render_highquality (
#     filename = outfile,
#     interactive = FALSE,
#     lightdirection = 120,
#     lightaltitude = c(20,80),
#     lightcolor = c(color[4], "white"),
#     lightintensity = c(900,150),
#     samples = 450,
#     height = 6000,
#     width = 6000
#   )
#   
#   end_time <- Sys.time()
#   diff <- end_time - start_time
#   cat(crayon::cyan(diff), "\n")
# }
# 
# 
# rgl::rgl.close()
# 
