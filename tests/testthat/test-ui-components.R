# Snapshots for UI components ---------------------------------------------

test_that("snapshots for header()", {
  expect_snapshot_output(
    x = header(),
    cran = FALSE,
    variant = "header"
  )
})

test_that("snapshots for sidebar()", {
  expect_snapshot_output(
    x = sidebar(),
    cran = FALSE,
    variant = "sidebar"
  )
})
