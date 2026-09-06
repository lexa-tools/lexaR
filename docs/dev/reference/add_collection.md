# Add text to database

This function creates a new text in the database, i.e. a new empty text
skeleton is written to disk, in the `texts/` directory, for the user to
edit at will.

## Usage

``` r
add_collection(lexadb, title = NULL)
```

## Arguments

- lexadb:

  A `lexadb` object (created with
  [`load_lexadb`](https://stefanocoretta.github.io/lexa/dev/reference/load_lexadb.md))

- title:

  The text title as a string.

## Value

Nothing. Used for its side effects
