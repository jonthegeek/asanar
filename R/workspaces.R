#' Get audit log events
#'
#' Retrieve the audit log events that have been captured in your domain.  This endpoint will return a list of [AuditLogEvent](/reference/audit-log-api) objects, sorted by creation time in ascending order. Note that the Audit Log API captures events from October 8th, 2021 and later. Queries for events before this date will not return results.  There are a number of query parameters (below) that can be used to filter the set of [AuditLogEvent](/reference/audit-log-api) objects that are returned in the response. Any combination of query parameters is valid. When no filters are provided, all of the events that have been captured in your domain will match.  The list of events will always be [paginated](/docs/pagination). The default limit is 1000 events. The next set of events can be retrieved using the `offset` from the previous response. If there are no events that match the provided filters in your domain, the endpoint will return `null` for the `next_page` field. Querying again with the same filters may return new events if they were captured after the last request. Once a response includes a `next_page` with an `offset`, subsequent requests can be made with the latest `offset` to poll for new events that match the provided filters.  *Note: If the filters you provided match events in your domain and `next_page` is present in the response, we will continue to send `next_page` on subsequent requests even when there are no more events that match the filters. This was put in place so that you can implement an audit log stream that will return future events that match these filters. If you are not interested in future events that match the filters you have defined, you can rely on checking empty `data` response for the end of current events that match your filters.*  When no `offset` is provided, the response will begin with the oldest events that match the provided filters. It is important to note that [AuditLogEvent](/reference/audit-log-api) objects will be permanently deleted from our systems after 90 days. If you wish to keep a permanent record of these events, we recommend using a SIEM tool to ingest and store these logs.
#'
#' @param workspace_gid (character scalar) Globally unique identifier for the workspace or organization.
#' @param actor_gid (optional) (character scalar) Filter to events triggered by the actor with this ID.
#' @param actor_type (optional) (character scalar) Filter to events with an actor of this type. This only needs to be included if querying for actor types without an ID. If `actor_gid` is included, this should be excluded. Possible values: user, asana, asana_support, anonymous, external_administrator.
#' @param end_at (optional) (datetime scalar) Filter to events created before this time (exclusive).
#' @param event_type (optional) (character scalar) Filter to events of this type. Refer to the [supported audit log events](/docs/audit-log-events#supported-audit-log-events) for a full list of values.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param resource_gid (optional) (character scalar) Filter to events with this resource ID.
#' @param start_at (optional) (datetime scalar) Filter to events created after this time (inclusive).
#'
#' @return An object representing a single event within an Asana domain.  Every audit log event is comprised of an `event_type`, `actor`, `resource`, and `context`. Some events will include additional metadata about the event under `details`. See our [currently supported list of events](/docs/audit-log-events#supported-audit-log-events) for more details.
#'
#' @keywords internal
asn_get_audit_log_events <- function(workspace_gid, actor_gid, actor_type, end_at, event_type, limit, offset, resource_gid, start_at) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/workspaces/{workspace_gid}/audit_log_events", workspace_gid = workspace_gid),
    query = list(actor_gid = rlang::maybe_missing(actor_gid), actor_type = rlang::maybe_missing(actor_type), end_at = rlang::maybe_missing(end_at), event_type = rlang::maybe_missing(event_type), limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), resource_gid = rlang::maybe_missing(resource_gid), start_at = rlang::maybe_missing(start_at)),
    method = "get"
  )
}


