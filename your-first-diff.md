# Your First Diff

This chapter wires delta into git, builds
the fixture repository the whole guide
uses, and reads one small commit twice:
plain, then painted. By the end you can
state what delta added to the picture —
and prove none of it is new information.

## The wiring: three settings

Add these to your `~/.gitconfig` (create
the file if git has not already):

```ini
[core]
    pager = delta
[interactive]
    diffFilter = delta --color-only
[delta]
    navigate = true
```

- `core.pager` puts delta in the pager
  seat (chapter 2): every diff git shows
  at a terminal now comes to delta first.
- `interactive.diffFilter` puts it in the
  filter seat for interactive staging;
  `--color-only` is the promise that in
  this seat it will colour and *nothing
  more*. Chapter 10 explains why the
  promise matters.
- `[delta] navigate = true` switches on
  file navigation inside the pager
  (chapter 12). It is the only delta
  option the lab turned on at this stage,
  so that what follows is delta's
  *default* face.

If you would rather not edit the file by
hand, the same settings one at a time:

```bash
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
```

## The fixture

The guide's lab is a tiny invented
project — a garden planner — with a
history built to contain one of
everything a diff reader meets. Build it
with the script that ships with this
guide:

```bash
sh delta-lab/make-fixture.sh garden
cd garden
git log --oneline
```

Six commits: a start, small edits to code
and prose, a tidy-up that adds, deletes
and renames files, a photo added, the
photo replaced, and a quarrel the script
rehearses and then politely aborts (the
conflict itself gets its own staging in
chapter 11). Nothing in it is modelled on
any real garden; it is a specimen, made
to be looked at.

## The same commit, twice

The second commit — `f15ec93` in the lab
(your hash will differ; find it with
`git log --oneline`) — makes four small
changes: a number in the code, a pair of
lines in a function, one word added to a
sentence in the README. Without delta,
`git show` answers in the classic
notation (transcript t01):

```text
-WATER_LITRES_PER_BED = 6
+WATER_LITRES_PER_BED = 4
```

With the wiring above, the *same command*
answers (transcript t02):

```text
garden.py
────────────────────────────────────────

6: BEDS = { │
    "south": ["beans", "squash"],
}

WATER_LITRES_PER_BED = 6
WATER_LITRES_PER_BED = 4
```

The rule lines are as wide as your
terminal — delta measures it (chapter 2).
The commit's own header lines (author,
date, message) pass through untouched:
delta paints diffs, and leaves the rest
of git's output alone.

What changed, item by item:

- Each file gets a header — the name on
  its own line over a rule — in place of
  the four `diff --git` / `---` / `+++`
  lines. (Those lines still exist in the
  raw diff; they are how git speaks. The
  header is delta saying the same thing
  in one line.)
- The `@@ -6,12 +6,12 @@` header becomes
  the little box: `6: BEDS = {` is the
  line number and the context words git
  printed — the line of code the hunk
  follows. Chapter 5 takes this apart.
- Removed and added lines lose their
  `-`/`+` signs and gain backgrounds
  instead: dark red, dark green. The
  signs can be brought back
  (`keep-plus-minus-markers`, chapter 5)
  if your eye wants both signals.

Check: run the commit both ways in your
own fixture — `git show <hash>`, then
`git --no-pager show <hash>` — and
confirm the second is byte-for-byte the
output git has always produced. Delta
sat in the pager seat for the first and
was never called for the second. Nothing
about your repository, your history or
git's answers changed today; only the
reading did.
