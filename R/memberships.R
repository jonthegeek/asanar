#' Get multiple memberships
#'
#' Returns compact `goal_membership`, `team_membership`, `project_membership`, `portfolio_membership`, or `workspace_membership` records. The possible types for `parent` in this request are `project`, `portfolio`, `team`, `goal`, and `workspace`. An additional member (user GID or team GID) can be passed in to filter to a specific membership. If a `parent` param is not provided, a `member`, `resource_subtype`, and `workspace` param must be provided.
#'
#' @param limit (optional) (integer scalar) Pagination limit for the request.
#' @param member (optional) (character scalar) Globally unique identifier for `team` or `user`.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param parent (optional) (character scalar) Globally unique identifier for `project`, `portfolio`,   `team`, `goal`, and `workspace`.
#' @param resource_subtype (optional) (character scalar) The resource_subtype to filter on. Must be provided with `member` and `workspace` if `parent` is not provided. Valid values include `team_membership`, `workspace_membership`, `portfolio_membership`
#' @param workspace (optional) (character scalar) The workspace to filter on. Must be provided with `member` and `resource_subtype` if `parent` is not provided.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#'
#' @keywords internal
asn_get_memberships <- function(limit, member, offset, opt_fields, parent, resource_subtype, workspace) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/memberships"),
    query = list(limit = rlang::maybe_missing(limit), member = rlang::maybe_missing(member), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields), parent = rlang::maybe_missing(parent), resource_subtype = rlang::maybe_missing(resource_subtype), workspace = rlang::maybe_missing(workspace)),
    method = "get"
  )
}


#' Create a membership
#'
#' Creates a new membership in a `team`, `project`, `goal`, or `portfolio`. `Teams` or `users` can be a member of `goals`. `Project`, `team`, and `portfolios` have users as members.  Returns the full record of the newly created membership.
#'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#'
#' @keywords internal
asn_create_membership <- function(opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/memberships"),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Delete a membership
#'
#' A specific, existing membership can be deleted by making a `DELETE` request on the URL for that membership.  Returns an empty data record.
#'
#' @param membership_gid (character scalar) Globally unique identifier for the membership.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_delete_membership <- function(membership_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/memberships/{membership_gid}", membership_gid = membership_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "delete"
  )
}


#' Update a membership
#'
#' An existing membership can be updated by making a `PUT` request on the URL for that goal. Only the fields provided in the `data` block will be updated; any unspecified fields will remain unchanged. Memberships on `project`, `portfolio`, `team`, and `goals` can be updated.
#'
#' @param membership_gid (character scalar) Globally unique identifier for the membership.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#'
#' @keywords internal
asn_update_membership <- function(membership_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/memberships/{membership_gid}", membership_gid = membership_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "put",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


