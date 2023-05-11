#' Create a custom field
#'
#' Creates a new custom field in a workspace. Every custom field is required to be created in a specific workspace, and this workspace cannot be changed once set.  A custom field’s name must be unique within a workspace and not conflict with names of existing task properties such as `Due Date` or `Assignee`. A custom field’s type must be one of `text`, `enum`, `multi_enum`, `number`, `date`, or `people`.  Returns the full record of the newly created custom field.
#'
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return Custom Fields store the metadata that is used in order to add user-specified information to tasks in Asana. Be sure to reference the [custom fields](https://developers.asana.com/reference/custom-fields) developer documentation for more information about how custom fields relate to various resources in Asana.  Users in Asana can [lock custom fields](https://asana.com/guide/help/premium/custom-fields#gl-lock-fields), which will make them read-only when accessed by other users. Attempting to edit a locked custom field will return HTTP error code `403 Forbidden`.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | date_value | list | *Conditional*. Only relevant for custom fields of type `date`. This object reflects the chosen date (and optionally, time) value of a `date` custom field. If no date is selected, the value of `date_value` will be `null`. |
#' | display_value | character scalar | A string representation for the value of the custom field. Integrations that don't require the underlying type should use this field to read values. Using this field will future-proof an app against new custom field types. |
#' | enabled | logical scalar | *Conditional*. Determines if the custom field is enabled or not. |
#' | enum_options | list | *Conditional*. Only relevant for custom fields of type `enum`. This array specifies the possible values which an `enum` custom field can adopt. To modify the enum options, refer to [working with enum options](https://developers.asana.com/reference/createenumoptionforcustomfield). |
#' | enum_value | list | *Conditional*. Only relevant for custom fields of type `enum`. This object is the chosen value of an `enum` custom field. |
#' | multi_enum_values | list | *Conditional*. Only relevant for custom fields of type `multi_enum`. This object is the chosen values of a `multi_enum` custom field. |
#' | name | character scalar | The name of the custom field. |
#' | number_value | number | *Conditional*. This number is the value of a `number` custom field. |
#' | resource_subtype | character scalar | The type of the custom field. Must be one of the given values.  |
#' | text_value | character scalar | *Conditional*. This string is the value of a `text` custom field. |
#' | type | character scalar | *Deprecated: new integrations should prefer the resource_subtype field.* The type of the custom field. Must be one of the given values.  |
#' | asana_created_field | character scalar | *Conditional*. A unique identifier to associate this field with the template source of truth. |
#' | currency_code | character scalar | ISO 4217 currency code to format this custom field. This will be null if the `format` is not `currency`. |
#' | custom_label | character scalar | This is the string that appears next to the custom field value. This will be null if the `format` is not `custom`. |
#' | custom_label_position | character scalar | Only relevant for custom fields with `custom` format. This depicts where to place the custom label. This will be null if the `format` is not `custom`. |
#' | description | character scalar | [Opt In](https://developers.asana.com/docs/inputoutput-options). The description of the custom field. |
#' | format | character scalar | The format of this custom field. |
#' | has_notifications_enabled | logical scalar | *Conditional*. This flag describes whether a follower of a task with this field should receive inbox notifications from changes to this field. |
#' | is_global_to_workspace | logical scalar | This flag describes whether this custom field is available to every container in the workspace. Before project-specific custom fields, this field was always true. |
#' | precision | integer scalar | Only relevant for custom fields of type ‘Number’. This field dictates the number of places after the decimal to round to, i.e. 0 is integer values, 1 rounds to the nearest tenth, and so on. Must be between 0 and 6, inclusive. For percentage format, this may be unintuitive, as a value of 0.25 has a precision of 0, while a value of 0.251 has a precision of 1. This is due to 0.25 being displayed as 25%. The identifier format will always have a precision of 0. |
#' | created_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | people_value | list | *Conditional*. Only relevant for custom fields of type `people`. This array of [compact user](https://developers.asana.com/reference/users) objects reflects the values of a `people` custom field. |
#'
#' @keywords internal
asn_create_custom_field <- function(limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/custom_fields"),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
  # nocov end
}


#' Get a custom field
#'
#' Get the complete definition of a custom field’s metadata.  Since custom fields can be defined for one of a number of types, and these types have different data and behaviors, there are fields that are relevant to a particular type. For instance, as noted above, enum_options is only relevant for the enum type and defines the set of choices that the enum could represent. The examples below show some of these type-specific custom field definitions.
#'
#' @param custom_field_gid (character scalar) Globally unique identifier for the custom field.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return Custom Fields store the metadata that is used in order to add user-specified information to tasks in Asana. Be sure to reference the [custom fields](https://developers.asana.com/reference/custom-fields) developer documentation for more information about how custom fields relate to various resources in Asana.  Users in Asana can [lock custom fields](https://asana.com/guide/help/premium/custom-fields#gl-lock-fields), which will make them read-only when accessed by other users. Attempting to edit a locked custom field will return HTTP error code `403 Forbidden`.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | date_value | list | *Conditional*. Only relevant for custom fields of type `date`. This object reflects the chosen date (and optionally, time) value of a `date` custom field. If no date is selected, the value of `date_value` will be `null`. |
#' | display_value | character scalar | A string representation for the value of the custom field. Integrations that don't require the underlying type should use this field to read values. Using this field will future-proof an app against new custom field types. |
#' | enabled | logical scalar | *Conditional*. Determines if the custom field is enabled or not. |
#' | enum_options | list | *Conditional*. Only relevant for custom fields of type `enum`. This array specifies the possible values which an `enum` custom field can adopt. To modify the enum options, refer to [working with enum options](https://developers.asana.com/reference/createenumoptionforcustomfield). |
#' | enum_value | list | *Conditional*. Only relevant for custom fields of type `enum`. This object is the chosen value of an `enum` custom field. |
#' | multi_enum_values | list | *Conditional*. Only relevant for custom fields of type `multi_enum`. This object is the chosen values of a `multi_enum` custom field. |
#' | name | character scalar | The name of the custom field. |
#' | number_value | number | *Conditional*. This number is the value of a `number` custom field. |
#' | resource_subtype | character scalar | The type of the custom field. Must be one of the given values.  |
#' | text_value | character scalar | *Conditional*. This string is the value of a `text` custom field. |
#' | type | character scalar | *Deprecated: new integrations should prefer the resource_subtype field.* The type of the custom field. Must be one of the given values.  |
#' | asana_created_field | character scalar | *Conditional*. A unique identifier to associate this field with the template source of truth. |
#' | currency_code | character scalar | ISO 4217 currency code to format this custom field. This will be null if the `format` is not `currency`. |
#' | custom_label | character scalar | This is the string that appears next to the custom field value. This will be null if the `format` is not `custom`. |
#' | custom_label_position | character scalar | Only relevant for custom fields with `custom` format. This depicts where to place the custom label. This will be null if the `format` is not `custom`. |
#' | description | character scalar | [Opt In](https://developers.asana.com/docs/inputoutput-options). The description of the custom field. |
#' | format | character scalar | The format of this custom field. |
#' | has_notifications_enabled | logical scalar | *Conditional*. This flag describes whether a follower of a task with this field should receive inbox notifications from changes to this field. |
#' | is_global_to_workspace | logical scalar | This flag describes whether this custom field is available to every container in the workspace. Before project-specific custom fields, this field was always true. |
#' | precision | integer scalar | Only relevant for custom fields of type ‘Number’. This field dictates the number of places after the decimal to round to, i.e. 0 is integer values, 1 rounds to the nearest tenth, and so on. Must be between 0 and 6, inclusive. For percentage format, this may be unintuitive, as a value of 0.25 has a precision of 0, while a value of 0.251 has a precision of 1. This is due to 0.25 being displayed as 25%. The identifier format will always have a precision of 0. |
#' | created_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | people_value | list | *Conditional*. Only relevant for custom fields of type `people`. This array of [compact user](https://developers.asana.com/reference/users) objects reflects the values of a `people` custom field. |
#'
#' @keywords internal
asn_get_custom_field <- function(custom_field_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/custom_fields/{custom_field_gid}", custom_field_gid = custom_field_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
  # nocov end
}


#' Update a custom field
#'
#' A specific, existing custom field can be updated by making a PUT request on the URL for that custom field. Only the fields provided in the `data` block will be updated; any unspecified fields will remain unchanged When using this method, it is best to specify only those fields you wish to change, or else you may overwrite changes made by another user since you last retrieved the custom field. A custom field’s `type` cannot be updated. An enum custom field’s `enum_options` cannot be updated with this endpoint. Instead see “Work With Enum Options” for information on how to update `enum_options`. Locked custom fields can only be updated by the user who locked the field. Returns the complete updated custom field record.
#'
#' @param custom_field_gid (character scalar) Globally unique identifier for the custom field.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return Custom Fields store the metadata that is used in order to add user-specified information to tasks in Asana. Be sure to reference the [custom fields](https://developers.asana.com/reference/custom-fields) developer documentation for more information about how custom fields relate to various resources in Asana.  Users in Asana can [lock custom fields](https://asana.com/guide/help/premium/custom-fields#gl-lock-fields), which will make them read-only when accessed by other users. Attempting to edit a locked custom field will return HTTP error code `403 Forbidden`.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | date_value | list | *Conditional*. Only relevant for custom fields of type `date`. This object reflects the chosen date (and optionally, time) value of a `date` custom field. If no date is selected, the value of `date_value` will be `null`. |
#' | display_value | character scalar | A string representation for the value of the custom field. Integrations that don't require the underlying type should use this field to read values. Using this field will future-proof an app against new custom field types. |
#' | enabled | logical scalar | *Conditional*. Determines if the custom field is enabled or not. |
#' | enum_options | list | *Conditional*. Only relevant for custom fields of type `enum`. This array specifies the possible values which an `enum` custom field can adopt. To modify the enum options, refer to [working with enum options](https://developers.asana.com/reference/createenumoptionforcustomfield). |
#' | enum_value | list | *Conditional*. Only relevant for custom fields of type `enum`. This object is the chosen value of an `enum` custom field. |
#' | multi_enum_values | list | *Conditional*. Only relevant for custom fields of type `multi_enum`. This object is the chosen values of a `multi_enum` custom field. |
#' | name | character scalar | The name of the custom field. |
#' | number_value | number | *Conditional*. This number is the value of a `number` custom field. |
#' | resource_subtype | character scalar | The type of the custom field. Must be one of the given values.  |
#' | text_value | character scalar | *Conditional*. This string is the value of a `text` custom field. |
#' | type | character scalar | *Deprecated: new integrations should prefer the resource_subtype field.* The type of the custom field. Must be one of the given values.  |
#' | asana_created_field | character scalar | *Conditional*. A unique identifier to associate this field with the template source of truth. |
#' | currency_code | character scalar | ISO 4217 currency code to format this custom field. This will be null if the `format` is not `currency`. |
#' | custom_label | character scalar | This is the string that appears next to the custom field value. This will be null if the `format` is not `custom`. |
#' | custom_label_position | character scalar | Only relevant for custom fields with `custom` format. This depicts where to place the custom label. This will be null if the `format` is not `custom`. |
#' | description | character scalar | [Opt In](https://developers.asana.com/docs/inputoutput-options). The description of the custom field. |
#' | format | character scalar | The format of this custom field. |
#' | has_notifications_enabled | logical scalar | *Conditional*. This flag describes whether a follower of a task with this field should receive inbox notifications from changes to this field. |
#' | is_global_to_workspace | logical scalar | This flag describes whether this custom field is available to every container in the workspace. Before project-specific custom fields, this field was always true. |
#' | precision | integer scalar | Only relevant for custom fields of type ‘Number’. This field dictates the number of places after the decimal to round to, i.e. 0 is integer values, 1 rounds to the nearest tenth, and so on. Must be between 0 and 6, inclusive. For percentage format, this may be unintuitive, as a value of 0.25 has a precision of 0, while a value of 0.251 has a precision of 1. This is due to 0.25 being displayed as 25%. The identifier format will always have a precision of 0. |
#' | created_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | people_value | list | *Conditional*. Only relevant for custom fields of type `people`. This array of [compact user](https://developers.asana.com/reference/users) objects reflects the values of a `people` custom field. |
#'
#' @keywords internal
asn_update_custom_field <- function(custom_field_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/custom_fields/{custom_field_gid}", custom_field_gid = custom_field_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "put",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
  # nocov end
}


#' Delete a custom field
#'
#' A specific, existing custom field can be deleted by making a DELETE request on the URL for that custom field. Locked custom fields can only be deleted by the user who locked the field. Returns an empty data record.
#'
#' @param custom_field_gid (character scalar) Globally unique identifier for the custom field.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_delete_custom_field <- function(custom_field_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/custom_fields/{custom_field_gid}", custom_field_gid = custom_field_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "delete"
  )
  # nocov end
}


