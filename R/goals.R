#' Add a supporting goal relationship
#'
#' Creates a goal relationship by adding a supporting resource to a given goal.  Returns the newly created goal relationship record.
#'
#' @param goal_gid (character scalar) Globally unique identifier for the goal.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_add_supporting_relationship <- function(goal_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/goals/{goal_gid}/addSupportingRelationship", goal_gid = goal_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Removes a supporting goal relationship
#'
#' Removes a goal relationship for a given parent goal.
#'
#' @param goal_gid (character scalar) Globally unique identifier for the goal.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#' @keywords internal
asn_remove_supporting_relationship <- function(goal_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/goals/{goal_gid}/removeSupportingRelationship", goal_gid = goal_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get a goal
#'
#' Returns the complete goal record for a single goal.
#'
#' @param goal_gid (character scalar) Globally unique identifier for the goal.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_goal <- function(goal_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/goals/{goal_gid}", goal_gid = goal_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Update a goal
#'
#' An existing goal can be updated by making a PUT request on the URL for that goal. Only the fields provided in the `data` block will be updated; any unspecified fields will remain unchanged.  Returns the complete updated goal record.
#'
#' @param goal_gid (character scalar) Globally unique identifier for the goal.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_update_goal <- function(goal_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/goals/{goal_gid}", goal_gid = goal_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "put",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Delete a goal
#'
#' A specific, existing goal can be deleted by making a DELETE request on the URL for that goal.  Returns an empty data record.
#'
#' @param goal_gid (character scalar) Globally unique identifier for the goal.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#' @keywords internal
asn_delete_goal <- function(goal_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/goals/{goal_gid}", goal_gid = goal_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "delete"
  )
}


#' Get goals
#'
#' Returns compact goal records.
#'
#' @param is_workspace_level (optional) (logical scalar) Filter to goals with is_workspace_level set to query value. Must be used with the workspace parameter.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param portfolio (optional) (character scalar) Globally unique identifier for supporting portfolio.
#' @param project (optional) (character scalar) Globally unique identifier for supporting project.
#' @param team (optional) (character scalar) Globally unique identifier for the team.
#' @param time_periods (optional) (character vector) Globally unique identifiers for the time periods.
#' @param workspace (optional) (character scalar) Globally unique identifier for the workspace.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_goals <- function(is_workspace_level, limit, offset, opt_fields, portfolio, project, team, time_periods, workspace) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/goals"),
    query = list(is_workspace_level = rlang::maybe_missing(is_workspace_level), limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields), portfolio = rlang::maybe_missing(portfolio), project = rlang::maybe_missing(project), team = rlang::maybe_missing(team), time_periods = rlang::maybe_missing(time_periods), workspace = rlang::maybe_missing(workspace)),
    method = "get"
  )
}


#' Create a goal
#'
#' Creates a new goal in a workspace or team.  Returns the full record of the newly created goal.
#'
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_create_goal <- function(limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/goals"),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Create a goal metric
#'
#' Creates and adds a goal metric to a specified goal. Note that this replaces an existing goal metric if one already exists.
#'
#' @param goal_gid (character scalar) Globally unique identifier for the goal.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_create_goal_metric <- function(goal_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/goals/{goal_gid}/setMetric", goal_gid = goal_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Update a goal metric
#'
#' Updates a goal's existing metric's `current_number_value` if one exists, otherwise responds with a 400 status code.  Returns the complete updated goal metric record.
#'
#' @param goal_gid (character scalar) Globally unique identifier for the goal.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_update_goal_metric <- function(goal_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/goals/{goal_gid}/setMetricCurrentValue", goal_gid = goal_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Add a collaborator to a goal
#'
#' Adds followers to a goal. Returns the goal the followers were added to. Each goal can be associated with zero or more followers in the system. Requests to add/remove followers, if successful, will return the complete updated goal record, described above.
#'
#' @param goal_gid (character scalar) Globally unique identifier for the goal.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_add_followers <- function(goal_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/goals/{goal_gid}/addFollowers", goal_gid = goal_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Remove a collaborator from a goal
#'
#' Removes followers from a goal. Returns the goal the followers were removed from. Each goal can be associated with zero or more followers in the system. Requests to add/remove followers, if successful, will return the complete updated goal record, described above.
#'
#' @param goal_gid (character scalar) Globally unique identifier for the goal.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_remove_followers <- function(goal_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/goals/{goal_gid}/removeFollowers", goal_gid = goal_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get parent goals from a goal
#'
#' Returns a compact representation of all of the parent goals of a goal.
#'
#' @param goal_gid (character scalar) Globally unique identifier for the goal.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_parent_goals_for_goal <- function(goal_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/goals/{goal_gid}/parentGoals", goal_gid = goal_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}
