#' Get a project's custom fields
#'
#' Returns a list of all of the custom fields settings on a project, in compact form. Note that, as in all queries to collections which return compact representation, `opt_fields` can be used to include more data than is returned in the compact representation. See the [getting started guide on input/output options](https://developers.asana.com/docs/#input-output-options) for more information.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return Custom Fields Settings objects represent the many-to-many join of the Custom Field and Project as well as stores information that is relevant to that particular pairing.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | custom_field | list | The custom field that is applied to the `parent`. |
#' | is_important | logical scalar | `is_important` is used in the Asana web application to determine if this custom field is displayed in the list/grid view of a project or portfolio. |
#' | parent | list | The parent to which the custom field is applied. This can be a project or portfolio and indicates that the tasks or projects that the parent contains may be given custom field values for this custom field. |
#' | project | list | *Deprecated: new integrations should prefer the `parent` field.* The id of the project that this custom field settings refers to. |
#'
#' @keywords internal
asn_get_custom_field_settings_for_project <- function(project_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/custom_field_settings", project_gid = project_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Create a project brief
#'
#' Creates a new project brief.  Returns the full record of the newly created project brief.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *Project Brief* allows you to explain the what and why of the project to your team.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | html_text | character scalar | HTML formatted text for the project brief. |
#' | title | character scalar | The title of the project brief. |
#' | permalink_url | character scalar | A url that points directly to the object within Asana. |
#' | project | list | The project with which this project brief is associated. |
#' | text | character scalar | [Opt In](https://developers.asana.com/docs/inputoutput-options). The plain text of the project brief. |
#'
#' @keywords internal
asn_create_project_brief <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/project_briefs", project_gid = project_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get memberships from a project
#'
#' Returns the compact project membership records for the project.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param user (optional) (character scalar) A string identifying a user. This can either be the string "me", an email, or the gid of a user.
#'
#' @return With the introduction of “comment-only” projects in Asana, a user’s membership in a project comes with associated permissions. These permissions (whether a user has full access to the project or comment-only access) are accessible through the project memberships endpoints described here.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | user | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#'
#' @keywords internal
asn_get_project_memberships_for_project <- function(project_gid, limit, offset, opt_fields, user) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/project_memberships", project_gid = project_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields), user = rlang::maybe_missing(user)),
    method = "get"
  )
}


#' Get statuses from a project
#'
#' *Deprecated: new integrations should prefer the `/status_updates` route.*  Returns the compact project status update records for all updates on the project.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return *Deprecated: new integrations should prefer the `status_update` resource.* A *project status* is an update on the progress of a particular project, and is sent out to all project followers when created. These updates include both text describing the update and a color code intended to represent the overall state of the project: "green" for projects that are on track, "yellow" for projects at risk, and "red" for projects that are behind.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | title | character scalar | The title of the project status update. |
#'
#' @keywords internal
asn_get_project_statuses_for_project <- function(project_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/project_statuses", project_gid = project_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Create a project status
#'
#' *Deprecated: new integrations should prefer the `/status_updates` route.*  Creates a new status update on the project.  Returns the full record of the newly created project status update.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return *Deprecated: new integrations should prefer the `status_update` resource.* A *project status* is an update on the progress of a particular project, and is sent out to all project followers when created. These updates include both text describing the update and a color code intended to represent the overall state of the project: "green" for projects that are on track, "yellow" for projects at risk, and "red" for projects that are behind.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | title | character scalar | The title of the project status update. |
#' | color | character scalar | The color associated with the status update. |
#' | html_text | character scalar | [Opt In](https://developers.asana.com/docs/inputoutput-options). The text content of the status update with formatting as HTML. |
#' | text | character scalar | The text content of the status update. |
#' | author | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | created_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | modified_at | datetime scalar | The time at which this project status was last modified. *Note: This does not currently reflect any changes in associations such as comments that may have been added or removed from the project status.* |
#'
#' @keywords internal
asn_create_project_status_for_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/project_statuses", project_gid = project_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get multiple projects
#'
#' Returns the compact project records for some filtered set of projects. Use one or more of the parameters provided to filter the projects returned. *Note: This endpoint may timeout for large domains. Try filtering by team!*
#'
#' @param archived (optional) (logical scalar) Only return projects whose `archived` field takes on the value of this parameter.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param team (optional) (character scalar) The team to filter projects on.
#' @param workspace (optional) (character scalar) The workspace or organization to filter projects on.
#'
#' @return A *project* represents a prioritized list of tasks in Asana or a board with columns of tasks represented as cards. It exists in a single workspace or organization and is accessible to a subset of users in that workspace or organization, depending on its permissions.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | Name of the project. This is generally a short sentence fragment that fits on a line in the UI for maximum readability. However, it can be longer. |
#'
#' @keywords internal
asn_get_projects <- function(archived, limit, offset, opt_fields, team, workspace) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects"),
    query = list(archived = rlang::maybe_missing(archived), limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields), team = rlang::maybe_missing(team), workspace = rlang::maybe_missing(workspace)),
    method = "get"
  )
}


