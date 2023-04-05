#' Get multiple webhooks
#'
#' Get the compact representation of all webhooks your app has registered for the authenticated user in the given workspace.
#'
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param resource (optional) (character scalar) Only return webhooks for the given resource.
#' @param workspace (character scalar) The workspace to query for webhooks in.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_webhooks <- function(workspace, limit, offset, opt_fields, resource) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/webhooks"),
    query = list(workspace = workspace, limit = rlang::maybe_missing(limit), offset = rlang::maybe_missing(offset), opt_fields = rlang::maybe_missing(opt_fields), resource = rlang::maybe_missing(resource)),
    method = "get"
  )
}


#' Establish a webhook
#'
#' Establishing a webhook is a two-part process. First, a simple HTTP POST request initiates the creation similar to creating any other resource.  Next, in the middle of this request comes the confirmation handshake. When a webhook is created, we will send a test POST to the target with an `X-Hook-Secret` header. The target must respond with a `200 OK` or `204 No Content` and a matching `X-Hook-Secret` header to confirm that this webhook subscription is indeed expected. We strongly recommend storing this secret to be used to verify future webhook event signatures.  The POST request to create the webhook will then return with the status of the request. If you do not acknowledge the webhook’s confirmation handshake it will fail to setup, and you will receive an error in response to your attempt to create it. This means you need to be able to receive and complete the webhook *while* the POST request is in-flight (in other words, have a server that can handle requests asynchronously).  Invalid hostnames like localhost will recieve a 403 Forbidden status code.  ``` # Request curl -H "Authorization: Bearer <personal_access_token>" \ -X POST https://app.asana.com/api/1.0/webhooks \ -d "resource=8675309" \ -d "target=https://example.com/receive-webhook/7654" ```  ``` # Handshake sent to https://example.com/ POST /receive-webhook/7654 X-Hook-Secret: b537207f20cbfa02357cf448134da559e8bd39d61597dcd5631b8012eae53e81 ```  ``` # Handshake response sent by example.com HTTP/1.1 200 X-Hook-Secret: b537207f20cbfa02357cf448134da559e8bd39d61597dcd5631b8012eae53e81 ```  ``` # Response HTTP/1.1 201 {   "data": {     "gid": "43214",     "resource": {       "gid": "8675309",       "name": "Bugs"     },     "target": "https://example.com/receive-webhook/7654",     "active": false,     "last_success_at": null,     "last_failure_at": null,     "last_failure_content": null   } } ```
#'
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_create_webhook <- function(opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/webhooks"),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "post",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Get a webhook
#'
#' Returns the full record for the given webhook.
#'
#' @param webhook_gid (character scalar) Globally unique identifier for the webhook.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_webhook <- function(webhook_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/webhooks/{webhook_gid}", webhook_gid = webhook_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "get"
  )
}


#' Update a webhook
#'
#' An existing webhook's filters can be updated by making a PUT request on the URL for that webhook. Note that the webhook's previous `filters` array will be completely overwritten by the `filters` sent in the PUT request.
#'
#' @param webhook_gid (character scalar) Globally unique identifier for the webhook.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_update_webhook <- function(webhook_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/webhooks/{webhook_gid}", webhook_gid = webhook_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "put",
    body = stop("We do not properly build this yet. Edit by hand.")
  )
}


#' Delete a webhook
#'
#' This method *permanently* removes a webhook. Note that it may be possible to receive a request that was already in flight after deleting the webhook, but no further requests will be issued.
#'
#' @param webhook_gid (character scalar) Globally unique identifier for the webhook.
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return An empty object. Some endpoints do not return an object on success. The success is conveyed through a 2-- status code and returning an empty object.
#'
#' @keywords internal
asn_delete_webhook <- function(webhook_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/webhooks/{webhook_gid}", webhook_gid = webhook_gid),
    query = list(opt_fields = rlang::maybe_missing(opt_fields)),
    method = "delete"
  )
}
