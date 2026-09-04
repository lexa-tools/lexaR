# Print methods ----

#' Print method for Lexa databases
#'
#' Print method for objects of class `lexadb`, which prints database info and
#' statistics.
#'
#' @param x An object of class `lexadb`.
#' @param ... Arguments passed to print.
#'
#' @return Nothing. Used for its side effects.
#' @export
#'
print.lexadb <- function(x, ...) {
  db_path <- attr(x, "metadata")$dbpath

  lexicon <- x$lexicon
  lexicon_length <- length(lexicon)

  wtypes <- table(unlist(lapply(lexicon, function(x) x$word_type)))
  wtypes_length <- length(wtypes)

  if (wtypes_length > 0) {
    names(wtypes) <- paste0("{crayon::red('", stringr::str_to_sentence(names(wtypes)), ":')}")
    types <- "{crayon::red(cli::symbol$circle_filled)} Word types {crayon::green(cli::symbol$arrow_right)} "
    for (type_i in 1:wtypes_length) {
      types <- paste(types, names(wtypes)[type_i], wtypes[[type_i]])
      if (type_i < wtypes_length) {
        types <- paste(types, crayon::green('|'))
      }
    }
  } else {
    types <- "{crayon::red(cli::symbol$circle_filled)} Types {crayon::green(cli::symbol$arrow_right)} "
  }

  wclass <- table(unlist(lapply(lexicon, function(x) x$word_class)))
  wclass_length <- length(wclass)

  if (wclass_length > 0) {
    names(wclass) <- paste0("{crayon::red('", stringr::str_to_sentence(names(wclass)), ":')}")
    classes <- "{crayon::red(cli::symbol$circle_filled)} Word classes {crayon::green(cli::symbol$arrow_right)} "
    for (class_i in 1:wclass_length) {
      classes <- paste(classes, names(wclass)[class_i], wclass[[class_i]])
      if (class_i < wclass_length) {
        classes <- paste(classes, crayon::green('|'))
      }
    }
  } else {
    classes <- "{crayon::red(cli::symbol$circle_filled)} Classes {crayon::green(cli::symbol$arrow_right)} "
  }

  cli::cli_h1("Database info")
  cli::cli_text(
    "{crayon::green(cli::symbol$circle_filled)} {crayon::blue('Name:')}
    {x$metadata$name}"
  )
  cli::cli_text(
    "{crayon::green(cli::symbol$circle_filled)} {crayon::blue('Author:')}
    {x$metadata$author}"
  )
  cli::cli_text(
    "{crayon::green(cli::symbol$info)} {crayon::blue('Entries:')}
    {lexicon_length}"
  )
  cli::cli_h2("Lexicon breakdown")
  cli::cli_text(types)
  cli::cli_text(classes)
}

