# Changelog

## lexaR 0.0.3.9000

### Breaking

- Now “texts” are sentences “collections”. This means that the folder
  `texts` is now called `collections` and each yaml file name should be
  `cl_00000n.yaml`.

- The lexa database schema is now developed at
  <https://github.com/lexa-tools/lexa-schema>.

- No longer supporting Rmarkdown. Please use Quarto and the
  [interlinear](https://github.com/stefanocoretta/interlinear) package.

### Added

- `write_merged_lexicon()` to write a single yaml file with the lexicon
  entries.

- `open_entry()` to open the entry YAML file. Use `edit_entry()` if you
  wish to edit the entry and you want the `date_modified` field to be
  automatically updated with the current date.

- `edit_entry()` to open the entry YAML file and update `date_modified`
  with current date.

- [`import_lexicon_lift()`](https://stefanocoretta.github.io/lexa/dev/reference/import_lexicon_lift.md)
  to import a LIFT lexicon to Lexa (experimental).

- Added multilingual support to lexicon entries. (closes
  [\#4](https://github.com/stefanocoretta/lexa/issues/4))

### Changed

- [`add_entry()`](https://stefanocoretta.github.io/lexa/dev/reference/add_entry.md)
  now checks if homophones exist.

- The specification for a lexical entry has now a `homophone` field
  (numeric).

- [`search_lexicon()`](https://stefanocoretta.github.io/lexa/dev/reference/search_lexicon.md)
  has a new argument `show_entry` which, when `TRUE`, prints all the
  entry info (it’s `FALSE` by default).

- The `whole` argument in
  [`search_lexicon()`](https://stefanocoretta.github.io/lexa/dev/reference/search_lexicon.md)
  is now `FALSE` by default.

- [`load_lexadb()`](https://stefanocoretta.github.io/lexa/dev/reference/load_lexadb.md)
  now checks for validity of lexical entries based on the expected
  schema.
