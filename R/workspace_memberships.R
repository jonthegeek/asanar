#' Get a workspace membership
#'
#' Returns the complete workspace record for a single workspace membership.
#'
#' @param workspace_membership_gid (character scalar) NA
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return This object determines if a user is a member of a workspace.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | user | list | A *user* object represents an account in Asana that can be given access to various workspaces, projects, and tasks. |
#' | workspace | list | A *workspace* is the highest-level organizational unit in Asana. All projects and tasks have an associated workspace. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | is_active | logical scalar | Reflects if this user still a member of the workspace. |
#' | is_admin | logical scalar | Reflects if this user is an admin of the workspace. |
#' | is_guest | logical scalar | Reflects if this user is a guest of the workspace. |
#' | user_task_list | list | The user's "My Tasks" in the workspace. |
#' | vacation_dates | list | Contains keys `start_on` and `end_on` for the vacation dates for the user in this workspace. If `start_on` is null, the entire `vacation_dates` object will be null. If `end_on` is before today, the entire `vacation_dates` object will be null. |
#'
#' @keywords internal
asn_get_workspace_membership <- function(workspace_membership_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/workspace_memberships/{workspace_membership_gid}", workspace_membership_gid = workspace_membership_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
  # nocov end
}
