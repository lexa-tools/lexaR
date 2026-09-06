# Show collection or sentence with given id

It shows the collection or sentence with the given id.

## Usage

``` r
show_collection(lexadb, coll_id, sent_id = NULL)
```

## Arguments

- lexadb:

  A `lexadb` object (created with
  [`load_lexadb`](https://stefanocoretta.github.io/lexa/dev/reference/load_lexadb.md)).

- coll_id:

  A string with the collection id (the `cl_` prefix and leading zeros
  can be omitted.)

- sent_id:

  A string with the sentence id (the `st_` prefix and leading zeros can
  be omitted.)

## Value

A `lexast` object.

## Examples

``` r
db_path <- system.file("extdata/albanian_lexadb", package = "lexa")
albanian <- load_lexadb(db_path)
#> ℹ Loading: albanian
#> Error in !unlist(lx_val): invalid argument type

show_collection(albanian, 1)
#> Error: object 'albanian' not found
show_collection(albanian, 1, 3)
#> Error: object 'albanian' not found
```
