# The Moving Parts

Delta is one binary with three seats, two
borrowed parts, and one configuration
home. Knowing which is which turns nearly
every surprise in later chapters into a
named problem, so this chapter is short
and entirely mechanical.

## The three seats

**The pager seat.** Most of the time you
never type `delta` at all. Git is told
`core.pager = delta`, and from then on
every diff git wants to show a human —
`git diff`, `git show`, `git log -p` —
is handed to delta instead of `less`.
Delta renders it and passes it to a real
pager (by default `less` again) for the
screen-at-a-time part. You configure this
once, in chapter 4, and then simply use
git.

**The filter seat.** Some git commands
show you a diff *while asking you
questions* — `git add -p` is the everyday
one. There, git needs the diff text back,
so decoration would corrupt the
conversation. Git's `interactive.diffFilter`
setting names a program that may *colour*
the hunks but must not rearrange them,
and delta has a mode for exactly this:
`delta --color-only`. Chapter 10 lives
in this seat.

**The front door.** Delta also reads a
diff directly: piped or redirected into
its standard input (`delta < change.patch`),
or given **two files** to compare
(`delta old.py new.py`), in which case it
asks git to compute that diff and then
paints it. What delta will *not* do is
treat one filename as a patch to read —
chapter 15 tells that small story,
because everyone tries it once.

And one non-seat, worth naming now: **git
only calls a pager when its output is a
terminal.** Pipe `git show` into a file or
another program and no pager runs at all
— not delta, not less. That is git's
decision, made before delta is consulted,
and it is why scripts and patch files
never contain delta's paint (chapter 14).

## The borrowed parts

Delta does two jobs itself — laying out
diffs, and pairing changed lines for
emphasis — and borrows two:

- **Syntax highlighting** comes from the
  same theme and language set as the
  `bat` tool: `--list-syntax-themes` in
  the lab listed 28 themes and
  `--list-languages` 198 languages
  (transcript t14). When delta colours
  your Python, it is bat's knowledge of
  Python doing it.
- **Paging** is handed to `less` unless
  you say otherwise. Delta sets less up
  with the options it needs; features
  like file navigation (chapter 12) are
  really delta and less cooperating —
  delta marks each file section and
  pre-loads less's search pattern so the
  `n` key walks from file to file.

## Where the configuration lives

Delta has no config file of its own. Its
options live in **git's configuration**,
in a `[delta]` section of (usually)
`~/.gitconfig`, alongside the settings
that seat it:

```ini
[core]
    pager = delta
[interactive]
    diffFilter = delta --color-only
[delta]
    navigate = true
```

Individual options can also ride along on
one command — `git -c delta.features=line-numbers show …`
sets them for that run, and `delta`'s own
command-line flags (as in the filter seat)
override both. Because the plumbing is
git's, the referee is too:

```bash
delta --show-config
```

prints every option as delta has
*actually* understood it, defaults and
all (transcript t15). When a setting
seems ignored, this command — not the
config file — is the ground truth, and
chapter 15 shows the lab catching a real
case of the two disagreeing.

One more piece of plumbing: delta reads
your terminal's width itself and lays out
to fit. Take the terminal away — pipe
delta's own output into a file — and it
falls back to 80 columns. Chapter 6 shows
what that layout engine does with a wide
terminal and a narrow one.
