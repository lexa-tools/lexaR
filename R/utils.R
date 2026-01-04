# Check last entry ID and increase hex by 1.

generate_lx_id <- function(lexadb) {
  db_path <- attr(lexadb, "meta")$path
  lx_files <- list.files(file.path(db_path, "lexicon"), pattern = "*.yaml")
  if (length(lx_files) > 0) {
    last_id <- as.integer(
      as.hexmode(stringr::str_sub(lx_files[[length(lx_files)]], 4, 9))
    )
    new_id_n <- last_id + 1
    new_id_hex <- format(as.hexmode(new_id_n), width = 6)
    new_id <- paste0("lx_", new_id_hex)
  } else {
    new_id <- "lx_000001"
  }
  return(new_id)
}

# Check last collection ID and increase hex by 1.

generate_cl_id <- function(lexadb) {
  db_path <- attr(lexadb, "meta")$path
  cl_files <- list.files(file.path(db_path, "collections"), pattern = "*.yaml")
  if (length(cl_files) > 0) {
    last_id <- as.integer(
      as.hexmode(stringr::str_sub(cl_files[[length(cl_files)]], 4, 9))
    )
    new_id_n <- last_id + 1
    new_id_hex <- format(as.hexmode(new_id_n), width = 6)
    new_id <- paste0("cl_", new_id_hex)
  } else {
    new_id <- "cl_000001"
  }
  return(new_id)
}

validate_db <- function(path, config = NULL) {
  if (is.null(config)) {
    config <- read_config(path)
  }

  if (config$schema_version == "0.0.0.9000") {
    valid <- list(
      schema = config$schema == "lexadb",
      lexicon = dir.exists(file.path(path, "lexicon")),
      collections = dir.exists(file.path(path, "collections")),
      morphology = file.exists(file.path(path, "morphology.yaml"))
    )

    messages <- c(
      x = "The schema is not {.file lexadb}.",
      x = "{.file lexicon/} is missing.",
      x = "{.file collections/} is missing.",
      x = "{.file morphology.yaml} is missing."
    )

    problems <- messages[!unlist(valid)]

    return(list(valid = valid, problems = problems))
  } else {
    cli::cli_abort("Lexadb schema version not recognised: {config$schema_version}")
  }
}

validate_lexicon <- function(lexadb) {
  db_path <- attr(lexadb, "meta")$path
  lexicon <- read_lexicon(db_path)

  if (lexadb$config$schema_version == "0.0.0.9000") {
    lapply(
      lexicon,
      function(entry) {
        entry_json <- jsonlite::toJSON(entry, auto_unbox = TRUE)
        validated <- jsonvalidate::json_validate(
          entry_json,
          system.file("extdata/json-schemas/0.0.0.9000/lx-schema.json", package = "lexaR"),
          verbose = TRUE,
          engine = "ajv"
        )
        return(validated)
      }
    )
  }
}

validate_collections <- function(lexadb) {
  db_path <- attr(lexadb, "meta")$path
  collections <- read_collections(db_path)

  if (lexadb$config$schema_version == "0.0.0.9000") {
    lapply(
      collections,
      function(entry) {
        entry_json <- jsonlite::toJSON(entry, auto_unbox = TRUE)
        validated <- jsonvalidate::json_validate(
          entry_json,
          system.file("extdata/json-schemas/0.0.0.9000/cl-schema.json", package = "lexaR"),
          verbose = TRUE,
          engine = "ajv"
        )
        return(validated)
      }
    )
  }
}
