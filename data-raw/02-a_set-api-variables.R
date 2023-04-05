# Use the api_spec to generate internal variables for this package.

# Load the spec ----------------------------------------------------------------

target_file <- here::here("data-raw", "api_spec.rds")
api_spec <- readRDS(target_file)


# Choose the base_url ----------------------------------------------------------

# It's possible for a spec to have multiple values in $servers$url. Tell the
# package which one is correct.
base_url <- api_spec$servers$url[[1]]

# Set other variables? ---------------------------------------------------------

# I don't have any yet, but there are likely to be some.


# Save to internal data -------------------------------------------------------

usethis::use_data(
  base_url,
  internal = TRUE,
  overwrite = TRUE
)


# Clean up ---------------------------------------------------------------------

rm(
  target_file,
  api_spec,
  base_url
)
