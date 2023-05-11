#' Get a goal relationship
#'
#' Returns the complete updated goal relationship record for a single goal relationship.
#'
#' @param goal_relationship_gid (character scalar) Globally unique identifier for the goal relationship.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *goal relationship* is an object representing the relationship between a goal and another goal, a project, or a portfolio.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | contribution_weight | number | The weight that the supporting resource's progress contributes to the supported goal's progress. This can only be 0 or 1. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. |
#' | supporting_resource | list | The supporting resource that supports the goal. This can be either a project, portfolio, or goal. |
#' | supported_goal | list | The goal that the supporting resource supports. |
#'
#' @keywords internal
asn_get_goal_relationship <- function(goal_relationship_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/goal_relationships/{goal_relationship_gid}", goal_relationship_gid = goal_relationship_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
  # nocov end
}


#' Update a goal relationship
#'
#' An existing goal relationship can be updated by making a PUT request on the URL for that goal relationship. Only the fields provided in the `data` block will be updated; any unspecified fields will remain unchanged.  Returns the complete updated goal relationship record.
#'
#' @param goal_relationship_gid (character scalar) Globally unique identifier for the goal relationship.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *goal relationship* is an object representing the relationship between a goal and another goal, a project, or a portfolio.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | contribution_weight | number | The weight that the supporting resource's progress contributes to the supported goal's progress. This can only be 0 or 1. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. |
#' | supporting_resource | list | The supporting resource that supports the goal. This can be either a project, portfolio, or goal. |
#' | supported_goal | list | The goal that the supporting resource supports. |
#'
#' @keywords internal
asn_update_goal_relationship <- function(goal_relationship_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/goal_relationships/{goal_relationship_gid}", goal_relationship_gid = goal_relationship_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "put",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
  # nocov end
}


#' Get goal relationships
#'
#' Returns compact goal relationship records.
#'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param resource_subtype (optional) (character scalar) If provided, filter to goal relationships with a given resource_subtype.
#' @param supported_goal (character scalar) Globally unique identifier for the supported goal in the goal relationship.
#'
#' @return A *goal relationship* is an object representing the relationship between a goal and another goal, a project, or a portfolio.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | contribution_weight | number | The weight that the supporting resource's progress contributes to the supported goal's progress. This can only be 0 or 1. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. |
#' | supporting_resource | list | The supporting resource that supports the goal. This can be either a project, portfolio, or goal. |
#'
#' @keywords internal
asn_get_goal_relationships <- function(supported_goal, opt_fields, resource_subtype) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/goal_relationships"),
    query = list(supported_goal = supported_goal, opt_fields = rlang::maybe_missing(opt_fields), resource_subtype = rlang::maybe_missing(resource_subtype)),
    method = "get"
  )
  # nocov end
}