#' Create an enum option
#'
#' Creates an enum option and adds it to this custom field’s list of enum options. A custom field can have at most 500 enum options (including disabled options). By default new enum options are inserted at the end of a custom field’s list. Locked custom fields can only have enum options added by the user who locked the field. Returns the full record of the newly created enum option.
#'
#' @param custom_field_gid (character scalar) Globally unique identifier for the custom field.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return Enum options are the possible values which an enum custom field can adopt. An enum custom field must contain at least 1 enum option but no more than 500.  You can add enum options to a custom field by using the `POST /custom_fields/custom_field_gid/enum_options` endpoint.  **It is not possible to remove or delete an enum option**. Instead, enum options can be disabled by updating the `enabled` field to false with the `PUT /enum_options/enum_option_gid` endpoint. Other attributes can be updated similarly.  On creation of an enum option, `enabled` is always set to `true`, meaning the enum option is a selectable value for the custom field. Setting `enabled=false` is equivalent to “trashing” the enum option in the Asana web app within the “Edit Fields” dialog. The enum option will no longer be selectable but, if the enum option value was previously set within a task, the task will retain the value.  Enum options are an ordered list and by default new enum options are inserted at the end. Ordering in relation to existing enum options can be specified on creation by using `insert_before` or `insert_after` to reference an existing enum option. Only one of `insert_before` and `insert_after` can be provided when creating a new enum option.  An enum options list can be reordered with the `POST /custom_fields/custom_field_gid/enum_options/insert` endpoint.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | color | character scalar | The color of the enum option. Defaults to ‘none’. |
#' | enabled | logical scalar | Whether or not the enum option is a selectable value for the custom field. |
#' | name | character scalar | The name of the enum option. |
#'
#' @keywords internal
asn_create_enum_option_for_custom_field <- function(custom_field_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/custom_fields/{custom_field_gid}/enum_options", custom_field_gid = custom_field_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
  # nocov end
}


