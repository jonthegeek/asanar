#' Get a story
#'
#' Returns the full record for a single story.
#'
#' @param story_gid (character scalar) Globally unique identifier for the story.
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
asn_get_story <- function(story_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/stories/{story_gid}", story_gid = story_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Update a story
#'
#' Updates the story and returns the full record for the updated story. Only comment stories can have their text updated, and only comment stories and attachment stories can be pinned. Only one of `text` and `html_text` can be specified.
#'
#' @param story_gid (character scalar) Globally unique identifier for the story.
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
asn_update_story <- function(story_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/stories/{story_gid}", story_gid = story_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "put",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Delete a story
#'
#' Deletes a story. A user can only delete stories they have created.  Returns an empty data record.
#'
#' @param story_gid (character scalar) Globally unique identifier for the story.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_delete_story <- function(story_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/stories/{story_gid}", story_gid = story_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "delete"
  )
}


