library(shiny)
library(shinymanager)
library(DT)

# UI ----------------------------------------------------------------------

ui <- fluidPage(
  selectInput(
    inputId = "dataset",
    label = "Dataset",
    choices = c(
      "airquality", "anscombe", "attenu", "attitude", "beaver1", "beaver2", "BOD", "cars",
      "ChickWeight", "chickwts", "CO2", "DNase", "esoph", "faithful", "Formaldehyde", "freeny",
      "Indometh", "infert", "InsectSprays", "iris", "LifeCycleSavings", "Loblolly", "longley",
      "morley", "mtcars", "npk", "Orange", "OrchardSprays", "PlantGrowth", "pressure", "Puromycin",
      "quakes", "randu", "rock", "sleep", "stackloss", "swiss", "Theoph", "ToothGrowth", "trees",
      "USArrests", "USJudgeRatings", "warpbreaks", "women"
    )
  ),
  DTOutput(outputId = "table")
)

# Secure app --------------------------------------------------------------

ui <- secure_app(
  ui,
  enable_admin = TRUE,
  # Top
  tags_top =
    tags$div(
      # The <h4> tag defines the fourth level heading
      tags$h3("Welcome to", style = "align:center"),
      tags$img(
        src = "auth_portal.png", width = 100
      )
    ),
  # Bottom
  tags_bottom = tags$div(
    tags$p(
      "For any question, please contact the",
      tags$a(
        href = "mailto:yangwu2020@gmail.com?subject=Shiny%20aManager",
        target = "_top", "administrator"
      )
    )
  ),
  # Background
  background = "linear-gradient(315deg, #ffffff 0%, #d7e1ec 74%);"
)

# Server ------------------------------------------------------------------

server <- function(input, output, session) {

  # Check_credentials directly on sqlite database
  auth <- secure_server(
    check_credentials = check_credentials(
      db = "credentials_database.sqlite",
      passphrase = "credentials_db_password"
    )
  )

  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })

  output$table <- renderDT({
    datatable(
      data = dataset(),
      extensions = "Buttons",
      options = list(
        scroller = TRUE,
        dom = "Blfrtip",
        buttons = list(
          "copy",
          "print",
          list(
            extend = "collection",
            buttons = list(
              list(extend = "csv", filename = "topline"),
              list(extend = "excel", filename = "topline"),
              list(extend = "pdf", filename = "topline")
            ),
            text = "Download"
          )
        ),
        lengthMenu = list(c(10, -1), c(10, "All"))
      ),
      rownames = FALSE
    )
  })
}

# Run the application
shinyApp(ui = ui, server = server)
