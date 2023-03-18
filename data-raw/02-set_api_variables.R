target_file <- here::here("data-raw", "api_spec.rds")
api_spec <- readRDS(target_file)

# Choose the proper base_url.
base_url <- api_spec$servers$url[[1]]

api_spec$paths |>
  # dplyr::filter(stringr::str_detect(endpoint, "users")) |>
  dplyr::filter(endpoint == "/users/{user_gid}/workspace_memberships") |>
  # dplyr::pull(endpoint)
  # dplyr::slice(4) |>
  dplyr::pull(shared_parameters)
  # dplyr::glimpse()

api_spec$components$parameters |>
  dplyr::filter(parameter == "user_path_gid") |>
  dplyr::glimpse()

testing <- api_spec$paths$parameters |>
  purrr::map(
    \(this_parameter_set) {
      purrr::map(
        this_parameter_set,
        \(this_param) {
          if (all(names(this_param) == "$ref")) {
            return(NULL)
          } else {
            return(
              tibble::tibble(
                name = this_param$name,
                `in` = this_param$`in`,
                description = this_param$description,
                schema = list(this_param$schema),
                example = list(this_param$example)
              )
            )
          }
        }
      ) |>
        purrr::list_rbind()
    }
  ) |>
  purrr::list_rbind()

# "/users" and "/users/{user_gid}" are effectively the same endpoint if there
# isn't a user_gid. You'd think "/users" would "win", but, without a query, the
# default return is "/users/me".

# The only POST with multipart is attachments.

# For PUT, "/tags/{tag_gid}" is lacking a requestBody param (also in the docs),
# but it has to match "/tags".

api_spec$paths |>
  dplyr::distinct(http_method)

usethis::use_data(
  base_url,
  internal = TRUE,
  overwrite = TRUE
)

rm(
  target_file,
  api_spec,
  base_url
)
