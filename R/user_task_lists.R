#' Get tasks from a user task list
#'
#' Returns the compact list of tasks in a user’s My Tasks list. *Note: Access
#' control is enforced for this endpoint as with all Asana API endpoints,
#' meaning a user’s private tasks will be filtered out if the API-authenticated
#' user does not have access to them.* *Note: Both complete and incomplete tasks
#' are returned by default unless they are filtered out (for example, setting
#' `completed_since=now` will return only incomplete tasks, which is the default
#' view for “My Tasks” in Asana.)*
#'
#' @param user_task_list_gid (character scalar) Globally unique identifier for
#'   the user task list.
#' @param completed_since (optional) (character scalar) Only return tasks that
#'   are either incomplete or that have been completed since this time. Accepts
#'   a date-time string or the keyword *now*.
#' @param limit (optional) (integer scalar) Results per page. The number of
#'   objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the
#'   next page returned by the API. A pagination request will return an offset
#'   token, which can be used as an input parameter to the next request. If an
#'   offset is not passed in, the API will return the first page of results.
#'   'Note: You can only pass in an offset that was returned to you via a
#'   previously paginated request.'
#' @param opt_fields (optional) (character vector) Defines fields to return.
#'   Some requests return *compact* representations of objects in order to
#'   conserve resources and complete the request more efficiently. Other times
#'   requests return more information than you may need. This option allows you
#'   to list the exact set of fields that the API should be sure to return for
#'   the objects. The field names should be provided as paths, described below.
#'   The id of included objects will always be returned, regardless of the field
#'   options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_tasks_for_user_task_list <- function(user_task_list_gid, completed_since, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/user_task_lists/{user_task_list_gid}/tasks", user_task_list_gid = user_task_list_gid),
    query = list(completed_since = completed_since, limit = limit, offset = offset, opt_fields = opt_fields),
    method = "get"
  )
}


#' Get a user task list
#'
#' Returns the full record for a user task list.
#'
#' @param user_task_list_gid (character scalar) Globally unique identifier for
#'   the user task list.
#' @param opt_fields (optional) (character vector) Defines fields to return.
#'   Some requests return *compact* representations of objects in order to
#'   conserve resources and complete the request more efficiently. Other times
#'   requests return more information than you may need. This option allows you
#'   to list the exact set of fields that the API should be sure to return for
#'   the objects. The field names should be provided as paths, described below.
#'   The id of included objects will always be returned, regardless of the field
#'   options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_user_task_list <- function(user_task_list_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/user_task_lists/{user_task_list_gid}", user_task_list_gid = user_task_list_gid),
    query = list(opt_fields = opt_fields),
    method = "get"
  )
}
