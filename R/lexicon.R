# Add entry ----

#' Add entry to lexicon
#'
#' This function creates a new entry in the lexicon, i.e. a new empty entry
#' skeleton is written to disk, in the `lexicon/` directory, for the user
#' to edit at will.
#'
#' @param lexadb A `lexadb` object (created with \code{\link{load_lexadb}}).
#' @param lexeme The entry as a string.
#' @param gloss The gloss as a string.
#' @param part_of_speech The part of speech as a string.
#' @param phonetic The phonetic transcription as a string.
#' @param morph_category The morphosyntactic category as a string
#'    (`"lexical"` or `"grammatical"`).
#' @param morph_type The type of morpheme as a string.
#' @param definition The definition of the entry as a string.
#' @param etymology The etymology of the entry as a string.
#' @param notes Further notes as a string.
#' @param homophone The homophone numeric index.
#' @param edit Open file for editing after creation (default is `TRUE`)
#'
#' @return Nothing. Used for its side effects
#' @export
add_entry <- function(lexadb,
                      lexeme = NULL,
                      gloss = NULL,
                      part_of_speech = NULL,
                      phonetic = NULL,
                      morph_category = NULL,
                      morph_type = NULL,
                      definition = gloss,
                      etymology = NULL,
                      notes = NULL,
                      homophone = NULL,
                      edit = TRUE) {

  lx_entry <- construct_entry(
    lexadb,
    lexeme = lexeme,
    gloss = gloss,
    part_of_speech = part_of_speech,
    phonetic = phonetic,
    morph_category = morph_category,
    morph_type = morph_type,
    definition = definition,
    etymology = etymology,
    notes = notes,
    homophone = homophone
  )

  write_entry(lexadb, lx_entry)
  cli::cli_alert_success("Entry {cli::col_blue(lx_entry$id)} added to the lexicon!")

  if (edit) {
    edit_entry(lexadb, lx_entry$id)
  }
}

# Open and edit entries ----

#' Open a lexical entry
#'
#' It opens the file of the specified lexical entry.
#'
#' @param lexadb   A `lexadb` object (created with \code{\link{load_lexadb}}).
#' @param entry_id A string with the entry id (the `lx_` prefix and leading
#'        zeros can be omitted.)
#'
#' @return Nothing. Used for its side effects
#' @export
open_entry <- function(lexadb, entry_id) {
  db_path <- attr(lexadb, "meta")$path

  if (!stringr::str_detect(entry_id, "lx")) {
    entry_id <- stringr::str_pad(entry_id, 6, "left", "0")
    entry_id <- paste0("lx_", entry_id)
  }

  lx_path <- file.path(
    normalizePath(db_path), "lexicon",
    paste0(entry_id, ".yaml")
  )

  if (file.exists(lx_path)) {
    usethis::edit_file(lx_path)
  } else {
    cli::cli_abort("Sorry, there is no entry with the given id!")
  }
}

#' Edit a lexical entry
#'
#' It opens the file of the specified lexical entry for editing and updates the `date_modified` field.
#'
#' @param lexadb   A `lexadb` object (created with \code{\link{load_lexadb}}).
#' @param entry_id A string with the entry id (the `lx_` prefix and leading
#'        zeros can be omitted.)
#'
#' @return Nothing. Used for its side effects
#' @export
edit_entry <- function(lexadb, entry_id) {
  db_path <- attr(lexadb, "meta")$path

  if (!stringr::str_detect(entry_id, "lx")) {
    entry_id <- stringr::str_pad(entry_id, 6, "left", "0")
    entry_id <- paste0("lx_", entry_id)
  }

  lx_path <- file.path(
    normalizePath(db_path), "lexicon",
    paste0(entry_id, ".yaml")
  )

  if (file.exists(lx_path)) {
    lx_yaml <- yaml::read_yaml(normalizePath(lx_path))
    lx_yaml$date_modified <- as.character(Sys.time())
    yaml::write_yaml(lx_yaml, lx_path)
    usethis::edit_file(lx_path)
  } else {
    cli::cli_abort("Sorry, there is no entry with the given id!")
  }
}

# Merge and split lexicon ----

# Merge individual yaml entries to single list
merge_lexicon <- function(lexadb, sort) {
  db_path <- attr(lexadb, "meta")$path
  lx_path <- glue::glue("{db_path}/lexicon")
  lx_files <- list.files(lx_path, "*.yaml", full.names = TRUE)

  lexicon <- list()

  for (file in lx_files) {
    file_yaml <- yaml::read_yaml(file)
    lexicon[[file_yaml$id]] <- file_yaml
  }

  # Sorting entries alphabetically
  if (sort) {
    entry_ids <- sapply(lexicon, function(entry) entry$lexeme)
    ordered_ids <- names(lexicon)[order(entry_ids)]

    # Reorder the list based on the ordered names
    lexicon_reordered <- lexicon[ordered_ids]

    return(lexicon_reordered)
  } else {
    return(lexicon)
  }
}

#' Write merged lexicon to disk
#'
#' It writes a yaml file which contains all the entries in the lexicon. The file
#' is output in the `src` directory.
#'
#' @param lexadb A `lexadb` object (created with \code{\link{load_lexadb}}).
#' @param sort Whether to sort the entries alphabetically (default is `TRUE`).
#' @param overwrite Whether to overwrite an existing `lexicon.yaml` file.
#'
#' @export
write_merged_lexicon <- function(lexadb, sort = TRUE, overwrite = FALSE) {
  merged <- merge_lexicon(lexadb, sort = sort)

  db_path <- attr(lexadb, "meta")$path
  merged_file <- glue::glue("{db_path}/src/lexicon.yaml")

  if (file.exists(merged_file)) {
    if (overwrite) {
      yaml::write_yaml(merged, merged_file)
    } else {
      cli::cli_abort(c(
        "x" = "A lexicon.yaml file already exists! Set {.arg overwrite = TRUE} to overwrite."
      ))
    }
  } else {
    dir.create(glue::glue("{db_path}/src"), showWarnings = FALSE)
    yaml::write_yaml(merged, merged_file)
  }

}
