test_that("asn_browse_token returns the expected url", {
  test_result <- asn_browse_token()
  expect_identical(
    test_result,
    "https://app.asana.com/0/my-apps"
  )
})
