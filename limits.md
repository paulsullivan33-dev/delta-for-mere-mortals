# Limits

What delta cannot do, and what it must
not be asked to do. The through-line is
chapter 1's rule: delta changes how a
diff looks, never what the diff says —
and every limit below is that rule viewed
from a different side.

## A painted wrong diff is still wrong

Delta renders the diff *git computed*.
If the comparison itself is the problem —
the wrong two commits, a rename git was
not told to detect, a merge base that
surprises you — the painted output is the
same wrong answer with better posture.
Delta has no settings for any of that,
deliberately. The computing choices live
in git (the Git guide in this series
covers them); delta is downstream of all
of them, and no theme fixes an upstream
mistake.

## Emphasis is a heuristic, not a proof

The feature this guide praised most —
the bright words inside a line — rests on
pairing removed and added lines by
resemblance (chapter 5: `max-line-distance`,
default 0.6). Heuristics have failure
shapes, and a reviewer should know them:

- A line rewritten past recognition gets
  no partner: plain red, plain green, no
  emphasis. Absence of emphasis means
  "unpaired", not "unchanged in spirit".
- In a block of many similar lines —
  generated code, tables of data, repeated
  stanzas — the pairing is a best guess.
  Two lines can be paired because they
  *look* alike, and the bright parts then
  tell a tidy story that is not quite the
  true one.
- Nothing in the rendering marks which
  pairs are certain. The emphasis is a
  reading aid with a quiet confidence
  problem; on a change that matters,
  read the raw lines too.

## Colour is a channel, and channels fail

The default signal is red versus green,
which is the single worst pair for the
most common colour-vision deficiency —
roughly one man in twelve reads those
hues unreliably. Delta's mitigations are
real but must be switched on: line
numbers (chapter 6) give position without
colour, `keep-plus-minus-markers`
(chapter 5) restores the signs, and the
individual `*-style` options can rebuild
the whole scheme on other colours.
Beyond eyes: print a diff and the colour
is gone; paste it into a document and
the *decorations* come along as text
while the colour does not, leaving
furniture without meaning. The terminal
is delta's native country. Exports
belong to git's plain output.

## The layout is not the document

The same diff is a document that changes
shape with the terminal: rules run to
the measured width, side-by-side wraps at
80 columns and relaxes at 160 (chapter
6), and a piped delta falls back to 80.
Nothing about the *content* changes, but
two readers quoting "the top line of the
diff" may be looking at different tops.
Serious reference is by file and line
number — one more reason chapter 6's
gutter earns its keep.

## Delta is not an interface for programs

Git already enforces the sharp half of
this: piped or redirected, it never calls
the pager, so patch files, CI logs and
scripts see the raw format they expect.
The soft half is yours to keep: if you
ever find delta's output *inside* a file
— escape codes, box characters — it got
there because somebody piped through
delta by hand (chapter 15). The painted
form is a terminal rendering, unstable
by design (widths, themes, versions all
move it), and anything automated should
eat `git`'s output, never delta's.

Two smaller honesties in the same
direction. **NO_COLOR will not save you:**
the convention many tools honour has no
effect on delta in the lab's test — the
escape count was identical with it set —
and `TERM=dumb` barely changed the count
either. The plain routes are git's:
`--no-pager`, a pipe, `GIT_PAGER=cat`.
And **delta detects its input by shape**:
diffs it recognises by their headers,
blame by its form, grep only when git's
colours mark it (chapter 9). A format it
does not recognise passes through or is
misread; a pager that sometimes guesses
is a tool to verify, which is what
`--show-config` and the raw view are for.

## It shows; it does not touch

Delta does not edit files, resolve
conflicts (chapter 11's fence is a
reading aid, not a resolution), stage,
commit, or remember. It keeps no history
of what you reviewed and offers no
comments, approvals or audit trail. A
team's *process* of review lives in
forges and habits; delta's whole office
is the thirty seconds in which a human
looks at a change and decides whether
they understand it. Within that office it
is excellent. This guide has tried to be
exact about the walls, because a tool
trusted past its walls becomes a way of
not seeing — and not seeing is the one
failure a diff reader cannot afford.
