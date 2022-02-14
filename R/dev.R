if (interactive()) {
  library(shiny)
  library(bs4Dash)
  
  shinyApp(
    ui = dashboardPage(
      header = dashboardHeader(),
      sidebar = dashboardSidebar(),
      body = dashboardBody(
        actionButton(inputId = "controlbarToggle", label = "Toggle Controlbar")
      ),
      controlbar = dashboardControlbar(
        id = "controlbar",
        collapsed = FALSE,
        overlay = TRUE
      ),
      title = "updateControlbar"
    ),
    server = function(input, output, session) {
      observeEvent(input$controlbar, {
        if (input$controlbar) {
          showModal(modalDialog(
            title = "Alert",
            "The controlbar is opened.",
            easyClose = TRUE,
            footer = NULL
          ))
        }
      })
      
      observeEvent(input$controlbarToggle, {
        updateControlbar(id = "controlbar", session = session)
      })
      
      observe({
        print(input$controlbar)
      })
    }
  )
}

