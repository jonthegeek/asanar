#' Visit Asana My Apps page
#'
#' Launch the Asana "My Apps" page (where you can create a new personal access
#' token). After you create a token, copy/paste the value into the
#' `ASN_API_TOKEN` environment variable. We recommend placing this environment
#' variable in your `.Renviron` file.
#'
#' @return The url of the "My Apps" page, invisibly.
#' @export
#'
#' @examples
#' asana_token_url <- asn_browse_token()
#' Sys.setenv(ASN_API_TOKEN = "1/12345:e12a3etc")
asn_browse_token <- function() {
  asn_token_url <- "https://app.asana.com/0/my-apps"
  if (interactive()) { # nocov start
    utils::browseURL(asn_token_url)
  } # nocov end
  return(invisible(asn_token_url))
}
