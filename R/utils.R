# Check last entry ID and increase hex by 1.

generate_lx_id <- function(lexadb) {
  lexicon <- lexadb$lexicon
  lexicon_length <- length(lexicon)

  new_id_n <- lexicon_length + 1
  new_id_str <- sprintf("%06d", new_id_n)
  new_id <- paste0("lx_", new_id_str)

  return(new_id)
}

validate_lexadb <- function(lexacon) {
  if (lexacon$metadata$schema_version == "0.0.0.9001") {
    lexadb_json <- jsonlite::toJSON(lexacon, auto_unbox = TRUE)
    validated <- jsonvalidate::json_validate(
      lexadb_json,
      system.file("extdata/json-schemas/0.0.0.9001/lexadb-schema.json", package = "lexaR"),
      verbose = TRUE,
      engine = "ajv"
    )
    return(validated)
  } else {
    cli::cli_abort(c("x" = "Validation scheme not supported: {lexacon$metadata$schema_version}."))
  }
}
