# Search lexicon entries

Search entries in the lexicon, by entry form or sense definitions.

## Usage

``` r
search_lexicon(
  lexacon,
  lexeme = NULL,
  whole = FALSE,
  definition = NULL,
  word_class = NULL,
  show_entry = FALSE
)
```

## Arguments

- lexacon:

  A `lexacon` object (created with
  [`load_lexadb`](https://stefanocoretta.github.io/lexa/dev/reference/load_lexadb.md)).

- lexeme:

  A regular expression to search among entries.

- whole:

  Whether to search for whole words (only applies to `entry`, `FALSE` by
  default).

- definition:

  A regular expression to search among sense definitions.

- show_entry:

  Whether to print all the entry info (uses `print.lexalx`, default is
  \`FALSE“).

- pos:

  A regular expression to match the part of speech.

## Value

A list of `lexalx` objects.

## Examples

``` r
db_path <- system.file("extdata/eleryon_lexadb", package = "lexaR")
eleryon <- load_lexadb(db_path)
#> Warning: 'raw = FALSE' but '/private/var/folders/5z/z0vmfr093_lgy9wqnckyhqlc0000gn/T/RtmpSvFMJc/temp_libpath149444a6c884a/lexaR/extdata/eleryon_lexadb' is not a regular file
#> Warning: cannot open file '/private/var/folders/5z/z0vmfr093_lgy9wqnckyhqlc0000gn/T/RtmpSvFMJc/temp_libpath149444a6c884a/lexaR/extdata/eleryon_lexadb': it is a directory
#> Error in file(file, "rt", encoding = fileEncoding): cannot open the connection

# Search for "chǭs"
search_lexicon(eleryon, "chǭs")
#> Error: object 'eleryon' not found

# Search for all verbs
search_lexicon(eleryon, ".*", pos = "verb")
#> Error in search_lexicon(eleryon, ".*", pos = "verb"): unused argument (pos = "verb")

# Search for entry with meaning "love"
search_lexicon(eleryon, definition = "love")
#> Error: object 'eleryon' not found
```
