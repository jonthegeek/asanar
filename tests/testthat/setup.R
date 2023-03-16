library(httptest2)

# When we're in capture mode, clear out previous captures.
if (Sys.getenv("ASN_API_TEST_MODE") == "capture") {
  if (Sys.getenv("ASN_API_TOKEN") == "") {
    stop(
      "No ASN_API_TOKEN available, cannot capture results. \n",
      "Unset ASN_API_TEST_MODE to use the mocked calls."
    )
  }
  unlink(test_path("asana.com"), recursive = TRUE)
}
