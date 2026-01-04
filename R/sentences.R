# Add collection ----

#' Add text to database
#'
#' This function creates a new text in the database, i.e. a new empty text
#' skeleton is written to disk, in the `texts/` directory, for the user
#' to edit at will.
#'
#' @param lexadb A `lexadb` object (created with \code{\link{load_lexadb}})
#' @param title The text title as a string.
#'
#' @return Nothing. Used for its side effects
#' @export
add_collection <- function(lexadb,
                      title = NULL) {

  cl_entry <- construct_collection(
    lexadb,
    title = title
  )

  write_collection(lexadb, cl_entry)
  cli::cli_alert_success("Text {cli::col_blue(cl_entry$id)} added to the texts!")
}




