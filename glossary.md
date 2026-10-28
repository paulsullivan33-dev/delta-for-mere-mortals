# Glossary

**Blame** — git's per-line attribution:
which commit and author last touched each
line. Delta renders it in columns when
git pages it through delta (chapter 9).

**Combined diff** — the three-way diff
format git uses for merges and conflicts,
with two columns of markers. Plain, it is
the hardest diff to read; chapter 11
shows delta's rendering of it.

**Decoration** — delta's furniture: file
headers, rules, hunk boxes. Beautiful at
a terminal, forbidden in the filter seat
(chapter 10), meaningless in a file
(chapter 14).

**Diff** — git's account of a change:
lines removed, lines added, context
around them. Git computes it; delta
paints it (chapter 1).

**Emphasis** — the brighter shade inside
a removed or added line marking the parts
that differ from its paired line
(chapter 5).

**Feature** — a named bundle of delta
options switched on in one word:
`line-numbers`, `side-by-side`, or your
own (chapter 7).

**Filter seat** — delta's role in
`interactive.diffFilter`, where it may
colour a diff but must not rearrange it;
entered with `--color-only` (chapter 10).

**Hunk** — one cluster of changes within
a file, with its surrounding context
lines. The unit `git add -p` asks about.

**Hyperlink (OSC 8)** — a terminal escape
sequence that makes text clickable.
Delta can emit file headers as links to
the files (chapter 12).

**Navigate** — delta's mode that marks
each file section with `•` and pre-loads
the pager's search, so `n`/`N` jump
between files inside `less` (chapter 12).

**Pager** — the program that shows long
output a screen at a time; traditionally
`less`. Delta sits in the pager's seat
and hands the paging back to less
(chapter 2).

**Pager seat** — delta's main role, via
git's `core.pager`: every diff git shows
a human passes through it (chapter 2).

**Pairing** — delta's matching of a
removed line to the added line it most
resembles, so their difference can be
emphasised. Governed by
`max-line-distance` (chapter 5).

**Side by side** — the two-panel view:
old file left, new file right, partners
opposite each other (chapter 6).

**Syntax theme** — the palette that
colours code by kind — keyword, string,
number — borrowed from the `bat` project;
independent of the diff colours
(chapter 8).

**Within-line emphasis** — see *Emphasis*.
