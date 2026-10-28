# Writing criteria for this guide

Every "for Mere Mortals" guide is written to the same nine-point
standard, so a reader who trusts one can trust the rest. Here it
is, with the verification notes for this particular guide below.

1. **Fix it first.** Reader outcomes lead, not action items: each
   chapter opens by naming the outcome it delivers, shows a check
   the reader can run to confirm they got it, and a reasonable
   reader finishes able to state what was done, what it means,
   and what to try next.
2. **Plain language.** Short sentences, everyday vocabulary,
   technical terms defined on first use. No slang, and no
   idioms that only make sense in one country — the reader may
   be translating as they go.
3. **No dead ends.** A guide never tells the reader to do
   something it cannot show them how to verify. Every claim a
   reader relies on — an install, a command, an output — is
   something this guide demonstrates or clearly labels
   documented-only below.
4. **Live-verified where it matters.** Procedures are run for
   real in the guide's lab wherever the build machine allows it,
   and the transcripts kept in the repository are the evidence.
   What could not be run is listed honestly below, never
   presented as if it had been.
5. **General audiences.** Nothing in this guide — examples,
   fixtures, names, addresses — is modelled on any particular
   reader or author's real life, network, or organisations.
   The lab's traffic is the lab talking to itself.
6. **Standalone.** A reader needs this guide, its lab, and
   nothing else. Where another guide would genuinely help, it
   is pointed to once, by name, and the chapter still completes
   without it.
7. **Honest about limits.** Chapter 14 names what the tool
   cannot do: repair a wrong comparison it merely renders,
   prove the line pairings its emphasis guesses at, reach a
   reader its red/green channel cannot, stand in for git's raw
   output as the evidence of record, or act as an interface for
   programs — and the failure shapes of each.
8. **The honesty rule is in the text, early.** Chapter 1 and
   the README state the rule plainly — *delta changes how a
   diff looks, never what the diff says* — before any procedure
   depends on it, and later chapters point back to it where the
   presentation could be mistaken for the content: copied
   decorations, confident-looking emphasis, a painted wrong
   diff.
9. **Builds clean.** The site builds with MkDocs in strict mode
   with no warnings, and a fresh reader following the chapters
   in order reaches the stated outcome of each.

## Verification notes for this guide

The build machine is a 2-CPU, 7.7 GB Ubuntu 24.04 sandbox.
Delta **0.20.1** was installed from the official release tarball
(dandavison/delta on GitHub) into a scratch directory — never
system-wide — and exercised against a throwaway fixture
repository built by the script shipped with this guide
(`delta-lab/make-fixture.sh`). Captures were made in a
pseudo-terminal at fixed widths (80, 100 and 160 columns) so
layout claims are real; colour claims rest on the raw escape
bytes of those captures, analysed in `examples/lab-notes.txt`,
because the plain-text transcripts in
`delta-lab/transcripts/` cannot carry colour.

Run for real, with transcripts as evidence:

- Install and version (t00); the same commit rendered plain by
  git and painted by delta as `core.pager` (t01, t02).
- The colour anatomy, measured in the raw bytes: removed lines
  on background 52 with emphasis 124, added lines on 22 with
  emphasis 28, syntax colours on added lines only — matching
  `delta --show-config`'s account of its own styles (t02, t15).
- `line-numbers` and `side-by-side` features, the latter at 160
  columns and again at 80, where long lines wrap with `↴`/`…`
  marks instead of any fallback to one column (t03–t05).
- A commit containing a mode change (`(mode +x)`), a rename, a
  deletion and an addition, each labelled in its header (t06);
  a binary file's header and empty body (t07).
- `git log -p` and `git blame` (via `pager.blame`) rendered by
  delta (t08, t09); `git show --stat` passing through
  undecorated (t20).
- `git add -p` with `interactive.diffFilter = delta
  --color-only`: the escape bytes prove colours and emphasis
  present and decorations absent, and `git diff --cached`
  proved the staging followed the answers given (t17).
- A staged merge conflict read plain (combined diff) and
  through delta (the labelled HEAD/theirs fence) (t12, t13).
- The front door: two loose files diffed (t10); a patch file
  rendered from standard input (t11); a lone filename shown
  *not* to be a patch input (it waits for a diff, and at a
  terminal prints delta's hint saying so).
- Themes: `--list-syntax-themes` (28) and `--list-languages`
  (198) listed; a Dracula render byte-compared against the
  default theme — the syntax colour of one token changed
  (203 → 212), every diff background unchanged (t14).
- `hyperlinks = true`: OSC 8 link sequences naming the files
  counted in the raw capture (8 in a two-file diff).
- Pipes, measured: git never invokes the pager when its output
  is piped; delta invoked manually as a filter decorates even
  into a pipe (falling back to width 80); `NO_COLOR=1` changed
  nothing in the escape census (130 with and without) and
  `TERM=dumb` barely more (125); `git --no-pager` restores the
  raw diff (t16).
- `git grep` into delta passes through plain, and renders in
  delta's grep format (purple file, green line number, lit
  match) once git's colours are forced with
  `color.ui=always` (t18, t19).
- Configuration as delta believes it: a custom feature set
  (`[delta "wide-review"]`) switching on line numbers and
  side-by-side in `--show-config`, and `--no-gitconfig`
  switching them back off (t15).
- Navigation inside the real pager: a terminal emulator
  (pyte) drove `less` through a four-file commit with
  `navigate = true`; screens captured before and after show
  the first `n` putting the first file's header at the top of
  the screen, a second `n` the next file's, and `N` returning
  (t21). Two earlier attempts that failed are also lab
  history — see the notes; they became chapter 15's second
  entry.

Documented only — described from the project's documentation,
not run, and the text does not claim otherwise:

- Install routes other than the release tarball (distro
  packages, Homebrew, cargo, Windows builds and package
  managers).
- The comparisons in chapter 13 (diff-so-fancy,
  diff-highlight, colordiff, bat, forge diff views, other git
  front-ends) are characterised, not benchmarked.
- Whether a given reader's terminal renders OSC 8 hyperlinks
  as clickable; delta's emission of the sequences is the
  verified half.
- Delta's use inside editors, IDEs and other git front-ends
  (which do not route through `core.pager`), and delta as a
  `difftool`.

Fixtures are this guide's own and deliberately generic: a tiny
garden-planning project with an invented maintainer, six
commits arranged to contain one of everything a diff reader
meets, and a branch quarrel rehearsed and aborted by the same
script. The lab's first binary specimen turned out to be text
in disguise (literal `\x00` sequences rather than NUL bytes);
the script was fixed to emit real NUL bytes and every capture
re-made, because a guide about honest rendering cannot keep a
dishonest fixture.
