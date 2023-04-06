.data <- rlang::.data

..name_endpoint_file <- function(endpoint) {
  stringr::str_extract(endpoint, "^/[^/]+(?=/|$)") |>
    stringr::str_remove("/") |>
    paste0(".R")
}

..name_function <- function(operationId) {
  paste0("asn_", snakecase::to_snake_case(operationId))
}

..concat_formals <- function(parameters) {
  return(
    purrr::map(
      parameters,
      \(fun_parameters) {
        fun_parameters |>
          dplyr::arrange(dplyr::desc(.data$required), .data$name) |>
          purrr::pmap(
            \(name, default, ...) {
              default <- unlist(default)
              if (is.null(default)) {
                return(name)
              }
              return(glue::glue('{name} = "{default}"'))
            }
          ) |>
          toString()
      }
    )
  )
}

..document_response <- function(response_description, response_properties) {
  response_description <- stringr::str_replace_all(
    response_description, "\n", " "
  )
  response_description <- glue::glue("#' @return {response_description}")

  response_details <- response_properties |>
    purrr::map_chr(
      \(these_properties) {
        if (nrow(these_properties)) {
          response_detail <- these_properties |>
            purrr::pmap(
              \(property, description, type, ...) {
                description <- stringr::str_replace_all(
                  description, "\n", " "
                )
                return(
                  glue::glue("#' | {property} | {type} | {description} |")
                )
              }
            )
          return(
            paste(
              c(
                "#' | **Property** | **Class** | **Description** |",
                "#' |:-------------|:----------|:----------------|",
                response_detail
              ),
              collapse = "\n"
            )
          )
        } else {
          return("#'")
        }
      }
    )

  return(paste(response_description, response_details, sep = "\n"))
}

..document_parameters <- function(parameters) {
  purrr::map_chr(
    parameters,
    \(these_parameters) {
      these_parameters |>
        purrr::pmap(
          \(name, required, description, type, enum, default, ...) {
            optional <- dplyr::if_else(
              required,
              "",
              "(optional) "
            )

            if (is.null(enum[[1]])) {
              possible_values <- ""
            } else {
              possible_values <- glue::glue(
                " Possible values: ",
                glue::glue_collapse(enum, ", "),
                "."
              )
            }

            if (is.null(default[[1]])) {
              default <- ""
            } else {
              default <- glue::glue(
                " Default: {default}"
              )
            }


            glue::glue(
              "#' @param {name} ",
              "{optional}({type}) {description}{possible_values}{default}"
            )
          }
        )
    } |>
      paste(collapse = "\n")
  )
}

..build_calls <- function(endpoint_col, parameters_col, body_col, http_method_col) {
  return(
    purrr::pmap_chr(
      list(endpoint_col, parameters_col, body_col, http_method_col),
      ..build_call
    )
  )
}

..build_call <- function(endpoint, parameters, body, http_method) {
  # Add any params with `in` == "path" to the generated endpoint list.
  path_params <- parameters$name[parameters$`in` == "path"]
  path_params <- glue::glue("{path_params} = {path_params}")

  endpoint <- glue::glue('"{endpoint}"')

  endpoint_list <- paste0(
    "list(",
    paste(
      c(endpoint, path_params),
      collapse = ", "
    ),
    ")"
  )

  query_params_required <- parameters$name[
    parameters$`in` == "query" & parameters$required
  ]
  query_params_required <- glue::glue(
    "{query_params_required} = {query_params_required}"
  )

  query_params_optional <- parameters$name[
    parameters$`in` == "query" & !parameters$required
  ]
  query_params_optional <- glue::glue(
    "{query_params_optional} = rlang::maybe_missing({query_params_optional})"
  )
  query_params <- c(query_params_required, query_params_optional)
  query_list <- paste0(
    "list(",
    paste(
      query_params,
      collapse = ", "
    ),
    ")"
  )

  # TODO: Really deal with body.

  if (body) {
    args <- glue::glue(
      "endpoint = {endpoint_list}",
      "query = {query_list}",
      "method = \"{http_method}\"",
      "body = stop(\"We do not properly build this yet. Edit by hand.\")",
      # I'm explicitly NOT letting them change the token, for now at least. This
      # is where they'd set it if I let them.
      .sep = ",\n    ",
      .trim = FALSE
    )
  } else {
    args <- glue::glue(
      "endpoint = {endpoint_list}",
      "query = {query_list}",
      "method = \"{http_method}\"",
      # I'm explicitly NOT letting them change the token, for now at least. This
      # is where they'd set it if I let them.
      .sep = ",\n    ",
      .trim = FALSE
    )
  }

  return(
    glue::glue(
      ".call_api(",
      "  {args}",
      ")",
      .sep = "\n  ",
      .trim = FALSE
    )
  )
}
