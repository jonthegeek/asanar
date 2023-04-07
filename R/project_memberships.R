#' Get a project membership
#'
#' Returns the complete project record for a single project membership.
#'
#' @param project_membership_gid (character scalar) NA
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return With the introduction of “comment-only” projects in Asana, a user’s membership in a project comes with associated permissions. These permissions (whether a user has full access to the project or comment-only access) are accessible through the project memberships endpoints described here.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | user | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | member | list | Member can be a user or a team. |
#' | project | list | [Opt In](https://developers.asana.com/docs/inputoutput-options). The project the user is a member of. |
#' | write_access | character scalar | Whether the member has full access, edit access, or comment-only access to the project. |
#'
#' @keywords internal
asn_get_project_membership <- function(project_membership_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/project_memberships/{project_membership_gid}", project_membership_gid = project_membership_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


