#' Create a new Lexa database
#'
#' @param name Name of the Lexa database (the `.yaml` extension will be appended to the name automatically).
#' @param parent Parent directory (default is current working directory).
#'
#' @return Nothing. Used for its side effects.
#' @export
#'
#' @examples
#' \dontrun{
#' create_lexadb(name = "my_db")
#' }
create_lexadb <- function(name, parent = ".", author = NULL) {
  file <- paste0(name, ".yaml")
  path <- file.path(parent, file)

  if (file.exists(normalizePath(path, mustWork = FALSE))) {
    cli::cli_abort(c("x" = "LexaDB '{file}' already exists!"))
  }

  lexadb <- new_lexadb(name, author, schema_version = "0.0.0.9001")

  dir.create(parent, FALSE, TRUE)
  write_lexadb(lexadb, path)
  attr(lexadb, "dbpath") <- normalizePath(path)

  return(lexadb)

}


new_lexadb <- function(name, author, schema_version) {
  metadata <- list(
    schema = "lexadb",
    schema_version = schema_version,
    name = name,
    author = ifelse(is.null(author), Sys.info()[["user"]], author)
  )

  now <- format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")

  lexicon <- list(
    lx_000001 = list(
      id = "lx_000001",
      lexeme = "rat",
      word_type = "stem",
      word_class = "noun",
      senses = list(
        se_01 = list(
          id = "se_01",
          gloss = "rat",
          definition = "a sweet and very sociable rodent"
        )
      ),
      date_created = now,
      date_modified = now
    )
  )
  class(lexicon$lx_000001) <- c("lexalx")

  lexadb <- list(
    metadata = metadata,
    lexicon = lexicon
  )
  class(lexadb) <- c("lexadb", "list")

  return(lexadb)
}

write_lexadb <- function(lexadb, path) {
  yaml::write_yaml(lexadb, file.path(path))
}



construct_entry <- function(lexadb,
                    lexeme = NULL,
                    gloss = NULL,
                    word_type = NULL,
                    word_class = NULL,
                    phonemic = NULL,
                    phonetic = NULL,
                    morph_category = NULL,
                    morph_type = NULL,
                    definition = gloss,
                    etymology = NULL,
                    notes = NULL,
                    homophone = NULL) {

  # Write default examples if mandatory fields are NULL
  # Used when initialising lexadb
  if (is.null(lexeme)) {
    lexeme = "lexeme"
  }
  if (is.null(word_type)) {
    word_type = "stem"
  }
  if (is.null(word_class)) {
    word_class = "noun"
  }
  if (is.null(gloss)) {
    gloss = "lexeme"
  }

  if (!is.null(lexadb)) {
    db_path <- attr(lexadb, "meta")$path
    entries <- lapply(
      read_lexicon(db_path),
      function(entry) entry$lexeme
    )

    if (!is.null(lexeme)) {
      if (lexeme %in% entries) {
        homophones_n <- sum(entries == lexeme)
        cli::cli_alert_warning(
          cli::pluralize("{homophones_n} homophone{?s} found!")
        )
        cont <- usethis::ui_yeah(
          "Continue?",
          yes = "Yes",
          no = "No",
          shuffle = FALSE
        )

        if (!cont) {
          return(cli::cli_alert_warning("Entry not created!"))
        } else (
          homophone <- homophones_n + 1L
        )
      }
    }

    lx_id <- generate_lx_id(lexadb)
  } else {
    lx_id <- generate_lx_id(NULL)
  }

  today <- format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")

  # entry schema
  out <- list(
    id = lx_id,
    lexeme = lexeme,
    phonetic = phonetic,
    morph_category = morph_category,
    morph_type = morph_type,
    part_of_speech = part_of_speech,
    # inflectional_features = list(class = NULL),
    etymology = etymology,
    notes = notes,
    homophone = homophone,
    allomorphs = list(
      al_01 = list(
        id = "al_01",
        morph = lexeme,
        phonetic = phonetic
      )
    ),
    senses = list(
      se_01 = list(
        id = "se_01",
        gloss = gloss,
        definition = definition
      )
    ),
    date_created = today,
    date_modified = today
  )

  # Drop null fields
  out <- remove_null_fields(out)

  entry <- list(id = lx_id, out = out)
  return(entry)

}
