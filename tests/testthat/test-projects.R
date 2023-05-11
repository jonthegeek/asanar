with_mock_dir("projects", {
  test_that("asn_get_tasks_for_project works", {
    expect_no_error({
      test_result <- asn_get_tasks_for_project(project_gid = "1204184694869405")
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
      c("gid", "name", "resource_type", "resource_subtype")
    )
    expect_identical(
      test_result[[1]]$resource_type,
      "task"
    )
  })
})
