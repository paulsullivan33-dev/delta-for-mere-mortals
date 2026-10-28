# Line Numbers and Side by Side

Two features change the *geometry* of a
diff rather than its paint: line numbers
in the gutter, and the side-by-side view
that puts the old file and the new file
in two panels. Both are off by default;
both are switched on the same way — as
**features**, delta's name for a bundle
of settings you enable in one word.

## Line numbers

```bash
git -c delta.features=line-numbers show f15ec93
```

(transcript t03). Every line now carries
two numbers and a thin separator:

```text
 11 ⋮    │Water in the morning, before the sun is high.
    ⋮ 11 │Water in the early morning, before the sun is high.
```

The left number is the line's place in
the old file, the right its place in the
new file. A removed line has no new
number; an added line has no old one;
context lines have both. The `⋮` keeps
the two columns from blurring together.
This is the same information the raw
`@@ -6,12 +6,12 @@` header makes you
compute in your head — starting line of
each file, then counting — done for you,
per line, where your eye already is. It
is also the feature that gives a diff a
*voice* in conversation: "line 11 of the
new file" is something you can say to a
teammate, or type into an editor.

## Side by side

```bash
git -c delta.features=side-by-side show f15ec93
```

At a wide terminal — the lab used 160
columns (transcript t04) — the diff
becomes two panels:

```text
│ 11 │Water in the morning, before the sun is high.   │ 11 │Water in the early morning, before the sun is high.
```

The old file on the left, the new file on
the right, each with its own line-number
gutter (side-by-side brings line numbers
with it). Lines that pair up sit opposite
each other, so your eye travels *across*
a change instead of down past it; a line
with no partner leaves an empty cell
opposite. For prose and for wide code
this is the most readable form delta
has. It is also, not coincidentally, the
form web forges use — chapter 13 puts the
two side by side, so to speak.

## The narrow terminal, honestly

The lab then ran the identical command in
an 80-column terminal (transcript t05),
and this is the part of the feature to
understand before you adopt it. Delta
does *not* give up and fall back to the
one-column view. It keeps its two panels
and **wraps** the lines that no longer
fit, marking the break:

```text
│ 11 │Water in the morning, before the ↴│ 11 │Water in the early morning, befor↵
│    │                     …sun is high.│    │e the sun is high.
```

A `↴` where the line broke, a `…` where
its continuation begins. Nothing is lost
and nothing is hidden — but at 80 columns
nearly every line of real code wraps, the
panels become ribbons, and the
one-column view with line numbers is
simply easier to read. Delta knows its
width from the terminal; it will not
choose for you. The working rule the lab
came away with: side-by-side is a
wide-terminal feature. Give it 140
columns or more, or leave it off and take
line numbers instead — and because both
are features, you can decide per command
(the `-c` form above) rather than marrying
one geometry in your config file.

## Making either one permanent

Anything after `features =` in the
`[delta]` section is on for every diff:

```ini
[delta]
    features = line-numbers
```

Features stack: `features = line-numbers side-by-side`
asks for both (and side-by-side brings
its own numbers regardless). Chapter 7
shows how to build your *own* named
feature out of any options at all, which
is the tidy way to keep a wide-terminal
setup one word long.

Check: run the fixture's second commit
three ways — default, `line-numbers`,
`side-by-side` — at the width of the
terminal you actually work in, and keep
the one your eye prefers. The lab's
preference is recorded in the notes, but
diffs are read by the person in the
chair, and the only wrong answer is a
geometry you have to fight.
