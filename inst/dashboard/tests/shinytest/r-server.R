app <- ShinyDriver$new("../../")
app$snapshotInit("r-server")

app$setInputs(R_packages = "data.table")
app$setInputs(R_date_range_input = c("2017-12-27", "2022-07-07"))
app$setInputs(R_packages = "reticulate")
app$snapshot()
