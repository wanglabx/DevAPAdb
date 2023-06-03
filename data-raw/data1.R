## code to prepare `data1` dataset goes here

pdui <- readRDS("workflow/data/01-import/PDUI.rds")
usethis::use_data(pdui, overwrite = TRUE)
