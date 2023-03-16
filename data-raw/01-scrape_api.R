target_file <- here::here("data-raw", "api_spec.rds")

if (file.exists(target_file)) {
  api_spec <- readRDS(target_file)
} else{
  # Read YAML file
  api_spec_url <- file.path(
    "https://raw.githubusercontent.com/Asana",
    "openapi/master/defs/asana_oas.yaml"
  )
  api_spec <- yaml::read_yaml(
    api_spec_url,
    # Some things are interpreted as ints but they aren't. For example, there
    # are pairs of ints that were being read in as ints, and then failing.
    handlers = list(int = as.character)
  )

  # Parse each component individually. I tried to generalize this but it didn't
  # make sense.

  # api_spec$openapi <- api_spec$openapi
  # api_spec$info <- api_spec$info

  # In this case there's only one server so this isn't interesting, but prepare
  # for a case where it is.
  api_spec$servers <- api_spec$servers |>
    tibble::enframe(name = NULL) |>
    tidyr::unnest_wider(value)

  api_spec$security <- names(purrr::flatten(api_spec$security))

  # api_spec$`x-readme` <- api_spec$`x-readme`

  # These might be useful for docs or something. Perhaps they can plug into
  # endpoint documentation or something.
  api_spec$tags <- api_spec$tags |>
    tibble::enframe(name = NULL) |>
    tidyr::unnest_wider(value)

  # The components are each really different objects, parse them separately.
  api_spec$components$parameters <- api_spec$components$parameters |>
    tibble::enframe(name = "parameter") |>
    tidyr::unnest_wider(value)

  api_spec$components$responses <- api_spec$components$responses |>
    tibble::enframe(name = "response") |>
    tidyr::unnest_wider(value) |>
    # The "content" column is a nested list that's just pointing at a field in
    # another table. Just one field, in fact. For now I'm hard-coding.
    dplyr::mutate(
      schema = "ErrorResponse"
    ) |>
    dplyr::select(-"content")

  # We might want to do more with this one.
  api_spec$components$schemas <- api_spec$components$schemas |>
    tibble::enframe(name = "schema") |>
    tidyr::unnest_wider(value)

  # api_spec$components$securitySchemes <-
  # api_spec$components$securitySchemes

  # This could kind of use more parsing, but I feel like it should probably
  # happen during use.
  api_spec$paths <- api_spec$paths |>
    tibble::enframe(name = "endpoint") |>
    tidyr::hoist(value, shared_parameters = "parameters") |>
    tidyr::unnest_longer(value, indices_to = "http_method") |>
    tidyr::unnest_wider(value)

  # A thing I noticed: When parameters are used in the endpoint inside {},
  # that's the "name" from api_spec$components$parameters, not the thing I
  # called "parameter" (the name of that object in the spec).

  saveRDS(api_spec, target_file)
}
rm(target_file)
