#' Support function to download metadata internally used in 'aopdata'
#'
#' @return A `data.frame` object with metadata and url of data sets
#'
#' @export
#' @family general support functions
#' @examples \dontrun{ if (interactive()) {
#' df <- download_metadata()
#'}}
download_metadata <- function(){

  # create tempfile to save metadata
  tempf <- file.path(tempdir(), "metadata_aopdata.csv")

  # IF metadata has already been successfully downloaded
  if (file.exists(tempf) & file.info(tempf)$size != 0) {

  } else {

    # test server connection
    metadata_link <- 'https://www.ipea.gov.br/geobr/aopdata/metadata/metadata.csv'
    check_con <- check_connection(metadata_link)
    if(is.null(check_con) | isFALSE(check_con)){ return(invisible(NULL)) }

    # download metadata to temp file
    httr::GET(url= metadata_link, httr::write_disk(tempf, overwrite = TRUE))
  }

 # read metadata
  metadata <- data.table::fread(tempf, stringsAsFactors=FALSE)
  return(metadata)
  }
