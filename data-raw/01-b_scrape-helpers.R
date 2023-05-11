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
    dplyr::select(
      "schema", "description", "allOf",
      "ref" = "$ref", "properties", "required"
    ) |>
    # Extract things from allOf.
    tidyr::hoist(
      "allOf",
      ref2 = list(1, "$ref"),
      allOf_properties = list(2, "properties"),
      allOf_description = list(2, "description")
    ) |>
    dplyr::mutate(
      ref = dplyr::coalesce(.data$ref, .data$ref2),
      ref = stringr::str_extract(.data$ref, "[^/]+$")
    ) |>
    dplyr::select(-"ref2", -"allOf")

  # Descriptions can be in the schema itself, in the allOf data, or in a
  # referenced schema (and those references can be nested).

  # First, deal with the two "basic" locations.
  all_schemas <- all_schemas |>
    dplyr::mutate(
      description = dplyr::coalesce(
        .data$description,
        .data$allOf_description
      )
    ) |>
    dplyr::select(-"allOf_description")

  # We'll use a function to recurse through references to find a description, if
  # necessary.
  all_schemas <- all_schemas |>
    dplyr::mutate(
      description = dplyr::coalesce(
        .data$description,
        purrr::map_chr(
          .data$ref,
          ..parse_ref_description,
          all_schemas = all_schemas
        )
      )
    )

  # Similar to the situation above, first we'll clean up the ~self-contained
  # properties for each schema, then we'll use the ref to find things that are
  # missing. In this case we want to inherit all the things, though (not just
  # take the first non-empty). Don't forget to make sure things are distinct!
  all_schemas <- all_schemas |>
    dplyr::mutate(
      allOf_properties = ..clean_schema_properties_col(
        .data$allOf_properties,
        .data
      ),
      properties = ..clean_schema_properties_col(
        .data$properties,
        .data
      ),
      properties = purrr::map2(
        .data$properties,
        .data$allOf_properties,
        \(prop1, prop2) {
          dplyr::bind_rows(
            tibble::tibble(
              property = character(0),
              description = character(0),
              type = character(0),
              example = list(),
              enum = list()
            ),
            prop1, prop2
          ) |>
            dplyr::distinct(.data$property, .keep_all = TRUE)
        }
      )
    ) |>
    dplyr::select(-"allOf_properties")

  # Apply required info.
  all_schemas <- all_schemas |>
    dplyr::mutate(
      properties = purrr::map2(
        .data$properties, .data$required,
        \(props, req) {
          if (is.null(req)) {
            return(
              dplyr::mutate(
                props,
                required = FALSE
              ) |>
                dplyr::arrange(.data$property)
            )
          }
          # There's at least one case where this doesn't hold up. I don't think
          # I screwed anything up, this is just an issue in the spec.

          # stopifnot(
          #   all(req %in% props$property)
          # )
          return(
            dplyr::mutate(
              props,
              required = .data$property %in% req
            ) |>
              dplyr::arrange(dplyr::desc(.data$required), .data$property)
          )
        }
      )
    ) |>
    dplyr::select(-"required")


  # Recursively update properties using ref. If A references B which references
  # C, A should end up with properties from A, B, and C.
  all_schemas <- all_schemas |>
    dplyr::mutate(
      properties = purrr::map2(
        .data$ref, .data$properties,
        ..combine_ref_properties,
        all_schemas = .data
      )
    ) |>
    dplyr::select(-"ref")

  return(all_schemas)
}

..parse_ref_description <- function(ref, all_schemas, depth = 1L) {
  if (is.na(ref) || depth > 20) {
    return(NA_character_)
  }

  # If this ref has its own description, that is a less-generic value than any
  # subref, so return it.
  this_desc <- all_schemas$description[all_schemas$schema == ref]

  if (!is.na(this_desc)) {
    return(this_desc)
  }

  return(
    ..parse_ref_description(
      all_schemas$ref[all_schemas$schema == ref],
      all_schemas,
      depth = depth + 1L
    )
  )
}

..combine_ref_properties <- function(ref, properties, all_schemas, depth = 1L) {
  if (is.na(ref) || depth > 20) {
    return(
      dplyr::bind_rows(properties, NULL)
    )
  }

  return(
    ..combine_ref_properties(
      ref = all_schemas$ref[all_schemas$schema == ref],
      properties = dplyr::bind_rows(
        all_schemas$properties[all_schemas$schema == ref][[1]],
        properties
      ) |>
        dplyr::distinct(.data$property, .keep_all = TRUE),
      all_schemas = all_schemas,
      depth = depth + 1L
    )
  )
}

