#' Get a team's project templates
#'
#' Returns the compact project template records for all project templates in the team.
#'
#' @param team_gid (character scalar) Globally unique identifier for the team.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *project template* is an object that allows new projects to be created with a predefined setup, which may include tasks, sections, Rules, etc. It simplifies the process of running a workflow that involves a similar set of work every time.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | Name of the project template. |
#'
#' @keywords internal
asn_get_project_templates_for_team <- function(team_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/teams/{team_gid}/project_templates", team_gid = team_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Get a team's projects
#'
#' Returns the compact project records for all projects in the team.
#'
#' @param team_gid (character scalar) Globally unique identifier for the team.
#' @param archived (optional) (logical scalar) Only return projects whose `archived` field takes on the value of this parameter.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *project* represents a prioritized list of tasks in Asana or a board with columns of tasks represented as cards. It exists in a single workspace or organization and is accessible to a subset of users in that workspace or organization, depending on its permissions.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | Name of the project. This is generally a short sentence fragment that fits on a line in the UI for maximum readability. However, it can be longer. |
#'
#' @keywords internal
asn_get_projects_for_team <- function(team_gid, archived, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/teams/{team_gid}/projects", team_gid = team_gid),
    query = list(archived = rlang::maybe_missing(archived), limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Create a project in a team
#'
#' Creates a project shared with the given team.  Returns the full record of the newly created project.
#'
#' @param team_gid (character scalar) Globally unique identifier for the team.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *project* represents a prioritized list of tasks in Asana or a board with columns of tasks represented as cards. It exists in a single workspace or organization and is accessible to a subset of users in that workspace or organization, depending on its permissions.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | Name of the project. This is generally a short sentence fragment that fits on a line in the UI for maximum readability. However, it can be longer. |
#' | archived | logical scalar | True if the project is archived, false if not. Archived projects do not show in the UI by default and may be treated differently for queries. |
#' | color | character scalar | Color of the project. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | current_status | list | *Deprecated: new integrations should prefer the `current_status_update` resource.* |
#' | current_status_update | list | The latest `status_update` posted to this project. |
#' | custom_field_settings | list | Array of Custom Field Settings (in compact form). |
#' | default_view | character scalar | The default view (list, board, calendar, or timeline) of a project. |
#' | due_date | datetime scalar | *Deprecated: new integrations should prefer the `due_on` field.* |
#' | due_on | datetime scalar | The day on which this project is due. This takes a date with format YYYY-MM-DD. |
#' | html_notes | character scalar | [Opt In](https://developers.asana.com/docs/inputoutput-options). The notes of the project with formatting as HTML. |
#' | members | list | Array of users who are members of this project. |
#' | modified_at | datetime scalar | The time at which this project was last modified. *Note: This does not currently reflect any changes in associations such as tasks or comments that may have been added or removed from the project.* |
#' | notes | character scalar | Free-form textual information associated with the project (ie., its description). |
#' | public | logical scalar | True if the project is public to its team. |
#' | start_on | date scalar | The day on which work for this project begins, or null if the project has no start date. This takes a date with `YYYY-MM-DD` format. *Note: `due_on` or `due_at` must be present in the request when setting or unsetting the `start_on` parameter. Additionally, `start_on` and `due_on` cannot be the same date.* |
#' | workspace | list | *Create-only*. The workspace or organization this project is associated with. Once created, projects cannot be moved to a different workspace. This attribute can only be specified at creation time. |
#' | completed | logical scalar | True if the project is currently marked complete, false if not. |
#' | completed_at | datetime scalar | The time at which this project was completed, or null if the project is not completed. |
#' | completed_by | list | The user that marked this project complete, or null if the project is not completed. |
#' | created_from_template | list | [Opt In](https://developers.asana.com/docs/inputoutput-options). The project template from which this project was created. If the project was not created from a template, this field will be null. |
#' | custom_fields | list | Array of Custom Fields. |
#' | followers | list | Array of users following this project. Followers are a subset of members who have opted in to receive "tasks added" notifications for a project. |
#' | icon | character scalar | The icon for a project. |
#' | owner | list | The current owner of the project, may be null. |
#' | permalink_url | character scalar | A url that points directly to the object within Asana. |
#' | project_brief | list | [Opt In](https://developers.asana.com/docs/inputoutput-options). The project brief associated with this project. |
#' | team | list | The team that this project is shared with. |
#'
#' @keywords internal
asn_create_project_for_team <- function(team_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/teams/{team_gid}/projects", team_gid = team_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get memberships from a team
#'
#' Returns the compact team memberships for the team.
#'
#' @param team_gid (character scalar) Globally unique identifier for the team.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
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
asn_get_team_memberships_for_team <- function(team_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/teams/{team_gid}/team_memberships", team_gid = team_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Create a team
#'
#' Creates a team within the current workspace.
#'
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *team* is used to group related projects and people together within an organization. Each project in an organization is associated with a team.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the team. |
#' | description | character scalar | [Opt In](https://developers.asana.com/docs/inputoutput-options). The description of the team.  |
#' | edit_team_name_or_description_access_level | character scalar | Controls who can edit team name and description  |
#' | edit_team_visibility_or_trash_team_access_level | character scalar | Controls who can edit team visibility and trash teams  |
#' | guest_invite_management_access_level | character scalar | Controls who can accept or deny guest invites for a given team  |
#' | html_description | character scalar | [Opt In](https://developers.asana.com/docs/inputoutput-options). The description of the team with formatting as HTML.  |
#' | join_request_management_access_level | character scalar | Controls who can accept or deny join team requests for a Membership by Request team  |
#' | member_invite_management_access_level | character scalar | Controls who can accept or deny member invites for a given team  |
#' | organization | list | The organization/workspace the team belongs to.  |
#' | permalink_url | character scalar | A url that points directly to the object within Asana. |
#' | team_member_removal_access_level | character scalar | Controls who can remove team members  |
#' | visibility | character scalar | The visibility of the team to users in the same organization  |
#'
#' @keywords internal
asn_create_team <- function(limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/teams"),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Update a team
#'
#' Updates a team within the current workspace.
#'
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *team* is used to group related projects and people together within an organization. Each project in an organization is associated with a team.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the team. |
#' | description | character scalar | [Opt In](https://developers.asana.com/docs/inputoutput-options). The description of the team.  |
#' | edit_team_name_or_description_access_level | character scalar | Controls who can edit team name and description  |
#' | edit_team_visibility_or_trash_team_access_level | character scalar | Controls who can edit team visibility and trash teams  |
#' | guest_invite_management_access_level | character scalar | Controls who can accept or deny guest invites for a given team  |
#' | html_description | character scalar | [Opt In](https://developers.asana.com/docs/inputoutput-options). The description of the team with formatting as HTML.  |
#' | join_request_management_access_level | character scalar | Controls who can accept or deny join team requests for a Membership by Request team  |
#' | member_invite_management_access_level | character scalar | Controls who can accept or deny member invites for a given team  |
#' | organization | list | The organization/workspace the team belongs to.  |
#' | permalink_url | character scalar | A url that points directly to the object within Asana. |
#' | team_member_removal_access_level | character scalar | Controls who can remove team members  |
#' | visibility | character scalar | The visibility of the team to users in the same organization  |
#'
#' @keywords internal
asn_update_team <- function(limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/teams"),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "put",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get a team
#'
#' Returns the full record for a single team.
#'
#' @param team_gid (character scalar) Globally unique identifier for the team.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *team* is used to group related projects and people together within an organization. Each project in an organization is associated with a team.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the team. |
#' | description | character scalar | [Opt In](https://developers.asana.com/docs/inputoutput-options). The description of the team.  |
#' | edit_team_name_or_description_access_level | character scalar | Controls who can edit team name and description  |
#' | edit_team_visibility_or_trash_team_access_level | character scalar | Controls who can edit team visibility and trash teams  |
#' | guest_invite_management_access_level | character scalar | Controls who can accept or deny guest invites for a given team  |
#' | html_description | character scalar | [Opt In](https://developers.asana.com/docs/inputoutput-options). The description of the team with formatting as HTML.  |
#' | join_request_management_access_level | character scalar | Controls who can accept or deny join team requests for a Membership by Request team  |
#' | member_invite_management_access_level | character scalar | Controls who can accept or deny member invites for a given team  |
#' | organization | list | The organization/workspace the team belongs to.  |
#' | permalink_url | character scalar | A url that points directly to the object within Asana. |
#' | team_member_removal_access_level | character scalar | Controls who can remove team members  |
#' | visibility | character scalar | The visibility of the team to users in the same organization  |
#'
#' @keywords internal
asn_get_team <- function(team_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/teams/{team_gid}", team_gid = team_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Add a user to a team
#'
#' The user making this call must be a member of the team in order to add others. The user being added must exist in the same organization as the team.  Returns the complete team membership record for the newly added user.
#'
#' @param team_gid (character scalar) Globally unique identifier for the team.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
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
asn_add_user_for_team <- function(team_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/teams/{team_gid}/addUser", team_gid = team_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Remove a user from a team
#'
#' The user making this call must be a member of the team in order to remove themselves or others.
#'
#' @param team_gid (character scalar) Globally unique identifier for the team.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_remove_user_for_team <- function(team_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/teams/{team_gid}/removeUser", team_gid = team_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get users in a team
#'
#' Returns the compact records for all users that are members of the team. Results are sorted alphabetically and limited to 2000. For more results use the `/users` endpoint.
#'
#' @param team_gid (character scalar) Globally unique identifier for the team.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | *Read-only except when same user as requester*. The user’s name. |
#'
#' @keywords internal
asn_get_users_for_team <- function(team_gid, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/teams/{team_gid}/users", team_gid = team_gid),
    query = list(offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


