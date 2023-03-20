.data <- rlang::.data
`%||%` <- rlang::`%||%`

..clean_schemas <- function(schemas) {
  # Some basic cleaning.
  all_schemas <- schemas |>
    tibble::enframe(name = "schema") |>
    tidyr::unnest_wider("value") |>
    # Only one schema has a value for anyOf: "MembershipResponse". Let's just
    # manually set its description to one of the values.
    dplyr::mutate(
      description = dplyr::if_else(
        .data$schema == "MembershipResponse",
        "A generic Asana Resource, containing a globally unique identifier.",
        .data$description
      )
    ) |>
    dplyr::select("schema", "description", "allOf", "ref" = "$ref") |>
    # Extract refs from allOf. There are often also properties, but right now we
    # don't care about those.
    tidyr::hoist(
      "allOf",
      ref2 = list(1, "$ref")
    ) |>
    dplyr::mutate(
      ref = dplyr::coalesce(.data$ref, .data$ref2),
      ref = stringr::str_extract(.data$ref, "[^/]+$")
    ) |>
    dplyr::select(-"ref2", -"allOf")

  # Now for the trickiest bit. ref is referencing something else in this tibble,
  # and it can be recursive. Let's write a function to walk through that.
  parse_ref <- function(ref) {
    if (is.na(ref)) {
      return(NA_character_)
    }

    subref <- all_schemas$ref[which(all_schemas$schema == ref)]
    if (!is.na(subref)) {
      return(parse_ref(subref))
    }

    return(all_schemas$description[all_schemas$schema == ref])
  }

  all_schemas <- all_schemas |>
    dplyr::mutate(
      description = dplyr::coalesce(
        .data$description,
        purrr::map_chr(.data$ref, parse_ref)
      )
    ) |>
    dplyr::select(-"ref")

  # It's easier as a named character vector.
  return(
    rlang::set_names(
      all_schemas$description,
      all_schemas$schema
    )
  )
}

