#' Get a portfolio's custom fields
#'
#' Returns a list of all of the custom fields settings on a portfolio, in compact form.
#'
#' @param portfolio_gid (character scalar) Globally unique identifier for the portfolio.
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
asn_get_custom_field_settings_for_portfolio <- function(portfolio_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/portfolios/{portfolio_gid}/custom_field_settings", portfolio_gid = portfolio_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Get memberships from a portfolio
#'
#' Returns the compact portfolio membership records for the portfolio.
#'
#' @param portfolio_gid (character scalar) Globally unique identifier for the portfolio.
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param user (optional) (character scalar) A string identifying a user. This can either be the string "me", an email, or the gid of a user.
#'
#' @return This object determines if a user is a member of a portfolio.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | portfolio | list | [Opt In](/docs/inputoutput-options). The portfolio the user is a member of. |
#' | user | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#'
#' @keywords internal
asn_get_portfolio_memberships_for_portfolio <- function(portfolio_gid, limit, offset, opt_fields, user) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/portfolios/{portfolio_gid}/portfolio_memberships", portfolio_gid = portfolio_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields), user = rlang::maybe_missing(user)),
    method = "get"
  )
}


#' Get multiple portfolios
#'
#' Returns a list of the portfolios in compact representation that are owned by the current API user.
#'
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param owner (optional) (character scalar) The user who owns the portfolio. Currently, API users can only get a list of portfolios that they themselves own.
#' @param workspace (character scalar) The workspace or organization to filter portfolios on.
#'
#' @return A *portfolio* gives a high-level overview of the status of multiple initiatives in Asana. Portfolios provide a dashboard overview of the state of multiple projects, including a progress report and the most recent [project status](/reference/project-statuses) update. Portfolios have some restrictions on size. Each portfolio has a max of 500 items and, like projects, a max of 20 custom fields.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the portfolio. |
#'
#' @keywords internal
asn_get_portfolios <- function(workspace, limit, offset, opt_fields, owner) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/portfolios"),
    query = list(workspace = workspace, limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields), owner = rlang::maybe_missing(owner)),
    method = "get"
  )
}


