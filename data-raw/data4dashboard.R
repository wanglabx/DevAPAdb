## code to prepare `data4dashboard` dataset goes here

dpath <- "/Users/allen/github/rujinlong/pc020DevAPAdb/analyses/data/01-import"
df_pdui_anno <- fread(here(dpath, "pdui_anno.csv"))
df_pdui_abundance <- fread(here(dpath, "pdui_abundance.csv"))
df_pdui_metadata <- fread(here(dpath, "pdui_metadata.csv"))

data4dashboard <- list("anno" = df_pdui_anno,
                       "abundance" = df_pdui_abundance,
                       "meta" = df_pdui_metadata)

usethis::use_data(data4dashboard, overwrite = TRUE)
