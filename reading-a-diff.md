# Reading a Diff

Everything delta shows is one of four
things: a file header, a hunk box, a
painted line, or git's own text passing
through. This chapter names each part and
what it is telling you, using the
fixture's second commit (transcript t02)
and the lab's colour measurements, which
are recorded in `examples/lab-notes.txt`
because a transcript cannot carry colour.

## The file header

```text
garden.py
────────────────────────────────────────
```

The name, over a rule the width of the
terminal. When the file's story is more
than "edited", the header says so —
chapter 4's tidy-up commit (transcript
t06) produced four headers in a row:

```text
garden.py (mode +x)
renamed: watering.sh ⟶   irrigation.sh
removed: notes.txt
added: seeds.csv
```

A mode change, a rename, a deletion and
an addition, each announced in the
header instead of encoded in the raw
diff's fine print. A binary file gets the
same honesty (transcript t07): the header
reads `gate.bin (binary file)` and there
is no body, because there are no lines to
paint. Delta will not pretend otherwise.

## The hunk box

```text
────────────┐
6: BEDS = { │
────────────┘
```

Each hunk — one cluster of changes, with
its context lines — opens with this box.
The text inside is git's own: the number
is the line in the *new* file where the
context after the `@@` begins, and the
words are the line git chose as the
hunk's landmark (usually the function or
heading the change sits inside). Delta
has simply framed it. When a hunk has no
landmark — a plain text file's middle —
the box carries the line number alone,
as in the tidy-up commit's `1: │`.

## The painted lines

Three coats of paint, in the order the
eye meets them:

1. **The diff colours.** Every removed
   line is laid on a dark red background;
   every added line on dark green. In the
   lab's default 256-colour terminal
   those were palette colours 52 and 22 —
   measured, not guessed: the transcripts'
   raw bytes are in the lab notes. Context
   lines get no background at all, which
   is why changes stand out as islands.
2. **The syntax colours.** Code is also
   coloured the way an editor colours it —
   keywords, strings, numbers each in
   their theme colour. Here is the detail
   worth knowing: by default this applies
   to the *added* lines. Removed lines are
   painted `normal` — plain text on the
   red. Delta's reasoning you can check in
   `delta --show-config`: `plus-style`
   says `syntax`, `minus-style` says
   `normal`. What a thing *was* gets the
   alarm colour; what it *became* gets the
   full reading light.
3. **The emphasis.** Within a removed/
   added pair, the parts that differ get a
   brighter shade of the line's own colour
   — a brighter red (124) inside the dark
   red, a brighter green (28) inside the
   dark green. In the fixture, the number
   `6` glows on the removed line and `4`
   on the added one; in the README, the
   single inserted word `early ` is the
   only bright patch on its line. This is
   the feature the whole tool exists for:
   the change *inside* the line, found
   for you.

## How delta pairs lines for emphasis

Emphasis needs pairs: which removed line
goes with which added line? Delta pairs
them by resemblance — lines that look
like near-copies of each other are
matched, and their differing tokens are
the bright parts. The knobs are visible
in `--show-config`: `max-line-distance`
(default 0.6) is how different two lines
may be and still count as a pair, and
`word-diff-regex` (default `\w+`) is what
counts as a word when the pair is
compared. Two honest consequences, which
chapter 14 returns to: a line rewritten
beyond recognition gets no partner and no
emphasis — plain red, plain green — and
in a dense block of similar lines the
pairing is a good guess, not a proof.
Emphasis is a reading aid. The lines
themselves are the evidence.

## The signs you lost, and getting them back

By default there are no `-` and `+`
characters: colour carries the meaning.
If you read diffs in black and white, or
print them, or your eyes simply want the
signs, one option restores them
(transcript t22):

```bash
git -c delta.keep-plus-minus-markers=true show f15ec93
```

```text
-Water in the morning, before the sun is high.
+Water in the early morning, before the sun is high.
```

Set `keep-plus-minus-markers = true` in
the `[delta]` section to keep them
permanently. Nothing else about the
rendering changes.

Check: in your fixture, run the second
commit and find, without re-reading the
raw diff, (a) which file the mode change
belongs to in the tidy-up commit,
(b) the exact word inserted into the
README sentence, and (c) the context line
of the garden.py hunk. If the paint is
doing its job, all three answers arrive
before you finish scanning — that speed,
on evidence you could already read, is
the entire offer.