#' Create a project
#'
#' Create a new project in a workspace or team.  Every project is required to be created in a specific workspace or organization, and this cannot be changed once set. Note that you can use the `workspace` parameter regardless of whether or not it is an organization.  If the workspace for your project is an organization, you must also supply a `team` to share the project with.  Returns the full record of the newly created project.
#'
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
asn_create_project <- function(opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects"),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get a project
#'
#' Returns the complete project record for a single project.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
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
asn_get_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}", project_gid = project_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Update a project
#'
#' A specific, existing project can be updated by making a PUT request on the URL for that project. Only the fields provided in the `data` block will be updated; any unspecified fields will remain unchanged.  When using this method, it is best to specify only those fields you wish to change, or else you may overwrite changes made by another user since you last retrieved the task.  Returns the complete updated project record.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
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
asn_update_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}", project_gid = project_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "put",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Delete a project
#'
#' A specific, existing project can be deleted by making a DELETE request on the URL for that project.  Returns an empty data record.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_delete_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}", project_gid = project_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "delete"
  )
}


#' Duplicate a project
#'
#' Creates and returns a job that will asynchronously handle the duplication.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *job* is an object representing a process that handles asynchronous work.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | new_project | list | A *project* represents a prioritized list of tasks in Asana or a board with columns of tasks represented as cards. It exists in a single workspace or organization and is accessible to a subset of users in that workspace or organization, depending on its permissions. |
#' | new_project_template | list | A *project template* is an object that allows new projects to be created with a predefined setup, which may include tasks, sections, Rules, etc. It simplifies the process of running a workflow that involves a similar set of work every time. |
#' | new_task | list | The *task* is the basic object around which many operations in Asana are centered. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. |
#' | status | character scalar | The current status of this job. The value is one of: `not_started`, `in_progress`, `succeeded`, or `failed`. |
#'
#' @keywords internal
asn_duplicate_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/duplicate", project_gid = project_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Add a custom field to a project
#'
#' Custom fields are associated with projects by way of custom field settings.  This method creates a setting for the project.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#'
#' @return Custom Fields Settings objects represent the many-to-many join of the Custom Field and Project as well as stores information that is relevant to that particular pairing.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | custom_field | list | The custom field that is applied to the `parent`. |
#' | is_important | logical scalar | `is_important` is used in the Asana web application to determine if this custom field is displayed in the list/grid view of a project or portfolio. |
#' | parent | list | The parent to which the custom field is applied. This can be a project or portfolio and indicates that the tasks or projects that the parent contains may be given custom field values for this custom field. |
#' | project | list | *Deprecated: new integrations should prefer the `parent` field.* The id of the project that this custom field settings refers to. |
#'
#' @keywords internal
asn_add_custom_field_setting_for_project <- function(project_gid) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/addCustomFieldSetting", project_gid = project_gid),
    query = list(),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Remove a custom field from a project
#'
#' Removes a custom field setting from a project.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_remove_custom_field_setting_for_project <- function(project_gid) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/removeCustomFieldSetting", project_gid = project_gid),
    query = list(),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get task count of a project
