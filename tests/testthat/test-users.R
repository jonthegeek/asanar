with_mock_dir("users", {
  test_that("asn_get_users works", {
    expect_no_error({
      test_result <- asn_get_users()
    })
    expect_s3_class(
      test_result,
      "asn_response"
    )
    expect_gte(
      length(test_result),
      1
    )
    expect_named(
      test_result[[1]],
      c("gid", "name", "resource_type")
    )
    expect_identical(
      test_result[[1]]$resource_type,
      "user"
    )
  })
})
