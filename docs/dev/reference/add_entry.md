# Add entry to lexicon

This function creates a new entry in the lexicon, i.e. a new empty entry
skeleton is written to disk, in the `lexicon/` directory, for the user
to edit at will.

## Usage

``` r
add_entry(
  lexacon,
  lexeme,
  gloss,
  word_type = NULL,
  word_class = NULL,
  definition = gloss,
  homophone = NULL
)
```

## Arguments

- lexacon:

  A `lexacon` object (created with
  [`load_lexadb`](https://stefanocoretta.github.io/lexa/dev/reference/load_lexadb.md)).

- lexeme:

  The entry as a string.

- gloss:

  The gloss as a string.

- word_type:

  The type of lexical entry (root, stem, affix, clitic, particle,
  compound, phrase).

- word_class:

  The word class of the lexical entry.

- definition:

  The definition of the entry as a string.

- homophone:

  The homophone numeric index.

## Value

Nothing. Used for its side effects
