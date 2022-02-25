pkgload::load_all(".")

top5 <- cranlogs::cran_top_downloads(count = 5)$package
today <- Sys.Date() - 1
last_month <- today - 60

runApp(top5, today, last_month)

