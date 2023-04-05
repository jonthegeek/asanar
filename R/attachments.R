#' Get an attachment
#'
#' Get the full record for a single attachment.
#'
#' @param attachment_gid (character scalar) Globally unique identifier for the
#'   attachment.
#' @param opt_fields (optional) (character vector) Defines fields to return.
#'   Some requests return *compact* representations of objects in order to
#'   conserve resources and complete the request more efficiently. Other times
#'   requests return more information than you may need. This option allows you
#'   to list the exact set of fields that the API should be sure to return for
#'   the objects. The field names should be provided as paths, described below.
#'   The id of included objects will always be returned, regardless of the field
#'   options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_attachment <- function(attachment_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list(
      "/attachments/{attachment_gid}",
      attachment_gid = attachment_gid
    ),
    query = list(opt_fields = opt_fields),
    method = "get"
  )
}


#' Delete an attachment
#'
#' Deletes a specific, existing attachment.  Returns an empty data record.
#'
#' @param attachment_gid (character scalar) Globally unique identifier for the
#'   attachment.
#' @param opt_fields (optional) (character vector) Defines fields to return.
#'   Some requests return *compact* representations of objects in order to
#'   conserve resources and complete the request more efficiently. Other times
#'   requests return more information than you may need. This option allows you
#'   to list the exact set of fields that the API should be sure to return for
#'   the objects. The field names should be provided as paths, described below.
#'   The id of included objects will always be returned, regardless of the field
#'   options.
#'
#' @return An empty object. Some endpoints do not return an object on success.
#'   The success is conveyed through a 2-- status code and returning an empty
#'   object.
#'
#' @keywords internal
asn_delete_attachment <- function(attachment_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list(
      "/attachments/{attachment_gid}",
      attachment_gid = attachment_gid
    ),
    query = list(opt_fields = opt_fields),
    method = "delete"
  )
}


#' Get attachments from an object
#'
#' Returns the compact records for all attachments on the object.  There are
#' three possible `parent` values for this request: `project`, `project_brief`,
#' and `task`. For a project, an attachment refers to a file uploaded to the
#' "Key resources" section in the project Overview. For a project brief, an
#' attachment refers to inline files in the project brief itself. For a task, an
#' attachment refers to a file directly associated to that task.  Note that
#' within the Asana app, inline images in the task description do not appear in
#' the index of image thumbnails nor as stories in the task. However, requests
#' made to `GET /attachments` for a task will return all of the images in the
#' task, including inline images.
#'
#' @param limit (optional) (integer scalar) Results per page. The number of
#'   objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the
#'   next page returned by the API. A pagination request will return an offset
#'   token, which can be used as an input parameter to the next request. If an
#'   offset is not passed in, the API will return the first page of results.
#'   'Note: You can only pass in an offset that was returned to you via a
#'   previously paginated request.'
#' @param opt_fields (optional) (character vector) Defines fields to return.
#'   Some requests return *compact* representations of objects in order to
#'   conserve resources and complete the request more efficiently. Other times
#'   requests return more information than you may need. This option allows you
#'   to list the exact set of fields that the API should be sure to return for
#'   the objects. The field names should be provided as paths, described below.
#'   The id of included objects will always be returned, regardless of the field
#'   options.
#' @param parent (character scalar) Globally unique identifier for object to
#'   fetch statuses from. Must be a GID for a `project`, `project_brief`, or
#'   `task`.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_attachments_for_object <- function(parent, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/attachments"),
    query = list(
      limit = limit,
      offset = offset,
      opt_fields = opt_fields,
      parent = parent
    ),
    method = "get"
  )
}


#' Upload an attachment
#'
#' Upload an attachment.  This method uploads an attachment on an object and
#' returns the compact record for the created attachment object. This is
#' possible by either:  - Providing the URL of the external resource being
#' attached, or - Downloading the file content first and then uploading it as
#' any other attachment. Note that it is not possible to attach files from third
#' party services such as Dropbox, Box, Vimeo & Google Drive via the API  The
#' 100MB size limit on attachments in Asana is enforced on this endpoint.  This
#' endpoint expects a multipart/form-data encoded request containing the full
#' contents of the file to be uploaded.  Requests made should follow the
#' HTTP/1.1 specification that line terminators are of the form `CRLF` or `\r\n`
#' outlined
#' [here](http://www.w3.org/Protocols/HTTP/1.1/draft-ietf-http-v11-spec-01#Basic-Rules)
#' in order for the server to reliably and properly handle the request.
#'
#' @param opt_fields (optional) (character vector) Defines fields to return.
#'   Some requests return *compact* representations of objects in order to
#'   conserve resources and complete the request more efficiently. Other times
#'   requests return more information than you may need. This option allows you
#'   to list the exact set of fields that the API should be sure to return for
#'   the objects. The field names should be provided as paths, described below.
#'   The id of included objects will always be returned, regardless of the field
#'   options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_create_attachment_for_object <- function(opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/attachments"),
    query = list(opt_fields = opt_fields),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}
