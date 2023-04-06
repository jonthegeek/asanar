#' Submit parallel requests
#'
#' Make multiple requests in parallel to Asana's API.
#'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A response object returned from a batch request.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | body | list | The JSON body that the invoked endpoint returned. |
#' | headers | list | A map of HTTP headers specific to this result. This is primarily used for returning a `Location` header to accompany a `201 Created` result.  The parent HTTP response will contain all common headers. |
#' | status_code | integer scalar | The HTTP status code that the invoked endpoint returned. |
#'
#' @keywords internal
asn_create_batch_request <- function(opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/batch"),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


