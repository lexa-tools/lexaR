#' Create a new Lexa database
#'
#' @param parent Parent directory (default is current working directory).
#' @param name Name of the Lexa database (`_lexadb` will be appended to the
#'   name).
#'
#' @return Nothing. Used for its side effects.
#' @export
#'
#' @examples
#' \dontrun{
#' create_lexadb(parent = "./", name = "my_new")
#' }
create_lexadb <- function(parent = ".", name) {
  name_db <- paste0(name, "_lexadb")
  path <- file.path(parent, name_db)

  if (dir.exists(path)) {
    cli::cli_abort("LexaDB '{name_db}' already exists!")
  }
  
  dir.create(path, FALSE, TRUE)

  init_config(path, name)
  init_lexicon(path)
  init_collections(path)
}

#' Load Lexa database
#'
#' It loadds a Lexa database from the specified path. The path is the directory
#' containing the database.
#'
#' @param path The path to the database as a string.
#'
#' @return A `lexadb` object.
#' @export
#'
#' @examples
#' db_path <- system.file("extdata/albanian_lexadb", package = "lexaR")
#' albanian <- load_lexadb(db_path)
#' albanian
#'
load_lexadb <- function(path) {
  if (!file.exists(file.path(path, "config.yaml"))) {
    cli::cli_abort(
      c("There is no {.file config.yaml}.", "x" = "LexaDB not loaded.")
    )  
  }

  config <- read_config(path)

  # Do not go past this if the schema version is unknown
  if (!(config$schema_version %in% c("0.0.0.9000"))) {
    cli::cli_abort(c("LexaDB schema version not recognised: {config$schema_version}.", "x" = "LexaDB not loaded."))
  }

  config_val <- validate_config(config)

  if (!config_val) {
    cli::cli_abort(c("{.file config.yaml} is not valid.", "x" = "LexaDB not loaded."))
  }

  cli::cli_alert_info("Loading: {.strong {config$name}}")

  lexadb <- list(
    config = config
  )

  class(lexadb) <- c("lexadb", "list")
  attr(lexadb, "meta") <- list(
    path = normalizePath(path)
  )

  lx_val <- validate_lexicon(lexadb)
  if (any(!unlist(lx_val))) {
    invalid_ids <- names(lx_val[lx_val == FALSE])
    cli::cli_alert_danger("The lexicon has entries that do not match the expected schema:")
    cli::cli_li(invalid_ids)
  } else {
    cli::cli_alert_success("Lexicon is valid.")
  }

  cl_val <- validate_collections(lexadb)
  if (any(!unlist(cl_val))) {
    invalid_ids <- names(cl_val[cl_val == FALSE])
    cli::cli_alert_danger("The collections have entries that do not match the expected schema:")
    cli::cli_li(invalid_ids)
  } else {
    cli::cli_alert_success("Collections are valid.")
  }

  return(lexadb)
}
