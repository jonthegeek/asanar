# GET requests work

    Code
      .call_api(endpoint = "users")
    Output
      [[1]]
      [[1]]$gid
      [1] "1204184768818112"
      
      [[1]]$name
      [1] "Jon Harmon"
      
      [[1]]$resource_type
      [1] "user"
      
      

---

    Code
      .call_api(endpoint = list("users/{user_gid}/workspace_memberships", user_gid = "1204184768818112"),
      query = list(opt_fields = "workspace"))
    Output
      [[1]]
      [[1]]$gid
      [1] "1204184768818132"
      
      [[1]]$workspace
      [[1]]$workspace$gid
      [1] "1204184768818122"
      
      [[1]]$workspace$resource_type
      [1] "workspace"
      
      
      

# POST requests work

    Code
      test_result <- .call_api(endpoint = "tasks", query = list(section = "1204184694869408"))
      test_result
    Output
      [[1]]
      [[1]]$gid
      [1] "1204206388054744"
      
      [[1]]$name
      [1] "Task 1"
      
      [[1]]$resource_type
      [1] "task"
      
      [[1]]$resource_subtype
      [1] "default_task"
      
      

---

    Code
      body <- .prepare_body(list(task = test_result[[1]]$gid))

---

    Code
      .call_api(endpoint = list("sections/{section_gid}/addTask", section_gid = "1204184694869406"),
      body = body)
    Output
      named list()

---

    Code
      .call_api(endpoint = "tasks", query = list(section = "1204184694869406"))
    Output
      [[1]]
      [[1]]$gid
      [1] "1204206388054744"
      
      [[1]]$name
      [1] "Task 1"
      
      [[1]]$resource_type
      [1] "task"
      
      [[1]]$resource_subtype
      [1] "default_task"
      
      

---

    Code
      .call_api(endpoint = list("sections/{section_gid}/addTask", section_gid = "1204184833701161"),
      body = body)
    Output
      named list()

---

    Code
      .call_api(endpoint = "tasks", query = list(section = "1204184833701161"))
    Output
      [[1]]
      [[1]]$gid
      [1] "1204206388054744"
      
      [[1]]$name
      [1] "Task 1"
      
      [[1]]$resource_type
      [1] "task"
      
      [[1]]$resource_subtype
      [1] "default_task"
      
      

---

    Code
      .call_api(endpoint = list("sections/{section_gid}/addTask", section_gid = "1204184694869408"),
      body = body)
    Output
      named list()

# POSTing and DELETEing files works.

    Code
      body <- .prepare_body(list(parent = "1204206388054744", file = test_path(
        "img-test.png")), type = "multipart", mime_type = "image/png")

---

    Code
      test_result[names(test_result) != "gid"]
    Output
      $resource_type
      [1] "attachment"
      
      $name
      [1] "img-test.png"
      
      $resource_subtype
      [1] "asana"
      

---

    Code
      .call_api(endpoint = list("attachments/{attachment_gid}", attachment_gid = test_result$
        gid), method = "delete")
    Output
      named list()