#' Get a workspace's custom fields
#'
#' Returns a list of the compact representation of all of the custom fields in a workspace.
#'
#' @param workspace_gid (character scalar) Globally unique identifier for the workspace or organization.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_custom_fields_for_workspace <- function(workspace_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/workspaces/{workspace_gid}/custom_fields", workspace_gid = workspace_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Get all projects in a workspace
#'
#' Returns the compact project records for all projects in the workspace. *Note: This endpoint may timeout for large domains. Prefer the `/teams/{team_gid}/projects` endpoint.*
#'
#' @param workspace_gid (character scalar) Globally unique identifier for the workspace or organization.
#' @param archived (optional) (logical scalar) Only return projects whose `archived` field takes on the value of this parameter.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_projects_for_workspace <- function(workspace_gid, archived, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/workspaces/{workspace_gid}/projects", workspace_gid = workspace_gid),
    query = list(archived = rlang::maybe_missing(archived), limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Create a project in a workspace
#'
#' Creates a project in the workspace.  If the workspace for your project is an organization, you must also supply a team to share the project with.  Returns the full record of the newly created project.
#'
#' @param workspace_gid (character scalar) Globally unique identifier for the workspace or organization.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_create_project_for_workspace <- function(workspace_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/workspaces/{workspace_gid}/projects", workspace_gid = workspace_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get tags in a workspace
#'
#' Returns the compact tag records for some filtered set of tags. Use one or more of the parameters provided to filter the tags returned.
#'
#' @param workspace_gid (character scalar) Globally unique identifier for the workspace or organization.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_tags_for_workspace <- function(workspace_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/workspaces/{workspace_gid}/tags", workspace_gid = workspace_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Create a tag in a workspace
#'
#' Creates a new tag in a workspace or organization.  Every tag is required to be created in a specific workspace or organization, and this cannot be changed once set. Note that you can use the workspace parameter regardless of whether or not it is an organization.  Returns the full record of the newly created tag.
#'
#' @param workspace_gid (character scalar) Globally unique identifier for the workspace or organization.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_create_tag_for_workspace <- function(workspace_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/workspaces/{workspace_gid}/tags", workspace_gid = workspace_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Search tasks in a workspace
#'
#' To mirror the functionality of the Asana web app's advanced search feature, the Asana API has a task search endpoint that allows you to build complex filters to find and retrieve the exact data you need. #### Premium access Like the Asana web product's advance search feature, this search endpoint will only be available to premium Asana users. A user is premium if any of the following is true:  - The workspace in which the search is being performed is a premium workspace - The user is a member of a premium team inside the workspace  Even if a user is only a member of a premium team inside a non-premium workspace, search will allow them to find data anywhere in the workspace, not just inside the premium team. Making a search request using credentials of a non-premium user will result in a `402 Payment Required` error. #### Pagination Search results are not stable; repeating the same query multiple times may return the data in a different order, even if the data do not change. Because of this, the traditional [pagination](https://developers.asana.com/docs/#pagination) available elsewhere in the Asana API is not available here. However, you can paginate manually by sorting the search results by their creation time and then modifying each subsequent query to exclude data you have already seen. Page sizes are limited to a maximum of 100 items, and can be specified by the `limit` query parameter. #### Eventual consistency Changes in Asana (regardless of whether they’re made though the web product or the API) are forwarded to our search infrastructure to be indexed. This process can take between 10 and 60 seconds to complete under normal operation, and longer during some production incidents. Making a change to a task that would alter its presence in a particular search query will not be reflected immediately. This is also true of the advanced search feature in the web product. #### Rate limits You may receive a `429 Too Many Requests` response if you hit any of our [rate limits](https://developers.asana.com/docs/#rate-limits). #### Custom field parameters | Parameter name | Custom field type | Accepted type | |---|---|---| | custom_fields.{gid}.is_set | All | Boolean | | custom_fields.{gid}.value | Text | String | | custom_fields.{gid}.value | Number | Number | | custom_fields.{gid}.value | Enum | Enum option ID | | custom_fields.{gid}.starts_with | Text only | String | | custom_fields.{gid}.ends_with | Text only | String | | custom_fields.{gid}.contains | Text only | String | | custom_fields.{gid}.less_than | Number only | Number | | custom_fields.{gid}.greater_than | Number only | Number |   For example, if the gid of the custom field is 12345, these query parameter to find tasks where it is set would be `custom_fields.12345.is_set=true`. To match an exact value for an enum custom field, use the gid of the desired enum option and not the name of the enum option: `custom_fields.12345.value=67890`.  **Not Supported**: searching for multiple exact matches of a custom field, searching for multi-enum custom field  *Note: If you specify `projects.any` and `sections.any`, you will receive tasks for the project **and** tasks for the section. If you're looking for only tasks in a section, omit the `projects.any` from the request.*
#'
#' @param workspace_gid (character scalar) Globally unique identifier for the workspace or organization.
#' @param assigned_by.any (optional) (character scalar) Comma-separated list of user identifiers
#' @param assigned_by.not (optional) (character scalar) Comma-separated list of user identifiers
#' @param assignee.any (optional) (character scalar) Comma-separated list of user identifiers
#' @param assignee.not (optional) (character scalar) Comma-separated list of user identifiers
#' @param commented_on_by.not (optional) (character scalar) Comma-separated list of user identifiers
#' @param completed (optional) (logical scalar) Filter to completed tasks
#' @param completed_at.after (optional) (datetime scalar) ISO 8601 datetime string
#' @param completed_at.before (optional) (datetime scalar) ISO 8601 datetime string
#' @param completed_on (optional) (date scalar) ISO 8601 date string or `null`
#' @param completed_on.after (optional) (date scalar) ISO 8601 date string
#' @param completed_on.before (optional) (date scalar) ISO 8601 date string
#' @param created_at.after (optional) (datetime scalar) ISO 8601 datetime string
#' @param created_at.before (optional) (datetime scalar) ISO 8601 datetime string
#' @param created_by.any (optional) (character scalar) Comma-separated list of user identifiers
#' @param created_by.not (optional) (character scalar) Comma-separated list of user identifiers
#' @param created_on (optional) (date scalar) ISO 8601 date string or `null`
#' @param created_on.after (optional) (date scalar) ISO 8601 date string
#' @param created_on.before (optional) (date scalar) ISO 8601 date string
#' @param due_at.after (optional) (datetime scalar) ISO 8601 datetime string
#' @param due_at.before (optional) (datetime scalar) ISO 8601 datetime string
#' @param due_on (optional) (date scalar) ISO 8601 date string or `null`
#' @param due_on.after (optional) (date scalar) ISO 8601 date string
#' @param due_on.before (optional) (date scalar) ISO 8601 date string
#' @param followers.not (optional) (character scalar) Comma-separated list of user identifiers
#' @param has_attachment (optional) (logical scalar) Filter to tasks with attachments
#' @param is_blocked (optional) (logical scalar) Filter to tasks with incomplete dependencies
#' @param is_blocking (optional) (logical scalar) Filter to incomplete tasks with dependents
#' @param is_subtask (optional) (logical scalar) Filter to subtasks
#' @param liked_by.not (optional) (character scalar) Comma-separated list of user identifiers
#' @param modified_at.after (optional) (datetime scalar) ISO 8601 datetime string
#' @param modified_at.before (optional) (datetime scalar) ISO 8601 datetime string
#' @param modified_on (optional) (date scalar) ISO 8601 date string or `null`
#' @param modified_on.after (optional) (date scalar) ISO 8601 date string
#' @param modified_on.before (optional) (date scalar) ISO 8601 date string
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param portfolios.any (optional) (character scalar) Comma-separated list of portfolio IDs
#' @param projects.all (optional) (character scalar) Comma-separated list of project IDs
#' @param projects.any (optional) (character scalar) Comma-separated list of project IDs
#' @param projects.not (optional) (character scalar) Comma-separated list of project IDs
#' @param resource_subtype (optional) (character scalar) Filters results by the task's resource_subtype Possible values: default_task, milestone. Default: milestone
#' @param sections.all (optional) (character scalar) Comma-separated list of section or column IDs
#' @param sections.any (optional) (character scalar) Comma-separated list of section or column IDs
#' @param sections.not (optional) (character scalar) Comma-separated list of section or column IDs
#' @param sort_ascending (optional) (logical scalar) Default `false` Default: FALSE
#' @param sort_by (optional) (character scalar) One of `due_date`, `created_at`, `completed_at`, `likes`, or `modified_at`, defaults to `modified_at` Possible values: due_date, created_at, completed_at, likes, modified_at. Default: modified_at
#' @param start_on (optional) (date scalar) ISO 8601 date string or `null`
#' @param start_on.after (optional) (date scalar) ISO 8601 date string
#' @param start_on.before (optional) (date scalar) ISO 8601 date string
#' @param tags.all (optional) (character scalar) Comma-separated list of tag IDs
#' @param tags.any (optional) (character scalar) Comma-separated list of tag IDs
#' @param tags.not (optional) (character scalar) Comma-separated list of tag IDs
#' @param teams.any (optional) (character scalar) Comma-separated list of team IDs
#' @param text (optional) (character scalar) Performs full-text search on both task name and description
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_search_tasks_for_workspace <- function(workspace_gid, assigned_by.any, assigned_by.not, assignee.any, assignee.not, commented_on_by.not, completed, completed_at.after, completed_at.before, completed_on, completed_on.after, completed_on.before, created_at.after, created_at.before, created_by.any, created_by.not, created_on, created_on.after, created_on.before, due_at.after, due_at.before, due_on, due_on.after, due_on.before, followers.not, has_attachment, is_blocked, is_blocking, is_subtask, liked_by.not, modified_at.after, modified_at.before, modified_on, modified_on.after, modified_on.before, opt_fields, portfolios.any, projects.all, projects.any, projects.not, resource_subtype = "milestone", sections.all, sections.any, sections.not, sort_ascending = "FALSE", sort_by = "modified_at", start_on, start_on.after, start_on.before, tags.all, tags.any, tags.not, teams.any, text) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/workspaces/{workspace_gid}/tasks/search", workspace_gid = workspace_gid),
    query = list(assigned_by.any = rlang::maybe_missing(assigned_by.any), assigned_by.not = rlang::maybe_missing(assigned_by.not), assignee.any = rlang::maybe_missing(assignee.any), assignee.not = rlang::maybe_missing(assignee.not), commented_on_by.not = rlang::maybe_missing(commented_on_by.not), completed = rlang::maybe_missing(completed), completed_at.after = rlang::maybe_missing(completed_at.after), completed_at.before = rlang::maybe_missing(completed_at.before), completed_on = rlang::maybe_missing(completed_on), completed_on.after = rlang::maybe_missing(completed_on.after), completed_on.before = rlang::maybe_missing(completed_on.before), created_at.after = rlang::maybe_missing(created_at.after), created_at.before = rlang::maybe_missing(created_at.before), created_by.any = rlang::maybe_missing(created_by.any), created_by.not = rlang::maybe_missing(created_by.not), created_on = rlang::maybe_missing(created_on), created_on.after = rlang::maybe_missing(created_on.after), created_on.before = rlang::maybe_missing(created_on.before), due_at.after = rlang::maybe_missing(due_at.after), due_at.before = rlang::maybe_missing(due_at.before), due_on = rlang::maybe_missing(due_on), due_on.after = rlang::maybe_missing(due_on.after), due_on.before = rlang::maybe_missing(due_on.before), followers.not = rlang::maybe_missing(followers.not), has_attachment = rlang::maybe_missing(has_attachment), is_blocked = rlang::maybe_missing(is_blocked), is_blocking = rlang::maybe_missing(is_blocking), is_subtask = rlang::maybe_missing(is_subtask), liked_by.not = rlang::maybe_missing(liked_by.not), modified_at.after = rlang::maybe_missing(modified_at.after), modified_at.before = rlang::maybe_missing(modified_at.before), modified_on = rlang::maybe_missing(modified_on), modified_on.after = rlang::maybe_missing(modified_on.after), modified_on.before = rlang::maybe_missing(modified_on.before), opt_fields = rlang::maybe_missing(opt_fields), portfolios.any = rlang::maybe_missing(portfolios.any), projects.all = rlang::maybe_missing(projects.all), projects.any = rlang::maybe_missing(projects.any), projects.not = rlang::maybe_missing(projects.not), resource_subtype = rlang::maybe_missing(resource_subtype), sections.all = rlang::maybe_missing(sections.all), sections.any = rlang::maybe_missing(sections.any), sections.not = rlang::maybe_missing(sections.not), sort_ascending = rlang::maybe_missing(sort_ascending), sort_by = rlang::maybe_missing(sort_by), start_on = rlang::maybe_missing(start_on), start_on.after = rlang::maybe_missing(start_on.after), start_on.before = rlang::maybe_missing(start_on.before), tags.all = rlang::maybe_missing(tags.all), tags.any = rlang::maybe_missing(tags.any), tags.not = rlang::maybe_missing(tags.not), teams.any = rlang::maybe_missing(teams.any), text = rlang::maybe_missing(text)),
    method = "get"
  )
}


