app <- ShinyDriver$new("../../")
app$snapshotInit("python-server")

app$setInputs(python_package = "my-mltools")
app$setInputs(run_query = "click")
app$snapshot()
