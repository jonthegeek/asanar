#' Get a project template
#'
#' Returns the complete project template record for a single project template.
#'
#' @param project_template_gid (character scalar) Globally unique identifier for the project template.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A *project template* is an object that allows new projects to be created with a predefined setup, which may include tasks, sections, Rules, etc. It simplifies the process of running a workflow that involves a similar set of work every time.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | Name of the project template. |
#' | color | character scalar | Color of the project template. |
#' | description | character scalar | Free-form textual information associated with the project template |
#' | html_description | character scalar | The description of the project template with formatting as HTML. |
#' | owner | list | The current owner of the project template, may be null. |
#' | public | logical scalar | True if the project template is public to its team. |
#' | requested_dates | list | Array of date variables in this project template. Calendar dates must be provided for these variables when instantiating a project. |
#' | requested_roles | list | Array of template roles in this project template. User Ids can be provided for these variables when instantiating a project to assign template tasks to the user. |
#' | team | list | A *team* is used to group related projects and people together within an organization. Each project in an organization is associated with a team. |
#'
#' @keywords internal
asn_get_project_template <- function(project_template_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/project_templates/{project_template_gid}", project_template_gid = project_template_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
  # nocov end
}


#' Get multiple project templates
#'
#' Returns the compact project template records for all project templates in the given team or workspace.
#'
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param team (optional) (character scalar) The team to filter projects on.
#' @param workspace (optional) (character scalar) The workspace to filter results on.
#'
#' @return A *project template* is an object that allows new projects to be created with a predefined setup, which may include tasks, sections, Rules, etc. It simplifies the process of running a workflow that involves a similar set of work every time.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | Name of the project template. |
#'
#' @keywords internal
asn_get_project_templates <- function(limit, offset, opt_fields, team, workspace) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/project_templates"),
    query = list(limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields), team = rlang::maybe_missing(team), workspace = rlang::maybe_missing(workspace)),
    method = "get"
  )
  # nocov end
}


#' Instantiate a project from a project template
#'
#' Creates and returns a job that will asynchronously handle the project instantiation.  To form this request, it is recommended to first make a request to [get a project template](https://developers.asana.com/reference/getprojecttemplate). Then, from the response, copy the `gid` from the object in the `requested_dates` array. This `gid` should be used in `requested_dates` to instantiate a project.  _Note: The body of this request will differ if your workspace is an organization. To determine if your workspace is an organization, use the [is_organization](https://developers.asana.com/reference/workspaces) parameter._
#'
#' @param project_template_gid (character scalar) Globally unique identifier for the project template.
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
asn_instantiate_project <- function(project_template_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/project_templates/{project_template_gid}/instantiateProject", project_template_gid = project_template_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
  # nocov end
}
