##https://data.aad.gov.au/geoserver/web/
#  WMS:https://data.aad.gov.au/geoserver/ows?service=WMS&version=1.3.0&request=GetCapabilities

  ## not available
  ## WMTS:https://data.aad.gov.au/geoserver/gwc/service/wmts?service=WMTS&version=1.1.1&request=GetCapabilities
#  WFS:https://data.aad.gov.au/geoserver/ows?service=WFS&acceptversions=2.0.0&request=GetCapabilities

#  WCS:https://data.aad.gov.au/geoserver/ows?service=WCS&acceptversions=2.0.1&request=GetCapabilities
  ## WPS?
  ##https://data.aad.gov.au/geoserver/ows?service=WPS&version=1.0.0&request=GetCapabilities



aadc.geoserver <- function(type = c("WFS")) {
  aadc <- c(WFS = "WFS:https://data.aad.gov.au/geoserver/ows?service=wfs&version=2.0.0&request=GetCapabilities",
            WMS = "WMS:https://data.aad.gov.au/geoserver/ows?service=WMS&version=1.3.0&request=GetCapabilities",
            WCS = "WCS:https://data.aad.gov.au/geoserver/ows?service=WCS&acceptversions=2.0.1&request=GetCapabilities")
  out <- switch(type,
         WFS = aadc["WFS"],
         WMS = aadc["WMS"],
         WCS = aadc["WCS"],
         all = aadc,
         "not supported")
  if (out[1L] == "not supported") stop(sprintf("'type=%s' is not supported, should be one of '%s' or 'all'", type,
                                           paste(collapse = ", ", names(aadc))))

  out
}

aadc_wfs_layers <- function() {
  vapour::vapour_layer_names(aadc.geoserver("WFS"))
}
aadc_wms_layers <- function() {
  vapour::vapour_sds_names(aadc.geoserver("WMS"))
}
aadc_wcs_layers <- function() {
  vapour::vapour_sds_names(aadc.geoserver("WCS"))
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
