# Themes and Colour

Delta paints with two separate palettes,
and most colour confusion comes from
mixing them up. The **diff colours** —
the red and green backgrounds, the bright
emphasis — say *what happened* to a line.
The **syntax theme** says *what the code
is*: keywords, strings, numbers. This
chapter is about the second palette: the
themes on offer, how delta chooses
between dark and light, and the lab's
proof that changing the theme leaves the
diff colours untouched.

## The theme shelf

```bash
delta --list-syntax-themes
```

listed 28 themes in the lab (transcript
t14), each tagged `dark` or `light` —
Monokai Extended (the default), Dracula,
the Catppuccin family, GitHub's themes,
and two dozen more. They are the themes
of the `bat` project (chapter 2), and the
companion list, `--list-languages`, names
the 198 languages and file types the same
engine can colour. If your language is on
that list, delta can paint it; if it is
not, the diff colours still work and the
code simply stays plain — a graceful
failure worth knowing about before you
meet it.

## Choosing one

```bash
git -c delta.syntax-theme=Dracula show f15ec93
```

or permanently:

```ini
[delta]
    syntax-theme = Dracula
```

The lab's check that this is a *separate
layer*: the same added line of Python,
rendered under the default theme and
under Dracula, byte-compared (the raw
escapes are in the lab notes). The `=`
sign changed colour — palette 203 under
Monokai Extended, 212 under Dracula —
while every background around it stayed
exactly where chapter 5 measured it: 52,
124, 22, 28. Change the theme and you
re-dress the code; the story the diff
colours tell does not move. That is also
why theme advice from other people is
harmless to take: it is taste, all the
way down, and the information survives
any of it.

## Dark terminals, light terminals

Themes come in dark and light families
because code coloured for one is washed
out on the other. Delta's default
behaviour is to *ask*: unless told
otherwise, it queries the terminal for
its background colour — the lab's
captures show the question going out as
terminal control sequences before the
first line was painted — and picks a
matching family. Two flags override the
asking:

```bash
delta --dark    # colours for a dark background
delta --light   # colours for a light background
```

(or `dark = true` / `light = true` in
the `[delta]` section). In the lab,
forcing `--dark` on a terminal delta had
judged for itself changed the output
bytes — proof the two families are real
alternatives, not a label. Set one
explicitly if delta guesses your terminal
wrong, which happens mostly in exotic
setups: multiplexers, remote sessions,
terminals that decline to answer.

## A word about colour depth

The lab's numbers (52, 124, 22, 28) are
*256-colour palette* entries, and they
are what delta emits by default in a
terminal like the lab's. In a terminal
advertising true colour, `--show-config`
reports styles as RGB values instead.
Same meaning, finer grain — and one more
reason a screenshot of a diff is evidence
about the *layout*, while the colours
themselves depend on where they were
rendered. Chapter 14 picks that thread
up.

Check: list the themes, pick the one
whose name you like best, and run the
fixture's second commit under it and
under the default. The diff you can
*read* should be identical; the one you
enjoy looking at is the right theme, and
enjoyment, over thousands of diffs, is a
feature.
