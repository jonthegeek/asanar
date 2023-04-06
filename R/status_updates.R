#' Get a status update
#'
#' Returns the complete record for a single status update.
#'
#' @param status_gid (character scalar) The status update to get.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *status update* is an update on the progress of a particular project, portfolio, or goal, and is sent out to all of its parent's followers when created. These updates include both text describing the update and a `status_type` intended to represent the overall state of the project.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. The `resource_subtype`s for `status` objects represent the type of their parent. |
#' | title | character scalar | The title of the status update. |
#' | html_text | character scalar | [Opt In](https://developers.asana.com/docs/inputoutput-options). The text content of the status update with formatting as HTML. |
#' | status_type | character scalar | The type associated with the status update. This represents the current state of the object this object is on. |
#' | text | character scalar | The text content of the status update. |
#' | author | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | created_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | hearted | logical scalar | *Deprecated - please use liked instead* True if the status is hearted by the authorized user, false if not. |
#' | hearts | list | *Deprecated - please use likes instead* Array of likes for users who have hearted this status. |
#' | liked | logical scalar | True if the status is liked by the authorized user, false if not. |
#' | likes | list | Array of likes for users who have liked this status. |
#' | modified_at | datetime scalar | The time at which this project status was last modified. *Note: This does not currently reflect any changes in associations such as comments that may have been added or removed from the status.* |
#' | num_hearts | integer scalar | *Deprecated - please use likes instead* The number of users who have hearted this status. |
#' | num_likes | integer scalar | The number of users who have liked this status. |
#' | parent | list | The parent of the status update. This can be a project, goal or portfolio, and indicates that this status was sent on that object. |
#'
#' @keywords internal
asn_get_status <- function(status_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/status_updates/{status_gid}", status_gid = status_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Delete a status update
#'
#' Deletes a specific, existing status update.  Returns an empty data record.
#'
#' @param status_gid (character scalar) The status update to get.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_delete_status <- function(status_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/status_updates/{status_gid}", status_gid = status_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "delete"
  )
}


#' Get status updates from an object
#'
#' Returns the compact status update records for all updates on the object.
#'
#' @param created_since (optional) (datetime scalar) Only return statuses that have been created since the given time.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param parent (character scalar) Globally unique identifier for object to fetch statuses from. Must be a GID for a project, portfolio, or goal.
#'
#' @return A *status update* is an update on the progress of a particular project, portfolio, or goal, and is sent out to all of its parent's followers when created. These updates include both text describing the update and a `status_type` intended to represent the overall state of the project.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. The `resource_subtype`s for `status` objects represent the type of their parent. |
#' | title | character scalar | The title of the status update. |
#'
#' @keywords internal
asn_get_statuses_for_object <- function(parent, created_since, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/status_updates"),
    query = list(parent = parent, created_since = rlang::maybe_missing(created_since), limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Create a status update
#'
#' Creates a new status update on an object. Returns the full record of the newly created status update.
#'
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *status update* is an update on the progress of a particular project, portfolio, or goal, and is sent out to all of its parent's followers when created. These updates include both text describing the update and a `status_type` intended to represent the overall state of the project.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | resource_subtype | character scalar | The subtype of this resource. Different subtypes retain many of the same fields and behavior, but may render differently in Asana or represent resources with different semantic meaning. The `resource_subtype`s for `status` objects represent the type of their parent. |
#' | title | character scalar | The title of the status update. |
#' | html_text | character scalar | [Opt In](https://developers.asana.com/docs/inputoutput-options). The text content of the status update with formatting as HTML. |
#' | status_type | character scalar | The type associated with the status update. This represents the current state of the object this object is on. |
#' | text | character scalar | The text content of the status update. |
#' | author | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | created_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | hearted | logical scalar | *Deprecated - please use liked instead* True if the status is hearted by the authorized user, false if not. |
#' | hearts | list | *Deprecated - please use likes instead* Array of likes for users who have hearted this status. |
#' | liked | logical scalar | True if the status is liked by the authorized user, false if not. |
#' | likes | list | Array of likes for users who have liked this status. |
#' | modified_at | datetime scalar | The time at which this project status was last modified. *Note: This does not currently reflect any changes in associations such as comments that may have been added or removed from the status.* |
#' | num_hearts | integer scalar | *Deprecated - please use likes instead* The number of users who have hearted this status. |
#' | num_likes | integer scalar | The number of users who have liked this status. |
#' | parent | list | The parent of the status update. This can be a project, goal or portfolio, and indicates that this status was sent on that object. |
#'
#' @keywords internal
asn_create_status_for_object <- function(limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/status_updates"),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


