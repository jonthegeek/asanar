#' Get projects a task is in
#'
#' Returns a compact representation of all of the projects the task is in.
#'
#' @param task_gid (character scalar) The task to operate on.
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
asn_get_projects_for_task <- function(task_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/projects", task_gid = task_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Get stories from a task
#'
#' Returns the compact records for all stories on the task.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A story represents an activity associated with an object in the Asana system.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | created_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. |
#' | text | character scalar | *Create-only*. Human-readable text for the story or comment. This will not include the name of the creator. *Note: This is not guaranteed to be stable for a given type of story. For example, text for a reassignment may not always say “assigned to …” as the text for a story can both be edited and change based on the language settings of the user making the request.* Use the `resource_subtype` property to discover the action that created the story. |
#'
#' @keywords internal
asn_get_stories_for_task <- function(task_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/stories", task_gid = task_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Create a story on a task
#'
#' Adds a story to a task. This endpoint currently only allows for comment stories to be created. The comment will be authored by the currently authenticated user, and timestamped when the server receives the request.  Returns the full record for the new story added to the task.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A story represents an activity associated with an object in the Asana system.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | html_text | character scalar | [Opt In](/docs/inputoutput-options). HTML formatted text for a comment. This will not include the name of the creator. |
#' | is_pinned | logical scalar | *Conditional*. Whether the story should be pinned on the resource. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. |
#' | sticker_name | character scalar | The name of the sticker in this story. `null` if there is no sticker. |
#' | text | character scalar | The plain text of the comment to add. Cannot be used with html_text. |
#' | assignee | list | *Conditional* |
#' | created_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | custom_field | list | *Conditional* |
#' | dependency | list | *Conditional* |
#' | duplicate_of | list | *Conditional* |
#' | duplicated_from | list | *Conditional* |
#' | follower | list | *Conditional* |
#' | hearted | logical scalar | *Deprecated - please use likes instead* *Conditional*. True if the story is hearted by the authorized user, false if not. |
#' | hearts | list | *Deprecated - please use likes instead*  *Conditional*. Array of likes for users who have hearted this story. |
#' | is_editable | logical scalar | *Conditional*. Whether the text of the story can be edited after creation. |
#' | is_edited | logical scalar | *Conditional*. Whether the text of the story has been edited after creation. |
#' | liked | logical scalar | *Conditional*. True if the story is liked by the authorized user, false if not. |
#' | likes | list | *Conditional*. Array of likes for users who have liked this story. |
#' | new_approval_status | character scalar | *Conditional*. The new value of approval status. |
#' | new_date_value | list | *Conditional* The new value of a date custom field story. |
#' | new_dates | list | *Conditional* |
#' | new_enum_value | list | *Conditional* |
#' | new_multi_enum_values | list | *Conditional*. The new value of a multi-enum custom field story. |
#' | new_name | character scalar | *Conditional* |
#' | new_number_value | integer scalar | *Conditional* |
#' | new_people_value | list | *Conditional*. The new value of a people custom field story. |
#' | new_resource_subtype | character scalar | *Conditional* |
#' | new_section | list | *Conditional* |
#' | new_text_value | character scalar | *Conditional* |
#' | num_hearts | integer scalar | *Deprecated - please use likes instead*  *Conditional*. The number of users who have hearted this story. |
#' | num_likes | integer scalar | *Conditional*. The number of users who have liked this story. |
#' | old_approval_status | character scalar | *Conditional*. The old value of approval status. |
#' | old_date_value | list | *Conditional*. The old value of a date custom field story. |
#' | old_dates | list | *Conditional* |
#' | old_enum_value | list | *Conditional* |
#' | old_multi_enum_values | list | *Conditional*. The old value of a multi-enum custom field story. |
#' | old_name | character scalar | *Conditional*' |
#' | old_number_value | integer scalar | *Conditional* |
#' | old_people_value | list | *Conditional*. The old value of a people custom field story. |
#' | old_resource_subtype | character scalar | *Conditional* |
#' | old_section | list | *Conditional* |
#' | old_text_value | character scalar | *Conditional* |
#' | previews | list | *Conditional*. A collection of previews to be displayed in the story.  *Note: This property only exists for comment stories.* |
#' | project | list | *Conditional* |
#' | source | character scalar | The component of the Asana product the user used to trigger the story. |
#' | story | list | *Conditional* |
#' | tag | list | *Conditional* |
#' | target | list | The object this story is associated with. Currently may only be a task. |
#' | task | list | *Conditional* |
#' | type | character scalar | NA |
#'
#' @keywords internal
asn_create_story_for_task <- function(task_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/stories", task_gid = task_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get a task's tags
#'
#' Get a compact representation of all of the tags the task has.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *tag* is a label that can be attached to any task in Asana. It exists in a single workspace or organization.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | Name of the tag. This is generally a short sentence fragment that fits on a line in the UI for maximum readability. However, it can be longer. |
#'
#' @keywords internal
asn_get_tags_for_task <- function(task_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/tags", task_gid = task_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Get multiple tasks
#'
#' Returns the compact task records for some filtered set of tasks. Use one or more of the parameters provided to filter the tasks returned. You must specify a `project` or `tag` if you do not specify `assignee` and `workspace`.  For more complex task retrieval, use [workspaces/{workspace_gid}/tasks/search](/reference/searchtasksforworkspace).
#'
#' @param assignee (optional) (character scalar) The assignee to filter tasks on. If searching for unassigned tasks, assignee.any = null can be specified. *Note: If you specify `assignee`, you must also specify the `workspace` to filter on.*
#' @param completed_since (optional) (datetime scalar) Only return tasks that are either incomplete or that have been completed since this time.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param modified_since (optional) (datetime scalar) Only return tasks that have been modified since the given time.  *Note: A task is considered “modified” if any of its properties change, or associations between it and other objects are modified (e.g.  a task being added to a project). A task is not considered modified just because another object it is associated with (e.g. a subtask) is modified. Actions that count as modifying the task include assigning, renaming, completing, and adding stories.*
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param project (optional) (character scalar) The project to filter tasks on.
#' @param section (optional) (character scalar) The section to filter tasks on.
#' @param workspace (optional) (character scalar) The workspace to filter tasks on. *Note: If you specify `workspace`, you must also specify the `assignee` to filter on.*
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
asn_get_tasks <- function(assignee, completed_since, limit, modified_since, offset, opt_fields, project, section, workspace) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks"),
    query = list(assignee = rlang::maybe_missing(assignee), completed_since = rlang::maybe_missing(completed_since), limit = rlang::maybe_missing(limit), modified_since = rlang::maybe_missing(modified_since), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields), project = rlang::maybe_missing(project), section = rlang::maybe_missing(section), workspace = rlang::maybe_missing(workspace)),
    method = "get"
  )
}


#' Create a task
#'
#' Creating a new task is as easy as POSTing to the `/tasks` endpoint with a data block containing the fields you’d like to set on the task. Any unspecified fields will take on default values.  Every task is required to be created in a specific workspace, and this workspace cannot be changed once set. The workspace need not be set explicitly if you specify `projects` or a `parent` task instead.
#'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return The *task* is the basic object around which many operations in Asana are centered.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the task. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. The resource_subtype `milestone` represent a single moment in time. This means tasks with this subtype cannot have a start_date. |
#' | actual_time_minutes | number | This value represents the sum of all the Time Tracking entries in the Actual Time field on a given Task. It is represented as a nullable long value. |
#' | approval_status | character scalar | *Conditional* Reflects the approval status of this task. This field is kept in sync with `completed`, meaning `pending` translates to false while `approved`, `rejected`, and `changes_requested` translate to true. If you set completed to true, this field will be set to `approved`. |
#' | assignee_status | character scalar | *Deprecated* Scheduling status of this task for the user it is assigned to. This field can only be set if the assignee is non-null. Setting this field to "inbox" or "upcoming" inserts it at the top of the section, while the other options will insert at the bottom. |
#' | completed | logical scalar | True if the task is currently marked complete, false if not. |
#' | completed_at | datetime scalar | The time at which this task was completed, or null if the task is incomplete. |
#' | completed_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | dependencies | list | [Opt In](/docs/inputoutput-options). Array of resources referencing tasks that this task depends on. The objects contain only the gid of the dependency. |
#' | dependents | list | [Opt In](/docs/inputoutput-options). Array of resources referencing tasks that depend on this task. The objects contain only the ID of the dependent. |
#' | due_at | date scalar | The UTC date and time on which this task is due, or null if the task has no due time. This takes an ISO 8601 date string in UTC and should not be used together with `due_on`. |
#' | due_on | date scalar | The localized date on which this task is due, or null if the task has no due date. This takes a date with `YYYY-MM-DD` format and should not be used together with `due_at`. |
#' | external | list | *OAuth Required*. *Conditional*. This field is returned only if external values are set or included by using [Opt In] (/docs/inputoutput-options). The external field allows you to store app-specific metadata on tasks, including a gid that can be used to retrieve tasks and a data blob that can store app-specific character strings. Note that you will need to authenticate with Oauth to access or modify this data. Once an external gid is set, you can use the notation `external:custom_gid` to reference your object anywhere in the API where you may use the original object gid. See the page on Custom External Data for more details. |
#' | hearted | logical scalar | *Deprecated - please use liked instead* True if the task is hearted by the authorized user, false if not. |
#' | hearts | list | *Deprecated - please use likes instead* Array of likes for users who have hearted this task. |
#' | html_notes | character scalar | [Opt In](/docs/inputoutput-options). The notes of the text with formatting as HTML. |
#' | is_rendered_as_separator | logical scalar | [Opt In](/docs/inputoutput-options). In some contexts tasks can be rendered as a visual separator; for instance, subtasks can appear similar to [sections](/reference/sections) without being true `section` objects. If a `task` object is rendered this way in any context it will have the property `is_rendered_as_separator` set to `true`. |
#' | liked | logical scalar | True if the task is liked by the authorized user, false if not. |
#' | likes | list | Array of likes for users who have liked this task. |
#' | memberships | list | *Create-only*. Array of projects this task is associated with and the section it is in. At task creation time, this array can be used to add the task to specific sections. After task creation, these associations can be modified using the `addProject` and `removeProject` endpoints. Note that over time, more types of memberships may be added to this property. |
#' | modified_at | datetime scalar | The time at which this task was last modified.  *Note: This does not currently reflect any changes in associations such as projects or comments that may have been added or removed from the task.* |
#' | notes | character scalar | Free-form textual information associated with the task (i.e. its description). |
#' | num_hearts | integer scalar | *Deprecated - please use likes instead* The number of users who have hearted this task. |
#' | num_likes | integer scalar | The number of users who have liked this task. |
#' | num_subtasks | integer scalar | [Opt In](/docs/inputoutput-options). The number of subtasks on this task.  |
#' | start_at | date scalar | Date and time on which work begins for the task, or null if the task has no start time. This takes an ISO 8601 date string in UTC and should not be used together with `start_on`. *Note: `due_at` must be present in the request when setting or unsetting the `start_at` parameter.* |
#' | start_on | date scalar | The day on which work begins for the task , or null if the task has no start date. This takes a date with `YYYY-MM-DD` format and should not be used together with `start_at`. *Note: `due_on` or `due_at` must be present in the request when setting or unsetting the `start_on` parameter.* |
#' | assignee | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | assignee_section | list | The *assignee section* is a subdivision of a project that groups tasks together in the assignee's "My Tasks" list. It can either be a header above a list of tasks in a list view or a column in a board view of "My Tasks." The `assignee_section` property will be returned in the response only if the request was sent by the user who is the assignee of the task. Note that you can only write to `assignee_section` with the gid of an existing section visible in the user's "My Tasks" list. |
#' | custom_fields | list | Array of custom field values applied to the task. These represent the custom field values recorded on this project for a particular custom field. For example, these custom field values will contain an `enum_value` property for custom fields of type `enum`, a `text_value` property for custom fields of type `text`, and so on. Please note that the `gid` returned on each custom field value *is identical* to the `gid` of the custom field, which allows referencing the custom field metadata through the `/custom_fields/custom_field-gid` endpoint. |
#' | followers | list | Array of users following this task. |
#' | parent | list | The parent of this task, or `null` if this is not a subtask. This property cannot be modified using a PUT request but you can change it with the `setParent` endpoint. You can create subtasks by using the subtasks endpoint. |
#' | permalink_url | character scalar | A url that points directly to the object within Asana. |
#' | projects | list | *Create-only.* Array of projects this task is associated with. At task creation time, this array can be used to add the task to many projects at once. After task creation, these associations can be modified using the addProject and removeProject endpoints. |
#' | tags | list | Array of tags associated with this task. In order to change tags on an existing task use `addTag` and `removeTag`. |
#' | workspace | list | *Create-only*. The workspace this task is associated with. Once created, task cannot be moved to a different workspace. This attribute can only be specified at creation time. |
#'
#' @keywords internal
asn_create_task <- function(opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks"),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get a task
#'
#' Returns the complete task record for a single task.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return The *task* is the basic object around which many operations in Asana are centered.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the task. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. The resource_subtype `milestone` represent a single moment in time. This means tasks with this subtype cannot have a start_date. |
#' | actual_time_minutes | number | This value represents the sum of all the Time Tracking entries in the Actual Time field on a given Task. It is represented as a nullable long value. |
#' | approval_status | character scalar | *Conditional* Reflects the approval status of this task. This field is kept in sync with `completed`, meaning `pending` translates to false while `approved`, `rejected`, and `changes_requested` translate to true. If you set completed to true, this field will be set to `approved`. |
#' | assignee_status | character scalar | *Deprecated* Scheduling status of this task for the user it is assigned to. This field can only be set if the assignee is non-null. Setting this field to "inbox" or "upcoming" inserts it at the top of the section, while the other options will insert at the bottom. |
#' | completed | logical scalar | True if the task is currently marked complete, false if not. |
#' | completed_at | datetime scalar | The time at which this task was completed, or null if the task is incomplete. |
#' | completed_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | dependencies | list | [Opt In](/docs/inputoutput-options). Array of resources referencing tasks that this task depends on. The objects contain only the gid of the dependency. |
#' | dependents | list | [Opt In](/docs/inputoutput-options). Array of resources referencing tasks that depend on this task. The objects contain only the ID of the dependent. |
#' | due_at | date scalar | The UTC date and time on which this task is due, or null if the task has no due time. This takes an ISO 8601 date string in UTC and should not be used together with `due_on`. |
#' | due_on | date scalar | The localized date on which this task is due, or null if the task has no due date. This takes a date with `YYYY-MM-DD` format and should not be used together with `due_at`. |
#' | external | list | *OAuth Required*. *Conditional*. This field is returned only if external values are set or included by using [Opt In] (/docs/inputoutput-options). The external field allows you to store app-specific metadata on tasks, including a gid that can be used to retrieve tasks and a data blob that can store app-specific character strings. Note that you will need to authenticate with Oauth to access or modify this data. Once an external gid is set, you can use the notation `external:custom_gid` to reference your object anywhere in the API where you may use the original object gid. See the page on Custom External Data for more details. |
#' | hearted | logical scalar | *Deprecated - please use liked instead* True if the task is hearted by the authorized user, false if not. |
#' | hearts | list | *Deprecated - please use likes instead* Array of likes for users who have hearted this task. |
#' | html_notes | character scalar | [Opt In](/docs/inputoutput-options). The notes of the text with formatting as HTML. |
#' | is_rendered_as_separator | logical scalar | [Opt In](/docs/inputoutput-options). In some contexts tasks can be rendered as a visual separator; for instance, subtasks can appear similar to [sections](/reference/sections) without being true `section` objects. If a `task` object is rendered this way in any context it will have the property `is_rendered_as_separator` set to `true`. |
#' | liked | logical scalar | True if the task is liked by the authorized user, false if not. |
#' | likes | list | Array of likes for users who have liked this task. |
#' | memberships | list | *Create-only*. Array of projects this task is associated with and the section it is in. At task creation time, this array can be used to add the task to specific sections. After task creation, these associations can be modified using the `addProject` and `removeProject` endpoints. Note that over time, more types of memberships may be added to this property. |
#' | modified_at | datetime scalar | The time at which this task was last modified.  *Note: This does not currently reflect any changes in associations such as projects or comments that may have been added or removed from the task.* |
#' | notes | character scalar | Free-form textual information associated with the task (i.e. its description). |
#' | num_hearts | integer scalar | *Deprecated - please use likes instead* The number of users who have hearted this task. |
#' | num_likes | integer scalar | The number of users who have liked this task. |
#' | num_subtasks | integer scalar | [Opt In](/docs/inputoutput-options). The number of subtasks on this task.  |
#' | start_at | date scalar | Date and time on which work begins for the task, or null if the task has no start time. This takes an ISO 8601 date string in UTC and should not be used together with `start_on`. *Note: `due_at` must be present in the request when setting or unsetting the `start_at` parameter.* |
#' | start_on | date scalar | The day on which work begins for the task , or null if the task has no start date. This takes a date with `YYYY-MM-DD` format and should not be used together with `start_at`. *Note: `due_on` or `due_at` must be present in the request when setting or unsetting the `start_on` parameter.* |
#' | assignee | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | assignee_section | list | The *assignee section* is a subdivision of a project that groups tasks together in the assignee's "My Tasks" list. It can either be a header above a list of tasks in a list view or a column in a board view of "My Tasks." The `assignee_section` property will be returned in the response only if the request was sent by the user who is the assignee of the task. Note that you can only write to `assignee_section` with the gid of an existing section visible in the user's "My Tasks" list. |
#' | custom_fields | list | Array of custom field values applied to the task. These represent the custom field values recorded on this project for a particular custom field. For example, these custom field values will contain an `enum_value` property for custom fields of type `enum`, a `text_value` property for custom fields of type `text`, and so on. Please note that the `gid` returned on each custom field value *is identical* to the `gid` of the custom field, which allows referencing the custom field metadata through the `/custom_fields/custom_field-gid` endpoint. |
#' | followers | list | Array of users following this task. |
#' | parent | list | The parent of this task, or `null` if this is not a subtask. This property cannot be modified using a PUT request but you can change it with the `setParent` endpoint. You can create subtasks by using the subtasks endpoint. |
#' | permalink_url | character scalar | A url that points directly to the object within Asana. |
#' | projects | list | *Create-only.* Array of projects this task is associated with. At task creation time, this array can be used to add the task to many projects at once. After task creation, these associations can be modified using the addProject and removeProject endpoints. |
#' | tags | list | Array of tags associated with this task. In order to change tags on an existing task use `addTag` and `removeTag`. |
#' | workspace | list | *Create-only*. The workspace this task is associated with. Once created, task cannot be moved to a different workspace. This attribute can only be specified at creation time. |
#'
#' @keywords internal
asn_get_task <- function(task_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}", task_gid = task_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Update a task
#'
#' A specific, existing task can be updated by making a PUT request on the URL for that task. Only the fields provided in the `data` block will be updated; any unspecified fields will remain unchanged.  When using this method, it is best to specify only those fields you wish to change, or else you may overwrite changes made by another user since you last retrieved the task.  Returns the complete updated task record.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return The *task* is the basic object around which many operations in Asana are centered.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the task. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. The resource_subtype `milestone` represent a single moment in time. This means tasks with this subtype cannot have a start_date. |
#' | actual_time_minutes | number | This value represents the sum of all the Time Tracking entries in the Actual Time field on a given Task. It is represented as a nullable long value. |
#' | approval_status | character scalar | *Conditional* Reflects the approval status of this task. This field is kept in sync with `completed`, meaning `pending` translates to false while `approved`, `rejected`, and `changes_requested` translate to true. If you set completed to true, this field will be set to `approved`. |
#' | assignee_status | character scalar | *Deprecated* Scheduling status of this task for the user it is assigned to. This field can only be set if the assignee is non-null. Setting this field to "inbox" or "upcoming" inserts it at the top of the section, while the other options will insert at the bottom. |
#' | completed | logical scalar | True if the task is currently marked complete, false if not. |
#' | completed_at | datetime scalar | The time at which this task was completed, or null if the task is incomplete. |
#' | completed_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | dependencies | list | [Opt In](/docs/inputoutput-options). Array of resources referencing tasks that this task depends on. The objects contain only the gid of the dependency. |
#' | dependents | list | [Opt In](/docs/inputoutput-options). Array of resources referencing tasks that depend on this task. The objects contain only the ID of the dependent. |
#' | due_at | date scalar | The UTC date and time on which this task is due, or null if the task has no due time. This takes an ISO 8601 date string in UTC and should not be used together with `due_on`. |
#' | due_on | date scalar | The localized date on which this task is due, or null if the task has no due date. This takes a date with `YYYY-MM-DD` format and should not be used together with `due_at`. |
#' | external | list | *OAuth Required*. *Conditional*. This field is returned only if external values are set or included by using [Opt In] (/docs/inputoutput-options). The external field allows you to store app-specific metadata on tasks, including a gid that can be used to retrieve tasks and a data blob that can store app-specific character strings. Note that you will need to authenticate with Oauth to access or modify this data. Once an external gid is set, you can use the notation `external:custom_gid` to reference your object anywhere in the API where you may use the original object gid. See the page on Custom External Data for more details. |
#' | hearted | logical scalar | *Deprecated - please use liked instead* True if the task is hearted by the authorized user, false if not. |
#' | hearts | list | *Deprecated - please use likes instead* Array of likes for users who have hearted this task. |
#' | html_notes | character scalar | [Opt In](/docs/inputoutput-options). The notes of the text with formatting as HTML. |
#' | is_rendered_as_separator | logical scalar | [Opt In](/docs/inputoutput-options). In some contexts tasks can be rendered as a visual separator; for instance, subtasks can appear similar to [sections](/reference/sections) without being true `section` objects. If a `task` object is rendered this way in any context it will have the property `is_rendered_as_separator` set to `true`. |
#' | liked | logical scalar | True if the task is liked by the authorized user, false if not. |
#' | likes | list | Array of likes for users who have liked this task. |
#' | memberships | list | *Create-only*. Array of projects this task is associated with and the section it is in. At task creation time, this array can be used to add the task to specific sections. After task creation, these associations can be modified using the `addProject` and `removeProject` endpoints. Note that over time, more types of memberships may be added to this property. |
#' | modified_at | datetime scalar | The time at which this task was last modified.  *Note: This does not currently reflect any changes in associations such as projects or comments that may have been added or removed from the task.* |
#' | notes | character scalar | Free-form textual information associated with the task (i.e. its description). |
#' | num_hearts | integer scalar | *Deprecated - please use likes instead* The number of users who have hearted this task. |
#' | num_likes | integer scalar | The number of users who have liked this task. |
#' | num_subtasks | integer scalar | [Opt In](/docs/inputoutput-options). The number of subtasks on this task.  |
#' | start_at | date scalar | Date and time on which work begins for the task, or null if the task has no start time. This takes an ISO 8601 date string in UTC and should not be used together with `start_on`. *Note: `due_at` must be present in the request when setting or unsetting the `start_at` parameter.* |
#' | start_on | date scalar | The day on which work begins for the task , or null if the task has no start date. This takes a date with `YYYY-MM-DD` format and should not be used together with `start_at`. *Note: `due_on` or `due_at` must be present in the request when setting or unsetting the `start_on` parameter.* |
#' | assignee | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | assignee_section | list | The *assignee section* is a subdivision of a project that groups tasks together in the assignee's "My Tasks" list. It can either be a header above a list of tasks in a list view or a column in a board view of "My Tasks." The `assignee_section` property will be returned in the response only if the request was sent by the user who is the assignee of the task. Note that you can only write to `assignee_section` with the gid of an existing section visible in the user's "My Tasks" list. |
#' | custom_fields | list | Array of custom field values applied to the task. These represent the custom field values recorded on this project for a particular custom field. For example, these custom field values will contain an `enum_value` property for custom fields of type `enum`, a `text_value` property for custom fields of type `text`, and so on. Please note that the `gid` returned on each custom field value *is identical* to the `gid` of the custom field, which allows referencing the custom field metadata through the `/custom_fields/custom_field-gid` endpoint. |
#' | followers | list | Array of users following this task. |
#' | parent | list | The parent of this task, or `null` if this is not a subtask. This property cannot be modified using a PUT request but you can change it with the `setParent` endpoint. You can create subtasks by using the subtasks endpoint. |
#' | permalink_url | character scalar | A url that points directly to the object within Asana. |
#' | projects | list | *Create-only.* Array of projects this task is associated with. At task creation time, this array can be used to add the task to many projects at once. After task creation, these associations can be modified using the addProject and removeProject endpoints. |
#' | tags | list | Array of tags associated with this task. In order to change tags on an existing task use `addTag` and `removeTag`. |
#' | workspace | list | *Create-only*. The workspace this task is associated with. Once created, task cannot be moved to a different workspace. This attribute can only be specified at creation time. |
#'
#' @keywords internal
asn_update_task <- function(task_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}", task_gid = task_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "put",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Delete a task
#'
#' A specific, existing task can be deleted by making a DELETE request on the URL for that task. Deleted tasks go into the “trash” of the user making the delete request. Tasks can be recovered from the trash within a period of 30 days; afterward they are completely removed from the system.  Returns an empty data record.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_delete_task <- function(task_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}", task_gid = task_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "delete"
  )
}


