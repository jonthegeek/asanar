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
#' @return A request ready to perform.
#' @keywords internal
.prepare_request <- function(endpoint, query, body, method, token) {
  request <- httr2::request(base_url)
  endpoint <- rlang::exec(glue::glue, !!!endpoint)
  request <- httr2::req_url_path_append(request, endpoint)

  if (!missing(query)) {
    query <- .remove_missing(query)
    if (length(query)) {
      request <- httr2::req_url_query(request, !!!query)
    }
  }
  if (!missing(body)) {
    body <- .remove_missing(body)
    if (length(body)) {
      request <- .add_body(request, body)
    }
  }
  if (!missing(method)) {
    request <- httr2::req_method(request, method)
  }

  return(
    httr2::req_auth_bearer_token(request, token)
  )
}

#' Remove missing arguments
#'
#' @param arg_list A list of arguments, each of which should be wrapped in
#'   `rlang::maybe_missing()`.
#'
#' @return The list without missing parameters.
#' @keywords internal
.remove_missing <- function(arg_list) {
  arg_present <- !purrr::map_lgl(
    arg_list,
    rlang::is_missing
  )
  return(
    structure(
      arg_list[arg_present],
      # Preserve special classes!
      class = class(arg_list)
    )
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
      data = unclass(body)
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

  return(.new_asn_response(response$data))
}

#' Construct an asn_response
#'
#' @param response_data The `data` portion of a response from
#'   `httr2::resp_body_json()`.
#'
#' @return An object with additional class "asn_response", or `NULL`.
#' @keywords internal
.new_asn_response <- function(response_data) {
  if (is.null(response_data)) {
    return(NULL)
  } else {
    return(
      structure(
        response_data,
        class = c("asn_response", class(response_data))
      )
    )
  }
}

#' Prepare the body of a call
#'
#' @param body An object to use as the body of the request.
#' @param type Whether the request is "json" or "multipart".
#' @param mime_type The mime_type of any file included in the body.
#'
#' @return A prepared body list object with a "json" or "multipart" subclass.
#' @keywords internal
.prepare_body <- function(body, type = c("json", "multipart"), mime_type) {
  type <- rlang::arg_match(type)

  switch(type,
    json = {
      body <- list(data = body)
      class(body) <- c("json", "list")
      return(body)
    },
    # There's only one valid multipart case for Asana, so I'm hard-coding
    # things. If this gets generalized, this will need to be rethought.
    multipart = {
      if ("file" %in% names(body)) {
        # TODO: auto-guess type?
        body$file <- curl::form_file(body$file, type = mime_type)
      }
      for (body_part in names(body)[names(body) != "file"]) {
        body[[body_part]] <- curl::form_data(body[[body_part]])
      }
      class(body) <- c("multipart", "list")
      return(body)
    }
  )
}