#' Get teams in a workspace
#'
#' Returns the compact records for all teams in the workspace visible to the authorized user.
#'
#' @param workspace_gid (character scalar) Globally unique identifier for the workspace or organization.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_teams_for_workspace <- function(workspace_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/workspaces/{workspace_gid}/teams", workspace_gid = workspace_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Get objects via typeahead
#'
#' Retrieves objects in the workspace based via an auto-completion/typeahead search algorithm. This feature is meant to provide results quickly, so do not rely on this API to provide extremely accurate search results. The result set is limited to a single page of results with a maximum size, so you won’t be able to fetch large numbers of results.  The typeahead search API provides search for objects from a single workspace. This endpoint should be used to query for objects when creating an auto-completion/typeahead search feature. This API is meant to provide results quickly and should not be relied upon for accurate or exhaustive search results. The results sets are limited in size and cannot be paginated.  Queries return a compact representation of each object which is typically the gid and name fields. Interested in a specific set of fields or all of the fields?! Of course you are. Use field selectors to manipulate what data is included in a response.  Resources with type `user` are returned in order of most contacted to least contacted. This is determined by task assignments, adding the user to projects, and adding the user as a follower to tasks, messages, etc.  Resources with type `project` are returned in order of recency. This is determined when the user visits the project, is added to the project, and completes tasks in the project.  Resources with type `task` are returned with priority placed on tasks the user is following, but no guarantee on the order of those tasks.  Resources with type `project_template` are returned with priority placed on favorited project templates.  Leaving the `query` string empty or omitted will give you results, still following the resource ordering above. This could be used to list users or projects that are relevant for the requesting user's api token.
#'
#' @param workspace_gid (character scalar) Globally unique identifier for the workspace or organization.
#' @param count (optional) (integer scalar) The number of results to return. The default is 20 if this parameter is omitted, with a minimum of 1 and a maximum of 100. If there are fewer results found than requested, all will be returned.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param query (optional) (character scalar) The string that will be used to search for relevant objects. If an empty string is passed in, the API will return results.
#' @param type (optional) (character scalar) *Deprecated: new integrations should prefer the resource_type field.* Possible values: custom_field, portfolio, project, tag, task, user. Default: user
#' @param resource_type (character scalar) The type of values the typeahead should return. You can choose from one of the following: `custom_field`, `project`, `project_template`, `portfolio`, `tag`, `task`, and `user`. Note that unlike in the names of endpoints, the types listed here are in singular form (e.g. `task`). Using multiple types is not yet supported. Possible values: custom_field, project, project_template, portfolio, tag, task, user. Default: user
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_typeahead_for_workspace <- function(resource_type = "user", workspace_gid, count, opt_fields, query, type = "user") {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/workspaces/{workspace_gid}/typeahead", workspace_gid = workspace_gid),
    query = list(resource_type = resource_type, count = rlang::maybe_missing(count), opt_fields = rlang::maybe_missing(opt_fields), query = rlang::maybe_missing(query), type = rlang::maybe_missing(type)),
    method = "get"
  )
}


