# lexa: Manage documentary and descriptive linguistic data

The goal of lexa is to provide a framework and tools to manage
linguistic fieldwork data.

The package is still in its infancy and only a very limited set of
features are being developed for the time being. The package contains
highly unstable code, so expect breaking changes at any point (although
I will try to keep these at a minimum).

The current available features are:

- Create a Lexa database.
- Add lexical entries to the database.
- Search lexical entries by word or definition.
- Import lexical entries from a `.csv` file.

## Installation

You can install the latest version of lexa like so:

``` r

remotes::install_github(
  "stefanocoretta/lexa@v0.0.3",
  build_vignettes = TRUE
)
```

## Quick start

To create a new database:

``` r

library(lexaR)

create_lexadb(name = "my_db")
```

This will create a file `my_db.yaml` in the current directory. See
[`vignette("database-schema", package = "lexaR")`](https://stefanocoretta.github.io/lexa/dev/articles/database-schema.md)
for details.

To create new lexical entries you first need to load the database:

``` r

new_db <- load_lexadb("my_db.yaml")

new_db
```

Now you can add a new entry with:

``` r

add_entry(new_db, "cane", "dog")
```

This will create a new entry. The new `id` is automatically created.

To search your lexicon:

``` r

db_path <- system.file("extdata/eleryon.yaml", package = "lexaR")
eleryon <- load_lexadb(db_path)
eleryon
#> 
#> ── Database info ───────────────────────────────────────────────────────────────
#> ◉ Name: Eleryon
#> ◉ Author: Stefano Coretta
#> ℹ Entries: 6
#> 
#> ── Lexicon breakdown ──
#> 
#> ◉ Word types → Stem: 6
#> ◉ Word classes → Adverb: 1 | Noun: 1 | Verb: 4

search_lexicon(eleryon, lexeme = "unullose")
#> ✔ Found 1 entry.
#> • unullose to love [lx_000002]
search_lexicon(eleryon, definition = "tomorrow")
#> ✔ Found 1 entry.
#> • chǭs tomorrow [lx_000005]
```

You can also display lexical entries!

``` r

show_entry(eleryon, 6)
#> 
#> ── Entry lx_000006 ─────────────────────────────────────────────────────────────
#> urųrtose /uryrtose/ verb (thematic and I)
#> 
#> ── Senses ──
#> 
#> 1.  to sit
#> 
#>           ── Examples
#>           • Ęs ętsu urųrtō enēim kę̄syoh bhųl enēim āireᵃph likhpyūaq. And then
#>           I sat on a rock, while it was raining over me.
#> 
#> ── Grammatical info ──
#> 
#> Type: stem
#> Class: verb
```
