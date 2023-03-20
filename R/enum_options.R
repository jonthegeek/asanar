#' Update an enum option
#'
#' Updates an existing enum option. Enum custom fields require at least one enabled enum option. Locked custom fields can only be updated by the user who locked the field. Returns the full record of the updated enum option.
#'
#' @param enum_option_gid (character scalar) Globally unique identifier for the enum option.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_update_enum_option <- function(enum_option_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/enum_options/{enum_option_gid}", enum_option_gid = enum_option_gid),
    query = list(opt_fields = opt_fields),
    method = "put",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}
