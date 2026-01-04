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
  db_path <- attr(x, "meta")$path

  lexicon <- read_lexicon(db_path)
  lexicon_length <- length(lexicon)

  collections <- read_collections(db_path)
  collections_length <- length(collections)

  mcats <- table(unlist(lapply(lexicon, function(x) x$morph_category)))
  mcats_length <- length(mcats)

  if (mcats_length > 0) {
    names(mcats) <- paste0("{crayon::red('", stringr::str_to_sentence(names(mcats)), ":')}")
    cats <- "{crayon::red(cli::symbol$circle_filled)} Categories {crayon::green(cli::symbol$arrow_right)} "
    for (cat_i in 1:mcats_length) {
      cats <- paste(cats, names(mcats)[cat_i], mcats[[cat_i]])
      if (cat_i < mcats_length) {
        cats <- paste(cats, crayon::green('|'))
      }
    }
  } else {
    cats <- "{crayon::red(cli::symbol$circle_filled)} Categories {crayon::green(cli::symbol$arrow_right)} "
  }


  mtypes <- table(unlist(lapply(lexicon, function(x) x$morph_type)))
  mtypes_length <- length(mtypes)

  if (mtypes_length > 0) {
    names(mtypes) <- paste0("{crayon::red('", stringr::str_to_sentence(names(mtypes)), "s:')}")
    types <- "{crayon::red(cli::symbol$circle_filled)} Morpheme types {crayon::green(cli::symbol$arrow_right)} "
    for (type_i in 1:mtypes_length) {
      types <- paste(types, names(mtypes)[type_i], mtypes[[type_i]])
      if (type_i < mtypes_length) {
        types <- paste(types, crayon::green('|'))
      }
    }
  } else {
    types <- "{crayon::red(cli::symbol$circle_filled)} Morpheme types {crayon::green(cli::symbol$arrow_right)} "
  }


  poses <- table(unlist(lapply(lexicon, function(x) x$part_of_speech)))
  poses_length <- length(poses)

  if (poses_length > 0) {
    names(poses) <- paste0("{crayon::red('", stringr::str_to_sentence(names(poses)), "s:')}")
    pos <- "{crayon::red(cli::symbol$circle_filled)} POS {crayon::green(cli::symbol$arrow_right)} "
    for (pos_i in 1:poses_length) {
      pos <- paste(pos, names(poses)[pos_i], poses[[pos_i]])
      if (pos_i < poses_length) {
        pos <- paste(pos, crayon::green('|'))
      }
    }
  } else {
    pos <- "{crayon::red(cli::symbol$circle_filled)} POS {crayon::green(cli::symbol$arrow_right)} "
  }


  cli::cli_h1("Database info")
  cli::cli_text(
    "{crayon::green(cli::symbol$circle_filled)} {crayon::blue('Name:')}
    {x$config$name}"
  )
  cli::cli_text(
    "{crayon::green(cli::symbol$info)} {crayon::blue('Entries:')}
    {lexicon_length}
    {crayon::green('|')}
    {crayon::blue('Collections:')} {collections_length}"
  )
  cli::cli_h2("Lexicon breakdown")
  cli::cli_text(cats)
  cli::cli_text(types)
  cli::cli_text(pos)
}