#'
#' Get an object that holds task count fields. **All fields are excluded by default**. You must [opt in](https://developers.asana.com/docs/inputoutput-options) using `opt_fields` to get any information from this endpoint.  This endpoint has an additional [rate limit](https://developers.asana.com/docs/rate-limits) and each field counts especially high against our [cost limits](https://developers.asana.com/docs/rate-limits#cost-limits).  Milestones are just tasks, so they are included in the `num_tasks`, `num_incomplete_tasks`, and `num_completed_tasks` counts.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A response object returned from the task count endpoint.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | num_completed_milestones | integer scalar | The number of completed milestones in a project. |
#' | num_completed_tasks | integer scalar | The number of completed tasks in a project. |
#' | num_incomplete_milestones | integer scalar | The number of incomplete milestones in a project. |
#' | num_incomplete_tasks | integer scalar | The number of incomplete tasks in a project. |
#' | num_milestones | integer scalar | The number of milestones in a project. |
#' | num_tasks | integer scalar | The number of tasks in a project. |
#'
#' @keywords internal
asn_get_task_counts_for_project <- function(project_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/task_counts", project_gid = project_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Add users to a project
#'
#' Adds the specified list of users as members of the project. Note that a user being added as a member may also be added as a *follower* as a result of this operation. This is because the user's default notification settings (i.e., in the "Notifcations" tab of "My Profile Settings") will override this endpoint's default behavior of setting "Tasks added" notifications to `false`. Returns the updated project record.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
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
asn_add_members_for_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/addMembers", project_gid = project_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Remove users from a project
#'
#' Removes the specified list of users from members of the project. Returns the updated project record.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
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
asn_remove_members_for_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/removeMembers", project_gid = project_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Add followers to a project
#'
#' Adds the specified list of users as followers to the project. Followers are a subset of members who have opted in to receive "tasks added" notifications for a project. Therefore, if the users are not already members of the project, they will also become members as a result of this operation. Returns the updated project record.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
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
asn_add_followers_for_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/addFollowers", project_gid = project_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Remove followers from a project
#'
#' Removes the specified list of users from following the project, this will not affect project membership status. Returns the updated project record.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
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
asn_remove_followers_for_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/removeFollowers", project_gid = project_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Create a project template from a project
#'
#' Creates and returns a job that will asynchronously handle the project template creation. Note that while the resulting project template can be accessed with the API, it won't be visible in the Asana UI until Project Templates 2.0 is launched in the app. See more in [this forum post](https://forum.asana.com/t/a-new-api-for-project-templates/156432).
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *job* is an object representing a process that handles asynchronous work.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | new_project | list | A *project* represents a prioritized list of tasks in Asana or a board with columns of tasks represented as cards. It exists in a single workspace or organization and is accessible to a subset of users in that workspace or organization, depending on its permissions. |
#' | new_project_template | list | A *project template* is an object that allows new projects to be created with a predefined setup, which may include tasks, sections, Rules, etc. It simplifies the process of running a workflow that involves a similar set of work every time. |
#' | new_task | list | The *task* is the basic object around which many operations in Asana are centered. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. |
#' | status | character scalar | The current status of this job. The value is one of: `not_started`, `in_progress`, `succeeded`, or `failed`. |
#'
#' @keywords internal
asn_project_save_as_template <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/saveAsTemplate", project_gid = project_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get sections in a project
#'
#' Returns the compact records for all sections in the specified project.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *section* is a subdivision of a project that groups tasks together. It can either be a header above a list of tasks in a list view or a column in a board view of a project.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the section (i.e. the text displayed as the section header). |
#'
#' @keywords internal
asn_get_sections_for_project <- function(project_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/sections", project_gid = project_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Create a section in a project
#'
#' Creates a new section in a project. Returns the full record of the newly created section.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *section* is a subdivision of a project that groups tasks together. It can either be a header above a list of tasks in a list view or a column in a board view of a project.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the section (i.e. the text displayed as the section header). |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | project | list | A *project* represents a prioritized list of tasks in Asana or a board with columns of tasks represented as cards. It exists in a single workspace or organization and is accessible to a subset of users in that workspace or organization, depending on its permissions. |
#' | projects | list | *Deprecated - please use project instead* |
#'
#' @keywords internal
asn_create_section_for_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/sections", project_gid = project_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Move or Insert sections
#'
#' Move sections relative to each other. One of `before_section` or `after_section` is required.  Sections cannot be moved between projects.  Returns an empty data block.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_insert_section_for_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/sections/insert", project_gid = project_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get tasks from a project
#'
#' Returns the compact task records for all tasks within the given project, ordered by their priority within the project. Tasks can exist in more than one project at a time.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param completed_since (optional) (character scalar) Only return tasks that are either incomplete or that have been completed since this time. Accepts a date-time string or the keyword *now*. 
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return The *task* is the basic object around which many operations in Asana are centered.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the task. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. The resource_subtype `milestone` represent a single moment in time. This means tasks with this subtype cannot have a start_date. |
#'
#' @keywords internal
asn_get_tasks_for_project <- function(project_gid, completed_since, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/tasks", project_gid = project_gid),
    query = list(completed_since = rlang::maybe_missing(completed_since), limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


