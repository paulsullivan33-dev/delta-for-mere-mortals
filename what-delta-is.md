# What Delta Is

A **diff** is git's answer to the question
*what changed?* — a list of lines removed
and lines added, with a little context
around them. It is exact, complete, and
written in a notation from the 1970s:
`-` for gone, `+` for new, and a header
like `@@ -6,12 +6,12 @@` that encodes
where in each file the change sits. Every
programmer reads diffs; very few read
them *well*, because the format spends
your attention on decoding instead of on
the change itself. The word that changed
inside a long line is the thing you most
need to see, and the plain format is the
one that hides it best.

**Delta is a pager for diffs.** A pager
is the program that shows you long output
a screen at a time — for git, usually
`less`. Delta stands where the pager
stands, receives the diff git computed,
and renders it for human eyes instead:

- removed lines on a dark red background,
  added lines on a dark green one;
- the *parts* of a line that actually
  changed picked out in a brighter shade
  of the same colour;
- code coloured by a **syntax theme**,
  the way an editor colours it;
- each file introduced by a clear header
  naming it — and saying `added:`,
  `removed:` or `renamed:` when that is
  what happened;
- each **hunk** (one cluster of changes)
  introduced by a small box locating it
  in the file.

Git still does all the computing. Delta
decides nothing about what changed; it
decides what the change *looks like*.
Chapter 2 shows the three places it can
sit; chapters 4 and 5 show the result.

## The rule, stated before everything else

A tool that stands between you and
evidence owes you one promise, and this
guide holds delta to it from the first
page:

> **Delta changes how a diff looks, never
> what the diff says. When the stakes are
> high, the raw output is the evidence —
> and it is always one flag away**
> (`git --no-pager …`, chapter 12).

Most days the promise is easy to keep,
because it is true by construction: delta
receives git's finished diff and cannot
add or remove a changed line. But
presentation can still mislead a reader
who forgets it is presentation. The
within-line emphasis pairs removed and
added lines by resemblance — a good
guess, usually right, occasionally
pairing lines that are not really
counterparts (chapter 14). The decoration
is not the diff: copy a file header out
of your terminal and you have copied
furniture, not data. And a beautifully
painted *wrong* diff — the wrong pair of
commits, a rename git did not detect —
is still wrong. Skim less because the
paint helps you aim; do not trust more
because the paint is pretty.

## Why anyone would do this

- **Reviewing.** The daily case. Somebody
  — often you, last week — proposes a
  change, and the diff is the whole
  evidence. Emphasis on the changed word
  inside the line is the difference
  between reading the change and
  re-reading two nearly identical lines
  hunting for it.
- **Understanding history.** `git log -p`
  and `git blame` are archaeology tools
  whose output delta renders too
  (chapter 9), so the past is as legible
  as the present.
- **Staging carefully.** `git add -p`
  asks, hunk by hunk, *this one?* Delta
  can paint those questions without
  breaking the asking (chapter 10).
- **Staying in the terminal.** Diff views
  exist in editors and on web forges, but
  they live where the code isn't being
  committed. Delta keeps the readable
  diff in the window where the work is.

## A first taste

After installing (chapter 3) and three
lines of configuration (chapter 4), an
ordinary command changes its face:

```bash
git show f15ec93
```

In the lab that one command, run against
the fixture repository, produced the
plain output of transcript
`delta-lab/transcripts/t01-plain-diff.txt`
before the configuration, and the painted
output of `t02-delta-default.txt` after
it. Same commit, same diff — the second
one names each file in a header, boxes
each hunk with its location, and lays the
removed and added lines on red and green
so the eye can sort them before the brain
starts reading.

Check: in the painted version the README
hunk's box reads:

```text
8: what was planted, where, and when to water. │
```

That is the line number and the context
line git itself printed after the `@@` —
delta has just taken it out of the code
and put it in a frame where you can use
it. Nothing was added; things were
*placed*.

## Who it is for

The programmer who reviews changes —
their own or a teammate's — in a
terminal, and wants the evidence legible.
The maintainer reading a long history.
Anyone who has ever approved a diff they
only skimmed, and would rather not do it
again.

## What it is not

Delta is not a diff *engine*: it computes
nothing (its one exception, diffing two
loose files in chapter 12, still hands
the comparing to git). It is not an
editor, a merge tool or a resolver of
conflicts — chapter 11 shows it laying a
conflict out clearly, and the resolving
is still yours. It is not a code review
platform: no comments, no approvals, no
memory. And it is not for machines: the
moment output is piped to a file or
another program, git itself stops calling
any pager, by design — chapter 14 is
firm about keeping it that way.
