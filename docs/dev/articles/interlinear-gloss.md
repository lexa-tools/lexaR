# Typesetting interlinear glosses

## Overview

Users can output interlinear glosses in Rmarkdown files from the texts
in a Lexa database.

Both PDF and HTML output formats are supported. The LaTeX package
[expex](https://ctan.org/pkg/expex) is used for PDF output, while HTML
glosses are rendered with
[Leipzig.js](https://bdchauvette.net/leipzig.js/).

At this time, the functionalities implemented within lexa are limited,
but they provide sufficient coverage for basic glossing.

## Load a Lexa database

To load a Lexa database, we first attach the lexa package.

``` r

library(lexa)
```

And then load the example database `eleryon_lexadb`.

``` r

eleryon_path <- system.file("extdata/eleryon_lexadb", package = "lexa")

eleryon <- load_lexadb(eleryon_path)
#> ℹ Loading: eleryon
```

We can now inspect the content of the `eleryon` database.

``` r

eleryon
#> 
#> ── Database info ───────────────────────────────────────────────────────────────
#> ◉ Name: eleryon
#> ℹ Entries: 6 | Collections: 1
#> 
#> ── Lexicon breakdown ──
#> 
#> ◉ Categories → Lexical: 6
#> ◉ Morpheme types → Roots: 6
#> ◉ POS → Adverbs: 1 | Nouns: 1 | Verbs: 4
```

## Include interlinear glosses

There are two ways of including an interlinear gloss in an Rmarkdown
file.

### Inline R code

One is by using inline R code (see the source of this vignette for the
code).

Ęs ętsu urųrtō enēim kę̄syoh bhųl enēim āireᵃph likhpyūaq.

\[œs œtsu uryrtoː eneːim kœːsjoh βyl eneːim aːireɐɸ lixpjuːaʔ\]

ęs ętsu ur-ųrt-ō enēim kę̄sy-oh bhųl enēim āir-eᵃph lichp-y-ūaq

and then RDP-sit-PFCT:IND:1SG on rock-ACC while on 1PL-ACC
rain-V-IMPF:IND:IMPR

‘And then I sat on a rock, while it was raining over me.’

### R code chunk

Alternatively, one can use an R code chunk and set `results='asis'`.

``` r

include_gloss(eleryon, "cl_000001", "st_000002")
```

Ksǫnteziṇ gartosesī ōroi Vāisi su Meukha su vēsyēl selo ellāimōma enēim
āireᵃph.

\[ksɵnteziŋ gartosesiː oːroi vaːisi su meuxa su veːsjeːl selo
ellaːimoːma eneːim aːreɐɸ\]

ksǫntez-iṇ garto-se-sī ōroi Vāisi su Meucha su vēsy-ēl sel-o ellāim-ōma
enēim āir-eᵃph

pleasure-INST tell-1SG-2PL:ACC about sun:NOM and moon:NOM and
star-NOM:PL which be-3PL:ABS above 1PL-ACC

‘With pleasure I tell you about the Sun, the Moon and the stars that are
above us.’

## Original writing system and transcription/transliteration

``` r

bromi_path <- system.file("extdata/bromi_lexadb", package = "lexa")

bromi <- load_lexadb(bromi_path)
#> ℹ Loading: ぶろみ, Bromi
```

ふぁろっしゃ「ぎそんの「うっつろい

Farossha gisonno uttroi.

\[faɽɔʃʃa gisɔnno uttɽoi\]

fa-rossha gi-sonno uttr-oi

ACC-lunch NOM-1PL eat-1PL

‘We are having lunch.’
