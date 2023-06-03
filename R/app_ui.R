#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      h1("DevAPAdb")
    )
  )
}


#' #' The application User-Interface
#' #'
#' #' @param request Internal parameter - do not change
#' #'
#' #' @importFrom shinydashboard dashboardPage dashboardHeader dashboardSidebar dashboardBody
#' #' @importFrom shinydashboard sidebarMenu menuItem tabItems
#' #' @importFrom shiny tags
#' #'
#' #' @noRd
#' app_ui <- function(request){
#'   shiny::tagList(
#'     golem_add_external_resources(),
#'     shinydashboard::dashboardPage(
#'       shinydashboard::dashboardHeader(title = "My Golem App"),
#'       shinydashboard::dashboardSidebar(
#'         shinydashboard::sidebarMenu(
#'           shinydashboard::menuItem("Tab 1", tabName = "tab1"),
#'           shinydashboard::menuItem("Tab 2", tabName = "tab2")
#'         )
#'       ),
#'       shinydashboard::dashboardBody(
#'         shinydashboard::tabItems(
#'           shinydashboard::tabItem("tab1", "Content for Tab 1"),
#'           shinydashboard::tabItem("tab2", "Content for Tab 2")
#'         )
#'       )
#'     )
#'   )
#' }



#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "DevAPAdb"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
