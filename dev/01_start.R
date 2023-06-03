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

# finishing setup git
golem::use_utils_ui(with_test = TRUE)
golem::use_utils_server(with_test = TRUE)

# You're now set! ----
# go to dev/02_dev.R
rstudioapi::navigateToFile("dev/02_dev.R")
