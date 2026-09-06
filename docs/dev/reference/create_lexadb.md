# Create a new Lexa database

Create a new Lexa database

## Usage

``` r
create_lexadb(name, parent = ".", author = NULL)
```

## Arguments

- name:

  Name of the Lexa database (the `.yaml` extension will be appended to
  the name automatically).

- parent:

  Parent directory (default is current working directory).

## Value

A lexadb connection.

## Examples

``` r
if (FALSE) { # \dontrun{
create_lexadb(name = "my_db")
} # }
```