..clean_schema_properties_col <- function(properties_col, all_schemas) {
  # This rectangles and cleans up a properties column. The properties won't be
  # fully usable after this, but it's a step.
  params_tbl <- properties_col |>
    tibble::enframe(name = "row_num") |>
    tidyr::unnest_longer("value", indices_to = "property") |>
    tidyr::unnest_wider("value") |>
    dplyr::select(
      "row_num", "property", dplyr::everything()
    )

  # We aren't going to deal with some columns yet even if they exist.
  params_tbl$`x-insert-after` <- NULL
  params_tbl$readOnly <- NULL
  params_tbl$nullable <- NULL
  params_tbl$required <- NULL
  params_tbl$`x-env-variable` <- NULL

  # We aren't going to document the things inside objects, at least not yet.
  params_tbl$properties <- NULL
  params_tbl$additionalProperties <- NULL

  # When allOf isn't NULL, it's giving details about nested properties.
  # Importantly, it hides the description and type, which are the main things I
  # care about.
  params_tbl <- params_tbl |>
    tidyr::hoist(
      "allOf",
      description_allof = list(2, "description"),
      type_allof = list(2, "type"),
      ref_allof = list(1, "$ref"),
      # Hoist these for tracking purposes.
      nullable_allof = list(2, "nullable"),
      nullable_readonly = list(2, "readOnly")
    ) |>
    tidyr::hoist(
      "items",
      description_items = "description",
      type_items = "type",
      ref_items = "$ref"
    ) |>
    dplyr::mutate(
      description = dplyr::coalesce(
        .data$description, .data$description_allof, .data$description_items
      ),
      type = dplyr::coalesce(
        .data$type, .data$type_allof, .data$type_items
      ),
      ref = dplyr::coalesce(
        .data$`$ref`,
        .data$ref_allof,
        .data$ref_items
      ) |>
        stringr::str_extract(
          "[^/]+$"
        )
    ) |>
    dplyr::select(
      -"description_allof",
      -"type_allof",
      -"ref_allof",
      -"ref_items",
      -"type_items",
      -"description_items",
      -"$ref",
      -"nullable_allof",
      -"nullable_readonly",
      -"allOf",
      -"items"
    )

  # Use ref to fill in descriptions.
  params_tbl <- params_tbl |>
    dplyr::mutate(
      description = dplyr::coalesce(
        .data$description,
        purrr::map_chr(
          .data$ref,
          ..parse_ref_description,
          all_schemas = all_schemas
        )
      )
    ) |>
    dplyr::select(-"ref")

  params_tbl <- params_tbl |>
    dplyr::mutate(
      type = ..clean_types(.data$type, .data$format)
    ) |>
    dplyr::select(-"format")

  params_prepared <- tibble::tibble(row_num = seq_along(properties_col)) |>
    dplyr::left_join(
      tidyr::nest(params_tbl, .by = "row_num", .key = "properties"),
      by = "row_num"
    )

  return(params_prepared$properties)
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
        type = ..clean_types(.data$type, .data$format)
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

..clean_types <- function(type_col, format_col) {
  return(
    dplyr::case_when(
      type_col == "integer" ~ "integer scalar",
      type_col == "boolean" ~ "logical scalar",
      type_col == "array" ~ "list",
      type_col == "object" ~ "list",
      type_col == "string" &
        format_col == "date-time" ~ "datetime scalar",
      type_col == "string" & format_col == "date" ~ "date scalar",
      type_col == "string" ~ "character scalar",
      is.na(type_col) ~ "list",
      TRUE ~ type_col
    )
  )
}

..clean_path_responses <- function(paths_parsed, schemas) {
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
              schemas$description[schemas$schema == schema2]
            )
          }

          return(
            schemas$description[schemas$schema == schema]
          )
        }
      ),
      response_properties = purrr::map2(
        .data$response_schema,
        .data$response_schema2,
        \(schema, schema2) {
          if (is.na(schema)) {
            props <- schemas$properties[schemas$schema == schema2][[1]]
          } else {
            props <- schemas$properties[schemas$schema == schema][[1]]
          }
          props$required <- NULL
          return(props)
        }
      )
    ) |>
    dplyr::select(
      -"response_schema",
      -"response_schema2",
      -"x-readme"
    )
}
