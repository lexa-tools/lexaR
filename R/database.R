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
  dir.create(path, FALSE, TRUE)

  init_config(path, name)
  init_lexicon(path)
  init_grammar(path)
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
  if (
    !stringr::str_ends(path, "_lexadb/?") |
    !file.exists(file.path(path, "config.yaml"))
  ) {
    cli::cli_abort("The provided path is not a Lexa database.")
  }

  config <- read_config(path)

  validated <- validate_db(path, config)

  if (any(!unlist(validated$valid))) {

    cli::cli_abort(
      c("The provided database is not a valid Lexa database. Problems:", validated$problems)
    )
  } else {
    cli::cli_alert_success("Database is valid.")
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
