#' Update an enum option
#'
#' Updates an existing enum option. Enum custom fields require at least one enabled enum option. Locked custom fields can only be updated by the user who locked the field. Returns the full record of the updated enum option.
#'
#' @param enum_option_gid (character scalar) Globally unique identifier for the enum option.
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
asn_update_enum_option <- function(enum_option_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/enum_options/{enum_option_gid}", enum_option_gid = enum_option_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "put",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


