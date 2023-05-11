#' Get memberships from a user
#'
#' Returns the compact team membership records for the user.
#'
#' @param user_gid (character scalar) A string identifying a user. This can either be the string "me", an email, or the gid of a user.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param workspace (character scalar) Globally unique identifier for the workspace.
#'
#' @return This object represents a user's connection to a team.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | is_admin | logical scalar | Describes if the user is a team admin. |
#' | is_guest | logical scalar | Describes if the user is a guest in the team. |
#' | is_limited_access | logical scalar | Describes if the user has limited access to the team. |
#' | team | list | A *team* is used to group related projects and people together within an organization. Each project in an organization is associated with a team. |
#' | user | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#'
#' @keywords internal
asn_get_team_memberships_for_user <- function(user_gid, workspace, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/users/{user_gid}/team_memberships", user_gid = user_gid),
    query = list(workspace = workspace, limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
  # nocov end
}


#' Get teams for a user
#'
#' Returns the compact records for all teams to which the given user is assigned.
#'
#' @param user_gid (character scalar) A string identifying a user. This can either be the string "me", an email, or the gid of a user.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param organization (character scalar) The workspace or organization to filter teams on.
#'
#' @return A *team* is used to group related projects and people together within an organization. Each project in an organization is associated with a team.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the team. |
#'
#' @keywords internal
asn_get_teams_for_user <- function(organization, user_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/users/{user_gid}/teams", user_gid = user_gid),
    query = list(organization = organization, limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
  # nocov end
}


#' Get a user's task list
#'
#' Returns the full record for a user's task list.
#'
#' @param user_gid (character scalar) A string identifying a user. This can either be the string "me", an email, or the gid of a user.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param workspace (character scalar) The workspace in which to get the user task list.
#'
#' @return A user task list represents the tasks assigned to a particular user. It provides API access to a user’s [My Tasks](https://asana.com/guide/help/fundamentals/my-tasks) view in Asana.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the user task list. |
#' | owner | list | The owner of the user task list, i.e. the person whose My Tasks is represented by this resource. |
#' | workspace | list | The workspace in which the user task list is located. |
#'
#' @keywords internal
asn_get_user_task_list_for_user <- function(user_gid, workspace, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/users/{user_gid}/user_task_list", user_gid = user_gid),
    query = list(workspace = workspace, opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
  # nocov end
}


#' Get multiple users
#'
#' Returns the user records for all users in all workspaces and organizations accessible to the authenticated user. Accepts an optional workspace ID parameter. Results are sorted by user ID.
#'
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param team (optional) (character scalar) The team ID to filter users on.
#' @param workspace (optional) (character scalar) The workspace or organization ID to filter users on.
#'
#' @return A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | *Read-only except when same user as requester*. The user’s name. |
#'
#' @export
asn_get_users <- function(limit, offset, opt_fields, team, workspace) {
  .call_api(
    endpoint = list("/users"),
    query = list(
      limit = rlang::maybe_missing(limit),
      offset = rlang::maybe_missing(offset),
      opt_fields = rlang::maybe_missing(opt_fields),
      team = rlang::maybe_missing(team),
      workspace = rlang::maybe_missing(workspace)
    ),
    method = "get"
  )
}


#' Get a user
#'
#' Returns the full user record for the single user with the provided ID.
#'
#' @param user_gid (character scalar) A string identifying a user. This can either be the string "me", an email, or the gid of a user.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | *Read-only except when same user as requester*. The user’s name. |
#' | email | character scalar | The user's email address. |
#' | photo | list | A map of the user’s profile photo in various sizes, or null if no photo is set. Sizes provided are 21, 27, 36, 60, 128, and 1024. All images are in PNG format, except for 1024 (which is in JPEG format). |
#' | workspaces | list | Workspaces and organizations this user may access. Note\: The API will only return workspaces and organizations that also contain the authenticated user. |
#'
#' @keywords internal
asn_get_user <- function(user_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/users/{user_gid}", user_gid = user_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
  # nocov end
}


#' Get a user's favorites
#'
#' Returns all of a user's favorites in the given workspace, of the given type. Results are given in order (The same order as Asana's sidebar).
#'
#' @param user_gid (character scalar) A string identifying a user. This can either be the string "me", an email, or the gid of a user.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param resource_type (character scalar) The resource type of favorites to be returned. Possible values: portfolio, project, tag, task, user, project_template. Default: project
#' @param workspace (character scalar) The workspace in which to get favorites.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the object. |
#'
#' @keywords internal
asn_get_favorites_for_user <- function(resource_type = "project", user_gid, workspace, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/users/{user_gid}/favorites", user_gid = user_gid),
    query = list(resource_type = resource_type, workspace = workspace, opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
  # nocov end
}


#' Get workspace memberships for a user
#'
#' Returns the compact workspace membership records for the user.
#'
#' @param user_gid (character scalar) A string identifying a user. This can either be the string "me", an email, or the gid of a user.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return This object determines if a user is a member of a workspace.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | user | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | workspace | list | A *workspace* is the highest-level organizational unit in Asana. All projects and tasks have an associated workspace. |
#'
#' @keywords internal
asn_get_workspace_memberships_for_user <- function(user_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/users/{user_gid}/workspace_memberships", user_gid = user_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
  # nocov end
}