#' Duplicate a task
#'
#' Creates and returns a job that will asynchronously handle the duplication.
#'
#' @param task_gid (character scalar) The task to operate on.
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
asn_duplicate_task <- function(task_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/duplicate", task_gid = task_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get subtasks from a task
#'
#' Returns a compact representation of all of the subtasks of a task.
#'
#' @param task_gid (character scalar) The task to operate on.
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
asn_get_subtasks_for_task <- function(task_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/subtasks", task_gid = task_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Create a subtask
#'
#' Creates a new subtask and adds it to the parent task. Returns the full record for the newly created subtask.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return The *task* is the basic object around which many operations in Asana are centered.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the task. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. The resource_subtype `milestone` represent a single moment in time. This means tasks with this subtype cannot have a start_date. |
#' | actual_time_minutes | number | This value represents the sum of all the Time Tracking entries in the Actual Time field on a given Task. It is represented as a nullable long value. |
#' | approval_status | character scalar | *Conditional* Reflects the approval status of this task. This field is kept in sync with `completed`, meaning `pending` translates to false while `approved`, `rejected`, and `changes_requested` translate to true. If you set completed to true, this field will be set to `approved`. |
#' | assignee_status | character scalar | *Deprecated* Scheduling status of this task for the user it is assigned to. This field can only be set if the assignee is non-null. Setting this field to "inbox" or "upcoming" inserts it at the top of the section, while the other options will insert at the bottom. |
#' | completed | logical scalar | True if the task is currently marked complete, false if not. |
#' | completed_at | datetime scalar | The time at which this task was completed, or null if the task is incomplete. |
#' | completed_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | dependencies | list | [Opt In](/docs/inputoutput-options). Array of resources referencing tasks that this task depends on. The objects contain only the gid of the dependency. |
#' | dependents | list | [Opt In](/docs/inputoutput-options). Array of resources referencing tasks that depend on this task. The objects contain only the ID of the dependent. |
#' | due_at | date scalar | The UTC date and time on which this task is due, or null if the task has no due time. This takes an ISO 8601 date string in UTC and should not be used together with `due_on`. |
#' | due_on | date scalar | The localized date on which this task is due, or null if the task has no due date. This takes a date with `YYYY-MM-DD` format and should not be used together with `due_at`. |
#' | external | list | *OAuth Required*. *Conditional*. This field is returned only if external values are set or included by using [Opt In] (/docs/inputoutput-options). The external field allows you to store app-specific metadata on tasks, including a gid that can be used to retrieve tasks and a data blob that can store app-specific character strings. Note that you will need to authenticate with Oauth to access or modify this data. Once an external gid is set, you can use the notation `external:custom_gid` to reference your object anywhere in the API where you may use the original object gid. See the page on Custom External Data for more details. |
#' | hearted | logical scalar | *Deprecated - please use liked instead* True if the task is hearted by the authorized user, false if not. |
#' | hearts | list | *Deprecated - please use likes instead* Array of likes for users who have hearted this task. |
#' | html_notes | character scalar | [Opt In](/docs/inputoutput-options). The notes of the text with formatting as HTML. |
#' | is_rendered_as_separator | logical scalar | [Opt In](/docs/inputoutput-options). In some contexts tasks can be rendered as a visual separator; for instance, subtasks can appear similar to [sections](/reference/sections) without being true `section` objects. If a `task` object is rendered this way in any context it will have the property `is_rendered_as_separator` set to `true`. |
#' | liked | logical scalar | True if the task is liked by the authorized user, false if not. |
#' | likes | list | Array of likes for users who have liked this task. |
#' | memberships | list | *Create-only*. Array of projects this task is associated with and the section it is in. At task creation time, this array can be used to add the task to specific sections. After task creation, these associations can be modified using the `addProject` and `removeProject` endpoints. Note that over time, more types of memberships may be added to this property. |
#' | modified_at | datetime scalar | The time at which this task was last modified.  *Note: This does not currently reflect any changes in associations such as projects or comments that may have been added or removed from the task.* |
#' | notes | character scalar | Free-form textual information associated with the task (i.e. its description). |
#' | num_hearts | integer scalar | *Deprecated - please use likes instead* The number of users who have hearted this task. |
#' | num_likes | integer scalar | The number of users who have liked this task. |
#' | num_subtasks | integer scalar | [Opt In](/docs/inputoutput-options). The number of subtasks on this task.  |
#' | start_at | date scalar | Date and time on which work begins for the task, or null if the task has no start time. This takes an ISO 8601 date string in UTC and should not be used together with `start_on`. *Note: `due_at` must be present in the request when setting or unsetting the `start_at` parameter.* |
#' | start_on | date scalar | The day on which work begins for the task , or null if the task has no start date. This takes a date with `YYYY-MM-DD` format and should not be used together with `start_at`. *Note: `due_on` or `due_at` must be present in the request when setting or unsetting the `start_on` parameter.* |
#' | assignee | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | assignee_section | list | The *assignee section* is a subdivision of a project that groups tasks together in the assignee's "My Tasks" list. It can either be a header above a list of tasks in a list view or a column in a board view of "My Tasks." The `assignee_section` property will be returned in the response only if the request was sent by the user who is the assignee of the task. Note that you can only write to `assignee_section` with the gid of an existing section visible in the user's "My Tasks" list. |
#' | custom_fields | list | Array of custom field values applied to the task. These represent the custom field values recorded on this project for a particular custom field. For example, these custom field values will contain an `enum_value` property for custom fields of type `enum`, a `text_value` property for custom fields of type `text`, and so on. Please note that the `gid` returned on each custom field value *is identical* to the `gid` of the custom field, which allows referencing the custom field metadata through the `/custom_fields/custom_field-gid` endpoint. |
#' | followers | list | Array of users following this task. |
#' | parent | list | The parent of this task, or `null` if this is not a subtask. This property cannot be modified using a PUT request but you can change it with the `setParent` endpoint. You can create subtasks by using the subtasks endpoint. |
#' | permalink_url | character scalar | A url that points directly to the object within Asana. |
#' | projects | list | *Create-only.* Array of projects this task is associated with. At task creation time, this array can be used to add the task to many projects at once. After task creation, these associations can be modified using the addProject and removeProject endpoints. |
#' | tags | list | Array of tags associated with this task. In order to change tags on an existing task use `addTag` and `removeTag`. |
#' | workspace | list | *Create-only*. The workspace this task is associated with. Once created, task cannot be moved to a different workspace. This attribute can only be specified at creation time. |
#'
#' @keywords internal
asn_create_subtask_for_task <- function(task_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/subtasks", task_gid = task_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Set the parent of a task
#'
#' parent, or no parent task at all. Returns an empty data block. When using `insert_before` and `insert_after`, at most one of those two options can be specified, and they must already be subtasks of the parent.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return The *task* is the basic object around which many operations in Asana are centered.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the task. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. The resource_subtype `milestone` represent a single moment in time. This means tasks with this subtype cannot have a start_date. |
#' | actual_time_minutes | number | This value represents the sum of all the Time Tracking entries in the Actual Time field on a given Task. It is represented as a nullable long value. |
#' | approval_status | character scalar | *Conditional* Reflects the approval status of this task. This field is kept in sync with `completed`, meaning `pending` translates to false while `approved`, `rejected`, and `changes_requested` translate to true. If you set completed to true, this field will be set to `approved`. |
#' | assignee_status | character scalar | *Deprecated* Scheduling status of this task for the user it is assigned to. This field can only be set if the assignee is non-null. Setting this field to "inbox" or "upcoming" inserts it at the top of the section, while the other options will insert at the bottom. |
#' | completed | logical scalar | True if the task is currently marked complete, false if not. |
#' | completed_at | datetime scalar | The time at which this task was completed, or null if the task is incomplete. |
#' | completed_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | dependencies | list | [Opt In](/docs/inputoutput-options). Array of resources referencing tasks that this task depends on. The objects contain only the gid of the dependency. |
#' | dependents | list | [Opt In](/docs/inputoutput-options). Array of resources referencing tasks that depend on this task. The objects contain only the ID of the dependent. |
#' | due_at | date scalar | The UTC date and time on which this task is due, or null if the task has no due time. This takes an ISO 8601 date string in UTC and should not be used together with `due_on`. |
#' | due_on | date scalar | The localized date on which this task is due, or null if the task has no due date. This takes a date with `YYYY-MM-DD` format and should not be used together with `due_at`. |
#' | external | list | *OAuth Required*. *Conditional*. This field is returned only if external values are set or included by using [Opt In] (/docs/inputoutput-options). The external field allows you to store app-specific metadata on tasks, including a gid that can be used to retrieve tasks and a data blob that can store app-specific character strings. Note that you will need to authenticate with Oauth to access or modify this data. Once an external gid is set, you can use the notation `external:custom_gid` to reference your object anywhere in the API where you may use the original object gid. See the page on Custom External Data for more details. |
#' | hearted | logical scalar | *Deprecated - please use liked instead* True if the task is hearted by the authorized user, false if not. |
#' | hearts | list | *Deprecated - please use likes instead* Array of likes for users who have hearted this task. |
#' | html_notes | character scalar | [Opt In](/docs/inputoutput-options). The notes of the text with formatting as HTML. |
#' | is_rendered_as_separator | logical scalar | [Opt In](/docs/inputoutput-options). In some contexts tasks can be rendered as a visual separator; for instance, subtasks can appear similar to [sections](/reference/sections) without being true `section` objects. If a `task` object is rendered this way in any context it will have the property `is_rendered_as_separator` set to `true`. |
#' | liked | logical scalar | True if the task is liked by the authorized user, false if not. |
#' | likes | list | Array of likes for users who have liked this task. |
#' | memberships | list | *Create-only*. Array of projects this task is associated with and the section it is in. At task creation time, this array can be used to add the task to specific sections. After task creation, these associations can be modified using the `addProject` and `removeProject` endpoints. Note that over time, more types of memberships may be added to this property. |
#' | modified_at | datetime scalar | The time at which this task was last modified.  *Note: This does not currently reflect any changes in associations such as projects or comments that may have been added or removed from the task.* |
#' | notes | character scalar | Free-form textual information associated with the task (i.e. its description). |
#' | num_hearts | integer scalar | *Deprecated - please use likes instead* The number of users who have hearted this task. |
#' | num_likes | integer scalar | The number of users who have liked this task. |
#' | num_subtasks | integer scalar | [Opt In](/docs/inputoutput-options). The number of subtasks on this task.  |
#' | start_at | date scalar | Date and time on which work begins for the task, or null if the task has no start time. This takes an ISO 8601 date string in UTC and should not be used together with `start_on`. *Note: `due_at` must be present in the request when setting or unsetting the `start_at` parameter.* |
#' | start_on | date scalar | The day on which work begins for the task , or null if the task has no start date. This takes a date with `YYYY-MM-DD` format and should not be used together with `start_at`. *Note: `due_on` or `due_at` must be present in the request when setting or unsetting the `start_on` parameter.* |
#' | assignee | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | assignee_section | list | The *assignee section* is a subdivision of a project that groups tasks together in the assignee's "My Tasks" list. It can either be a header above a list of tasks in a list view or a column in a board view of "My Tasks." The `assignee_section` property will be returned in the response only if the request was sent by the user who is the assignee of the task. Note that you can only write to `assignee_section` with the gid of an existing section visible in the user's "My Tasks" list. |
#' | custom_fields | list | Array of custom field values applied to the task. These represent the custom field values recorded on this project for a particular custom field. For example, these custom field values will contain an `enum_value` property for custom fields of type `enum`, a `text_value` property for custom fields of type `text`, and so on. Please note that the `gid` returned on each custom field value *is identical* to the `gid` of the custom field, which allows referencing the custom field metadata through the `/custom_fields/custom_field-gid` endpoint. |
#' | followers | list | Array of users following this task. |
#' | parent | list | The parent of this task, or `null` if this is not a subtask. This property cannot be modified using a PUT request but you can change it with the `setParent` endpoint. You can create subtasks by using the subtasks endpoint. |
#' | permalink_url | character scalar | A url that points directly to the object within Asana. |
#' | projects | list | *Create-only.* Array of projects this task is associated with. At task creation time, this array can be used to add the task to many projects at once. After task creation, these associations can be modified using the addProject and removeProject endpoints. |
#' | tags | list | Array of tags associated with this task. In order to change tags on an existing task use `addTag` and `removeTag`. |
#' | workspace | list | *Create-only*. The workspace this task is associated with. Once created, task cannot be moved to a different workspace. This attribute can only be specified at creation time. |
#'
#' @keywords internal
asn_set_parent_for_task <- function(task_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/setParent", task_gid = task_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get dependencies from a task
#'
#' Returns the compact representations of all of the dependencies of a task.
#'
#' @param task_gid (character scalar) The task to operate on.
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
asn_get_dependencies_for_task <- function(task_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/dependencies", task_gid = task_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Set dependencies for a task
#'
#' Marks a set of tasks as dependencies of this task, if they are not already dependencies. *A task can have at most 30 dependents and dependencies combined*.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_add_dependencies_for_task <- function(task_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/addDependencies", task_gid = task_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Unlink dependencies from a task
#'
#' Unlinks a set of dependencies from this task.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_remove_dependencies_for_task <- function(task_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/removeDependencies", task_gid = task_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get dependents from a task
#'
#' Returns the compact representations of all of the dependents of a task.
#'
#' @param task_gid (character scalar) The task to operate on.
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
asn_get_dependents_for_task <- function(task_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/dependents", task_gid = task_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Set dependents for a task
#'
#' Marks a set of tasks as dependents of this task, if they are not already dependents. *A task can have at most 30 dependents and dependencies combined*.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_add_dependents_for_task <- function(task_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/addDependents", task_gid = task_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Unlink dependents from a task
#'
#' Unlinks a set of dependents from this task.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_remove_dependents_for_task <- function(task_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/removeDependents", task_gid = task_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Add a project to a task
#'
#' Adds the task to the specified project, in the optional location specified. If no location arguments are given, the task will be added to the end of the project.  `addProject` can also be used to reorder a task within a project or section that already contains it.  At most one of `insert_before`, `insert_after`, or `section` should be specified. Inserting into a section in an non-order-dependent way can be done by specifying section, otherwise, to insert within a section in a particular place, specify `insert_before` or `insert_after` and a task within the section to anchor the position of this task.  Returns an empty data block.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_add_project_for_task <- function(task_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/addProject", task_gid = task_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Remove a project from a task
#'
#' Removes the task from the specified project. The task will still exist in the system, but it will not be in the project anymore.  Returns an empty data block.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_remove_project_for_task <- function(task_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/removeProject", task_gid = task_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Add a tag to a task
#'
#' Adds a tag to a task. Returns an empty data block.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_add_tag_for_task <- function(task_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/addTag", task_gid = task_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Remove a tag from a task
#'
#' Removes a tag from a task. Returns an empty data block.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_remove_tag_for_task <- function(task_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/removeTag", task_gid = task_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Add followers to a task
#'
#' Adds followers to a task. Returns an empty data block. Each task can be associated with zero or more followers in the system. Requests to add/remove followers, if successful, will return the complete updated task record, described above.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return The *task* is the basic object around which many operations in Asana are centered.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the task. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. The resource_subtype `milestone` represent a single moment in time. This means tasks with this subtype cannot have a start_date. |
#' | actual_time_minutes | number | This value represents the sum of all the Time Tracking entries in the Actual Time field on a given Task. It is represented as a nullable long value. |
#' | approval_status | character scalar | *Conditional* Reflects the approval status of this task. This field is kept in sync with `completed`, meaning `pending` translates to false while `approved`, `rejected`, and `changes_requested` translate to true. If you set completed to true, this field will be set to `approved`. |
#' | assignee_status | character scalar | *Deprecated* Scheduling status of this task for the user it is assigned to. This field can only be set if the assignee is non-null. Setting this field to "inbox" or "upcoming" inserts it at the top of the section, while the other options will insert at the bottom. |
#' | completed | logical scalar | True if the task is currently marked complete, false if not. |
#' | completed_at | datetime scalar | The time at which this task was completed, or null if the task is incomplete. |
#' | completed_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | dependencies | list | [Opt In](/docs/inputoutput-options). Array of resources referencing tasks that this task depends on. The objects contain only the gid of the dependency. |
#' | dependents | list | [Opt In](/docs/inputoutput-options). Array of resources referencing tasks that depend on this task. The objects contain only the ID of the dependent. |
#' | due_at | date scalar | The UTC date and time on which this task is due, or null if the task has no due time. This takes an ISO 8601 date string in UTC and should not be used together with `due_on`. |
#' | due_on | date scalar | The localized date on which this task is due, or null if the task has no due date. This takes a date with `YYYY-MM-DD` format and should not be used together with `due_at`. |
#' | external | list | *OAuth Required*. *Conditional*. This field is returned only if external values are set or included by using [Opt In] (/docs/inputoutput-options). The external field allows you to store app-specific metadata on tasks, including a gid that can be used to retrieve tasks and a data blob that can store app-specific character strings. Note that you will need to authenticate with Oauth to access or modify this data. Once an external gid is set, you can use the notation `external:custom_gid` to reference your object anywhere in the API where you may use the original object gid. See the page on Custom External Data for more details. |
#' | hearted | logical scalar | *Deprecated - please use liked instead* True if the task is hearted by the authorized user, false if not. |
#' | hearts | list | *Deprecated - please use likes instead* Array of likes for users who have hearted this task. |
#' | html_notes | character scalar | [Opt In](/docs/inputoutput-options). The notes of the text with formatting as HTML. |
#' | is_rendered_as_separator | logical scalar | [Opt In](/docs/inputoutput-options). In some contexts tasks can be rendered as a visual separator; for instance, subtasks can appear similar to [sections](/reference/sections) without being true `section` objects. If a `task` object is rendered this way in any context it will have the property `is_rendered_as_separator` set to `true`. |
#' | liked | logical scalar | True if the task is liked by the authorized user, false if not. |
#' | likes | list | Array of likes for users who have liked this task. |
#' | memberships | list | *Create-only*. Array of projects this task is associated with and the section it is in. At task creation time, this array can be used to add the task to specific sections. After task creation, these associations can be modified using the `addProject` and `removeProject` endpoints. Note that over time, more types of memberships may be added to this property. |
#' | modified_at | datetime scalar | The time at which this task was last modified.  *Note: This does not currently reflect any changes in associations such as projects or comments that may have been added or removed from the task.* |
#' | notes | character scalar | Free-form textual information associated with the task (i.e. its description). |
#' | num_hearts | integer scalar | *Deprecated - please use likes instead* The number of users who have hearted this task. |
#' | num_likes | integer scalar | The number of users who have liked this task. |
#' | num_subtasks | integer scalar | [Opt In](/docs/inputoutput-options). The number of subtasks on this task.  |
#' | start_at | date scalar | Date and time on which work begins for the task, or null if the task has no start time. This takes an ISO 8601 date string in UTC and should not be used together with `start_on`. *Note: `due_at` must be present in the request when setting or unsetting the `start_at` parameter.* |
#' | start_on | date scalar | The day on which work begins for the task , or null if the task has no start date. This takes a date with `YYYY-MM-DD` format and should not be used together with `start_at`. *Note: `due_on` or `due_at` must be present in the request when setting or unsetting the `start_on` parameter.* |
#' | assignee | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | assignee_section | list | The *assignee section* is a subdivision of a project that groups tasks together in the assignee's "My Tasks" list. It can either be a header above a list of tasks in a list view or a column in a board view of "My Tasks." The `assignee_section` property will be returned in the response only if the request was sent by the user who is the assignee of the task. Note that you can only write to `assignee_section` with the gid of an existing section visible in the user's "My Tasks" list. |
#' | custom_fields | list | Array of custom field values applied to the task. These represent the custom field values recorded on this project for a particular custom field. For example, these custom field values will contain an `enum_value` property for custom fields of type `enum`, a `text_value` property for custom fields of type `text`, and so on. Please note that the `gid` returned on each custom field value *is identical* to the `gid` of the custom field, which allows referencing the custom field metadata through the `/custom_fields/custom_field-gid` endpoint. |
#' | followers | list | Array of users following this task. |
#' | parent | list | The parent of this task, or `null` if this is not a subtask. This property cannot be modified using a PUT request but you can change it with the `setParent` endpoint. You can create subtasks by using the subtasks endpoint. |
#' | permalink_url | character scalar | A url that points directly to the object within Asana. |
#' | projects | list | *Create-only.* Array of projects this task is associated with. At task creation time, this array can be used to add the task to many projects at once. After task creation, these associations can be modified using the addProject and removeProject endpoints. |
#' | tags | list | Array of tags associated with this task. In order to change tags on an existing task use `addTag` and `removeTag`. |
#' | workspace | list | *Create-only*. The workspace this task is associated with. Once created, task cannot be moved to a different workspace. This attribute can only be specified at creation time. |
#'
#' @keywords internal
asn_add_followers_for_task <- function(task_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/addFollowers", task_gid = task_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Remove followers from a task
#'
#' Removes each of the specified followers from the task if they are following. Returns the complete, updated record for the affected task.
#'
#' @param task_gid (character scalar) The task to operate on.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return The *task* is the basic object around which many operations in Asana are centered.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the task. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. The resource_subtype `milestone` represent a single moment in time. This means tasks with this subtype cannot have a start_date. |
#' | actual_time_minutes | number | This value represents the sum of all the Time Tracking entries in the Actual Time field on a given Task. It is represented as a nullable long value. |
#' | approval_status | character scalar | *Conditional* Reflects the approval status of this task. This field is kept in sync with `completed`, meaning `pending` translates to false while `approved`, `rejected`, and `changes_requested` translate to true. If you set completed to true, this field will be set to `approved`. |
#' | assignee_status | character scalar | *Deprecated* Scheduling status of this task for the user it is assigned to. This field can only be set if the assignee is non-null. Setting this field to "inbox" or "upcoming" inserts it at the top of the section, while the other options will insert at the bottom. |
#' | completed | logical scalar | True if the task is currently marked complete, false if not. |
#' | completed_at | datetime scalar | The time at which this task was completed, or null if the task is incomplete. |
#' | completed_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | dependencies | list | [Opt In](/docs/inputoutput-options). Array of resources referencing tasks that this task depends on. The objects contain only the gid of the dependency. |
#' | dependents | list | [Opt In](/docs/inputoutput-options). Array of resources referencing tasks that depend on this task. The objects contain only the ID of the dependent. |
#' | due_at | date scalar | The UTC date and time on which this task is due, or null if the task has no due time. This takes an ISO 8601 date string in UTC and should not be used together with `due_on`. |
#' | due_on | date scalar | The localized date on which this task is due, or null if the task has no due date. This takes a date with `YYYY-MM-DD` format and should not be used together with `due_at`. |
#' | external | list | *OAuth Required*. *Conditional*. This field is returned only if external values are set or included by using [Opt In] (/docs/inputoutput-options). The external field allows you to store app-specific metadata on tasks, including a gid that can be used to retrieve tasks and a data blob that can store app-specific character strings. Note that you will need to authenticate with Oauth to access or modify this data. Once an external gid is set, you can use the notation `external:custom_gid` to reference your object anywhere in the API where you may use the original object gid. See the page on Custom External Data for more details. |
#' | hearted | logical scalar | *Deprecated - please use liked instead* True if the task is hearted by the authorized user, false if not. |
#' | hearts | list | *Deprecated - please use likes instead* Array of likes for users who have hearted this task. |
#' | html_notes | character scalar | [Opt In](/docs/inputoutput-options). The notes of the text with formatting as HTML. |
#' | is_rendered_as_separator | logical scalar | [Opt In](/docs/inputoutput-options). In some contexts tasks can be rendered as a visual separator; for instance, subtasks can appear similar to [sections](/reference/sections) without being true `section` objects. If a `task` object is rendered this way in any context it will have the property `is_rendered_as_separator` set to `true`. |
#' | liked | logical scalar | True if the task is liked by the authorized user, false if not. |
#' | likes | list | Array of likes for users who have liked this task. |
#' | memberships | list | *Create-only*. Array of projects this task is associated with and the section it is in. At task creation time, this array can be used to add the task to specific sections. After task creation, these associations can be modified using the `addProject` and `removeProject` endpoints. Note that over time, more types of memberships may be added to this property. |
#' | modified_at | datetime scalar | The time at which this task was last modified.  *Note: This does not currently reflect any changes in associations such as projects or comments that may have been added or removed from the task.* |
#' | notes | character scalar | Free-form textual information associated with the task (i.e. its description). |
#' | num_hearts | integer scalar | *Deprecated - please use likes instead* The number of users who have hearted this task. |
#' | num_likes | integer scalar | The number of users who have liked this task. |
#' | num_subtasks | integer scalar | [Opt In](/docs/inputoutput-options). The number of subtasks on this task.  |
#' | start_at | date scalar | Date and time on which work begins for the task, or null if the task has no start time. This takes an ISO 8601 date string in UTC and should not be used together with `start_on`. *Note: `due_at` must be present in the request when setting or unsetting the `start_at` parameter.* |
#' | start_on | date scalar | The day on which work begins for the task , or null if the task has no start date. This takes a date with `YYYY-MM-DD` format and should not be used together with `start_at`. *Note: `due_on` or `due_at` must be present in the request when setting or unsetting the `start_on` parameter.* |
#' | assignee | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | assignee_section | list | The *assignee section* is a subdivision of a project that groups tasks together in the assignee's "My Tasks" list. It can either be a header above a list of tasks in a list view or a column in a board view of "My Tasks." The `assignee_section` property will be returned in the response only if the request was sent by the user who is the assignee of the task. Note that you can only write to `assignee_section` with the gid of an existing section visible in the user's "My Tasks" list. |
#' | custom_fields | list | Array of custom field values applied to the task. These represent the custom field values recorded on this project for a particular custom field. For example, these custom field values will contain an `enum_value` property for custom fields of type `enum`, a `text_value` property for custom fields of type `text`, and so on. Please note that the `gid` returned on each custom field value *is identical* to the `gid` of the custom field, which allows referencing the custom field metadata through the `/custom_fields/custom_field-gid` endpoint. |
#' | followers | list | Array of users following this task. |
#' | parent | list | The parent of this task, or `null` if this is not a subtask. This property cannot be modified using a PUT request but you can change it with the `setParent` endpoint. You can create subtasks by using the subtasks endpoint. |
#' | permalink_url | character scalar | A url that points directly to the object within Asana. |
#' | projects | list | *Create-only.* Array of projects this task is associated with. At task creation time, this array can be used to add the task to many projects at once. After task creation, these associations can be modified using the addProject and removeProject endpoints. |
#' | tags | list | Array of tags associated with this task. In order to change tags on an existing task use `addTag` and `removeTag`. |
#' | workspace | list | *Create-only*. The workspace this task is associated with. Once created, task cannot be moved to a different workspace. This attribute can only be specified at creation time. |
#'
#' @keywords internal
asn_remove_follower_for_task <- function(task_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/tasks/{task_gid}/removeFollowers", task_gid = task_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