#' Get users in a workspace or organization
#'
#' Returns the compact records for all users in the specified workspace or organization. Results are sorted alphabetically and limited to 2000. For more results use the `/users` endpoint.
#'
#' @param workspace_gid (character scalar) Globally unique identifier for the workspace or organization.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_users_for_workspace <- function(workspace_gid, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/workspaces/{workspace_gid}/users", workspace_gid = workspace_gid),
    query = list(offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Get the workspace memberships for a workspace
#'
#' Returns the compact workspace membership records for the workspace.
#'
#' @param workspace_gid (character scalar) Globally unique identifier for the workspace or organization.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param user (optional) (character scalar) A string identifying a user. This can either be the string "me", an email, or the gid of a user.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_workspace_memberships_for_workspace <- function(workspace_gid, limit, offset, opt_fields, user) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/workspaces/{workspace_gid}/workspace_memberships", workspace_gid = workspace_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields), user = rlang::maybe_missing(user)),
    method = "get"
  )
}


#' Get multiple workspaces
#'
#' Returns the compact records for all workspaces visible to the authorized user.
#'
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_workspaces <- function(limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/workspaces"),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Get a workspace
#'
#' Returns the full workspace record for a single workspace.
#'
#' @param workspace_gid (character scalar) Globally unique identifier for the workspace or organization.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_workspace <- function(workspace_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/workspaces/{workspace_gid}", workspace_gid = workspace_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Update a workspace
#'
#' A specific, existing workspace can be updated by making a PUT request on the URL for that workspace. Only the fields provided in the data block will be updated; any unspecified fields will remain unchanged. Currently the only field that can be modified for a workspace is its name. Returns the complete, updated workspace record.
#'
#' @param workspace_gid (character scalar) Globally unique identifier for the workspace or organization.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_update_workspace <- function(workspace_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/workspaces/{workspace_gid}", workspace_gid = workspace_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "put",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Add a user to a workspace or organization
#'
#' Add a user to a workspace or organization. The user can be referenced by their globally unique user ID or their email address. Returns the full user record for the invited user.
#'
#' @param workspace_gid (character scalar) Globally unique identifier for the workspace or organization.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_add_user_for_workspace <- function(workspace_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/workspaces/{workspace_gid}/addUser", workspace_gid = workspace_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Remove a user from a workspace or organization
#'
#' Remove a user from a workspace or organization. The user making this call must be an admin in the workspace. The user can be referenced by their globally unique user ID or their email address. Returns an empty data record.
#'
#' @param workspace_gid (character scalar) Globally unique identifier for the workspace or organization.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#' @keywords internal
asn_remove_user_for_workspace <- function(workspace_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/workspaces/{workspace_gid}/removeUser", workspace_gid = workspace_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}
