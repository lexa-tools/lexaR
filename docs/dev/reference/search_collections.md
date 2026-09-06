# Search words in sentence collections

Search words in the sentence collections.

## Usage

``` r
search_collections(lexadb, word = NULL, whole = TRUE, gloss = NULL)
```

## Arguments

- lexadb:

  A `lexadb` object (created with
  [`load_lexadb`](https://stefanocoretta.github.io/lexa/dev/reference/load_lexadb.md)).

- word:

  A regular expression to search among the sentences.

- whole:

  Whether to search for whole words (`TRUE` by default).

- gloss:

  A regular expression to search among the glosses.

## Value

A list of `lexalx` objects.

## Examples

``` r
db_path <- system.file("extdata/albanian_lexadb", package = "lexa")
albanian <- load_lexadb(db_path)
#> ℹ Loading: albanian
#> Error in !unlist(lx_val): invalid argument type

search_collections(albanian, "rrezet")
#> Error: object 'albanian' not found
search_collections(albanian, gloss = "sun")
#> Error: object 'albanian' not found
search_collections(albanian, gloss = "traveller")
#> Error: object 'albanian' not found
```
