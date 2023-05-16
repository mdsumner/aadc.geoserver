## not many layers are populated meaningfully

## MULTISURFACE is effectively a GEOMETRYCOLLECTION of polygons (wk doesn't support yet)
bin <- layer_read_geometry("ausseabed:Vanderford_Glacier_Bathymetry_2021-22_5-128m-merged" )
surf <- sf::st_as_sfc(bin)

att <- attributes(surf)
surf <- lapply(surf, function(.x) {class(.x) <- c("XY", "GEOMETRYCOLLECTION", "sfg"); .x})
att$class <- c("sfc_GEOMETRYCOLLECTION", "sfc")
attributes(surf) <- att


#s <- layer_read_fields("aadc:SCAR_CGA_PLACE_NAMES_SIMPLIFIED" , n = 39140)

#g <- layer_read_geometry("Mapping:Coastline - Lines", n = 1)
#r <- layer_read_geometry("Mapping:DTC_rock_outcrop")
u <- layer_info("underway:nuyina_underway")
u$count
f <- layer_read_fields("underway:nuyina_underway", n = u$count, last = F)
#plot(f$longitude, f$latitude, pch = ".", colourvalues::colour_values(f$sea_water_temperature))