#' Print method for lexemes
#'
#' Print method for objects of class `lexalx`, which prints lexeme info.
#'
#' @param x An object of class `lexalx`.
#' @param ... Arguments passed to print.
#'
#' @return Nothing. Used for its side effects.
#' @export
print.lexalx <- function(x, ...) {
  n_senses <- length(x$senses)
  lexeme <- x$lexeme

  if (is.character(lexeme)) {
    lexeme_part <- "{crayon::blue(lexeme)}"
  } else {
    if (is.character(lexeme[[writing]])) {
      lexeme_part <- "{crayon::blue(lexeme[[writing]])}"
    } else {
      lexeme_tr <- lexeme[[writing]][["transcription"]]
      if (is.null(lexeme_tr)) {
        lexeme_tr <- lexeme[[writing]][["transliteration"]]
      }
      lexeme_part <- "{crayon::blue(lexeme[[writing]][['text']])} {crayon::blue(paste0('(', lexeme_tr, ')'))}"
    }
  }

  phonemic <- if (!is.null(x$phonemic)) x$phonemic[[1]] else NULL
  phonetic <- if (!is.null(x$phonetic)) x$phonetic[[1]] else NULL

  pronunciation <- paste0(
    if (!is.null(phonemic)) paste0("/", phonemic, "/") else "",
    if (!is.null(phonetic)) paste0(" [", phonetic, "]") else ""
  )

  lexeme_line <- paste(
    lexeme_part,
    pronunciation,
    "{.emph {crayon::green(x$word_class)}}"
  )

  if (!is.null(x$grammatical_features)) {
    lexeme_line <- paste(lexeme_line, "({x$grammatical_features})")
  }

  cli::cli_h1("Entry {x$id}")
  cli::cli_text(lexeme_line)

  cli::cli_h2("Senses")
  for (sense in 1:length(x$senses)) {
    definitions <- x$senses[[sense]]$definition
    if (length(definitions) > 1) {
      definitions_langs <- names(definitions)
      definitions[[the_language]] <- NULL
      definition_part <- paste(definitions, collapse = ". ")
    } else {
      definition_part <- definitions[[1]]
    }
    if (!is.null(x$senses[[sense]]$grammatical_features)) {
      cli::cli_text("{cli::col_red(sense, '.')}
        {crayon::blue('(', x$senses[[sense]]$grammatical_features, ')', sep = '')}
        {definition_part}")
    } else {
      cli::cli_text("{cli::col_red(sense, '.')} {definition_part}")
    }
    if (!is.null(x$senses[[sense]]$examples)) {
      d <- cli::cli_div(
        class = "example",
        theme = list(.example = list(`margin-left` = 10))
      )
      cli::cli_h3("Examples")
      for (example in x$senses[[sense]]$examples) {
        cli::cli_text(
          "{cli::symbol$bullet} {crayon::blue(example$sentence)} {example$translation}"
        )
      }
      cli::cli_end(d)
    }
  }

  if (!is.null(x$etymology)) {
    cli::cli_h2("Etymology")
    cli::cli_div(theme = list(span.etym = list(
      `font-style` = "italic",
      color = "blue"
    )))
    cli::cli_text(markdown_to_cli(x$etymology))
    cli::cli_end()
  }

  cli::cli_h2("Grammatical info")
  cli::cli_text("{crayon::red('Type:')} {x$word_type}")
  cli::cli_text("{crayon::red('Class:')} {x$word_class}")

  if (!is.null(x$notes)) {
    cli::cli_h2("Notes")
    cli::cli_ul(x$notes)
  }

}

#' Print method for list of entries
#'
#' Print method for the output of `search_lexicon()`, which returns an object
#'    of class `lexalxs`.
#'
#' @param x An object of class `lexalxs`.
#' @param ... Arguments passed to print.
#'
#' @return Nothing. Used for its side effects.
#' @export
print.lexalxs <- function(x, ...) {
  purrr::walk(x, function(i) print.lexalx(i))
}

#' Compact print method for list of entries
#'
#' Compact print method for the output of `search_lexicon()`, which returns an object
#'    of class `lexalxscompact` when `show_entry` is `FALSE`..
#'
#' @param x An object of class `lexalxscompact`.
#' @param ... Arguments passed to print.
#'
#' @return Nothing. Used for its side effects.
#' @export
print.lexalxscompact <- function(x, ...) {
  purrr::walk(
    x,
    function(i) {
      lexeme_line <- "{crayon::blue(i$lexeme)} {.emph {crayon::green(i$part_of_speech)}} {i$senses$se_01$definition} [{crayon::silver(i$id)}]"
      cli::cli_bullets(c("*" = lexeme_line))
    }
  )
}

markdown_to_cli <- function(x) {
  x <- gsub("\\*\\*(.*?)\\*\\*", "{cli::style_bold('\\1')}", x)
  x <- gsub("\\*(.*?)\\*", "{cli::style_italic('\\1')}", x)
  x <- gsub("_(.*?)_", "{cli::style_italic('\\1')}", x)
  x
}
