# Recipes

Six jobs delta does well, each in one
short sitting. All were run in the lab
unless the recipe says otherwise.

## Walk a long diff file by file

A big change, dozens of files, and you
want one at a time. With `navigate = true`
(chapter 4), delta plants a small `•`
marker at the head of every file section
and pre-loads the pager's search pattern
with it. Inside `less`:

- **`n`** — jump to the next file. The
  lab drove a real pager under a terminal
  emulator (transcript t21): starting at
  the commit header, the first `n` put
  the first file's header at the top of
  the screen, the second `n` the next
  file's.
- **`N`** — jump back. Verified the same
  way: from the second file, `N` returned
  the first file's header to the top.

You are not scrolling a document any
more; you are turning the pages of a
binder, one project file per page.

## Diff two files that live in no repository

```bash
delta garden-v1.py garden-v2.py
```

(transcript t10). Delta has git compute
the difference between the two files and
paints the result — header reading
`garden-v1.py ⟶ garden-v2.py`, hunks,
emphasis and all. The files need no
repository, no staging, no history; it is
the quickest way in this guide to answer
*what actually changed between these two
copies?* — the download and the original,
the config before and after an installer
ran.

## Read a patch somebody sent you

A `.patch` file — from an email, a
release page, a colleague — is a diff
with no repository attached. Feed it to
delta on standard input:

```bash
delta < change.patch
```

(transcript t11), and it renders like any
other diff, commit header and all if the
patch carries one. The one way *not* to
do it: `delta change.patch`. A lone
filename does not mean "read this patch"
to delta — with a terminal attached it
prints a short hint saying so; with no
input attached it waits, reading a diff
that is never coming. Chapter 15 keeps
the entry; everyone tries it once.

## Clickable file names

```ini
[delta]
    hyperlinks = true
```

makes each file header a link to the
file, in the terminal's OSC 8 hyperlink
form — the lab counted eight of the
escape sequences in a two-file diff, each
naming the file's real path. In a
terminal that supports them (many modern
ones do), the header becomes clickable
and opens the file, in the editor the
link format names if you set one. Whether
*your* terminal renders the link is the
terminal's business; delta's side —
emitting the sequences — is the verified
half, and the plain header still reads
fine where links are ignored.

## The vanilla second opinion

A diff looks wrong and you cannot tell
whether git, delta or your configuration
is the author of the wrongness. Remove
the painter from the question:

```bash
git --no-pager show <commit>
```

gives git's raw answer, delta never
called. Its mirror image, for checking
what your *configuration* adds:

```bash
delta --no-gitconfig < change.patch
```

renders with factory defaults, your
`[delta]` section ignored — verified in
the lab, where the wide-review feature of
chapter 7 vanished from `--show-config`
under this flag. Between the two, every
surprise has exactly one place left to
live.

## Set up a wide-terminal review seat

Chapter 7's named feature, kept as a
standing arrangement:

```ini
[delta]
    features = wide-review
[delta "wide-review"]
    line-numbers = true
    side-by-side = true
```

At a wide monitor, every diff now arrives
as two panels with numbers (chapter 6) —
and on the laptop screen, one
`git -c delta.features=line-numbers …`
(or deleting `side-by-side` from the
bundle) restores the narrow-friendly
form. Geometry is a per-chair decision;
features make it a per-command one.
