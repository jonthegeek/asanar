with_mock_dir("tasks", {
  test_that("asn_get_stories_for_task works", {
    expect_no_error({
      test_result <- asn_get_stories_for_task(task_gid = "1204206388054744")
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
      c(
        "gid", "created_at", "created_by", "resource_type", "text", "type",
        "resource_subtype"
      )
    )
    expect_identical(
      test_result[[1]]$resource_type,
      "story"
    )
  })
})
