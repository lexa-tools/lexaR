# Edit a lexical entry

It opens the file of the specified lexical entry for editing and updates
the `date_modified` field.

## Usage

``` r
edit_entry(lexadb, entry_id)
```

## Arguments

- lexadb:

  A `lexadb` object (created with
  [`load_lexadb`](https://stefanocoretta.github.io/lexa/dev/reference/load_lexadb.md)).

- entry_id:

  A string with the entry id (the `lx_` prefix and leading zeros can be
  omitted.)

## Value

Nothing. Used for its side effects
