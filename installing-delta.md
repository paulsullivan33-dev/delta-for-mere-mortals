# Installing Delta

Delta is a single self-contained program,
written in Rust and published as one
binary named `delta`. It needs nothing
else on the machine except git itself
(and, for the paging it does by default,
`less`, which most systems already have).
This guide's lab used the project's
release tarball; the package routes below
are the documented alternatives and end
at the same binary.

## The release tarball (the lab's route)

On the project's GitHub releases page,
each release carries archives per
platform. On a Linux x86-64 machine:

```bash
curl -LO https://github.com/dandavison/delta/releases/download/0.20.1/delta-0.20.1-x86_64-unknown-linux-gnu.tar.gz
tar xzf delta-0.20.1-x86_64-unknown-linux-gnu.tar.gz
```

Inside is a folder holding one file that
matters: `delta`. Put it somewhere on
your `PATH` — `~/bin` or `~/.local/bin`
if those are on it, or `/usr/local/bin`
with sudo — and make sure it is
executable. The same page offers `.deb`
and `.rpm` packages for Debian- and
Fedora-family systems, which install it
as a normal package (the Debian package
is named `git-delta`).

Check: the lab's version printout
(transcript `delta-lab/transcripts/t00-version.txt`)
is one line:

```text
$ delta --version
delta 0.20.1
```

Pin your reading to the version you
installed: delta is actively developed
and option names occasionally move
between releases. Every transcript in
this guide is from 0.20.1.

## The package routes

Described from the project's
documentation, not run in the lab:

- **Distro packages.** Debian and Ubuntu
  carry it as `git-delta`; Fedora and
  Arch have their own packages. These lag
  the releases, sometimes by a lot — the
  version check above tells you what you
  actually got.
- **Homebrew** (macOS, and Linux where
  brew lives): `brew install git-delta`.
- **Cargo**, if you already live in Rust:
  `cargo install git-delta` compiles it
  from source — the slow route, and the
  one that works anywhere Rust does.
- **Windows** builds are on the same
  releases page, and the package managers
  there (winget, Scoop, Chocolatey) carry
  it too.

## Prove it can paint

Installing the binary is half the job;
the other half is that git must hand it
diffs. That wiring is chapter 4, but a
thirty-second smoke test needs no wiring
at all — delta's front door (chapter 2)
takes two files:

```bash
printf 'one\ntwo\n' > a.txt
printf 'one\nTWO\n' > b.txt
delta a.txt b.txt
```

You should see a small painted diff: a
header naming both files, `two` on red,
`TWO` on green, the changed word itself
in the brighter emphasis colour. If
instead the output is plain, or delta
complains about the terminal, chapter 15
has the short list of causes — the usual
one is that the output was not a real
terminal when you looked.