..clean_schema_properties <- function(properties_col, required_col) {
  params_tbl <- properties_col |>
    tibble::enframe(name = "row_num") |>
    tidyr::unnest_longer("value", indices_to = "name") |>
    tidyr::unnest_wider("value")

  # ..clean_params looks for a schema column, which later gets unnested. It's
  # already unnested here, mostly.

  # There are two types of cleaning. First, let's deal with the one case that
  # uses $ref. Doing this manually rather than programmatically to get it done.
  # TODO: Generalize this.
  params_tbl[
    params_tbl$row_num == 24 & params_tbl$name == "user",
  ]$description <- api_spec$components$schemas$UserCompact$allOf[[2]]$description
  params_tbl[
    params_tbl$row_num == 24 & params_tbl$name == "user",
  ]$type <- "string"
  params_tbl[
    params_tbl$row_num == 24 & params_tbl$name == "user",
  ]$example <- list("12345")

  params_tbl$`$ref` <- NULL

  # There are actually only two sets of params that have things in allOf (and
  # one overlaps somewhat with the case above). Let's do those manually, too.
  params_tbl[
    params_tbl$row_num == 18 & params_tbl$name == "user",
  ]$description <- "The user who triggered the event."
  params_tbl[
    params_tbl$row_num == 18 & params_tbl$name == "user",
  ]$type <- "string"
  params_tbl[
    params_tbl$row_num == 18 & params_tbl$name == "user",
  ]$example <- list("12345")
  params_tbl[
    params_tbl$row_num == 18 & params_tbl$name == "user",
  ]$allOf <- list(NULL)

  params_tbl[
    params_tbl$row_num == 18 & params_tbl$name == "resource",
  ]$description <- "The resource which has triggered the event by being modified in some way."
  params_tbl[
    params_tbl$row_num == 18 & params_tbl$name == "resource",
  ]$type <- "string"
  params_tbl[
    params_tbl$row_num == 18 & params_tbl$name == "resource",
  ]$example <- list("Bug Task")
  params_tbl[
    params_tbl$row_num == 18 & params_tbl$name == "resource",
  ]$allOf <- list(NULL)

  params_tbl[
    params_tbl$row_num == 18 & params_tbl$name == "parent",
  ]$description <- "For added/removed events, the parent object that resource was added to or removed from. The parent will be `null` for other event types."
  params_tbl[
    params_tbl$row_num == 18 & params_tbl$name == "parent",
  ]$type <- "string"
  params_tbl[
    params_tbl$row_num == 18 & params_tbl$name == "parent",
  ]$example <- list("Bug Task")
  params_tbl[
    params_tbl$row_num == 18 & params_tbl$name == "parent",
  ]$allOf <- list(NULL)

  params_tbl[
    params_tbl$row_num == 6 & params_tbl$name == "actor",
  ]$description <- "The entity that triggered the event. Will typically be a user."
  params_tbl[
    params_tbl$row_num == 6 & params_tbl$name == "actor",
  ]$type <- "object"
  params_tbl[
    params_tbl$row_num == 6 & params_tbl$name == "actor",
  ]$properties <- list(api_spec$components$schemas$AuditLogEventActor$properties)
  params_tbl[
    params_tbl$row_num == 6 & params_tbl$name == "actor",
  ]$allOf <- list(NULL)

  params_tbl[
    params_tbl$row_num == 6 & params_tbl$name == "resource",
  ]$description <- api_spec$components$schemas$AuditLogEventResource$description
  params_tbl[
    params_tbl$row_num == 6 & params_tbl$name == "resource",
  ]$type <- "object"
  params_tbl[
    params_tbl$row_num == 6 & params_tbl$name == "resource",
  ]$properties <- list(api_spec$components$schemas$AuditLogEventResource$properties)
  params_tbl[
    params_tbl$row_num == 6 & params_tbl$name == "resource",
  ]$allOf <- list(NULL)

  params_tbl[
    params_tbl$row_num == 6 & params_tbl$name == "details",
  ]$description <- api_spec$components$schemas$AuditLogEventDetails$description
  params_tbl[
    params_tbl$row_num == 6 & params_tbl$name == "details",
  ]$type <- "object"
  params_tbl[
    params_tbl$row_num == 6 & params_tbl$name == "details",
  ]$allOf <- list(NULL)

  params_tbl[
    params_tbl$row_num == 6 & params_tbl$name == "context",
  ]$description <- api_spec$components$schemas$AuditLogEventContext$description
  params_tbl[
    params_tbl$row_num == 6 & params_tbl$name == "context",
  ]$type <- "object"
  params_tbl[
    params_tbl$row_num == 6 & params_tbl$name == "context",
  ]$properties <- list(api_spec$components$schemas$AuditLogEventContext$properties)
  params_tbl[
    params_tbl$row_num == 6 & params_tbl$name == "context",
  ]$allOf <- list(NULL)

  # Some columns appear to be useless, and others need slightly cleaning.
  params_tbl$`x-insert-after` <- NULL
  params_tbl$allOf <- NULL

  # This one looks to have some info but I want to move on for now.
  params_tbl$items <- NULL

  params_tbl$readOnly <- !is.na(params_tbl$readOnly)
  params_tbl$nullable <- !is.na(params_tbl$nullable)

  # The "required" info is up a level from where it should be. Let's put them
  # into the right places.

  # There's only one params_tbl$required that isn't NA, fix it manually.
  params_tbl$properties[[
    which(!is.na(params_tbl$required))
  ]]$should_skip_weekends$required <- TRUE

  params_tbl$required <- NULL

  params_tbl |>
    dplyr::filter(!is.na(required)) |>
    dplyr::pull(properties)

  return(tidyr::nest(params_tbl, .by = "row_num", .key = "properties"))
}

