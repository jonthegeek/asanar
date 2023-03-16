#' Call the Asana API
#'
#' This is unexported because I intend to use it from endpoint-specific
#' functions.
#'
#' @param endpoint The path to an endpoint. Optionally, a list with the path
#'   plus variables to [glue::glue()] into the path.
#' @param query An optional list of parameters to pass in the query portion of
#'   the request.
#' @param body An optional list of parameters to pass in the body portion of the
#'   request. Should have additional class "json" or "multipart". See the
#'   associated http2 functions for details.
#' @param method If the method is something other than GET or POST, supply it.
#'   Case is ignored.
#' @param token Your API token. Probably always pass this in the environment
#'   variable.
#'
#' @return The result of the call.
#' @keywords internal
.call_api <- function(endpoint,
                      query,
                      body,
                      method,
                      token = Sys.getenv("ASN_API_TOKEN")) {
  request <- .prepare_request(endpoint, query, body, method, token = token)
  response <- httr2::req_perform(request)

  return(.parse_response(response))
}

#' Combine request pieces
#'
#' @inheritParams .call_api
#'
#' @return A requrest ready to perform.
#' @keywords internal
.prepare_request <- function(endpoint, query, body, method, token) {
  request <- httr2::request(base_url)
  endpoint <- rlang::exec(glue::glue, !!!endpoint)
  request <- httr2::req_url_path_append(request, endpoint)

  if (!missing(query)) {
    request <- httr2::req_url_query(request, !!!query)
  }
  if (!missing(body)) {
    request <- .add_body(request, body)
  }
  if (!missing(method)) {
    request <- httr2::req_method(request, method)
  }

  return(
    httr2::req_auth_bearer_token(request, token)
  )
}

#' Add the body to the request
#'
#' @inheritParams .call_api
#' @param request The rest of the request.
#'
#' @return The request with the body appropriately added.
#' @keywords internal
.add_body <- function(request, body) {
  UseMethod(".add_body", body)
}


#' @export
.add_body.multipart <- function(request, body) {
  return(
    httr2::req_body_multipart(
      request,
      !!!unclass(body)
    )
  )
}

#' @export
.add_body.json <- function(request, body) {
  return(
    httr2::req_body_json(
      request,
      data = list(
        data = unclass(body)
      )
    )
  )
}

#' Parse the returned response
#'
#' @param response A raw response returned from the Asana api.
#'
#' @return Almost always a list.
#' @keywords internal
.parse_response <- function(response) {
  # TODO: Consider using the api-spec-supplied error explanations.
  httr2::resp_check_status(response)

  response <- httr2::resp_body_json(response)

  # TODO: Make sure that parsed properly.

  return(response$data)
}
