# Snapshots for UI components ---------------------------------------------

test_that("snapshots for header()", {
  expect_snapshot_output(
    x = header(),
    cran = FALSE,
    variant = "header"
  )
})

test_that("snapshots for body_()", {
  expect_snapshot_output(
    x = body_(top_packages = "dplyr", today = Sys.Date() - 1, last_month = Sys.Date() - 61),
    cran = FALSE,
    variant = "body"
  )
})

test_that("snapshots for sidebar()", {
  expect_snapshot_output(
    x = sidebar(),
    cran = FALSE,
    variant = "sidebar"
  )
})
