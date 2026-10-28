# Troubleshooting

Symptom first, cause second, in the order
the lab met them or the chapters imply
you should check.

## Nothing changed: git output looks exactly as before

*You configured delta, and `git diff` is
still plain.*

1. **There is no terminal.** Git calls a
   pager only when its output is one.
   Piped, redirected or running inside a
   script, git prints raw diff and delta
   is never consulted — by design
   (chapters 2 and 14). Test at a real
   prompt, unpiped.
2. **`core.pager` is not set, or set
   somewhere git isn't reading.** Check
   with `git config core.pager`; the
   answer should be `delta`. Remember
   that a repo's local config outranks
   your global one.
3. **Delta is not on the `PATH` git
   sees.** `git` reports a failed pager
   and falls back; run plain `delta
   --version` in the same shell.

## Delta runs, but an option is ignored

*You set `line-numbers` (or a theme, or
a feature) and the output does not care.*

1. **Ask the referee.** `delta
   --show-config` prints what delta
   believes, defaults and all. If the
   option is wrong *there*, delta never
   received your setting, whatever the
   file says.
2. **The lab's own case:** settings
   exported through the `GIT_CONFIG_GLOBAL`
   environment variable were honoured by
   git but never seen by delta, which
   reads the standard config files. The
   same lines in `~/.gitconfig` under a
   `[delta]` section worked immediately.
   Put delta's options in the file.
3. **A more local road is overriding
   you** — a `-c delta.…` on the command,
   a repo-local `[delta]` section, or a
   feature bundle that does not include
   the option you set (chapter 7).

## Interactive staging shows boxes and headers

*`git add -p` arrives wearing file
headers and hunk boxes — or, worse, git
behaves as if the hunks are malformed.*

The filter seat's contract is broken
(chapter 10). `git config interactive.diffFilter`
must read exactly `delta --color-only`.
Bare `delta` there is the one setup in
this guide that can do harm: delta
rearranges text that git is trying to
hold a conversation through. Fix the
setting before staging anything else.

## Pressing n in the pager says "No previous regular expression"

Navigation is not actually on, whatever
your file claims — that message is less
reporting that no search pattern was ever
loaded for it to repeat. Work the option
chain as in the second entry above:
`navigate = true` belongs in the `[delta]`
section of the config file delta reads,
and `delta --show-config` will confirm
whether it arrived. (The lab met this
message twice before tracing it to a
config file delta could not see.)

## delta some.patch just sits there

A lone filename is not an input mode
(chapters 2 and 12). Delta read it as
"prepare to receive a diff on standard
input" — or, at a terminal, it printed a
short hint saying exactly that. Feed the
patch properly: `delta < some.patch`.
Ctrl-C harms nothing; nothing was being
written.

## Grep output comes through plain

`git grep -n … | delta` passes the lines
through unstyled because delta could not
recognise the format. Force git's colours
on so the format is marked (chapter 9):
`git -c color.ui=always grep -n … | delta`.

## Side-by-side is an unreadable ribbon

The terminal is too narrow for two
panels. Delta wraps instead of falling
back — look for the `↴` and `…` wrap
marks (chapter 6). Below roughly 140
columns, drop the feature for that
command (`git -c delta.features=line-numbers …`)
or resize the terminal. This is the
feature working as designed, in a room
too small for it.

## A saved file is full of escape codes and box lines

Somebody piped *through delta* into the
file (`git show | delta > out.txt`), so
the painted rendering — colours,
decorations, an 80-column layout — is
what got saved. For anything that must
live in a file, let git write it
directly: `git show > out.patch`. Git
never calls the pager when its output is
a file, which is precisely the protection
the manual pipe walks around.

## The colours look wrong on this terminal

Washed out usually means a dark theme on
a light background or the reverse.
Delta asks the terminal its background
and guesses; override the guess with
`--light` or `--dark`, or name a
`syntax-theme` from the matching family
in `delta --list-syntax-themes`
(chapter 8). Garish or missing colours
on a remote session usually mean the
terminal at *your* end is describing
itself modestly; the diff colours are
palette colours by default, and a
terminal claiming few colours gets few.
