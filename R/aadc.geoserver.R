aadc.geoserver <- function() {
  "WFS:https://data.aad.gov.au/geoserver/ows?service=wfs&version=2.0.0&request=GetCapabilities"
}

aadc_layers <- function() {
  vapour::vapour_layer_names(aadc.geoserver())
}

layer_info <- function(layer) {
  info <- vapour::vapour_layer_info(aadc.geoserver(), layer)
  info
}

layer_read_fields <- function(layer, n = 10, last = TRUE) {
  skip_n <- 0
  if (last) {
    info <- layer_info(layer)
    skip_n <- info$n - n
  }
  tibble::as_tibble(vapour::vapour_read_fields(aadc.geoserver(), layer, limit_n = n, skip_n = skip_n))
}

layer_read_geometry <- function(layer, n = 10, last = TRUE) {
  skip_n <- 0
  if (last) {
    info <- layer_info(layer)
    skip_n <- info$n - n
  }
  vapour::vapour_read_geometry(aadc.geoserver(), layer, limit_n = n, skip_n = skip_n)

}
