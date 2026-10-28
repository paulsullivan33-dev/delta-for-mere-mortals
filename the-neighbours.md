# The Neighbours

Delta is not the only way to make a diff
readable, and several neighbours do part
of the job — or a different job wearing
similar clothes. An honest map. The
comparisons here are characterisations
from the projects' documentation, not
benchmarks; the lab ran delta only.

## diff-so-fancy

The closest relative: a Perl script that
has been prettifying git diffs for years,
configured as a pager much like delta.
It simplifies the `diff --git` headers,
strips the leading `+`/`-` in favour of
colour, and highlights changed areas.
Against delta it is lighter to install
(anywhere Perl already lives) and simpler
in what it attempts — no syntax themes,
no side-by-side, no line pairing as
refined as delta's emphasis. If delta's
feature shelf feels like a department
store where you wanted a kiosk,
diff-so-fancy is the kiosk, and a good
one.

## diff-highlight

Git's own contrib folder ships this small
Perl script, which does exactly one thing
from delta's list: it highlights the
changed *parts* within paired lines (and
can sit behind a plain pager). No headers,
no themes, no layout — but it is already
on your machine if git is, and for a
minimal setup its one trick is the one
that matters most. Delta grew from the
same insight; the difference is scope.

## colordiff

A wrapper that gives plain diff output
(the file-to-file kind, not only git's)
basic colours and can act as a pager.
It paints lines red and green and stops
there: no emphasis, no syntax, no headers
worth the name. For colouring the output
of a bare `diff` command in a script-heavy
workflow it is sometimes the pragmatic
pick; for reading git history it is a
generation behind.

## bat

Delta's own parts supplier (chapter 2):
`bat` is a `cat` with syntax highlighting,
paging and git integration of its own
(it marks modified lines in the margin
when it prints a file). If you want to
*read a file* beautifully, bat is the
tool and delta is not — delta paints
changes, not files. They compose rather
than compete; half of delta's good looks
are bat's wardrobe.

## The forges' diff views

GitHub, GitLab and their kin render diffs
in the browser with syntax colour,
side-by-side panels and — the part no
pager offers — *conversation*: comments
pinned to lines, approvals, memory. For
team review that is the right home, and
chapter 6's side-by-side will feel
familiar because it is the same idea.
The terminal tools win on the home
ground: local code, unpushed work,
history archaeology, and anywhere there
is no forge at all. Most programmers end
up using both, for the same reason they
own a desk and a workbench.

## Other git front-ends

Terminal interfaces like lazygit (this
series has a guide) and `tig` show diffs
inside their own panels, rendered by
their own code; editors and IDEs do the
same in richer dress. Delta configured as
git's pager does not reach inside those
programs — they are not git-the-command
printing to a terminal — and that is the
cleanest statement of delta's territory:
**where git itself prints a diff, delta
can paint it; where something else is
doing the showing, it cannot.**
