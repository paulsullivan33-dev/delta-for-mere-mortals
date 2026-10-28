# Configuration

Delta's options all live in one place —
the `[delta]` section of your git
configuration — and can all be overridden
for a single command. This chapter covers
the three ways an option reaches delta,
how to bundle options into feature sets
of your own, and the one command that
outranks the file: `delta --show-config`.

## The three roads in

1. **The config file.** Permanent, per
   machine (or per repository, if you put
   the section in a repo's `.git/config`):

   ```ini
   [delta]
       navigate = true
       line-numbers = true
   ```

2. **Through git, for one command.**
   Git's `-c` hands a setting to every
   program git runs, delta included:

   ```bash
   git -c delta.features=side-by-side show f15ec93
   ```

   Every one-command example in chapters
   5 and 6 travelled this road.

3. **Delta's own flags**, for the times
   you run delta directly — the filter
   seat's `delta --color-only` is the
   everyday case, and `delta --side-by-side`
   works too when delta reads a diff from
   a pipe or two files.

Where they disagree, the more local road
wins: flags over `-c`, `-c` over the file.

## Features: bundles with names

Chapter 6 introduced `line-numbers` and
`side-by-side` as *features* — names that
stand for a bundle of underlying options.
Delta ships a few built in (`decorations`
is the one quietly responsible for the
file headers and hunk boxes; it is on by
default). The useful trick is that you
can mint your own. The lab defined one
for wide-terminal review:

```ini
[delta]
    features = wide-review
[delta "wide-review"]
    line-numbers = true
    side-by-side = true
```

From then on, `features = wide-review`
switches on both settings at once — and
`git -c delta.features=wide-review …`
summons the same bundle for one command.
Verified the referee's way (below): with
that file in place, `--show-config`
reported `line-numbers = true` and
`side-by-side = true`.

## The referee: --show-config

```bash
delta --show-config
```

prints every effective option with its
value — defaults included, styles spelled
out as the actual colours (transcript
t15). Three uses recur throughout this
guide:

- **Settling arguments.** You set an
  option and nothing changed. The file
  says one thing; `--show-config` says
  what delta *believes*. Trust the second.
  Chapter 15 tells the lab's own story:
  settings the lab had exported through
  the `GIT_CONFIG_GLOBAL` environment
  variable were honoured by git but never
  seen by delta, which reads the standard
  config files — the same lines in
  `~/.gitconfig` worked at once.
- **Learning the defaults.** The styles
  quoted in chapter 5 (52/124, 22/28,
  `syntax` for plus lines, `normal` for
  minus) were read off this output, not
  out of the documentation.
- **The vanilla check.** `--no-gitconfig`
  makes delta ignore the config file
  entirely:

  ```bash
  delta --no-gitconfig --show-config
  ```

  In the lab, the wide-review settings
  above vanished from the listing —
  `line-numbers` and `side-by-side` back
  to `false`. Chapter 12 uses this as a
  recipe: the second opinion, with
  nobody's preferences in it.

## What else lives in there

`--show-config` on a fresh install runs
to a few dozen options. Most readers will
touch a handful beyond this chapter's:
`syntax-theme` and the individual
`*-style` options (chapter 8),
`keep-plus-minus-markers` (chapter 5),
`hyperlinks` (chapter 12), `width` (delta
measures the terminal; the option pins a
number when you need one), `pager` and
`paging` (who pages the output, and
whether). The rest — the knobs for
pairing lines, blame palettes, per-part
formats — are catalogued in delta's own
manual, and the honest advice is to leave
them at their defaults until a specific
irritation names the knob it wants.
Configuration is a means to reading
diffs, and it can quietly become a hobby
that replaces it.

Check: run `delta --show-config` now and
find three things — the `features` line,
`navigate`, and `minus-emph-style`. If
the first two match what your config file
claims and the third says `124`, your
setup is the one this guide has been
describing, and you can prove it in one
command the next time they disagree.
