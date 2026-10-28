# Conflicts and Odd Diffs

Most diffs are the tidy kind: two versions
of a file, one before, one after. This
chapter covers the untidy kinds — a merge
conflict with *three* versions in play, a
binary file with no lines to speak of,
and the summary that is not a diff at
all — and what delta does with each.

## The conflict, plain

The fixture's script rehearsed a quarrel
and aborted it; for this chapter the lab
staged it again and left it standing. Two
branches had set the garden's water
constant differently — 3 litres on
`main`, 2 on `winter` — and the merge
stopped, as merges do, to ask a human.
Plain `git diff` in the middle of that
merge speaks **combined diff**, the
three-way dialect (transcript t13):

```text
diff --cc garden.py
@@@ -6,7 -6,7 +6,11 @@@
++<<<<<<< HEAD
 +WATER_LITRES_PER_BED = 3
++=======
+ WATER_LITRES_PER_BED = 2
++>>>>>>> winter
```

Two columns of `+`/space where one used
to be, the conflict markers themselves
wearing `++`, and the whole thing
technically complete and practically
unreadable at the exact moment a person
most needs to read carefully.

## The conflict, through delta

The same `git diff` with delta as pager
(transcript t12) lays the disputed lines
out as what they are — two rival versions
of one spot, each labelled with the side
it came from:

```text
▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
HEAD│
WATER_LITRES_PER_BED = 3
winter│
WATER_LITRES_PER_BED = 2
▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲
```

(The borders run the width of the
terminal; they are trimmed here.) Above
and below the fence, the undisputed
context lines sit as normal context. The
`<<<<<<<` and `>>>>>>>` markers have been
understood and replaced by the frame:
a `HEAD` box holding your side, a
`winter` box holding theirs, and no third
voice pretending to be an answer.

Two honest limits ride along. First,
delta shows the conflict; it does not
resolve it. The file on disk still
contains the markers, `git status` still
says `both modified: garden.py`, and the
editing, choosing and `git add` are
yours — delta is the reading light over
the workbench, not a hand on it. Second,
this rendering is for the *unmerged*
state: once you have edited the file,
`git diff` shows your resolution against
the stages, a different and plainer
picture.

## The binary file

Chapter 5 met this one: a file git
classifies as binary has no lines, so
there is nothing to paint (transcript
t07). Delta's whole contribution is the
header — `gate.bin (binary file)` — and
silence where the body would be. It does
not hexdump, summarise or guess at the
content. If the *fact* of the change is
what you need, the header is the fact;
if you need the difference itself, you
need a tool that understands the format —
an image differ for images, and so on —
and chapter 13 says the same of the
neighbours.

## The summary that is not a diff

`git show --stat` and `git diff --stat`
ask git for a census instead of the
changes: names, counts, a bar per file.
Chapter 9 showed the output passing
through delta untouched (transcript
t20). Remember it here because it
surprises people in the other direction:
with delta configured everywhere, the
stat table still arrives in git's plain
dress, counts and bars uncoloured. That
is delta's restraint working as designed
— the table is not a diff, and mostly
you will be glad the numbers look the
same in every context, including the
ones (chapter 14) where no painter is
involved at all.

Check: rehearse the fixture's conflict
(`CONFLICT=1 sh delta-lab/make-fixture.sh garden-conflict`)
and read it both ways — `git --no-pager diff`,
then `git diff`. The question to answer
from the painted version alone: how many
lines are actually in dispute? (In the
lab's staging: one line, wearing two
values. The fence makes it look like
what it is.)
