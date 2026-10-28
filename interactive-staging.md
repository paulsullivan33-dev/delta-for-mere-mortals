# Interactive Staging

`git add -p` walks you through your
uncommitted changes hunk by hunk —
*Stage this hunk?* — and lets you commit
the finished half of your work while the
experimental half stays in the file. The
questions are only as good as your
reading of each hunk, which makes this
delta's most valuable seat — and its
most constrained one.

## Why this seat is different

In the pager seat, delta's output goes to
your eyes and nowhere else, so headers
and boxes are free. Here, the program
showing you the hunk is *git itself*, in
conversation: git prints a hunk, reads
your answer, prints the next. The hunk
text passes through a filter on its way —
`interactive.diffFilter` — and git then
uses the filtered text as the record of
what you were shown and what you chose.
A filter that rearranged the text —
added headers, renumbered lines, rewrote
the `@@` line — would be editing the
conversation's minutes. So the contract
for this seat is: **colour, yes;
furniture, no.**

Delta's side of the contract is a flag:

```ini
[interactive]
    diffFilter = delta --color-only
```

`--color-only` renders the diff colours
and the within-line emphasis — and
nothing else. No file headers, no hunk
boxes, no re-flowing. Chapter 4 already
had you set it; this chapter is the
evidence it matters.

## The lab's session

The lab dirtied two files in the
fixture — a README line and the water
constant — and ran `git add -p`
(transcript t17). Each hunk arrived
painted: the removed line on dark red
with the changed word picked out, the
added line on dark green likewise, the
`@@` header and git's question
`(1/1) Stage this hunk [y,n,q,a,d,e,?]?`
in git's own plain dress. Under the
paint, the raw bytes say it precisely
(lab notes): delta's background colours
52/124 and 22/28 are present, and the box
characters of the decorations are
*absent* — the filter kept its contract.

The answers were `y` to the README hunk
and `n` to the code hunk, and git's own
ledger afterwards — `git diff --cached --name-only`
— listed exactly one file: `README.md`.
The painted hunk was not a picture of the
decision; it *was* the decision, taken on
a hunk the reader could actually read.
That is the whole argument for this
chapter in one session: the moment git
asks *are you sure about this one?*, the
hunk deserves the best rendering it can
get — within the one rule that the
rendering must not touch the text.

## If the questions look wrong

Decorations in an `add -p` session —
headers, boxes, a hunk wearing a frame —
mean the filter seat is misconfigured:
either `interactive.diffFilter` is unset
(git then shows its own plain hunks,
which is safe but unpainted) or it names
delta *without* `--color-only`, which is
the one genuinely bad setup in this
guide, because git will try to hold its
conversation through text that has been
rearranged. Check the setting with
`git config interactive.diffFilter`; the
answer should be `delta --color-only`
exactly. Chapter 15 keeps this as its
own entry, because it is the mistake
with consequences.

Check: dirty one line in your fixture,
run `git add -p`, and answer `n`. The
hunk should arrive painted and
undecorated, and `git status` afterwards
should show the change still unstaged —
the filter coloured your decision without
touching it.
