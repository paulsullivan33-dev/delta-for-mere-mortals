# Log, Blame and Grep

The pager seat (chapter 2) is not only
about `git diff`. Any git command whose
output *contains* diffs gets them
painted, and two commands that are not
diffs at all — blame and grep — have
renderings of their own. This chapter
walks the four, with the one recipe in
the guide that needs a trick.

## git log -p: history with its evidence

```bash
git log -p -2
```

(transcript t08). The commit lines —
hash, author, date, message — pass
through as git wrote them. Each commit's
diff is then painted in full delta dress:
headers, hunk boxes, colours. Reading a
project's past this way is a different
experience from the plain log: the
*shape* of each change (one line? one
file? everything?) is visible before you
read a word of it, which is what skimming
history actually needs. `git show` is the
same rendering aimed at one commit, and
`git log` without `-p` has no diffs in
it, so delta leaves it entirely alone.

## git blame: who, laid out in columns

Blame's raw output prefixes every line
with a hash, an author, a timestamp and a
line number in a dense parenthesised
block. Tell git to page blame through
delta:

```bash
git config --global pager.blame delta
git blame garden.py
```

and delta rebuilds it (transcript t09):

```text
21 seconds ago  Pat Gardener    f15ec934│ 13 │     if day in ("Saturday",):
```

Columns: how long ago, who, the commit's
short hash, the line number, and the code
itself, syntax-coloured. An author's
name is printed once and then left blank
until the author *changes* — a whole
hunk from one commit reads as one block.
Lines untouched since the file's first
commit carry a `^` marker on the hash,
so the oldest stratum is visible at a
glance. For the question blame exists
to answer — *whose change is this line,
and when* — the columns put each fact
under the eye that wants it. (The
relative times are delta's rendering; ask
blame itself, with `--date`, when you
need the exact day.)

## git grep: the recipe with a trick

Delta can render grep results — file in
purple, line number in green, the match
itself lit up, the code syntax-coloured
(transcript t19). But this:

```bash
git grep -n Water | delta
```

does **not** do it (transcript t18): the
lines pass through plain. The reason is
fair once you see it — a bare
`file:line:text` stream could be
anything, and delta will not guess. It
recognises the format when git *colours*
its matches, which git only does for a
terminal; in a pipe, colours are off.
So force them on:

```bash
git -c color.ui=always grep -n Water | delta
```

With git's colour marks present, delta
knows what it is looking at and paints:
each match on its line glows against the
code around it, and a search through a
large tree becomes a page you can scan
by eye. If you use it often, it is worth
an alias in your shell or your git
config; if you use it rarely, the `-c`
form keeps the trick where you can see
it.

## What passes through untouched

Just as instructive is what delta does
*not* decorate. `git show --stat`
(transcript t20) prints its summary table
— file names, counts, the little bar
chart of pluses and minuses — exactly as
git wrote it, headers and all, with delta
adding nothing. `git log` without `-p`,
`git status`, commit messages: all plain.
Delta is a painter of diff-shaped things,
and it keeps its brush off the rest of
git's voice. When output looks
surprisingly plain, the first question is
whether there was a diff in it at all —
chapter 15's checklist starts there.

Check: in the fixture, run `git log -p`
and stop at the binary commit — the
`gate.bin (binary file)` header in the
middle of the history. Then
`git -c pager.blame=delta blame garden.py`
and find which commit set the water to 3
litres, from the columns alone.