#' Create a portfolio
#'
#' Creates a new portfolio in the given workspace with the supplied name.  Note that portfolios created in the Asana UI may have some state (like the “Priority” custom field) which is automatically added to the portfolio when it is created. Portfolios created via our API will *not* be created with the same initial state to allow integrations to create their own starting state on a portfolio.
#'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *portfolio* gives a high-level overview of the status of multiple initiatives in Asana. Portfolios provide a dashboard overview of the state of multiple projects, including a progress report and the most recent [project status](/reference/project-statuses) update. Portfolios have some restrictions on size. Each portfolio has a max of 500 items and, like projects, a max of 20 custom fields.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the portfolio. |
#' | color | character scalar | Color of the portfolio. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | created_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | current_status_update | list | The latest `status_update` posted to this portfolio. |
#' | custom_field_settings | list | Array of custom field settings applied to the portfolio. |
#' | custom_fields | list | Array of Custom Fields. |
#' | due_on | datetime scalar | The localized day on which this portfolio is due. This takes a date with format YYYY-MM-DD. |
#' | members | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | owner | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | permalink_url | character scalar | A url that points directly to the object within Asana. |
#' | public | logical scalar | True if the portfolio is public to its workspace members. |
#' | start_on | date scalar | The day on which work for this portfolio begins, or null if the portfolio has no start date. This takes a date with `YYYY-MM-DD` format. *Note: `due_on` must be present in the request when setting or unsetting the `start_on` parameter. Additionally, `start_on` and `due_on` cannot be the same date.* |
#' | workspace | list | *Create-only*. The workspace or organization that the portfolio belongs to. |
#'
#' @keywords internal
asn_create_portfolio <- function(opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/portfolios"),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get a portfolio
#'
#' Returns the complete portfolio record for a single portfolio.
#'
#' @param portfolio_gid (character scalar) Globally unique identifier for the portfolio.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *portfolio* gives a high-level overview of the status of multiple initiatives in Asana. Portfolios provide a dashboard overview of the state of multiple projects, including a progress report and the most recent [project status](/reference/project-statuses) update. Portfolios have some restrictions on size. Each portfolio has a max of 500 items and, like projects, a max of 20 custom fields.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the portfolio. |
#' | color | character scalar | Color of the portfolio. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | created_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | current_status_update | list | The latest `status_update` posted to this portfolio. |
#' | custom_field_settings | list | Array of custom field settings applied to the portfolio. |
#' | custom_fields | list | Array of Custom Fields. |
#' | due_on | datetime scalar | The localized day on which this portfolio is due. This takes a date with format YYYY-MM-DD. |
#' | members | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | owner | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | permalink_url | character scalar | A url that points directly to the object within Asana. |
#' | public | logical scalar | True if the portfolio is public to its workspace members. |
#' | start_on | date scalar | The day on which work for this portfolio begins, or null if the portfolio has no start date. This takes a date with `YYYY-MM-DD` format. *Note: `due_on` must be present in the request when setting or unsetting the `start_on` parameter. Additionally, `start_on` and `due_on` cannot be the same date.* |
#' | workspace | list | *Create-only*. The workspace or organization that the portfolio belongs to. |
#'
#' @keywords internal
asn_get_portfolio <- function(portfolio_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/portfolios/{portfolio_gid}", portfolio_gid = portfolio_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Update a portfolio
#'
#' An existing portfolio can be updated by making a PUT request on the URL for that portfolio. Only the fields provided in the `data` block will be updated; any unspecified fields will remain unchanged.  Returns the complete updated portfolio record.
#'
#' @param portfolio_gid (character scalar) Globally unique identifier for the portfolio.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *portfolio* gives a high-level overview of the status of multiple initiatives in Asana. Portfolios provide a dashboard overview of the state of multiple projects, including a progress report and the most recent [project status](/reference/project-statuses) update. Portfolios have some restrictions on size. Each portfolio has a max of 500 items and, like projects, a max of 20 custom fields.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the portfolio. |
#' | color | character scalar | Color of the portfolio. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | created_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | current_status_update | list | The latest `status_update` posted to this portfolio. |
#' | custom_field_settings | list | Array of custom field settings applied to the portfolio. |
#' | custom_fields | list | Array of Custom Fields. |
#' | due_on | datetime scalar | The localized day on which this portfolio is due. This takes a date with format YYYY-MM-DD. |
#' | members | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | owner | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | permalink_url | character scalar | A url that points directly to the object within Asana. |
#' | public | logical scalar | True if the portfolio is public to its workspace members. |
#' | start_on | date scalar | The day on which work for this portfolio begins, or null if the portfolio has no start date. This takes a date with `YYYY-MM-DD` format. *Note: `due_on` must be present in the request when setting or unsetting the `start_on` parameter. Additionally, `start_on` and `due_on` cannot be the same date.* |
#' | workspace | list | *Create-only*. The workspace or organization that the portfolio belongs to. |
#'
#' @keywords internal
asn_update_portfolio <- function(portfolio_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/portfolios/{portfolio_gid}", portfolio_gid = portfolio_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "put",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Delete a portfolio
#'
#' An existing portfolio can be deleted by making a DELETE request on the URL for that portfolio.  Returns an empty data record.
#'
#' @param portfolio_gid (character scalar) Globally unique identifier for the portfolio.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_delete_portfolio <- function(portfolio_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/portfolios/{portfolio_gid}", portfolio_gid = portfolio_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "delete"
  )
}


#' Get portfolio items
#'
#' Get a list of the items in compact form in a portfolio.
#'
#' @param portfolio_gid (character scalar) Globally unique identifier for the portfolio.
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
asn_get_items_for_portfolio <- function(portfolio_gid, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/portfolios/{portfolio_gid}/items", portfolio_gid = portfolio_gid),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Add a portfolio item
#'
#' Add an item to a portfolio. Returns an empty data block.
#'
#' @param portfolio_gid (character scalar) Globally unique identifier for the portfolio.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_add_item_for_portfolio <- function(portfolio_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/portfolios/{portfolio_gid}/addItem", portfolio_gid = portfolio_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Remove a portfolio item
#'
#' Remove an item from a portfolio. Returns an empty data block.
#'
#' @param portfolio_gid (character scalar) Globally unique identifier for the portfolio.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_remove_item_for_portfolio <- function(portfolio_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/portfolios/{portfolio_gid}/removeItem", portfolio_gid = portfolio_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Add a custom field to a portfolio
#'
#' Custom fields are associated with portfolios by way of custom field settings.  This method creates a setting for the portfolio.
#'
#' @param portfolio_gid (character scalar) Globally unique identifier for the portfolio.
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
asn_add_custom_field_setting_for_portfolio <- function(portfolio_gid) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/portfolios/{portfolio_gid}/addCustomFieldSetting", portfolio_gid = portfolio_gid),
    query = list(),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Remove a custom field from a portfolio
#'
#' Removes a custom field setting from a portfolio.
#'
#' @param portfolio_gid (character scalar) Globally unique identifier for the portfolio.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_remove_custom_field_setting_for_portfolio <- function(portfolio_gid) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/portfolios/{portfolio_gid}/removeCustomFieldSetting", portfolio_gid = portfolio_gid),
    query = list(),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Add users to a portfolio
#'
#' Adds the specified list of users as members of the portfolio. Returns the updated portfolio record.
#'
#' @param portfolio_gid (character scalar) Globally unique identifier for the portfolio.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *portfolio* gives a high-level overview of the status of multiple initiatives in Asana. Portfolios provide a dashboard overview of the state of multiple projects, including a progress report and the most recent [project status](/reference/project-statuses) update. Portfolios have some restrictions on size. Each portfolio has a max of 500 items and, like projects, a max of 20 custom fields.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the portfolio. |
#' | color | character scalar | Color of the portfolio. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | created_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | current_status_update | list | The latest `status_update` posted to this portfolio. |
#' | custom_field_settings | list | Array of custom field settings applied to the portfolio. |
#' | custom_fields | list | Array of Custom Fields. |
#' | due_on | datetime scalar | The localized day on which this portfolio is due. This takes a date with format YYYY-MM-DD. |
#' | members | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | owner | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | permalink_url | character scalar | A url that points directly to the object within Asana. |
#' | public | logical scalar | True if the portfolio is public to its workspace members. |
#' | start_on | date scalar | The day on which work for this portfolio begins, or null if the portfolio has no start date. This takes a date with `YYYY-MM-DD` format. *Note: `due_on` must be present in the request when setting or unsetting the `start_on` parameter. Additionally, `start_on` and `due_on` cannot be the same date.* |
#' | workspace | list | *Create-only*. The workspace or organization that the portfolio belongs to. |
#'
#' @keywords internal
asn_add_members_for_portfolio <- function(portfolio_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/portfolios/{portfolio_gid}/addMembers", portfolio_gid = portfolio_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Remove users from a portfolio
#'
#' Removes the specified list of users from members of the portfolio. Returns the updated portfolio record.
#'
#' @param portfolio_gid (character scalar) Globally unique identifier for the portfolio.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *portfolio* gives a high-level overview of the status of multiple initiatives in Asana. Portfolios provide a dashboard overview of the state of multiple projects, including a progress report and the most recent [project status](/reference/project-statuses) update. Portfolios have some restrictions on size. Each portfolio has a max of 500 items and, like projects, a max of 20 custom fields.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the portfolio. |
#' | color | character scalar | Color of the portfolio. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | created_by | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | current_status_update | list | The latest `status_update` posted to this portfolio. |
#' | custom_field_settings | list | Array of custom field settings applied to the portfolio. |
#' | custom_fields | list | Array of Custom Fields. |
#' | due_on | datetime scalar | The localized day on which this portfolio is due. This takes a date with format YYYY-MM-DD. |
#' | members | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | owner | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | permalink_url | character scalar | A url that points directly to the object within Asana. |
#' | public | logical scalar | True if the portfolio is public to its workspace members. |
#' | start_on | date scalar | The day on which work for this portfolio begins, or null if the portfolio has no start date. This takes a date with `YYYY-MM-DD` format. *Note: `due_on` must be present in the request when setting or unsetting the `start_on` parameter. Additionally, `start_on` and `due_on` cannot be the same date.* |
#' | workspace | list | *Create-only*. The workspace or organization that the portfolio belongs to. |
#'
#' @keywords internal
asn_remove_members_for_portfolio <- function(portfolio_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/portfolios/{portfolio_gid}/removeMembers", portfolio_gid = portfolio_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


