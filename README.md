# Delta for Mere Mortals

Git's own account of a change is exact and
unwelcoming: lines beginning with `-` and
`+`, blocks of context, line numbers you
have to decode from a header like
`@@ -6,12 +6,12 @@`. Everything you need
is there, and reading it is slow, tiring
work — so people skim, and skimming diffs
is how bad changes get approved. **Delta**
is a **pager** that takes the diff git
already computed and *paints* it: syntax
highlighting for the code, a background
colour for removed and added lines, a
brighter emphasis on the exact words that
changed inside a line, tidy headers that
name each file and what happened to it,
and, when you ask, line numbers or a
side-by-side view.

One rule governs everything in this
guide, and it is stated here and again in
chapter 1: **delta changes how a diff
looks, never what the diff says.** Git
computes the change; delta presents it;
the pager shows it a screen at a time.
Where the presentation itself could
mislead — an emphasis that pairs the
wrong two lines, a decoration you might
copy into a patch file by mistake —
chapter 14 says so plainly, and the raw
output is never more than one flag away.

The lab behind this guide ran the real
thing: **delta 0.20.1**, the official
release binary, on a small Linux machine,
against a throwaway fixture repository
the lab built for the purpose — a tiny
garden planner with a short, deliberate
history: small within-line edits, a file
added, a file deleted, a file renamed, a
mode change, a binary file replaced, and
two branches that disagree. Against it
the lab compared plain `git show` with
the same commit through delta, read the
terminal's escape codes to prove which
colours delta actually emits, turned on
line numbers and side-by-side views at
two terminal widths, rendered `git log`,
`git blame`, `git grep` and interactive
staging through delta, staged a merge
conflict and read it both ways, fed delta
a patch file and two loose files, and
drove the real pager with a terminal
emulator to watch file navigation jump.

What the lab could not settle, it did not
fake. Delta's colour choices are recorded
in the lab notes as the escape codes the
terminal received, because a text
transcript cannot show colour; the
transcripts prove layout and content.
Install routes other than the release
tarball are described from the project's
documentation. `criteria.md` keeps the
full ledger of what was run and what was
only read.

## What this guide covers

- [**What delta is**](what-delta-is.md) —
  the mental model: git computes, delta
  paints, the pager pages — and the rule
  that paint is never content
- [**The moving parts**](the-moving-parts.md) —
  delta's three seats in your workflow,
  where its configuration lives, and the
  parts it borrows: a syntax engine and
  a pager
- [**Installing delta**](installing-delta.md) —
  the release binary and the package
  routes, and the two commands that prove
  the install
- [**Your first diff**](your-first-diff.md) —
  three lines of configuration, the
  fixture repository, and the same commit
  read plain and painted
- [**Reading a diff**](reading-a-diff.md) —
  the anatomy of delta's output: file
  headers, hunk boxes, background colours,
  and the brighter emphasis on what
  actually changed inside a line
- [**Line numbers and side by side**](line-numbers-and-side-by-side.md) —
  old and new line numbers in the gutter,
  two-panel view at a wide terminal, and
  what happens when the terminal is
  narrow
- [**Configuration**](configuration.md) —
  the `[delta]` section, features, your
  own named feature sets, and
  `--show-config`, the tool that shows
  what delta actually believes
- [**Themes and colour**](themes-and-colour.md) —
  the 28 syntax themes, dark and light
  terminals, and why the theme and the
  diff colours are separate layers
- [**Log, blame and grep**](log-blame-and-grep.md) —
  history, authorship and search results
  through the same painter, including the
  one recipe that needs git's own colours
  switched on first
- [**Interactive staging**](interactive-staging.md) —
  `git add -p` with delta as the filter,
  and why that seat demands
  `--color-only` and no decorations
- [**Conflicts and odd diffs**](conflicts-and-odd-diffs.md) —
  a merge conflict laid out as two
  labelled sides, and what delta does
  with binary files and `--stat`
  summaries: mostly, leave them alone
- [**Recipes**](recipes.md) — navigate a
  long diff file by file, diff two files
  that live in no repository, read a
  patch somebody mailed you, clickable
  file names, and the vanilla second
  opinion
- [**The neighbours**](the-neighbours.md) —
  diff-so-fancy, diff-highlight, colordiff,
  bat, and the diff views built into
  forges and other git tools
- [**Limits**](limits.md) — a prettier
  diff is the same diff, emphasis is a
  heuristic, colour is a channel that can
  fail, and scripts should never eat
  painted output
- [**Troubleshooting**](troubleshooting.md) —
  the pager that never starts, the option
  delta never saw, decorations where they
  break things, and the patch file that
  hangs
- [**Glossary**](glossary.md) — the
  terms, collected in one place

## What it doesn't cover

Changing what git computes. Delta has no
opinion about diff algorithms, rename
detection or merge strategy; if the
underlying diff is the wrong comparison,
chapter 14 explains why the painted
version is the same wrong comparison in
nicer clothes, and the Git guide in this
series is where the computing side lives.
Writing patches, resolving conflicts and
editing code are likewise other tools'
work — delta shows, it does not touch.
Running delta inside editors and IDEs is
pointed at, not taught.

## How to use this guide

Read chapter 1 for the model and the
rule, and chapter 2 before configuring
anything — knowing which seat delta is
sitting in turns most surprises into
named problems. Chapters 3 and 4 get you
from no delta to a painted diff in one
sitting, against the fixture repository,
which the lab script in `delta-lab/`
builds for you. Chapter 5 is the one to
read slowly: everything later is a
variation on its anatomy lesson. Turn
features on one at a time (chapters 6–8)
and check `delta --show-config` whenever
reality disagrees with your configuration
file — chapter 15 explains why that
command settles arguments. The lab's
transcripts live in
`delta-lab/transcripts/`; the fixture
script is `delta-lab/make-fixture.sh`;
its notes, including the colour evidence,
are `examples/lab-notes.txt`.

---

## Part of the series

This guide is one of the [For Mere Mortals](https://paulsullivan33-dev.github.io/mere-mortals/) guides: plain-language guides to the tools programmers and makers use.

Related guides:

- [Git for Mere Mortals](https://paulsullivan33-dev.github.io/git-for-mere-mortals/)
- [lazygit for Mere Mortals](https://paulsullivan33-dev.github.io/lazygit-for-mere-mortals/)
- [Git Rescue for Mere Mortals](https://paulsullivan33-dev.github.io/git-rescue-for-mere-mortals/)

## License

The writing in this guide is licensed under [CC BY 4.0](https://github.com/paulsullivan33-dev/delta-for-mere-mortals/blob/main/LICENSE). Code examples and lab scripts are licensed under the [MIT License](https://github.com/paulsullivan33-dev/delta-for-mere-mortals/blob/main/LICENSE-CODE).
