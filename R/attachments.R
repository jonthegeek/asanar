#' Get an attachment
#'
#' Get the full record for a single attachment.
#'
#' @param attachment_gid (character scalar) Globally unique identifier for the attachment.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An *attachment* object represents any file attached to a task in Asana, whether it’s an uploaded file or one associated via a third-party service such as Dropbox or Google Drive.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the file. |
#' | resource_subtype | character scalar | The service hosting the attachment. Valid values are `asana`, `dropbox`, `gdrive`, `onedrive`, `box`, `vimeo`, and `external`. |
#' | connected_to_app | logical scalar | Whether the attachment is connected to the app making the request for the purposes of showing an app components widget. Only present when the `resource_subtype` is `external` or `gdrive`. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | download_url | character scalar | The URL containing the content of the attachment. *Note:* May be null if the attachment is hosted by [Box](https://www.box.com/) and will be null if the attachment is a Video Message hosted by [Vimeo](https://vimeo.com/). If present, this URL may only be valid for two minutes from the time of retrieval. You should avoid persisting this URL somewhere and just refresh it on demand to ensure you do not keep stale URLs. |
#' | host | character scalar | The service hosting the attachment. Valid values are `asana`, `dropbox`, `gdrive`, `box`, and `vimeo`. |
#' | parent | list | The task this attachment is attached to. |
#' | permanent_url | character scalar | NA |
#' | size | integer scalar | The size of the attachment in bytes. Only present when the `resource_subtype` is `asana`. |
#' | view_url | character scalar | The URL where the attachment can be viewed, which may be friendlier to users in a browser than just directing them to a raw file. May be null if no view URL exists for the service. |
#'
#' @keywords internal
asn_get_attachment <- function(attachment_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/attachments/{attachment_gid}", attachment_gid = attachment_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
  # nocov end
}


#' Delete an attachment
#'
#' Deletes a specific, existing attachment.  Returns an empty data record.
#'
#' @param attachment_gid (character scalar) Globally unique identifier for the attachment.
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#'
#' @keywords internal
asn_delete_attachment <- function(attachment_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/attachments/{attachment_gid}", attachment_gid = attachment_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "delete"
  )
  # nocov end
}


#' Get attachments from an object
#'
#' Returns the compact records for all attachments on the object.  There are three possible `parent` values for this request: `project`, `project_brief`, and `task`. For a project, an attachment refers to a file uploaded to the "Key resources" section in the project Overview. For a project brief, an attachment refers to inline files in the project brief itself. For a task, an attachment refers to a file directly associated to that task.  Note that within the Asana app, inline images in the task description do not appear in the index of image thumbnails nor as stories in the task. However, requests made to `GET /attachments` for a task will return all of the images in the task, including inline images.
#'
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param parent (character scalar) Globally unique identifier for object to fetch statuses from. Must be a GID for a `project`, `project_brief`, or `task`.
#'
#' @return An *attachment* object represents any file attached to a task in Asana, whether it’s an uploaded file or one associated via a third-party service such as Dropbox or Google Drive.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the file. |
#' | resource_subtype | character scalar | The service hosting the attachment. Valid values are `asana`, `dropbox`, `gdrive`, `onedrive`, `box`, `vimeo`, and `external`. |
#'
#' @keywords internal
asn_get_attachments_for_object <- function(parent, limit, offset, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/attachments"),
    query = list(parent = parent, limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
  # nocov end
}


#' Upload an attachment
#'
#' Upload an attachment.  This method uploads an attachment on an object and returns the compact record for the created attachment object. This is possible by either:  - Providing the URL of the external resource being attached, or - Downloading the file content first and then uploading it as any other attachment. Note that it is not possible to attach files from third party services such as Dropbox, Box, Vimeo & Google Drive via the API  The 100MB size limit on attachments in Asana is enforced on this endpoint.  This endpoint expects a multipart/form-data encoded request containing the full contents of the file to be uploaded.  Requests made should follow the HTTP/1.1 specification that line terminators are of the form `CRLF` or `\r\n` outlined [here](http://www.w3.org/Protocols/HTTP/1.1/draft-ietf-http-v11-spec-01#Basic-Rules) in order for the server to reliably and properly handle the request.
#'
#' @param opt_fields (optional) (list) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An *attachment* object represents any file attached to a task in Asana, whether it’s an uploaded file or one associated via a third-party service such as Dropbox or Google Drive.
#' | **Property** | **Class** | **Description** |
#' |:-------------|:----------|:----------------|
#' | gid | character scalar | Globally unique identifier of the resource, as a string. |
#' | resource_type | character scalar | The base type of this resource. |
#' | name | character scalar | The name of the file. |
#' | resource_subtype | character scalar | The service hosting the attachment. Valid values are `asana`, `dropbox`, `gdrive`, `onedrive`, `box`, `vimeo`, and `external`. |
#' | connected_to_app | logical scalar | Whether the attachment is connected to the app making the request for the purposes of showing an app components widget. Only present when the `resource_subtype` is `external` or `gdrive`. |
#' | created_at | datetime scalar | The time at which this resource was created. |
#' | download_url | character scalar | The URL containing the content of the attachment. *Note:* May be null if the attachment is hosted by [Box](https://www.box.com/) and will be null if the attachment is a Video Message hosted by [Vimeo](https://vimeo.com/). If present, this URL may only be valid for two minutes from the time of retrieval. You should avoid persisting this URL somewhere and just refresh it on demand to ensure you do not keep stale URLs. |
#' | host | character scalar | The service hosting the attachment. Valid values are `asana`, `dropbox`, `gdrive`, `box`, and `vimeo`. |
#' | parent | list | The task this attachment is attached to. |
#' | permanent_url | character scalar | NA |
#' | size | integer scalar | The size of the attachment in bytes. Only present when the `resource_subtype` is `asana`. |
#' | view_url | character scalar | The URL where the attachment can be viewed, which may be friendlier to users in a browser than just directing them to a raw file. May be null if no view URL exists for the service. |
#'
#' @keywords internal
asn_create_attachment_for_object <- function(opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export. Also enable covr!
  # nocov start
  .call_api(
    endpoint = list("/attachments"),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
  # nocov end
}
