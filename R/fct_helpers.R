#' Create a tidy data.frame from the PDUi output
#'
#' @description This function takes the output from PDUi and creates a tidy data.frame.
#'
#' @param row_data A list of data.frames, where the first element is the PDUi output and the second element is the metadata.
#' @param symbol2ensembl A data.frame with two columns, Gene_symbol and Ensembl_id.
#' @importFrom dplyr mutate select rename_with
#' @importFrom tidyr separate_wider_delim
#' @importFrom data.table setnames
#' @importFrom stringr str_replace_all
#' @importFrom magrittr '%>%'
#'
#' @return The return value, if any, from executing the function.
#'
#' @examples
#' @noRd
#' @export
create_tbl_apa <- function(row_data, symbol2ensembl) {
    update_genes <- function(data, s2e, column) {
        tax_check <- any(s2e$Tax_id == unique(data$tax_id))
        if (tax_check) {
            gene_names <- setNames(s2e$Ensembl_id, s2e$Gene_symbol)
            data[column] <- ifelse(data$gene %in% names(gene_names), gene_names[data$gene], "-")
        } else {
            data[column] <- "-"
        }
        return(data)
    }

    pdui_value <- row_data[["pdui"]] %>%
        dplyr::mutate(transcript = str_replace_all(Gene, "\\|.*", "")) %>%
        dplyr::select(-c("Predicted_Proximal_APA", "Loci", "chromosome", "fit_value", "Gene")) %>%
        column_to_rownames("transcript")

    pdui <- row_data[["pdui"]] %>%
        dplyr::select(c("Gene", "Predicted_Proximal_APA", "Loci")) %>%
        tidyr::separate_wider_delim(Gene, "|", names = c("transcript", "gene", "chr", "strand")) %>%
        dplyr::mutate(
            Site_ID = paste(chr, Predicted_Proximal_APA, strand, sep = "|"),
            `3'UTR` = gsub(".*:", "", Loci),
            PAS_cluster = ifelse(strand == "-",
                paste(gsub("-.*", "", `3'UTR`), Predicted_Proximal_APA, sep = "-"),
                paste(Predicted_Proximal_APA, gsub(".*-", "", `3'UTR`), sep = "-")
            ),
            tax_id = unique(row_data[["metadata"]][["tax_id"]]),
            species = unique(row_data[["metadata"]][["sci_name"]])
        )

    if (length(grep("^EN", pdui$gene)) < 0.9 * nrow(pdui)) {
        pdui <- update_genes(pdui, symbol2ensembl, "ensembl")
    } else {
        pdui <- update_genes(pdui, symbol2ensembl, "symbol")
    }

    pdui <- pdui %>%
        dplyr::rename_with(~ ifelse(any(names(pdui) == "symbol"), "ensemble", "symbol"), .cols = "gene") %>%
        dplyr::select(c("species", "tax_id", "symbol", "ensembl", "transcript", "Site_ID", "3'UTR", "PAS_cluster", "Predicted_Proximal_APA")) %>%
        data.table::setnames(c("Species", "Tax_ID", "Gene_Symbol", "Ensembl_ID", "Transcript_ID", "Site_ID", "3'UTR", "PAS_cluster", "PAS"))

    return(list(
        "pdui_anno" = pdui,
        "pdui_value" = pdui_value
    ))
}



#' Import metadata, salmon quant results, and dapars2 results for a given species
#'
#' @param fin_meta File path to metadata file
#' @param species_name Name of the species to import data for
#' @param nfpath File path to directory containing salmon and dapars2 results
#'
#' @return A list containing metadata, salmon quant results, and dapars2 results
#'
#' @importFrom openxlsx read.xlsx
#' @importFrom data.table setnames fread
#' @importFrom dplyr select mutate
#' @importFrom here here
#' @importFrom readr read_rds
#' @importFrom stringr str_replace
#'
#' @examples
#' @noRd
#' @export
import_nf <- function(fin_meta, species_name, nfpath) {
    rst <- list()

    # Read metadata
    df_meta <- openxlsx::read.xlsx(fin_meta, sheet = species_name) %>%
        dplyr::select(-fastq_ftp) %>%
        data.table::setnames(colnames(.), c("sample_id", "study_acc", "tax_id", "sci_name", "tissue", "sex", "dev_stage", "sample_title")) %>%
        dplyr::mutate(species = species_name)

    # Read salmon quant results
    rst_salmon <- readRDS(here(nfpath, paste0(species_name, "_salmon.rds")))

    # Read dapars2 results
    rst_pdui <- data.table::fread(here(nfpath, paste0(species_name, "_dapars2.tsv"))) %>%
        data.table::setnames(colnames(.), stringr::str_replace(colnames(.), "_T[12]_PDUI", "")) %>%
        dplyr::select(-chromosome)

    return(list(
        "metadata" = df_meta,
        "salmon" = rst_salmon,
        "pdui" = rst_pdui
    ))
}




#' Pivot longer function with custom names for column names
#'
#' This function pivots a data frame from wide to long format using the specified
#' column names for the values and names columns.
#'
#' @param df A data frame to pivot
#' @param values_to The name of the column to use for the values column in the long format
#' @param names_to The name of the column to use for the names column in the long format

#' @return A data frame in long format
#'
#' @importFrom tidyr pivot_longer
#' @importFrom tibble rownames_to_column
#' @importFrom magrittr '%>%'
#'
#' @examples
#' @export
#' @noRd
pivot_longer2 <- function(df, values_to, names_to = "transcript_id") {
    df_long <- df %>%
        t() %>%
        data.frame() %>%
        tibble::rownames_to_column("sample_id") %>%
        tidyr::pivot_longer(cols = -sample_id, values_to = values_to, names_to = names_to)

    return(df_long)
}
