# I use ../api instead of just api to avoid a "long filename" issue.

with_mock_dir("../api", {
  test_that("GET requests work", {
    expect_snapshot({
      .call_api(
        endpoint = "users"
      )
    })
    expect_snapshot({
      .call_api(
        endpoint = list(
          "users/{user_gid}/workspace_memberships",
          user_gid = "1204184768818112"
        ),
        query = list(
          opt_fields = "workspace"
        )
      )
    })
  })

  test_that("POST requests work", {
    # Check the Incoming section to get the task ID.
    expect_snapshot({
      test_result <- .call_api(
        endpoint = "tasks",
        query = list(
          section = "1204184694869408"
        )
      )
      test_result
    })

    expect_snapshot({
      body <- .prepare_body(list(task = test_result[[1]]$gid))
    })

    # Move Task 1 to Icebox.
    expect_snapshot({
      .call_api(
        endpoint = list(
          "sections/{section_gid}/addTask",
          section_gid = "1204184694869406"
        ),
        body = body
      )
    })

    # Check the Icebox section.
    expect_snapshot({
      .call_api(
        endpoint = "tasks",
        query = list(
          section = "1204184694869406"
        )
      )
    })

    # Move it to To do.
    expect_snapshot({
      .call_api(
        endpoint = list(
          "sections/{section_gid}/addTask",
          section_gid = "1204184833701161"
        ),
        body = body
      )
    })

    # Check the To do section.
    expect_snapshot({
      .call_api(
        endpoint = "tasks",
        query = list(
          section = "1204184833701161"
        )
      )
    })

    # Move it back to Incoming to reset.
    expect_snapshot({
      .call_api(
        endpoint = list(
          "sections/{section_gid}/addTask",
          section_gid = "1204184694869408"
        ),
        body = body
      )
    })
  })

  test_that("POSTing and DELETEing files works.", {
    # This body will attach this image to Task 1.
    expect_snapshot({
      body <- .prepare_body(
        list(
          parent = "1204206388054744",
          file = test_path("img-test.png")
        ),
        type = "multipart",
        mime_type = "image/png"
      )
    })

    expect_no_error({
      test_result <- .call_api(
        endpoint = "attachments",
        body = body
      )
    })

    expect_snapshot({
      test_result[names(test_result) != "gid"]
    })


    # Delete it.
    expect_snapshot({
      .call_api(
        endpoint = list(
          "attachments/{attachment_gid}",
          attachment_gid = test_result$gid
        ),
        method = "delete"
      )
    })
  })
})
