# Scrape the API spec into usable data.

# Load and define helpers ------------------------------------------------------

source(here::here("data-raw", "01-b_scrape-helpers.R"), local = TRUE)
target_file <- here::here("data-raw", "api_spec.rds")


# Read YAML file -------------------------------------------------------------

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

# Usable as-is -----------------------------------------------------------------

# api_spec$openapi <- api_spec$openapi
# api_spec$info <- api_spec$info
# api_spec$`x-readme` <- api_spec$`x-readme`

# servers ----------------------------------------------------------------------

# In this case there's only one server so this isn't interesting, but prepare
# for a case where it is.
api_spec$servers <- api_spec$servers |>
  tibble::enframe(name = NULL) |>
  tidyr::unnest_wider("value")

# security ---------------------------------------------------------------------

api_spec$security <- names(purrr::flatten(api_spec$security))

# tags -------------------------------------------------------------------------

# These might be useful for docs or something. Perhaps they can plug into
# endpoint documentation or something.
api_spec$tags <- api_spec$tags |>
  tibble::enframe(name = NULL) |>
  tidyr::unnest_wider("value")

# components -------------------------------------------------------------------

# The components are each really different objects, parse them separately.

## components$parameters -------------------------------------------------------

# I was rectangling this, but it's easier to use as-is.
# api_spec$components$parameters <- api_spec$components$parameters

# api_spec$components$parameters <- api_spec$components$parameters |>
#   tibble::enframe(name = "parameter") |>
#   tidyr::unnest_wider(value)

## components$responses --------------------------------------------------------

api_spec$components$responses <- api_spec$components$responses |>
  tibble::enframe(name = "response") |>
  tidyr::unnest_wider(value) |>
  # The "content" column is a nested list that's just pointing at a field in
  # another table. Just one field, in fact. For now I'm hard-coding.
  dplyr::mutate(
    schema = "ErrorResponse"
  ) |>
  dplyr::select(-"content")

## components$schemas ----------------------------------------------------------

# For now, I'm not going for completeness here. I'll check things manually when
# I finalize the functions. Let's try to get the `description` field sorted out
# (of the overall schema, not the individual pieces).

api_spec$components$schemas <- ..clean_schemas(api_spec$components$schemas)

## components$securitySchemas --------------------------------------------------

# api_spec$components$securitySchemes <- api_spec$components$securitySchemes

# paths ------------------------------------------------------------------------

## paths basics ----------------------------------------------------------------

# There's a LOT of cleaning to do in paths. Start with the basics, then dive
# into details.
paths_parsed <- api_spec$paths |>
  tibble::enframe(name = "endpoint") |>
  tidyr::hoist("value", shared_parameters = "parameters") |>
  tidyr::unnest_longer("value", indices_to = "http_method") |>
  tidyr::unnest_wider("value") |>
  dplyr::mutate(row_num = dplyr::row_number())

## paths$responses -------------------------------------------------------------

paths_parsed <- ..clean_path_responses(
  paths_parsed,
  api_spec$components$schemas
)

# TODO: For opt_fields, use the response for this object to define the "enum"
# column. That actually isn't perfect. It's hiding somehow.

## paths$parameters ------------------------------------------------------------

# We lose rows that don't have any params, so instead we'll parse the two
# params columns, then join them back in.

parsed_shared_params <- paths_parsed$shared_parameters |>
  ..clean_params()

parsed_params <- paths_parsed$parameters |>
  ..clean_params()

all_parsed_params <- dplyr::bind_rows(
  parsed_params,
  parsed_shared_params
) |>
  dplyr::arrange(.data$row_num, .data$`in`, .data$required, .data$name) |>
  dplyr::distinct() |>
  tidyr::nest(
    parameters = -"row_num"
  )

api_spec$paths <- paths_parsed |>
  dplyr::select(
    -"shared_parameters",
    -"parameters"
  ) |>
  dplyr::left_join(all_parsed_params, by = "row_num") |>
  dplyr::select(-"row_num")

# Save -------------------------------------------------------------------------

saveRDS(api_spec, target_file)
rm(
  all_parsed_params,
  api_spec_url,
  parsed_params,
  parsed_shared_params,
  paths_parsed,
  target_file
)
source(here::here("data-raw", "01-c_scrape-cleanup.R"), local = TRUE)
