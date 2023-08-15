#' module1 UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_module1_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      # Text input for species
      textInput(ns("species"), "Enter species:"),

      # Text input for organism
      textInput(ns("organism"), "Enter organism:"),

      # Submit button
      actionButton(ns("submit"), "Submit"),

      # Table to display the data
      tableOutput(ns("my_table"))
    )
  )
}

#' module1 Server Functions
#'
#' @noRd
mod_module1_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    # Connect to the SQLite database
    # con <- dbConnect(RSQLite::SQLite(), dbname = "workflow/data/01-import/olddel/PDUI.sqlite")
    #
    # # This is a reactive expression, so it will re-run whenever any reactive inputs it references change
    # data <- eventReactive(input$submit, {
    #   query <- paste0("SELECT * FROM pdui WHERE species = '", input$species, "' AND organism = '", input$organism, "'")
    #   res <- dbSendQuery(con, query)
    #   df <- dbFetch(res)
    #   dbClearResult(res)
    #   df
    # })
    #
    # # Use the data in a render function to display it in the UI
    # output$my_table <- renderTable({
    #   head(data())
    # })
    #
    # # Disconnect from the database when the session ends
    # session$onSessionEnded(function() {
    #   dbDisconnect(con)
    # })
  })
}

## To be copied in the UI
# mod_module1_ui("module1_1")

## To be copied in the server
# mod_module1_server("module1_1")
