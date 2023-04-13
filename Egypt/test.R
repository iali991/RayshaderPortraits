library(rayshader)
library(rayrender)

#Render the volcano dataset using pathtracingvolcano %>%
sphere_shade() %>%
plot_3d(volcano,zscale = 2)
render_highquality( #Change position of lightrender_highquality(lightdirection = 45)#Change vertical position of lightrender_highquality(
  lightdirection = 45, 
  lightaltitude=10,#Change the ground materialrender_highquality(lightdirection = 45, lightaltitude=60,
  ground_material = rayrender::diffuse(checkerperiod = 30, checkercolor="grey50"),#Add three different color lights and a titlerender_highquality(lightdirection = c(0,120,240), lightaltitude=45,
  lightcolor=c("red","green","blue"), title_text = "Red, Green, Blue",
  title_bar_color="white", title_bar_alpha=0.8)#Change the camera:render_camera(theta=-45,phi=60,fov=60,zoom=0.8)
render_highquality(lightdirection = c(0),
                   title_bar_color="white", title_bar_alpha=0.8)#Add a shiny metal sphererender_camera(theta=-45,phi=60,fov=60,zoom=0.8)
render_highquality(lightdirection = c(0,120,240), lightaltitude=45, 
                   lightcolor=c("red","green","blue"),
                   scene_elements = rayrender::sphere(z=-60,y=0,
                                                      radius=20,material=rayrender::metal()))#Add a red light to the volcano and change the ambient light to duskrender_camera(theta=45,phi=45)
render_highquality(lightdirection = c(240), lightaltitude=30, 
                   lightcolor=c("#5555ff"),
                   scene_elements = rayrender::sphere(z=0,y=15, x=-18, radius=5,
                                                      material=rayrender::light(color="red",intensity=10)))#Manually change the camera location and directionrender_camera(theta=45,phi=45,fov=90)
render_highquality(lightdirection = c(240), lightaltitude=30, lightcolor=c("#5555ff"), 
                   camera_location = c(50,10,10), camera_lookat = c(0,15,0),
                   scene_elements = rayrender::sphere(z=0,y=15, x=-18, radius=5,
                                                      material=rayrender::light(color="red",intensity=10)))
rgl::rgl.close()