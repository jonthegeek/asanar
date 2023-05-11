#' Get a job by id
#'
#' Returns the full record for a job.
#'
#' @param job_gid (character scalar) Globally unique identifier for the job.
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
asn_get_job <- function(job_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/jobs/{job_gid}", job_gid = job_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
  # nocov end
}
