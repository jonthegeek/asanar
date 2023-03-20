#' Get a project membership
#'
#' Returns the complete project record for a single project membership.
#'
#' @param project_membership_gid (character scalar) NA
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_project_membership <- function(project_membership_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/project_memberships/{project_membership_gid}", project_membership_gid = project_membership_gid),
    query = list(opt_fields = opt_fields),
    method = "get"
  )
}
