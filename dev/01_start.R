# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
########################################
#### CURRENT FILE: ON START SCRIPT #####
########################################

## Fill the DESCRIPTION ----
## Add meta data about your application
##
## /!\ Note: if you want to change the name of your app during development,
## either re-run this function, call golem::set_golem_name(), or don't forget
## to change the name in the app_sys() function in app_config.R /!\
##
golem::fill_desc(
  pkg_name = "DevAPAdb", # The Name of the package containing the App
  pkg_title = "DevAPAdb: APA during Developmental Processes", # The Title of the package containing the App
  pkg_description = "This repo contains code and analyese for building the APA database of developmental processes.", # The Description of the package containing the App
  author_first_name = "Jinlong", # Your First Name
  author_last_name = "Ru", # Your Last Name
  author_email = "jinlong.ru@gmail.com", # Your Email
  repo_url = "https://github.com/rujinlong/DevAPAdb",
  pkg_version = "0.0.1" # The Version of the package containing the App
)

## Set {golem} options ----
golem::set_golem_options()
usethis::use_gpl3_license()
usethis::use_readme_rmd(open = FALSE)
usethis::use_code_of_conduct(contact = "jinlong.ru@gmail.com")
usethis::use_git()

## Use git ----
usethis::use_git()

## Init Testing Infrastructure ----
## Create a template for tests
golem::use_recommended_tests()

## Favicon ----
# If you want to change the favicon (default is golem's one)
golem::use_favicon() # path = "path/to/ico". Can be an online file.
# golem::remove_favicon() # Uncomment to remove the default favicon

## Add helper functions ----
golem::use_utils_ui(with_test = TRUE)
golem::use_utils_server(with_test = TRUE)

# You're now set! ----

# go to dev/02_dev.R
rstudioapi::navigateToFile("dev/02_dev.R")
