# Import lexicon from a csv file

It imports entries from a `.csv` file with lexical data. The file must
have specific columns, see Details for file specifics. The lexicon is
imported into an existing Lexa database.

## Usage

``` r
import_lexicon_csv(lexadb, path)
```

## Arguments

- lexadb:

  A `lexadb` object as returned by
  [`load_lexadb()`](https://stefanocoretta.github.io/lexa/dev/reference/load_lexadb.md).

- path:

  The path to the lexicon .csv file as a string.

## Value

Nothing. Used for its side effects.

## Details

The file must have at least the following columns:

- `entry`: the lexical entry, as it should appear in the head entry.

- `gloss`: the gloss of the entry.

Optionally, the file can have the following columns:

- `definition`: the full definition of the entry. This normally provides
  more details about the meaning than the gloss. If this column is not
  present, the definition field is filled with the gloss.

- `phon`: phonetic transcription of the entry.

- `morph_category`: category of entry (e.g. lexical vs grammatical).

- `morph_type`: type of morpheme (e.g. root vs affix).

- `part_of_speech`: part of speech of entry.

- `class`: lexical class of entry (e.g. verbal conjugations, noun
  classes).

- `etymology`: the etymology of the entry.

- `notes`: free text notes.

Note that this list is temporary and *it will change* in the future.
