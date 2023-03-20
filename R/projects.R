#' Get a project's custom fields
#'
#' Returns a list of all of the custom fields settings on a project, in compact form. Note that, as in all queries to collections which return compact representation, `opt_fields` can be used to include more data than is returned in the compact representation. See the [getting started guide on input/output options](https://developers.asana.com/docs/#input-output-options) for more information.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_custom_field_settings_for_project <- function(project_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/custom_field_settings", project_gid = project_gid),
    query = list(limit = limit, offset = offset, opt_fields = opt_fields),
    method = "get"
  )
}


#' Create a project brief
#'
#' Creates a new project brief.  Returns the full record of the newly created project brief.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_create_project_brief <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/project_briefs", project_gid = project_gid),
    query = list(opt_fields = opt_fields),
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
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param user (optional) (character scalar) A string identifying a user. This can either be the string "me", an email, or the gid of a user.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_project_memberships_for_project <- function(project_gid, limit, offset, opt_fields, user) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/project_memberships", project_gid = project_gid),
    query = list(limit = limit, offset = offset, opt_fields = opt_fields, user = user),
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
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_project_statuses_for_project <- function(project_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/project_statuses", project_gid = project_gid),
    query = list(limit = limit, offset = offset, opt_fields = opt_fields),
    method = "get"
  )
}


#' Create a project status
#'
#' *Deprecated: new integrations should prefer the `/status_updates` route.*  Creates a new status update on the project.  Returns the full record of the newly created project status update.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_create_project_status_for_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/project_statuses", project_gid = project_gid),
    query = list(opt_fields = opt_fields),
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
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param team (optional) (character scalar) The team to filter projects on.
#' @param workspace (optional) (character scalar) The workspace or organization to filter projects on.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_projects <- function(archived, limit, offset, opt_fields, team, workspace) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects"),
    query = list(archived = archived, limit = limit, offset = offset, opt_fields = opt_fields, team = team, workspace = workspace),
    method = "get"
  )
}


#' Create a project
#'
#' Create a new project in a workspace or team.  Every project is required to be created in a specific workspace or organization, and this cannot be changed once set. Note that you can use the `workspace` parameter regardless of whether or not it is an organization.  If the workspace for your project is an organization, you must also supply a `team` to share the project with.  Returns the full record of the newly created project.
#'
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_create_project <- function(opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects"),
    query = list(opt_fields = opt_fields),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get a project
#'
#' Returns the complete project record for a single project.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}", project_gid = project_gid),
    query = list(opt_fields = opt_fields),
    method = "get"
  )
}


#' Update a project
#'
#' A specific, existing project can be updated by making a PUT request on the URL for that project. Only the fields provided in the `data` block will be updated; any unspecified fields will remain unchanged.  When using this method, it is best to specify only those fields you wish to change, or else you may overwrite changes made by another user since you last retrieved the task.  Returns the complete updated project record.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_update_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}", project_gid = project_gid),
    query = list(opt_fields = opt_fields),
    method = "put",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Delete a project
#'
#' A specific, existing project can be deleted by making a DELETE request on the URL for that project.  Returns an empty data record.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#' @keywords internal
asn_delete_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}", project_gid = project_gid),
    query = list(opt_fields = opt_fields),
    method = "delete"
  )
}


#' Duplicate a project
#'
#' Creates and returns a job that will asynchronously handle the duplication.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_duplicate_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/duplicate", project_gid = project_gid),
    query = list(opt_fields = opt_fields),
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
#' @return A generic Asana Resource, containing a globally unique identifier.
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
#' Get an object that holds task count fields. **All fields are excluded by default**. You must [opt in](/docs/inputoutput-options) using `opt_fields` to get any information from this endpoint.  This endpoint has an additional [rate limit](/docs/rate-limits) and each field counts especially high against our [cost limits](/docs/rate-limits#cost-limits).  Milestones are just tasks, so they are included in the `num_tasks`, `num_incomplete_tasks`, and `num_completed_tasks` counts.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A response object returned from the task count endpoint.
#'
#' @keywords internal
asn_get_task_counts_for_project <- function(project_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/task_counts", project_gid = project_gid),
    query = list(limit = limit, offset = offset, opt_fields = opt_fields),
    method = "get"
  )
}


#' Add users to a project
#'
#' Adds the specified list of users as members of the project. Note that a user being added as a member may also be added as a *follower* as a result of this operation. This is because the user's default notification settings (i.e., in the "Notifcations" tab of "My Profile Settings") will override this endpoint's default behavior of setting "Tasks added" notifications to `false`. Returns the updated project record.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_add_members_for_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/addMembers", project_gid = project_gid),
    query = list(opt_fields = opt_fields),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Remove users from a project
#'
#' Removes the specified list of users from members of the project. Returns the updated project record.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_remove_members_for_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/removeMembers", project_gid = project_gid),
    query = list(opt_fields = opt_fields),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Add followers to a project
#'
#' Adds the specified list of users as followers to the project. Followers are a subset of members who have opted in to receive "tasks added" notifications for a project. Therefore, if the users are not already members of the project, they will also become members as a result of this operation. Returns the updated project record.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_add_followers_for_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/addFollowers", project_gid = project_gid),
    query = list(opt_fields = opt_fields),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Remove followers from a project
#'
#' Removes the specified list of users from following the project, this will not affect project membership status. Returns the updated project record.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_remove_followers_for_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/removeFollowers", project_gid = project_gid),
    query = list(opt_fields = opt_fields),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Create a project template from a project
#'
#' Creates and returns a job that will asynchronously handle the project template creation. Note that while the resulting project template can be accessed with the API, it won't be visible in the Asana UI until Project Templates 2.0 is launched in the app. See more in [this forum post](https://forum.asana.com/t/a-new-api-for-project-templates/156432).
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_project_save_as_template <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/saveAsTemplate", project_gid = project_gid),
    query = list(opt_fields = opt_fields),
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
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_sections_for_project <- function(project_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/sections", project_gid = project_gid),
    query = list(limit = limit, offset = offset, opt_fields = opt_fields),
    method = "get"
  )
}


#' Create a section in a project
#'
#' Creates a new section in a project. Returns the full record of the newly created section.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_create_section_for_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/sections", project_gid = project_gid),
    query = list(opt_fields = opt_fields),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Move or Insert sections
#'
#' Move sections relative to each other. One of `before_section` or `after_section` is required.  Sections cannot be moved between projects.  Returns an empty data block.
#'
#' @param project_gid (character scalar) Globally unique identifier for the project.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#' @keywords internal
asn_insert_section_for_project <- function(project_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/sections/insert", project_gid = project_gid),
    query = list(opt_fields = opt_fields),
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
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_tasks_for_project <- function(project_gid, completed_since, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/projects/{project_gid}/tasks", project_gid = project_gid),
    query = list(completed_since = completed_since, limit = limit, offset = offset, opt_fields = opt_fields),
    method = "get"
  )
}
