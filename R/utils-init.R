# Lexa init functions ----
# These functions initialise different parts of a Lexa database. They are used
# when creating a new Lexa database with `create_lexadb()`.



init_lexicon <- function(path) {
  dir.create(file.path(path, "lexicon"), FALSE, TRUE)

  lx_entry <- construct_entry(NULL)
  yaml::write_yaml(lx_entry$out, file.path(path, "lexicon", "lx_000001.yaml"))
}

init_grammar <- function(path) {
  grammar <- list()
  yaml::write_yaml(grammar, file.path(path, "grammar.yaml"))
}

init_collections <- function(path) {
  dir.create(file.path(path, "collections"), FALSE, TRUE)
  cl_example <- construct_collection()
  yaml::write_yaml(cl_example$out, file.path(path, "collections", "cl_000001.yaml"))
}

# Write entry helpers ----
#
# The following are helper functions used when creating a new lexical entry.

# Prepare empty entry skeleton.
# Outputs a list with entry id (`id`) and output list (`out`).




# Remove null fields

remove_null_fields <- function(x) {
  if (is.list(x)) {
    # Following commented line makes no sense
    # x <- lapply(x, remove_nulls_and_empty)
    x <- x[!sapply(x, function(y) is.null(y) || (is.list(y) && length(y) == 0))]
  }
  x
}

# Prepare empty collection skeleton.
# Outputs a list with collection id (`id`) and output string (`out`).

construct_collection <- function(lexadb = NULL, title = NULL) {
  cl_id <- ifelse(is.null(lexadb), "cl_000001", generate_cl_id(lexadb))

  out <- list(
    id = cl_id,
    title = title,
    sentences = list(
      st_000001 = list(
        id = "st_000001",
        sentence = NULL,
        morphemes = NULL,
        gloss = NULL,
        phonetic = NULL,
        translation = NULL
      )
    )
  )

  collection <- list(id = cl_id, out = out)
  return(collection)
}