..clean_params <- function(params_col) {
  params_tbl <- params_col |>
    tibble::enframe(name = "row_num") |>
    tidyr::unnest_longer("value") |>
    tidyr::unnest_wider("value")

  # By chance, some cols can be missing. Make sure they're all there so we can
  # use easier code below. This won't actually work for "schema" and "example"
  # yet (since they're list columns) but so far we don't need that.
  expected_cols <- c(
    "row_num", "$ref", "name", "in", "required", "description", "schema",
    "example", "x-env-variable"
  )
  for (missing_col in setdiff(expected_cols, colnames(params_tbl))) {
    params_tbl[[missing_col]] <- NA_character_
  }

  params_tbl <- params_tbl |>
    dplyr::mutate(
      parameter = stringr::str_extract(
        .data$`$ref`,
        "[^/]+$"
      ),
      name = dplyr::if_else(
        is.na(.data$name),
        purrr::map_chr(
          .data$parameter,
          \(x) {
            api_spec$components$parameters[[x]]$name %||% NA_character_
          }
        ),
        .data$name
      ),
      `in` = dplyr::if_else(
        is.na(.data$`in`),
        purrr::map_chr(
          .data$parameter,
          \(x) {
            api_spec$components$parameters[[x]]$`in` %||% NA_character_
          }
        ),
        .data$`in`
      ),
      required = dplyr::if_else(
        is.na(.data$required),
        purrr::map_lgl(
          .data$parameter,
          \(x) {
            api_spec$components$parameters[[x]]$required %||% FALSE
          }
        ),
        .data$required
      ),
      description = dplyr::if_else(
        is.na(.data$description),
        purrr::map_chr(
          .data$parameter,
          \(x) {
            api_spec$components$parameters[[x]]$description %||% NA_character_
          }
        ),
        .data$description
      ),
      schema = dplyr::if_else(
        lengths(.data$schema) == 0,
        purrr::map(
          .data$parameter,
          \(x) {
            api_spec$components$parameters[[x]]$schema
          }
        ),
        .data$schema
      ),
      example = dplyr::if_else(
        lengths(.data$example) == 0,
        purrr::map(
          .data$parameter,
          \(x) {
            api_spec$components$parameters[[x]]$example
          }
        ),
        .data$example
      ),
      `x-env-variable` = dplyr::if_else(
        is.na(.data$`x-env-variable`),
        purrr::map_chr(
          .data$parameter,
          \(x) {
            api_spec$components$parameters[[x]]$`x-env-variable` %||%
              NA_character_
          }
        ),
        .data$`x-env-variable`
      )
    ) |>
    # The opt_pretty parameters is useless (it just changes how json looks
    # when it's returned, and we immediately parse it anyway).
    dplyr::filter(.data$name != "opt_pretty") |>
    dplyr::select(
      -"$ref",
      -"parameter"
    ) |>
    # Schema has useful info that should't be buried.
    tidyr::unnest_wider("schema", names_sep = "_")

  if ("schema_example" %in% colnames(params_tbl)) {
    params_tbl$example <- purrr::map2(
      params_tbl$example, params_tbl$schema_example,
      `%||%`
    )
    params_tbl$schema_example <- NULL
  }

  params_tbl <- dplyr::rename_with(
    params_tbl,
    stringr::str_remove,
    dplyr::starts_with("schema_"),
    "^schema_"
  )

  # Types aren't in R terms, fix that.
  if ("type" %in% colnames(params_tbl)) {
    # Special case 1: Arrays. Theoretically this depends on the "items"
    # column, but in this case it's always "string". We'll hard-code here but
    # this may not generalize to other APIs.

    # We don't need this column anymore. It's potentially useful but in this
    # case it's always just "string".
    params_tbl$items <- NULL

    # Special case 2: When enum isn't NULL, it's still a string, but there
    # will be additional documentation and checking of the possible values.

    # Special case 3: The "format" column specifies "date-time" and "date".
    # The associated "type" is always "string".

    params_tbl <- params_tbl |>
      dplyr::mutate(
        type = dplyr::case_when(
          .data$type == "integer" ~ "integer scalar",
          .data$type == "boolean" ~ "logical scalar",
          .data$type == "array" ~ "character vector",
          .data$type == "string" &
            .data$format == "date-time" ~ "datetime scalar",
          .data$type == "string" & .data$format == "date" ~ "date scalar",
          .data$type == "string" ~ "character scalar",
          TRUE ~ .data$type
        )
      )
  }

  # They put arbitrary \n's in the descriptions, and those will break things.
  # Change those into space.
  params_tbl$description <- stringr::str_replace_all(
    params_tbl$description,
    "\n",
    " "
  )

  params_tbl
}

..clean_path_responses <- function(paths_parsed) {
  paths_parsed |>
    tidyr::unnest_wider("responses", names_sep = "_") |>
    # Everything has exactly one of 200, 201, or 204. All we care about out of
    # those is the $content$`application/json`$schema$properties$data$`$ref` in
    # order to grab the description of the response.
    dplyr::mutate(
      response_ok = dplyr::case_when(
        lengths(responses_200) > 0 ~ responses_200,
        lengths(responses_201) > 0 ~ responses_201,
        lengths(responses_204) > 0 ~ responses_204,
        TRUE ~ list(NULL)
      )
    ) |>
    tidyr::nest(
      responses = dplyr::starts_with("responses_"),
      .names_sep = "_"
    ) |>
    tidyr::hoist(
      "response_ok",
      response_schema = list(
        "content", "application/json", "schema", "properties", "data", "$ref"
      ),
      response_schema2 = list(
        "content", "application/json", "schema", "properties", "data", "items",
        "$ref"
      )
    ) |>
    dplyr::mutate(
      response_schema = stringr::str_extract(
        .data$response_schema,
        "[^/]+$"
      ),
      response_schema2 = stringr::str_extract(
        .data$response_schema2,
        "[^/]+$"
      ),
      response_description = purrr::map2_chr(
        .data$response_schema,
        .data$response_schema2,
        \(schema, schema2) {
          if (is.na(schema)) {
            return(
              api_spec$components$schemas[[schema2]]
            )
          }

          return(
            api_spec$components$schemas[[schema]]
          )
        }
      )
    ) |>
    dplyr::select(
      -"response_schema",
      -"response_schema2"
    )
}
