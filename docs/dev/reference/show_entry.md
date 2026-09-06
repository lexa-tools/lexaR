# Show lexicon entry with given id

It shows the entry with the given id.

## Usage

``` r
show_entry(lexacon, entry_id)
```

## Arguments

- lexacon:

  A `lexacon` object (created with
  [`load_lexadb`](https://stefanocoretta.github.io/lexa/dev/reference/load_lexadb.md)).

- entry_id:

  A string with the entry id (the `lx_` prefix and leading zeros can be
  omitted.)

## Value

A `lexalx` object.

## Examples

``` r
db_path <- system.file("extdata/eleryon_lexadb", package = "lexaR")
eleryon <- load_lexadb(db_path)
#> Warning: 'raw = FALSE' but '/private/var/folders/5z/z0vmfr093_lgy9wqnckyhqlc0000gn/T/RtmpSvFMJc/temp_libpath149444a6c884a/lexaR/extdata/eleryon_lexadb' is not a regular file
#> Warning: cannot open file '/private/var/folders/5z/z0vmfr093_lgy9wqnckyhqlc0000gn/T/RtmpSvFMJc/temp_libpath149444a6c884a/lexaR/extdata/eleryon_lexadb': it is a directory
#> Error in file(file, "rt", encoding = fileEncoding): cannot open the connection

show_entry(eleryon, 6)
#> Error: object 'eleryon' not found
# Same as:
show_entry(eleryon, "lx_000006")
#> Error: object 'eleryon' not found
```
