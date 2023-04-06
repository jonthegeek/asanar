#' Get a section
#'
#' Returns the complete record for a single section.
#'
#' @param section_gid (character scalar) The globally unique identifier for the section.
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
asn_get_section <- function(section_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/sections/{section_gid}", section_gid = section_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Update a section
#'
#' A specific, existing section can be updated by making a PUT request on the URL for that project. Only the fields provided in the `data` block will be updated; any unspecified fields will remain unchanged. (note that at this time, the only field that can be updated is the `name` field.)  When using this method, it is best to specify only those fields you wish to change, or else you may overwrite changes made by another user since you last retrieved the task.  Returns the complete updated section record.
#'
#' @param section_gid (character scalar) The globally unique identifier for the section.
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
asn_update_section <- function(section_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/sections/{section_gid}", section_gid = section_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "put",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Delete a section
#'
#' A specific, existing section can be deleted by making a DELETE request on the URL for that section.  Note that sections must be empty to be deleted.  The last remaining section cannot be deleted.  Returns an empty data block.
#'
#' @param section_gid (character scalar) The globally unique identifier for the section.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_delete_section <- function(section_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/sections/{section_gid}", section_gid = section_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "delete"
  )
}


#' Add task to section
#'
#' Add a task to a specific, existing section. This will remove the task from other sections of the project.  The task will be inserted at the top of a section unless an insert_before or insert_after parameter is declared.  This does not work for separators (tasks with the resource_subtype of section).
#'
#' @param section_gid (character scalar) The globally unique identifier for the section.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_add_task_for_section <- function(section_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/sections/{section_gid}/addTask", section_gid = section_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get tasks from a section
#'
#' *Board view only*: Returns the compact section records for all tasks within the given section.
#'
#' @param section_gid (character scalar) The globally unique identifier for the section.
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
asn_get_tasks_for_section <- function(section_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/sections/{section_gid}/tasks", section_gid = section_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


