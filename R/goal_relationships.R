#' Get a goal relationship
#'
#' Returns the complete updated goal relationship record for a single goal relationship.
#'
#' @param goal_relationship_gid (character scalar) Globally unique identifier for the goal relationship.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_goal_relationship <- function(goal_relationship_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/goal_relationships/{goal_relationship_gid}", goal_relationship_gid = goal_relationship_gid),
    query = list(opt_fields = opt_fields),
    method = "get"
  )
}


#' Update a goal relationship
#'
#' An existing goal relationship can be updated by making a PUT request on the URL for that goal relationship. Only the fields provided in the `data` block will be updated; any unspecified fields will remain unchanged.  Returns the complete updated goal relationship record.
#'
#' @param goal_relationship_gid (character scalar) Globally unique identifier for the goal relationship.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_update_goal_relationship <- function(goal_relationship_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/goal_relationships/{goal_relationship_gid}", goal_relationship_gid = goal_relationship_gid),
    query = list(opt_fields = opt_fields),
    method = "put",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get goal relationships
#'
#' Returns compact goal relationship records.
#'
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param resource_subtype (optional) (character scalar) If provided, filter to goal relationships with a given resource_subtype.
#' @param supported_goal (character scalar) Globally unique identifier for the supported goal in the goal relationship.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_goal_relationships <- function(supported_goal, opt_fields, resource_subtype) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/goal_relationships"),
    query = list(opt_fields = opt_fields, resource_subtype = resource_subtype, supported_goal = supported_goal),
    method = "get"
  )
}
