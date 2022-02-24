#' @importFrom keyring key_set_with_value key_get
#' @importFrom shinymanager create_db

# Credentials database ----------------------------------------------------

credentials <- data.frame(
  user = c("shiny_user", "shiny_admin"),
  password = c("userpassword", "adminpassword"),
  # Password will automatically be hashed
  admin = c(FALSE, TRUE),
  stringsAsFactors = FALSE
)

# Set database key --------------------------------------------------------

key_set_with_value(service = "shinymanager_key", username = "yang_wu", password = "credentials_db_password")

# Create SQLite database --------------------------------------------------

create_db(
  credentials_data = credentials,
  sqlite_path = "credentials_database.sqlite",
  passphrase = key_get(service = "shinymanager_key", username = "yang_wu")
)