#' Reorder a custom field's enum
#'
#' Moves a particular enum option to be either before or after another specified enum option in the custom field. Locked custom fields can only be reordered by the user who locked the field.
#'
#' @param custom_field_gid (character scalar) Globally unique identifier for the custom field.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return Enum options are the possible values which an enum custom field can adopt. An enum custom field must contain at least 1 enum option but no more than 500.  You can add enum options to a custom field by using the `POST /custom_fields/custom_field_gid/enum_options` endpoint.  **It is not possible to remove or delete an enum option**. Instead, enum options can be disabled by updating the `enabled` field to false with the `PUT /enum_options/enum_option_gid` endpoint. Other attributes can be updated similarly.  On creation of an enum option, `enabled` is always set to `true`, meaning the enum option is a selectable value for the custom field. Setting `enabled=false` is equivalent to “trashing” the enum option in the Asana web app within the “Edit Fields” dialog. The enum option will no longer be selectable but, if the enum option value was previously set within a task, the task will retain the value.  Enum options are an ordered list and by default new enum options are inserted at the end. Ordering in relation to existing enum options can be specified on creation by using `insert_before` or `insert_after` to reference an existing enum option. Only one of `insert_before` and `insert_after` can be provided when creating a new enum option.  An enum options list can be reordered with the `POST /custom_fields/custom_field_gid/enum_options/insert` endpoint.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | color | character scalar | The color of the enum option. Defaults to ‘none’. |
#' | enabled | logical scalar | Whether or not the enum option is a selectable value for the custom field. |
#' | name | character scalar | The name of the enum option. |
#'
#' @keywords internal
asn_insert_enum_option_for_custom_field <- function(custom_field_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/custom_fields/{custom_field_gid}/enum_options/insert", custom_field_gid = custom_field_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
  # nocov end
}
