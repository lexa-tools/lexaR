# Lexa read functions ----

read_lexadb <- function(path) {
  lexadb <- yaml::read_yaml(path)
  attr(lexadb, "dbpath") <- path
  structure(lexadb, class = c("lexadb", "list"))

  validation <- validate_lexadb(lexadb)

  if (!validation) {
    cli::cli_alert_danger("The lexadb does not match the expected schema.")
    validation_tbl <- tibble::as_tibble(attr(validation, "errors")[,c("instancePath", "message")])
    validation_tbl <- dplyr::rename(validation_tbl, path = instancePath, problem = message)
    print(validation_tbl)
    return(validation_tbl)
  }

  lx_names <- grep("^lx_[0-9]+$", names(lexadb), value = TRUE)
  lexadb <- list(
    metadata = lexadb$metadata,
    lexicon = lexadb[lx_names]
  )

  return(lexadb)
}
