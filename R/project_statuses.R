#' Get a project status
#'
#' *Deprecated: new integrations should prefer the `/status_updates/{status_gid}` route.*  Returns the complete record for a single status update.
#'
#' @param project_status_gid (character scalar) The project status update to get.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_project_status <- function(project_status_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/project_statuses/{project_status_gid}", project_status_gid = project_status_gid),
    query = list(opt_fields = opt_fields),
    method = "get"
  )
}


#' Delete a project status
#'
#' *Deprecated: new integrations should prefer the `/status_updates/{status_gid}` route.*  Deletes a specific, existing project status update.  Returns an empty data record.
#'
#' @param project_status_gid (character scalar) The project status update to get.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#' @keywords internal
asn_delete_project_status <- function(project_status_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/project_statuses/{project_status_gid}", project_status_gid = project_status_gid),
    query = list(opt_fields = opt_fields),
    method = "delete"
  )
}
