# Typeset interlinear gloss

The function returns the selected sentence as properly formatted
html/latex code.

## Usage

``` r
typeset_gloss(lexadb, collection, sentence, format = "latex")
```

## Arguments

- lexadb:

  A `lexadb` object (created with
  [`load_lexadb`](https://stefanocoretta.github.io/lexa/dev/reference/load_lexadb.md)).

- collection:

  Collection id.

- sentence:

  Sentence id to print.

- format:

  Format to print out with (either `html` or `latex`).

## Examples

``` r
db_path <- system.file("extdata/albanian_lexadb", package = "lexa")
albanian <- load_lexadb(db_path)
#> ℹ Loading: albanian
#> Error in !unlist(lx_val): invalid argument type

typeset_gloss(albanian, 1, 1)
#> Error: object 'albanian' not found
typeset_gloss(albanian, 1, 1, format = "html")
#> Error: object 'albanian' not found
```
