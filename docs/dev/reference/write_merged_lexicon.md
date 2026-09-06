# Write merged lexicon to disk

It writes a yaml file which contains all the entries in the lexicon. The
file is output in the `src` directory.

## Usage

``` r
write_merged_lexicon(lexadb, sort = TRUE, overwrite = FALSE)
```

## Arguments

- lexadb:

  A `lexadb` object (created with
  [`load_lexadb`](https://stefanocoretta.github.io/lexa/dev/reference/load_lexadb.md)).

- sort:

  Whether to sort the entries alphabetically (default is `TRUE`).

- overwrite:

  Whether to overwrite an existing `lexicon.yaml` file.
